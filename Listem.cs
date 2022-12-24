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
    public partial class Listem : Form
    {
        public Listem()
        {
            InitializeComponent();

        }
        private void btn_film_Click(object sender, EventArgs e)
        {
            Filmler flm = new Filmler();
            flm.Show();
            this.Hide();
        }

        private void btn_dizi_Click(object sender, EventArgs e)
        {
            Diziler dz = new Diziler();
            dz.Show();
            this.Hide();
        }
    }
}
