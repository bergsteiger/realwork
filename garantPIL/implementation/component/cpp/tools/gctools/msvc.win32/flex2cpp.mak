FLEX=flex.exe -L -o

SOURCE=..\src
TARGET=..\src

all:               belongs.cpp blobtable.cpp classes.cpp complect.cpp gcini.cpp kwfile.cpp loadstringmap.cpp normfile.cpp sources.cpp sttop.cpp


belongs.cpp:       $(SOURCE)\belongs.flex
                   $(FLEX)$(TARGET)\belongs.cpp $(SOURCE)\belongs.flex

blobtable.cpp:     $(SOURCE)\blobtable.flex
                   $(FLEX)$(TARGET)\blobtable.cpp $(SOURCE)\blobtable.flex

classes.cpp:       $(SOURCE)\classes.flex
                   $(FLEX)$(TARGET)\classes.cpp $(SOURCE)\classes.flex

complect.cpp:      $(SOURCE)\complect.flex
                   $(FLEX)$(TARGET)\complect.cpp $(SOURCE)\complect.flex

gcini.cpp:         $(SOURCE)\gcini.flex
                   $(FLEX)$(TARGET)\gcini.cpp $(SOURCE)\gcini.flex

kwfile.cpp:        $(SOURCE)\kwfile.flex
                   $(FLEX)$(TARGET)\kwfile.cpp $(SOURCE)\kwfile.flex

loadstringmap.cpp: $(SOURCE)\loadstringmap.flex
                   $(FLEX)$(TARGET)\loadstringmap.cpp $(SOURCE)\loadstringmap.flex

normfile.cpp:      $(SOURCE)\normfile.flex
                   $(FLEX)$(TARGET)\normfile.cpp $(SOURCE)\normfile.flex

sources.cpp:       $(SOURCE)\sources.flex
                   $(FLEX)$(TARGET)\sources.cpp $(SOURCE)\sources.flex

sttop.cpp:         $(SOURCE)\sttop.flex
                   $(FLEX)$(TARGET)\sttop.cpp $(SOURCE)\sttop.flex
