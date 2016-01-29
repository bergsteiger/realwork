unit CustomizeTools_ut_CustomizeTools_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/Forms/CustomizeTools_ut_CustomizeTools_UserType.pas"
// Начат: 13.09.2010 19:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::PrimToolbarMenu::CustomizeTools::ut_CustomizeTools
//
// CustomizeTools
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { Константы для типа формы ut_CustomizeTools }
   ut_CustomizeToolsName = 'ut_CustomizeTools';
    { Строковый идентификатор пользовательского типа "CustomizeTools" }
   ut_CustomizeTools = TvcmUserType(0);
    { CustomizeTools }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$If not defined(NoScripts) AND not defined(NoVCM)}
type
   Tkw_FormUserType_ut_CustomizeTools = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_CustomizeTools }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_CustomizeTools
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_CustomizeTools

class function Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_CustomizeTools';
end;//Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTools.GetInteger: Integer;
 {-}
begin
 Result := ut_CustomizeTools;
end;//Tkw_FormUserType_ut_CustomizeTools.GetInteger

{$IfEnd} //not NoScripts AND not NoVCM
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FormUserType_ut_CustomizeTools
 Tkw_FormUserType_ut_CustomizeTools.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.