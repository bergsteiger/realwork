unit PrimChangesBetweenEditons_DocumentChanges_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/Forms/PrimChangesBetweenEditons_DocumentChanges_UserType.pas"
// Начат: 25.05.2011 14:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::View::ChangesBetweenEditons::PrimChangesBetweenEditons::DocumentChanges
//
// Изменения в документе
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
   { Константы для типа формы DocumentChanges }
  DocumentChangesName = 'DocumentChanges';
   { Строковый идентификатор пользовательского типа "Изменения в документе" }
  DocumentChanges = TvcmUserType(0);
   { Изменения в документе }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_DocumentChanges = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы DocumentChanges }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_DocumentChanges
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_DocumentChanges

class function Tkw_FormUserType_DocumentChanges.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::DocumentChanges';
end;//Tkw_FormUserType_DocumentChanges.GetWordNameForRegister

function Tkw_FormUserType_DocumentChanges.GetInteger: Integer;
 {-}
begin
 Result := DocumentChanges;
end;//Tkw_FormUserType_DocumentChanges.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_DocumentChanges
 Tkw_FormUserType_DocumentChanges.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.