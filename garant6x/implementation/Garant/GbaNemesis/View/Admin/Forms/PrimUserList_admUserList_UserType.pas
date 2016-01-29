unit PrimUserList_admUserList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimUserList_admUserList_UserType.pas"
// Начат: 15.08.2005 19.00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Администратор::Admin::View::Admin::PrimUserList::admUserList
//
// Список пользователей
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
   { Константы для типа формы admUserList }
  admUserListName = 'admUserList';
   { Строковый идентификатор пользовательского типа "Список пользователей" }
  admUserList = TvcmUserType(0);
   { Список пользователей }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admUserList = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы admUserList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admUserList
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admUserList

class function Tkw_FormUserType_admUserList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::admUserList';
end;//Tkw_FormUserType_admUserList.GetWordNameForRegister

function Tkw_FormUserType_admUserList.GetInteger: Integer;
 {-}
begin
 Result := admUserList;
end;//Tkw_FormUserType_admUserList.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_admUserList
 Tkw_FormUserType_admUserList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.