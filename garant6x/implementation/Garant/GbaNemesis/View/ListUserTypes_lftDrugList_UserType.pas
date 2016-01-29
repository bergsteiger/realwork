unit ListUserTypes_lftDrugList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftDrugList_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftDrugList
//
// Список препаратов
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
  ,
  ListUserTypes_lftUserCRList2_SynchorForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftDrugList }
  lftDrugListName = 'lftDrugList';
   { Строковый идентификатор пользовательского типа "Список препаратов" }
  lftDrugList = TvcmUserType(lftUserCRList2_SynchorForm + 1);
   { Список препаратов }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftDrugList = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftDrugList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftDrugList
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftDrugList

class function Tkw_FormUserType_lftDrugList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftDrugList';
end;//Tkw_FormUserType_lftDrugList.GetWordNameForRegister

function Tkw_FormUserType_lftDrugList.GetInteger: Integer;
 {-}
begin
 Result := lftDrugList;
end;//Tkw_FormUserType_lftDrugList.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftDrugList
 Tkw_FormUserType_lftDrugList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.