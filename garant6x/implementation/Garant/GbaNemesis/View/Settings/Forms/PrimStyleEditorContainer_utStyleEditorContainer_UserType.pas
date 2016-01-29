unit PrimStyleEditorContainer_utStyleEditorContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimStyleEditorContainer_utStyleEditorContainer_UserType.pas"
// Начат: 02.10.2009 22:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimStyleEditorContainer::utStyleEditorContainer
//
// Редактор стилей
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
   { Константы для типа формы utStyleEditorContainer }
  utStyleEditorContainerName = 'utStyleEditorContainer';
   { Строковый идентификатор пользовательского типа "Редактор стилей" }
  utStyleEditorContainer = TvcmUserType(0);
   { Редактор стилей }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utStyleEditorContainer = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utStyleEditorContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utStyleEditorContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utStyleEditorContainer

class function Tkw_FormUserType_utStyleEditorContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utStyleEditorContainer';
end;//Tkw_FormUserType_utStyleEditorContainer.GetWordNameForRegister

function Tkw_FormUserType_utStyleEditorContainer.GetInteger: Integer;
 {-}
begin
 Result := utStyleEditorContainer;
end;//Tkw_FormUserType_utStyleEditorContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utStyleEditorContainer
 Tkw_FormUserType_utStyleEditorContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.