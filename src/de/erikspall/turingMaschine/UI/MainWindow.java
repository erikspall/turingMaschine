package de.erikspall.turingMaschine.UI;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.net.URI;
import java.sql.SQLOutput;
import java.util.Arrays;

public class MainWindow {
    private JPanel MainPanel;
    private JTabbedPane tabbedPane;
    private JPanel statusBar;
    private JPanel panelTapeRoot;
    private JToolBar toolBar;
    private JTextField textField1;
    private JTextField textField2;
    private JTextField textField3;
    private JButton gitHubButton;
    private JComboBox comboBoxLookAndFeel;
    private JPanel panelLeftSplit;
    private JPanel panelAlphabet;
    private JTextField textField4;
    private JTable table1;

    public MainWindow(){
        for (UIManager.LookAndFeelInfo look:
             UIManager.getInstalledLookAndFeels()) {
            comboBoxLookAndFeel.addItem(look.getName());
            if (look.getClassName().equals(UIManager.getSystemLookAndFeelClassName()))
                comboBoxLookAndFeel.setSelectedIndex(comboBoxLookAndFeel.getItemCount()-1);
        }
        gitHubButton.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));


        comboBoxLookAndFeel.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    UIManager.setLookAndFeel(UIManager.getInstalledLookAndFeels()[comboBoxLookAndFeel.getSelectedIndex()].getClassName());
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (InstantiationException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (UnsupportedLookAndFeelException e) {
                    e.printStackTrace();
                }
                SwingUtilities.updateComponentTreeUI(MainPanel);
            }
        });


        gitHubButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                Desktop desktop = Desktop.isDesktopSupported() ? Desktop.getDesktop() : null;
                if (desktop != null && desktop.isSupported(Desktop.Action.BROWSE)) {
                    try {
                        desktop.browse(new URI("https://github.com/erikspall/turingmaschine"));

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        });
    }


    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (UnsupportedLookAndFeelException e) {
            e.printStackTrace();
        }
        JFrame frame = new JFrame("MainWindow");
        frame.setMinimumSize(new Dimension(500,500));
        frame.setSize(new Dimension(500,500));
        frame.setContentPane(new MainWindow().MainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

    }


}
