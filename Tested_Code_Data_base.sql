--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-12-26 17:17:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 238 (class 1255 OID 24710)
-- Name: delete_oyuncu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_oyuncu() RETURNS trigger
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


ALTER FUNCTION public.delete_oyuncu() OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 24712)
-- Name: delete_yonetmen(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_yonetmen() RETURNS trigger
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


ALTER FUNCTION public.delete_yonetmen() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 16742)
-- Name: dizi_getir(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dizi_getir(prmt integer) RETURNS TABLE(id integer, dizi_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY SELECT "Liste_Id", "Dizi_Adı" FROM "Diziler"
    WHERE "Liste_Id" = prmt;
END;
$$;


ALTER FUNCTION public.dizi_getir(prmt integer) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16737)
-- Name: dizi_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dizi_sayisi() RETURNS double precision
    LANGUAGE plpgsql
    AS $$
declare
	total integer;
begin

total:=(select count("Dizi_ıd") from "Diziler");
return total;
end;
$$;


ALTER FUNCTION public.dizi_sayisi() OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 16744)
-- Name: en_yuksek_rating_dizi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.en_yuksek_rating_dizi() RETURNS TABLE(id integer, dizi_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY select max("Rating_Puan"),"Dizi_Adı" from "Diziler" group by "Dizi_Adı" having max("Rating_Puan")>8;
END;
$$;


ALTER FUNCTION public.en_yuksek_rating_dizi() OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 16752)
-- Name: en_yuksek_rating_film(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.en_yuksek_rating_film() RETURNS TABLE(id integer, film_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY select max("Rating_Puan"),"Film_Adı" from "Filmler" group by "Film_Adı" having max("Rating_Puan")>9;
END;
$$;


ALTER FUNCTION public.en_yuksek_rating_film() OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 16755)
-- Name: film_getir(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_getir(fprmt integer) RETURNS TABLE(id integer, film_adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY SELECT "Liste_Id", "Film_Adı" FROM "Filmler"
    WHERE "Liste_Id" = fprmt;
END;
$$;


ALTER FUNCTION public.film_getir(fprmt integer) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16751)
-- Name: film_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.film_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	total_film integer;
begin

total_film:=(select count("Film_Id") from "Filmler");
return total_film;
end;
$$;


ALTER FUNCTION public.film_sayisi() OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 24714)
-- Name: insert_kisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_kisi() RETURNS trigger
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


ALTER FUNCTION public.insert_kisi() OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 16747)
-- Name: oyuncu_sayisi_getir(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.oyuncu_sayisi_getir() RETURNS TABLE(toplam_oyuncu bigint, kategori character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY select count("Oyuncu_Kategori"),"Oyuncu_Kategori" from "Oyuncular" group by "Oyuncu_Kategori";
END;
$$;


ALTER FUNCTION public.oyuncu_sayisi_getir() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 24706)
-- Name: silinen_dizi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.silinen_dizi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into "silinen_Dizi" ("dizi_ıd","dizi_ad") values(OLD."Dizi_ıd",OLD."Dizi_Adı");
return new;
end;
$$;


ALTER FUNCTION public.silinen_dizi() OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 24697)
-- Name: silinen_film(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.silinen_film() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
insert into "silinen_Film" (film_ıd,"film_ad") values(OLD."Film_Id",OLD."Film_Adı");
return new;
end;
$$;


ALTER FUNCTION public.silinen_film() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16463)
-- Name: Acıklama; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Acıklama" (
    "Acıklama_Id" integer NOT NULL,
    "Acıklama_Icerik" character varying
);


ALTER TABLE public."Acıklama" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16536)
-- Name: Cekildigi_Yer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cekildigi_Yer" (
    "Sehir_Id" integer NOT NULL,
    "Sehir_Ad" character varying(15) NOT NULL
);


ALTER TABLE public."Cekildigi_Yer" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16531)
-- Name: Dizi_Oyuncu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dizi_Oyuncu" (
    "Dizi_Id" integer NOT NULL,
    "Kisi_Id" integer NOT NULL
);


ALTER TABLE public."Dizi_Oyuncu" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16487)
-- Name: Diziler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Diziler" (
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


ALTER TABLE public."Diziler" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16509)
-- Name: Film_Oyuncu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Film_Oyuncu" (
    "Film_Id" integer NOT NULL,
    "Kisi_ıd" integer NOT NULL
);


ALTER TABLE public."Film_Oyuncu" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16468)
-- Name: Filmler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Filmler" (
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


ALTER TABLE public."Filmler" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16504)
-- Name: Fragman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Fragman" (
    "Fragman_Id" integer NOT NULL,
    "Fragman_Sure" character varying NOT NULL
);


ALTER TABLE public."Fragman" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24648)
-- Name: Kisiler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kisiler" (
    "Kisi_Id" integer NOT NULL,
    "Kisi_Ad" character varying NOT NULL,
    "Kisi_Soyad" character varying NOT NULL,
    "Kisi_Tel_No" integer,
    "Kisi_Adres" character varying,
    "Kisi_Kategori" character varying NOT NULL
);


ALTER TABLE public."Kisiler" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16442)
-- Name: Listem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Listem" (
    "Liste_Id" integer NOT NULL,
    "Liste_Ad" character varying(20) NOT NULL,
    "Profil_Id" integer NOT NULL
);


ALTER TABLE public."Listem" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16526)
-- Name: Oyuncular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Oyuncular" (
    "Kisi_Id" integer NOT NULL,
    "Oyuncu_Kategori" character varying(10) NOT NULL
);


ALTER TABLE public."Oyuncular" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16499)
-- Name: Platform; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Platform" (
    "Platform_Id" integer NOT NULL,
    "Platform_Ad" character varying(20) NOT NULL,
    "Platform_Yil" integer NOT NULL,
    "Rating_Puan" integer
);


ALTER TABLE public."Platform" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16447)
-- Name: Profil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Profil" (
    "Profil_Id" integer NOT NULL,
    "Ad" character varying(20) NOT NULL,
    "Soyad" character varying(20) NOT NULL,
    "E-mail" character varying(30)
);


ALTER TABLE public."Profil" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16541)
-- Name: Rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rating" (
    "Rating_Puan" integer NOT NULL,
    "Rating_Derece" character varying
);


ALTER TABLE public."Rating" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16564)
-- Name: Sponsor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sponsor" (
    "Sponsor_Id" integer NOT NULL,
    "Sponsor_Ad" character varying NOT NULL
);


ALTER TABLE public."Sponsor" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16458)
-- Name: Tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tur" (
    "Tur_Ad" character varying(30) NOT NULL,
    "Izleyici_Kitlesi" character varying(10)
);


ALTER TABLE public."Tur" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16521)
-- Name: Yonetmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yonetmen" (
    "Kisi_Id" integer NOT NULL
);


ALTER TABLE public."Yonetmen" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24701)
-- Name: silinen_Dizi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."silinen_Dizi" (
    "dizi_ıd" integer,
    dizi_ad character varying
);


ALTER TABLE public."silinen_Dizi" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24686)
-- Name: silinen_Film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."silinen_Film" (
    "film_ıd" integer,
    film_ad character varying
);


ALTER TABLE public."silinen_Film" OWNER TO postgres;

--
-- TOC entry 3467 (class 0 OID 16463)
-- Dependencies: 212
-- Data for Name: Acıklama; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Acıklama" ("Acıklama_Id", "Acıklama_Icerik") FROM stdin;
1	Kanserden öleceğini öğrenen kimya öğretmeni,ailesinin geleceğini garanti altına almak için metamfetamin üretip satmak üzere eski bir öğrencisiyle kafa kafaya verir
2	Dizi genel olarak işlemediği bir suçtan dolayı idam cezası almış Lincoln Burrowsu ve Lincolnün kardeşi Michael Scofield ın kardeşini kurtarmak için tüm yasal yolların tükendiğini fark edip onu hapishaneden çıkarmak için bir kaçış planı yapması ve sonrasında gelişen olayları konu alır
3	Viking kahramanı Ragnar Lothbrok"un ileriyi göremeyen yetersiz bir lidere meydan okuyarak Norse sınırlarını nasıl genişlettiğini seyrettiğimiz gerçekçi bir dram
4	Dizide Elliot, gündüzleri genç bir siber güvenlik mühendisi ve geceleri hackerlık yapan bir siber korsandır. Elliot, yer altı hacker grubunun (fsociety) onunla irtibata geçmek için şirketininin sistemine zarar vermesi üzerine büyük bir karmaşıklığın içine kendisini atmıştır.
5	Prestij, birbirini alt etmeye çalışan iki sihirbazın hikayesini anlatıyor.
6	Norveç dağlarındaki bir patlamanın kadim bir trolü uyandırmasının ardından cesur bir paleontolog bu trolün ölüm saçarak ortalığı kasıp kavurmasını önlemekle görevlendirilir
7	Oregon Üniversitesinde yüksek lisansını yapan Chuck Palahniukun uzak olmayan bir gelecekte geçen ve kafası karışık genç bir erkeği konu alan romanından yola çıkılarak çekilen Fight Clubda filmi anlatan, ünlü bir otomobil firmasında iyi bir işe sahiptir.
8	"American Psycho" romanından uyarlanan, kan donduran bir psikolojik gerilim filmi.
\.


--
-- TOC entry 3476 (class 0 OID 16536)
-- Dependencies: 221
-- Data for Name: Cekildigi_Yer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cekildigi_Yer" ("Sehir_Id", "Sehir_Ad") FROM stdin;
1	USA
2	Illinois
3	İrlanda
4	New York
5	USA
6	USA
7	USA
8	USA
9	Colombia
\.


--
-- TOC entry 3475 (class 0 OID 16531)
-- Dependencies: 220
-- Data for Name: Dizi_Oyuncu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Dizi_Oyuncu" ("Dizi_Id", "Kisi_Id") FROM stdin;
1	1
2	2
3	3
3	4
3	5
4	7
4	8
4	9
2	10
2	11
2	13
\.


--
-- TOC entry 3469 (class 0 OID 16487)
-- Dependencies: 214
-- Data for Name: Diziler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Diziler" ("Liste_Id", "Dizi_Adı", "Kisi_Id", "Fragman_Id", "Sezon_Sayısı", "Platform_Id", "Sehir_Id", "Acıklama_Id", "Rating_Puan", "Sponsor_ıd", "Tur_ad", "Dizi_ıd") FROM stdin;
1	Breaking Bad	14	1	5	1	1	1	9	1	Gerilim	1
1	Prison Break	15	2	5	2	2	2	8	2	Aksiyon	2
2	Vikings	16	3	6	1	3	3	9	3	Tarihsel Drama	3
2	Mr.Robot	17	4	4	1	4	4	9	4	Psikolojik Gerilim	4
1	Luchifer	15	5	4	1	5	5	9	5	Gerilim	5
\.


--
-- TOC entry 3472 (class 0 OID 16509)
-- Dependencies: 217
-- Data for Name: Film_Oyuncu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Film_Oyuncu" ("Film_Id", "Kisi_ıd") FROM stdin;
1	13
1	23
1	24
2	25
2	26
3	27
3	28
3	29
3	30
3	31
\.


--
-- TOC entry 3468 (class 0 OID 16468)
-- Dependencies: 213
-- Data for Name: Filmler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Filmler" ("Film_Adı", "Kisi_Id", "Fragman_Id", "Film_Süre", "Platform_Id", "Sehir_Id", "Acıklama_Id", "Rating_Puan", "Sponsor_ıd", "Tur_Ad", "Film_Id", "Liste_Id") FROM stdin;
Prestige	19	5	2 saat 8 dakika	1	5	5	10	5	Psikolojik	1	1
Esrarengiz Canavar	20	6	1 saat 43 dakika	1	6	6	7	6	Aksiyon ve Macera	2	1
Dövüş Kulübü	21	7	2 saat 19 dakika	3	7	7	9	7	Aksiyon	3	2
American Sayko	22	8	1 saat 41 dakika	1	8	8	8	8	Gizem-Dram	4	2
\.


--
-- TOC entry 3471 (class 0 OID 16504)
-- Dependencies: 216
-- Data for Name: Fragman; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Fragman" ("Fragman_Id", "Fragman_Sure") FROM stdin;
1	124 saniye
2	112 saniye
3	168 saniye
4	102 saniye
5	95 saniye
6	103 saniye
7	89 saniye
8	92 saniye
\.


--
-- TOC entry 3479 (class 0 OID 24648)
-- Dependencies: 224
-- Data for Name: Kisiler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Kisiler" ("Kisi_Id", "Kisi_Ad", "Kisi_Soyad", "Kisi_Tel_No", "Kisi_Adres", "Kisi_Kategori") FROM stdin;
1	Bryan	Cranston	\N	Londra	Oyuncu
2	Wentworth	Miller	\N	USa	Oyuncu
3	Travis	Fimmel	\N	Avustralya	Oyuncu
4	Katheryn	Winnick	\N	Kanada	Oyuncu
5	Clive	Standen	\N	Kuzey İrlanda	Oyuncu
7	Rami	Malek	\N	USA	Oyuncu
8	Christian	Slater	\N	USA	Oyuncu
9	Michel	Gill	\N	USA	Oyuncu
10	Dominic	 Purcell	\N	İngiltere	Oyuncu
11	Sarah Wayne	 Callies	\N	USA	Oyuncu
13	Christian	 Bale	\N	İngiltere	Oyuncu
14	Vince	 Gilligan	\N	Los Angeles	Yonetmen
15	Paul	Scheuring	8996544	Canada	Yonetmen
16	Michael	Hirst	14365442	İngiltere	Yonetmen
17	Igor	Srubshchik	14365442	İtalya	Yonetmen
19	Christopher	 Nolan	14365442	Londra	Yonetmen
20	Roar	Uthaug	\N	Norveç	Yonetmen
21	David 	Fincher	\N	USA	Yonetmen
22	Mary	Harron	\N	Kanada	Yonetmen
23	Hugh 	Jackman	\N	Avustralya	Oyuncu
24	Michael 	 Caine	\N	Londra	Oyuncu
25	Mads Sjøgård	 Pettersen 	\N	Norveç	Oyuncu
26	Ine Marie	 Wilmann 	\N	Norveç	Oyuncu
27	Brad	 Pitt	\N	ABD	Oyuncu
28	Helena Bonham 	  Carter	\N	Londra	Oyuncu
29	Meat	  Loaf	\N	Dallas	Oyuncu
30	Justin 	 Theroux	\N	Washington	Oyuncu
31	Bill 	  Sage	\N	ABD	Oyuncu
34	Abrham	Linclon	\N	Amerika	Oyuncu
35	Yılmaz	Erdogan	555	Turkey	Yonetmen
\.


--
-- TOC entry 3464 (class 0 OID 16442)
-- Dependencies: 209
-- Data for Name: Listem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Listem" ("Liste_Id", "Liste_Ad", "Profil_Id") FROM stdin;
1	Emre	1
2	Fatih	2
\.


--
-- TOC entry 3474 (class 0 OID 16526)
-- Dependencies: 219
-- Data for Name: Oyuncular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Oyuncular" ("Kisi_Id", "Oyuncu_Kategori") FROM stdin;
1	Dizi
2	Dizi
3	Dizi
4	Dizi
5	Dizi
7	Dizi
8	Dizi
9	Dizi
10	Dizi
11	Dizi
13	Film
23	Film
24	Film
25	Film
26	Film
27	Film
28	Film
29	Film
30	Film
31	Film
34	Dizi
\.


--
-- TOC entry 3470 (class 0 OID 16499)
-- Dependencies: 215
-- Data for Name: Platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Platform" ("Platform_Id", "Platform_Ad", "Platform_Yil", "Rating_Puan") FROM stdin;
1	Netfilix	1997	9
2	Disney	2019	8
3	Amozon Prime Video	2006	7
4	Youtube	2005	10
\.


--
-- TOC entry 3465 (class 0 OID 16447)
-- Dependencies: 210
-- Data for Name: Profil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Profil" ("Profil_Id", "Ad", "Soyad", "E-mail") FROM stdin;
1	Emre Can	Secer	\N
2	Fatih	Kalaman	fatihKalaman@gmail.com
\.


--
-- TOC entry 3477 (class 0 OID 16541)
-- Dependencies: 222
-- Data for Name: Rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Rating" ("Rating_Puan", "Rating_Derece") FROM stdin;
9	Perfect
8	Good
10	Very Perfect
7	Normal
\.


--
-- TOC entry 3478 (class 0 OID 16564)
-- Dependencies: 223
-- Data for Name: Sponsor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sponsor" ("Sponsor_Id", "Sponsor_Ad") FROM stdin;
1	Sony
2	FOX
3	DR3
4	Universal Cable Productions
5	Warner Bros Pictures
6	Samsung
7	DC
8	Nokia
\.


--
-- TOC entry 3466 (class 0 OID 16458)
-- Dependencies: 211
-- Data for Name: Tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Tur" ("Tur_Ad", "Izleyici_Kitlesi") FROM stdin;
Gerilim	+18
Aksiyon	+18
Tarihsel Drama	+18
Psikolojik Gerilim	+15
Psikolojik	+15
Macera	+13
Aksiyon ve Macera	+13
Gizem-Dram	+18
\.


--
-- TOC entry 3473 (class 0 OID 16521)
-- Dependencies: 218
-- Data for Name: Yonetmen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Yonetmen" ("Kisi_Id") FROM stdin;
14
15
16
17
19
20
21
22
35
\.


--
-- TOC entry 3481 (class 0 OID 24701)
-- Dependencies: 226
-- Data for Name: silinen_Dizi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."silinen_Dizi" ("dizi_ıd", dizi_ad) FROM stdin;
\.


--
-- TOC entry 3480 (class 0 OID 24686)
-- Dependencies: 225
-- Data for Name: silinen_Film; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."silinen_Film" ("film_ıd", film_ad) FROM stdin;
5	The Platform
\.


--
-- TOC entry 3252 (class 2606 OID 16467)
-- Name: Acıklama Açıklama_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Acıklama"
    ADD CONSTRAINT "Açıklama_Id_pkey" PRIMARY KEY ("Acıklama_Id");


--
-- TOC entry 3283 (class 2606 OID 16535)
-- Name: Dizi_Oyuncu Dizi_ıd-Kisi_ıd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dizi_Oyuncu"
    ADD CONSTRAINT "Dizi_ıd-Kisi_ıd_pkey" PRIMARY KEY ("Dizi_Id", "Kisi_Id");


--
-- TOC entry 3266 (class 2606 OID 24642)
-- Name: Diziler Dizi_ıd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Dizi_ıd_pkey" PRIMARY KEY ("Dizi_ıd");


--
-- TOC entry 3274 (class 2606 OID 16513)
-- Name: Film_Oyuncu Film_Id-Kisi_ıd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Film_Oyuncu"
    ADD CONSTRAINT "Film_Id-Kisi_ıd_pkey" PRIMARY KEY ("Film_Id", "Kisi_ıd");


--
-- TOC entry 3254 (class 2606 OID 24634)
-- Name: Filmler Film_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Film_Id_pkey" PRIMARY KEY ("Film_Id");


--
-- TOC entry 3272 (class 2606 OID 16508)
-- Name: Fragman Fragman_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fragman"
    ADD CONSTRAINT "Fragman_Id_pkey" PRIMARY KEY ("Fragman_Id");


--
-- TOC entry 3293 (class 2606 OID 24654)
-- Name: Kisiler Kisi_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisiler"
    ADD CONSTRAINT "Kisi_Id_pkey" PRIMARY KEY ("Kisi_Id");


--
-- TOC entry 3278 (class 2606 OID 16679)
-- Name: Yonetmen Kisi_ıd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetmen"
    ADD CONSTRAINT "Kisi_ıd_pkey" PRIMARY KEY ("Kisi_Id");


--
-- TOC entry 3244 (class 2606 OID 16446)
-- Name: Listem Listem_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Listem"
    ADD CONSTRAINT "Listem_Id_pkey" PRIMARY KEY ("Liste_Id");


--
-- TOC entry 3281 (class 2606 OID 16669)
-- Name: Oyuncular Oyuncu_ıd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Oyuncular"
    ADD CONSTRAINT "Oyuncu_ıd_pkey" PRIMARY KEY ("Kisi_Id");


--
-- TOC entry 3269 (class 2606 OID 16503)
-- Name: Platform Platform_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Platform"
    ADD CONSTRAINT "Platform_Id_pkey" PRIMARY KEY ("Platform_Id");


--
-- TOC entry 3248 (class 2606 OID 16451)
-- Name: Profil Profil_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Profil"
    ADD CONSTRAINT "Profil_Id_pkey" PRIMARY KEY ("Profil_Id");


--
-- TOC entry 3289 (class 2606 OID 16545)
-- Name: Rating Rating_puan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_puan_pkey" PRIMARY KEY ("Rating_Puan");


--
-- TOC entry 3287 (class 2606 OID 16540)
-- Name: Cekildigi_Yer Sehir_ıd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cekildigi_Yer"
    ADD CONSTRAINT "Sehir_ıd_pkey" PRIMARY KEY ("Sehir_Id");


--
-- TOC entry 3291 (class 2606 OID 16570)
-- Name: Sponsor Sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sponsor"
    ADD CONSTRAINT "Sponsor_pkey" PRIMARY KEY ("Sponsor_Id");


--
-- TOC entry 3250 (class 2606 OID 16462)
-- Name: Tur Tür_Id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tur"
    ADD CONSTRAINT "Tür_Id_pkey" PRIMARY KEY ("Tur_Ad");


--
-- TOC entry 3255 (class 1259 OID 16563)
-- Name: fki_Aciklama_Id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Aciklama_Id" ON public."Filmler" USING btree ("Acıklama_Id");


--
-- TOC entry 3267 (class 1259 OID 16633)
-- Name: fki_Aciklama_Id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Aciklama_Id_fkey" ON public."Diziler" USING btree ("Acıklama_Id");


--
-- TOC entry 3256 (class 1259 OID 16600)
-- Name: fki_Aciklama_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Aciklama_ıd_fkey" ON public."Filmler" USING btree ("Acıklama_Id");


--
-- TOC entry 3284 (class 1259 OID 16707)
-- Name: fki_Dizi_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Dizi_ıd_fkey" ON public."Dizi_Oyuncu" USING btree ("Dizi_Id");


--
-- TOC entry 3275 (class 1259 OID 16715)
-- Name: fki_Film_Id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Film_Id_fkey" ON public."Film_Oyuncu" USING btree ("Film_Id");


--
-- TOC entry 3257 (class 1259 OID 16582)
-- Name: fki_Fragman_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Fragman_ıd_fkey" ON public."Filmler" USING btree ("Fragman_Id");


--
-- TOC entry 3279 (class 1259 OID 24660)
-- Name: fki_Kisi_Id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Kisi_Id_fkey" ON public."Yonetmen" USING btree ("Kisi_Id");


--
-- TOC entry 3258 (class 1259 OID 24640)
-- Name: fki_Liste_Id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Liste_Id_fkey" ON public."Filmler" USING btree ("Liste_Id");


--
-- TOC entry 3276 (class 1259 OID 16687)
-- Name: fki_Oyuncu_Id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Oyuncu_Id_fkey" ON public."Film_Oyuncu" USING btree ("Kisi_ıd");


--
-- TOC entry 3259 (class 1259 OID 16588)
-- Name: fki_Platform_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Platform_ıd_fkey" ON public."Filmler" USING btree ("Platform_Id");


--
-- TOC entry 3245 (class 1259 OID 16457)
-- Name: fki_Profil_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Profil_fkey" ON public."Listem" USING btree ("Profil_Id");


--
-- TOC entry 3246 (class 1259 OID 16551)
-- Name: fki_Profil_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Profil_ıd_fkey" ON public."Listem" USING btree ("Profil_Id");


--
-- TOC entry 3270 (class 1259 OID 16557)
-- Name: fki_Rating_Puan_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Rating_Puan_fkey" ON public."Platform" USING btree ("Rating_Puan");


--
-- TOC entry 3260 (class 1259 OID 16612)
-- Name: fki_Rating_puan_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Rating_puan_fkey" ON public."Filmler" USING btree ("Rating_Puan");


--
-- TOC entry 3261 (class 1259 OID 16594)
-- Name: fki_Sehir_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Sehir_ıd_fkey" ON public."Filmler" USING btree ("Sehir_Id");


--
-- TOC entry 3262 (class 1259 OID 16576)
-- Name: fki_Sponsor_ıd_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Sponsor_ıd_fkey" ON public."Filmler" USING btree ("Sponsor_ıd");


--
-- TOC entry 3263 (class 1259 OID 16606)
-- Name: fki_Tur_ad_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Tur_ad_fkey" ON public."Filmler" USING btree ("Tur_Ad");


--
-- TOC entry 3264 (class 1259 OID 16693)
-- Name: fki_Yonetmen_Id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Yonetmen_Id_fkey" ON public."Filmler" USING btree ("Kisi_Id");


--
-- TOC entry 3285 (class 1259 OID 16675)
-- Name: fki_o; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_o ON public."Dizi_Oyuncu" USING btree ("Kisi_Id");


--
-- TOC entry 3323 (class 2620 OID 24711)
-- Name: Dizi_Oyuncu delete_d_oyuncu_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delete_d_oyuncu_trigger AFTER DELETE ON public."Dizi_Oyuncu" FOR EACH ROW EXECUTE FUNCTION public.delete_oyuncu();


--
-- TOC entry 3322 (class 2620 OID 24713)
-- Name: Yonetmen delete_yonetmen_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delete_yonetmen_trigger AFTER DELETE ON public."Yonetmen" FOR EACH ROW EXECUTE FUNCTION public.delete_yonetmen();


--
-- TOC entry 3324 (class 2620 OID 24715)
-- Name: Kisiler insert_kisi_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_kisi_trigger AFTER INSERT ON public."Kisiler" FOR EACH ROW EXECUTE FUNCTION public.insert_kisi();


--
-- TOC entry 3321 (class 2620 OID 24707)
-- Name: Diziler trigger_silinen_dizi; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_silinen_dizi AFTER DELETE ON public."Diziler" FOR EACH ROW EXECUTE FUNCTION public.silinen_dizi();


--
-- TOC entry 3320 (class 2620 OID 24698)
-- Name: Filmler trigger_silinen_film; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_silinen_film AFTER DELETE ON public."Filmler" FOR EACH ROW EXECUTE FUNCTION public.silinen_film();


--
-- TOC entry 3310 (class 2606 OID 16628)
-- Name: Diziler Aciklama_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Aciklama_Id_fkey" FOREIGN KEY ("Acıklama_Id") REFERENCES public."Acıklama"("Acıklama_Id");


--
-- TOC entry 3299 (class 2606 OID 16595)
-- Name: Filmler Aciklama_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Aciklama_ıd_fkey" FOREIGN KEY ("Acıklama_Id") REFERENCES public."Acıklama"("Acıklama_Id") NOT VALID;


--
-- TOC entry 3319 (class 2606 OID 24671)
-- Name: Dizi_Oyuncu Dizi_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dizi_Oyuncu"
    ADD CONSTRAINT "Dizi_ıd_fkey" FOREIGN KEY ("Dizi_Id") REFERENCES public."Diziler"("Dizi_ıd") NOT VALID;


--
-- TOC entry 3315 (class 2606 OID 24666)
-- Name: Film_Oyuncu Film_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Film_Oyuncu"
    ADD CONSTRAINT "Film_Id_fkey" FOREIGN KEY ("Film_Id") REFERENCES public."Filmler"("Film_Id") NOT VALID;


--
-- TOC entry 3296 (class 2606 OID 16577)
-- Name: Filmler Fragman_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Fragman_ıd_fkey" FOREIGN KEY ("Fragman_Id") REFERENCES public."Fragman"("Fragman_Id") NOT VALID;


--
-- TOC entry 3304 (class 2606 OID 16613)
-- Name: Diziler Fragman_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Fragman_ıd_fkey" FOREIGN KEY ("Fragman_Id") REFERENCES public."Fragman"("Fragman_Id") NOT VALID;


--
-- TOC entry 3318 (class 2606 OID 16670)
-- Name: Dizi_Oyuncu Kisi_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dizi_Oyuncu"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Oyuncular"("Kisi_Id") NOT VALID;


--
-- TOC entry 3314 (class 2606 OID 16682)
-- Name: Film_Oyuncu Kisi_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Film_Oyuncu"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_ıd") REFERENCES public."Oyuncular"("Kisi_Id") NOT VALID;


--
-- TOC entry 3316 (class 2606 OID 24655)
-- Name: Yonetmen Kisi_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetmen"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;


--
-- TOC entry 3312 (class 2606 OID 24676)
-- Name: Diziler Kisi_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;


--
-- TOC entry 3302 (class 2606 OID 24681)
-- Name: Filmler Kisi_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Kisi_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;


--
-- TOC entry 3303 (class 2606 OID 24635)
-- Name: Filmler Liste_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Liste_Id_fkey" FOREIGN KEY ("Liste_Id") REFERENCES public."Listem"("Liste_Id") NOT VALID;


--
-- TOC entry 3311 (class 2606 OID 24643)
-- Name: Diziler Liste_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Liste_Id_fkey" FOREIGN KEY ("Liste_Id") REFERENCES public."Listem"("Liste_Id") NOT VALID;


--
-- TOC entry 3317 (class 2606 OID 24661)
-- Name: Oyuncular Oyuncu_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Oyuncular"
    ADD CONSTRAINT "Oyuncu_Id_fkey" FOREIGN KEY ("Kisi_Id") REFERENCES public."Kisiler"("Kisi_Id") NOT VALID;


--
-- TOC entry 3297 (class 2606 OID 16583)
-- Name: Filmler Platform_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Platform_ıd_fkey" FOREIGN KEY ("Platform_Id") REFERENCES public."Platform"("Platform_Id") NOT VALID;


--
-- TOC entry 3305 (class 2606 OID 16618)
-- Name: Diziler Platform_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Platform_ıd_fkey" FOREIGN KEY ("Platform_Id") REFERENCES public."Platform"("Platform_Id") NOT VALID;


--
-- TOC entry 3294 (class 2606 OID 16546)
-- Name: Listem Profil_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Listem"
    ADD CONSTRAINT "Profil_ıd_fkey" FOREIGN KEY ("Profil_Id") REFERENCES public."Profil"("Profil_Id") NOT VALID;


--
-- TOC entry 3313 (class 2606 OID 16552)
-- Name: Platform Rating_Puan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Platform"
    ADD CONSTRAINT "Rating_Puan_fkey" FOREIGN KEY ("Rating_Puan") REFERENCES public."Rating"("Rating_Puan") NOT VALID;


--
-- TOC entry 3308 (class 2606 OID 16644)
-- Name: Diziler Rating_Puan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Rating_Puan_fkey" FOREIGN KEY ("Rating_Puan") REFERENCES public."Rating"("Rating_Puan") NOT VALID;


--
-- TOC entry 3301 (class 2606 OID 16607)
-- Name: Filmler Rating_puan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Rating_puan_fkey" FOREIGN KEY ("Rating_Puan") REFERENCES public."Rating"("Rating_Puan") NOT VALID;


--
-- TOC entry 3298 (class 2606 OID 16589)
-- Name: Filmler Sehir_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Sehir_ıd_fkey" FOREIGN KEY ("Sehir_Id") REFERENCES public."Cekildigi_Yer"("Sehir_Id") NOT VALID;


--
-- TOC entry 3306 (class 2606 OID 16623)
-- Name: Diziler Sehir_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Sehir_ıd_fkey" FOREIGN KEY ("Sehir_Id") REFERENCES public."Cekildigi_Yer"("Sehir_Id") NOT VALID;


--
-- TOC entry 3295 (class 2606 OID 16571)
-- Name: Filmler Sponsor_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Sponsor_ıd_fkey" FOREIGN KEY ("Sponsor_ıd") REFERENCES public."Sponsor"("Sponsor_Id") NOT VALID;


--
-- TOC entry 3309 (class 2606 OID 16649)
-- Name: Diziler Sponsor_ıd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Sponsor_ıd_fkey" FOREIGN KEY ("Sponsor_ıd") REFERENCES public."Sponsor"("Sponsor_Id") NOT VALID;


--
-- TOC entry 3300 (class 2606 OID 16601)
-- Name: Filmler Tur_ad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Filmler"
    ADD CONSTRAINT "Tur_ad_fkey" FOREIGN KEY ("Tur_Ad") REFERENCES public."Tur"("Tur_Ad") NOT VALID;


--
-- TOC entry 3307 (class 2606 OID 16634)
-- Name: Diziler Tur_ad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diziler"
    ADD CONSTRAINT "Tur_ad_fkey" FOREIGN KEY ("Tur_ad") REFERENCES public."Tur"("Tur_Ad") NOT VALID;


-- Completed on 2022-12-26 17:17:51

--
-- PostgreSQL database dump complete
--

