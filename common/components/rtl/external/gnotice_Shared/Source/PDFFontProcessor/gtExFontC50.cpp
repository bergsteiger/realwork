//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtExFontC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtRtlC50.bpi");
USEUNIT("gtExPDFFont.pas");
USEPACKAGE("gtFontC50.bpi");
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
