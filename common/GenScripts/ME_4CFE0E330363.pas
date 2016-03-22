unit NOT_FINISHED_vg_listbox;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vg_listbox.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vg_listbox" MUID: (4CFE0E330363)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vg_controls
 , vg_scene
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
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , VGComboBoxPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgStringComboBox);
 {* Регистрация TvgStringComboBox }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgComboBox);
 {* Регистрация TvgComboBox }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgListBoxItem);
 {* Регистрация TvgListBoxItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
