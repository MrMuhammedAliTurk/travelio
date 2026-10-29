$ErrorActionPreference = 'Stop'

$sourceRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$targetRoot = Join-Path (Split-Path -Parent $sourceRoot) 'travelio'

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "Flutter komutu bulunamadı. Flutter SDK'yı kurup PATH'e ekledikten sonra yeniden çalıştır."
}

if (Test-Path $targetRoot) {
    throw "Hedef klasör zaten var: $targetRoot`nMevcut projeyi korumak için işlem durduruldu. Klasörü yeniden adlandır veya silip betiği tekrar çalıştır."
}

Write-Host "Flutter proje iskeleti oluşturuluyor: $targetRoot" -ForegroundColor Cyan
flutter create --project-name travelio --org com.travelio.app "$targetRoot"
if ($LASTEXITCODE -ne 0) { throw 'flutter create başarısız oldu.' }

Write-Host 'Travelio kaynak dosyaları kopyalanıyor...' -ForegroundColor Cyan
$targetLib = Join-Path $targetRoot 'lib'
if (Test-Path $targetLib) { Remove-Item $targetLib -Recurse -Force }
Copy-Item (Join-Path $sourceRoot 'lib') $targetLib -Recurse -Force
Copy-Item (Join-Path $sourceRoot 'pubspec.yaml') (Join-Path $targetRoot 'pubspec.yaml') -Force
Copy-Item (Join-Path $sourceRoot 'README.md') (Join-Path $targetRoot 'README.md') -Force
$targetTest = Join-Path $targetRoot 'test'
if (Test-Path $targetTest) { Remove-Item $targetTest -Recurse -Force }
Copy-Item (Join-Path $sourceRoot 'test') $targetTest -Recurse -Force

# Fotoğraflar Image.network ile yüklendiği için Android internet iznini ekle.
$manifestPath = Join-Path $targetRoot 'android\app\src\main\AndroidManifest.xml'
if (Test-Path $manifestPath) {
    $manifest = Get-Content $manifestPath -Raw
    if ($manifest -notmatch 'android.permission.INTERNET') {
        $manifest = $manifest -replace '(<manifest[^>]*>)', ('$1' + "`r`n    <uses-permission android:name=`"android.permission.INTERNET`" />")
        Set-Content -Path $manifestPath -Value $manifest -Encoding UTF8
    }
}

Push-Location $targetRoot
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw 'flutter pub get başarısız oldu.' }
} finally {
    Pop-Location
}

Write-Host ''
Write-Host 'Travelio proje iskeleti hazır.' -ForegroundColor Green
Write-Host "Proje dizini: $targetRoot"
Write-Host 'Çalıştırmak için: '
Write-Host "  Set-Location `"$targetRoot`""
Write-Host '  flutter run'
