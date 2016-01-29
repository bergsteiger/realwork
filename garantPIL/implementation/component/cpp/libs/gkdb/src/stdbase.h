
#ifndef __STD_BASE_H
#define __STD_BASE_H

#include "base.h"

#define MAX_VAL_STR_AS_KEY 31

#define ID_FATS_IN_AUX "~FIA~"

class YBase : public Base {
public:
	YBase (const char*, int, int ndt_cache = -1);

	virtual ~YBase ();

public:
	virtual void OpenIndices ();

	virtual int IsOkWithoutText ();
	virtual int IsOk ();			// check whether all is ok

	int IsPacked ();
	bool is_demo_base ();
	bool is_vip_base ();
	void get_percents (std::vector<std::pair <std::string, long> > &gauges);

public:
	virtual	void open_saw_bases (int);
	void	close_saw_bases ();
};

extern "C" {
extern int CreatedBigStream;
}

extern void MorphoReadOnlyAccessForModifiedBase (YBase* pBase, bool bInitTurboForReadOnly = true);

class StdBigBase : public YBase {
public:
	StdBigBase (const char* name, int mode, int ndt_cache  = -1);

	virtual ~StdBigBase ();

public:
	virtual	void open_saw_bases (int);
};

class GLBase : public StdBigBase {
public:
	GLBase (const char* name);

	virtual ~GLBase ();
};

#endif

