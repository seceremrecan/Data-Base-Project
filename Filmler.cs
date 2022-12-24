using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VeriTabanı_Projesi
{
    public partial class Filmler : Form
    {
        public Filmler()
        {
            InitializeComponent();
        }
        NpgsqlConnection connect = new NpgsqlConnection("server=localhost; port=5432; Database=Data_Base_Project; user ID=postgres; password=258258258");
        private void button1_Click(object sender, EventArgs e)
        {

            string query = "select * from \"Filmler\"";



            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_film.DataSource = ds.Tables[0];
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Listem lst = new Listem();
            lst.Show();
            this.Hide();
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void textBox11_TextChanged(object sender, EventArgs e)
        {

        }

        private void btn_silinen_Filmler_Click(object sender, EventArgs e)
        {
            string silinen_Film_query = "SELECT * FROM \"silinen_Film\" order by film_ıd ";
            NpgsqlDataAdapter silinen_Film_adapter = new NpgsqlDataAdapter(silinen_Film_query, connect);

            DataTable dt = new DataTable();
            silinen_Film_adapter.Fill(dt);
            data_grid_film.DataSource = dt;
        }

        private void btn_film_oyuncu_Click(object sender, EventArgs e)
        {
            string filmOyuncuListele = "select  o.\"Kisi_Id\",o.\"Kisi_Ad\",o.\"Kisi_Soyad\" from \"Kisiler\" as o inner join \"Film_Oyuncu\" as b on b.\"Kisi_ıd\" = o.\"Kisi_Id\"";


            NpgsqlDataAdapter da = new NpgsqlDataAdapter(filmOyuncuListele, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_film.DataSource = ds.Tables[0];
        }

        private void btn_film_ekle_Click(object sender, EventArgs e)
        {
            connect.Open();
            NpgsqlCommand insertCommand = new NpgsqlCommand("insert into \"Filmler\" values(@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12)", connect);
            insertCommand.Parameters.AddWithValue("@p1",txt_film_ad.Text);//int
            insertCommand.Parameters.AddWithValue("@p2",int.Parse(txt_film_kisi_id.Text));
            insertCommand.Parameters.AddWithValue("@p12",int.Parse(txt_film_liste_id.Text));
            insertCommand.Parameters.AddWithValue("@p3", int.Parse(txt_film_fragman_id.Text));
            insertCommand.Parameters.AddWithValue("@p4", txt_film_sure.Text);
            insertCommand.Parameters.AddWithValue("@p5", int.Parse(txt_film_platform_id.Text));
            insertCommand.Parameters.AddWithValue("@p6", int.Parse(txt_film_sehir_id.Text));
            insertCommand.Parameters.AddWithValue("@p7", int.Parse(txt_film_aciklama_id.Text));
            insertCommand.Parameters.AddWithValue("@p8", int.Parse(txt_film_rating_puan.Text));
            insertCommand.Parameters.AddWithValue("@p9", int.Parse(txt_film_sponsor_id.Text));
            insertCommand.Parameters.AddWithValue("@p10", txt_film_tur_ad.Text);
            insertCommand.Parameters.AddWithValue("@p11", int.Parse(txt_film_id.Text));
            insertCommand.ExecuteNonQuery();//degisikleri veri tabanina yansit
            connect.Close();
            MessageBox.Show("Ekleme Başarılı");
            foreach (Control item in this.Controls)
            {
                if (item is TextBox)
                {
                    (item as TextBox).Clear();
                }
            }
            string query = "select \"Film_Adı\",\"Kisi_Ad\",\"Fragman_Sure\",\"Film_Süre\",\"Platform_Ad\",\"Sehir_Ad\",\"Acıklama_Icerik\",\"Sponsor_Ad\",\"Tur_Ad\",\"Film_Id\",\"Liste_Id\" from \"Filmler\"  inner join \"Kisiler\" on \"Filmler\".\"Kisi_Id\" = \"Kisiler\".\"Kisi_Id\" inner join \"Fragman\" on \"Filmler\".\"Fragman_Id\" = \"Fragman\".\"Fragman_Id\" inner join \"Platform\" on \"Filmler\".\"Platform_Id\" = \"Platform\".\"Platform_Id\" inner join \"Cekildigi_Yer\" on \"Filmler\".\"Sehir_Id\" = \"Cekildigi_Yer\".\"Sehir_Id\" inner join \"Acıklama\" on \"Filmler\".\"Acıklama_Id\" = \"Acıklama\".\"Acıklama_Id\" inner join \"Sponsor\" on \"Filmler\".\"Sponsor_ıd\" = \"Sponsor\".\"Sponsor_Id\" order by \"Film_Id\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_film.DataSource = ds.Tables[0];

        }

        private void btn_film_guncelle_Click(object sender, EventArgs e)
        {
            connect.Open();
            NpgsqlCommand insertCommand = new NpgsqlCommand("UPDATE \"Filmler\" SET \"Film_Adı\"=@p1,\"Kisi_Id\"=@p2,\"Fragman_Id\"=@p3,\"Film_Süre\"=@p4,\"Platform_Id\"=@p5,\"Sehir_Id\"=@p6,\"Acıklama_Id\"=@p7,\"Rating_Puan\"=@p8,\"Sponsor_ıd\"=@p9,\"Tur_Ad\"=@p10,\"Liste_Id\"=@p12 WHERE \"Film_Id\"=@p11", connect);
            insertCommand.Parameters.AddWithValue("@p1", txt_film_ad.Text);//int
            insertCommand.Parameters.AddWithValue("@p2", int.Parse(txt_film_kisi_id.Text));
            insertCommand.Parameters.AddWithValue("@p12", int.Parse(txt_film_liste_id.Text));
            insertCommand.Parameters.AddWithValue("@p3", int.Parse(txt_film_fragman_id.Text));
            insertCommand.Parameters.AddWithValue("@p4", txt_film_sure.Text);
            insertCommand.Parameters.AddWithValue("@p5", int.Parse(txt_film_platform_id.Text));
            insertCommand.Parameters.AddWithValue("@p6", int.Parse(txt_film_sehir_id.Text));
            insertCommand.Parameters.AddWithValue("@p7", int.Parse(txt_film_aciklama_id.Text));
            insertCommand.Parameters.AddWithValue("@p8", int.Parse(txt_film_rating_puan.Text));
            insertCommand.Parameters.AddWithValue("@p9", int.Parse(txt_film_sponsor_id.Text));
            insertCommand.Parameters.AddWithValue("@p10", txt_film_tur_ad.Text);
            insertCommand.Parameters.AddWithValue("@p11", int.Parse(txt_film_id.Text));
            insertCommand.ExecuteNonQuery();//degisikleri veri tabanina yansit
            connect.Close();
            MessageBox.Show("Güncelleme Başarılı");
            foreach (Control item in this.Controls)
            {
                if (item is TextBox)
                {
                    (item as TextBox).Clear();
                }
            }
            string query = "select \"Film_Adı\",\"Kisi_Ad\",\"Fragman_Sure\",\"Film_Süre\",\"Platform_Ad\",\"Sehir_Ad\",\"Acıklama_Icerik\",\"Sponsor_Ad\",\"Tur_Ad\",\"Film_Id\",\"Liste_Id\" from \"Filmler\"  inner join \"Kisiler\" on \"Filmler\".\"Kisi_Id\" = \"Kisiler\".\"Kisi_Id\" inner join \"Fragman\" on \"Filmler\".\"Fragman_Id\" = \"Fragman\".\"Fragman_Id\" inner join \"Platform\" on \"Filmler\".\"Platform_Id\" = \"Platform\".\"Platform_Id\" inner join \"Cekildigi_Yer\" on \"Filmler\".\"Sehir_Id\" = \"Cekildigi_Yer\".\"Sehir_Id\" inner join \"Acıklama\" on \"Filmler\".\"Acıklama_Id\" = \"Acıklama\".\"Acıklama_Id\" inner join \"Sponsor\" on \"Filmler\".\"Sponsor_ıd\" = \"Sponsor\".\"Sponsor_Id\" order by \"Film_Id\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_film.DataSource = ds.Tables[0];
        }

        private void btn_film_sil_Click(object sender, EventArgs e)
        {
            connect.Open();
            NpgsqlCommand deleteCommand = new NpgsqlCommand("DELETE From  \"Filmler\" where \"Film_Id\"=@p1", connect);
            deleteCommand.Parameters.AddWithValue("@p1", int.Parse(txt_film_id.Text));
            deleteCommand.ExecuteNonQuery();
            connect.Close();
            MessageBox.Show("Silme Başarılı");
            //listeleme
            string query = "select \"Film_Adı\",\"Kisi_Ad\",\"Fragman_Sure\",\"Film_Süre\",\"Platform_Ad\",\"Sehir_Ad\",\"Acıklama_Icerik\",\"Sponsor_Ad\",\"Tur_Ad\",\"Film_Id\",\"Liste_Id\" from \"Filmler\"  inner join \"Kisiler\" on \"Filmler\".\"Kisi_Id\" = \"Kisiler\".\"Kisi_Id\" inner join \"Fragman\" on \"Filmler\".\"Fragman_Id\" = \"Fragman\".\"Fragman_Id\" inner join \"Platform\" on \"Filmler\".\"Platform_Id\" = \"Platform\".\"Platform_Id\" inner join \"Cekildigi_Yer\" on \"Filmler\".\"Sehir_Id\" = \"Cekildigi_Yer\".\"Sehir_Id\" inner join \"Acıklama\" on \"Filmler\".\"Acıklama_Id\" = \"Acıklama\".\"Acıklama_Id\" inner join \"Sponsor\" on \"Filmler\".\"Sponsor_ıd\" = \"Sponsor\".\"Sponsor_Id\" order by \"Film_Id\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_film.DataSource = ds.Tables[0];
        }
    }
}
