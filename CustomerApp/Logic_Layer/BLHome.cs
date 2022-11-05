using CustomerApp.DB_Layer;
using Guna.UI2.AnimatorNS;
using System;
using System.Collections.Generic;
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
    }
}
