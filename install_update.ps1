$ErrorActionPreference = 'Stop'

$targetRoot = Join-Path $env:USERPROFILE 'travelio_app'
if (-not (Test-Path (Join-Path $targetRoot 'pubspec.yaml'))) {
    throw "Flutter projesi bulunamadı: $targetRoot`nProjen farklı bir dizindeyse install_update.ps1 içindeki targetRoot yolunu düzenle."
}

$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupRoot = Join-Path $env:USERPROFILE "travelio_backups\travelio_app_1.1.0_$stamp"
New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null

$pathsToBackup = @('lib', 'test/widget_test.dart', 'pubspec.yaml', 'README.md')
foreach ($relativePath in $pathsToBackup) {
    $sourcePath = Join-Path $targetRoot $relativePath
    if (Test-Path $sourcePath) {
        $backupPath = Join-Path $backupRoot $relativePath
        $backupParent = Split-Path $backupPath -Parent
        New-Item -ItemType Directory -Path $backupParent -Force | Out-Null
        Copy-Item -Path $sourcePath -Destination $backupPath -Recurse -Force
    }
}

New-Item -ItemType Directory -Path (Join-Path $targetRoot 'lib') -Force | Out-Null
Copy-Item -Path (Join-Path $PSScriptRoot 'lib\*') -Destination (Join-Path $targetRoot 'lib') -Recurse -Force
New-Item -ItemType Directory -Path (Join-Path $targetRoot 'test') -Force | Out-Null
Copy-Item -Path (Join-Path $PSScriptRoot 'test\widget_test.dart') -Destination (Join-Path $targetRoot 'test\widget_test.dart') -Force
Copy-Item -Path (Join-Path $PSScriptRoot 'pubspec.yaml') -Destination (Join-Path $targetRoot 'pubspec.yaml') -Force
Copy-Item -Path (Join-Path $PSScriptRoot 'README.md') -Destination (Join-Path $targetRoot 'README.md') -Force

Write-Host ''
Write-Host 'Travelio 1.1.0 kaynak dosyaları güncellendi.' -ForegroundColor Green
Write-Host "Yedek klasörü: $backupRoot" -ForegroundColor Cyan
Write-Host 'Şimdi PowerShell üzerinde şu komutları çalıştır:' -ForegroundColor Yellow
Write-Host 'cd C:\Users\mhmmd\travelio_app'
Write-Host 'flutter pub get'
Write-Host 'flutter analyze'
Write-Host 'flutter test'
Write-Host 'flutter run'
