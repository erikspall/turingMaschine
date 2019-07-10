using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace turingMachineInput
{
    public partial class inputDialog : Form
    {
        public string returnValue { get; set; }

        public inputDialog(int zustände, List<string> zeichen, int direction, bool isEnd,char c, int z)
        {
            InitializeComponent();
            switch (direction)
            {
                case 0:
                    radioButton1.Checked = true;
                    break;
                case 1:
                    radioButton2.Checked = true;
                    break;
                case 2:
                    radioButton3.Checked = true;
                    break;
                case -1:
                    radioButton2.Checked = true;
                    break;
            }
            foreach (string str in zeichen)
            {
                comboBox1.Items.Add(str);
            }
            for (int i = 0; i < zustände; i++)
            {
                comboBox2.Items.Add("Z"+i.ToString());
            }
            if (isEnd)
            {
                checkBox1.Checked = true;
            } else
            {
                checkBox1.Checked = false; 
            }

            comboBox1.Text = c.ToString();
            comboBox2.Text = "Z"+z.ToString();

        }

        

        private void Button1_Click(object sender, EventArgs e)
        {
            if (!checkBox1.Checked) { 
            returnValue = "";
            if (radioButton1.Checked)
            {
                returnValue += "L;";
            } else if (radioButton2.Checked)
            {
                returnValue += "0;";
            } else
            {
                returnValue += "R;";
            }

            returnValue += comboBox1.Text+";";
            returnValue += comboBox2.Text;
            } else
            {
                returnValue = "~ Ende ~";
            }
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            returnValue = "";
        }
    }
}
