//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtAceExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtDocEngC50.bpi");
USEPACKAGE("gtDocEngC50Pro.bpi");
USEUNIT("gtAceXportIntf.pas");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("acepro55run.bpi");
USEPACKAGE("gtRtlC50.bpi");
USEPACKAGE("vcljpg50.bpi");
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
