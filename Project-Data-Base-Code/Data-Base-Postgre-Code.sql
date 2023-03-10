PGDMP                         z            Data_Base_Project    14.5    14.5 v    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16441    Data_Base_Project    DATABASE     p   CREATE DATABASE "Data_Base_Project" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';
 #   DROP DATABASE "Data_Base_Project";
                postgres    false            ?            1255    24710    delete_oyuncu()    FUNCTION     *  CREATE FUNCTION public.delete_oyuncu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
delete_oyuncu_id integer;


begin

delete_oyuncu_id:=old."Kisi_Id";

delete from "Oyuncular" where "Kisi_Id"=delete_oyuncu_id;
delete from "Kisiler" where "Kisi_Id"=delete_oyuncu_id;

return new;
end;$$;
 &   DROP FUNCTION public.delete_oyuncu();
       public          postgres    false            ?            1255    24712    delete_yonetmen()    FUNCTION     5  CREATE FUNCTION public.delete_yonetmen() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
delete_yonetmen_id integer;


begin

delete_yonetmen_id:=old."Kisi_Id";

delete from "Kisiler" where "Kisi_Id"=delete_yonetmen_id;

return new;
end;
--on "Yonetmen" tablosundan silinince "Kisilerde" de silinir$$;
 (   DROP FUNCTION public.delete_yonetmen();
       public          postgres    false            ?            1255    16742    dizi_getir(integer)    FUNCTION     ?   CREATE FUNCTION public.dizi_getir(prmt integer) RETURNS TABLE(id integer, dizi_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY SELECT "Liste_Id", "Dizi_Adı" FROM "Diziler"
    WHERE "Liste_Id" = prmt;
END;
$$;
 /   DROP FUNCTION public.dizi_getir(prmt integer);
       public          postgres    false            ?            1255    16737    dizi_sayisi()    FUNCTION     ?   CREATE FUNCTION public.dizi_sayisi() RETURNS double precision
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
begin

total:=(select count("Dizi_ıd") from "Diziler");
return total;
end;
$$;
 $   DROP FUNCTION public.dizi_sayisi();
       public          postgres    false            ?            1255    16744    en_yuksek_rating_dizi()    FUNCTION       CREATE FUNCTION public.en_yuksek_rating_dizi() RETURNS TABLE(id integer, dizi_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY select max("Rating_Puan"),"Dizi_Adı" from "Diziler" group by "Dizi_Adı" having max("Rating_Puan")>8;
END;
$$;
 .   DROP FUNCTION public.en_yuksek_rating_dizi();
       public          postgres    false            ?            1255    16752    en_yuksek_rating_film()    FUNCTION       CREATE FUNCTION public.en_yuksek_rating_film() RETURNS TABLE(id integer, film_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY select max("Rating_Puan"),"Film_Adı" from "Filmler" group by "Film_Adı" having max("Rating_Puan")>9;
END;
$$;
 .   DROP FUNCTION public.en_yuksek_rating_film();
       public          postgres    false            ?            1255    16755    film_getir(integer)    FUNCTION     ?   CREATE FUNCTION public.film_getir(fprmt integer) RETURNS TABLE(id integer, film_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY SELECT "Liste_Id", "Film_Adı" FROM "Filmler"
    WHERE "Liste_Id" = fprmt;
END;
$$;
 0   DROP FUNCTION public.film_getir(fprmt integer);
       public          postgres    false            ?            1255    16751    film_sayisi()    FUNCTION     ?   CREATE FUNCTION public.film_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total_film integer;
begin

total_film:=(select count("Film_Id") from "Filmler");
return total_film;
end;
$$;
 $   DROP FUNCTION public.film_sayisi();
       public          postgres    false            ?            1255    24714    insert_kisi()    FUNCTION       CREATE FUNCTION public.insert_kisi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare
insert_kisi_id integer;
insert_kisi_kategori varchar;


begin
insert_kisi_id:=new."Kisi_Id";
insert_kisi_kategori:=new."Kisi_Kategori";


if(insert_kisi_kategori='Oyuncu') then
insert into "Oyuncular" values(insert_kisi_id,'Dizi');

end if;

if(insert_kisi_kategori='Yonetmen') then
insert into "Yonetmen" values(insert_kisi_id);

end if;
return old;

end;

-- "Kisilere" ekleme yağıldığında "Oyuncu" ve "Yonetmen" tablosuna ekleme yapar
$$;
 $   DROP FUNCTION public.insert_kisi();
       public          postgres    false            ?            1255    16747    oyuncu_sayisi_getir()    FUNCTION       CREATE FUNCTION public.oyuncu_sayisi_getir() RETURNS TABLE(toplam_oyuncu bigint, kategori character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY select count("Oyuncu_Kategori"),"Oyuncu_Kategori" from "Oyuncular" group by "Oyuncu_Kategori";
END;
$$;
 ,   DROP FUNCTION public.oyuncu_sayisi_getir();
       public          postgres    false            ?            1255    24706    silinen_dizi()    FUNCTION     ?   CREATE FUNCTION public.silinen_dizi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into "silinen_Dizi" ("dizi_ıd","dizi_ad") values(OLD."Dizi_ıd",OLD."Dizi_Adı");
return new;
end;
$$;
 %   DROP FUNCTION public.silinen_dizi();
       public          postgres    false            ?            1255    24697    silinen_film()    FUNCTION     ?   CREATE FUNCTION public.silinen_film() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into "silinen_Film" (film_ıd,"film_ad") values(OLD."Film_Id",OLD."Film_Adı");
return new;
end;
$$;
 %   DROP FUNCTION public.silinen_film();
       public          postgres    false            ?            1259    16463 	   Acıklama    TABLE     s   CREATE TABLE public."Acıklama" (
    "Acıklama_Id" integer NOT NULL,
    "Acıklama_Icerik" character varying
);
    DROP TABLE public."Acıklama";
       public         heap    postgres    false            ?            1259    16536    Cekildigi_Yer    TABLE     x   CREATE TABLE public."Cekildigi_Yer" (
    "Sehir_Id" integer NOT NULL,
    "Sehir_Ad" character varying(15) NOT NULL
);
 #   DROP TABLE public."Cekildigi_Yer";
       public         heap    postgres    false            ?            1259    16531    Dizi_Oyuncu    TABLE     f   CREATE TABLE public."Dizi_Oyuncu" (
    "Dizi_Id" integer NOT NULL,
    "Kisi_Id" integer NOT NULL
);
 !   DROP TABLE public."Dizi_Oyuncu";
       public         heap    postgres    false            ?            1259    16487    Diziler    TABLE     ?  CREATE TABLE public."Diziler" (
    "Liste_Id" integer NOT NULL,
    "Dizi_Adı" character varying NOT NULL,
    "Kisi_Id" integer NOT NULL,
    "Fragman_Id" integer NOT NULL,
    "Sezon_Sayısı" integer NOT NULL,
    "Platform_Id" integer NOT NULL,
    "Sehir_Id" integer NOT NULL,
    "Acıklama_Id" integer NOT NULL,
    "Rating_Puan" integer NOT NULL,
    "Sponsor_ıd" integer NOT NULL,
    "Tur_ad" character varying NOT NULL,
    "Dizi_ıd" integer NOT NULL
);
    DROP TABLE public."Diziler";
       public         heap    postgres    false            ?            1259    16509    Film_Oyuncu    TABLE     g   CREATE TABLE public."Film_Oyuncu" (
    "Film_Id" integer NOT NULL,
    "Kisi_ıd" integer NOT NULL
);
 !   DROP TABLE public."Film_Oyuncu";
       public         heap    postgres    false            ?            1259    16468    Filmler    TABLE     ?  CREATE TABLE public."Filmler" (
    "Film_Adı" character varying NOT NULL,
    "Kisi_Id" integer NOT NULL,
    "Fragman_Id" integer NOT NULL,
    "Film_Süre" character varying(30),
    "Platform_Id" integer NOT NULL,
    "Sehir_Id" integer NOT NULL,
    "Acıklama_Id" integer NOT NULL,
    "Rating_Puan" integer NOT NULL,
    "Sponsor_ıd" integer NOT NULL,
    "Tur_Ad" character varying NOT NULL,
    "Film_Id" integer NOT NULL,
    "Liste_Id" integer NOT NULL
);
    DROP TABLE public."Filmler";
       public         heap    postgres    false            ?            1259    16504    Fragman    TABLE     t   CREATE TABLE public."Fragman" (
    "Fragman_Id" integer NOT NULL,
    "Fragman_Sure" character varying NOT NULL
);
    DROP TABLE public."Fragman";
       public         heap    postgres    false            ?            1259    24648    Kisiler    TABLE       CREATE TABLE public."Kisiler" (
    "Kisi_Id" integer NOT NULL,
    "Kisi_Ad" character varying NOT NULL,
    "Kisi_Soyad" character varying NOT NULL,
    "Kisi_Tel_No" integer,
    "Kisi_Adres" character varying,
    "Kisi_Kategori" character varying NOT NULL
);
    DROP TABLE public."Kisiler";
       public         heap    postgres    false            ?            1259    16442    Listem    TABLE     ?   CREATE TABLE public."Listem" (
    "Liste_Id" integer NOT NULL,
    "Liste_Ad" character varying(20) NOT NULL,
    "Profil_Id" integer NOT NULL
);
    DROP TABLE public."Listem";
       public         heap    postgres    false            ?            1259    16526 	   Oyuncular    TABLE     z   CREATE TABLE public."Oyuncular" (
    "Kisi_Id" integer NOT NULL,
    "Oyuncu_Kategori" character varying(10) NOT NULL
);
    DROP TABLE public."Oyuncular";
       public         heap    postgres    false            ?            1259    16499    Platform    TABLE     ?   CREATE TABLE public."Platform" (
    "Platform_Id" integer NOT NULL,
    "Platform_Ad" character varying(20) NOT NULL,
    "Platform_Yil" integer NOT NULL,
    "Rating_Puan" integer
);
    DROP TABLE public."Platform";
       public         heap    postgres    false            ?            1259    16447    Profil    TABLE     ?   CREATE TABLE public."Profil" (
    "Profil_Id" integer NOT NULL,
    "Ad" character varying(20) NOT NULL,
    "Soyad" character varying(20) NOT NULL,
    "E-mail" character varying(30)
);
    DROP TABLE public."Profil";
       public         heap    postgres    false            ?            1259    16541    Rating    TABLE     l   CREATE TABLE public."Rating" (
    "Rating_Puan" integer NOT NULL,
    "Rating_Derece" character varying
);
    DROP TABLE public."Rating";
       public         heap    postgres    false            ?            1259    16564    Sponsor    TABLE     r   CREATE TABLE public."Sponsor" (
    "Sponsor_Id" integer NOT NULL,
    "Sponsor_Ad" character varying NOT NULL
);
    DROP TABLE public."Sponsor";
       public         heap    postgres    false            ?            1259    16458    Tur    TABLE     y   CREATE TABLE public."Tur" (
    "Tur_Ad" character varying(30) NOT NULL,
    "Izleyici_Kitlesi" character varying(10)
);
    DROP TABLE public."Tur";
       public         heap    postgres    false            ?            1259    16521    Yonetmen    TABLE     C   CREATE TABLE public."Yonetmen" (
    "Kisi_Id" integer NOT NULL
);
    DROP TABLE public."Yonetmen";
       public         heap    postgres    false            ?            1259    24701    silinen_Dizi    TABLE     ^   CREATE TABLE public."silinen_Dizi" (
    "dizi_ıd" integer,
    dizi_ad character varying
);
 "   DROP TABLE public."silinen_Dizi";
       public         heap    postgres    false            ?            1259    24686    silinen_Film    TABLE     ^   CREATE TABLE public."silinen_Film" (
    "film_ıd" integer,
    film_ad character varying
);
 "   DROP TABLE public."silinen_Film";
       public         heap    postgres    false            ?          0    16463 	   Acıklama 
   TABLE DATA           I   COPY public."Acıklama" ("Acıklama_Id", "Acıklama_Icerik") FROM stdin;
    public          postgres    false    212   ??       ?          0    16536    Cekildigi_Yer 
   TABLE DATA           A   COPY public."Cekildigi_Yer" ("Sehir_Id", "Sehir_Ad") FROM stdin;
    public          postgres    false    221   ??       ?          0    16531    Dizi_Oyuncu 
   TABLE DATA           =   COPY public."Dizi_Oyuncu" ("Dizi_Id", "Kisi_Id") FROM stdin;
    public          postgres    false    220   ??       ?          0    16487    Diziler 
   TABLE DATA           ?   COPY public."Diziler" ("Liste_Id", "Dizi_Adı", "Kisi_Id", "Fragman_Id", "Sezon_Sayısı", "Platform_Id", "Sehir_Id", "Acıklama_Id", "Rating_Puan", "Sponsor_ıd", "Tur_ad", "Dizi_ıd") FROM stdin;
    public          postgres    false    214   '?       ?          0    16509    Film_Oyuncu 
   TABLE DATA           >   COPY public."Film_Oyuncu" ("Film_Id", "Kisi_ıd") FROM stdin;
    public          postgres    false    217   ՛       ?          0    16468    Filmler 
   TABLE DATA           ?   COPY public."Filmler" ("Film_Adı", "Kisi_Id", "Fragman_Id", "Film_Süre", "Platform_Id", "Sehir_Id", "Acıklama_Id", "Rating_Puan", "Sponsor_ıd", "Tur_Ad", "Film_Id", "Liste_Id") FROM stdin;
    public          postgres    false    213   ?       ?          0    16504    Fragman 
   TABLE DATA           A   COPY public."Fragman" ("Fragman_Id", "Fragman_Sure") FROM stdin;
    public          postgres    false    216   ??       ?          0    24648    Kisiler 
   TABLE DATA           u   COPY public."Kisiler" ("Kisi_Id", "Kisi_Ad", "Kisi_Soyad", "Kisi_Tel_No", "Kisi_Adres", "Kisi_Kategori") FROM stdin;
    public          postgres    false    224   7?       ?          0    16442    Listem 
   TABLE DATA           G   COPY public."Listem" ("Liste_Id", "Liste_Ad", "Profil_Id") FROM stdin;
    public          postgres    false    209   ??       ?          0    16526 	   Oyuncular 
   TABLE DATA           C   COPY public."Oyuncular" ("Kisi_Id", "Oyuncu_Kategori") FROM stdin;
    public          postgres    false    219   ˟       ?          0    16499    Platform 
   TABLE DATA           a   COPY public."Platform" ("Platform_Id", "Platform_Ad", "Platform_Yil", "Rating_Puan") FROM stdin;
    public          postgres    false    215   '?       ?          0    16447    Profil 
   TABLE DATA           H   COPY public."Profil" ("Profil_Id", "Ad", "Soyad", "E-mail") FROM stdin;
    public          postgres    false    210   ??       ?          0    16541    Rating 
   TABLE DATA           B   COPY public."Rating" ("Rating_Puan", "Rating_Derece") FROM stdin;
    public          postgres    false    222   ߠ       ?          0    16564    Sponsor 
   TABLE DATA           ?   COPY public."Sponsor" ("Sponsor_Id", "Sponsor_Ad") FROM stdin;
    public          postgres    false    223    ?       ?          0    16458    Tur 
   TABLE DATA           =   COPY public."Tur" ("Tur_Ad", "Izleyici_Kitlesi") FROM stdin;
    public          postgres    false    211   ??       ?          0    16521    Yonetmen 
   TABLE DATA           /   COPY public."Yonetmen" ("Kisi_Id") FROM stdin;
    public          postgres    false    218   ?       ?          0    24701    silinen_Dizi 
   TABLE DATA           =   COPY public."silinen_Dizi" ("dizi_ıd", dizi_ad) FROM stdin;
    public          postgres    false    226   =?       ?          0    24686    silinen_Film 
   TABLE DATA           =   COPY public."silinen_Film" ("film_ıd", film_ad) FROM stdin;
    public          postgres    false    225   u?       ?           2606    16467    Acıklama Açıklama_Id_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public."Acıklama"
    ADD CONSTRAINT "Açıklama_Id_pkey" PRIMARY KEY ("Acıklama_Id");
 J   ALTER TABLE ONLY public."Acıklama" DROP CONSTRAINT "Açıklama_Id_pkey";
       public            postgres    false    212            ?           2606    16535 "   Dizi_Oyuncu Dizi_ıd-Kisi_ıd_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public."Dizi_Oyuncu"
    ADD CONSTRAINT "Dizi_ıd-Kisi_ıd_pkey" PRIMARY KEY ("Dizi_Id", "Kisi_Id");
 P   ALTER TABLE ONLY public."Dizi_Oyuncu" DROP CONSTRAINT "Dizi_ıd-Kisi_ıd_pkey";
       public            postgres    false    220    220            ?           2606    24642    Diziler Dizi_ıd_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Dizi_ıd_pkey" PRIMARY KEY ("Dizi_ıd");
 C   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Dizi_ıd_pkey";
       public            postgres    false    214            ?           2606    16513 !   Film_Oyuncu Film_Id-Kisi_ıd_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public."Film_Oyuncu"
    ADD CONSTRAINT "Film_Id-Kisi_ıd_pkey" PRIMARY KEY ("Film_Id", "Kisi_ıd");
 O   ALTER TABLE ONLY public."Film_Oyuncu" DROP CONSTRAINT "Film_Id-Kisi_ıd_pkey";
       public            postgres    false    217    217            ?           2606    24634    Filmler Film_Id_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Film_Id_pkey" PRIMARY KEY ("Film_Id");
 B   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Film_Id_pkey";
       public            postgres    false    213            ?           2606    16508    Fragman Fragman_Id_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public."Fragman"
    ADD CONSTRAINT "Fragman_Id_pkey" PRIMARY KEY ("Fragman_Id");
 E   ALTER TABLE ONLY public."Fragman" DROP CONSTRAINT "Fragman_Id_pkey";
       public            postgres    false    216            ?           2606    24654    Kisiler Kisi_Id_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Kisiler"
    ADD CONSTRAINT "Kisi_Id_pkey" PRIMARY KEY ("Kisi_Id");
 B   ALTER TABLE ONLY public."Kisiler" DROP CONSTRAINT "Kisi_Id_pkey";
       public            postgres    false    224            ?           2606    16679    Yonetmen Kisi_ıd_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Yonetmen"
    ADD CONSTRAINT "Kisi_ıd_pkey" PRIMARY KEY ("Kisi_Id");
 D   ALTER TABLE ONLY public."Yonetmen" DROP CONSTRAINT "Kisi_ıd_pkey";
       public            postgres    false    218            ?           2606    16446    Listem Listem_Id_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Listem"
    ADD CONSTRAINT "Listem_Id_pkey" PRIMARY KEY ("Liste_Id");
 C   ALTER TABLE ONLY public."Listem" DROP CONSTRAINT "Listem_Id_pkey";
       public            postgres    false    209            ?           2606    16669    Oyuncular Oyuncu_ıd_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."Oyuncular"
    ADD CONSTRAINT "Oyuncu_ıd_pkey" PRIMARY KEY ("Kisi_Id");
 G   ALTER TABLE ONLY public."Oyuncular" DROP CONSTRAINT "Oyuncu_ıd_pkey";
       public            postgres    false    219            ?           2606    16503    Platform Platform_Id_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."Platform"
    ADD CONSTRAINT "Platform_Id_pkey" PRIMARY KEY ("Platform_Id");
 G   ALTER TABLE ONLY public."Platform" DROP CONSTRAINT "Platform_Id_pkey";
       public            postgres    false    215            ?           2606    16451    Profil Profil_Id_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Profil"
    ADD CONSTRAINT "Profil_Id_pkey" PRIMARY KEY ("Profil_Id");
 C   ALTER TABLE ONLY public."Profil" DROP CONSTRAINT "Profil_Id_pkey";
       public            postgres    false    210            ?           2606    16545    Rating Rating_puan_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_puan_pkey" PRIMARY KEY ("Rating_Puan");
 E   ALTER TABLE ONLY public."Rating" DROP CONSTRAINT "Rating_puan_pkey";
       public            postgres    false    222            ?           2606    16540    Cekildigi_Yer Sehir_ıd_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."Cekildigi_Yer"
    ADD CONSTRAINT "Sehir_ıd_pkey" PRIMARY KEY ("Sehir_Id");
 J   ALTER TABLE ONLY public."Cekildigi_Yer" DROP CONSTRAINT "Sehir_ıd_pkey";
       public            postgres    false    221            ?           2606    16570    Sponsor Sponsor_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Sponsor"
    ADD CONSTRAINT "Sponsor_pkey" PRIMARY KEY ("Sponsor_Id");
 B   ALTER TABLE ONLY public."Sponsor" DROP CONSTRAINT "Sponsor_pkey";
       public            postgres    false    223            ?           2606    16462    Tur Tür_Id_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Tur"
    ADD CONSTRAINT "Tür_Id_pkey" PRIMARY KEY ("Tur_Ad");
 >   ALTER TABLE ONLY public."Tur" DROP CONSTRAINT "Tür_Id_pkey";
       public            postgres    false    211            ?           1259    16563    fki_Aciklama_Id    INDEX     Q   CREATE INDEX "fki_Aciklama_Id" ON public."Filmler" USING btree ("Acıklama_Id");
 %   DROP INDEX public."fki_Aciklama_Id";
       public            postgres    false    213            ?           1259    16633    fki_Aciklama_Id_fkey    INDEX     V   CREATE INDEX "fki_Aciklama_Id_fkey" ON public."Diziler" USING btree ("Acıklama_Id");
 *   DROP INDEX public."fki_Aciklama_Id_fkey";
       public            postgres    false    214            ?           1259    16600    fki_Aciklama_ıd_fkey    INDEX     W   CREATE INDEX "fki_Aciklama_ıd_fkey" ON public."Filmler" USING btree ("Acıklama_Id");
 +   DROP INDEX public."fki_Aciklama_ıd_fkey";
       public            postgres    false    213            ?           1259    16707    fki_Dizi_ıd_fkey    INDEX     R   CREATE INDEX "fki_Dizi_ıd_fkey" ON public."Dizi_Oyuncu" USING btree ("Dizi_Id");
 '   DROP INDEX public."fki_Dizi_ıd_fkey";
       public            postgres    false    220            ?           1259    16715    fki_Film_Id_fkey    INDEX     Q   CREATE INDEX "fki_Film_Id_fkey" ON public."Film_Oyuncu" USING btree ("Film_Id");
 &   DROP INDEX public."fki_Film_Id_fkey";
       public            postgres    false    217            ?           1259    16582    fki_Fragman_ıd_fkey    INDEX     T   CREATE INDEX "fki_Fragman_ıd_fkey" ON public."Filmler" USING btree ("Fragman_Id");
 *   DROP INDEX public."fki_Fragman_ıd_fkey";
       public            postgres    false    213            ?           1259    24660    fki_Kisi_Id_fkey    INDEX     N   CREATE INDEX "fki_Kisi_Id_fkey" ON public."Yonetmen" USING btree ("Kisi_Id");
 &   DROP INDEX public."fki_Kisi_Id_fkey";
       public            postgres    false    218            ?           1259    24640    fki_Liste_Id_fkey    INDEX     O   CREATE INDEX "fki_Liste_Id_fkey" ON public."Filmler" USING btree ("Liste_Id");
 '   DROP INDEX public."fki_Liste_Id_fkey";
       public            postgres    false    213            ?           1259    16687    fki_Oyuncu_Id_fkey    INDEX     T   CREATE INDEX "fki_Oyuncu_Id_fkey" ON public."Film_Oyuncu" USING btree ("Kisi_ıd");
 (   DROP INDEX public."fki_Oyuncu_Id_fkey";
       public            postgres    false    217            ?           1259    16588    fki_Platform_ıd_fkey    INDEX     V   CREATE INDEX "fki_Platform_ıd_fkey" ON public."Filmler" USING btree ("Platform_Id");
 +   DROP INDEX public."fki_Platform_ıd_fkey";
       public            postgres    false    213            ?           1259    16457    fki_Profil_fkey    INDEX     M   CREATE INDEX "fki_Profil_fkey" ON public."Listem" USING btree ("Profil_Id");
 %   DROP INDEX public."fki_Profil_fkey";
       public            postgres    false    209            ?           1259    16551    fki_Profil_ıd_fkey    INDEX     Q   CREATE INDEX "fki_Profil_ıd_fkey" ON public."Listem" USING btree ("Profil_Id");
 )   DROP INDEX public."fki_Profil_ıd_fkey";
       public            postgres    false    209            ?           1259    16557    fki_Rating_Puan_fkey    INDEX     V   CREATE INDEX "fki_Rating_Puan_fkey" ON public."Platform" USING btree ("Rating_Puan");
 *   DROP INDEX public."fki_Rating_Puan_fkey";
       public            postgres    false    215            ?           1259    16612    fki_Rating_puan_fkey    INDEX     U   CREATE INDEX "fki_Rating_puan_fkey" ON public."Filmler" USING btree ("Rating_Puan");
 *   DROP INDEX public."fki_Rating_puan_fkey";
       public            postgres    false    213            ?           1259    16594    fki_Sehir_ıd_fkey    INDEX     P   CREATE INDEX "fki_Sehir_ıd_fkey" ON public."Filmler" USING btree ("Sehir_Id");
 (   DROP INDEX public."fki_Sehir_ıd_fkey";
       public            postgres    false    213            ?           1259    16576    fki_Sponsor_ıd_fkey    INDEX     U   CREATE INDEX "fki_Sponsor_ıd_fkey" ON public."Filmler" USING btree ("Sponsor_ıd");
 *   DROP INDEX public."fki_Sponsor_ıd_fkey";
       public            postgres    false    213            ?           1259    16606    fki_Tur_ad_fkey    INDEX     K   CREATE INDEX "fki_Tur_ad_fkey" ON public."Filmler" USING btree ("Tur_Ad");
 %   DROP INDEX public."fki_Tur_ad_fkey";
       public            postgres    false    213            ?           1259    16693    fki_Yonetmen_Id_fkey    INDEX     Q   CREATE INDEX "fki_Yonetmen_Id_fkey" ON public."Filmler" USING btree ("Kisi_Id");
 *   DROP INDEX public."fki_Yonetmen_Id_fkey";
       public            postgres    false    213            ?           1259    16675    fki_o    INDEX     D   CREATE INDEX fki_o ON public."Dizi_Oyuncu" USING btree ("Kisi_Id");
    DROP INDEX public.fki_o;
       public            postgres    false    220            ?           2620    24711 #   Dizi_Oyuncu delete_d_oyuncu_trigger    TRIGGER     ?   CREATE TRIGGER delete_d_oyuncu_trigger AFTER DELETE ON public."Dizi_Oyuncu" FOR EACH ROW EXECUTE FUNCTION public.delete_oyuncu();
 >   DROP TRIGGER delete_d_oyuncu_trigger ON public."Dizi_Oyuncu";
       public          postgres    false    238    220            ?           2620    24713     Yonetmen delete_yonetmen_trigger    TRIGGER     ?   CREATE TRIGGER delete_yonetmen_trigger AFTER DELETE ON public."Yonetmen" FOR EACH ROW EXECUTE FUNCTION public.delete_yonetmen();
 ;   DROP TRIGGER delete_yonetmen_trigger ON public."Yonetmen";
       public          postgres    false    239    218            ?           2620    24715    Kisiler insert_kisi_trigger    TRIGGER     x   CREATE TRIGGER insert_kisi_trigger AFTER INSERT ON public."Kisiler" FOR EACH ROW EXECUTE FUNCTION public.insert_kisi();
 6   DROP TRIGGER insert_kisi_trigger ON public."Kisiler";
       public          postgres    false    249    224            ?           2620    24707    Diziler trigger_silinen_dizi    TRIGGER     z   CREATE TRIGGER trigger_silinen_dizi AFTER DELETE ON public."Diziler" FOR EACH ROW EXECUTE FUNCTION public.silinen_dizi();
 7   DROP TRIGGER trigger_silinen_dizi ON public."Diziler";
       public          postgres    false    214    234            ?           2620    24698    Filmler trigger_silinen_film    TRIGGER     z   CREATE TRIGGER trigger_silinen_film AFTER DELETE ON public."Filmler" FOR EACH ROW EXECUTE FUNCTION public.silinen_film();
 7   DROP TRIGGER trigger_silinen_film ON public."Filmler";
       public          postgres    false    213    233            ?           2606    16628    Diziler Aciklama_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Aciklama_Id_fkey" FOREIGN KEY ("Acıklama_Id") REFERENCES public."Acıklama"("Acıklama_Id");
 F   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Aciklama_Id_fkey";
       public          postgres    false    3252    214    212            ?           2606    16595    Filmler Aciklama_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Aciklama_ıd_fkey" FOREIGN KEY ("Acıklama_Id") REFERENCES public."Acıklama"("Acıklama_Id") NOT VALID;
 G   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Aciklama_ıd_fkey";
       public          postgres    false    213    212    3252            ?           2606    24671    Dizi_Oyuncu Dizi_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Dizi_Oyuncu"
    ADD CONSTRAINT "Dizi_ıd_fkey" FOREIGN KEY ("Dizi_Id") REFERENCES public."Diziler"("Dizi_ıd") NOT VALID;
 G   ALTER TABLE ONLY public."Dizi_Oyuncu" DROP CONSTRAINT "Dizi_ıd_fkey";
       public          postgres    false    214    220    3266            ?           2606    24666    Film_Oyuncu Film_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Film_Oyuncu"
    ADD CONSTRAINT "Film_Id_fkey" FOREIGN KEY ("Film_Id") REFERENCES public."Filmler"("Film_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Film_Oyuncu" DROP CONSTRAINT "Film_Id_fkey";
       public          postgres    false    213    3254    217            ?           2606    16577    Filmler Fragman_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Fragman_ıd_fkey" FOREIGN KEY ("Fragman_Id") REFERENCES public."Fragman"("Fragman_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Fragman_ıd_fkey";
       public          postgres    false    213    3272    216            ?           2606    16613    Diziler Fragman_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Fragman_ıd_fkey" FOREIGN KEY ("Fragman_Id") REFERENCES public."Fragman"("Fragman_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Fragman_ıd_fkey";
       public          postgres    false    214    216    3272            ?           2606    16670    Dizi_Oyuncu Kisi_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Dizi_Oyuncu"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Oyuncular"("Kisi_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Dizi_Oyuncu" DROP CONSTRAINT "Kisi_Id_fkey";
       public          postgres    false    219    3281    220            ?           2606    16682    Film_Oyuncu Kisi_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Film_Oyuncu"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_ıd") REFERENCES public."Oyuncular"("Kisi_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Film_Oyuncu" DROP CONSTRAINT "Kisi_Id_fkey";
       public          postgres    false    217    3281    219            ?           2606    24655    Yonetmen Kisi_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Yonetmen"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;
 C   ALTER TABLE ONLY public."Yonetmen" DROP CONSTRAINT "Kisi_Id_fkey";
       public          postgres    false    224    3293    218            ?           2606    24676    Diziler Kisi_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;
 B   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Kisi_Id_fkey";
       public          postgres    false    3293    224    214            ?           2606    24681    Filmler Kisi_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;
 B   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Kisi_Id_fkey";
       public          postgres    false    3293    224    213            ?           2606    24635    Filmler Liste_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Liste_Id_fkey" FOREIGN KEY ("Liste_Id") REFERENCES public."Listem"("Liste_Id") NOT VALID;
 C   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Liste_Id_fkey";
       public          postgres    false    3244    213    209            ?           2606    24643    Diziler Liste_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Liste_Id_fkey" FOREIGN KEY ("Liste_Id") REFERENCES public."Listem"("Liste_Id") NOT VALID;
 C   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Liste_Id_fkey";
       public          postgres    false    209    3244    214            ?           2606    24661    Oyuncular Oyuncu_Id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Oyuncular"
    ADD CONSTRAINT "Oyuncu_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Oyuncular" DROP CONSTRAINT "Oyuncu_Id_fkey";
       public          postgres    false    224    3293    219            ?           2606    16583    Filmler Platform_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Platform_ıd_fkey" FOREIGN KEY ("Platform_Id") REFERENCES public."Platform"("Platform_Id") NOT VALID;
 G   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Platform_ıd_fkey";
       public          postgres    false    3269    213    215            ?           2606    16618    Diziler Platform_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Platform_ıd_fkey" FOREIGN KEY ("Platform_Id") REFERENCES public."Platform"("Platform_Id") NOT VALID;
 G   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Platform_ıd_fkey";
       public          postgres    false    215    214    3269            ?           2606    16546    Listem Profil_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Listem"
    ADD CONSTRAINT "Profil_ıd_fkey" FOREIGN KEY ("Profil_Id") REFERENCES public."Profil"("Profil_Id") NOT VALID;
 D   ALTER TABLE ONLY public."Listem" DROP CONSTRAINT "Profil_ıd_fkey";
       public          postgres    false    210    209    3248            ?           2606    16552    Platform Rating_Puan_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Platform"
    ADD CONSTRAINT "Rating_Puan_fkey" FOREIGN KEY ("Rating_Puan") REFERENCES public."Rating"("Rating_Puan") NOT VALID;
 G   ALTER TABLE ONLY public."Platform" DROP CONSTRAINT "Rating_Puan_fkey";
       public          postgres    false    215    222    3289            ?           2606    16644    Diziler Rating_Puan_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Rating_Puan_fkey" FOREIGN KEY ("Rating_Puan") REFERENCES public."Rating"("Rating_Puan") NOT VALID;
 F   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Rating_Puan_fkey";
       public          postgres    false    3289    214    222            ?           2606    16607    Filmler Rating_puan_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Rating_puan_fkey" FOREIGN KEY ("Rating_Puan") REFERENCES public."Rating"("Rating_Puan") NOT VALID;
 F   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Rating_puan_fkey";
       public          postgres    false    213    3289    222            ?           2606    16589    Filmler Sehir_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Sehir_ıd_fkey" FOREIGN KEY ("Sehir_Id") REFERENCES public."Cekildigi_Yer"("Sehir_Id") NOT VALID;
 D   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Sehir_ıd_fkey";
       public          postgres    false    3287    221    213            ?           2606    16623    Diziler Sehir_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Sehir_ıd_fkey" FOREIGN KEY ("Sehir_Id") REFERENCES public."Cekildigi_Yer"("Sehir_Id") NOT VALID;
 D   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Sehir_ıd_fkey";
       public          postgres    false    221    214    3287            ?           2606    16571    Filmler Sponsor_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Sponsor_ıd_fkey" FOREIGN KEY ("Sponsor_ıd") REFERENCES public."Sponsor"("Sponsor_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Sponsor_ıd_fkey";
       public          postgres    false    213    3291    223            ?           2606    16649    Diziler Sponsor_ıd_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Sponsor_ıd_fkey" FOREIGN KEY ("Sponsor_ıd") REFERENCES public."Sponsor"("Sponsor_Id") NOT VALID;
 F   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Sponsor_ıd_fkey";
       public          postgres    false    223    214    3291            ?           2606    16601    Filmler Tur_ad_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Tur_ad_fkey" FOREIGN KEY ("Tur_Ad") REFERENCES public."Tur"("Tur_Ad") NOT VALID;
 A   ALTER TABLE ONLY public."Filmler" DROP CONSTRAINT "Tur_ad_fkey";
       public          postgres    false    3250    211    213            ?           2606    16634    Diziler Tur_ad_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Tur_ad_fkey" FOREIGN KEY ("Tur_ad") REFERENCES public."Tur"("Tur_Ad") NOT VALID;
 A   ALTER TABLE ONLY public."Diziler" DROP CONSTRAINT "Tur_ad_fkey";
       public          postgres    false    211    214    3250            ?   ?  x?UTM??6=ۿ??S,Hүk?6????z?e,??	)? )?o)??Ͼ??????7?v7ۢ?7o޼?W???ǖ??>;n?z/?=F?X?2Z???^?I'l????E?Y?|={??@??t¾?3[???t??L??;?ˁ#NV?F?S?F???Җ?H?9J\?^?*?;g?CY???
?T?4N?L޴?P?g#-??%<???|;??????e?1??FxZ?.?? ???K???݄??k|~???3ŗv?tL?DΔ??P?cѲ?qdK??ݙ?G??NRO??N׳?N??????s??B??P{?|???%?? ??]+??]?q?f??X???HCE??:O?|???`?Fo0?(O?#T-?+?9&9T2NZ޴?8ر?!?bA??k?{??t\uH9/
$.qy??q?Nl?p-т???:???o?I?? t?-??q:?ÖG}?g?Ěa??*u???E끞?BX???g-??o????X?z5?r?tq܌?|?M???[??wd$f?PV????O??=???}MK??	`s?^Q?< Hsty3]
\??A??GuP?D"?? !???J{???1r???^??Sw?l4??a+??툾??鱋
܋??3$?^	@?a???ѐi?z????e7;H???PWsn???Y-Z? ,??G?????Bg6?r?^C???W[?k? ? ???~|??᷸-?c?N??pY???3r?????Z8k???*?0)'???4??m?6?<????h1???<p???5??g3ׁ#???J?cT??f/e?@??%???aVO5?-As??ڴf1???t}6oݸA????eF??a?j+~?aqز???a}?7??e?s?iu?? ?5???JӇ???h??P+?z??v?K??$?$ڜJ<̤??????$??      ?   ?   x?3?v?2????????,?2?<??('1/%?˄?/?\!2?(????L??I0???? ???      ?   3   x?ʻ  B???H?w??CR?׀ ???a?????+?TT?????Q?      ?   ?   x?M?A
?0E????	
Ӵ?]*?+???r3?bǴ$n??A???n^aG?????o?
?Z????e?d}?V?9 ?(??k??O?
+JS?"٘@?8]??9ʔ???#/??c,NaO??????>?sx??ߌJ?<D?8??_j??Z?ka?y5?3w      ?   /   x?Ĺ  ???#?.??
D2?_????n???ꂧ??Ѝ`      ?   ?   x?E?M
?0FדS?J??/Ŋ
n݌5??BR?e??????r?j?Y<f_n?ku?@?????	???AAx?r?Mson?l?,ZU?z?[??C҃????"??)?t?ԼS?????D?????????}/?R???D???O0??2{?H????????i@JH??R!?g?U?2??}^3?>?VH?      ?   C   x?3?442Q(N?ˬL?2?444?q?9?,`NC??)??)?m?0?q?9-,alNK??=... ?Mh      ?   T  x?u??n?@???S?T?1??QCI?8)????l?-??hvM??O?+?ޓ???Hz??4?}3?:?1?h`Bh??o`a͊???I?NKi?OK>?k????y????????s???hS8O???`?>?TX*cT???9\5L&Zm$??J??߲̋o[????p???;?k$????U?m?F????a???\גG??9L2R?+vk?O0d?I?f.??I-8???{ q[P"k?mkR???l? b$??K#ALPk%?i????$bn???;-A?H????????2	?D???tbdR?y?7k?ϥ?=??BC?R&????ߋ"??i??nȫ?)r??[?᱀??ej	b*?\?dj}??] Zx??e?9 n,???)l?????>?"???X?ݻE?rW??h???dK??*a?Du??'??.̊4p??:?w?>?atX??????x?ʉ????:??Vz^??F???}?4R?>?7\*????h?j????O??9????ؚs???h????r??;?????>儢k?\?q?"?=o??*h?.??T????#W͊1?'??????????뵏rIj?Hy???t??x5      ?       x?3?t?-J?4?2?tK,???4?????? F.      ?   L   x?5λ?0??[????U?????'?%z?h,??
qRI#?2?"??I??????[e?]9增?I-??a`-k      ?   Y   x?3??K-I??ɬ?4??4???2?t?,?K??420????2?t?ͯ??S(??MU?LI???q?s?pF旖?&??L9?b???? ???      ?   ?   x?3?t?-JUpN??NMN-????2?tK,????N?I?J??xP?Cznbf?^r~.W? ??      ?   1   x???H-JKM.???t??O?24?K-?T?	?s???&?p??qqq KeH      ?   j   x???
?@???O?O ?i?S:?(Q?.?-?h30??}߷?QeÞ.?%?C??$??9/???Co??ӚT??$Z8?z?Ӵf???F?z???68?U??x ????      ?   ^   x?sO-??????6??r?.ά???C?23?Ss\?s?Bř??9?Y??
?p]?H?`?obrjH?1?<??T$Q?̪?\]??`Sc???? 	?(      ?   %   x?34?24?24?24?2??22?22?22?????? AX&      ?   (   x?3?t?I,?????,I?H-?2??)M?LCa??qqq A&      ?      x?3??HU?I,I?/??????? >?w     