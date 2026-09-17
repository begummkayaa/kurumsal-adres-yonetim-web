<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MegaWebProje._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- GÖRSELE ÖZEL YENİ NESİL TASARIM CSS KODLARI -->
    <style>
        /* Buton Tasarımları (Oval ve Modern) */
        .action-bar .btn {
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            padding: 6px 18px;
            margin-right: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .action-bar .btn-nav {
            background-color: white;
            border: 1px solid #dee2e6;
            color: #495057;
        }
        .action-bar .btn-nav:hover { background-color: #f8f9fa; }
        
        /* Form Label ve Textbox Tasarımları */
        .form-section { background-color: #ffffff; border-radius: 12px; }
        .form-title { color: #2b4c7e; font-size: 14px; font-weight: 700; text-transform: uppercase; }
        .custom-label { font-size: 13px; font-weight: 700; color: #b73e4b; /* Kiremit/kırmızımsı label rengi */ }
        .custom-input {
            border-radius: 15px; 
            border: 1px solid #ffeeba; 
            font-size: 13px;
            padding: 6px 15px;
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.02);
        }
        .custom-input:focus { border-color: #80bdff; outline: none; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); }
        
        /* Grid Tablo Başlık Tasarımı (Koyu Lacivert) */
        .grid-header-card { background-color: #1a2238; border-radius: 12px 12px 0 0; }
        .grid-header-card h5 { color: #ffffff; font-size: 14px; font-weight: 600; }
        .grid-header-card span.sub-text { color: #8a98b9; font-size: 12px; font-weight: normal; }
        
        /* Arama Kutusu (Oval ve Koyu) */
        .search-box { background-color: #2a344a; border: none; color: white; border-radius: 20px; padding: 4px 15px 4px 30px; font-size: 13px; width: 250px; }
        .search-box::placeholder { color: #8a98b9; }
        .search-icon-wrapper { position: relative; }
        .search-icon { position: absolute; left: 10px; top: 50%; transform: translateY(-50%); color: #8a98b9; font-size: 12px; }
        
        /* Grid Tablo İçi */
        .custom-grid th { background-color: #1a2238 !important; color: white !important; font-size: 12px; text-transform: uppercase; padding: 12px 8px; border: none; }
        .custom-grid td { font-size: 13px; color: #495057; vertical-align: middle; }
    </style>

    <div class="container-fluid mt-4">
        
        <!-- ÜST MENÜ / ARAÇ ÇUBUĞU -->
        <div class="card mb-3 border-0 shadow-sm" style="border-radius: 12px;">
            <div class="card-body p-3 action-bar d-flex justify-content-between align-items-center flex-wrap">
                <!-- İşlem Butonları -->
                <div>
                    <asp:Button ID="btnEkle" runat="server" Text="➕ Yeni Kayıt" CssClass="btn btn-primary" />
                    <asp:Button ID="btnKaydet" runat="server" Text="✔️ Kaydet" CssClass="btn btn-success" OnClick="btnKaydet_Click" />
                    <asp:Button ID="btnGuncelle" runat="server" Text="🔄 Güncelle" CssClass="btn btn-warning text-white" OnClick="btnGuncelle_Click" />
                    <asp:Button ID="btnSil" runat="server" Text="🗑️ Sil" CssClass="btn btn-danger" OnClick="btnSil_Click" />
                </div>

                <!-- Navigasyon Butonları -->
                <div>
                    <asp:Button ID="btnIlk" runat="server" Text="⏮ İlk" CssClass="btn btn-nav" OnClick="btnIlk_Click" />
                    <asp:Button ID="btnGeri" runat="server" Text="◀ Geri" CssClass="btn btn-nav" OnClick="btnGeri_Click" />
                    <asp:Button ID="btnIleri" runat="server" Text="İleri ▶" CssClass="btn btn-nav" OnClick="btnIleri_Click" />
                    <asp:Button ID="btnSon" runat="server" Text="Son ⏭" CssClass="btn btn-nav" OnClick="btnSon_Click" />
                </div>

                <!-- Ekstra Araçlar -->
                <div>
                    <asp:Button ID="btnTemizle" runat="server" Text="🧹 Ekranı Temizle" CssClass="btn btn-outline-info text-info fw-bold" style="background:white;" OnClick="btnTemizle_Click" />
                    <asp:Button ID="btnKurCek" runat="server" Text="💱 Güncel Kur Çek" CssClass="btn btn-outline-primary fw-bold" style="background:white;" OnClick="btnGuncelKurCek_Click" />
                </div>
            </div>
        </div>

        <!-- ADRES ANA BİLGİLERİ -->
        <div class="card border-0 shadow-sm mb-4 form-section">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
                    <div class="form-title">
                        📄 ADRES ANA BİLGİLERİ
                    </div>
                    <div class="text-muted" style="font-size:12px;">Aktif Kayıt Düzenleme</div>
                </div>

                <div class="row">
                    <!-- Sol Kolon -->
                    <div class="col-md-6">
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Kod</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtKod" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Ad</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtAd" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-start">
                            <label class="col-sm-3 col-form-label custom-label pt-2">Adres</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtAdres" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control custom-input" style="border-radius: 10px;"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Semt</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtSemt" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Şehir</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtSehir" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                         <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Ülke</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtUlke" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Posta Kodu</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtPostaKodu" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- Sağ Kolon -->
                    <div class="col-md-6">
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Telefon</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtTelefon" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Fax</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtFax" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Vergi Da.</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtVergiDairesi" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Vergi No</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtVergiNo" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Mail</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtMail" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Web Sitesi</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtWeb" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Yetkili 1</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtYetkili1" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label custom-label">Yetkili 2</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtYetkili2" runat="server" CssClass="form-control custom-input"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- VERİ LİSTESİ VE CANLI ARAMA -->
        <div class="card border-0 shadow-sm" style="border-radius: 12px; overflow:hidden;">
            <div class="grid-header-card p-3 d-flex justify-content-between align-items-center">
                <h5 class="mb-0 m-0 d-flex align-items-center gap-2">
                    ☰ Kayıt Listesi <span class="sub-text">| Özet Adres Raporu</span>
                </h5>
                <div class="search-icon-wrapper">
                    <span class="search-icon">🔍</span>
                    <asp:TextBox ID="txtArama" runat="server" CssClass="search-box" Placeholder="İsim veya Kod ara..." onkeyup="canliBasHarfAra()"></asp:TextBox>
                </div>
            </div>
            
            <div class="card-body p-0">
                <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                    <asp:GridView ID="gridAdresler" runat="server" CssClass="table table-striped table-hover mb-0 custom-grid" 
                        AutoGenerateColumns="False" AutoGenerateSelectButton="True" DataKeyNames="ID" OnSelectedIndexChanged="gridAdresler_SelectedIndexChanged" BorderStyle="None">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" />
                            <asp:BoundField DataField="Kod" HeaderText="Firma Kodu" />
                            <asp:BoundField DataField="Ad" HeaderText="Firma Ünvanı" />
                            <asp:BoundField DataField="Adres" HeaderText="Adres" />
                            <asp:BoundField DataField="Semt" HeaderText="Semt / İlçe" />
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
            <!-- Alt Kısımda Listelenen Kayıt Sayısı -->
            <div class="card-footer bg-white border-top-0 py-3 px-4">
                <span id="lblKayitSayisi" class="fw-bold text-secondary" style="font-size: 13px;">Listelenen Kayıt Sayısı: 0</span>
            </div>
        </div>
    </div>

    <!-- Canlı Arama ve Baş Harfe Göre Süzme Mantığı (Sıfır Hata) -->
    <script type="text/javascript">
        // @ts-nocheck

        function kayitSayisiniGuncelle() {
            var table = document.getElementById('<%= gridAdresler.ClientID %>');
            if (!table) return;
            var tr = table.getElementsByTagName("tr");
            var gorunurSayi = 0;

            for (var i = 1; i < tr.length; i++) {
                if (tr[i].style.display !== "none") {
                    gorunurSayi++;
                }
            }
            var lbl = document.getElementById("lblKayitSayisi");
            if (lbl) lbl.innerHTML = "Listelenen Kayıt Sayısı: " + gorunurSayi;
        }

        window.onload = function() {
            kayitSayisiniGuncelle();
        };

        function canliBasHarfAra() {
            var input = document.getElementById('<%= txtArama.ClientID %>');
            if (!input) return;
            var filter = input.value ? input.value.toLowerCase().trim() : "";
            
            var table = document.getElementById('<%= gridAdresler.ClientID %>');
            if (!table) return;
            var tr = table.getElementsByTagName("tr");

            for (var i = 1; i < tr.length; i++) {
                var rowVisible = false;
                var td = tr[i].getElementsByTagName("td");
                
                // Kod (1. sütun) ve Ad (2. sütun) üzerinde kelime başlangıç araması yapar
                for (var j = 1; j <= 2; j++) {
                    if (td[j] && td[j].innerHTML) {
                        var cellText = td[j].innerHTML.replace(/<[^>]*>?/gm, '').toLowerCase().trim();
                        var kelimeler = cellText.split(/\s+/);
                        
                        for (var k = 0; k < kelimeler.length; k++) {
                            // Kelimenin TAM OLARAK aranan ifade ile başlaması şartı (indexOf === 0)
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
            kayitSayisiniGuncelle();
        }
    </script>
</asp:Content>