using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;


namespace WpfControlLibrary1
{
    /// <summary>
    /// Interaktionslogik für UserControl1.xaml
    /// </summary>
    /// 


    public partial class UserControl1 : UserControl
    {



        public static List<Label> tape = new List<Label>(); //tapeArray of Labels used to Display content of TM
        public static bool loaded = false;    //bool to track if everthing loaded already, so tape creation isn't messed up
        public static int sizing = 50;
        public static int index = -1;
        public static int indexInContent = 0;
        public static string blank = "#";
        public static bool done = false;
        public static List<string> tapeContent = new List<string>();
        public static Canvas Canvas1 = new Canvas();
        //public bool hasMoved { get; set; } = false;
        public static ThicknessAnimation tA = new ThicknessAnimation();
        private static int duration=1000;

        public UserControl1()
        {
            InitializeComponent();
            dummyGrid.Children.Add(Canvas1);
            Grid.SetColumn(Canvas1, 0);
            Grid.SetRow(Canvas1, 0);
            
        }

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            if (!loaded) {
                loaded = true;
                for (int i = -1; (Canvas1.ActualWidth / sizing) + 2 > tape.Count; i++)
                {
                    Label tLabel = new Label(); //temporary Label that gets added to Array
                    tLabel.Width = sizing;
                    tLabel.Height = sizing;
                    tLabel.HorizontalContentAlignment = HorizontalAlignment.Center;
                    tLabel.VerticalContentAlignment = VerticalAlignment.Center;
                    tLabel.Content = blank;
                    tLabel.BorderBrush = Brushes.Black;
                    tLabel.BorderThickness = new Thickness(1);
                    tLabel.Margin = new Thickness(i * sizing, 0, 0, 0);
                    Canvas1.Children.Add(tLabel);
                    tape.Add(tLabel);
                    tapeContent.Add(blank);


                }
                index = ((tape.Count) / 2) - 1;
                indexInContent = index;
            }
            /// MessageBox.Show(ActualWidth.ToString());
           // tA.Completed += new EventHandler(myanim_Completed);
        }
        
        private void UserControl_SourceUpdated(object sender, DataTransferEventArgs e)
        {

        }

        private void UserControl_SizeChanged(object sender, SizeChangedEventArgs e)
        {
           // done = false;
            if (loaded)
            {
                
                while ((Canvas1.ActualWidth / sizing) + 2 > tape.Count) //Check if tape needs more Lables
                {
                  
                    if (tape.Count % 2 != 0) //if even
                    {   //Move everything
                        for (int i = 0; i < tape.Count; i++)
                        {
                           // MessageBox.Show(tape[i].Margin.Left.ToString());
                            tape[i].Margin = new Thickness(tape[i].Margin.Left + sizing, 0, 0, 0);
                        }

                        //Insert Label
                        Label tLabel = new Label(); //temporary Label that gets added to Array
                        tLabel.Width = sizing;
                        tLabel.Height = sizing;
                        tLabel.HorizontalContentAlignment = HorizontalAlignment.Center;
                        tLabel.VerticalContentAlignment = VerticalAlignment.Center;

                        if (indexInContent - (index - 1) >= 0)
                        {
                            tLabel.Content = tapeContent[indexInContent - (index - 1)];
                        } else { 
                            tLabel.Content = blank; //Content should load here
                            tapeContent.Add(blank);
                        }

                        tLabel.BorderBrush = Brushes.Black;
                        tLabel.BorderThickness = new Thickness(1);
                        tLabel.Margin = new Thickness(-sizing, 0, 0, 0);
                        Canvas1.Children.Add(tLabel);
                        tape.Insert(0, tLabel);
                        index++;//Index of current item changed

                    }
                    else //if uneven
                    {
                        //Add Label
                        Label tLabel = new Label(); //temporary Label that gets added to Array
                        tLabel.Width = sizing;
                        tLabel.Height = sizing;
                        tLabel.HorizontalContentAlignment = HorizontalAlignment.Center;
                        tLabel.VerticalContentAlignment = VerticalAlignment.Center;


                        if (indexInContent + (tape.Count-index) < tapeContent.Count)
                        {
                            tLabel.Content = tapeContent[indexInContent + (tape.Count - index)];
                        }
                        else
                        {
                            tLabel.Content = blank; //Content should load here
                            tapeContent.Add(blank);
                        }

                        tLabel.BorderBrush = Brushes.Black;
                        tLabel.BorderThickness = new Thickness(1);
                        tLabel.Margin = new Thickness((tape.Count - 1) * sizing, 0, 0, 0);
                        Canvas1.Children.Add(tLabel);
                        tape.Add(tLabel);
                    }
                  
                }
                while ((Canvas1.ActualWidth / sizing) + 2 < tape.Count - 1)//Check if tape needs less Lables
                {
                    
                    if (tape.Count % 2 == 0) //if even
                    {//Move everything
                        for (int i = 0; i < tape.Count; i++)
                        {
                            tape[i].Margin = new Thickness(tape[i].Margin.Left - sizing, 0, 0, 0);
                        }
                        //Remove first Label
                        Canvas1.Children.Remove(tape[0]);
                        tape.RemoveAt(0);
                        index--;//Index of current item changed
                    }
                    else //if uneven
                    {
                        //remove Label
                        Canvas1.Children.Remove(tape[tape.Count - 1]);
                        tape.RemoveAt(tape.Count - 1);
                    }
                   
                }






            }
           // done = true;
        }

        public static void setText(int index, string str)
        {
            
            
                tape[index].Content = str;
                tapeContent[indexInContent] = str;
            
        }

        public static int currentItem()
        {
            return index;
        }


        public static void moveForward()
        {
            Label tLabel = new Label(); //temporary Label that gets added to Array
            tLabel.Width = sizing;
            tLabel.Height = sizing;
            tLabel.HorizontalContentAlignment = HorizontalAlignment.Center;
            tLabel.VerticalContentAlignment = VerticalAlignment.Center;
            if (indexInContent + (tape.Count - index) < tapeContent.Count)
            {
                tLabel.Content = tapeContent[indexInContent + (tape.Count - index)];
            }
            else
            {
                tLabel.Content = blank; //Content should load here
                tapeContent.Add(blank);
            }
            tLabel.BorderBrush = Brushes.Black;
            tLabel.BorderThickness = new Thickness(1);
            tLabel.Margin = new Thickness((tape.Count - 1) * sizing, 0, 0, 0);
            Canvas1.Children.Add(tLabel);
            tape.Add(tLabel);
            

            foreach (Label lbl in tape)
            {
                //tA = new ThicknessAnimation(new Thickness(lbl.Margin.Left - sizing, 0, 0, 0), new Duration(TimeSpan.FromSeconds(1)));
                tA.From = new Thickness(lbl.Margin.Left,0,0,0);
                tA.To = new Thickness(lbl.Margin.Left - sizing, 0, 0, 0);
                tA.Duration = new Duration(TimeSpan.FromMilliseconds(duration));
                tA.FillBehavior = FillBehavior.Stop;
                lbl.BeginAnimation(MarginProperty, null);
                lbl.BeginAnimation(MarginProperty, tA);
                lbl.Margin = new Thickness(lbl.Margin.Left-sizing,0,0,0);
            }


            Canvas1.Children.Remove(tape[0]);
            tape.RemoveAt(0);
            //index++;
            indexInContent++;
        }

        public static void moveBackward()
        {
            Label tLabel = new Label(); //temporary Label that gets added to Array
            tLabel.Width = sizing;
            tLabel.Height = sizing;
            tLabel.HorizontalContentAlignment = HorizontalAlignment.Center;
            tLabel.VerticalContentAlignment = VerticalAlignment.Center;

            if (indexInContent - (index+1) >= 0)
            {
                tLabel.Content = tapeContent[indexInContent - (index+1)];
            }
            else
            {
                tLabel.Content = blank; //Content should load here
                tapeContent.Insert(0,blank);
                indexInContent++;
            }

            tLabel.BorderBrush = Brushes.Black;
            tLabel.BorderThickness = new Thickness(1);
            tLabel.Margin = new Thickness(-sizing*2, 0, 0, 0);
            Canvas1.Children.Add(tLabel);
            tape.Insert(0, tLabel);
           
            

            foreach (Label lbl in tape)
            {
                // tA = new ThicknessAnimation(new Thickness(lbl.Margin.Left + sizing, 0, 0, 0), new Duration(TimeSpan.FromSeconds(1)));
                tA.From = new Thickness(lbl.Margin.Left, 0, 0, 0);
                tA.To = new Thickness(lbl.Margin.Left + sizing, 0, 0, 0);
                tA.Duration = new Duration(TimeSpan.FromMilliseconds(duration));
                lbl.BeginAnimation(MarginProperty, null);
                lbl.BeginAnimation(MarginProperty, tA);
                lbl.Margin = new Thickness(lbl.Margin.Left + sizing, 0, 0, 0);
            }

            Canvas1.Children.Remove(tape[tape.Count()-1]);
            tape.RemoveAt(tape.Count-1);
            
          
            indexInContent--;
        }

        public static void resetTape(string input)
        {
            tapeContent.Clear();
            indexInContent = index;
            foreach(Label lbl in tape)
            {
                tapeContent.Add(blank);
            }
            //Set ABC again?
            prepareTape(input);
        }
        public static void prepareTape(string input)
        {
            for (int i = 0; i < input.Length; i++)
            {
                if (i + index < tapeContent.Count)
                {
                    tapeContent.RemoveAt(i + index);
                    tapeContent.Insert(i + index, input[i].ToString());
                } else
                {
                    tapeContent.Add(input[i].ToString());
                }
            }
            initTape();
        }

        public static void initTape()
        {
            for (int i = 0; i < tape.Count; i++)
            {
                if (i >= index)
                {
                    tape[i].Content = tapeContent[i];
                } else
                {
                    tape[i].Content = blank;
                }
            }
        }

        public static void newDuration(int milli)
        {

            duration = milli;
        }
    }
}
