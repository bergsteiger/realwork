unit NOT_FINISHED_vg_listbox;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// ������: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vg_listbox.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Impl::vg_listbox
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vg_controls,
  vg_scene
  ;

type
 TvgStringComboBox = class(TvgTextControl)
 end;//TvgStringComboBox

 TvgComboBox = class(TvgControl)
 end;//TvgComboBox

 TvgListBoxItem = class(TvgTextControl)
 end;//TvgListBoxItem

 TvgListBox = class
 end;//TvgListBox
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  VGComboBoxPack
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  ;

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� TvgStringComboBox
 TtfwClassRef.Register(TvgStringComboBox);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� TvgComboBox
 TtfwClassRef.Register(TvgComboBox);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� TvgListBoxItem
 TtfwClassRef.Register(TvgListBoxItem);
{$IfEnd} //not NoScripts AND not NoVGScene

end.