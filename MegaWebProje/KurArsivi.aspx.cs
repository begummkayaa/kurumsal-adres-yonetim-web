using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Xml;

namespace MegaWebProje
{
    public partial class KurArsivi : Page
    {
        SqlConnection baglanti = new SqlConnection(ConfigurationManager.ConnectionStrings["MegaBaglanti"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                KurlariListele();
            }
        }

        private void KurlariListele()
        {
            string sorgu = "SELECT Tarih, DolarKuru, EuroKuru, Durum FROM DovizGecmisi ORDER BY Tarih DESC";
            SqlDataAdapter da = new SqlDataAdapter(sorgu, baglanti);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gridKurArsivi.DataSource = dt;
            gridKurArsivi.DataBind();

            int kayitSayisi = dt.Rows.Count;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setCount", $"document.getElementById('lblKayitSayisi').innerText = 'Listelenen Arşiv Kaydı: {kayitSayisi}';", true);
        }

        protected void btnKurCek_Click(object sender, EventArgs e)
        {
            try
            {
                string tcmbUrl = "https://www.tcmb.gov.tr/kurlar/today.xml";
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
                    DateTime simdi = DateTime.Now;
                    string durumStr = "Başarılı";

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

                    KurlariListele();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "basarili", "alert('Güncel kurlar TCMB'den başarıyla çekildi ve arşive kaydedildi!');", true);
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
    }
}