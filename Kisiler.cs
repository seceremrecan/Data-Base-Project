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
    public partial class Kisiler : Form
    {
        public Kisiler()
        {
            InitializeComponent();
        }
        NpgsqlConnection connectKisi = new NpgsqlConnection("server=localhost; port=5432; Database=Data_Base_Project; user ID=postgres; password=258258258");

        private void button1_Click(object sender, EventArgs e)
        {
            connectKisi.Open();
            NpgsqlCommand insertCommand = new NpgsqlCommand("insert into \"Kisiler\" values(@p1,@p2,@p3,@p4,@p5,@p6)", connectKisi);
            insertCommand.Parameters.AddWithValue("@p1",int.Parse(txt_kisiler_kisi_ıd.Text));
            insertCommand.Parameters.AddWithValue("@p2", txt_kisiler_kisi_ad.Text);
            insertCommand.Parameters.AddWithValue("@p3", txt_kisiler_kisi_soyad.Text);
            insertCommand.Parameters.AddWithValue("@p4", int.Parse(txt_kisiler_kisi_tel.Text));
            insertCommand.Parameters.AddWithValue("@p5", txt_kisiler_kisi_adres.Text);
            insertCommand.Parameters.AddWithValue("@p6", txt_kisiler_kisi_kategori.Text);
            insertCommand.ExecuteNonQuery();//degisikleri veri tabanina yansit
            connectKisi.Close();
            MessageBox.Show("Ekleme Başarılı");
            foreach (Control item in this.Controls)
            {
                if (item is TextBox)
                {
                    (item as TextBox).Clear();
                }
            }
            string query = "select * from \"Kisiler\""; 
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connectKisi);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_kisiler.DataSource = ds.Tables[0];
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string query = "select * from \"Kisiler\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connectKisi);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_kisiler.DataSource = ds.Tables[0];
        }

        private void button2_Click(object sender, EventArgs e)
        {
            connectKisi.Open();
            NpgsqlCommand deleteCommand = new NpgsqlCommand("DELETE From  \"Yonetmen\" where \"Kisi_Id\"=@p1", connectKisi);
            deleteCommand.Parameters.AddWithValue("@p1", int.Parse(txt_kisiler_kisi_ıd.Text));
            deleteCommand.ExecuteNonQuery();
            connectKisi.Close();
            MessageBox.Show("Silme Başarılı");
            //listeleme
            string query = "select \"Yonetmen\".\"Kisi_Id\",\"Kisi_Ad\",\"Kisi_Soyad\" from \"Yonetmen\" inner join \"Kisiler\" on \"Kisiler\".\"Kisi_Id\" = \"Yonetmen\".\"Kisi_Id\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connectKisi);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_kisiler.DataSource = ds.Tables[0];
        }

        private void button5_Click(object sender, EventArgs e)
        {
            string query = "select \"Yonetmen\".\"Kisi_Id\",\"Kisi_Ad\",\"Kisi_Soyad\" from \"Yonetmen\" inner join \"Kisiler\" on \"Kisiler\".\"Kisi_Id\" = \"Yonetmen\".\"Kisi_Id\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connectKisi);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_kisiler.DataSource = ds.Tables[0];
        }

        private void button3_Click(object sender, EventArgs e)
        {
            connectKisi.Open();
            NpgsqlCommand deleteCommand = new NpgsqlCommand("DELETE From  \"Dizi_Oyuncu\" where \"Kisi_Id\"=@p1", connectKisi);
            deleteCommand.Parameters.AddWithValue("@p1", int.Parse(txt_kisiler_kisi_ıd.Text));
            deleteCommand.ExecuteNonQuery();
            connectKisi.Close();
            MessageBox.Show("Silme Başarılı");
            //listeleme
            string query = "select \"Dizi_Oyuncu\".\"Kisi_Id\",\"Kisi_Ad\",\"Kisi_Soyad\" from \"Dizi_Oyuncu\" inner join \"Kisiler\" on \"Kisiler\".\"Kisi_Id\" = \"Dizi_Oyuncu\".\"Kisi_Id\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connectKisi);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_kisiler.DataSource = ds.Tables[0];
        }

        private void button6_Click(object sender, EventArgs e)
        {
            string query = "select \"Oyuncular\".\"Kisi_Id\",\"Kisi_Ad\",\"Kisi_Soyad\",\"Oyuncu_Kategori\" from \"Oyuncular\" inner join \"Kisiler\" on \"Kisiler\".\"Kisi_Id\" = \"Oyuncular\".\"Kisi_Id\"  ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connectKisi);
            DataSet ds = new DataSet();
            da.Fill(ds);
            data_grid_kisiler.DataSource = ds.Tables[0];
        }
    }
}
