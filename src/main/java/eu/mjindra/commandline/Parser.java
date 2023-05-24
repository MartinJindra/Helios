package eu.mjindra.commandline;

import org.apache.commons.cli.*;

import java.util.Dictionary;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;

/**
 * Parser for commandline arguments.
 * @author Martin Jindra
 * @version 23.05.2023
 */
public class Parser {

    private String appName;

    public Parser(String appName) {
        this.appName = appName;
    }

    /**
     * Return all parsed arguments and values.
     * @param args not passed Argument
     * @return all parsed arguments and values
     * @throws ParseException is thrown if there are problems with the arguments and values
     */
    public HashMap<String, String> parse(String[] args) throws ParseException {
        CommandLineParser parser = new DefaultParser();
        Options options = Arguments.getDefaultOptions();

        HashMap<String, String> arguments = new HashMap<>();

        CommandLine cmdline = parser.parse(options, args);
        for (Option line: cmdline.getOptions()) {
            if (line.getLongOpt().equals("help"))
                this.printHelp();

            arguments.put(
                    line.getLongOpt(),
                    line.getValue()
            );
        }
        return arguments;
    }

    /**
     * Print help
     */
    private void printHelp() {
        new HelpFormatter().printHelp(this.appName, Arguments.getDefaultOptions());
    }
}
