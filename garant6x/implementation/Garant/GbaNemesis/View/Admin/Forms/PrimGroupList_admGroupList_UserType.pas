unit PrimGroupList_admGroupList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupList_admGroupList_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Администратор::Admin::View::Admin::PrimGroupList::admGroupList
//
// Группы пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
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
   { Константы для типа формы admGroupList }
  admGroupListName = 'admGroupList';
   { Строковый идентификатор пользовательского типа "Группы пользователей" }
  admGroupList = TvcmUserType(0);
   { Группы пользователей }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admGroupList = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы admGroupList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admGroupList
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admGroupList

class function Tkw_FormUserType_admGroupList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::admGroupList';
end;//Tkw_FormUserType_admGroupList.GetWordNameForRegister

function Tkw_FormUserType_admGroupList.GetInteger: Integer;
 {-}
begin
 Result := admGroupList;
end;//Tkw_FormUserType_admGroupList.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_admGroupList
 Tkw_FormUserType_admGroupList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.