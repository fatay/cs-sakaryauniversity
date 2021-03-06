USE [RestaurantOtomasyon]
GO
/****** Object:  UserDefinedFunction [dbo].[fncGenelKdvliFiyat]    Script Date: 16.12.2019 17:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fncGenelKdvliFiyat]
(@fiyat money, @adet int, @indirim float)
returns money
as 
begin
 declare @kdvli money
	set @kdvli=@fiyat*@adet
	set @kdvli=@kdvli+(@kdvli*0.18)
	set @kdvli=@kdvli*(1-@indirim)
	return @kdvli
end
GO
/****** Object:  UserDefinedFunction [dbo].[fncKdvHesabi]    Script Date: 16.12.2019 17:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fncKdvHesabi](@fiyat money)
returns money
as 
begin
declare @kdv money
set @kdv =@fiyat*0.18
return @kdv 
end
GO
/****** Object:  UserDefinedFunction [dbo].[fncSatisSayisi]    Script Date: 16.12.2019 17:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fncSatisSayisi](@toplam int)
returns int
as
begin
declare @sayi int
set @sayi=+@toplam
return @sayi
end
GO
/****** Object:  Table [dbo].[masalar]    Script Date: 16.12.2019 17:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[masalar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KAPASITE] [int] NULL,
	[servısturu] [int] NULL,
	[DURUM] [int] NULL,
	[ONAY] [bit] NULL,
 CONSTRAINT [PK_masalar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[bosMasa]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[bosMasa](@bosM bit)
returns table
as
return select * from masalar where DURUM=@bosM
GO
/****** Object:  Table [dbo].[personeller]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personeller](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GOREVID] [int] NULL,
	[AD] [nchar](50) NULL,
	[SOYAD] [nchar](50) NULL,
	[PAROLA] [nchar](50) NULL,
	[KULLANICIADI] [nchar](50) NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_personeller] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[izinliPersonel]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[izinliPersonel](@izin bit)
returns table
as
return select * from personeller where DURUM=@izin
GO
/****** Object:  Table [dbo].[adisyonlar]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adisyonlar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServisTurNo] [int] NOT NULL,
	[Tarih] [datetime] NOT NULL,
	[PersonelID] [int] NOT NULL,
	[Durum] [bit] NULL,
	[MasaId] [int] NULL,
 CONSTRAINT [PK_adisyonlar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hesapOdemeleri]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hesapOdemeleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ADISYONID] [int] NULL,
	[MUSTERIID] [int] NULL,
	[ODEMETURID] [int] NULL,
	[ARATOPLAM] [money] NULL,
	[KDVTUTARI] [money] NULL,
	[TOPLAMTUTAR] [money] NULL,
	[TARIH] [datetime] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_hesapOdemeleri] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kategoriler]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kategoriler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KATEGORIADI] [nchar](100) NULL,
	[ACIKLAMA] [text] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_kategoriler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[musteriler]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[musteriler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AD] [nchar](50) NULL,
	[SOYAD] [nchar](50) NULL,
	[ADRES] [text] NULL,
	[TELEFON] [nchar](50) NULL,
	[ILKSIPARIS] [date] NULL,
	[EMAİL] [nchar](50) NULL,
	[SIPARISSAYISI] [int] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_musteriler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[odemeTurleri]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[odemeTurleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ODEMETURU] [nchar](50) NULL,
	[ACIKLAMA] [text] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_odemeTurleri] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[paketSiparis]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paketSiparis](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MUSTERIID] [int] NULL,
	[ADISYONID] [int] NULL,
	[ODEMETURU] [int] NULL,
	[ACIKLAMA] [text] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_paketSiparis] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personelGorevleri]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personelGorevleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GOREV] [nchar](100) NULL,
	[ACIKLAMA] [text] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_personelgorev] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personelHareketleri]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personelHareketleri](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PERSONELID] [int] NULL,
	[ISLEM] [nchar](50) NULL,
	[TARIH] [nchar](10) NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_personelhareketleri] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rezervasyonlar]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rezervasyonlar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MUSTERIADI] [int] NULL,
	[MASAID] [int] NULL,
	[ADISYONID] [int] NULL,
	[KISISAYISI] [int] NULL,
	[TARIH] [datetime] NULL,
	[ACIKLAMA] [text] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_Rezervasyonlar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[satislar]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[satislar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ADISYONID] [int] NULL,
	[URUNID] [int] NULL,
	[MASAID] [int] NULL,
	[ADET] [int] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_satislar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[servisturu]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[servisturu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SERVISADI] [nchar](50) NULL,
	[ACIKLAMA] [text] NULL,
 CONSTRAINT [PK_servisturu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[urunler]    Script Date: 16.12.2019 17:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[urunler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KATEGORIID] [int] NULL,
	[URUNAD] [nchar](100) NULL,
	[ACIKLAMA] [text] NULL,
	[FIYAT] [money] NULL,
	[DURUM] [bit] NULL,
 CONSTRAINT [PK_urunler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[adisyonlar] ON 

INSERT [dbo].[adisyonlar] ([ID], [ServisTurNo], [Tarih], [PersonelID], [Durum], [MasaId]) VALUES (1, 1, CAST(N'2019-12-14T03:48:04.777' AS DateTime), 1, 0, 2)
INSERT [dbo].[adisyonlar] ([ID], [ServisTurNo], [Tarih], [PersonelID], [Durum], [MasaId]) VALUES (2, 1, CAST(N'2019-12-14T03:48:46.997' AS DateTime), 1, 0, 3)
SET IDENTITY_INSERT [dbo].[adisyonlar] OFF
SET IDENTITY_INSERT [dbo].[hesapOdemeleri] ON 

INSERT [dbo].[hesapOdemeleri] ([ID], [ADISYONID], [MUSTERIID], [ODEMETURID], [ARATOPLAM], [KDVTUTARI], [TOPLAMTUTAR], [TARIH], [DURUM]) VALUES (1, NULL, NULL, NULL, NULL, NULL, 4535.0000, NULL, 0)
SET IDENTITY_INSERT [dbo].[hesapOdemeleri] OFF
SET IDENTITY_INSERT [dbo].[kategoriler] ON 

INSERT [dbo].[kategoriler] ([ID], [KATEGORIADI], [ACIKLAMA], [DURUM]) VALUES (1, N'Çorbalar                                                                                            ', N'çorbalar', 0)
INSERT [dbo].[kategoriler] ([ID], [KATEGORIADI], [ACIKLAMA], [DURUM]) VALUES (2, N'Ana Yemekler                                                                                        ', N'Ana yemekler', 0)
INSERT [dbo].[kategoriler] ([ID], [KATEGORIADI], [ACIKLAMA], [DURUM]) VALUES (3, N'Fast Food                                                                                           ', N'Fast Food', 0)
INSERT [dbo].[kategoriler] ([ID], [KATEGORIADI], [ACIKLAMA], [DURUM]) VALUES (4, N'İçecekler                                                                                           ', N'içecekler', 0)
INSERT [dbo].[kategoriler] ([ID], [KATEGORIADI], [ACIKLAMA], [DURUM]) VALUES (5, N'Tatlılar                                                                                            ', N'tatlılar', 0)
SET IDENTITY_INSERT [dbo].[kategoriler] OFF
SET IDENTITY_INSERT [dbo].[masalar] ON 

INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (1, 5, 1, 2, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (2, 3, 1, 2, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (3, 5, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (4, 4, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (5, 7, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (6, 3, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (7, 6, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (8, 10, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (9, 9, 1, 1, 0)
INSERT [dbo].[masalar] ([ID], [KAPASITE], [servısturu], [DURUM], [ONAY]) VALUES (10, 8, 1, 1, 0)
SET IDENTITY_INSERT [dbo].[masalar] OFF
SET IDENTITY_INSERT [dbo].[personelGorevleri] ON 

INSERT [dbo].[personelGorevleri] ([ID], [GOREV], [ACIKLAMA], [DURUM]) VALUES (1, N'komi                                                                                                ', N'komi', 0)
INSERT [dbo].[personelGorevleri] ([ID], [GOREV], [ACIKLAMA], [DURUM]) VALUES (2, N'Bulaşıkçı                                                                                           ', N'Baş Bulaşıkçı', 0)
INSERT [dbo].[personelGorevleri] ([ID], [GOREV], [ACIKLAMA], [DURUM]) VALUES (3, N'şef                                                                                                 ', N'şef', 0)
SET IDENTITY_INSERT [dbo].[personelGorevleri] OFF
SET IDENTITY_INSERT [dbo].[personelHareketleri] ON 

INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (1, 5, N'giriş yaptı                                       ', N'Dec 13 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (2, 5, N'giriş yaptı                                       ', N'Dec 13 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (3, 5, N'giriş yaptı                                       ', N'Dec 13 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (4, 5, N'giriş yaptı                                       ', N'Dec 13 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (5, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (6, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (7, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (8, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (9, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (10, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (11, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (12, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (13, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (14, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (15, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (16, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (17, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (18, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (19, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (20, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (21, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (22, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (23, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (24, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (25, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (26, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (27, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (28, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (29, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (30, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (31, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (32, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (33, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (34, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (35, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (36, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (37, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (38, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (39, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (40, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (41, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (42, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (43, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (44, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (45, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (46, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (47, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (48, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (49, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (50, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (51, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (52, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (53, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (54, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (55, 5, N'giriş yaptı                                       ', N'Dec 14 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (56, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (57, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (58, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (59, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (60, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (61, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (62, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (63, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (64, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (65, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (66, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (67, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (68, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (69, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (70, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (71, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (72, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (73, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (74, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (75, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (76, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (77, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (78, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (79, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (80, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (81, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (82, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (83, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (84, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (85, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (86, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (87, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (88, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (89, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (90, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (91, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (92, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (93, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (94, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (95, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (96, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (97, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (98, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (99, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
GO
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (100, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (101, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (102, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (103, 5, N'giriş yaptı                                       ', N'Dec 15 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (104, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (105, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (106, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (107, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (108, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (109, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (110, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (111, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (112, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (113, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (114, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (115, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (116, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (117, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (118, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (119, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (120, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (121, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (122, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (123, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (124, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (125, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (126, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (127, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (128, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (129, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (130, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (131, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (132, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (133, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (134, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (135, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (136, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (137, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (138, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (139, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (140, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (141, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (142, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
INSERT [dbo].[personelHareketleri] ([ID], [PERSONELID], [ISLEM], [TARIH], [DURUM]) VALUES (143, 5, N'giriş yaptı                                       ', N'Dec 16 201', 0)
SET IDENTITY_INSERT [dbo].[personelHareketleri] OFF
SET IDENTITY_INSERT [dbo].[personeller] ON 

INSERT [dbo].[personeller] ([ID], [GOREVID], [AD], [SOYAD], [PAROLA], [KULLANICIADI], [DURUM]) VALUES (1, 3, N'Adem                                              ', N'Yalçın                                            ', N'123456                                            ', N'yalcinkaya                                        ', 0)
INSERT [dbo].[personeller] ([ID], [GOREVID], [AD], [SOYAD], [PAROLA], [KULLANICIADI], [DURUM]) VALUES (2, 2, N'Belkıs                                            ', N'Kaya                                              ', N'123456                                            ', N'belkiskaya                                        ', 1)
INSERT [dbo].[personeller] ([ID], [GOREVID], [AD], [SOYAD], [PAROLA], [KULLANICIADI], [DURUM]) VALUES (5, 1, N'Beyzanur                                          ', N'Demir                                             ', N'123                                               ', N'byznrdmr                                          ', 0)
SET IDENTITY_INSERT [dbo].[personeller] OFF
SET IDENTITY_INSERT [dbo].[satislar] ON 

INSERT [dbo].[satislar] ([ID], [ADISYONID], [URUNID], [MASAID], [ADET], [DURUM]) VALUES (1, 1, 1, 1, 345, 1)
INSERT [dbo].[satislar] ([ID], [ADISYONID], [URUNID], [MASAID], [ADET], [DURUM]) VALUES (2, 2, 2, 2, 12, 1)
SET IDENTITY_INSERT [dbo].[satislar] OFF
SET IDENTITY_INSERT [dbo].[servisturu] ON 

INSERT [dbo].[servisturu] ([ID], [SERVISADI], [ACIKLAMA]) VALUES (1, N'Komi                                              ', N'Komi')
INSERT [dbo].[servisturu] ([ID], [SERVISADI], [ACIKLAMA]) VALUES (2, N'Garson                                            ', N'Garson')
INSERT [dbo].[servisturu] ([ID], [SERVISADI], [ACIKLAMA]) VALUES (3, N'Aşçı                                              ', N'Aşçı')
SET IDENTITY_INSERT [dbo].[servisturu] OFF
SET IDENTITY_INSERT [dbo].[urunler] ON 

INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (1, 1, N'mercimek çorbası                                                                                    ', N'', 3.5000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (2, 1, N'ezogelin çorbası                                                                                    ', N'-', 4.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (3, 1, N'domates çorbası                                                                                     ', N'-', 4.5000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (4, 1, N'analıkızlı çorbası                                                                                  ', N'-', NULL, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (5, 1, N'yayla çorbası                                                                                       ', N'-', NULL, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (6, 2, N'tas kebabı                                                                                          ', N'-', 15.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (7, 2, N'Fırında Patates                                                                                     ', N'-', 10.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (8, 2, N'Tavuk sote                                                                                          ', N'-', 7.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (9, 2, N'Beyti Kebabı                                                                                        ', N'-', 17.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (10, 2, N'Hindi                                                                                               ', N'-', 20.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (11, 3, N'patates kızartması                                                                                  ', N'-', 5.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (12, 3, N'hamburger                                                                                           ', N'-', 15.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (13, 3, N'cheeseburger                                                                     chesee burger      ', N'-', 13.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (14, 3, N'chicken burger                                                                                      ', N'-', 13.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (15, 3, N'kanat kızartma                                                                                      ', N'-', 11.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (16, 4, N'kola                                                                                                ', N'-', 5.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (17, 4, N'meyve suyu                                                                                          ', N'-', 4.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (18, 4, N'nektar                                                                                              ', N'-', 4.5000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (19, 4, N'gazoz                                                                                               ', N'-', 3.5000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (20, 4, N'ıce tea                                                                                             ', N'-', 3.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (21, 5, N'baklava                                                                                             ', N'-', 6.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (22, 5, N'tiriliçe                                                                                            ', N'-', 6.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (23, 5, N'kadayıf                                                                                             ', N'-', 6.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (24, 5, N'tavuk göğsü                                                                                         ', N'-', 6.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (25, 5, N'tulumba                                                                                             ', N'-', 6.0000, 0)
INSERT [dbo].[urunler] ([ID], [KATEGORIID], [URUNAD], [ACIKLAMA], [FIYAT], [DURUM]) VALUES (26, 5, N'muhallebi                                                                                           ', N'-', 6.0000, NULL)
SET IDENTITY_INSERT [dbo].[urunler] OFF
ALTER TABLE [dbo].[adisyonlar] ADD  CONSTRAINT [DF_adisyonlar_TARIH]  DEFAULT (getdate()) FOR [Tarih]
GO
ALTER TABLE [dbo].[adisyonlar] ADD  CONSTRAINT [DF_adisyonlar_DURUM]  DEFAULT ((0)) FOR [Durum]
GO
ALTER TABLE [dbo].[hesapOdemeleri] ADD  CONSTRAINT [DF_hesapOdemeleri_TARIH]  DEFAULT (getdate()) FOR [TARIH]
GO
ALTER TABLE [dbo].[hesapOdemeleri] ADD  CONSTRAINT [DF_hesapOdemeleri_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[kategoriler] ADD  CONSTRAINT [DF_kategoriler_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[masalar] ADD  CONSTRAINT [DF_masalar_DURUM]  DEFAULT ((1)) FOR [DURUM]
GO
ALTER TABLE [dbo].[masalar] ADD  CONSTRAINT [DF_masalar_ONAY]  DEFAULT ((0)) FOR [ONAY]
GO
ALTER TABLE [dbo].[musteriler] ADD  CONSTRAINT [DF_musteriler_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[odemeTurleri] ADD  CONSTRAINT [DF_odemeTurleri_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[paketSiparis] ADD  CONSTRAINT [DF_paketSiparis_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[personelGorevleri] ADD  CONSTRAINT [DF_personelGorevleri_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[personelHareketleri] ADD  CONSTRAINT [DF_personelhareketleri_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[personeller] ADD  CONSTRAINT [DF_personeller_DURUM]  DEFAULT ((0)) FOR [DURUM]
GO
ALTER TABLE [dbo].[adisyonlar]  WITH CHECK ADD  CONSTRAINT [FK_adisyonlar_personeller] FOREIGN KEY([PersonelID])
REFERENCES [dbo].[personeller] ([ID])
GO
ALTER TABLE [dbo].[adisyonlar] CHECK CONSTRAINT [FK_adisyonlar_personeller]
GO
ALTER TABLE [dbo].[adisyonlar]  WITH CHECK ADD  CONSTRAINT [FK_adisyonlar_servisTuru] FOREIGN KEY([ServisTurNo])
REFERENCES [dbo].[servisturu] ([ID])
GO
ALTER TABLE [dbo].[adisyonlar] CHECK CONSTRAINT [FK_adisyonlar_servisTuru]
GO
ALTER TABLE [dbo].[hesapOdemeleri]  WITH CHECK ADD  CONSTRAINT [FK_hesapOdemeleri_adisyonlar] FOREIGN KEY([ADISYONID])
REFERENCES [dbo].[adisyonlar] ([ID])
GO
ALTER TABLE [dbo].[hesapOdemeleri] CHECK CONSTRAINT [FK_hesapOdemeleri_adisyonlar]
GO
ALTER TABLE [dbo].[hesapOdemeleri]  WITH CHECK ADD  CONSTRAINT [FK_hesapOdemeleri_musteriler] FOREIGN KEY([MUSTERIID])
REFERENCES [dbo].[musteriler] ([ID])
GO
ALTER TABLE [dbo].[hesapOdemeleri] CHECK CONSTRAINT [FK_hesapOdemeleri_musteriler]
GO
ALTER TABLE [dbo].[hesapOdemeleri]  WITH CHECK ADD  CONSTRAINT [FK_hesapOdemeleri_odemeTurleri] FOREIGN KEY([ODEMETURID])
REFERENCES [dbo].[odemeTurleri] ([ID])
GO
ALTER TABLE [dbo].[hesapOdemeleri] CHECK CONSTRAINT [FK_hesapOdemeleri_odemeTurleri]
GO
ALTER TABLE [dbo].[paketSiparis]  WITH CHECK ADD  CONSTRAINT [FK_paketSiparis_musteriler] FOREIGN KEY([MUSTERIID])
REFERENCES [dbo].[musteriler] ([ID])
GO
ALTER TABLE [dbo].[paketSiparis] CHECK CONSTRAINT [FK_paketSiparis_musteriler]
GO
ALTER TABLE [dbo].[paketSiparis]  WITH CHECK ADD  CONSTRAINT [FK_paketSiparis_odemeTurleri] FOREIGN KEY([ODEMETURU])
REFERENCES [dbo].[odemeTurleri] ([ID])
GO
ALTER TABLE [dbo].[paketSiparis] CHECK CONSTRAINT [FK_paketSiparis_odemeTurleri]
GO
ALTER TABLE [dbo].[personeller]  WITH CHECK ADD  CONSTRAINT [FK_personeller_personelGorevleri] FOREIGN KEY([GOREVID])
REFERENCES [dbo].[personelGorevleri] ([ID])
GO
ALTER TABLE [dbo].[personeller] CHECK CONSTRAINT [FK_personeller_personelGorevleri]
GO
ALTER TABLE [dbo].[Rezervasyonlar]  WITH CHECK ADD  CONSTRAINT [FK_Rezervasyonlar_adisyonlar] FOREIGN KEY([ADISYONID])
REFERENCES [dbo].[adisyonlar] ([ID])
GO
ALTER TABLE [dbo].[Rezervasyonlar] CHECK CONSTRAINT [FK_Rezervasyonlar_adisyonlar]
GO
ALTER TABLE [dbo].[Rezervasyonlar]  WITH CHECK ADD  CONSTRAINT [FK_Rezervasyonlar_masalar] FOREIGN KEY([MASAID])
REFERENCES [dbo].[masalar] ([ID])
GO
ALTER TABLE [dbo].[Rezervasyonlar] CHECK CONSTRAINT [FK_Rezervasyonlar_masalar]
GO
ALTER TABLE [dbo].[satislar]  WITH CHECK ADD  CONSTRAINT [FK_satislar_adisyonlar] FOREIGN KEY([ADISYONID])
REFERENCES [dbo].[adisyonlar] ([ID])
GO
ALTER TABLE [dbo].[satislar] CHECK CONSTRAINT [FK_satislar_adisyonlar]
GO
ALTER TABLE [dbo].[satislar]  WITH CHECK ADD  CONSTRAINT [FK_satislar_urunler] FOREIGN KEY([URUNID])
REFERENCES [dbo].[urunler] ([ID])
GO
ALTER TABLE [dbo].[satislar] CHECK CONSTRAINT [FK_satislar_urunler]
GO
ALTER TABLE [dbo].[urunler]  WITH CHECK ADD  CONSTRAINT [FK_urunler_kategoriler] FOREIGN KEY([KATEGORIID])
REFERENCES [dbo].[kategoriler] ([ID])
GO
ALTER TABLE [dbo].[urunler] CHECK CONSTRAINT [FK_urunler_kategoriler]
GO
