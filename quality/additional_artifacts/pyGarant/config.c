/* Generated automatically from /usr/local/lib/python2.1/config/config.c.in by makesetup. */
/* -*- C -*- ***********************************************
Copyright (c) 2000, BeOpen.com.
Copyright (c) 1995-2000, Corporation for National Research Initiatives.
Copyright (c) 1990-1995, Stichting Mathematisch Centrum.
All rights reserved.

See the file "Misc/COPYRIGHT" for information on usage and
redistribution of this file, and for a DISCLAIMER OF ALL WARRANTIES.
******************************************************************/

/* Module configuration */

/* !!! !!! !!! This file is edited by the makesetup script !!! !!! !!! */

/* This file contains the table of built-in modules.
   See init_builtin() in import.c. */

#include "Python.h"


extern void initgc(void);
extern void initthread(void);
extern void initsignal(void);
extern void initregex(void);
extern void initpcre(void);
extern void initposix(void);
extern void initsignal(void);
extern void init_sre(void);
extern void initarray(void);
extern void initcmath(void);
extern void initmath(void);
extern void initstrop(void);
extern void initstruct(void);
extern void inittime(void);
extern void initoperator(void);
extern void init_codecs(void);
extern void initunicodedata(void);
extern void init_locale(void);
extern void initfcntl(void);
extern void initpwd(void);
extern void initgrp(void);
extern void initerrno(void);
extern void initselect(void);
extern void init_socket(void);
extern void initmmap(void);
extern void initmd5(void);
extern void initsha(void);
extern void initrotor(void);
extern void initnew(void);
extern void initbinascii(void);
extern void initparser(void);
extern void initcStringIO(void);
extern void initcPickle(void);

/* -- ADDMODULE MARKER 1 -- */

extern void PyMarshal_Init(void);
extern void initimp(void);

struct _inittab _PyImport_Inittab[] = {

	{"gc", initgc},
	{"thread", initthread},
	{"signal", initsignal},
	{"regex", initregex},
	{"pcre", initpcre},
	{"posix", initposix},
	{"signal", initsignal},
	{"_sre", init_sre},
	{"array", initarray},
	{"cmath", initcmath},
	{"math", initmath},
	{"strop", initstrop},
	{"struct", initstruct},
	{"time", inittime},
	{"operator", initoperator},
	{"_codecs", init_codecs},
	{"unicodedata", initunicodedata},
	{"_locale", init_locale},
	{"fcntl", initfcntl},
	{"pwd", initpwd},
	{"grp", initgrp},
	{"errno", initerrno},
	{"select", initselect},
	{"_socket", init_socket},
	{"mmap", initmmap},
	{"md5", initmd5},
	{"sha", initsha},
	{"rotor", initrotor},
	{"new", initnew},
	{"binascii", initbinascii},
	{"parser", initparser},
	{"cStringIO", initcStringIO},
	{"cPickle", initcPickle},

/* -- ADDMODULE MARKER 2 -- */

	/* This module lives in marshal.c */
	{"marshal", PyMarshal_Init},

	/* This lives in import.c */
	{"imp", initimp},

	/* These entries are here for sys.builtin_module_names */
	{"__main__", NULL},
	{"__builtin__", NULL},
	{"sys", NULL},
	{"exceptions", init_exceptions},

	/* Sentinel */
	{0, 0}
};
