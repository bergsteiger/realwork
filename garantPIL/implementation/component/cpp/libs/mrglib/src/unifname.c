#include <stdlib.h>
#include <stdio.h>

#include <strings.h>

#ifndef __GNUC__
//#error You must make the appropriate port of this file!
#endif

#include "gdbapi.h"

static char *strslash(char *);

char *unifname(const char *fname, const char *cwd)
{
	char *goodcwd, *newname, *oldname;
	char *s, *p;

	oldname = (char *)ml_malloc(strlen(fname) + 5);
	strcpy(oldname, fname);
#if defined(__GO32__) || defined(__CYGWIN32__)
	// check for absolute path in fname
	strslash(oldname);
	if (oldname[1] == ':' && oldname[2] == '/')
		return oldname;
#else
	if (*oldname == '/') {
		// TODO : check for './' and '../' sequences
		return oldname;
	}
#endif
	goodcwd = (char *)ml_malloc(strlen(cwd) + 2);
	strcpy(goodcwd, cwd);
	strslash(goodcwd);
	s = strchr(cwd, '\0')-1;
	if (*s != '/') {
		*s = '/'; 
		*(s+1) = '\0';
	}
	p = oldname;
	while(p[0] == '.' && p[1] == '/') p += 2;
	while (p[0] == '.' && p[1] == '.' && p[2] == '/') {
		p += 3;
		while(p[0] == '.' && p[1] == '/') p += 2;
		if (!s) {
			free(goodcwd);
			free(oldname);
			return NULL;
		}
		*s = '\0';
		s = strrchr(goodcwd, '/');
		if (s) s[1] = '\0';
		else {
			free(goodcwd);
			free(oldname);
			return NULL;
		}
		printf("Debug: path to add fname: %s\n", goodcwd);
	}
	newname = (char *)ml_malloc(strlen(p) + strlen(goodcwd) + 5);
	strcpy(newname, goodcwd);
	strcat(newname, p);
	free(goodcwd);
	free(oldname);
	return newname;
}

static char *strslash(char *str)
{
	char *s = str;

	while ((s = strchr(s, '\\')) != NULL)
		*s = '/';
	return str;
}
