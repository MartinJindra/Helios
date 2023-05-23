package eu.mjindra.commandline;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import java.util.HashSet;

public class Parser {

    /**
     * Return all parsed arguments and values.
     * @param args not passed Argument
     * @return all parsed arguments and values
     * @throws ParseException is thrown if there are problems with the arguments and values
     */
    public static HashSet<String[]> parse(String[] args) throws ParseException {
        CommandLineParser parser = new DefaultParser();
        Options options = Arguments.getDefaultOptions();

        HashSet<String[]> arguments = new HashSet<>();

        CommandLine cmdline = parser.parse(options, args);
        for (Option line: cmdline.getOptions()) {
            arguments.add(new String[] {
                    line.getLongOpt(),
                    line.getValue()
            });
        }
        return arguments;
    }

    /**
     * Evaluate all processed arguments and values.
     * @param args not passed Argument
     * @return If are arguments used
     * @throws ParseException is thrown if there are problems with the arguments and values
     */
    public static boolean execute(String[] args) throws ParseException {
        HashSet<String[]> parse = Parser.parse(args);
        System.out.println(parse.size());
        if (parse.size() == 0)
            return false;
        for (String[] arg: parse) {

        }
        return true;
    }

}
