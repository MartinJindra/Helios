# Helios

A simple project to create a DND character builder.

Your question may be "Why build a new character builder when Aurora is available?".

Because it is unmaintained, not opensource and not cross-platform.

So I want to build Helios. A sibling to Aurora.

## Deprecated

I decided to drop the Java implementation because Java does not have solid GUI Framework.

## Building

This program is written in Java. So _[JDK 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)_ (and upwards) and [Maven](https://maven.apache.org/install.html) are needed to build a package.

If necessary _JDK 11_ could also run it change line 15 and 16 in [pom.xml](pom.xml) to `11`.

To compile the package with all needed dependencies.

### Installing dependencies

**Windows**

Chocolatey (with admin privileges)

```
choco install oracle17jdk maven
```

Winget

```
winget install Microsoft.OpenJDK.17
```

And for Maven follow instructions on [apache.org](https://maven.apache.org/install.html).

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
