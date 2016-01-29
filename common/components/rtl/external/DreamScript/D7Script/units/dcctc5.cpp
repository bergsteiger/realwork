//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcctc5.res");
USEUNIT("dcreg.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldbx50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("vclx50.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
