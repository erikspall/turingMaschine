package de.erikspall.turingMaschine.UI.Tape.Element;

import javax.swing.*;
import javax.swing.border.Border;
import java.awt.*;

public class TapeElement {
    JPanel rootPanel;
    JPanel outerPanel;
    JLabel innerLabel;
    int dimensions;

    public TapeElement(JPanel rootPanel, int pos, int dimensions, String blank){
        //this.rootPanel = new JPanel();

        this.rootPanel = rootPanel;
        outerPanel = new JPanel(null);
        innerLabel = new JLabel();
        this.dimensions = dimensions;
        innerLabel.setHorizontalAlignment(SwingConstants.CENTER);
        //innerLabel.setVerticalAlignment(Label.CENTER);
        innerLabel.setHorizontalTextPosition(JLabel.CENTER);
        innerLabel.setVerticalTextPosition(JLabel.CENTER);
        innerLabel.setText(blank);
        innerLabel.setBounds(0,0,dimensions,dimensions);
        outerPanel.add(innerLabel);
        outerPanel.setBounds(pos,0,dimensions,dimensions);
        outerPanel.setBorder(BorderFactory.createLineBorder(Color.BLACK));
        System.out.println(this.rootPanel);
        this.rootPanel.add(outerPanel);
        this.rootPanel.updateUI();
    }

    public String getText(){
        return innerLabel.getText();
    }

    public void setText(String text){
        innerLabel.setText(text);
    }

    public int getX(){
        return outerPanel.getX();
    }

    public void setX(int x){
        outerPanel.setLocation(x,0);
        rootPanel.updateUI();
    }
    public void shiftRight(){
        outerPanel.setLocation(outerPanel.getX()+dimensions,0);
    }
    public void shiftLeft(){
        outerPanel.setLocation(outerPanel.getX()-dimensions,0);
    }
    public JPanel getPanel(){
        return outerPanel;
    }
}
