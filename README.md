# Helios

A simple project to create a DND character builder.

Your question may be "Why build a new character builder when Aurora is available?".

Because it is unmaintained, not opensource and not cross-platform.

So I want to build Helios. A sibling to Aurora.

## Building

This program is written in Java. So *[JDK 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)* (and upwards) and [Maven](https://maven.apache.org/install.html) are needed to build a package.

If necessary *JDK 11* could also run it change line 15 and 16 in [pom.xml](pom.xml) to `11`.

To compile the package with all needed dependencies.

### Installing dependencies

**Fedora 38+**
```
sudo dnf install java-17-openjdk-devel maven
```

**Debian 11+**
```
sudo apt update
sudo apt install openjdk-17-jdk maven
```

## Compiling a package
```
mvn compile assembly:single
```
