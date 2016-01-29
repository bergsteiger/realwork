//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("vgscene_dsgn_cb4.res");
USERES("..\vg_reg.dcr");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEUNIT("..\vg_ani.pas");
USEUNIT("..\vg_canvas_gdip.pas");
USEUNIT("..\vg_colors.pas");
USEUNIT("..\vg_controls.pas");
USEUNIT("..\vg_dsgn_path.pas");
USEUNIT("..\vg_effects.pas");
USEUNIT("..\vg_objects.pas");
USEUNIT("..\vg_scene.pas");
USEUNIT("..\vg_layouts.pas");
USEUNIT("..\vg_listbox.pas");
USEUNIT("..\vg_tabcontrol.pas");
USEUNIT("..\vg_textbox.pas");
USEUNIT("..\vg_extctrls.pas");
USEUNIT("..\vg_version.pas");
USEUNIT("..\vg_treeview.pas");
USEUNIT("..\vg_inspector.pas");
USEUNIT("..\vg_dsgn_bmp.pas");
USEUNIT("..\vg_dsgn_styles.pas");
USEUNIT("..\vg_memo.pas");
USEUNIT("..\vg_dsgn_lang.pas");
USEUNIT("..\vg_grid.pas");
USEUNIT("..\vg_actions.pas");
USEUNIT("..\vg_dsgn_imglist.pas");
USEUNIT("..\vg_dbctrls.pas");
USEUNIT("..\vg_dsgn.pas");
USEUNIT("..\vg_reg.pas");
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
