unit ctButtonEdit;

// Модуль: "w:\common\components\gui\Garant\Everest\ctButtonEdit.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , elCustomButtonEdit
 , l3Interfaces
;

type
 TctButtonEdit = class(TelCustomButtonEdit)
  protected
   function pm_GetText: Il3CString;
   procedure pm_SetText(const aValue: Il3CString);
  public
   property Text: Il3CString
    read pm_GetText
    write pm_SetText;
 end;//TctButtonEdit

implementation

uses
 l3ImplUses
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TctButtonEdit.pm_GetText: Il3CString;
//#UC START# *482AE97A02F7_482AE8CA0176get_var*
//#UC END# *482AE97A02F7_482AE8CA0176get_var*
begin
//#UC START# *482AE97A02F7_482AE8CA0176get_impl*
 Result := CText;
//#UC END# *482AE97A02F7_482AE8CA0176get_impl*
end;//TctButtonEdit.pm_GetText

procedure TctButtonEdit.pm_SetText(const aValue: Il3CString);
//#UC START# *482AE97A02F7_482AE8CA0176set_var*
//#UC END# *482AE97A02F7_482AE8CA0176set_var*
begin
//#UC START# *482AE97A02F7_482AE8CA0176set_impl*
 Inc(FRestrictOnTextChange);
 try
  if not l3Same(aValue, CText) then
   CText := aValue;
 finally
  Dec(FRestrictOnTextChange);
 end;//try..finally

 AdjustWidth; // Костыль к K278854646
//#UC END# *482AE97A02F7_482AE8CA0176set_impl*
end;//TctButtonEdit.pm_SetText

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TctButtonEdit);
 {* Регистрация TctButtonEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
