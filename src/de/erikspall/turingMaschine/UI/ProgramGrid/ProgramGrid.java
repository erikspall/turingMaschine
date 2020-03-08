package de.erikspall.turingMaschine.UI.ProgramGrid;

import javafx.scene.control.SelectionMode;

import javax.swing.*;
import javax.swing.plaf.metal.MetalBorders;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import java.awt.*;
import java.util.Vector;

public class ProgramGrid extends JTable {
    private ProgramGridModel model;
    public ProgramGrid(){
        super();
        model = new ProgramGridModel();
        setColumnSelectionAllowed(false);
        setRowSelectionAllowed(false);
        setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        addCharacter("State");
        addCharacter("#");
        addEndState();
        addState();

        this.setModel(model);


    }

    public void addCharacter(String columnName){
        model.addColumn(columnName);
    }

    public void addState(){


        Object[] newRow = new Object[model.getColumnCount()];
        newRow[0] = String.valueOf(model.getRowCount());
        for (int i = 1; i < model.getColumnCount(); i++){
            newRow[i] = "";
        }

        model.insertRow(getStateCount(),newRow);
    }

    public void removeState(){
        if (getStateCount() > 1){
            model.removeRow(getStateCount()-1);
        }
    }

    private void addEndState(){
        Object[] newRow = new Object[model.getColumnCount()];

        for (int i = 0; i < model.getColumnCount(); i++){
            newRow[i] = "~End~";
        }

        model.addRow(newRow);
    }

    public void prepareStringGrid(String alphabet){
        if (alphabet.length() != 0)  {
            // Set Blank

            for (int i = 2; i < model.getColumnCount(); i++){
                if (i >= model.getColumnCount()) {
                    break;
                }
                //System.out.println("ABC: " + alphabet);
                if (!alphabet.contains(model.getColumnName(i))){
                    String toRemove = model.getColumnName(i);
                    System.out.println("Removing: " + toRemove);
                    while (model.findColumn(toRemove) != -1) {
                        model.removeColumn(model.findColumn(toRemove));
                        i--;
                        System.out.println("Raus mit de Viechaa");
                    }
                } else {
                    alphabet = alphabet.replace(model.getColumnName(i), "");
                }
            }

            for (int i = 0; i < alphabet.length(); i++){
                if (model.findColumn(String.valueOf(alphabet.charAt(i))) == -1){
                    addCharacter(String.valueOf(alphabet.charAt(i)));
                    setValueAt("~End~", model.getRowCount()-1, model.getColumnCount()-1);
                }
            }


        }
    }

    public int getStateCount(){
        return model.getRowCount()-1;
    }

    public ProgramCommand getCommand(int state, Character readChar){
       /* if (model.getValueAt(state-1,model.findColumn(String.valueOf(readChar))) != null && model.getValueAt(state - 1,model.findColumn(String.valueOf(readChar))).equals("~End~")){
            return null;
        }*/
        return new ProgramCommand(String.valueOf(model.getValueAt(state - 1,model.findColumn(String.valueOf(readChar)))));
    }

}
