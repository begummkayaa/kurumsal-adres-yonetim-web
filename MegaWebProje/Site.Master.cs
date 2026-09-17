using System;
using System.Web.UI;

namespace MegaWebProje
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string aktifSayfa = Request.Url.AbsolutePath.ToLower();

                // Hangi sayfadaysak ilgili menüyü beyaz/aktif yapıyoruz
                if (aktifSayfa.EndsWith("default.aspx") || aktifSayfa == "/")
                {
                    lnkAnaSayfa.Attributes["class"] = "nav-link active text-white fw-bold";
                    lnkRaporlar.Attributes["class"] = "nav-link dropdown-toggle text-white-50";
                }
                else if (aktifSayfa.Contains("rapor") || aktifSayfa.Contains("kurarsivi"))
                {
                    lnkAnaSayfa.Attributes["class"] = "nav-link text-white-50";
                    lnkRaporlar.Attributes["class"] = "nav-link dropdown-toggle active text-white fw-bold";
                }
            }
        }
    }
}