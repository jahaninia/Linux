#!/bin/bash

source .env

LOG_FILE="/var/log/sip_check.log"
MAX_RETRIES=10
RETRY_DELAY="60s"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

send_telegram() {
    local msg="$1"
    curl -s -X POST "https://workertelegram.mjahaninia.workers.dev/bot${BOT_TOKEN}/sendMessage" \
         -d chat_id="$CHAT_ID" \
         --data-urlencode "text=$msg"
}

if /usr/sbin/pidof -o %PPID -x -- "$0" >/dev/null; then
  log "ERROR: Script $0 already running"
  exit 1
fi

sleepCheck () {
   offline=$( /sbin/asterisk -rx 'sip show peers' | grep -o '[0-9]\+ offline Unmonitored' | awk '{print $1}')
   log "Offline count: $offline"
   
   if [[ "$offline" -gt 0 ]]; then
      send_telegram "🔴 Sanj - Offline Peers: $offline"
      sleep "$1"
      return 1
   else
      return 0
   fi
}

log "=== Start SIP recovery process ==="

offline_count=$( /sbin/asterisk -rx 'sip show peers' | grep -o '[0-9]\+ offline Unmonitored' | awk '{print $1}')
if [[ "$offline_count" -gt 0 ]]; then
   log "Peers offline detected. Starting recovery..."

   sed -i '54,$d' /etc/asterisk/tgui/sip.conf 
   sed -i '2,$d'  /etc/asterisk/tgui/register.conf
   /sbin/asterisk -rx "sip reload"

   retry=0
   while ! sleepCheck "$RETRY_DELAY"; do
      ((retry++))
      log "Retry #$retry - Peers still offline..."
      if [[ "$retry" -ge "$MAX_RETRIES" ]]; then
         log "Max retries reached. Exiting..."
         send_telegram "⚠️ Sanj - Max retries reached. Some peers still offline."
         exit 1
      fi
   done

   log "Peers online. Rebuilding SIP configs..."

   perl -I /opt/telc/mapper/ /opt/telc/mapper/sipRegister.pl > /etc/asterisk/tgui/register.conf 
   perl -I /opt/telc/mapper/ /opt/telc/mapper/sipconf.pl > /etc/asterisk/tgui/sip.conf 
   chown asterisk.asterisk /etc/asterisk/tgui/*.conf 
   /sbin/asterisk -rx "sip reload"

   log "Final 5-minute check..."
   sleepCheck 300s

   final_offline=$( /sbin/asterisk -rx 'sip show peers' | grep -o '[0-9]\+ offline Unmonitored' | awk '{print $1}' )
   send_telegram "✅ Sanj - Recovery Completed. Offline Peers: $final_offline"
else
   log "All peers are already online."
fi

log "=== End of script ==="
