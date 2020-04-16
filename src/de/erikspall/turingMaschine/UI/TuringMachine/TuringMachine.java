package de.erikspall.turingMaschine.UI.TuringMachine;

import de.erikspall.turingMaschine.UI.ProgramGrid.ProgramCommand;
import de.erikspall.turingMaschine.UI.ProgramGrid.ProgramGrid;
import de.erikspall.turingMaschine.UI.Tape.AnimationListener;
import de.erikspall.turingMaschine.UI.Tape.Tape;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TuringMachine implements AnimationListener {
    private int steps;
    private Tape guiTape;
    private ProgramGrid guiProgramGrid;
    private Timer delay;
    private boolean isRunning;


    public int getState() {
        return state;
    }

    private int state;

    public int getSteps() {
        return steps;
    }
    public String getBlank() {
        return blank;
    }

    public void setBlank(String blank) {
        this.blank = blank;
        resetTape(blank);
    }

    private String blank;
    private String alphabet;

    public TuringMachine(Tape guiTape, ProgramGrid guiProgramGrid) {
        this.guiTape = guiTape;
        this.guiProgramGrid = guiProgramGrid;
        this.alphabet = "";
        this.blank = "#";
        guiTape.init();
        guiTape.addListener(this);
        state = 1;
        delay = new Timer(500, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                delay.stop();
                execute(guiProgramGrid.getCommand(state,guiTape.read()));
            }
        });

        isRunning = false;
    }

    public Tape getGuiTape() {
        return guiTape;
    }

    public String getAlphabet() {
        return alphabet;
    }

    public void setAlphabet(String alphabet) {
        this.alphabet = "";
        for (Character c:
             alphabet.toCharArray()) {

            if (this.alphabet.indexOf(c) == -1 && !c.equals('#') && !c.equals(',')){
                System.out.println("Char: " +  c);
                this.alphabet += c;
            }
        }
        guiProgramGrid.prepareStringGrid(this.alphabet);

    }

    public void setInput(String input){

        guiTape.prepareTape(input);
    }

    public void resetTape(String string){
        if (delay != null)
            delay.stop();
        if (guiTape.getMoveRightTimer() != null)
            guiTape.getMoveLeftTimer().stop();
        if (guiTape.getMoveLeftTimer() != null)
            guiTape.getMoveRightTimer().stop();
        guiTape.reset(string);
    }

    public void reset(){
        guiProgramGrid.clearSelection();
        isRunning = false;
        state = 1;
        // set new statuspanels here
        steps = 0;
    }

    public void execute(ProgramCommand command){
        System.out.println("State: " + state + ", Command: " + command.toString());
        isRunning = true;
        if (command.isValid()) {
            if (!command.isEnd()) {
                guiTape.write(command.getWhatToWrite());

                state = command.getNextState();
                if (state == -1){
                    state = guiProgramGrid.getColumnCount()-1;
                }
                switch (command.getDirection()) {
                    case LEFT: {
                        // moveRight is like moveBackward
                        guiTape.moveRight();
                        break;
                    }
                    case RIGHT: {
                        guiTape.moveLeft();
                        break;
                    }
                    case NONE: {
                        execute(guiProgramGrid.getCommand(state,guiTape.read()));
                    }
                }
            } else {
                isRunning = false;
                JOptionPane.showMessageDialog(null,"Program completed");

            }
        } else {
            isRunning = false;
            JOptionPane.showMessageDialog(null,"Not a valid command!");

        }
    }

    public void stepRun(){
        execute(guiProgramGrid.getCommand(state,guiTape.read()));
    }

    public void start(){
        ProgramCommand command = guiProgramGrid.getCommand(state,guiTape.read());

        System.out.println("Command: " + command.toString());
        System.out.println("Direction: " + command.getDirection());
        System.out.println("Write: " + command.getWhatToWrite());
        System.out.println("State: " + command.getNextState());

        execute(command);

    }



    @Override
    public void onLeftAnimationEnd() {
        System.out.println("Left Animation ended");
        delay.start();
    }

    @Override
    public void onRightAnimationEnd() {
        System.out.println("Right Animation ended");
     //   execute(guiProgramGrid.getCommand(state,guiTape.read()));
        delay.start();
    }
}
