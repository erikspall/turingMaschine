using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WpfControlLibrary1;


namespace turingMachine
{
    public partial class Form1 : Form
    {
        Random rnd = new Random();
        string abc,input="";
        bool isRunning = false;


        int currentS,steps,animatedTiles = 0;
        public Form1()
        {
            InitializeComponent();
            //dataGridView1.Columns.Add("zustände", "");
            dataGridView1.Columns.Add(UserControl1.blank, UserControl1.blank);
            dataGridView1.Rows.Add(new DataGridViewRow());
            dataGridView1.RowHeadersWidth = 61;
            dataGridView1.Rows[0].HeaderCell.Value = "Z0";
            dataGridView1.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            UserControl1.tA.Completed += new EventHandler(myanim_Completed);

        }

        private void myanim_Completed(object sender, EventArgs e)
        {
           // MessageBox.Show(UserControl1.tape[0].Margin.Left.ToString());
            if (isRunning) { 
            if (animatedTiles >= UserControl1.tape.Count)
            {
                // MessageBox.Show("Jo");
                timer1.Enabled = true;
                animatedTiles = 0;
            } else
            {
                animatedTiles++;
            }
            }
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
           
           
        }

        private void Form1_Click(object sender, EventArgs e)
        {
           
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            
        }

        private void Form1_Shown(object sender, EventArgs e)
        {
          //  MessageBox.Show(UserControl1.currentItem().ToString());
            label1.Margin = new Padding((UserControl1.sizing * (UserControl1.currentItem()-1)) + (UserControl1.sizing/4)+1,0,0,0);
            
        }

        private void Form1_Resize(object sender, EventArgs e)
        {
            

            label1.Margin = new Padding((UserControl1.sizing * (UserControl1.currentItem() - 1)) + (UserControl1.sizing / 4) + 1, 0, 0, 0);
            label1.Margin = new Padding((UserControl1.sizing * (UserControl1.currentItem() - 1)) + (UserControl1.sizing / 4) + 1, 0, 0, 0);
        }

        private void SplitContainer1_Paint(object sender, PaintEventArgs e)
        {
            
        }

        private void LinkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            System.Diagnostics.Process.Start("https://github.com/erikspall/turingMaschine");
        }

        private void TextBoxAlphabet_Leave(object sender, EventArgs e)
        {

           
        }

        private void TextBoxAlphabet_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!textBoxAlphabet.Text.Equals(abc) && e.KeyChar == (char)13)
            {
                //Setze Caption


                //Set ABC
                textBoxAlphabet.Text = textBoxAlphabet.Text.ToUpper();
                abc = textBoxAlphabet.Text;
                labelAlphabet.Text = "Alphabet: {";
                foreach (char Char in abc)
                {
                    labelAlphabet.Text += Char+", ";
                }
                labelAlphabet.Text = labelAlphabet.Text.Remove(labelAlphabet.Text.Length - 2,2);
                labelAlphabet.Text += "}";
                e.Handled = true;
                prepareStringGrid();

            }
        }



        private void prepareStringGrid()
        {
            string rawA = textBoxAlphabet.Text;
            bool doneDeleting = false;
            do
            {
               
                for (int i = 0; i < rawA.Length; i++)
                {
                    if (i <= rawA.Length)
                    {
                        if (!"ABCDEFGHIJKLMNOPQRSTUVWXYZ+-/0123456789".Contains(rawA[i]) || rawA[i] == UserControl1.blank[0]){
                            rawA=rawA.Remove(i, 1);
                        }
                    }

                    if (i > rawA.Length && rawA.Length != 0)
                    {
                        doneDeleting = false;
                    }
                    else
                    {
                        doneDeleting = true;
                    }
                }


            } while (!doneDeleting);

            if (rawA.Length != 0)
            {
                dataGridView1.Columns[0].HeaderText = UserControl1.blank;
                for (int i = 1; i < dataGridView1.Columns.Count; i++)
                {
                    if (i >= dataGridView1.Columns.Count)
                    {
                        break;
                    }

                    while (!rawA.Contains(dataGridView1.Columns[i].HeaderText) && dataGridView1.Columns.Count > 1)
                    {
                        if (i + 1 < dataGridView1.Columns.Count)
                        {
                            for (int l = i; l < dataGridView1.Columns.Count - 1; l++)
                            {
                                for (int j = 0; j < dataGridView1.Rows.Count; j++)
                                {
                                    dataGridView1[l, j].Value = dataGridView1[l + 1, j].Value;
                                    
                                }
                            }
                        }

                        dataGridView1.Columns.RemoveAt(dataGridView1.Columns.Count - 1);
                        if (i >= dataGridView1.Columns.Count)
                        {
                            break;
                        }
                    }
                   
                }
                //Delete every row already in rawA
                for (int i = 1; i < dataGridView1.Columns.Count; i++)
                {
                    if (rawA.Contains(dataGridView1.Columns[i].HeaderText))
                    {
                        rawA = rawA.Remove(rawA.IndexOf(dataGridView1.Columns[i].Name), 1);
                    }
                }
                //Add all needed Rows
                for (int i = 0; i < rawA.Length; i++)
                {
                    
                        if  (!dataGridView1.Columns.Contains(rawA[i].ToString()))
                        {
                            dataGridView1.Columns.Add(rawA[i].ToString(), rawA[i].ToString());
                        }
                    
                }
                //Edit2.Clear
                //Edit2.EditingDone
            }

        }

        private void addRow()
        {
            dataGridView1.Rows.Add();
            dataGridView1.Rows[dataGridView1.Rows.Count - 1].HeaderCell.Value = "Z" + (dataGridView1.Rows.Count - 1).ToString();
        }

        private void removeRow()
        {
            if (dataGridView1.Rows.Count > 1) { 
            dataGridView1.Rows.RemoveAt(dataGridView1.Rows.Count - 1);

            }

        }



        private void Button1_Click_1(object sender, EventArgs e)
        {
            UserControl1.moveForward();
        }

        private void ButtonAddRow_Click(object sender, EventArgs e)
        {
            addRow();
        }

        private void ButtonRowRemove_Click(object sender, EventArgs e)
        {
            removeRow();
        }

        private void TextBoxInput_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                textBoxInput.Text = textBoxInput.Text.ToUpper();
               
                setInputWord();
              
                e.Handled = true;
            }
           // e.Handled = true;
        }

        private void ButtonRefresh_Click(object sender, EventArgs e)
        {
            resetTM();
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            UserControl1.moveBackward();
        }

        private void setInputWord()
        {
            bool isInvalid = false;
            if (!input.Equals(textBoxInput.Text))//If Input is diffrent
            {
                foreach(Char c in textBoxInput.Text) {
                    if (textBoxAlphabet.Text.Contains(c) || c.ToString() == UserControl1.blank)
                    {
                        labelInput.Text = "";
                        

                        
                        
                    } else
                    {
                        labelInput.Text = "Ungültige Eingabe";
                        textBoxInput.Text = "";
                        isInvalid = true;
                        break;
                    }
                    
                   // prepareStringGrid();
                    

                }
                if (!isInvalid)
                    {
                    input = textBoxInput.Text;
                    resetTM();
                    }
                
            }
        }

        private void TextBoxBlank_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                //textBoxInput.Text = textBoxInput.Text.ToUpper();

                setBlank();

                e.Handled = true;
            }
        }

        private void DataGridView1_DoubleClick(object sender, EventArgs e)
        {
            List<string> zeichen = new List<string>();
            int direction=-1;
            bool isEndState = false;
            char currentChar;
            int currentState;
            foreach (DataGridViewColumn c in dataGridView1.Columns)
            {
                zeichen.Add(c.HeaderText);
            }
            if (dataGridView1.CurrentCell.Value != null && !dataGridView1.CurrentCell.Value.ToString().Equals("~ Ende ~"))
            {
                switch (dataGridView1.CurrentCell.Value.ToString()[0])
                {
                    case 'L':
                        direction = 0;
                        break;
                    case '0':
                        direction = 1;
                        break;
                    case 'R':
                        direction = 2;
                        break;
                }
                currentChar = dataGridView1.CurrentCell.Value.ToString()[2];
                currentState = int.Parse(dataGridView1.CurrentCell.Value.ToString().Substring(5));
                if (dataGridView1.CurrentCell.Value.ToString().Equals("~ Ende ~"))
                {
                    isEndState = true;
                }
            } else
            {
                currentChar = dataGridView1.Columns[dataGridView1.CurrentCell.ColumnIndex].HeaderText[0];
                currentState = dataGridView1.CurrentRow.Index;
            }
         
          


            
            

            turingMachineInput.inputDialog t = new turingMachineInput.inputDialog(dataGridView1.Rows.Count,zeichen,direction,isEndState,currentChar,currentState);
            t.ShowDialog();
            if (!t.returnValue.Equals(""))
            {
                dataGridView1.CurrentCell.Value = t.returnValue;
            }
        }

        private void ButtonStepBackwards_Click(object sender, EventArgs e)
        {
            UserControl1.moveBackward();
        }

        private void Timer1_Tick_1(object sender, EventArgs e)
        {
            timer1.Enabled = false;

            if (isRunning)
            {
                
                handleMove();
            }
        }

        private void ButtonStepForward_Click(object sender, EventArgs e)
        {
            UserControl1.moveForward();
        }

        private void ButtonRun_Click(object sender, EventArgs e)
        {
            isRunning = true;
            handleMove();
        }

        private void ToolStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void ButtonStepRun_Click(object sender, EventArgs e)
        {
            handleMove();
            
        }

        private void resetTM()
        {
            dataGridView1.ClearSelection();
            isRunning = false;
            timer1.Enabled = false;
            currentS = 0;
            steps = 0;
            UserControl1.index = ((UserControl1.tape.Count) / 2) - 1;
            UserControl1.indexInContent = UserControl1.index;
            toolStripStateLabel.Text = "State: " + currentS.ToString();
            toolStripStepsLabel.Text = "Steps: " + steps.ToString();
            
            
            if (!textBoxBlank.Text.Equals(""))
            {
                UserControl1.blank = textBoxBlank.Text;
            } else
            {
                UserControl1.blank = "#";
            }
            dataGridView1.Columns[0].HeaderText = UserControl1.blank;
            UserControl1.resetTape(textBoxInput.Text);
            



        }

        private void setBlank()
        {
            if (!textBoxBlank.Text.Contains(UserControl1.blank) && !textBoxAlphabet.Text.Contains(textBoxBlank.Text))
            {
                UserControl1.blank = textBoxBlank.Text;
                resetTM();
                

                
            }
        }

        private void handleMove()
        {

            timer1.Enabled = false;
            string read = UserControl1.tapeContent[UserControl1.indexInContent];
            //MessageBox.Show("IndexInContent: " + UserControl1.indexInContent.ToString() + " Read: " + read);
            int x = 0, y = 0;

            for (int i = 0; i < dataGridView1.Columns.Count; i++)
            {
                if (dataGridView1.Columns[i].HeaderText == read)
                {
                    x = i;
                    break;
                }
            }
            for (int i = 0; i < dataGridView1.Rows.Count; i++)
            {
                if (int.Parse(dataGridView1.Rows[i].HeaderCell.Value.ToString().Substring(1)) == currentS)
                {
                    y = i;
                    break;
                }
            }

            dataGridView1.CurrentCell = dataGridView1.Rows[y].Cells[x];

            if (dataGridView1.CurrentCell.Value == null || dataGridView1.CurrentCell.Value.ToString() == "")
            {
                MessageBox.Show("No command for Char: " + dataGridView1.Columns[x].HeaderText + " and State: " + dataGridView1.Rows[y].HeaderCell.Value.ToString() + "\n" +" Stopping...", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            } else
            {
                steps++;
                if (dataGridView1.Rows[y].Cells[x].Value.ToString() != "~ Ende ~")
                {
                    
                    

                    currentS = int.Parse(dataGridView1.Rows[y].Cells[x].Value.ToString().Substring(5));
                    toolStripStateLabel.Text = "State: " + currentS.ToString();
                    toolStripStepsLabel.Text = "Steps: " + steps.ToString();
                    UserControl1.setText(UserControl1.currentItem(), dataGridView1.Rows[y].Cells[x].Value.ToString()[2].ToString());

                  //  toolStripStateLabel.Text = "";
                  //  foreach (string str in UserControl1.tapeContent)
                  //  {
                  //      toolStripStateLabel.Text += str;
                  //  }
                  //  toolStripStepsLabel.Text = "index Content: " + UserControl1.indexInContent.ToString() + " Index: " + UserControl1.index.ToString() + " Gelesesn: " + read;
                    if (dataGridView1.Rows[y].Cells[x].Value.ToString()[0] == 'L')
                    {
                    
                        UserControl1.moveBackward();
                    }
                    else if (dataGridView1.Rows[y].Cells[x].Value.ToString()[0] == 'R')
                    {
                        
                        UserControl1.moveForward();
                    }
                    else if (dataGridView1.Rows[y].Cells[x].Value.ToString()[0] == '0')
                    {
                        //???
                    }

                } else
                {
                    isRunning = false;
                    toolStripStateLabel.Text = "State: " + currentS.ToString();
                    toolStripStepsLabel.Text = "Steps: " + steps.ToString();
                    MessageBox.Show("Done", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }

        }
    }

    
}
