<%@ Page Title="Özet Adres Raporu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RaporOzet.aspx.cs" Inherits="MegaWebProje.RaporOzet" %>

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
                    <span class="me-2">☰</span> Özet Adres Raporu 
                    <span class="sub-text ms-2">| MEGA İŞ ÇÖZÜMLERİ</span>
                </h5>
                <div class="search-icon-wrapper">
                    <span class="search-icon">🔍</span>
                    <asp:TextBox ID="txtArama" runat="server" CssClass="search-box" Placeholder="İsim veya Kod ara..." onkeyup="raporOzetBasHarfAra()"></asp:TextBox>
                </div>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive" style="max-height: 500px; overflow-y: auto;">
                    <asp:GridView ID="gridOzetRapor" runat="server" CssClass="table table-striped table-hover mb-0 custom-grid" 
                        AutoGenerateColumns="False" BorderStyle="None">
                        <Columns>
                            <asp:BoundField DataField="Kod" HeaderText="Kod" />
                            <asp:BoundField DataField="Ad" HeaderText="Ad" />
                            <asp:BoundField DataField="Adres" HeaderText="Adres" />
                            <asp:BoundField DataField="Semt" HeaderText="Semt" />
                            <asp:BoundField DataField="Sehir" HeaderText="Sehir" />
                            <asp:BoundField DataField="Telefon" HeaderText="Telefon" />
                            <asp:BoundField DataField="EpostaAdr" HeaderText="E-Posta Adresi" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            
            <div class="card-footer bg-white border-top-0 py-3 px-4 d-flex justify-content-between align-items-center">
                <button type="button" class="btn-pdf" onclick="raporOzetPdfIndir()">📄 PDF Olarak İndir</button>
                <span id="lblKayitSayisi" class="fw-bold text-secondary" style="font-size: 13px;">Listelenen Kayıt Sayısı: 0</span>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // @ts-nocheck
        
        function ozetKayitSayisiniGuncelle() {
            var table = document.getElementById('<%= gridOzetRapor.ClientID %>');
            if (!table) return;
            var tr = table.getElementsByTagName("tr");
            var gorunurSayi = 0;
            for (var i = 1; i < tr.length; i++) {
                if (tr[i].style.display !== "none") gorunurSayi++;
            }
            var lbl = document.getElementById("lblKayitSayisi");
            if (lbl) lbl.innerHTML = "Listelenen Kayıt Sayısı: " + gorunurSayi;
        }

        window.onload = function () { ozetKayitSayisiniGuncelle(); };

        // Mantıksal Baş Harf / Kelime Başlangıcı Arama Mantığı
        function raporOzetBasHarfAra() {
            var input = document.getElementById('<%= txtArama.ClientID %>');
            if (!input) return; 
            
            var filter = input.value ? input.value.toLowerCase().trim() : "";
            
            var table = document.getElementById('<%= gridOzetRapor.ClientID %>');
            if (!table) return;
            
            var tr = table.getElementsByTagName("tr");
            for (var i = 1; i < tr.length; i++) {
                var rowVisible = false;
                var td = tr[i].getElementsByTagName("td");
                
                // Kod (0. sütun) ve Ad (1. sütun) üzerinde kelime başlangıç araması
                for (var j = 0; j <= 1; j++) {
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
            ozetKayitSayisiniGuncelle();
        }

        function turkceKarakterCevirOzet(text) {
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

        function raporOzetPdfIndir() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('landscape'); 

            doc.setFontSize(14);
            doc.setFont("helvetica", "bold");
            doc.setTextColor(0, 100, 0); 
            doc.text("MEGA IS COZUMLERI - ADRES OZET RAPORU (RAPOR 1)", 14, 15);

            doc.setFontSize(9);
            doc.setFont("helvetica", "normal");
            doc.setTextColor(0, 0, 0); 
            var now = new Date();
            var dateStr = ("0" + now.getDate()).slice(-2) + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + now.getFullYear() + " " + ("0" + now.getHours()).slice(-2) + ":" + ("0" + now.getMinutes()).slice(-2);
            doc.text("Rapor Tarihi: " + dateStr, 14, 22);

            var table = document.getElementById('<%= gridOzetRapor.ClientID %>');
            if (!table) return; 

            var trs = table.getElementsByTagName("tr");
            if (trs.length === 0) return;

            var headers = [];
            var rows = [];

            var ths = trs[0].getElementsByTagName("th");
            for (var h = 0; h < ths.length; h++) {
                var baslikMetni = ths[h].innerHTML.replace(/<[^>]*>?/gm, '');
                headers.push(turkceKarakterCevirOzet(baslikMetni.trim()));
            }

            for (var i = 1; i < trs.length; i++) {
                if (trs[i].style.display !== "none") {
                    var rowData = [];
                    var tds = trs[i].getElementsByTagName("td");
                    for (var j = 0; j < tds.length; j++) {
                        var hucreMetni = tds[j].innerHTML.replace(/<[^>]*>?/gm, '');
                        rowData.push(turkceKarakterCevirOzet(hucreMetni.trim()));
                    }
                    rows.push(rowData);
                }
            }

            doc.autoTable({
                head: [headers],
                body: rows,
                startY: 28,
                theme: 'grid',
                styles: { fontSize: 7, cellPadding: 2, textColor: [0, 0, 0] },
                headStyles: { fillColor: [47, 79, 79], textColor: [255, 255, 255], fontStyle: 'bold', fontSize: 7 },
                columnStyles: {
                    0: { cellWidth: 20 }, 1: { cellWidth: 50 }, 2: { cellWidth: 65 }, 3: { cellWidth: 30 }, 
                    4: { cellWidth: 30 }, 5: { cellWidth: 35 }, 6: { cellWidth: 50 }
                }
            });

            doc.save("Adres_Ozet_Raporu_" + dateStr + ".pdf");
        }
    </script>
</asp:Content>