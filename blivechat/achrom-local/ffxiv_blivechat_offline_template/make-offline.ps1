Param(
  [string]$Template = ".\ffxiv_blivechat_offline_template.css",
  [string]$OutFile = ".\ffxiv_blivechat_offline.css",
  [string]$FontPath = "",
  [string]$ProxyUri = "http://127.0.0.1:7890",
  [switch]$DisableProxy
)

# TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 设置默认代理（可关闭）
if (-not $DisableProxy -and $ProxyUri) {
  try {
    $proxy = New-Object System.Net.WebProxy($ProxyUri, $true) # $true: 本地直连
    [System.Net.WebRequest]::DefaultWebProxy = $proxy
    [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
    Write-Host "Proxy enabled: $ProxyUri" -ForegroundColor Cyan
  } catch {
    Write-Host "Failed to set proxy: $ProxyUri" -ForegroundColor Yellow
  }
} else {
  Write-Host "Proxy disabled." -ForegroundColor Yellow
}

# 需要转为 data URI 的图片（主源 + 备用源）
$files = @(
  @{ Key = "BASE64_CMT";    Urls = @(
      "https://cdn.jsdelivr.net/gh/hekatech/achrom-css@main/ffxiv/cmt.png",
      "https://raw.githubusercontent.com/hekatech/achrom-css/refs/heads/main/ffxiv/cmt.png"
  )},
  @{ Key = "BASE64_CLICK";  Urls = @(
      "https://cdn.jsdelivr.net/gh/hekatech/achrom-css@main/ffxiv/click.png",
      "https://raw.githubusercontent.com/hekatech/achrom-css/refs/heads/main/ffxiv/click.png"
  )},
  @{ Key = "BASE64_USER";   Urls = @(
      "https://cdn.jsdelivr.net/gh/hekatech/achrom-css@main/ffxiv/user.png",
      "https://raw.githubusercontent.com/hekatech/achrom-css/refs/heads/main/ffxiv/user.png"
  )},
  @{ Key = "BASE64_MEMBER"; Urls = @(
      "https://cdn.jsdelivr.net/gh/hekatech/achrom-css@main/ffxiv/member.png",
      "https://raw.githubusercontent.com/hekatech/achrom-css/refs/heads/main/ffxiv/member.png"
  )},
  @{ Key = "BASE64_GIFT";   Urls = @(
      "https://cdn.jsdelivr.net/gh/hekatech/achrom-css@main/ffxiv/gift.png",
      "https://raw.githubusercontent.com/hekatech/achrom-css/refs/heads/main/ffxiv/gift.png"
  )}
)

function Get-DataUriFromUrl([string]$url, [string]$proxyUri, [switch]$noProxy) {
  $tmp = [System.IO.Path]::GetTempFileName()
  try {
    $invokeParams = @{
      Uri = $url
      OutFile = $tmp
      ErrorAction = 'Stop'
      UseBasicParsing = $true
      UserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) PowerShell'
    }
    if (-not $noProxy -and $proxyUri) { $invokeParams['Proxy'] = $proxyUri }

    Invoke-WebRequest @invokeParams | Out-Null

    $bytes = [System.IO.File]::ReadAllBytes($tmp)
    $b64 = [System.Convert]::ToBase64String($bytes)
    $ext = ([System.IO.Path]::GetExtension($url)).TrimStart('.').ToLower()
    $mime = switch ($ext) {
      "png"  { "image/png" }
      "jpg"  { "image/jpeg" }
      "jpeg" { "image/jpeg" }
      "svg"  { "image/svg+xml" }
      default { "application/octet-stream" }
    }
    return "data:$mime;base64,$b64"
  } finally {
    if (Test-Path $tmp) { Remove-Item $tmp -Force -ErrorAction SilentlyContinue }
  }
}

function Fetch-FirstDataUri([string[]]$urls, [string]$proxyUri, [switch]$noProxy) {
  foreach ($u in $urls) {
    try {
      return Get-DataUriFromUrl -url $u -proxyUri $proxyUri -noProxy:$noProxy
    } catch {
      Write-Host "Failed: $u, try next..." -ForegroundColor Yellow
    }
  }
  throw "All sources failed."
}

if (-not (Test-Path $Template)) { throw "Template file not found: $Template" }
$content = Get-Content -Raw -Path $Template

foreach ($f in $files) {
  $dataUri = Fetch-FirstDataUri -urls $f.Urls -proxyUri $ProxyUri -noProxy:$DisableProxy
  $token = "{{$($f.Key)}}"
  $content = $content.Replace($token, $dataUri)
  Write-Host ("Embedded {0}" -f $f.Key) -ForegroundColor Green
}

# 可选：内嵌字体
if ($FontPath -and (Test-Path $FontPath)) {
  $fontBytes = [System.IO.File]::ReadAllBytes($FontPath)
  $b64 = [System.Convert]::ToBase64String($fontBytes)
  $ext = ([System.IO.Path]::GetExtension($FontPath)).TrimStart('.').ToLower()
  $mime = if ($ext -eq "woff2") { "font/woff2" } elseif ($ext -eq "woff") { "font/woff" } elseif ($ext -eq "ttf") { "font/ttf" } else { "application/octet-stream" }
  $format = if ($ext -eq "woff2") { "woff2" } elseif ($ext -eq "woff") { "woff" } elseif ($ext -eq "ttf") { "truetype" } else { $ext }
  $fontFace = "@font-face { font-family: 'TsangerYuYangT'; src: url('data:$mime;base64,$b64') format('$format'); font-weight:400; font-style:normal; }`r`n"
  $content = $fontFace + $content
  Write-Host "Embedded font TsangerYuYangT ($ext)" -ForegroundColor Green
} else {
  Write-Host "No font provided, using system fallback." -ForegroundColor Yellow
}

Set-Content -Path $OutFile -Value $content -Encoding UTF8
Write-Host "Done: $OutFile" -ForegroundColor Cyan