using CustomerApp.Logic_Layer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CustomerApp
{
    public partial class FormFood : Form
    {
        DataTable dtFood = null;
        BLService dbFood = new BLService();
        int row;
        string ma_dich_vu;

        public FormFood()
        {
            InitializeComponent();
            LoadListFood();
            this.txtNumber.Text = "1"; 
        }

        private void btnHome_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        public void LoadListFood()
        {
            try
            {
                dtFood = new DataTable();
                dtFood.Clear();

                DataTable dataDisplay = dbFood.getListFoods();
                dtFood = dataDisplay;
                dgvFood.ForeColor = Color.Black;
                dgvFood.DataSource = dtFood;

            }
            catch (SqlException e)
            {
                MessageBox.Show("Không lấy được danh sách. Lỗi: " + e.Message);
            }
        }

        private void dgvFood_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvFood.CurrentCell != null)
            {
                row = dgvFood.CurrentCell.RowIndex;
                ma_dich_vu = dgvFood.Rows[row].Cells[1].Value.ToString();
                this.txtNumber.Focus();
            }
        }

        private void btnOrder_Click(object sender, EventArgs e)
        {
            string number = this.txtNumber.Text.ToString().Trim();
            string ma_giam_gia = this.txtMGG.Text.ToString().Trim();

            string question = "Bạn chắc chắn muốn đặt " + number + " " 
                + dgvFood.Rows[row].Cells[3].Value.ToString() 
                + " với số tiền phải trả chưa tính giảm giá: " + Int32.Parse(dgvFood.Rows[row].Cells[4].Value.ToString()) * Int32.Parse(number) + " ?";
            DialogResult traloi;
            traloi = MessageBox.Show(question, "Trả lời", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);

            if (traloi == DialogResult.OK)
            {
                string ma_may = FormLogin.ma_may;
                if (ma_giam_gia == "")
                    dbFood.orderSerVice(ma_may, ma_dich_vu, number);
                else
                    dbFood.orderSerVice(ma_may, ma_dich_vu, number, ma_giam_gia);
                LoadListFood();
            }
        }
    }
}
