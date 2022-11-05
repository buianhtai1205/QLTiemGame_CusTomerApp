using CustomerApp.DB_Layer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CustomerApp.Logic_Layer
{
    internal class BLLogin
    {
        DBMain db;

        public BLLogin()
        {
            db = new DBMain();
        }
        public bool checkUserAccount(String username, String password)
        {
            bool flag = false;
            string sqlStr = "SELECT dbo.CheckKhachHang('" + username + "', '" + password + "')";
            flag = db.checkCount(sqlStr, System.Data.CommandType.Text);
            return flag;
        }
    }
}
