//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtDocEngC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCLJPG50.bpi");
USEUNIT("gtXportIntf.pas");
USEUNIT("gtDocConsts.pas");
USEUNIT("gtDocUtils.pas");
USEUNIT("gtMetafileProcessor.pas");
USEUNIT("gtCstDocEng.pas");
USEPACKAGE("gtCompressionC50.bpi");
USEPACKAGE("gtRtlC50.bpi");
USEPACKAGE("gtFiltersC50.bpi");
USEUNIT("gtDocResStrs.pas");
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
