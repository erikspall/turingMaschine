package de.erikspall.turingMaschine.UI.ProgramGridInputDialog;

import de.erikspall.turingMaschine.UI.ProgramGrid.Direction;
import de.erikspall.turingMaschine.UI.ProgramGrid.ProgramCommand;
import de.erikspall.turingMaschine.UI.ProgramGrid.ProgramGridModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class ProgramGridInputDialog extends JDialog {
    private JPanel contentPane;
    private JButton buttonOK;
    private JButton buttonCancel;
    private JRadioButton leftRadioButton;
    private JRadioButton nullRadioButton;
    private JRadioButton rightRadioButton;
    private JComboBox writeComboBox;
    private JComboBox stateComboBox;
    private ProgramCommand command;

    public boolean isOK() {
        return isOK;
    }

    private boolean isOK;

    public ProgramGridInputDialog(Component c) {
        setContentPane(contentPane);
        setModal(true);
        setSize(284,200);
        setTitle("Input");
        setLocationRelativeTo(c);
        getRootPane().setDefaultButton(buttonOK);
        isOK = false;



        buttonOK.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onOK();
            }
        });

        buttonCancel.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        });

        // call onCancel() when cross is clicked
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                onCancel();
            }
        });

        // call onCancel() on ESCAPE
        contentPane.registerKeyboardAction(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        }, KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
    }

    private void onOK() {
        isOK = true;
        dispose();
    }

    private void onCancel() {
        isOK = false;
        dispose();
    }

    public ProgramCommand getValue(){
        Direction direction;
        String write;
        String state;

        if (leftRadioButton.isSelected()){
            direction = Direction.LEFT;
        } else if (nullRadioButton.isSelected()){
            direction = Direction.NONE;
        } else {
            direction = Direction.RIGHT;
        }

        write = writeComboBox.getSelectedItem().toString();
        state = stateComboBox.getSelectedItem().toString();

        
        return new ProgramCommand(direction,write,state);

    }

    public void showDialog(ProgramGridModel model, int state, int col){
        // start at 1, because 0 is State column
        for (int i = 1; i < model.getColumnCount(); i++){
            writeComboBox.addItem(model.getColumnName(i));
        }
        for (int i = 0; i < model.getRowCount(); i++){
            stateComboBox.addItem(model.getValueAt(i,0));
        }

        writeComboBox.setSelectedIndex(col-1);
        stateComboBox.setSelectedIndex(state);

        setVisible(true);
        
    }
}
