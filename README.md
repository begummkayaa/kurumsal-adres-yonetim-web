# 🌐 Kurumsal Adres ve Raporlama Yönetim Sistemi Web Uygulaması

Kurumsal Adres ve Raporlama Yönetim Sistemi, masaüstü mimaride geliştirilmiş adres otomasyon süreçlerinin modern web teknolojilerine taşınmasını sağlayan, gelişmiş CRUD operasyonları, kelime başlangıçlı canlı arama ve dinamik PDF raporlama özellikleri sunan **ASP.NET WebForms** tabanlı bir web uygulamasıdır.

---

## 📑 İçindekiler

- [Proje Vizyonu ve Özellikler](#-proje-vizyonu-ve-özellikler)
- [Sistem Mimarisi](#️-sistem-mimarisi)
- [Kullanılan Teknolojiler](#️-kullanılan-teknolojiler)
- [Kurulum ve Çalıştırma](#-kurulum-ve-çalıştırma)
- [Kullanım Senaryosu](#-kullanım-senaryosu)
- [Geliştirici ve Proje Hakkında](#-geliştirici-ve-proje-hakkında)
- [Lisans](#-lisans)

---

## ✨ Proje Vizyonu ve Özellikler

Klasik masaüstü otomasyon çözümlerinin web ortamına taşınması; her yerden erişilebilirlik, hız ve modern arayüz standartları gerektirir. Bu proje, masaüstü altyapısındaki veri yönetim mantığını web katmanına entegre ederek şu kabiliyetleri sunar:

- **Gelişmiş CRUD Operasyonları:** Adres ve kurum verilerinin web arayüzü üzerinden hızlı ve güvenli bir şekilde eklenmesi, güncellenmesi ve yönetilmesi.
- **Canlı ve Akıllı Arama (Prefix Search):** `indexOf === 0` mantığıyla çalışan kelime başlangıçlı filtreleme altyapısı sayesinde binlerce kayıt arasında anlık sonuçlara ulaşma.
- **Dinamik jsPDF Raporlama:** Masaüstü raporlama mantığının web'e uyarlanmış hali; Türkçe karakter desteğine ve özel kurumsal tasarım renklerine (Dark Green / Slate Gray) sahip Özet ve Detay PDF raporları üretebilme.
- **İlişkisel Veritabanı Desteği:** SQL Server altyapısı ile optimize edilmiş veri sorgulama ve listeleme performansı.

---

## ⚙️ Sistem Mimarisi

Uygulama, modern web standartlarına uygun olarak katmanlı bir yapıda tasarlanmıştır:

1. **Sunum Katmanı (Presentation Layer):** ASP.NET WebForms (`.aspx`, `.aspx.cs`) sayfaları, HTML5/CSS3 bileşenleri ve kullanıcı etkileşimini yöneten istemci tarafı JavaScript betikleri.
2. **İş Mantığı ve Raporlama Katmanı (Logic & Reporting Layer):** Verilerin işlenmesi, filtrelenmesi ve istemci tarafında `jsPDF` / `AutoTable` kütüphaneleriyle dinamik PDF dokümanlarına dönüştürülmesi.
3. **Veri Erişim Katmanı (Data Access Layer):** SQL Server veritabanı ile güvenli bağlantı kurularak veri alışverişinin (CRUD) sağlandığı C# backend servisleri.

---

## 🛠️ Kullanılan Teknolojiler

- **Backend & Web Framework:** C#, ASP.NET WebForms, .NET
- **Frontend & Scripting:** HTML5, CSS3, JavaScript (Vanilla JS, jsPDF, AutoTable)
- **Veritabanı:** Microsoft SQL Server
- **Geliştirme Ortamı:** Visual Studio

---

## 🚀 Kurulum ve Çalıştırma

Projeyi yerel makinenizde çalıştırmak için aşağıdaki adımları sırasıyla izleyin:

### 1. Repoyu Klonlayın
```bash
git clone [https://github.com/begummkayaa/kurumsal-adres-yonetim-web.git](https://github.com/begummkayaa/kurumsal-adres-yonetim-web.git)
cd kurumsal-adres-yonetim-web
```
### 2. Projeyi Visual Studio ile Açın
Çözüm veya proje dosyasına çift tıklayarak projeyi Visual Studio'da açın.

### 3. Veritabanı Bağlantısını Yapılandırın
Web.config veya ilgili .aspx.cs dosyanız içerisindeki bağlantı dizesini (connectionString) kendi SQL Server adresinize göre güncelleyin.

### 4. Projeyi Çalıştırın
Visual Studio üzerinden IIS Express veya yerel IIS sunucusunu seçerek F5 tuşu ile projeyi tarayıcıda ayağa kaldırın.

## 💡 Kullanım Senaryosu
- Kullanıcı web arayüzündeki Default.aspx paneline giriş yapar ve sistemdeki kayıtlı adres listesini görüntüler.

- Arama çubuğuna yazmaya başladığı anda prefix tabanlı canlı arama devreye girerek eşleşen kayıtları anında filtreler.

- RaporOzet.aspx veya RaporDetay.aspx sayfalarında, veriler kurumsal tasarıma uygun olarak listelenir.

- Sayfadaki "PDF İndir" butonuna tıklandığında, istemci tarafındaki jsPDF entegrasyonu sayesinde Türkçe karakter uyumlu özet/detay raporu saniyeler içinde cihaza indirilir.

## 🏢 Geliştirici ve Proje Hakkında
Bu proje, masaüstü otomasyon altyapısına sahip sistemlerin modern web teknolojilerine adaptasyonunu sağlamak ve gelişmiş jsPDF raporlama modülleriyle zenginleştirmek amacıyla Begüm Kaya tarafından geliştirilmiştir.

## 📄 Lisans
Bu proje MIT Lisansı altında lisanslanmıştır. Daha fazla bilgi için LICENSE dosyasına göz atabilirsiniz.

