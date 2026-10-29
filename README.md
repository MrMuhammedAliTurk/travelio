# Travelio — Flutter Gezi Keşif ve Planlama Uygulaması

Travelio, Türkiye ve dünyanın farklı bölgelerindeki örnek destinasyonları keşfetmek, aramak, favorilere kaydetmek ve kişisel gezi planı oluşturmak için hazırlanmış bir Flutter uygulaması prototipidir.

## Özellikler

- Keşfet ekranı ve öne çıkan rota kartı
- Türkiye / yurt dışı kapsam filtresi
- 50’den fazla Türkiye ve yurt dışı örnek destinasyonu
- Şehir, ülke, bölge, kategori ve etikete göre arama
- Kültür, doğa, sahil ve tarih kategorileriyle filtreleme
- Destinasyon detay sayfası ve öne çıkan etiketler
- Favorilere ekleme ve favorilerden çıkarma
- Gezi planına ekleme ve plandan çıkarma
- Profil, uygulama bilgileri ve tercih ekranı
- Dart veri modeli, `fromJson` / `toJson` örneği
- Ekranlar arası geçiş için `Navigator` ve `MaterialPageRoute`
- Flutter'ın yerleşik Material bileşenleri; üçüncü taraf UI paketi kullanılmaz

> Bu prototipte kullanıcı hesabı, gerçek harita/konum, çevrim içi rezervasyon ve kalıcı veri tabanı bulunmaz. Destinasyon açıklamaları, puanları ve bütçe göstergeleri editoryal örneklerdir; gerçek zamanlı veya doğrulanmış fiyat/puan verisi değildir. Favoriler ve gezi planı uygulama çalıştığı sürece bellekte tutulur. Puanlar, bütçe göstergeleri ve açıklamalar örnek veridir.

## Gereksinimler

- Flutter SDK (Dart, Flutter ile birlikte gelir)
- Visual Studio Code
- Android Studio ve Android Emulator veya fiziksel Android cihaz

## Windows'ta projeyi hazırlama

Bu kaynak paketi Flutter'ın Android/iOS platform klasörleri olmadan gelir. `setup_flutter_project.ps1` betiği bilgisayarında Flutter proje iskeletini üretir ve bu kaynakları içine kopyalar.

1. Flutter SDK'yı kur ve `flutter doctor` komutunun çalıştığını doğrula.
2. ZIP dosyasını bir klasöre çıkar.
3. PowerShell'i bu klasörde aç ve çalıştır:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\setup_flutter_project.ps1
```

Betik, kaynak klasörünün bir üst dizininde `travelio` adında tam Flutter projesi oluşturur. Ardından şu komutlarla çalıştırabilirsin:

```powershell
cd ..\travelio
flutter pub get
flutter run
```

Birden fazla cihaz/emülatör varsa önce `flutter devices` ile cihaz kimliğini kontrol et ve gerekirse `flutter run -d <cihaz_kimliği>` kullan.

## Görseller

Destinasyon fotoğrafları internet üzerinden yüklenir. Görsel bağlantısı çalışmazsa uygulama yerleşik bir manzara simgesiyle yedek görünüm gösterir. Android'de internet erişiminin etkin olması gerekir.

## Proje yapısı

```text
lib/
  main.dart
  data/
    destination_data.dart
  models/
    destination.dart
  screens/
    main_shell.dart
    explore_screen.dart
    destination_detail_screen.dart
    saved_screen.dart
    itinerary_screen.dart
    profile_screen.dart
  widgets/
    destination_card.dart
    destination_image.dart
```

## GitHub teslimi için öneri

Projeyi çalıştırdıktan sonra Git deposu oluştur, ekran görüntülerini `screenshots/` klasörüne ekle ve bu README dosyasını proje kökünde tut. Flutter sürümünü `flutter --version` komutuyla kontrol ederek teslim notlarına ekle.
