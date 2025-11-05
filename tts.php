<?php

header('Content-Type: application/json; charset=utf-8');

$tts_url  = "http://192.168.2.192:8002/api/tts";
$save_dir = "/home/tgui/files/pbx/tts";
$api_url   = "https://randomuser.me/api/?nat=ir";

$json = file_get_contents($api_url);
if ($json === false) {
    die("خطا در دریافت اطلاعات از randomuser.me\n");
}
$data = json_decode($json, true);
if (!isset($data['results'][0]['location'])) {
    die("ساختار JSON نامعتبر است\n");
}
$loc = $data['results'][0]['location'];

// ۲. تبدیل به رشته فارسیِ آدرس
$city    = $loc['city']        ?? '';
$state   = $loc['state']       ?? '';
$street  = $loc['street']['name'] ?? '';
$number  = $loc['street']['number'] ?? '';
$postcode= $loc['postcode']    ?? '';

$text = sprintf("%s، استان %s، %s، پلاک %s، کدپستی %s",
                   $city, $state, $street, $number, $postcode);


//$text = $_POST["text"] ?? $_GET["text"] ?? "";
if (trim($text) === "") {
    http_response_code(400);
    echo json_encode(["error" => "متن ورودی خالی است"]);
    exit;
}

/* --- تعیین نام فایل‌ها --- */
$raw_filename   = "tts_raw_"  . date("Ymd_His") . ".wav";
$final_filename = "tts_"      . date("Ymd_His") . ".wav";
$raw_path   = rtrim($save_dir, "/") . "/" . $raw_filename;
$final_path = rtrim($save_dir, "/") . "/" . $final_filename;

/* --- ارسال متن خام به Mimic3 --- */
$ch = curl_init($tts_url);
curl_setopt_array($ch, [
    CURLOPT_POST           => true,
    CURLOPT_POSTFIELDS     => $text,          // ✅ فقط بدنهٔ ساده: متن مستقیم
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_CONNECTTIMEOUT => 10,
    CURLOPT_TIMEOUT        => 60,
    CURLOPT_HTTPHEADER     => ["Content-Type: text/plain"] // نوع داده صحیح
]);
$response  = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

/* --- بررسی و تبدیل فرمت صوتی --- */
if ($http_code === 200 && $response) {
    if (!file_exists($save_dir)) {
        mkdir($save_dir, 0755, true);
    }

    file_put_contents($raw_path, $response);

    // 🔄 تبدیل به فرمت Asterisk-compatible
    $cmd = "sox " . escapeshellarg($raw_path) . " -r 8000 -c 1 -b 16 " . escapeshellarg($final_path);
    shell_exec($cmd);
    @unlink($raw_path);

    @chown($final_path, "asterisk");
    @chgrp($final_path, "asterisk");
    @chmod($final_path, 0644);

    echo json_encode([
        "status"   => "ok",
        "text" => $text,
        "path"     => substr($final_path,0,-4)
    ], JSON_UNESCAPED_UNICODE);
} else {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "http"   => $http_code,
        "msg"    => "خطا در دریافت داده از Mimic3"
    ], JSON_UNESCAPED_UNICODE);
}
?>
