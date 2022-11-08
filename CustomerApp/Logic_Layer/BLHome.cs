using CustomerApp.DB_Layer;
using Guna.UI2.AnimatorNS;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomerApp.Logic_Layer
{
    internal class BLHome
    {
        DBMain db;

        public BLHome()
        {
            db = new DBMain();
        }

        public int GetMinute(string username)
        {
            string sqlStr = "SELECT dbo.SoPhutConLaiKhachHang('" + username + "')";
            int result = db.getCount(sqlStr, System.Data.CommandType.Text);
            return result;
        }

        public void MoMay(string ma_may)
        {
            string sqlStr = "EXEC proc_MoMay @ma_may = '" + ma_may + "'";
            db.MyExecuteNonQuery(sqlStr, CommandType.Text);
        }

        public void TatMay(string ma_may)
        {
            string sqlStr = "EXEC proc_TatMay @ma_may = '" + ma_may + "'";
            db.MyExecuteNonQuery(sqlStr, CommandType.Text);
        }

        public void CapNhapKhachHangSuDung(string ma_may, string username)
        {
            string sqlStr = "EXEC proc_CapNhapKhachHangSuDung @ma_may = '" + ma_may + "', @ten_dang_nhap = '" + username + "'";
            db.MyExecuteNonQuery(sqlStr, CommandType.Text);
        }
    }
}
