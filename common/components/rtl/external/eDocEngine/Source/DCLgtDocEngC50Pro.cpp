//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtDocEngC50Pro.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCLJPG50.bpi");
USEPACKAGE("gtDocEngC50Pro.bpi");
USEUNIT("gtDocReg.pas");
USERES("gtDocReg.dcr");
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
