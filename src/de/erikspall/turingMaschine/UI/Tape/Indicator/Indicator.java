package de.erikspall.turingMaschine.UI.Tape.Indicator;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Indicator extends JLabel {

    public Indicator(int x) {
        super();
        this.setBounds(x,0,25,25);
        BufferedImage img = null;
        try {
            img = ImageIO.read(new File("src/res/ic_arrow_drop_down.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        Image dimg = img.getScaledInstance(this.getWidth(), this.getHeight(), Image.SCALE_SMOOTH);
        this.setIcon(new ImageIcon(dimg));

    }

    public static int calculatePosition(int amountOfTapeElements, int sizeOfElement){
        int pos = (((amountOfTapeElements-2)/2)*sizeOfElement)+(sizeOfElement/4);
        System.out.println("Pos: " + pos);
        return pos;
    }
}
