# --- variables defined by configure ---

SRC = .
QUADSUFFIX = 
PREFIX = x86_64-Linux
LIBDIRSUFFIX = 64
EXE = 

DEBUG ?= 0
NOUNDERSCORE = 0
QUAD = 0
QUADSIZE = 16

LT = ../../../LoopTools/x86_64-Linux/lib64
INCPATH = $(LT)/../include
STDLIBS = $(LT)/libooptools.a 

FC = gfortran
FFLAGSDEB = -O0 -g -Wall -Wno-unused-dummy-argument -Wno-tabs -ffpe-trap=invalid,overflow,zero -DDEBUG=$(DEBUG)
FFLAGSOPT = -O3
FFLAGS = $(FFLAGS$(DEB)) -ffixed-line-length-none -fno-range-check -march=native \
  -DQUAD=$(QUAD) -DQUADSIZE=$(QUADSIZE) \
  -DU77EXT=0

CC = gcc
CFLAGSDEB = -O0 -g -Wall -DDEBUG=$(DEBUG)
CFLAGSOPT = -O3 -g -fomit-frame-pointer -ffast-math
CFLAGS = $(CFLAGS$(DEB)) -m64 \
  -DQUAD=$(QUAD) -DQUADSIZE=$(QUADSIZE) \
  -DNOUNDERSCORE=$(NOUNDERSCORE) \
  -DBIGENDIAN=0

CXX = g++
CXXFLAGS = $(CFLAGS$(DEB)) -m64

MCFLAGS =
MCLIBS = -lpthread -lrt

LDFLAGS = -L/usr/lib/gcc/x86_64-linux-gnu/7/liblto_plugin.so -L/usr/lib/gcc/x86_64-linux-gnu/7 -L/usr/lib/gcc/x86_64-linux-gnu/7/../../../x86_64-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/7/../../../../lib -L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/7/../../.. -lgfortran -lm -lgcc_s -lgcc -lquadmath -lm -lgcc_s -lgcc -lgcc_s -lgcc

# --- end defs by configure ---

# makefile.in
# makefile template used by configure
# this file is part of FormCalc
# last modified 6 Oct 19 th

# Note: make permanent changes only in makefile.in,
# changes in makefile will be overwritten by configure.


.PHONY: all build clean distclean

MAKECMDGOALS ?= run

MAKECMDGOALS := $(MAKECMDGOALS:%=%$(EXE))

LEFTOVERS := $(wildcard [b]uild)

all: $(LEFTOVERS) $(MAKECMDGOALS)

AR = $(SRC)/tools/ar
RANLIB = $(SRC)/tools/ranlib

DIR = $(dir $(lastword $(MAKEFILE_LIST)))
LIB = $(subst /,_,$(patsubst $(SRC)/%,%,$(DIR:/=))).a
LIBS :=
VPATH := .:$(SRC):$(SRC)/models:$(SRC)/include

-include $(SRC)/renconst/*akefile

-include $(SRC)/squaredme/*akefile $(SRC)/squaredme/*/*akefile

CLEANLIBS := $(LIBS)

-include $(SRC)/util/*akefile

INCLUDE := $(patsubst %,-I%,$(subst :, ,$(VPATH):$(INCPATH)))
FINCLUDE = -I$(SRC)/F $(INCLUDE)
CINCLUDE = -I$(SRC)/C $(INCLUDE)

DEB := $(if $(filter 0,$(DEBUG)),OPT,DEB)
FFLAGS += $(FINCLUDE)
CFLAGS += $(CINCLUDE)


libs: $(LIBS)
	$(RANLIB)

build:
	$(RANLIB)


DEPS := $(wildcard *.d)

clean:
	$(RM) -r build
	$(RM) $(DEPS) $(DEPS:%.d=%.tm) $(DEPS:%.d=%.tm.c) \
	  $(DEPS:%.d=%.o) $(DEPS:%.d=%$(EXE)) $(CLEANLIBS) libs

distclean: clean
	$(RM) $(LIBS) makefile simd.h


-include [FC]-squaredme.d
-include [FC]-renconst.d

F-%.d: deps-%.c
	$(CPP) -MM $(FINCLUDE) $< | sed 's|^.*:|$@:|' > $@

C-%.d: deps-%.c
	$(CPP) -MM $(CINCLUDE) $< | sed 's|^.*:|$@:|' > $@


-include $(MAKECMDGOALS:%$(EXE)=%.d)
%.d: $(SRC)/%.F
	{ grep "^[^c*].*Mma" $< >/dev/null 2>&1 ; \
	  echo "MMA = $$?" ; \
	  echo "$*$(EXE): $@ libs" ; \
	  $(CPP) -M $(FINCLUDE) -x c $< | sed 's|^.*:|$@:|' ; \
	} > $@

PREFIX :=

ifeq ($(MMA), 0)
%$(EXE):: $(SRC)/%.F %.d $(SRC)/tools/mktm
	$(FC) $(FFLAGS) -DMMA -DPREFIX=$(PREFIX) -E $< | $(SRC)/tools/mktm $*.tm
	$(FC) $(FFLAGS) -DMMA -DPREFIX=$(PREFIX) -c $<
	CC="$(SRC)/tools/fcc" REALCC="$(CC) $(CFLAGS)" \
	CXX="$(SRC)/tools/f++" REALCXX="$(CXX) $(CXXFLAGS)" \
	  PATH="$(PATH):$(SRC)/tools" \
	  mcc $(MCFLAGS) -o $@ $*.tm $*.o $(LIBS) $(STDLIBS) $(LDFLAGS) $(MCLIBS)
	-$(RM) $*.o $*.tm.c
else
%$(EXE):: $(SRC)/%.F %.d
	$(FC) $(FFLAGS) -DPREFIX=$(PREFIX) -o $@ $< $(LIBS) $(STDLIBS)
	-$(RM) $*.o
endif

