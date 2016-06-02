DEST=one
LIBS=-Llib -Wl,-Bstatic -lfusezip $(shell pkg-config libzip --libs) -Wl,-Bdynamic $(shell pkg-config fuse --libs)
LIB=lib/libfusezip.a
CXXFLAGS=-g -O0 -Wall -Wextra
RELEASE_CXXFLAGS=-O3 -Wall -Wextra
RELEASE_LDFLAGS=-static-libgcc -static-libstdc++
FUSEFLAGS=$(shell pkg-config fuse --cflags)
ZIPFLAGS=$(shell pkg-config libzip --cflags)
SOURCES=main.cpp
OBJECTS=$(SOURCES:.cpp=.o)
CLEANFILES=$(OBJECTS)
INSTALLPREFIX=/usr

all: $(DEST)

$(DEST): $(OBJECTS) $(LIB)
	$(CXX) $(OBJECTS) $(LDFLAGS) $(LIBS) \
	    -o $@

# main.cpp must be compiled separately with FUSEFLAGS
main.o: main.cpp
	$(CXX) -c $(CXXFLAGS) $(FUSEFLAGS) $(ZIPFLAGS) $< \
	    -Ilib \
	    -o $@

clean: 
	rm -f $(CLEANFILES)

release:
	make CXXFLAGS="$(RELEASE_CXXFLAGS)" LDFLAGS="$(RELEASE_LDFLAGS)" all

.PHONY: all release clean
