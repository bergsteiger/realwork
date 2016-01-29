//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtGmSuiteExpC50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("gtGmSuiteIntf.pas");
USEPACKAGE("gtDocEngC50.bpi");
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
