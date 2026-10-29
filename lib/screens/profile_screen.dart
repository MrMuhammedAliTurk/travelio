import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profil', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Seyahat tercihlerini ve uygulama bilgilerini yönet.', style: TextStyle(color: Color(0xFF7D8984), fontSize: 13)),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE8EDE9))),
            child: Row(
              children: [
                Container(
                  height: 62,
                  width: 62,
                  decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF176B5B), Color(0xFF6DB49B)]), shape: BoxShape.circle),
                  child: const Icon(Icons.person_rounded, color: Colors.white, size: 34),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gezgin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF182D2A))),
                      SizedBox(height: 5),
                      Text('Yeni maceralara hazır', style: TextStyle(fontSize: 12, color: Color(0xFF7D8984))),
                    ],
                  ),
                ),
                const Icon(Icons.edit_outlined, color: Color(0xFF7D8984)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Tercihler', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF182D2A))),
          const SizedBox(height: 11),
          _ProfileOption(icon: Icons.language_rounded, title: 'Dil', subtitle: 'Türkçe', onTap: () => _showInfo(context, 'Dil', 'Bu örnek sürüm Türkçe arayüzle hazırlanmıştır.')),
          _ProfileOption(icon: Icons.notifications_none_rounded, title: 'Bildirimler', subtitle: 'Demo sürümünde kapalı', onTap: () => _showInfo(context, 'Bildirimler', 'Bildirim ayarları sonraki geliştirme aşamasında eklenebilir.')),
          _ProfileOption(icon: Icons.shield_outlined, title: 'Gizlilik', subtitle: 'Veri kullanımı hakkında', onTap: () => _showInfo(context, 'Gizlilik', 'Bu başlangıç sürümünde hesap veya sunucu bağlantısı yoktur. Favoriler ve gezi planı uygulama açıkken bellekte tutulur.')),
          const SizedBox(height: 20),
          const Text('Uygulama', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF182D2A))),
          const SizedBox(height: 11),
          _ProfileOption(icon: Icons.explore_outlined, title: 'Travelio hakkında', subtitle: 'Sürüm 1.1.0 · Genişletilmiş katalog', onTap: () => _showInfo(context, 'Travelio hakkında', 'Travelio, Flutter ile geliştirilen bir gezi keşif ve planlama uygulaması prototipidir. Katalogda Türkiye ve farklı ülkelerden 50’den fazla örnek destinasyon yer alır; puan, bütçe ve açıklamalar editoryal örneklerdir.')),
          _ProfileOption(icon: Icons.code_rounded, title: 'Kullanılan teknoloji', subtitle: 'Flutter · Dart · Material', onTap: () => _showInfo(context, 'Teknoloji', 'Uygulama Flutter ve Dart ile oluşturulmuştur. Başlangıç sürümünde ek Flutter paketi kullanılmaz.')),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFEAF3EE), borderRadius: BorderRadius.circular(20)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tips_and_updates_outlined, color: Color(0xFF176B5B), size: 22),
                SizedBox(width: 10),
                Expanded(child: Text('Bu proje bir başlangıç prototipidir. Gerçek rezervasyon, harita, konum ve kullanıcı hesabı özellikleri henüz bulunmaz.', style: TextStyle(color: Color(0xFF4E6A60), fontSize: 12, height: 1.55))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Tamam'))],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(17),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE8EDE9))),
            child: Row(
              children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFEAF3EE), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF176B5B), size: 20)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF243A34))), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF84908A)))])),
                const Icon(Icons.chevron_right_rounded, color: Color(0xFF8A9690)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
