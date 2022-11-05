using CustomerApp.DB_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CustomerApp.Logic_Layer
{
    internal class BLService
    {
        DBMain db;

        public BLService()
        {
            db = new DBMain();
        }

        public DataTable getListFoods()
        {
            DataTable dt = new DataTable();
            string sqlStr = "SELECT * FROM XemDanhSachThucAn";
            dt = db.ExcuteQueryDataSet(sqlStr, CommandType.Text);
            return dt;
        }

        public DataTable getListDrinks()
        {
            DataTable dt = new DataTable();
            string sqlStr = "SELECT * FROM XemDanhSachNuocUong";
            dt = db.ExcuteQueryDataSet(sqlStr, CommandType.Text);
            return dt;
        }

        public DataTable getListCards()
        {
            DataTable dt = new DataTable();
            string sqlStr = "SELECT * FROM XemDanhSachTheGame";
            dt = db.ExcuteQueryDataSet(sqlStr, CommandType.Text);
            return dt;
        }

        public void orderSerVice(string ma_may, string ma_dich_vu, string number, string ma_giam_gia = "NULL")
        {
            string varStr;
            if (ma_giam_gia != "NULL")
            {
                if (checkUuDai(ma_giam_gia) == true)
                {
                    varStr = "@ma_dich_vu = '" + ma_dich_vu + "', @so_luong_mua = '" + number + "', @ma_may = '" + ma_may + "', @ma_uu_dai = '" + ma_giam_gia + "'";
                    string sqlStr = "EXEC proc_OrderDichVu " + varStr;
                    db.MyExecuteNonQuery(sqlStr, CommandType.Text);
                }
                else
                {
                    MessageBox.Show("Mã giảm giá bạn nhập không tồn tại.");
                }
            }
            else
            {
                varStr = "@ma_dich_vu = '" + ma_dich_vu + "', @so_luong_mua = '" + number + "', @ma_may = '" + ma_may + "'";
                string sqlStr = "EXEC proc_OrderDichVu " + varStr;
                db.MyExecuteNonQuery(sqlStr, CommandType.Text);
            }
            
        }

        public bool checkUuDai(string ma_giam_gia)
        {
            return false;
        }
    }
}
