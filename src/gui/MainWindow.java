package gui;

import logic.tape.tape.Tape;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;

public class MainWindow {
    private JPanel panelMain;
    private JTabbedPane tabbedPane1;
    private JPanel panelPicture;
    private JPanel panelTape;
        private JPanel panelT;
    private JPanel panelStatusBar;
    private JLabel lblIDK;
    private JButton button1;
    private JButton button2;
    private JButton button3;
    static Tape tape;
    boolean isLoaded = false;

    public MainWindow() {
        panelTape.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                if (!isLoaded) {
                    isLoaded = true;
                    panelT.setLayout(null);
                    // System.out.println("WW");
                    tape = new Tape(panelT, 50, "#");

                } else {
                    tape.updateSize();
                    lblIDK.setText(String.valueOf(tape.getPanelCount()));
                }
            }
        });
        button1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                tape.moveForward();
            }
        });
        button2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                tape.moveBackward();
            }
        });
        button3.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                tape.setText("A");
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
        frame.setContentPane(new MainWindow().panelMain);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

    }


}
