# chill_kicks

Project PUDIL CHILL KICKS NI BOS

## Widget Tree dan Bagaimana Hubungan Parent-Child Bekerja Antar Widget

Widget Tree adalah representasi struktur dari semua widget yang digunakan untuk membangun tampilan UI di Flutter. Karena semua hal seperti teks, tombol, layout, padding, dll itu bagian dari widget di Flutter. Widget tree cuman jadi visual yang menunjukkan widget mana yang ada di dalam widget. Salah satu contohnya ada widget yang menjadi rott yaitu Material App, lalu di dalamnya ada widget lagi Scaffold lalu di dalamnya lagi ada widget seperti column, text, icon, dll. Setiap widget yang membungkus widget lain disebut parent dan widget yang dibungkus oleh widget lain itu disebut child.

Hubungannya sendiri adalah mekanisme layout dari flutter dan menentukan konfigurasi tampilannya.Widget parent mengatur tata letak. Parent menentukan batas maksimum dan minimum ukuran yang diperbolehkan untuk child. Sedangkan untuk widget child memberi tahu parent ukuran yang diinginkan berdasarkan batasan yang diberikan.

## Semua widget yang digunakan beserta fungsinya

- MyApp. Widget root proyek ini, bertugas untuk menjalankan dan mendifinisikan theme dan struktur projek.
- MateriapApp. Menyediakan fungsi tampilan desain material google seperti routing dan theme.
- ThemeData (didalam MaterialApp). Mendefinisikan tema visual aplikasi secara keseluruhan, seperti warna, font, serta bentuk widget.
- ColorScheme (didalam ThemeData). Mendefinisikan color pallete yang mau digunakan seperti primary dan secondary color.
- MyHomePage. Menyediakan struktur tata letak visual dasar home screennya
- Scaffold. Struktur untuk letak visual dasar seperti appbar, body, dan drawer.
- AppBar. Bagian atas halaman seperti judul dan navbar.
- Text. String text di halaman.
- TextStyle. Mengatur styling widget text.
- IconThemeData. Digunakan di AppBar untuk atur warna icon di dalamnya.
- Padding. Mengatur space kosong di child widgetnya.
- Column. Menyusun dan menampilkan child widgetnya secara vertikal.
- Row. Menyusun dan menampilkan child widgetnya secara horizontal.
- SizedBox. Memberi ruang kosong dengan ukuran yang tetap.
- Center. Menempatkan child widgetnya pas di tengah.
- GridView.Count. Menampilkan child widgetnya di grid 2D dengan jumlah kolom yang telah ditentukan untuk menu utama.
- NeverScrollableScrollPhysics. Digunakan di GridView agar grid tetap statis di Column.
- ItemCard. Widget yang punya button menu (punya icon dan tekxt).
- Material. Menyediakan pengaturan untuk background, borderRadius, untuk childrennya.
- InkWell. Menyediakan visual ketika widget hover sekaligus menyediakan handler onTap biar lebih interaktif.
- Container. Agar widget fleksibel digunakan untuk dekorasi, padding, atau menuntukan ukuran dari child widgetnya.
- Icon. Menampilkan icon dari library Material Design.
- ScaffoldMessenger. Dipakai untuk mengelola SnackBar.
- SnackBar. Pesan pemberitahuan sementara di bagian bawa layar pas ItemCard ditekan.
- InfoCard. Widget yang menampilkan kartu informasi statis.
- Card. Menyediakan wadaw Material Design secara visual.
- MediaQuery. Mendapatkan ukuran misalnya untuk mengatur lebar InfoCard.

## Fungsi Widget MaterialApp dan Alasan Widget ini Sering Digunakan Sebagai Widget Root

MaterialApp menjadi widget yang penting di semua hal. Theming, MaterialApp memungkinkan kita mendefinisikan skema warna, font, dan visual default lainnya untuk keseluruhan aplikasi. Routing, memungkinkan kita untuk mengelola sistem navigasi aplikasi, jadi perpindahan antar halaman. Judul Aplikasi, menentukan judul aplikasi yang muncul di task manager atau switch aplikasi. Localization, bisa pakai fitur multi-bahasa dan regional.

Selain itu, MaterialApp hampir selalu digunakan sebagai widget root karena penyediaan konteks dan sebagai struktur dasar.

1. Penyediaan Konteks
    Supaya widget yang digunakan untuk desain dapat berfungsi dengan benar dan punya tampilan yang konsisten, mereka perlu konteks yang disediakan MaterialApp. Kalau tanpa MaterialApp, widget seperti Scaffold tidak akan tau cara ambil theme, mengelola navbar, atau menampilkan pesan seperti SnackBar.

2. Navbar
    Flutter dimulai dengan satu halaman, dengan MaterialApp akan disediakan properti home dan yang lebih penting, semua halaman berikutnya dimuat di atasnya. Fungsi utamanya menyiapkan theme, navigasi, locale, widget tersebut harus berada di posisi tertinggi di dalam widget tree untuk memastikan sebuah widget dibawhanya bisa akses layanan-layanan tersebut.

## Perbedaan Antara StatelessWidget dan StatefulWidget

- StatelessWidget merupakan widget yang tampilannya tidak berubah setelah dibuat, sedangkan StatefulWidget adalah widget yang tampilannya bisa berubah sepanjang waktu hidupnya, berdasarkan data internal.
- StatelessWidget hanya memiliki satu method build(). Sedangkan untuk StatefulWidget memiliki method createState() yang mengembalikan objek State terpisah dan objek State tersebut punya method build() dan dipanggil ulang waktu datanya berubah.
- StatelessWidget tidak punya mekanisme untuk pembaruan internal. Cuman digambar ulang kalau parent widgetnya digambar ulang. Sedangkan StatefulWidget digambar ulang secara eksplisit dengan memanggil metode setState() di dalam objek State.

1. Kapan Memilih StatelessWidget
    Ketika tampilan widget cuman bergantung di informasi yang diberikan pada saat pembuatan dan tidak akan berubah kedepannya. Misal InfoCar yang menampilkan NPM, Nama, dan Kelas. Widget ini hanya sebagai pembungkus layout, dekorasi, atau menampilkan text/icon.
2. Kapan Memilih StatefulWidget
    Ketika perlu mengubah tampilan sebagai respon terhadap interaksi pengguna, data dari APi, atau hal-hal lainnya. Perlu memanggil fungsi setState() juga untuk memberi tahu Flutter agar menggambar ulang widget tersebut dengan data yang baru.

## BuildContext dan penggunaannya di metode build

BuildContext adalah pegangan atau referensi yang mewakili lokasi dari sebuah widget dalam widget tree. BuildContext adalah kunci yang memungkinkan widget Anda mengetahui di mana posisinya, sehingga ia dapat mengakses sumber daya dan layanan dari widget lain yang berada di atasnya (induk) dalam pohon. Fungsi BUildContext yang paling utama adalah mengakses tema dan data, memungkinkan widget untuk mencari dan mengakses data yang disediakan oleh widget induk yang lebih tinggi di pohon. Navigasi, Digunakan sebagai argumen untuk fungsi navigasi. Akses layanan, Digunakan untuk berinteraksi dengan layanan tingkat atas, seperti menampilkan snackbar. Layout, Secara internal, Flutter menggunakan BuildContext untuk melacak elemen dan merender widget secara efisien.

Setiap metode build() pada widget, baik StatelessWidget maupun StatefulWidget, wajib menerima satu parameter bertipe BuildContext. Di dalam metode build(), digunakan variabel context untuk memanggil fungsionalitas yang disediakan oleh widget-widget yang berada di atasnya.

## "Hot Reload" dan "Hot Restart"

Konsep Hot Reload dan Hot Restart adalah fitur penting di Flutter yang mempercepat siklus pengembangan aplikasi. Perbedaan utamanya terletak pada kecepatan dan apa yang dipertahankan saat kode diubah. Hot Reload adalah mekanisme tercepat untuk melihat hasil perubahan kode Anda. Hot Reload menyuntikkan source code yang telah diperbarui ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Flutter membangun file kode yang berubah, lalu mengirimkan kode yang diperbarui tersebut ke VM aplikasi yang sudah berjalan, dan Flutter secara otomatis menjalankan kembali metode build() untuk Widget Tree yang terpengaruh.

Hot Restart adalah mekanisme yang lebih menyeluruh, mirip dengan "berhenti dan mulai" aplikasi secara cepat. Hot Restart menghancurkan dan membangun kembali Dart VM sepenuhnya. Aplikasi dihentikan, lalu Dart VM dihancurkan dan dibuat ulang dan aplikasi dimulai kembali dari awal (dari main()).