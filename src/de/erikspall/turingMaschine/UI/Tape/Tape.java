package de.erikspall.turingMaschine.UI.Tape;

import de.erikspall.turingMaschine.UI.MainWindow;
import de.erikspall.turingMaschine.UI.Tape.Indicator.Indicator;
import de.erikspall.turingMaschine.UI.Tape.TapeElement.TapeElement;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class Tape extends JPanel {
    private ArrayList<TapeElement> tape;
    private ArrayList<Character> tapeContent;
    private int index, indexInContent;
    public static boolean hasLoaded = false, isMoving = false;
    private Indicator indicator;
    private ArrayList<AnimationListener> listeners = new ArrayList<>();
    Timer moveRightTimer;

    public Timer getMoveRightTimer() {
        return moveRightTimer;
    }

    public Timer getMoveLeftTimer() {
        return moveLeftTimer;
    }

    Timer moveLeftTimer;

    /**
     * Constructor of Tape initializes Arrays, but doesn't create the TapeElements, because Width == 0 at this point
     */
    public Tape(){
        super();

        tape = new ArrayList<>();
        tapeContent = new ArrayList<>();

    }

    /**
     * Create all TapeElements
     */
    public void init(){
        setLayout(null); // Otherwise NullPointer

        for (int i = -1; ((getWidth() / 50 /* Sizing */ )+2) > tape.size(); i++){
            TapeElement tapeElement = new TapeElement('#',i * 50);
            add(tapeElement);
            tape.add(tapeElement);
            tapeContent.add('#');
        }

        indicator = new Indicator(Indicator.calculatePosition(tape.size(),50));
        add(indicator);
        index = ((tape.size()/2)) ;
        indexInContent = index;
        updateUI();
        hasLoaded = true;
    }

    /**
     * Returns amount of TapeElements in tape ArrayList
     */
    public int getAmountOfTapeElements(){
        return tape.size();
    }

    /**
     * Adjust amount of TapeElements according to Width
     */
    public void adjustSize(){

        // While there is more room for TapeElements
        while ((getWidth() / 50 /* Sizing */) + 2 > tape.size()) {

            // If the amount of TapeElements is even
            if ((tape.size() % 2) != 0) {

                // Move all TapeElements to the right
                for (TapeElement tapeElement:
                tape) {
                    tapeElement.setLocation(tapeElement.getX() + 50 /* Sizing */, 25 /* Size of Indicator */);
                }

                // Correct position of Indicator
                indicator.setLocation(indicator.getX() + 50 /* Sizing */, 0);

                // New TapeElement
                TapeElement tapeElement = new TapeElement('#', -50);

                // If Content then load content, else add content
                if (indexInContent - (index + 1) >= 0) {
                    tapeElement.setText(tapeContent.get(indexInContent - (index + 1)));
                } else {
                    tapeElement.setText('#');
                    tapeContent.add('#'); // Maybe wrong
                   // indexInContent++;
                }

                // Add TapeElement to GUI and adjust index
                add(tapeElement);
                tape.add(0, tapeElement);
                index++;
            } else {
                TapeElement tapeElement = new TapeElement('#', (tape.size() - 1) * 50 /* Sizing */);

                if (indexInContent + (tape.size() - index) < tapeContent.size()){
                    tapeElement.setText(tapeContent.get(indexInContent + (tape.size() - index)));
                } else {
                    tapeElement.setText('#');
                    tapeContent.add('#');
                }

                add(tapeElement);
                tape.add(tapeElement);
            }
        }

        // While there are no many TapeElements
        while ((getWidth() / 50 /* Sizing */) + 2 < tape.size()-1){

            // if amount is even
            if ((tape.size() % 2) == 0) {

                // Move Elements to left
                for (TapeElement tapeElement:
                tape) {
                    tapeElement.setLocation(tapeElement.getX() - 50 /* Sizing */, 25);
                }

                // Adjust indicator
                indicator.setLocation(indicator.getX() - 50 /* Sizing*/, 0);

                // Delete TapeElement
                remove(tape.get(0));
                tape.remove(0);
                index--;
            } else {

                // Delete TapeElement
                remove(tape.get(tape.size()-1));
                tape.remove(tape.size() - 1);
            }
        }

        updateUI();
    }


    /**
     * Animate TapeElements to Left
     */
    public void moveLeft(){
        if (!isMoving) {

            isMoving = true;

            TapeElement tapeElement = new TapeElement('#', (tape.size() - 1) * 50 /* Sizing */);

            moveLeftTimer = new Timer(10, new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent actionEvent) {
                    for (TapeElement t :
                            tape) {

                        t.setLocation(t.getX() - 1, 25);

                    }
                    if (tape.get(0).getX() <= -2 * 50) {
                        ((Timer) actionEvent.getSource()).stop();
                        remove(tape.get(0));
                        tape.remove(0);
                        isMoving = false;
                        for (AnimationListener animationListener:
                                listeners){
                            animationListener.onLeftAnimationEnd();
                        }
                    }
                }

            });

            if (indexInContent + (tape.size() - index) < tapeContent.size()) {
                tapeElement.setText(tapeContent.get(indexInContent + (tape.size() - index)));
            } else {
                tapeElement.setText('#');
                tapeContent.add('#');
            }

            add(tapeElement);
            tape.add(tapeElement);

            moveLeftTimer.start();

            indexInContent++;
        }
    }

    /**
     * Animate TapeElements to Right
     */
    public void moveRight(){
        if (!isMoving) {
            isMoving = true;
            TapeElement tapeElement = new TapeElement('#', -50*2);

            moveRightTimer = new Timer(10, new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent actionEvent) {
                    for (TapeElement t:
                    tape){

                        t.setLocation(t.getX()+1,25);
                    }
                    if (tape.get(0).getX() >= -50){
                        ((Timer)actionEvent.getSource()).stop();
                        remove(tape.get(tape.size()-1));
                        tape.remove(tape.size()-1);
                        isMoving = false;
                        for (AnimationListener animationListener:
                        listeners){
                            animationListener.onRightAnimationEnd();
                        }

                    }
                }
            });

            if (indexInContent - (index + 1) >= 0) {
                tapeElement.setText(tapeContent.get(indexInContent - (index + 1)));
            } else {
                tapeElement.setText('#');
                tapeContent.add(0,'#'); // Maybe wrong
                indexInContent++;
            }

            add(tapeElement);
            tape.add(0,tapeElement);

            moveRightTimer.start();

            indexInContent--;

        }
    }


    /**
     * Write to Tape
     */
    public void write(Character c){
        tapeContent.remove(indexInContent);
        tapeContent.add(indexInContent, c);

        tape.get(index).setText(c);
    }

    /**
     * Return current char
     */
    public Character read(){
        return tapeContent.get(indexInContent);
    }

    /**
     * Reset Tape
     */
    public void reset(String input){
        tapeContent.clear();
        indexInContent = index;
        for (TapeElement t:tape){
            tapeContent.add('#');
        }
        prepareTape(input);
    }

    /**
     * Bring Inputword to tapeContent
     */
    public void prepareTape(String input){
        for (int i = 0; i < input.length(); i++){
            if (i + index < tapeContent.size()){
                tapeContent.remove(i+index);
                tapeContent.add(i+index, input.charAt(i));
            } else {
                tapeContent.add(input.charAt(i));
            }
        }
        initTape();
    }

    /**
     * Bring tapeContent to tape
     */
    public void initTape(){
        for (int i = 0; i < tape.size(); i++){
            if (i >= index){
                tape.get(i).setText(tapeContent.get(i));
            } else {
                tape.get(i).setText('#');
            }
        }
    }

    public void addListener(AnimationListener toAdd) {
        listeners.add(toAdd);
    }


}
