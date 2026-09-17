<%@ Page Title="Detaylı Adres Raporu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RaporDetay.aspx.cs" Inherits="MegaWebProje.RaporDetay" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>

    <style>
        .grid-header-card { background-color: #111827; border-radius: 12px 12px 0 0; padding: 15px 20px !important; }
        .grid-header-card h5 { color: #f9fafb; font-size: 15px; font-weight: 700; }
        .grid-header-card span.sub-text { color: #9ca3af; font-size: 13px; font-weight: 500; }
        
        .search-box { background-color: #1f2937; border: 1px solid #374151; color: white; border-radius: 20px; padding: 5px 15px 5px 30px; font-size: 13px; width: 250px; }
        .search-box::placeholder { color: #9ca3af; }
        .search-icon-wrapper { position: relative; }
        .search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 12px; }
        
        .custom-grid th { background-color: #1a2238 !important; color: white !important; font-size: 12px; text-transform: uppercase; padding: 12px 8px; border: none; }
        .custom-grid td { font-size: 13px; color: #495057; vertical-align: middle; }
        
        .btn-pdf { background-color: #ecfdf5; color: #059669; border: 1px solid #a7f3d0; border-radius: 20px; padding: 6px 18px; font-size: 13px; font-weight: 700; transition: all 0.2s; }
        .btn-pdf:hover { background-color: #d1fae5; }
    </style>

    <div class="container-fluid mt-4">
        <div class="card border-0 shadow-sm" style="border-radius: 12px; overflow:hidden;">
           <div class="grid-header-card p-3 d-flex justify-content-between align-items-center">
                <h5 class="mb-0 m-0 d-flex align-items-center">
                    <span class="me-2">☰</span> Detaylı Adres Raporu 
                    <span class="sub-text ms-2">| MEGA İŞ ÇÖZÜMLERİ</span>
                </h5>
                <div class="search-icon-wrapper">
                    <span class="search-icon">🔍</span>
                    <asp:TextBox ID="txtArama" runat="server" CssClass="search-box" Placeholder="İsim veya Kod ara..." onkeyup="raporDetayBasHarfAra()"></asp:TextBox>
                </div>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                    <asp:GridView ID="gridDetayRapor" runat="server" CssClass="table table-striped table-hover mb-0 custom-grid" 
                        AutoGenerateColumns="False" BorderStyle="None">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" />
                            <asp:BoundField DataField="Kod" HeaderText="Kod" />
                            <asp:BoundField DataField="Ad" HeaderText="Ad" />
                            <asp:BoundField DataField="Adres" HeaderText="Adres" />
                            <asp:BoundField DataField="Semt" HeaderText="Semt" />
                            <asp:BoundField DataField="Sehir" HeaderText="Şehir" />
                            <asp:BoundField DataField="PostaKodu" HeaderText="Posta Kodu" />
                            <asp:BoundField DataField="Ulke" HeaderText="Ülke" />
                            <asp:BoundField DataField="Telefon" HeaderText="Telefon" />
                            <asp:BoundField DataField="Fax" HeaderText="Fax" />
                            <asp:BoundField DataField="VerDar" HeaderText="Vergi Dairesi" />
                            <asp:BoundField DataField="VerNo" HeaderText="Vergi No" />
                            <asp:BoundField DataField="EpostaAdr" HeaderText="E-Posta Adresi" />
                            <asp:BoundField DataField="WebAdr" HeaderText="Web Sitesi" />
                            <asp:BoundField DataField="Yetkili1" HeaderText="Yetkili 1" />
                            <asp:BoundField DataField="Yetkili2" HeaderText="Yetkili 2" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            
            <div class="card-footer bg-white border-top-0 py-3 px-4 d-flex justify-content-between align-items-center">
                <button type="button" class="btn-pdf" onclick="raporDetayPdfIndir()">📄 PDF Olarak İndir</button>
                <span id="lblDetayKayitSayisi" class="fw-bold text-secondary" style="font-size: 13px;">Listelenen Kayıt Sayısı: 0</span>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // @ts-nocheck

        function detayKayitSayisiniGuncelle() {
            var table = document.getElementById('<%= gridDetayRapor.ClientID %>');
            if (!table) return;
            var tr = table.getElementsByTagName("tr");
            var gorunurSayi = 0;
            for (var i = 1; i < tr.length; i++) {
                if (tr[i].style.display !== "none") gorunurSayi++;
            }
            var lbl = document.getElementById("lblDetayKayitSayisi");
            if (lbl) lbl.innerHTML = "Listelenen Kayıt Sayısı: " + gorunurSayi;
        }

        window.onload = function () { detayKayitSayisiniGuncelle(); };

        // Mantıksal Baş Harf / Kelime Başlangıcı Arama Mantığı
        function raporDetayBasHarfAra() {
            var input = document.getElementById('<%= txtArama.ClientID %>');
            if (!input) return; 
            
            var filter = input.value ? input.value.toLowerCase().trim() : "";
            
            var table = document.getElementById('<%= gridDetayRapor.ClientID %>');
            if (!table) return;
            
            var tr = table.getElementsByTagName("tr");
            for (var i = 1; i < tr.length; i++) {
                var rowVisible = false;
                var td = tr[i].getElementsByTagName("td");
                
                // Kod (1. sütun) ve Ad (2. sütun) üzerinde kelime başlangıç araması
                for (var j = 1; j <= 2; j++) {
                    if (td[j] && td[j].innerHTML) {
                        var cellText = td[j].innerHTML.replace(/<[^>]*>?/gm, '').toLowerCase().trim();
                        var kelimeler = cellText.split(/\s+/);
                        
                        for (var k = 0; k < kelimeler.length; k++) {
                            if (kelimeler[k].indexOf(filter) === 0) {
                                rowVisible = true;
                                break;
                            }
                        }
                        if (rowVisible) break;
                    }
                }
                tr[i].style.display = rowVisible ? "" : "none";
            }
            detayKayitSayisiniGuncelle();
        }

        function turkceKarakterCevirDetay(text) {
            if (!text) return "";
            var trMap = {
                'ç': 'c', 'Ç': 'C', 'ğ': 'g', 'Ğ': 'G',
                'ı': 'i', 'İ': 'I', 'ö': 'o', 'Ö': 'O',
                'ş': 's', 'Ş': 'S', 'ü': 'u', 'Ü': 'U'
            };
            return text.replace(/[çÇğĞıİöÖşŞüÜ]/g, function (match) {
                return trMap[match];
            });
        }

        function raporDetayPdfIndir() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('landscape');

            doc.setFontSize(14);
            doc.setFont("helvetica", "bold");
            doc.setTextColor(0, 100, 0); 
            doc.text("MEGA IS COZUMLERI - DETAYLI ADRES RAPORU (RAPOR 2)", 14, 15);

            doc.setFontSize(9);
            doc.setFont("helvetica", "normal");
            doc.setTextColor(0, 0, 0); 
            var now = new Date();
            var dateStr = ("0" + now.getDate()).slice(-2) + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + now.getFullYear() + " " + ("0" + now.getHours()).slice(-2) + ":" + ("0" + now.getMinutes()).slice(-2);
            doc.text("Rapor Tarihi: " + dateStr, 14, 22);

            var table = document.getElementById('<%= gridDetayRapor.ClientID %>');
            if (!table) return; 

            var trs = table.getElementsByTagName("tr");
            if (trs.length === 0) return;

            var headers = [];
            var rows = [];

            var ths = trs[0].getElementsByTagName("th");
            for (var h = 0; h < ths.length; h++) {
                if (h === 0) continue; 
                var baslikMetni = ths[h].innerHTML.replace(/<[^>]*>?/gm, '');
                headers.push(turkceKarakterCevirDetay(baslikMetni.trim()));
            }

            for (var i = 1; i < trs.length; i++) {
                if (trs[i].style.display !== "none") {
                    var rowData = [];
                    var tds = trs[i].getElementsByTagName("td");
                    for (var j = 0; j < tds.length; j++) {
                        if (j === 0) continue; 
                        var hucreMetni = tds[j].innerHTML.replace(/<[^>]*>?/gm, '');
                        rowData.push(turkceKarakterCevirDetay(hucreMetni.trim()));
                    }
                    rows.push(rowData);
                }
            }

            doc.autoTable({
                head: [headers],
                body: rows,
                startY: 28,
                theme: 'grid',
                styles: { fontSize: 5, cellPadding: 1.2, textColor: [0, 0, 0] },
                headStyles: { fillColor: [47, 79, 79], textColor: [255, 255, 255], fontStyle: 'bold', fontSize: 5 }
            });

            doc.save("Adres_Detayli_Raporu_" + dateStr + ".pdf");
        }
    </script>
</asp:Content>