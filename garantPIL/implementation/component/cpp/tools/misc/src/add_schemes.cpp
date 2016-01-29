#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"
#include "rev.h"

#include "SearchB.h"
#include "protect.h"

#include "garantPIL/implementation/component/cpp/libs/gchange/include/parser.h"
#include "garantPIL/implementation/component/cpp/libs/gchange/include/context.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

extern	int StrRev( char * pStr, revision& theRev );

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	bool b_work = false;
	BaseInfo info;
	if (base->FindBaseInfo (39, info) == sizeof (BaseInfo)) {
		revision r;
		StrRev ("25/4/2009:0:0", r);
		if (rev_daysdiff (r, info.LastUpdate) == 0)
			b_work = true;
	}
	delete base;
	if (!b_work) {
		printf ("­Ґв 39 бҐЈ¬Ґ­в , Ё«Ё ҐЈ® аҐўЁ§Ёп ­Ґ 25/4/2009\n");
		exit (EXIT_SUCCESS);
	}
	static char rules[] =
	"once\n"\
	"  Here.add(202,\"Актуальная бухгалтерия\",\"Current accountancy\",0);\n"\
	"  Here.add(213,\"Законодательство в схемах\",\"Legislation in Diagrams\",2);\n"\
	"  Here.add(214,\"Законодательство в схемах. Налоги и бухучет\",\"Legislation in Diagrams. Taxes, Accounting\",1);\n"\
	"  Here.add(220,\"АКЦИЯ. Законодательство в схемах. Налоги и бухучет\",\"Action. Legislation in Diagrams. Taxes, Accounting\",0);\n"
	"end\n";
	
	StdBigBase *b  = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	RuleParser *r = new RuleParser (rules);
	Context *c = new Context ();
	c->set_baseinfo_revision (info.LastUpdate);
	c->base (b);
	c->rule (r);
	c->do_changes ();
	printf ("\n");
	delete b;
}
