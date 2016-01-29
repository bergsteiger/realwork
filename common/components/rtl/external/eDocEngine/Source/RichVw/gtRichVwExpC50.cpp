//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtRichVwExpC50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("gtRichViewIntf.pas");
USEPACKAGE("gtDocEngC50.bpi");
USEPACKAGE("gtDocEngC50Pro.bpi");
USEPACKAGE("RVPkgCB5.bpi");
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
