//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtRaveExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEUNIT("gtRvXportIntf.pas");
USEPACKAGE("gtDocEngC50.bpi");
USEPACKAGE("Rave50VCLBEX50.bpi");
USEPACKAGE("VCLJPG50.bpi");
USEPACKAGE("gtDocEngC50Pro.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
