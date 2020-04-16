package de.erikspall.turingMaschine.UI;

import de.erikspall.turingMaschine.UI.ProgramGrid.ProgramGrid;
import de.erikspall.turingMaschine.UI.ProgramGrid.ProgramGridModel;
import de.erikspall.turingMaschine.UI.ProgramGridInputDialog.ProgramGridInputDialog;
import de.erikspall.turingMaschine.UI.Tape.Tape;
import de.erikspall.turingMaschine.UI.TuringMachine.TuringMachine;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


public class MainWindow {
    private JPanel mainPanel;
    private JTabbedPane tabbedPane1;
    private JPanel statusPanel;
    private JButton buttonStart;
    private JButton buttonStep;
    private JPanel leftSplitPanel;
    private JPanel rightSplitPanel;
    private JScrollPane programGridScrollPane;
    private ProgramGrid programGrid;
    private JTextField abcTextField;
    private JTextField inputTextField;
    private JTextField blankTextFiel;
    private JPanel panelTape;
    private Tape tape;
    private JButton buttonReset;
    private JLabel abcLabel;
    private JLabel inputLabel;
    private JButton buttonLeft;
    private JButton buttonRight;
    private JButton buttonNewProgram;
    private JButton buttonSaveAs;
    private JButton buttonSave;
    private JButton buttonOpen;
    private JButton buttonAddState;
    private JButton buttonRemoveState;
    private JLabel statusLabelState;
    private JLabel statusLabelSteps;
    private TuringMachine tm;

    public MainWindow(){

        buttonStart.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {

            tm.start();

            }
        });

        buttonStep.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                tape.moveRight();

            }
        });


        programGrid.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() == 2) {
                    if (programGrid.getSelectedColumn() != 0 && programGrid.getSelectedRow() != programGrid.getRowCount()-1) {
                        ProgramGridInputDialog dialog = new ProgramGridInputDialog(mainPanel);
                        dialog.showDialog((ProgramGridModel) programGrid.getModel(), programGrid.getSelectedRow(), programGrid.getSelectedColumn());
                        if (dialog.isOK()) {
                            programGrid.setValueAt(dialog.getValue(), programGrid.getSelectedRow(), programGrid.getSelectedColumn());
                        }

                    }
                }
            }
        });
        panelTape.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {

            }
        });
        tape.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                if (tape.hasLoaded) {
                    tm.getGuiTape().adjustSize();
                } else {
                    tm = new TuringMachine(tape,programGrid);

                }
            }
        });
        buttonReset.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                tape.reset("#");
            }
        });

        inputTextField.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                inputTextField.setText(inputTextField.getText().toUpperCase());
                boolean isValid = true;
                for (Character c:
                        inputTextField.getText().toCharArray()) {
                    if (!abcTextField.getText().isEmpty() && abcTextField.getText().contains(c.toString()) || c.equals('#')){

                    } else {
                        isValid = false;
                    }
                }
                if (isValid) {
                    tape.reset(inputTextField.getText());
                    inputLabel.setText("");
                }
                else {
                    inputLabel.setText("Invalid Input!");
                    inputTextField.setText("");
                }

            }
        });
        abcTextField.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                tm.setAlphabet(abcTextField.getText().toUpperCase());

                abcTextField.setText(tm.getAlphabet());

                abcLabel.setText("Alphabet: {" + tm.getBlank());
                for (Character c:
                     tm.getAlphabet().toCharArray()) {
                    abcLabel.setText(abcLabel.getText() + ", " + c);
                }
               /* if (abcTextField.getText().length() > 0) {
                    abcLabel.setText(abcLabel.getText().substring(0, abcLabel.getText().length() - 2));
                }*/
                abcLabel.setText(abcLabel.getText()+"}");

                inputTextField.setText("");
                inputLabel.setText("");

                tm.resetTape(inputTextField.getText());

            }
        });
        buttonAddState.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                programGrid.addState();
            }
        });
        buttonRemoveState.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                programGrid.removeState();
            }
        });


        blankTextFiel.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                if (blankTextFiel.getText().length() != 1){
                    blankTextFiel.setText(tm.getBlank());
                } else {
                    //check if blank is already used as input in alphabet
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
        JFrame frame = new JFrame("Turing Machine");
        frame.setContentPane(new MainWindow().mainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(565,500);
        frame.setMinimumSize(new Dimension(565,500));
        frame.pack();
        frame.setVisible(true);
    }


}
