unit NOT_FINISHED_vg_listbox;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vg_listbox.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Impl::vg_listbox
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

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
// Регистрация TvgStringComboBox
 TtfwClassRef.Register(TvgStringComboBox);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgComboBox
 TtfwClassRef.Register(TvgComboBox);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgListBoxItem
 TtfwClassRef.Register(TvgListBoxItem);
{$IfEnd} //not NoScripts AND not NoVGScene

end.