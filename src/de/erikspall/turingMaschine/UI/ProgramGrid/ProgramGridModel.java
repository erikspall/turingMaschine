package de.erikspall.turingMaschine.UI.ProgramGrid;

import javax.swing.table.DefaultTableModel;
import java.util.Vector;

public class ProgramGridModel extends DefaultTableModel {
    public ProgramGridModel(){
        super(0,0);
    }

    @Override
    public boolean isCellEditable(int row, int column) {
        return false;
    }

    public void removeColumn(int column) {
        columnIdentifiers.remove(column);
        for (Object row: dataVector) {
            ((Vector) row).remove(column);
        }
        fireTableStructureChanged();
    }
}
