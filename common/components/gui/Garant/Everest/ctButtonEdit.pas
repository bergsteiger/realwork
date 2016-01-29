unit ctButtonEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ctButtonEdit.pas"
// Начат: 14.05.2008 17:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::elClone::TctButtonEdit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  elCustomButtonEdit
  ;

type
 TctButtonEdit = class(TelCustomButtonEdit)
 protected
 // property methods
   function pm_GetText: Il3CString;
   procedure pm_SetText(const aValue: Il3CString);
 public
 // public properties
   property Text: Il3CString
     read pm_GetText
     write pm_SetText;
 end;//TctButtonEdit

implementation

uses
  l3String
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TctButtonEdit

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
{$If not defined(NoScripts)}
// Регистрация TctButtonEdit
 TtfwClassRef.Register(TctButtonEdit);
{$IfEnd} //not NoScripts

end.