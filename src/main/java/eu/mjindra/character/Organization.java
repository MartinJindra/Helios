package eu.mjindra.character;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * An organization for DnD.
 *
 * @author Martin Jindra
 * @version 01.06.2023
 */
public class Organization {

    private String name;

    private byte[] symbol;

    private String allies;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getSymbol() {
        return symbol;
    }

    public void setSymbol(byte[] symbol) {
        this.symbol = symbol;
    }

    /**
     * Set the symbol of an organization via a path.
     * @param symbolPath Path to symbol
     */
    public void setSymbol(String symbolPath) {
        try {
            Path p = Path.of(symbolPath);
            if (Files.exists(p))
                Files.readAllBytes(p);
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }

    public String getAllies() {
        return allies;
    }

    public void setAllies(String allies) {
        this.allies = allies;
    }

    public String toString() {
        StringBuilder str = new StringBuilder(String.format("## Organization %s\n", this.name));
        str.append(String.format("Allies: %s", this.allies));
        return str.toString();
    }
}
