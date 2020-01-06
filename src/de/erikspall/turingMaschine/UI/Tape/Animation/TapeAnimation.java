package de.erikspall.turingMaschine.UI.Tape.Animation;

import de.erikspall.turingMaschine.UI.Tape.Element.TapeElement;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class TapeAnimation {
    boolean direction; //1-Left, 0-Right
    int duration,startX;
    ArrayList<TapeElement> panelTape;
    Timer timer;


    public boolean isDirection() {
        return direction;
    }

    public void setDirection(boolean direction) {
        this.direction = direction;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }



    public TapeAnimation(ArrayList<TapeElement> panelTape, boolean direction, int duration, int dimensions){
        this.panelTape = panelTape;
        this.direction = direction;
        this.duration = duration;
        this.startX = 0;
        timer = new Timer(duration, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                System.out.println(panelTape.size());
                if (direction){//Left
                    if (panelTape.get(0).getX() != startX-dimensions) {
                        for (TapeElement tE :
                                panelTape) {
                            tE.setX(tE.getX() - 1);
                        }
                    } else {
                        timer.stop();

                    }


                } else {
                    if (panelTape.get(1).getX() != 0) {
                        for (TapeElement tE :
                                panelTape) {
                            tE.setX(tE.getX() + 1);
                        }
                    } else {
                        timer.stop();
                    }
                }
            }
        });
    }

    public void animate(){
        timer.start();
    }

}