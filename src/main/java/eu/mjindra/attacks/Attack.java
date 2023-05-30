package eu.mjindra.attacks;

import eu.mjindra.utils.properties.Ability;
import eu.mjindra.utils.properties.Damage;
import eu.mjindra.utils.properties.Range;

/**
 * A class representing an attack in DND.
 *
 * @author Martin Jindra
 * @version 27.05.2023
 */
public class Attack {

    private String uuid;

    private String name;

    private Range shortRange, longRange;

    private byte attack;

    private Damage damage;

    private boolean displayed;
    private Ability ability;

}
