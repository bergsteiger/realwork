//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dceldbB6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("VCL.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("dbx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("elpackB6.bpi");
USEPACKAGE("elpkdbB6.bpi");
USEUNIT("ElDBReg.pas");
USEUNIT("Design\ElDbNavDsgn.pas");
USEUNIT("Design\ElDBTreeDsgn.pas");
USEUNIT("Design\ElDBTreeGridDsgn.pas");
USEUNIT("Design\RelSourcePropDsgn.pas");
USEFORMNS("Design\frmGridColProp.pas", frmGridColProp, TColumnDefs);
USEFORMNS("Design\frmStylesProp.pas", frmStylesProp, TStylesPropDlg);

//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
    return 1;
}
//---------------------------------------------------------------------------

