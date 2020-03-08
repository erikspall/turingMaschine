package de.erikspall.turingMaschine.UI.Tape.TapeElement;

import javax.swing.*;
import java.awt.*;

public class TapeElement extends JTextField {

    /*
    *   Creates one Element of the Tape
    *   content - content of the TapeElement
    *   pos - x-position of TapeElement
    *   size - width and height of TapeElement
    *   sizeOfIndicator - How much space for the indicator
    *   rootPanel - The Panel that should contain the TapeElement
     **/
    public TapeElement(Character content, int position){
        super(String.valueOf(content)); //Set Content

        this.setBorder(BorderFactory.createLineBorder(Color.BLACK)); //Create Border
        this.setBounds(position,25,50,50); //Set Size and pos
        this.setHorizontalAlignment(JTextField.CENTER); //Center Text
        this.setEditable(false);


    }

    public void setText(Character c){
        super.setText(String.valueOf(c));
    }
}
