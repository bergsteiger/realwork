//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dceldbB4.res");
USEPACKAGE("vclx40.bpi");
USEPACKAGE("VCL40.bpi");
USEPACKAGE("VCLDB40.bpi");
USEPACKAGE("elpkdbB4.bpi");
USEUNIT("ElDBReg.pas");
USEUNIT("Design\ElDbNavDsgn.pas");
USEPACKAGE("elpkdbB4.bpi");
USEUNIT("Design\ElDBTreeDsgn.pas");
USEUNIT("Design\ElDBTreeGridDsgn.pas");
USEUNIT("Design\RelSourcePropDsgn.pas");
USEFORMNS("Design\frmGridColProp.pas", frmGridColProp, TColumnDefs);
USEFORMNS("Design\frmStylesProp.pas", frmStylesProp, TStylesPropDlg);

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

