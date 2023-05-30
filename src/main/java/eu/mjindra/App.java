package eu.mjindra;

import eu.mjindra.character.DND5eParser;
import eu.mjindra.commandline.Parser;
import org.apache.commons.cli.ParseException;

import java.io.FileNotFoundException;
import java.util.HashMap;

/**
 * DND Character Builder.
 *
 * @author Martin Jindra
 * @version 23.05.2023
 */
public class App {

    public static final String appName = "DND Character Builder";

    public static void main(String[] args) {

        try {
            Parser parser = new Parser(appName);

            HashMap<String, String> arguments = parser.parse(args);
            if (arguments.size() > 0 && arguments.containsKey("input")) {
                DND5eParser dnd5eParser = new DND5eParser(arguments.get("input"));
                dnd5eParser.parseXML();

                if (arguments.containsKey("display"))
                    System.out.println(dnd5eParser.getCharacter().summarizeInformation());

            }
        } catch (ParseException | FileNotFoundException e) {
            System.err.println(e.getMessage());
        }
    }
}