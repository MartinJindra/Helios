package eu.mjindra.commandline;

import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionGroup;
import org.apache.commons.cli.Options;
import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;

public class Arguments {

    /**
     * Return default options.
     * @return default options
     */
    public static @NotNull Options getDefaultOptions() {
        Options options = new Options();

        // Program information
        options.addOptionGroup(Arguments.getInformationOptions());

        // IO Options
        for (Option io: Arguments.getIOOptions()) {
            options.addOption(io);
        }

        return options;
    }

    /**
     * Return options that inform about the program.
     * @return options
     */
    private static @NotNull OptionGroup getInformationOptions() {
        OptionGroup infoGroup = new OptionGroup();
        infoGroup.setRequired(false);
        infoGroup.addOption(
                Option.builder("v")
                        .argName("version")
                        .desc("Display version.")
                        .build()
        );
        infoGroup.addOption(
                Option.builder("h")
                        .argName("help")
                        .desc("Print help.")
                        .build()
        );
        return infoGroup;
    }

    /**
     * Return options that use files.
     * @return options
     */
    @Contract(" -> new")
    private static Option @NotNull [] getIOOptions() {
        return new Option[] {
                Option.builder("i")
                        .longOpt("input")
                        .argName("file")
                        .hasArg()
                        .desc("Input .dnd5e file.")
                        .build()
                ,
                Option.builder("o")
                        .longOpt("output")
                        .argName("file")
                        .hasArg()
                        .optionalArg(true)
                        .desc("Generated output PDF.")
                        .build()
        };
    }
}
