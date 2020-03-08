package de.erikspall.turingMaschine.UI.ProgramGrid;

public class ProgramCommand {
    String command;

    public ProgramCommand(Direction direction, String writeThis, String goTo){
        command = "";
        command += direction.toString() + ";";
        command += writeThis + ";";
        command += goTo;

    }

    public ProgramCommand(String command){
        this.command = "";
        if (command.isEmpty()){
            this.command = "";
        } else if (command.equals("~End~")){
            this.command = "~End~";
        } else {
            if (command.charAt(1) == ';' & command.charAt(3) == ';'){
                this.command = command;
            } else {
                this.command = "";
            }
        }
    }

    @Override
    public String toString() {
        return command;
    }

    public Character getWhatToWrite(){
        return command.charAt(2);
    }

    public Direction getDirection(){
        return Direction.valueOf(command.charAt(0));
    }

    public int getNextState() {
        if (command.substring(4).equals("~End~")) {
            return -1;
        } else {
            return Integer.valueOf(command.substring(4));
        }
    }

    public boolean isValid(){
        if (!command.isEmpty()){
            return true;
        } else {
            return false;
        }
    }

    public boolean isEnd(){
        if (command.equals("~End~")){
            return true;
        } else {
            return false;
        }
    }
}
