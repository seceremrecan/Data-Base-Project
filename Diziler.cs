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
    public partial class Diziler : Form
    {
        public Diziler()
        {
            InitializeComponent();
        }

        private void Diziler_Load(object sender, EventArgs e)
        {

        }
        NpgsqlConnection connect = new NpgsqlConnection("server=localhost; port=5432; Database=Data_Base_Project; user ID=postgres; password=258258258");
        private void button1_Click(object sender, EventArgs e)
        {

            string query = "select * from \"Diziler\"";



            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_dizi.DataSource = ds.Tables[0];
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Listem dlst = new Listem();
            dlst.Show();
            this.Hide();
        }

        private void btn_dizi_oyuncu_Click(object sender, EventArgs e)
        {
            string diziOyuncuListele = "select  o.\"Kisi_Id\",o.\"Kisi_Ad\",o.\"Kisi_Soyad\" from \"Kisiler\" as o inner join \"Dizi_Oyuncu\" as b on b.\"Kisi_Id\" = o.\"Kisi_Id\"";


            NpgsqlDataAdapter da = new NpgsqlDataAdapter(diziOyuncuListele, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_dizi.DataSource = ds.Tables[0];
        }

        private void btn_dizi_ekle_Click(object sender, EventArgs e)
        {
            //1,'Mr.Robot',4,4,4,1,4,4,9,4,'Psikolojik Gerilim',4
            connect.Open();
            NpgsqlCommand insertCommand = new NpgsqlCommand("insert into \"Diziler\" values(@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12)", connect);
            insertCommand.Parameters.AddWithValue("@p1", int.Parse(txt_dizi_liste_id.Text));//int
            insertCommand.Parameters.AddWithValue("@p2", txt_dizi_ad.Text);
            insertCommand.Parameters.AddWithValue("@p3", int.Parse(txt_dizi_kisi_id.Text));
            insertCommand.Parameters.AddWithValue("@p4", int.Parse(txt_dizi_fragman_id.Text));
            insertCommand.Parameters.AddWithValue("@p5", int.Parse(txt_dizi_sezon_sayisi.Text));
            insertCommand.Parameters.AddWithValue("@p6", int.Parse(txt_dizi_platform_id.Text));
            insertCommand.Parameters.AddWithValue("@p7", int.Parse(txt_dizi_sehir_id.Text));
            insertCommand.Parameters.AddWithValue("@p8", int.Parse(txt_dizi_aciklama_id.Text));
            insertCommand.Parameters.AddWithValue("@p9", int.Parse(txt_dizi_rating_puan.Text));
            insertCommand.Parameters.AddWithValue("@p10", int.Parse(txt_dizi_sponsor_id.Text));
            insertCommand.Parameters.AddWithValue("@p11", txt_dizi_tur_ad.Text);
            insertCommand.Parameters.AddWithValue("@p12", int.Parse(txt_dizi_id.Text));
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
            string query = "select \"Liste_Id\",\"Dizi_Adı\",\"Kisi_Ad\",\"Fragman_Sure\",\"Platform_Ad\",\"Sezon_Sayısı\",\"Sehir_Ad\",\"Acıklama_Icerik\",\"Sponsor_Ad\",\"Tur_ad\",\"Dizi_ıd\" from \"Diziler\"  inner join \"Fragman\" on \"Diziler\".\"Fragman_Id\" = \"Fragman\".\"Fragman_Id\" inner join \"Platform\" on \"Diziler\".\"Platform_Id\" = \"Platform\".\"Platform_Id\" inner join \"Cekildigi_Yer\" on \"Diziler\".\"Sehir_Id\" = \"Cekildigi_Yer\".\"Sehir_Id\" inner join \"Acıklama\" on \"Diziler\".\"Acıklama_Id\" = \"Acıklama\".\"Acıklama_Id\" inner join \"Sponsor\" on \"Diziler\".\"Sponsor_ıd\" = \"Sponsor\".\"Sponsor_Id\" inner join \"Kisiler\" on \"Diziler\".\"Kisi_Id\" = \"Kisiler\".\"Kisi_Id\" order by \"Dizi_ıd\""; ;
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_dizi.DataSource = ds.Tables[0];

        }

        private void button5_Click(object sender, EventArgs e)
        {
            connect.Open();
            NpgsqlCommand updateCommand = new NpgsqlCommand("UPDATE \"Diziler\" SET \"Liste_Id\"=@p1,\"Dizi_Adı\"=@p2,\"Kisi_Id\"=@p3,\"Fragman_Id\"=@p4,\"Sezon_Sayısı\"=@p5,\"Platform_Id\"=@p6,\"Sehir_Id\"=@p7,\"Acıklama_Id\"=@p8,\"Rating_Puan\"=@p9,\"Sponsor_ıd\"=@p10,\"Tur_ad\"=@p11 WHERE \"Dizi_ıd\"=@p12", connect);
            
            updateCommand.Parameters.AddWithValue("@p1", int.Parse(txt_dizi_liste_id.Text));
            updateCommand.Parameters.AddWithValue("@p2", txt_dizi_ad.Text);
            updateCommand.Parameters.AddWithValue("@p3", int.Parse(txt_dizi_kisi_id.Text));
            updateCommand.Parameters.AddWithValue("@p4", int.Parse(txt_dizi_fragman_id.Text));
            updateCommand.Parameters.AddWithValue("@p5", int.Parse(txt_dizi_sezon_sayisi.Text));
            updateCommand.Parameters.AddWithValue("@p6", int.Parse(txt_dizi_platform_id.Text));
            updateCommand.Parameters.AddWithValue("@p7", int.Parse(txt_dizi_sehir_id.Text));
            updateCommand.Parameters.AddWithValue("@p8", int.Parse(txt_dizi_aciklama_id.Text));
            updateCommand.Parameters.AddWithValue("@p9", int.Parse(txt_dizi_rating_puan.Text));
            updateCommand.Parameters.AddWithValue("@p10", int.Parse(txt_dizi_sponsor_id.Text));
            updateCommand.Parameters.AddWithValue("@p11", txt_dizi_tur_ad.Text);
            updateCommand.Parameters.AddWithValue("@p12", int.Parse(txt_dizi_id.Text));//int
            updateCommand.ExecuteNonQuery();//degisikleri veri tabanina yansit
            connect.Close();
            MessageBox.Show("Güncelleme Başarılı");
            foreach (Control item in this.Controls)
            {
                if (item is TextBox)
                {
                    (item as TextBox).Clear();
                }
            }
            string query = "select \"Liste_Id\",\"Dizi_Adı\",\"Kisi_Ad\",\"Fragman_Sure\",\"Platform_Ad\",\"Sezon_Sayısı\",\"Sehir_Ad\",\"Acıklama_Icerik\",\"Sponsor_Ad\",\"Tur_ad\",\"Dizi_ıd\" from \"Diziler\"  inner join \"Fragman\" on \"Diziler\".\"Fragman_Id\" = \"Fragman\".\"Fragman_Id\" inner join \"Platform\" on \"Diziler\".\"Platform_Id\" = \"Platform\".\"Platform_Id\" inner join \"Cekildigi_Yer\" on \"Diziler\".\"Sehir_Id\" = \"Cekildigi_Yer\".\"Sehir_Id\" inner join \"Acıklama\" on \"Diziler\".\"Acıklama_Id\" = \"Acıklama\".\"Acıklama_Id\" inner join \"Sponsor\" on \"Diziler\".\"Sponsor_ıd\" = \"Sponsor\".\"Sponsor_Id\" inner join \"Kisiler\" on \"Diziler\".\"Kisi_Id\" = \"Kisiler\".\"Kisi_Id\" order by \"Dizi_ıd\""; ;
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_dizi.DataSource = ds.Tables[0];
        }

        private void button4_Click(object sender, EventArgs e)
        {
            connect.Open();
            NpgsqlCommand deleteCommand = new NpgsqlCommand("DELETE From  \"Diziler\" where \"Dizi_ıd\"=@p1", connect);
            deleteCommand.Parameters.AddWithValue("@p1", int.Parse(txt_dizi_id.Text));
            deleteCommand.ExecuteNonQuery();
            connect.Close();
            MessageBox.Show("Silme Başarılı");
            //listeleme
            string sorgu = "select \"Liste_Id\",\"Dizi_Adı\",\"Kisi_Ad\",\"Fragman_Sure\",\"Platform_Ad\",\"Sezon_Sayısı\",\"Sehir_Ad\",\"Acıklama_Icerik\",\"Sponsor_Ad\",\"Tur_ad\",\"Dizi_ıd\" from \"Diziler\"  inner join \"Fragman\" on \"Diziler\".\"Fragman_Id\" = \"Fragman\".\"Fragman_Id\" inner join \"Platform\" on \"Diziler\".\"Platform_Id\" = \"Platform\".\"Platform_Id\" inner join \"Cekildigi_Yer\" on \"Diziler\".\"Sehir_Id\" = \"Cekildigi_Yer\".\"Sehir_Id\" inner join \"Acıklama\" on \"Diziler\".\"Acıklama_Id\" = \"Acıklama\".\"Acıklama_Id\" inner join \"Sponsor\" on \"Diziler\".\"Sponsor_ıd\" = \"Sponsor\".\"Sponsor_Id\" inner join \"Kisiler\" on \"Diziler\".\"Kisi_Id\" = \"Kisiler\".\"Kisi_Id\" order by \"Dizi_ıd\""; ;
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, connect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_dizi.DataSource = ds.Tables[0];
        }

        private void btn_silinen_Dizi_Click(object sender, EventArgs e)
        {
            string silinen_Dizi_query = "SELECT * FROM \"silinen_Dizi\" order by dizi_ıd ";
            NpgsqlDataAdapter silinen_Dizi_adapter = new NpgsqlDataAdapter(silinen_Dizi_query, connect);

            DataTable dt = new DataTable();
            silinen_Dizi_adapter.Fill(dt);
            data_grid_dizi.DataSource = dt;
        }

        private void btn_kisi_ekle_Click(object sender, EventArgs e)
        {
            Kisiler persons = new Kisiler();
            persons.Show();
           
        }
    }
}
