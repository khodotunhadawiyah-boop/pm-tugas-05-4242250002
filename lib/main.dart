import 'package:material_ui/material_ui.dart';

void main() => runApp(const MenuUmkmApp());

/// Akar aplikasi. Stateless karena tidak punya data yang berubah.
class MenuUmkmApp extends StatelessWidget {
  const MenuUmkmApp({super.key});

  // Satu-satunya warna yang ditulis langsung: seed color.
  static const Color _seed = Color(0xFFE8825A);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu UMKM Kuliner Medan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanMenu(),
    );
  }
}

/// Data satu menu.
class ItemMenu {
  const ItemMenu(this.nama, this.harga, this.kategori);
  final String nama;
  final String harga;
  final String kategori;
}

const List<ItemMenu> daftarMenu = [
  ItemMenu('Soto Medan', 'Rp 25.000', 'Makanan'),
  ItemMenu('Mie Gomak', 'Rp 22.000', 'Makanan'),
  ItemMenu('Bika Ambon', 'Rp 35.000', 'Kue'),
  ItemMenu('Es Teh Manis', 'Rp 6.000', 'Minuman'),
];

/// Halaman utama. Stateless: hanya menyusun tampilan dari data tetap.
class HalamanMenu extends StatelessWidget {
  const HalamanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Menu UMKM Kuliner Medan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _KepalaUsaha(),
          const SizedBox(height: 16),
          const _KartuKontak(),
          const SizedBox(height: 24),
          Text('Daftar Menu', style: teks.titleLarge),
          const SizedBox(height: 8),
          for (final menu in daftarMenu)
            KartuMenu(
              nama: menu.nama,
              harga: menu.harga,
              kategori: menu.kategori,
            ),
        ],
      ),
    );
  }
}

/// Kepala: gambar, nama usaha, deskripsi singkat.
class _KepalaUsaha extends StatelessWidget {
  const _KepalaUsaha();

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            // Cadangan bila internet mati atau gambar gagal dimuat.
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              width: double.infinity,
              color: skema.primaryContainer,
              child: Icon(
                Icons.restaurant,
                size: 64,
                color: skema.onPrimaryContainer,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Warung Rasa Medan', style: teks.headlineSmall),
        const SizedBox(height: 4),
        Text(
          'Kuliner khas Medan yang dimasak segar setiap hari.',
          textAlign: TextAlign.center,
          style: teks.bodyMedium?.copyWith(color: skema.onSurfaceVariant),
        ),
      ],
    );
  }
}

/// Kontak: Card + ListTile (3 baris) dan dua tombol aksi.
class _KartuKontak extends StatelessWidget {
  const _KartuKontak();

  void _pesan(BuildContext context, String isi) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isi)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.phone_outlined),
            title: Text('+62 812-0000-0000'),
          ),
          const Divider(height: 1),
          const ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Jl. Contoh No. 1, Medan'),
          ),
          const Divider(height: 1),
          const ListTile(
            leading: Icon(Icons.schedule_outlined),
            title: Text('Buka setiap hari, 08.00 - 21.00'),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.icon(
                  onPressed: () => _pesan(context, 'Membuka pesanan...'),
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Pesan'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _pesan(context, 'Membuka peta...'),
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Lokasi'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu satu menu. Stateless: tampilannya hanya bergantung pada parameter.
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.kategori,
  });

  final String nama;
  final String harga;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.restaurant_menu)),
        title: Text(nama),
        subtitle: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            Text(harga),
            Chip(label: Text(kategori)),
          ],
        ),
        trailing: TombolFavorit(nama: nama),
      ),
    );
  }
}

/// Placeholder sementara, diganti di Tahap 3.
class TombolFavorit extends StatelessWidget {
  const TombolFavorit({super.key, required this.nama});
  final String nama;

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.favorite_border);
  }
}