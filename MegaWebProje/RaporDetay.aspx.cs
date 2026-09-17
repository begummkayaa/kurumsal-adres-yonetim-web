using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace MegaWebProje
{
    public partial class RaporDetay : Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["MegaBaglanti"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DetayVerileriGetir();
            }
        }

        private void DetayVerileriGetir()
        {
            // Detaylı raporda tüm sütunları çekiyoruz
            string sorgu = "SELECT * FROM AdresAna";
            SqlDataAdapter da = new SqlDataAdapter(sorgu, baglanti);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gridDetayRapor.DataSource = dt;
            gridDetayRapor.DataBind();

            // Alt kısımdaki kayıt sayısını güncelliyoruz
            int kayitSayisi = dt.Rows.Count;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setCount", $"document.getElementById('lblKayitSayisi').innerText = 'Listelenen Kayıt Sayısı: {kayitSayisi}';", true);
        }

        protected void btnPdfIndir_Click(object sender, EventArgs e)
        {
            try
            {
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