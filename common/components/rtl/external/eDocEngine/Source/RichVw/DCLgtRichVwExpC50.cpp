//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtRichVwExpC50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("gtRichVwExpReg.pas");
USERES("gtRichVwExpReg.dcr");
USEPACKAGE("gtRichVwExpC50.bpi");
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
