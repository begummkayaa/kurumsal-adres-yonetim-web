<%@ Page Title="TCMB Kur Arşivi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="KurArsivi.aspx.cs" Inherits="MegaWebProje.KurArsivi" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        /* Ana Kart Tasarımı */
        .card-kur {
            border-radius: 12px;
            overflow: hidden;
            border: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            background-color: #ffffff;
        }
        
        /* En Üst Koyu Lacivert/Siyah Başlık */
        .kur-header {
            background-color: #111827;
            padding: 15px 25px;
        }
        .kur-title {
            color: #f9fafb;
            font-weight: 700;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .kur-icon { color: #fbbf24; font-size: 18px; }
        
        /* Otomatik Kur Servisi Butonu */
        .btn-oto {
            background-color: #1f2937;
            color: #9ca3af;
            border: 1px solid #374151;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            padding: 6px 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-oto:hover { background-color: #374151; color: #ffffff; }

        /* Tablo ve Sütun Başlıkları (Koyu Gri) */
        .kur-table th {
            background-color: #374151 !important;
            color: #d1d5db !important;
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 700;
            padding: 12px 25px;
            border: none;
        }
        .kur-table td {
            font-size: 13px;
            font-weight: 600;
            color: #6b7280;
            padding: 14px 25px;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }
        .kur-table tr:nth-child(even) td { background-color: #fafafa; }
        .kur-table tr:hover td { background-color: #f3f4f6; }

        /* Güncel Kur Rozeti (Pill) */
        .badge-guncel {
            background-color: #ecfdf5;
            color: #059669;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: 1px solid #a7f3d0;
        }
        .badge-dot {
            width: 6px;
            height: 6px;
            background-color: #10b981;
            border-radius: 50%;
            display: inline-block;
        }
    </style>

    <div class="container-fluid mt-4">
        <div class="card card-kur">
            
            <!-- Görseldeki Üst Kısım -->
            <div class="kur-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div class="kur-title d-flex align-items-center gap-2">
                    <span class="kur-icon">💸</span> 
                    TCMB Döviz Arşivi 
                    <span style="color: #9ca3af; font-size: 13px; font-weight: 500;">| MEGA İŞ ÇÖZÜMLERİ</span>
                </div>
                <button type="button" class="btn-oto">Otomatik Kur Servisi</button>
            </div>
            
            <!-- Tablo -->
            <div class="card-body p-0 table-responsive" style="max-height: 550px; overflow-y: auto;">
                <asp:GridView ID="gridKurArsivi" runat="server" CssClass="table kur-table mb-0" 
                    AutoGenerateColumns="False" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Tarih" HeaderText="ÇEKİM TARİHİ" />
                        <asp:BoundField DataField="DolarKuru" HeaderText="ABD DOLARI ($)" />
                        <asp:BoundField DataField="EuroKuru" HeaderText="EURO (€)" />
                        <asp:BoundField DataField="Durum" HeaderText="DURUM" />
                    </Columns>
                </asp:GridView>
            </div>
            
            <!-- Alt Bilgi (Footer) -->
            <div class="card-footer bg-white border-top py-3 px-4 d-flex justify-content-between align-items-center">
                <span class="text-muted" style="font-size: 12px;">TCMB arşiv kayıtları listelenmektedir.</span>
                <span id="lblKurSayisi" class="fw-bold" style="font-size: 13px; color: #4b5563;">Listelenen Arşiv Kaydı: 0</span>
            </div>
            
        </div>
    </div>

    <!-- JavaScript ile C#'a Dokunmadan Sütunları Renklendirme ve Rozet Ekleme -->
    <script type="text/javascript">
function kurTablosunuDuzenle() {
    var table = document.getElementById('<%= gridKurArsivi.ClientID %>');
            if (!table) return;
            
            var tr = table.getElementsByTagName("tr");
            var gorunurSayi = tr.length > 1 ? tr.length - 1 : 0;

            for (var i = 1; i < tr.length; i++) {
                var tdList = tr[i].getElementsByTagName("td");
                
                if (tdList.length >= 4) {
                    // Dolar Sütununu Yeşil Yap
                    tdList[1].style.color = "#059669";
                    
                    // Euro Sütununu Mavi Yap
                    tdList[2].style.color = "#3b82f6";
                    
                    // Durum Sütununu Kontrol Et
                    var durumTd = tdList[3];
                    var durumText = durumTd.innerText.trim();

                    // SADECE "Güncel Bugünün Kuru" yazıyorsa rozete çevir. 
                    // "Başarılı" ve diğer yazılar olduğu gibi (normal yazı) kalacak.
                    if (durumText === "Güncel Bugünün Kuru") {
                        durumTd.innerHTML = '<span class="badge-guncel"><span class="badge-dot"></span> Güncel Bugünün Kuru</span>';
                    }
                }
            }

            // Alt Kayıt Sayısını Güncelle
            var lbl = document.getElementById("lblKurSayisi");
            if (lbl) {
                lbl.innerText = "Listelenen Arşiv Kaydı: " + gorunurSayi;
            }
        }

        window.onload = function() {
            kurTablosunuDuzenle();
        };
    </script>
</asp:Content>