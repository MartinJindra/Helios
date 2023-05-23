package eu.mjindra.characterfile;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
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

    public DND5eParser(String file) throws FileNotFoundException {
        this.setFile(file);
    }

    public void setFile(String file) throws FileNotFoundException {
        if (!file.isBlank()) {
            this.file = Path.of(file);
            if (!Files.exists(this.file)) {
                throw new FileNotFoundException(String.format("%s does not exists.", file));
            }
        }
    }

    /**
     * Parse the XML.
     */
    public void parseXML() {

        try {
            byte[] content = Files.readAllBytes(this.file);
            StringBuilder out = new StringBuilder();
            for (byte b : content) {
                out.append((char) b);
            }
            System.out.println(out);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        try {
            DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            Document doc = builder.parse(this.file.toFile());
            doc.getDocumentElement().normalize();

            Node first = doc.getElementsByTagName("character").item(0);
            NodeList nodeList = first.getChildNodes();
            int n = nodeList.getLength();
            Node current;
            for (int i=0; i<n; i++) {
                current = nodeList.item(i);
                if(current.getNodeType() == Node.ELEMENT_NODE) {
                    //System.out.println(current.getNodeName() + ": " + current.getTextContent());
                }
            }

        } catch (SAXException | IOException | ParserConfigurationException e) {
            throw new RuntimeException(e);
        }


    }
}
