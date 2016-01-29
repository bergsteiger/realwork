unit PrimGroupProperty_admCreateGroup_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupProperty_admCreateGroup_UserType.pas"
// Начат: 01.10.2009 21:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Администратор::Admin::View::Admin::PrimGroupProperty::admCreateGroup
//
// Новая группа
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
   { Константы для типа формы admCreateGroup }
  admCreateGroupName = 'admCreateGroup';
   { Строковый идентификатор пользовательского типа "Новая группа" }
  admCreateGroup = TvcmUserType(0);
   { Новая группа }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admCreateGroup = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы admCreateGroup }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admCreateGroup
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admCreateGroup

class function Tkw_FormUserType_admCreateGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::admCreateGroup';
end;//Tkw_FormUserType_admCreateGroup.GetWordNameForRegister

function Tkw_FormUserType_admCreateGroup.GetInteger: Integer;
 {-}
begin
 Result := admCreateGroup;
end;//Tkw_FormUserType_admCreateGroup.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_admCreateGroup
 Tkw_FormUserType_admCreateGroup.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.