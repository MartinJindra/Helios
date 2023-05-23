package eu.mjindra;

import eu.mjindra.commandline.Parser;
import org.apache.commons.cli.ParseException;

public class App {

    public static final String appName = "DND Character Builder";

    public static void main( String[] args ) {
        try {
            Parser.execute(args);
        } catch (ParseException pe) {
            System.err.println(pe.getMessage());
        }
    }
}
