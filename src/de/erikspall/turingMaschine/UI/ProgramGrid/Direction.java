package de.erikspall.turingMaschine.UI.ProgramGrid;

public enum Direction {
    LEFT,NONE,RIGHT;

    @Override
    public String toString() {
        if (this == LEFT){
            return "L";
        } else if (this == NONE){
            return "0";
        } else if (this == RIGHT){
            return "R";
        }
        return "FAILED";
    }

    public static Direction valueOf(Character c){
        switch (c){
            case 'L':{
                return LEFT;

            }
            case '0':{
                return NONE;

            }
            case 'R':{
                return RIGHT;

            }
        }
        return null;
    }
}
