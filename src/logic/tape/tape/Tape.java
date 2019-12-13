package logic.tape.tape;

import logic.tape.indicator.Indicator;
import logic.tape.tape.animation.TapeAnimation;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

public class Tape {
    JPanel rootPanel;
    ArrayList<TapeElement>panelTape;
    ArrayList<String>tapeContent;
    int index,indexInContent;
    int dimensions;
    String blank;
    TapeAnimation left,right;


    public Tape(JPanel rootPanel, int dimensions, String blank){
        this.rootPanel = rootPanel;
        this.rootPanel.removeAll();
        this.blank = blank;
        this.dimensions = dimensions;
        tapeContent = new ArrayList<>();
        this.rootPanel.setMinimumSize(new Dimension(-1,this.dimensions));
        this.rootPanel.setSize(this.rootPanel.getWidth(),this.dimensions);
        panelTape = new ArrayList<>();
        left = new TapeAnimation(this.panelTape,true,1,this.dimensions);
        right = new TapeAnimation(this.panelTape,false,1,this.dimensions);
        for (int i = -1; (this.rootPanel.getWidth()/this.dimensions)+2 > panelTape.size();i++){
            panelTape.add(new TapeElement(this.rootPanel,this.dimensions*i,this.dimensions,this.blank));
            tapeContent.add(this.blank);
        }

        index = ((panelTape.size()/2));
        indexInContent = index;

    }

    public void updateSize(){
        String whatToLoad = "";
        while ((rootPanel.getWidth()/dimensions)+2 > panelTape.size()){
            if (panelTape.size() % 2 != 0){
                for (int i = 0; i < panelTape.size(); i++){
                    panelTape.get(i).shiftRight();
                }


                if (indexInContent - (index - 1) >= 0){
                    whatToLoad = tapeContent.get(indexInContent-(index-1));
                } else {
                    whatToLoad = blank;
                    tapeContent.add(blank);
                }
                panelTape.add(0,new TapeElement(rootPanel,-dimensions,dimensions,whatToLoad));
                index++;

            } else {
                if (indexInContent+(panelTape.size()-index)<tapeContent.size()){
                    whatToLoad = tapeContent.get(indexInContent+(panelTape.size()-index));
                }else {
                    whatToLoad = blank;
                    tapeContent.add(blank);
                }
                panelTape.add(new TapeElement(rootPanel,(panelTape.size()-1)*dimensions,dimensions,whatToLoad));

            }
        }
        while ((rootPanel.getWidth()/dimensions)+2 < panelTape.size()-1){
            if (panelTape.size() % 2 == 0){
                for (int i = 0; i< panelTape.size(); i++){
                    panelTape.get(i).shiftLeft();
                }
                rootPanel.remove(panelTape.get(0).getPanel());
                panelTape.remove(0);
                index--;

            } else {
                rootPanel.remove(panelTape.get(panelTape.size()-1).getPanel());
                panelTape.remove(panelTape.size()-1);
            }

            /*panelTape.add(new TapeElement(rootPanel,(panelTape.size()-1)*dimensions,dimensions,whatToLoad));

            for (TapeElement tE:
                 panelTape) {

            }*/

        }
    }

    public int getPanelCount(){
        return panelTape.size();
    }

    public void setText(String text){
        panelTape.get(index).setText(text);
        tapeContent.set(indexInContent,text);
    }

    public void moveForward(){
        String whatToLoad = "";
        if (indexInContent + (panelTape.size()-index)<tapeContent.size()){
            whatToLoad = tapeContent.get(indexInContent+(panelTape.size()-index));
        } else {
            whatToLoad = blank;
            tapeContent.add(blank);
        }
        panelTape.add(new TapeElement(rootPanel,(panelTape.size()-1)*dimensions,dimensions,whatToLoad));
        left.animate();
        rootPanel.remove(panelTape.get(0).getPanel());
        panelTape.remove(0);
        indexInContent++;

    }

    public void moveBackward(){
        String whatToLoad = "";
        if (indexInContent - (index+1) >= 0){
            whatToLoad = tapeContent.get(indexInContent - (index+1));
        } else {
            whatToLoad = blank;
            tapeContent.add(0,blank);
            indexInContent++;
        }
        panelTape.add(0,new TapeElement(rootPanel,-dimensions*2,dimensions,whatToLoad));
        right.animate();
        rootPanel.remove(panelTape.get(panelTape.size()-1).getPanel());
        panelTape.remove(panelTape.size()-1);
        indexInContent--;
    }

    public void resetTape(String input){
        tapeContent.clear();
        indexInContent = index;
        for (TapeElement tE:
             panelTape) {
            tapeContent.add(blank);
        }
        prepareTape(input);
    }

    public void prepareTape(String input){
        for (int i = 0; i < input.length(); i++){
            if (i+ index < tapeContent.size()){
                tapeContent.remove(i+index);
                tapeContent.add(i+index, String.valueOf(input.charAt(i)));
            }else{
                tapeContent.add(String.valueOf(input.charAt(i)));
            }
        }
        initTape();
    }

    public void initTape(){
        for (int i = 0; i < panelTape.size();i++){
            if (i>= index){
                panelTape.get(i).setText(tapeContent.get(i));
            } else {
                panelTape.get(i).setText(blank);
            }
        }
    }
}
