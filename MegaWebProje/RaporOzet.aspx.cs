using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace MegaWebProje
{
    public partial class RaporOzet : Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["MegaBaglanti"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                OzetVerileriGetir();
            }
        }

        private void OzetVerileriGetir()
        {
            // Özet raporda görünecek sütunları seçiyoruz (Görseldeki gibi)
            string sorgu = "SELECT Kod, Ad, Adres, Semt, Sehir, Telefon, EpostaAdr FROM AdresAna";
            SqlDataAdapter da = new SqlDataAdapter(sorgu, baglanti);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gridOzetRapor.DataSource = dt;
            gridOzetRapor.DataBind();

            // Alt kısımdaki kayıt sayısını dinamik yazdırıyoruz
            int kayitSayisi = dt.Rows.Count;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setCount", $"document.getElementById('lblKayitSayisi').innerText = 'Listelenen Kayıt Sayısı: {kayitSayisi}';", true);
        }

        protected void btnPdfIndir_Click(object sender, EventArgs e)
        {
            try
            {
                // Sayfayı doğrudan yazdırma/PDF kaydetme moduna açan JavaScript komutu
                string script = "window.print();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "printScript", script, true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "pdfHata", $"alert('Yazdırma başlatılırken hata oluştu: {ex.Message}');", true);
            }
        }
    }
}