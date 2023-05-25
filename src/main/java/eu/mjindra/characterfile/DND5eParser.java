package eu.mjindra.characterfile;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Parser for .dnd5e character file.
 * @author Martin Jindra
 * @version 23.05.2023
 */
public class DND5eParser {

    private Path file;
    private Document document;
    private Element rootElement;

    private Character character;

    public DND5eParser(String file) throws FileNotFoundException {
        this();
        this.setFile(file);
    }

    public DND5eParser() {
        this.character = new Character();
    }

    public Character getCharacter() {
        return this.character;
    }

    public void setFile(String file) throws FileNotFoundException {
        if (!file.isBlank()) {
            this.file = Path.of(file);
            if (!Files.exists(this.file))
                throw new FileNotFoundException(String.format("%s does not exists.", file));
        }
    }

    /**
     * Parse the entire XML.
     */
    public void parseXML() {

        try {
            this.document = new SAXBuilder().build(this.file.toFile());
            this.rootElement = this.document.getRootElement();

            this.parseInformation();

        } catch (JDOMException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Parse the information-tag and display-information-tag.
     */
    private void parseInformation() {
        Element information = this.rootElement.getChild("information");
        Element displayInformation = this.rootElement.getChild("display-properties");

        this.character.setName(displayInformation.getChildText("name"));
        this.character.setRace(displayInformation.getChildText("race"));
        this.character.setClasses(displayInformation.getChildText("class"));
        this.character.setLevel(Byte.parseByte(displayInformation.getChildText("level")));
        this.character.setBackground(displayInformation.getChildText("background"));
    }
}
