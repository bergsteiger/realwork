#include "shared/Core/fix/mpcxc.h"
#include "stdbase.h"
#include "basemask.h"
#include "garver.h"

int main(int argc, char **argv)
{
	if (argc < 2) {
		printf("GARANT Base Diller info set programm v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
		printf("Usage: %s <base> [<mess file>]\n", argv[0]);
		return 1;
	}
	YBase base(argv[1], ACE_OS_O_RDONLY);
	if (!base.IsOk()) {
		printf("Error opening base.\n");
		return 1;
	}
	char pNewDillerInfo [] = "This is Diller info string, laying in NDT file";
	
        Index * pAuxInd = base.FindIndex ( "Aux" );
        char pDillerInfoKey [] = "DInf";
	Stream * pStr;

	if ( argc > 2 ) {
		pStr = pAuxInd -> Open ( pDillerInfoKey, TRUE );
		pStr -> Write ( pNewDillerInfo, strlen (pNewDillerInfo) );

		printf ( "New message:\n\t%s\n", pNewDillerInfo );
	} else {
		pStr = pAuxInd -> Open ( pDillerInfoKey );
		char * pOldMess = (char*) malloc ( pStr->Length() );
		pStr -> Read ( pOldMess, pStr->Length () );

		printf ( "Current message:\n\t%s\n", pOldMess );
	}
	
	pAuxInd->Close ( pStr );
	return 0;
}

