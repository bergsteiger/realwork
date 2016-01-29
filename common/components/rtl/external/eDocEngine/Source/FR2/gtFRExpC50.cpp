//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtFRExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtDocEngC50.bpi");
USEUNIT("gtFRXportIntf.pas");
USEPACKAGE("Fr5.bpi");
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
