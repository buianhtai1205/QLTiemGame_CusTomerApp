using CustomerApp.Logic_Layer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CustomerApp
{
    public partial class FormLogin : Form
    {
        BLLogin dbLogin = new BLLogin();
        public bool isLogined = false;
        public static string username = "NULL";
        public static string ma_may = "MAY1";
        public FormLogin()
        {
            InitializeComponent();
            this.txtUsername.ResetText();
            this.txtPassword.ResetText();
            this.txtUsername.Focus();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            username = txtUsername.Text.ToString().Trim();
            String password = txtPassword.Text.ToString().Trim();

            bool check = false;

            check = dbLogin.checkUserAccount(username, password);

            if (check) 
            {
                isLogined = true;
                this.Close();
            } 
            else
            {
                MessageBox.Show("Tên đăng nhập hoặc mật khẩu không chính xác.", "Thông báo");
                this.txtPassword.ResetText();
                this.txtUsername.Focus();
            }
        }
    }
}
