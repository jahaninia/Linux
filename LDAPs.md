
# chack connect rocky linux to ldap
### if strings with strart '<' and end '>' is replace with data valid 

## Install openldap clinet
```bash
 dnf install  openldap-clients -y
```
## if  CA server is local shude find file cer and install in linux under command for CA local if valid CA jump to ldap test

```powershell
certutil -ca.cert <name of outpute>.cer
```
or  find in directory 
```text
C:\Windows\System32\certsrv\certenroll\
```
Send file to server linux by scp or all way 

```bash
cp /etc/openldap/certs/<name of outpute>.cer /etc/pki/ca-trust/source/anchors/
update-ca-trust extract
```
## ldap test
### if strings with strart '<' and end '>' is replace with data valid 

ldapsearch -H ldaps://<IP DC>:636   -D "<Username>"   -w '<Pass>'   -b "<base oy>"   -x -LLL "(objectClass=*)" 


```bash
ldapsearch -H ldaps://<IP or dns record Domain controller>   -D "<user with `@doman`>"   -w "<password>"   -b "DC=<domain>,DC=<local>"
```

@@if is ladp in java 

## find path install java
```bash
readlink -f $(which java)
```
## find kettool for add cert
```bash
locate keytool
```
after find cd path  output command readlink "jre/lib/security/cacerts"
```bash
 keytool -importcert   -trustcacerts   -alias <>   -file <Path file cer send>   -keystore /usr/java/jdk1.8.0_401/jre/lib/security/cacerts   -storepass changeit
```



 ./keytool -importcert   -trustcacerts   -alias ariansystemdp.local   -file /root/CA-SRV.ArianSystemdp.local_ArianCA.crt   -keystore /usr/java/jdk1.8.0_401/jre/lib/security/cacerts   -storepass changeit
