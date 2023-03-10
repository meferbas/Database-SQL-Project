PGDMP                         z            sqlproje    15.0    15.0 l    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    25470    sqlproje    DATABASE     |   CREATE DATABASE sqlproje WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Turkish_Turkey.1254';
    DROP DATABASE sqlproje;
                postgres    false                        1255    40981    delete_ucretli()    FUNCTION     ?   CREATE FUNCTION public.delete_ucretli() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare
delete_ucretli_oyun integer;

begin
delete_ucretli_oyun:=old.oyunid;

delete from oyun where oyunid=delete_ucretli_oyun;


return new;

end;
$$;
 '   DROP FUNCTION public.delete_ucretli();
       public          postgres    false                       1255    40989    delete_ucretsiz()    FUNCTION     ?   CREATE FUNCTION public.delete_ucretsiz() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare
delete_ucretsiz_oyun integer;

begin
delete_ucretsiz_oyun:=old.oyunid;

delete from oyun where oyunid=delete_ucretsiz_oyun;


return new;

end;
$$;
 (   DROP FUNCTION public.delete_ucretsiz();
       public          postgres    false            ?            1255    40979    eklenenhesap()    FUNCTION     ?  CREATE FUNCTION public.eklenenhesap() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

	INSERT INTO eklenenhesap ("hesap","hesapadi", "hesapsoyadi","mail","oyunsayi","sayiarkadas","para","profil","magaza","destek","envanter","kutuphane")
		VALUES (NEW."hesapid", NEW."ad", NEW."soyad",NEW."mail",NEW."oyunlar",NEW."arkadaslar",NEW."bakiye",NEW."profilid",NEW."magazaid",NEW."destekid",NEW."envanterid",NEW."kutuphaneid");
		
RETURN NEW;
END;

$$;
 %   DROP FUNCTION public.eklenenhesap();
       public          postgres    false            ?            1255    32771    fiyatarttir()    FUNCTION       CREATE FUNCTION public.fiyatarttir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
tfiyat integer;
begin
tfiyat:=(select fiyat from oyun order by oyunid desc limit 1);
update oyunsiparis set toplamoyunfiyat=toplamoyunfiyat+tfiyat;
return new;
end;
$$;
 $   DROP FUNCTION public.fiyatarttir();
       public          postgres    false            ?            1255    32783 
   gbarttir()    FUNCTION     R  CREATE FUNCTION public.gbarttir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
gbtoplam integer;
begin
gbtoplam:=(select oyungb from oyun order by oyunid desc limit 1 );
update oyunsiparis set toplamgb=toplamgb+gbtoplam; --where OyunSiparisID = (select from oyunsiparis order by OyunSiparisID desc limit 1)
return new;
end;
$$;
 !   DROP FUNCTION public.gbarttir();
       public          postgres    false            ?            1255    25826    hesapgetir(character varying)    FUNCTION     8  CREATE FUNCTION public.hesapgetir(tmp character varying) RETURNS TABLE(hesapidsutun integer, hesapad character varying, hesapsoyad character varying, hesapmail character varying)
    LANGUAGE plpgsql
    AS $$
begin
	Return Query
	Select
	hesapid,
	ad,
	soyad,
	mail
	From
		hesap
	where
		ad like tmp;
end;
$$;
 8   DROP FUNCTION public.hesapgetir(tmp character varying);
       public          postgres    false            ?            1255    25821    indirim(double precision)    FUNCTION     ?   CREATE FUNCTION public.indirim(fiyat double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
begin
Fiyat:=Fiyat-Fiyat*0.2;
return Fiyat;
end;
$$;
 6   DROP FUNCTION public.indirim(fiyat double precision);
       public          postgres    false            ?            1255    32796    oyun_sayi_log()    FUNCTION     ?   CREATE FUNCTION public.oyun_sayi_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin
	INSERT INTO "hesaplog" ("hesap","oyunsayi")
 		values (new."hesapid",new."oyunlar");
	return new;
end;
$$;
 &   DROP FUNCTION public.oyun_sayi_log();
       public          postgres    false            ?            1255    32785    oyun_update()    FUNCTION     ?   CREATE FUNCTION public.oyun_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

begin
	INSERT INTO "oyunhesap" ("HesapID","oyunsayisi")
 		values (new."hesap",new."oyunsayi");
	return new;
end;
$$;
 $   DROP FUNCTION public.oyun_update();
       public          postgres    false            ?            1255    32777    oyunsayisiarttir()    FUNCTION     P  CREATE FUNCTION public.oyunsayisiarttir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
toplamoyunsayisi integer;
begin
toplamoyunsayisi:=(select count (*) from oyun);
update oyunsiparis set oyunsayisi=toplamoyunsayisi; --where OyunSiparisID = (select from oyunsiparis order by OyunSiparisID desc limit 1)
return new;
end;
$$;
 )   DROP FUNCTION public.oyunsayisiarttir();
       public          postgres    false                       1255    41003 '   puana_gore_oyun_getir(integer, integer)    FUNCTION     (  CREATE FUNCTION public.puana_gore_oyun_getir(len_from integer, len_to integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  puan_count integer;
begin
   select count(*) 
   into puan_count
   from oyun
   where oyunpuan between len_from and len_to;
   
   return puan_count;
end;
$$;
 N   DROP FUNCTION public.puana_gore_oyun_getir(len_from integer, len_to integer);
       public          postgres    false            ?            1255    40966    silinenhesap()    FUNCTION     ?  CREATE FUNCTION public.silinenhesap() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

	INSERT INTO silinenhesap ("hesap","hesapadi", "hesapsoyadi","mail","oyunsayi","sayiarkadas","para","profil","magaza","destek","envanter","kutuphane")
		VALUES (NEW."hesapid", NEW."ad", NEW."soyad",NEW."mail",NEW."oyunlar",NEW."arkadaslar",NEW."bakiye",NEW."profilid",NEW."magazaid",NEW."destekid",NEW."envanterid",NEW."kutuphaneid");
		
RETURN NEW;
END;

$$;
 %   DROP FUNCTION public.silinenhesap();
       public          postgres    false            ?            1255    25829 %   siparisadresigetir(character varying)    FUNCTION     _  CREATE FUNCTION public.siparisadresigetir(siparisadres character varying) RETURNS TABLE(idsiparis integer, siparisadi character varying, siparissoyadi character varying, siparisadresi character varying)
    LANGUAGE plpgsql
    AS $$
begin
	return query
	select
	siparisid,
	ad,
	soyad,
	adres
	from
	siparis
	where
	adres like siparisadres;
end;
$$;
 I   DROP FUNCTION public.siparisadresigetir(siparisadres character varying);
       public          postgres    false            ?            1259    25573    arkadas    TABLE     	  CREATE TABLE public.arkadas (
    "ArkadasID" integer NOT NULL,
    "CevrimiciArkadas" character varying(50),
    "CevrimdisiArkadas" character varying(50),
    "OyundaOlanlar" character varying(50),
    "GrupID" integer NOT NULL,
    "HesapID" integer NOT NULL
);
    DROP TABLE public.arkadas;
       public         heap    postgres    false            ?            1259    25578    destek    TABLE     ?   CREATE TABLE public.destek (
    "DestekID" integer NOT NULL,
    "TemsilciAdi" character varying(20) NOT NULL,
    "TemsilciDurumu" character varying(10) NOT NULL,
    "TemsilciSayisi" integer NOT NULL
);
    DROP TABLE public.destek;
       public         heap    postgres    false            ?            1259    40963    eklenenhesap    TABLE     ?  CREATE TABLE public.eklenenhesap (
    hesap integer NOT NULL,
    hesapadi character varying(50) NOT NULL,
    hesapsoyadi character varying(50) NOT NULL,
    mail character varying(100) NOT NULL,
    oyunsayi integer NOT NULL,
    sayiarkadas integer NOT NULL,
    para integer NOT NULL,
    profil integer NOT NULL,
    magaza integer NOT NULL,
    destek integer NOT NULL,
    envanter integer NOT NULL,
    kutuphane integer NOT NULL
);
     DROP TABLE public.eklenenhesap;
       public         heap    postgres    false            ?            1259    25583    envanter    TABLE     ?   CREATE TABLE public.envanter (
    "EnvanterID" integer NOT NULL,
    "ToplamDeger" integer,
    "OgeSayisi" integer,
    "Hediye" integer
);
    DROP TABLE public.envanter;
       public         heap    postgres    false            ?            1259    25588    envanteresya    TABLE     |   CREATE TABLE public.envanteresya (
    "EnvanterEsyaID" integer NOT NULL,
    "EsyaID" integer,
    "EnvanterID" integer
);
     DROP TABLE public.envanteresya;
       public         heap    postgres    false            ?            1259    25593    esya    TABLE     ?   CREATE TABLE public.esya (
    "EsyaID" integer NOT NULL,
    "EsyaAdi" character varying(30) NOT NULL,
    "Fiyat" integer,
    "PazarID" integer
);
    DROP TABLE public.esya;
       public         heap    postgres    false            ?            1259    25598    grup    TABLE     ?   CREATE TABLE public.grup (
    "GrupID" integer NOT NULL,
    "KisiSayisi" integer,
    "Yonetici" character varying(20) NOT NULL
);
    DROP TABLE public.grup;
       public         heap    postgres    false            ?            1259    25603    hesap    TABLE     ?  CREATE TABLE public.hesap (
    hesapid integer NOT NULL,
    ad character varying(20) NOT NULL,
    soyad character varying(20) NOT NULL,
    mail character varying(150) NOT NULL,
    oyunlar integer,
    arkadaslar integer,
    bakiye integer,
    profilid integer NOT NULL,
    magazaid integer NOT NULL,
    destekid integer NOT NULL,
    envanterid integer NOT NULL,
    kutuphaneid integer NOT NULL
);
    DROP TABLE public.hesap;
       public         heap    postgres    false            ?            1259    25608    kupon    TABLE     \   CREATE TABLE public.kupon (
    "KuponID" integer NOT NULL,
    "Yuzde" integer NOT NULL
);
    DROP TABLE public.kupon;
       public         heap    postgres    false            ?            1259    25613 	   kutuphane    TABLE     ?   CREATE TABLE public.kutuphane (
    "KutuphaneID" integer NOT NULL,
    "Oyunlar" character varying(50),
    "Yuklenenler" character varying(50),
    "OyunSayisi" integer
);
    DROP TABLE public.kutuphane;
       public         heap    postgres    false            ?            1259    25618    magaza    TABLE     ?   CREATE TABLE public.magaza (
    "MagazaID" integer NOT NULL,
    "OneCikanlar" character varying(50),
    "IndirimliOyun" character varying(20),
    "CokSatanlar" character varying(20)
);
    DROP TABLE public.magaza;
       public         heap    postgres    false            ?            1259    25623    oyun    TABLE     
  CREATE TABLE public.oyun (
    oyunid integer NOT NULL,
    oyunturu character varying(20) NOT NULL,
    oyunpuan integer,
    fiyat integer,
    elestiriler text NOT NULL,
    oyungb integer NOT NULL,
    sirketid integer NOT NULL,
    magazaid integer NOT NULL
);
    DROP TABLE public.oyun;
       public         heap    postgres    false            ?            1259    25630 	   oyunhesap    TABLE     ?   CREATE TABLE public.oyunhesap (
    "oyunhesapID" integer NOT NULL,
    "HesapID" integer NOT NULL,
    "OyunID" integer NOT NULL,
    oyunsayisi integer
);
    DROP TABLE public.oyunhesap;
       public         heap    postgres    false            ?            1259    25635    oyunkutuphanesi    TABLE     ?   CREATE TABLE public.oyunkutuphanesi (
    oyunkpid integer NOT NULL,
    "KutuphaneID" integer NOT NULL,
    "OyunID" integer NOT NULL
);
 #   DROP TABLE public.oyunkutuphanesi;
       public         heap    postgres    false            ?            1259    25640    oyunsiparis    TABLE     ?   CREATE TABLE public.oyunsiparis (
    "OyunSiparisID" integer NOT NULL,
    "SiparisID" integer,
    "OyunID" integer,
    oyunsayisi integer,
    toplamoyunfiyat integer,
    toplamgb integer
);
    DROP TABLE public.oyunsiparis;
       public         heap    postgres    false            ?            1259    25645    pazar    TABLE     ?   CREATE TABLE public.pazar (
    pazarid integer NOT NULL,
    esyasayisi integer,
    toplamfiyat integer,
    satistaolan character varying(10)
);
    DROP TABLE public.pazar;
       public         heap    postgres    false            ?            1259    25650    profil    TABLE     2  CREATE TABLE public.profil (
    "ProfilID" integer NOT NULL,
    "Durum" character varying(20) NOT NULL,
    "Hakkinda" character varying(100) NOT NULL,
    "Cinsiyet" character varying(5) NOT NULL,
    "Yas" integer NOT NULL,
    "Konum" character varying(20) NOT NULL,
    "PazarID" integer NOT NULL
);
    DROP TABLE public.profil;
       public         heap    postgres    false            ?            1259    25655    siparis    TABLE     ?   CREATE TABLE public.siparis (
    siparisid integer NOT NULL,
    kuponid integer,
    ad character varying(25),
    soyad character varying(25),
    adres character varying(100),
    oyunsayisi integer NOT NULL,
    tutar integer
);
    DROP TABLE public.siparis;
       public         heap    postgres    false            ?            1259    25660    sirket    TABLE     ?   CREATE TABLE public.sirket (
    "SirketID" integer NOT NULL,
    "Kurucu" character varying(20) NOT NULL,
    "CalisanSayisi" integer
);
    DROP TABLE public.sirket;
       public         heap    postgres    false            ?            1259    25765    ucretli    TABLE     ?   CREATE TABLE public.ucretli (
    oyunid integer NOT NULL,
    fiyat integer NOT NULL,
    tur character varying(20) NOT NULL,
    adi character varying(40) NOT NULL
);
    DROP TABLE public.ucretli;
       public         heap    postgres    false            ?            1259    25775    ucretsiz    TABLE     ?   CREATE TABLE public.ucretsiz (
    oyunid integer NOT NULL,
    tur character varying(20) NOT NULL,
    adi character varying(20) NOT NULL
);
    DROP TABLE public.ucretsiz;
       public         heap    postgres    false            ?          0    25573    arkadas 
   TABLE DATA           }   COPY public.arkadas ("ArkadasID", "CevrimiciArkadas", "CevrimdisiArkadas", "OyundaOlanlar", "GrupID", "HesapID") FROM stdin;
    public          postgres    false    214   ??       ?          0    25578    destek 
   TABLE DATA           _   COPY public.destek ("DestekID", "TemsilciAdi", "TemsilciDurumu", "TemsilciSayisi") FROM stdin;
    public          postgres    false    215   S?       ?          0    40963    eklenenhesap 
   TABLE DATA           ?   COPY public.eklenenhesap (hesap, hesapadi, hesapsoyadi, mail, oyunsayi, sayiarkadas, para, profil, magaza, destek, envanter, kutuphane) FROM stdin;
    public          postgres    false    234   ??       ?          0    25583    envanter 
   TABLE DATA           V   COPY public.envanter ("EnvanterID", "ToplamDeger", "OgeSayisi", "Hediye") FROM stdin;
    public          postgres    false    216   Ǐ       ?          0    25588    envanteresya 
   TABLE DATA           P   COPY public.envanteresya ("EnvanterEsyaID", "EsyaID", "EnvanterID") FROM stdin;
    public          postgres    false    217   ?       ?          0    25593    esya 
   TABLE DATA           G   COPY public.esya ("EsyaID", "EsyaAdi", "Fiyat", "PazarID") FROM stdin;
    public          postgres    false    218   C?       ?          0    25598    grup 
   TABLE DATA           B   COPY public.grup ("GrupID", "KisiSayisi", "Yonetici") FROM stdin;
    public          postgres    false    219   ??       ?          0    25603    hesap 
   TABLE DATA           ?   COPY public.hesap (hesapid, ad, soyad, mail, oyunlar, arkadaslar, bakiye, profilid, magazaid, destekid, envanterid, kutuphaneid) FROM stdin;
    public          postgres    false    220   ??       ?          0    25608    kupon 
   TABLE DATA           3   COPY public.kupon ("KuponID", "Yuzde") FROM stdin;
    public          postgres    false    221   ??       ?          0    25613 	   kutuphane 
   TABLE DATA           Z   COPY public.kutuphane ("KutuphaneID", "Oyunlar", "Yuklenenler", "OyunSayisi") FROM stdin;
    public          postgres    false    222   ܑ       ?          0    25618    magaza 
   TABLE DATA           [   COPY public.magaza ("MagazaID", "OneCikanlar", "IndirimliOyun", "CokSatanlar") FROM stdin;
    public          postgres    false    223   X?       ?          0    25623    oyun 
   TABLE DATA           j   COPY public.oyun (oyunid, oyunturu, oyunpuan, fiyat, elestiriler, oyungb, sirketid, magazaid) FROM stdin;
    public          postgres    false    224   ϒ       ?          0    25630 	   oyunhesap 
   TABLE DATA           S   COPY public.oyunhesap ("oyunhesapID", "HesapID", "OyunID", oyunsayisi) FROM stdin;
    public          postgres    false    225   ??       ?          0    25635    oyunkutuphanesi 
   TABLE DATA           L   COPY public.oyunkutuphanesi (oyunkpid, "KutuphaneID", "OyunID") FROM stdin;
    public          postgres    false    226   ??       ?          0    25640    oyunsiparis 
   TABLE DATA           t   COPY public.oyunsiparis ("OyunSiparisID", "SiparisID", "OyunID", oyunsayisi, toplamoyunfiyat, toplamgb) FROM stdin;
    public          postgres    false    227   ?       ?          0    25645    pazar 
   TABLE DATA           N   COPY public.pazar (pazarid, esyasayisi, toplamfiyat, satistaolan) FROM stdin;
    public          postgres    false    228   R?       ?          0    25650    profil 
   TABLE DATA           h   COPY public.profil ("ProfilID", "Durum", "Hakkinda", "Cinsiyet", "Yas", "Konum", "PazarID") FROM stdin;
    public          postgres    false    229   ??       ?          0    25655    siparis 
   TABLE DATA           Z   COPY public.siparis (siparisid, kuponid, ad, soyad, adres, oyunsayisi, tutar) FROM stdin;
    public          postgres    false    230   u?       ?          0    25660    sirket 
   TABLE DATA           G   COPY public.sirket ("SirketID", "Kurucu", "CalisanSayisi") FROM stdin;
    public          postgres    false    231   ??       ?          0    25765    ucretli 
   TABLE DATA           :   COPY public.ucretli (oyunid, fiyat, tur, adi) FROM stdin;
    public          postgres    false    232   8?       ?          0    25775    ucretsiz 
   TABLE DATA           4   COPY public.ucretsiz (oyunid, tur, adi) FROM stdin;
    public          postgres    false    233   ??       ?           2606    25577    arkadas arkadas_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.arkadas
    ADD CONSTRAINT arkadas_pkey PRIMARY KEY ("ArkadasID");
 >   ALTER TABLE ONLY public.arkadas DROP CONSTRAINT arkadas_pkey;
       public            postgres    false    214            ?           2606    25582    destek destek_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.destek
    ADD CONSTRAINT destek_pkey PRIMARY KEY ("DestekID");
 <   ALTER TABLE ONLY public.destek DROP CONSTRAINT destek_pkey;
       public            postgres    false    215            ?           2606    25587    envanter envanter_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.envanter
    ADD CONSTRAINT envanter_pkey PRIMARY KEY ("EnvanterID");
 @   ALTER TABLE ONLY public.envanter DROP CONSTRAINT envanter_pkey;
       public            postgres    false    216            ?           2606    25592    envanteresya envanteresya_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.envanteresya
    ADD CONSTRAINT envanteresya_pkey PRIMARY KEY ("EnvanterEsyaID");
 H   ALTER TABLE ONLY public.envanteresya DROP CONSTRAINT envanteresya_pkey;
       public            postgres    false    217            ?           2606    25597    esya esya_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.esya
    ADD CONSTRAINT esya_pkey PRIMARY KEY ("EsyaID");
 8   ALTER TABLE ONLY public.esya DROP CONSTRAINT esya_pkey;
       public            postgres    false    218            ?           2606    25602    grup grup_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.grup
    ADD CONSTRAINT grup_pkey PRIMARY KEY ("GrupID");
 8   ALTER TABLE ONLY public.grup DROP CONSTRAINT grup_pkey;
       public            postgres    false    219            ?           2606    25607    hesap hesap_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT hesap_pkey PRIMARY KEY (hesapid);
 :   ALTER TABLE ONLY public.hesap DROP CONSTRAINT hesap_pkey;
       public            postgres    false    220            ?           2606    25612    kupon kupon_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.kupon
    ADD CONSTRAINT kupon_pkey PRIMARY KEY ("KuponID");
 :   ALTER TABLE ONLY public.kupon DROP CONSTRAINT kupon_pkey;
       public            postgres    false    221            ?           2606    25617    kutuphane kutuphane_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.kutuphane
    ADD CONSTRAINT kutuphane_pkey PRIMARY KEY ("KutuphaneID");
 B   ALTER TABLE ONLY public.kutuphane DROP CONSTRAINT kutuphane_pkey;
       public            postgres    false    222            ?           2606    25622    magaza magaza_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.magaza
    ADD CONSTRAINT magaza_pkey PRIMARY KEY ("MagazaID");
 <   ALTER TABLE ONLY public.magaza DROP CONSTRAINT magaza_pkey;
       public            postgres    false    223            ?           2606    25629    oyun oyun_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.oyun
    ADD CONSTRAINT oyun_pkey PRIMARY KEY (oyunid);
 8   ALTER TABLE ONLY public.oyun DROP CONSTRAINT oyun_pkey;
       public            postgres    false    224            ?           2606    25634    oyunhesap oyunhesap_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.oyunhesap
    ADD CONSTRAINT oyunhesap_pkey PRIMARY KEY ("oyunhesapID");
 B   ALTER TABLE ONLY public.oyunhesap DROP CONSTRAINT oyunhesap_pkey;
       public            postgres    false    225            ?           2606    25639 $   oyunkutuphanesi oyunkutuphanesi_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.oyunkutuphanesi
    ADD CONSTRAINT oyunkutuphanesi_pkey PRIMARY KEY (oyunkpid);
 N   ALTER TABLE ONLY public.oyunkutuphanesi DROP CONSTRAINT oyunkutuphanesi_pkey;
       public            postgres    false    226            ?           2606    25644    oyunsiparis oyunsiparis_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.oyunsiparis
    ADD CONSTRAINT oyunsiparis_pkey PRIMARY KEY ("OyunSiparisID");
 F   ALTER TABLE ONLY public.oyunsiparis DROP CONSTRAINT oyunsiparis_pkey;
       public            postgres    false    227            ?           2606    25649    pazar pazar_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.pazar
    ADD CONSTRAINT pazar_pkey PRIMARY KEY (pazarid);
 :   ALTER TABLE ONLY public.pazar DROP CONSTRAINT pazar_pkey;
       public            postgres    false    228            ?           2606    25654    profil profil_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.profil
    ADD CONSTRAINT profil_pkey PRIMARY KEY ("ProfilID");
 <   ALTER TABLE ONLY public.profil DROP CONSTRAINT profil_pkey;
       public            postgres    false    229            ?           2606    25659    siparis siparis_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT siparis_pkey PRIMARY KEY (siparisid);
 >   ALTER TABLE ONLY public.siparis DROP CONSTRAINT siparis_pkey;
       public            postgres    false    230            ?           2606    25664    sirket sirket_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.sirket
    ADD CONSTRAINT sirket_pkey PRIMARY KEY ("SirketID");
 <   ALTER TABLE ONLY public.sirket DROP CONSTRAINT sirket_pkey;
       public            postgres    false    231            ?           2606    25769    ucretli ucretli_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.ucretli
    ADD CONSTRAINT ucretli_pkey PRIMARY KEY (oyunid);
 >   ALTER TABLE ONLY public.ucretli DROP CONSTRAINT ucretli_pkey;
       public            postgres    false    232            ?           2606    25779    ucretsiz ucretsiz_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.ucretsiz
    ADD CONSTRAINT ucretsiz_pkey PRIMARY KEY (oyunid);
 @   ALTER TABLE ONLY public.ucretsiz DROP CONSTRAINT ucretsiz_pkey;
       public            postgres    false    233            ?           1259    25790    fki_ucretli_fk    INDEX     D   CREATE INDEX fki_ucretli_fk ON public.ucretli USING btree (oyunid);
 "   DROP INDEX public.fki_ucretli_fk;
       public            postgres    false    232                       2620    40988    ucretli delete_ucretli_trig    TRIGGER     y   CREATE TRIGGER delete_ucretli_trig AFTER DELETE ON public.ucretli FOR EACH ROW EXECUTE FUNCTION public.delete_ucretli();
 4   DROP TRIGGER delete_ucretli_trig ON public.ucretli;
       public          postgres    false    256    232                       2620    40992    ucretsiz delete_ucretsiz_trig    TRIGGER     |   CREATE TRIGGER delete_ucretsiz_trig AFTER DELETE ON public.ucretsiz FOR EACH ROW EXECUTE FUNCTION public.delete_ucretsiz();
 6   DROP TRIGGER delete_ucretsiz_trig ON public.ucretsiz;
       public          postgres    false    233    257                       2620    32776    oyun trigfiyatarttir    TRIGGER     o   CREATE TRIGGER trigfiyatarttir AFTER INSERT ON public.oyun FOR EACH ROW EXECUTE FUNCTION public.fiyatarttir();
 -   DROP TRIGGER trigfiyatarttir ON public.oyun;
       public          postgres    false    238    224                       2620    32784    oyun triggbarttir    TRIGGER     i   CREATE TRIGGER triggbarttir AFTER INSERT ON public.oyun FOR EACH ROW EXECUTE FUNCTION public.gbarttir();
 *   DROP TRIGGER triggbarttir ON public.oyun;
       public          postgres    false    240    224                        2620    40980    hesap triggereklenen    TRIGGER     p   CREATE TRIGGER triggereklenen AFTER INSERT ON public.hesap FOR EACH ROW EXECUTE FUNCTION public.eklenenhesap();
 -   DROP TRIGGER triggereklenen ON public.hesap;
       public          postgres    false    255    220                       2620    32782    oyun trigoyunarttir    TRIGGER     s   CREATE TRIGGER trigoyunarttir AFTER INSERT ON public.oyun FOR EACH ROW EXECUTE FUNCTION public.oyunsayisiarttir();
 ,   DROP TRIGGER trigoyunarttir ON public.oyun;
       public          postgres    false    239    224            ?           2606    25665    arkadas FK_arkadas.GrupID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.arkadas
    ADD CONSTRAINT "FK_arkadas.GrupID" FOREIGN KEY ("GrupID") REFERENCES public.grup("GrupID");
 E   ALTER TABLE ONLY public.arkadas DROP CONSTRAINT "FK_arkadas.GrupID";
       public          postgres    false    3276    219    214            ?           2606    25670    arkadas FK_arkadas.HesapID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.arkadas
    ADD CONSTRAINT "FK_arkadas.HesapID" FOREIGN KEY ("HesapID") REFERENCES public.hesap(hesapid);
 F   ALTER TABLE ONLY public.arkadas DROP CONSTRAINT "FK_arkadas.HesapID";
       public          postgres    false    3278    220    214            ?           2606    25675 '   envanteresya FK_envanteresya.EnvanterID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.envanteresya
    ADD CONSTRAINT "FK_envanteresya.EnvanterID" FOREIGN KEY ("EnvanterID") REFERENCES public.envanter("EnvanterID");
 S   ALTER TABLE ONLY public.envanteresya DROP CONSTRAINT "FK_envanteresya.EnvanterID";
       public          postgres    false    216    3270    217            ?           2606    25680 #   envanteresya FK_envanteresya.EsyaID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.envanteresya
    ADD CONSTRAINT "FK_envanteresya.EsyaID" FOREIGN KEY ("EsyaID") REFERENCES public.esya("EsyaID");
 O   ALTER TABLE ONLY public.envanteresya DROP CONSTRAINT "FK_envanteresya.EsyaID";
       public          postgres    false    218    3274    217            ?           2606    25685    esya FK_esya.PazarID    FK CONSTRAINT     |   ALTER TABLE ONLY public.esya
    ADD CONSTRAINT "FK_esya.PazarID" FOREIGN KEY ("PazarID") REFERENCES public.pazar(pazarid);
 @   ALTER TABLE ONLY public.esya DROP CONSTRAINT "FK_esya.PazarID";
       public          postgres    false    218    3294    228            ?           2606    25690    hesap FK_hesap.DestekID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT "FK_hesap.DestekID" FOREIGN KEY (destekid) REFERENCES public.destek("DestekID");
 C   ALTER TABLE ONLY public.hesap DROP CONSTRAINT "FK_hesap.DestekID";
       public          postgres    false    215    3268    220            ?           2606    25695    hesap FK_hesap.EnvanterID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT "FK_hesap.EnvanterID" FOREIGN KEY (envanterid) REFERENCES public.envanter("EnvanterID");
 E   ALTER TABLE ONLY public.hesap DROP CONSTRAINT "FK_hesap.EnvanterID";
       public          postgres    false    220    216    3270            ?           2606    25700    hesap FK_hesap.KutuphaneID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT "FK_hesap.KutuphaneID" FOREIGN KEY (kutuphaneid) REFERENCES public.kutuphane("KutuphaneID");
 F   ALTER TABLE ONLY public.hesap DROP CONSTRAINT "FK_hesap.KutuphaneID";
       public          postgres    false    222    3282    220            ?           2606    25705    hesap FK_hesap.MagazaID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT "FK_hesap.MagazaID" FOREIGN KEY (magazaid) REFERENCES public.magaza("MagazaID");
 C   ALTER TABLE ONLY public.hesap DROP CONSTRAINT "FK_hesap.MagazaID";
       public          postgres    false    220    3284    223            ?           2606    25710    hesap FK_hesap.ProfilID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hesap
    ADD CONSTRAINT "FK_hesap.ProfilID" FOREIGN KEY (profilid) REFERENCES public.profil("ProfilID");
 C   ALTER TABLE ONLY public.hesap DROP CONSTRAINT "FK_hesap.ProfilID";
       public          postgres    false    220    3296    229            ?           2606    25715    oyun FK_oyun.MagazaID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyun
    ADD CONSTRAINT "FK_oyun.MagazaID" FOREIGN KEY (magazaid) REFERENCES public.magaza("MagazaID");
 A   ALTER TABLE ONLY public.oyun DROP CONSTRAINT "FK_oyun.MagazaID";
       public          postgres    false    224    3284    223            ?           2606    25720    oyun FK_oyun.SirketID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyun
    ADD CONSTRAINT "FK_oyun.SirketID" FOREIGN KEY (sirketid) REFERENCES public.sirket("SirketID");
 A   ALTER TABLE ONLY public.oyun DROP CONSTRAINT "FK_oyun.SirketID";
       public          postgres    false    224    3300    231            ?           2606    25725    oyunhesap FK_oyunhesap.HesapID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyunhesap
    ADD CONSTRAINT "FK_oyunhesap.HesapID" FOREIGN KEY ("HesapID") REFERENCES public.hesap(hesapid);
 J   ALTER TABLE ONLY public.oyunhesap DROP CONSTRAINT "FK_oyunhesap.HesapID";
       public          postgres    false    225    3278    220            ?           2606    25730    oyunhesap FK_oyunhesap.OyunID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyunhesap
    ADD CONSTRAINT "FK_oyunhesap.OyunID" FOREIGN KEY ("OyunID") REFERENCES public.oyun(oyunid);
 I   ALTER TABLE ONLY public.oyunhesap DROP CONSTRAINT "FK_oyunhesap.OyunID";
       public          postgres    false    3286    224    225            ?           2606    25735 .   oyunkutuphanesi FK_oyunkutuphanesi.KutuphaneID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyunkutuphanesi
    ADD CONSTRAINT "FK_oyunkutuphanesi.KutuphaneID" FOREIGN KEY ("KutuphaneID") REFERENCES public.kutuphane("KutuphaneID");
 Z   ALTER TABLE ONLY public.oyunkutuphanesi DROP CONSTRAINT "FK_oyunkutuphanesi.KutuphaneID";
       public          postgres    false    3282    226    222            ?           2606    25740 )   oyunkutuphanesi FK_oyunkutuphanesi.OyunID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyunkutuphanesi
    ADD CONSTRAINT "FK_oyunkutuphanesi.OyunID" FOREIGN KEY ("OyunID") REFERENCES public.oyun(oyunid);
 U   ALTER TABLE ONLY public.oyunkutuphanesi DROP CONSTRAINT "FK_oyunkutuphanesi.OyunID";
       public          postgres    false    3286    226    224            ?           2606    25745 !   oyunsiparis FK_oyunsiparis.OyunID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyunsiparis
    ADD CONSTRAINT "FK_oyunsiparis.OyunID" FOREIGN KEY ("OyunID") REFERENCES public.oyun(oyunid);
 M   ALTER TABLE ONLY public.oyunsiparis DROP CONSTRAINT "FK_oyunsiparis.OyunID";
       public          postgres    false    227    3286    224            ?           2606    25750 $   oyunsiparis FK_oyunsiparis.SiparisID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.oyunsiparis
    ADD CONSTRAINT "FK_oyunsiparis.SiparisID" FOREIGN KEY ("SiparisID") REFERENCES public.siparis(siparisid);
 P   ALTER TABLE ONLY public.oyunsiparis DROP CONSTRAINT "FK_oyunsiparis.SiparisID";
       public          postgres    false    227    3298    230            ?           2606    25755    profil FK_profil.PazarID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.profil
    ADD CONSTRAINT "FK_profil.PazarID" FOREIGN KEY ("PazarID") REFERENCES public.pazar(pazarid);
 D   ALTER TABLE ONLY public.profil DROP CONSTRAINT "FK_profil.PazarID";
       public          postgres    false    229    3294    228            ?           2606    25760    siparis FK_siparis.KuponID    FK CONSTRAINT     ?   ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT "FK_siparis.KuponID" FOREIGN KEY (kuponid) REFERENCES public.kupon("KuponID");
 F   ALTER TABLE ONLY public.siparis DROP CONSTRAINT "FK_siparis.KuponID";
       public          postgres    false    221    230    3280            ?           2606    25770    ucretli ucretli_OyunID_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.ucretli
    ADD CONSTRAINT "ucretli_OyunID_fkey" FOREIGN KEY (oyunid) REFERENCES public.oyun(oyunid);
 G   ALTER TABLE ONLY public.ucretli DROP CONSTRAINT "ucretli_OyunID_fkey";
       public          postgres    false    224    3286    232            ?           2606    25780    ucretsiz ucretsiz_OyunID_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.ucretsiz
    ADD CONSTRAINT "ucretsiz_OyunID_fkey" FOREIGN KEY (oyunid) REFERENCES public.oyun(oyunid);
 I   ALTER TABLE ONLY public.ucretsiz DROP CONSTRAINT "ucretsiz_OyunID_fkey";
       public          postgres    false    224    233    3286            ?   ?   x?-?K
?0????"_?}???E?&?_&Q???7?o??pe?w)?V5()j??6?? CF9:?z??<Z^?x?fR?-.??9????ߘ?6?;{?V?8(??C?T???1?]?KT;???%J?P??ӟ??R?xs???F?M?*z???,I:?      ?   G   x?3?N-?N???--N?,?4?2?tI?ˬBs???*1?t?<:???7?8?4(`
df䦖 ???qqq )4K      ?      x?????? ? ?      ?   7   x???	 0??]1?3
?K??#&??e??C6[H??|ꜞ*????<??e?      ?   %   x?3?4?4?2?4?4?2?4?4?2?4?4?????? 4?z      ?   >   x?3?????L?440?4?2?L?LN??47?4?2?,??I??4ɘpVeep9?\1z\\\ ???      ?   E   x?3?4?,H???+.?2?4?L-J?OO??2?4?,.?I??rL8M9S?R?L9?9sK3ssSK?b???? 1?      ?   ?   x?U??
?0Dϓ??????C??`???ƠA??M?~}?J??`?Y?1).??#n??T???O?\?S??t??d?;?4?$
_?N?8O????????=bA?2?b8_+??ڴ$???Z?{??n?CpĒ?0???????W?G??۷fJ??ZE?%?RY7y?1#?5?y?ϩ._F`??1??`P?      ?   !   x?3?44?2?46?2?45?2??0?????? ,KP      ?   l   x?u?1
?@??:9EN?8??x?`R?F2A<??`????%pe!?p]?(?R??ӈv????S????,?!?f??ǛpqO豇࣐x??I?e?IND<?]0?      ?   g   x?%?K
A?/????M?$mC?H:*x?i?U?-$??	?bX???c???tK??cL?:?T<???????S]???=??B???W?ZW?=??D?Ю(      ?   ?   x?e?Q?0D?gO?	L???w??Ċ,
&??-F?1??y3?]?,i????F??3??~?k?`??|?؃?aZVx?5?????N?!?=,Y?4ͷ^=?RI^?
%???Z?.a?!?y?#v??*?ֹ_5ռ~?J????.?????zmbI?o?ې????޽?????e#Y?m|Y??c??>?)???V??P??+??㎈?ׄV7      ?   0   x?3?4A.#N ?،˘??0??2?42L?L9?Aj?b???? ??,      ?      x?3?4?4?2?4?ƜF@2F??? !??      ?   )   x?3?4AcN#cCSNc.#NcNK ??E$F??? ??z      ?   T   x??=? ???aL???a\Ih ?y+????o^?1???.?!PF[???)@?X#㱞*E?ജ	? ???F?c#?n?/      ?   ?   x?U?[
?0E?'??
??-ڽ?3MF	yI???MK??7?q??X?
??$sK?K?+5J??$?]*?<?0z,A	K?wk????^2???x??=?Rh1@$~??????|?r??7h??b????
>?/?t?-?I~???(Z?6ՖK?G??-'???"??ڹV?      ?   ^   x??I? ?????!?M+D	?aX??e]y%!??1چ??Q?syR@???M??-?
?6NGؠG????q-?W?|?????n?      ?   E   x?3??M??M-?4?2??-?H?q??9?R??+?l.ΔԼ?*NCK.S??Ĕ?"N3K?=... Pq?      ?   W   x???? ???N`??8?b??B????N/"8?sf{??5??S????FRt??RP???:???????H?z???u?u$???      ?   8   x?3????/*H?L?/I䲄?rSK2???M`??)\?????ř??y?1z\\\ ???     