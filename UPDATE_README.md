# Travelio 1.1.0 — Güncelleme paketi

Bu paket, mevcut `C:\Users\mhmmd\travelio_app` Flutter projesinin kaynak dosyalarını günceller. Android platform klasörlerine, SDK ayarlarına veya emülatör yapılandırmasına dokunmaz.

## Önerilen kurulum yöntemi

1. ZIP dosyasını **Travelio_Update** adlı bir klasöre çıkar.
2. Çıkarılan klasörde PowerShell aç.
3. Şu komutları çalıştır:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install_update.ps1
```

Betik, değiştireceği mevcut dosyaların kopyasını `%USERPROFILE%\travelio_backups` altında tarih damgalı bir yedek klasörüne alır, sonra kaynak dosyaları günceller.

4. Ardından yeni bir PowerShell penceresinde şu komutları çalıştır:

```powershell
cd C:\Users\mhmmd\travelio_app
flutter pub get
flutter analyze
flutter test
flutter run
```

Emülatör açıksa normalde `flutter run` yeterlidir. Birden fazla cihaz varsa `flutter devices` ile cihaz kimliğini öğrenip `flutter run -d emulator-5554` kullanabilirsin.

## Bu sürümde

- Toplam 56 örnek destinasyon: 36 Türkiye, 20 yurt dışı.
- Türkiye / yurt dışı / tümü kapsam filtreleri.
- Destinasyon adı, şehir, bölge, ülke, kategori ve etiketle arama.
- Türkçe karakterleri sadeleştirerek arama (ör. `Izmir` veya `İzmir`, `Turkiye` veya `Türkiye`).
- Kategorilere “Şehir” filtresi eklendi.
- Destinasyon detaylarında ülke bilgisini gösterme.
- Arama/filtre sonucu bulunmadığında filtreleri tek dokunuşla temizleme.
- Uygulama sürümü 1.1.0 olarak güncellendi.

## Önemli not

Destinasyonların bütçe sembolleri, puanları ve açıklamaları prototip amaçlı editoryal örneklerdir; canlı fiyat, doğrulanmış kullanıcı puanı, ulaşım, hava durumu veya rezervasyon verisi değildir. Fotoğraflar internet bağlantısıyla yüklenir; bağlantı çalışmazsa yedek manzara simgesi görünür.
