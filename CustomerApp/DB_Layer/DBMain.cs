using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CustomerApp.DB_Layer
{
    internal class DBMain
    {
        string strConnectionString = "Data Source = DESKTOP-3URLIGC;" + "Initial Catalog = QLTiemGame;" + "Integrated Security=True";
        //dt ket noi db
        SqlConnection conn = null;
        SqlCommand comm = null;
        SqlDataAdapter dataView = null;
        DataTable dataDisplayView = null;

        public DBMain()
        {
            conn = new SqlConnection(strConnectionString);
            comm = conn.CreateCommand();
        }

        public DataTable ExcuteQueryDataSet(string strSQL, CommandType ct)
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            comm.CommandText = strSQL;
            comm.CommandType = ct;
            dataView = new SqlDataAdapter(comm);

            dataDisplayView = new DataTable();

            dataView.Fill(dataDisplayView);
            return dataDisplayView;
        }

        public bool MyExecuteNonQuery(string strSQL, CommandType ct)
        {
            bool flag = false;
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            comm.CommandText = strSQL;
            comm.CommandType = ct;
            try
            {
                comm.ExecuteNonQuery();
                flag = true;
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
            return flag;

        }

        public bool checkCount(string strSQL, CommandType ct)
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            comm.CommandText = strSQL;
            comm.CommandType = ct;
            Int32 count = (Int32)comm.ExecuteScalar();
            if (count == 0)
            {
                return false;
            }
            return true;
        }

        public int getCount(string strSQL, CommandType ct)
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            comm.CommandText = strSQL;
            comm.CommandType = ct;
            Int32 count = (Int32)comm.ExecuteScalar();
            return count;
        }


    }
}
