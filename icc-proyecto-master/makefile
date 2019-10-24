build=./build
src=./src
doc=./doc
jar=Main.jar

all: clean jar doc

jar: compile
	jar cfe \$(jar) buscaminas/vista/Main -C \$(build) .
	rm -R -f \$(build)

clean:
	rm -R -f \$(build)
	rm -R -f \$(doc)
	rm -f \$(jar)

compile:
	mkdir -p \$(build)
	javac -d \$(build) -sourcepath \$(src) \$(src)/buscaminas/vista/Main.java -Xlint:unchecked

doc:
	mkdir \$(doc)
	javadoc -html5 -version -author -d \$(doc) -sourcepath \$(src) -subpackages buscaminas
