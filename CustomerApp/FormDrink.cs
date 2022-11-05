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
    public partial class FormDrink : Form
    {
        DataTable dtDrink = null;
        BLService dbDrink = new BLService();
        int row;
        string ma_dich_vu;

        public FormDrink()
        {
            InitializeComponent();
            LoadListDrink();
            this.txtNumber.Text = "1";
        }

        private void btnHome_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void LoadListDrink()
        {
            try
            {
                dtDrink = new DataTable();
                dtDrink.Clear();

                DataTable dataDisplay = dbDrink.getListDrinks();
                dtDrink = dataDisplay;
                dgvDrink.ForeColor = Color.Black;
                dgvDrink.DataSource = dtDrink;
            }
            catch (SqlException e)
            {
                MessageBox.Show("Không lấy được danh sách. Lỗi: " + e.Message);
            }
        }

        private void dgvDrink_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvDrink.CurrentCell != null)
            {
                row = dgvDrink.CurrentCell.RowIndex;
                ma_dich_vu = dgvDrink.Rows[row].Cells[1].Value.ToString();
                this.txtNumber.Focus();
            }
        }

        private void btnOrder_Click(object sender, EventArgs e)
        {
            string number = this.txtNumber.Text.ToString().Trim();
            string ma_giam_gia = this.txtMGG.Text.ToString().Trim();

            string question = "Bạn chắc chắn muốn đặt " + number + " "
                + dgvDrink.Rows[row].Cells[3].Value.ToString()
                + " với số tiền phải trả chưa tính giảm giá: " + Int32.Parse(dgvDrink.Rows[row].Cells[4].Value.ToString()) * Int32.Parse(number) + " ?";
            DialogResult traloi;
            traloi = MessageBox.Show(question, "Trả lời", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);

            if (traloi == DialogResult.OK)
            {
                string ma_may = FormLogin.ma_may;
                if (ma_giam_gia == "")
                    dbDrink.orderSerVice(ma_may, ma_dich_vu, number);
                else
                    dbDrink.orderSerVice(ma_may, ma_dich_vu, number, ma_giam_gia);
                LoadListDrink();
            }
        }
    }
}
