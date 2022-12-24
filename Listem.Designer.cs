
namespace VeriTabanı_Projesi
{
    partial class Listem
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btn_film = new System.Windows.Forms.Button();
            this.btn_dizi = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // btn_film
            // 
            this.btn_film.Font = new System.Drawing.Font("Corbel", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btn_film.Location = new System.Drawing.Point(249, 156);
            this.btn_film.Name = "btn_film";
            this.btn_film.Size = new System.Drawing.Size(110, 61);
            this.btn_film.TabIndex = 0;
            this.btn_film.Text = "FİLMLER";
            this.btn_film.UseVisualStyleBackColor = true;
            this.btn_film.Click += new System.EventHandler(this.btn_film_Click);
            // 
            // btn_dizi
            // 
            this.btn_dizi.Font = new System.Drawing.Font("Corbel", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btn_dizi.Location = new System.Drawing.Point(424, 156);
            this.btn_dizi.Name = "btn_dizi";
            this.btn_dizi.Size = new System.Drawing.Size(107, 61);
            this.btn_dizi.TabIndex = 1;
            this.btn_dizi.Text = "DİZİLER";
            this.btn_dizi.UseVisualStyleBackColor = true;
            this.btn_dizi.Click += new System.EventHandler(this.btn_dizi_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new System.Drawing.Point(405, 262);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(125, 62);
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            // 
            // Listem
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(224)))), ((int)(((byte)(192)))));
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.btn_dizi);
            this.Controls.Add(this.btn_film);
            this.Name = "Listem";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Listem";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btn_film;
        private System.Windows.Forms.Button btn_dizi;
        private System.Windows.Forms.PictureBox pictureBox1;
    }
}