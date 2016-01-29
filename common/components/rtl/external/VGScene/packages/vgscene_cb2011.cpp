//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("..\vg_dsgn_path.pas", Vg_dsgn_path, frmPathDataDesigner);
USEFORMNS("..\vg_dsgn_lang.pas", Vg_dsgn_lang, vgLangDesigner);
USEFORMNS("..\vg_dsgn_styles.pas", Vg_dsgn_styles, frmStyleDesigner);
USEFORMNS("..\vg_dsgn_imglist.pas", Vg_dsgn_imglist, frmDsgnImageList);
USEFORMNS("..\vg_dsgn_bmp.pas", Vg_dsgn_bmp, frmBitmapEditor);
USEFORMNS("..\vg_dsgn.pas", Vg_dsgn, vgBrushDesign);
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
