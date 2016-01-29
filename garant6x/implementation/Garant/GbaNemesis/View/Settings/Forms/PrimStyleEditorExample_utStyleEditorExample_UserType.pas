unit PrimStyleEditorExample_utStyleEditorExample_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimStyleEditorExample_utStyleEditorExample_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimStyleEditorExample::utStyleEditorExample
//
// Текстовое окно редактора стилей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utStyleEditorExample }
  utStyleEditorExampleName = 'utStyleEditorExample';
   { Строковый идентификатор пользовательского типа "Текстовое окно редактора стилей" }
  utStyleEditorExample = TvcmUserType(0);
   { Текстовое окно редактора стилей }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utStyleEditorExample = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utStyleEditorExample }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utStyleEditorExample
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utStyleEditorExample

class function Tkw_FormUserType_utStyleEditorExample.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utStyleEditorExample';
end;//Tkw_FormUserType_utStyleEditorExample.GetWordNameForRegister

function Tkw_FormUserType_utStyleEditorExample.GetInteger: Integer;
 {-}
begin
 Result := utStyleEditorExample;
end;//Tkw_FormUserType_utStyleEditorExample.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utStyleEditorExample
 Tkw_FormUserType_utStyleEditorExample.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.