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
    public partial class UserControl1 : UserControl
    {
        List<Label> tape = new List<Label>(); //tapeArray of Labels used to Display content of TM
        bool loaded = false;    //bool to track if everthing loaded already, so tape creation isn't messed up

        public UserControl1()
        {
            InitializeComponent();
        }

        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            if (!loaded) {
                loaded = true;
                for (int i = -1; (Canvas1.ActualWidth / 50) + 2 > tape.Count; i++)
                {
                    Label tLabel = new Label(); //temporary Label that gets added to Array
                    tLabel.Width = 50;
                    tLabel.Height = 50;
                    tLabel.HorizontalContentAlignment = HorizontalAlignment.Center;
                    tLabel.VerticalContentAlignment = VerticalAlignment.Center;
                    tLabel.Content = "#";
                    tLabel.BorderBrush = Brushes.Black;
                    tLabel.BorderThickness = new Thickness(1);
                    tLabel.Margin = new Thickness(i * 50, 0, 0, 0);
                    Canvas1.Children.Add(tLabel);
                    tape.Add(tLabel);
                   
                }
               
            }
           /// MessageBox.Show(ActualWidth.ToString());
            
        }

        private void UserControl_SourceUpdated(object sender, DataTransferEventArgs e)
        {

        }

        private void UserControl_SizeChanged(object sender, SizeChangedEventArgs e)
        {
           // MessageBox.Show(tape.Count.ToString());
           if ((Canvas1.ActualWidth/50)+2 > tape.Count) //Check if tape needs more Lables
            {
                 if (tape.Count % 2 == 0) //if even
                {

                } else //if uneven
                {

                }
            }

        }

        public int currentIndex()
        {
            
        }
    }
}
