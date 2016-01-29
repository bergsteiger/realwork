//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtRaveExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtRaveExpC50.bpi");
USEUNIT("gtRaveExpReg.pas");
USERES("gtRaveExpReg.dcr");
USEPACKAGE("Rave50VCLBEX50.bpi");
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
