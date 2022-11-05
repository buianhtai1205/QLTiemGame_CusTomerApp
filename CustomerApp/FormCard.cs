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
    public partial class FormCard : Form
    {
        DataTable dtCard = null;
        BLService dbCard = new BLService();
        int row;
        string ma_dich_vu;

        public FormCard()
        {
            InitializeComponent();
            LoadListCard();
            this.txtNumber.Text = "1";
        }

        private void btnHome_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        public void LoadListCard()
        {
            try
            {
                dtCard = new DataTable();
                dtCard.Clear();

                DataTable dataDisplay = dbCard.getListCards();
                dtCard = dataDisplay;
                dgvCard.ForeColor = Color.Black;
                dgvCard.DataSource = dtCard;

            }
            catch (SqlException e)
            {
                MessageBox.Show("Không lấy được danh sách. Lỗi: " + e.Message);
            }
        }

        private void dgvCard_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvCard.CurrentCell != null)
            {
                row = dgvCard.CurrentCell.RowIndex;
                ma_dich_vu = dgvCard.Rows[row].Cells[1].Value.ToString();
                this.txtNumber.Focus();
            }
        }

        private void btnOrder_Click(object sender, EventArgs e)
        {
            string number = this.txtNumber.Text.ToString().Trim();
            string ma_giam_gia = this.txtMGG.Text.ToString().Trim();

            string question = "Bạn chắc chắn muốn đặt " + number + " "
                + dgvCard.Rows[row].Cells[3].Value.ToString()
                + " với số tiền phải trả chưa tính giảm giá: " + Int32.Parse(dgvCard.Rows[row].Cells[4].Value.ToString()) * Int32.Parse(number) + " ?";
            DialogResult traloi;
            traloi = MessageBox.Show(question, "Trả lời", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);

            if (traloi == DialogResult.OK)
            {
                string ma_may = FormLogin.ma_may;
                if (ma_giam_gia == "")
                    dbCard.orderSerVice(ma_may, ma_dich_vu, number);
                else
                    dbCard.orderSerVice(ma_may, ma_dich_vu, number, ma_giam_gia);
                LoadListCard();
            }
        }
    }
}
