LIBS += $(LIB)
VPATH := $(DIR):$(VPATH)
OBJS_RC :=

OBJS := \
  $(DIR)RenConst.o

OBJS_RC += $(OBJS)

$(LIB)($(OBJS)): F-renconst.d $(DIR)RenConst.Fh


$(LIB): $(LIB)($(OBJS_RC))

