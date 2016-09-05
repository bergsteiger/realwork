unit NOT_FINISHED_evCustomEditor;
 {* Базовый класс окна редактора с кучей "полезных" функций. Рекомендуется для конечного пользователя (программиста). }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomEditor.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevCustomEditor" MUID: (4829D89703D2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEditorModelPart
 , evdTypes
 , evTypes
;

type
 TevCustomEditor = class(TevCustomEditorModelPart)
  {* Базовый класс окна редактора с кучей "полезных" функций. Рекомендуется для конечного пользователя (программиста). }
  protected
   function InTable: Boolean; virtual;
   function DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean; virtual;
   function AllowAutoSelectByMouse: Boolean; virtual;
  public
   function InsertPageBreak(NeedNewSection: Boolean = False;
    aPageOrientation: TevPageOrientation = evdTypes.ev_poPortrait): Boolean; virtual;
   procedure DecIndent; virtual;
   procedure IncIndent; virtual;
 end;//TevCustomEditor

implementation

uses
 l3ImplUses
 , evdInterfaces
 {$If NOT Defined(NoScripts)}
 , TevCustomEditorWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4829D89703D2impl_uses*
 //#UC END# *4829D89703D2impl_uses*
;

function TevCustomEditor.InTable: Boolean;
//#UC START# *54C0FF7C0012_4829D89703D2_var*
//#UC END# *54C0FF7C0012_4829D89703D2_var*
begin
//#UC START# *54C0FF7C0012_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FF7C0012_4829D89703D2_impl*
end;//TevCustomEditor.InTable

function TevCustomEditor.InsertPageBreak(NeedNewSection: Boolean = False;
 aPageOrientation: TevPageOrientation = evdTypes.ev_poPortrait): Boolean;
//#UC START# *54C10AFF0075_4829D89703D2_var*
//#UC END# *54C10AFF0075_4829D89703D2_var*
begin
//#UC START# *54C10AFF0075_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C10AFF0075_4829D89703D2_impl*
end;//TevCustomEditor.InsertPageBreak

procedure TevCustomEditor.DecIndent;
//#UC START# *54C10BEA0345_4829D89703D2_var*
//#UC END# *54C10BEA0345_4829D89703D2_var*
begin
//#UC START# *54C10BEA0345_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C10BEA0345_4829D89703D2_impl*
end;//TevCustomEditor.DecIndent

procedure TevCustomEditor.IncIndent;
//#UC START# *54C10BFE0098_4829D89703D2_var*
//#UC END# *54C10BFE0098_4829D89703D2_var*
begin
//#UC START# *54C10BFE0098_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C10BFE0098_4829D89703D2_impl*
end;//TevCustomEditor.IncIndent

function TevCustomEditor.DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean;
//#UC START# *55CDBD7600D4_4829D89703D2_var*
//#UC END# *55CDBD7600D4_4829D89703D2_var*
begin
//#UC START# *55CDBD7600D4_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CDBD7600D4_4829D89703D2_impl*
end;//TevCustomEditor.DoSearchHyperLink

function TevCustomEditor.AllowAutoSelectByMouse: Boolean;
//#UC START# *4C346719001A_4829D89703D2_var*
//#UC END# *4C346719001A_4829D89703D2_var*
begin
//#UC START# *4C346719001A_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C346719001A_4829D89703D2_impl*
end;//TevCustomEditor.AllowAutoSelectByMouse

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomEditor);
 {* Регистрация TevCustomEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
