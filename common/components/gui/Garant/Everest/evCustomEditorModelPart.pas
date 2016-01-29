unit evCustomEditorModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomEditorModelPart.pas"
// Начат: 26.02.2010 10:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevCustomEditorModelPart
//
// Часть TevCustomEditor перенесённая на модель
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evMultiSelectEditorWindow
  ;

type
 TevAllowParaType = (
  {* Разрешённые типы параграфов }
   ev_aptTable
 , ev_aptSBS
 , ev_aptPicture
 , ev_aptFormula
 , ev_aptPageBreak
 );//TevAllowParaType

 TevAllowParaTypes = set of TevAllowParaType;
  {* Множество типов разрешённых параграфов }

 TevCustomEditorModelPart = class(TevMultiSelectEditorWindow)
  {* Часть TevCustomEditor перенесённая на модель }
 protected
 // property methods
   function pm_GetAllowParaType: TevAllowParaTypes; virtual;
 protected
 // protected properties
   property AllowParaType: TevAllowParaTypes
     read pm_GetAllowParaType;
 end;//TevCustomEditorModelPart

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomEditorModelPart

function TevCustomEditorModelPart.pm_GetAllowParaType: TevAllowParaTypes;
//#UC START# *4B877E7B0330_4B877C5101C1get_var*
//#UC END# *4B877E7B0330_4B877C5101C1get_var*
begin
//#UC START# *4B877E7B0330_4B877C5101C1get_impl*
 Result := [Low(TevAllowParaType) .. High(TevAllowParaType)];
//#UC END# *4B877E7B0330_4B877C5101C1get_impl*
end;//TevCustomEditorModelPart.pm_GetAllowParaType

initialization
{$If not defined(NoScripts)}
// Регистрация TevCustomEditorModelPart
 TtfwClassRef.Register(TevCustomEditorModelPart);
{$IfEnd} //not NoScripts

end.