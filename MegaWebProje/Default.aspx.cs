using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Xml;

namespace MegaWebProje
{
    public partial class _Default : Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["MegaBaglanti"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                VerileriGetir();
            }
        }

        private void VerileriGetir()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM AdresAna", baglanti);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Columns.Contains("TcKimlikNo"))
            {
                dt.Columns.Remove("TcKimlikNo");
            }

            if (dt.Columns.Contains("GNot"))
            {
                dt.Columns.Remove("GNot");
            }

            gridAdresler.DataSource = dt;
            gridAdresler.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "updateCount", "setTimeout(kayitSayisiniGuncelle, 100);", true);
        }

        // Ortak Kayıt Getirme Metodu
        private void KaydiGetir(int id)
        {
            ViewState["SecilenID"] = id;

            baglanti.Open();
            SqlCommand komut = new SqlCommand("SELECT * FROM AdresAna WHERE ID = @p1", baglanti);
            komut.Parameters.AddWithValue("@p1", id);
            SqlDataReader dr = komut.ExecuteReader();

            if (dr.Read())
            {
                txtKod.Text = dr["Kod"].ToString();
                txtAd.Text = dr["Ad"].ToString();
                txtAdres.Text = dr["Adres"].ToString();
                txtSemt.Text = dr["Semt"].ToString();
                txtSehir.Text = dr["Sehir"].ToString();
                txtUlke.Text = dr["Ulke"].ToString();
                txtPostaKodu.Text = dr["PostaKodu"].ToString();
                txtTelefon.Text = dr["Telefon"].ToString();
                txtFax.Text = dr["Fax"].ToString();
                txtVergiDairesi.Text = dr["VerDar"].ToString();
                txtVergiNo.Text = dr["VerNo"].ToString();
                txtMail.Text = dr["EpostaAdr"].ToString();
                txtWeb.Text = dr["WebAdr"].ToString();
                txtYetkili1.Text = dr["Yetkili1"].ToString();
                txtYetkili2.Text = dr["Yetkili2"].ToString();
            }
            baglanti.Close();
        }

        // İLK KAYDA GİT (⏮️)
        protected void btnIlk_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut = new SqlCommand("SELECT TOP 1 ID FROM AdresAna ORDER BY ID ASC", baglanti);
            object sonuc = komut.ExecuteScalar();
            baglanti.Close();

            if (sonuc != null && sonuc != DBNull.Value)
            {
                KaydiGetir(Convert.ToInt32(sonuc));
            }
        }

        // GERİ TUŞU (⏪)
        protected void btnGeri_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut;

            if (ViewState["SecilenID"] == null)
            {
                komut = new SqlCommand("SELECT TOP 1 ID FROM AdresAna ORDER BY ID DESC", baglanti);
            }
            else
            {
                int mevcutID = Convert.ToInt32(ViewState["SecilenID"]);
                komut = new SqlCommand("SELECT TOP 1 ID FROM AdresAna WHERE ID < @p1 ORDER BY ID DESC", baglanti);
                komut.Parameters.AddWithValue("@p1", mevcutID);
            }

            object sonuc = komut.ExecuteScalar();
            baglanti.Close();

            if (sonuc != null && sonuc != DBNull.Value)
            {
                KaydiGetir(Convert.ToInt32(sonuc));
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Zaten ilk kayıttasınız!');", true);
            }
        }

        // İLERİ TUŞU (⏩)
        protected void btnIleri_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut;

            if (ViewState["SecilenID"] == null)
            {
                komut = new SqlCommand("SELECT TOP 1 ID FROM AdresAna ORDER BY ID ASC", baglanti);
            }
            else
            {
                int mevcutID = Convert.ToInt32(ViewState["SecilenID"]);
                komut = new SqlCommand("SELECT TOP 1 ID FROM AdresAna WHERE ID > @p1 ORDER BY ID ASC", baglanti);
                komut.Parameters.AddWithValue("@p1", mevcutID);
            }

            object sonuc = komut.ExecuteScalar();
            baglanti.Close();

            if (sonuc != null && sonuc != DBNull.Value)
            {
                KaydiGetir(Convert.ToInt32(sonuc));
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Zaten son kayıttasınız!');", true);
            }
        }

        // SON KAYDA GİT (⏭️)
        protected void btnSon_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut = new SqlCommand("SELECT TOP 1 ID FROM AdresAna ORDER BY ID DESC", baglanti);
            object sonuc = komut.ExecuteScalar();
            baglanti.Close();

            if (sonuc != null && sonuc != DBNull.Value)
            {
                KaydiGetir(Convert.ToInt32(sonuc));
            }
        }

        // Yeni Kayıt Kaydet
        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            baglanti.Open();

            SqlCommand komut = new SqlCommand("INSERT INTO AdresAna (Kod, Ad, Adres, Semt, Sehir, Ulke, PostaKodu, Telefon, Fax, VerDar, VerNo, EpostaAdr, WebAdr, Yetkili1, Yetkili2) VALUES (@p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12, @p13, @p14, @p15)", baglanti);

            komut.Parameters.AddWithValue("@p1", txtKod.Text);
            komut.Parameters.AddWithValue("@p2", txtAd.Text);
            komut.Parameters.AddWithValue("@p3", txtAdres.Text);
            komut.Parameters.AddWithValue("@p4", txtSemt.Text);
            komut.Parameters.AddWithValue("@p5", txtSehir.Text);
            komut.Parameters.AddWithValue("@p6", txtUlke.Text);
            komut.Parameters.AddWithValue("@p7", txtPostaKodu.Text);
            komut.Parameters.AddWithValue("@p8", txtTelefon.Text);
            komut.Parameters.AddWithValue("@p9", txtFax.Text);
            komut.Parameters.AddWithValue("@p10", txtVergiDairesi.Text);
            komut.Parameters.AddWithValue("@p11", txtVergiNo.Text);
            komut.Parameters.AddWithValue("@p12", txtMail.Text);
            komut.Parameters.AddWithValue("@p13", txtWeb.Text);
            komut.Parameters.AddWithValue("@p14", txtYetkili1.Text);
            komut.Parameters.AddWithValue("@p15", txtYetkili2.Text);

            komut.ExecuteNonQuery();
            baglanti.Close();

            VerileriGetir();
            TemizleForm();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Kayıt başarıyla eklendi!');", true);
        }

        // Grid'den satır seçimi
        protected void gridAdresler_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(gridAdresler.SelectedDataKey.Value);
            KaydiGetir(id);
        }

        // Güncelleme İşlemi
        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            if (ViewState["SecilenID"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Lütfen önce listeden güncellemek istediğiniz kaydı seçin!');", true);
                return;
            }

            baglanti.Open();
            SqlCommand komut = new SqlCommand("UPDATE AdresAna SET Kod=@p1, Ad=@p2, Adres=@p3, Semt=@p4, Sehir=@p5, Ulke=@p6, PostaKodu=@p7, Telefon=@p8, Fax=@p9, VerDar=@p10, VerNo=@p11, EpostaAdr=@p12, WebAdr=@p13, Yetkili1=@p14, Yetkili2=@p15 WHERE ID=@p16", baglanti);

            komut.Parameters.AddWithValue("@p1", txtKod.Text);
            komut.Parameters.AddWithValue("@p2", txtAd.Text);
            komut.Parameters.AddWithValue("@p3", txtAdres.Text);
            komut.Parameters.AddWithValue("@p4", txtSemt.Text);
            komut.Parameters.AddWithValue("@p5", txtSehir.Text);
            komut.Parameters.AddWithValue("@p6", txtUlke.Text);
            komut.Parameters.AddWithValue("@p7", txtPostaKodu.Text);
            komut.Parameters.AddWithValue("@p8", txtTelefon.Text);
            komut.Parameters.AddWithValue("@p9", txtFax.Text);
            komut.Parameters.AddWithValue("@p10", txtVergiDairesi.Text);
            komut.Parameters.AddWithValue("@p11", txtVergiNo.Text);
            komut.Parameters.AddWithValue("@p12", txtMail.Text);
            komut.Parameters.AddWithValue("@p13", txtWeb.Text);
            komut.Parameters.AddWithValue("@p14", txtYetkili1.Text);
            komut.Parameters.AddWithValue("@p15", txtYetkili2.Text);
            komut.Parameters.Add("@p16", SqlDbType.Int).Value = ViewState["SecilenID"];

            komut.ExecuteNonQuery();
            baglanti.Close();

            VerileriGetir();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Kayıt başarıyla güncellendi!');", true);
        }

        // Silme İşlemi
        protected void btnSil_Click(object sender, EventArgs e)
        {
            if (ViewState["SecilenID"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Lütfen önce listeden silmek istediğiniz kaydı seçin!');", true);
                return;
            }

            baglanti.Open();
            SqlCommand komut = new SqlCommand("DELETE FROM AdresAna WHERE ID=@p1", baglanti);
            komut.Parameters.AddWithValue("@p1", ViewState["SecilenID"]);
            komut.ExecuteNonQuery();
            baglanti.Close();

            VerileriGetir();
            TemizleForm();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Kayıt başarıyla silindi!');", true);
        }

        // Ekranı Temizle
        protected void btnTemizle_Click(object sender, EventArgs e)
        {
            txtArama.Text = "";
            TemizleForm();
            VerileriGetir();
        }

        // TCMB XML Servisi ile Güncel Kur Çek ve DovizGecmisi Tablosuna Arşivle Butonu
        protected void btnGuncelKurCek_Click(object sender, EventArgs e)
        {
            try
            {
                // Saat 15:30 kontrolü ve gün kontrolü (Hafta sonu veya 15:30 öncesi durumu)
                DateTime simdi = DateTime.Now;
                string tcmbUrl = "https://www.tcmb.gov.tr/kurlar/today.xml";
                string durumStr = "Güncel Bugünün Kuru";

                // Eğer saat 15:30'dan küçükse veya günlerden Cumartesi/Pazar ise TCMB henüz o günün kurunu yayınlamamıştır
                if (simdi.Hour < 15 || (simdi.Hour == 15 && simdi.Minute < 30) || simdi.DayOfWeek == DayOfWeek.Saturday || simdi.DayOfWeek == DayOfWeek.Sunday)
                {
                    durumStr = "En Son Açıklanan Geçmiş İş Günü Kuru (15:30 Öncesi / Tatil Modu)";
                }

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(tcmbUrl);

                string dolarStr = xmlDoc.SelectSingleNode("Tarih_Date/Currency[@Kod='USD']/BanknoteSelling")?.InnerText;
                string euroStr = xmlDoc.SelectSingleNode("Tarih_Date/Currency[@Kod='EUR']/BanknoteSelling")?.InnerText;

                if (string.IsNullOrEmpty(dolarStr))
                    dolarStr = xmlDoc.SelectSingleNode("Tarih_Date/Currency[@Kod='USD']/ForexSelling")?.InnerText;
                if (string.IsNullOrEmpty(euroStr))
                    euroStr = xmlDoc.SelectSingleNode("Tarih_Date/Currency[@Kod='EUR']/ForexSelling")?.InnerText;

                if (!string.IsNullOrEmpty(dolarStr) && !string.IsNullOrEmpty(euroStr))
                {
                    decimal dolar = Convert.ToDecimal(dolarStr.Replace(".", ","));
                    decimal euro = Convert.ToDecimal(euroStr.Replace(".", ","));

                    using (SqlCommand komut = new SqlCommand("INSERT INTO DovizGecmisi (Tarih, DolarKuru, EuroKuru, Durum) VALUES (@tarih, @dolar, @euro, @durum)", baglanti))
                    {
                        komut.Parameters.AddWithValue("@tarih", simdi);
                        komut.Parameters.AddWithValue("@dolar", dolar);
                        komut.Parameters.AddWithValue("@euro", euro);
                        komut.Parameters.AddWithValue("@durum", durumStr);

                        baglanti.Open();
                        komut.ExecuteNonQuery();
                        baglanti.Close();
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "basarili", $"alert('✅ Kur başarıyla çekildi ve arşive eklendi!\\nDurum: {durumStr}\\nUSD: {dolar}\\nEUR: {euro}');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "hata", "alert('TCMB kur verileri okunamadı!');", true);
                }
            }
            catch (Exception ex)
            {
                if (baglanti.State == ConnectionState.Open) baglanti.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "exHata", $"alert('Kur çekilirken hata oluştu: {ex.Message}');", true);
            }
        }

        private void TemizleForm()
        {
            txtKod.Text = "";
            txtAd.Text = "";
            txtAdres.Text = "";
            txtSemt.Text = "";
            txtSehir.Text = "";
            txtUlke.Text = "";
            txtPostaKodu.Text = "";
            txtTelefon.Text = "";
            txtFax.Text = "";
            txtVergiDairesi.Text = "";
            txtVergiNo.Text = "";
            txtMail.Text = "";
            txtWeb.Text = "";
            txtYetkili1.Text = "";
            txtYetkili2.Text = "";
            ViewState["SecilenID"] = null;
        }
    }
}