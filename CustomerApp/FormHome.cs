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
    public partial class FormHome : Form
    {
        int minute = 0;
        int hour = 0;
        BLHome dbHome = new BLHome();

        public FormHome()
        {
            InitializeComponent();
            int so_phut_con_lai = dbHome.GetMinute(FormLogin.username);
            hour = so_phut_con_lai / 60;
            minute = so_phut_con_lai - hour * 60;

            setTimeLabel(hour, minute);

            this.timeCount.Start();
        }

        private void setTimeLabel(int labelHour, int labelMinute)
        {
            if (labelMinute < 10)
                lbMinute.Text = "0" + labelMinute.ToString();
            else
                lbMinute.Text = labelMinute.ToString();
            if (labelHour < 10)
                lbHour.Text = "0" + labelHour.ToString();
            else
                lbHour.Text = labelHour.ToString();
        }

        private void timeCount_Tick(object sender, EventArgs e)
        {
            if (hour < 0)
            {
                this.timeCount.Stop();
                this.Close();
            }
            minute = minute - 1;
            setTimeLabel(hour, minute);
            if (minute == 0)
            {
                minute = 60;
                hour = hour - 1;
            }
            if (hour == 0 && minute == 5)
                MessageBox.Show("Bạn chỉ còn 5 phút. Vui lòng nạp tiền!");
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnFood_Click(object sender, EventArgs e)
        {
            FormFood formFood = new FormFood();
            formFood.ShowDialog();
        }

        private void btnDrink_Click(object sender, EventArgs e)
        {
            FormDrink formDrink = new FormDrink();
            formDrink.ShowDialog();
        }

        private void btnCard_Click(object sender, EventArgs e)
        {
            FormCard formCard = new FormCard();
            formCard.ShowDialog();
        }
    }
}
