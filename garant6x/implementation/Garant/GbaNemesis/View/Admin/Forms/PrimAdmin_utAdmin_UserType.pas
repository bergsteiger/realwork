unit PrimAdmin_utAdmin_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimAdmin_utAdmin_UserType.pas"
// Начат: 11.11.2009 21:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Администратор::Admin::View::Admin::PrimAdmin::utAdmin
//
// Администрирование пользователей
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
   { Константы для типа формы utAdmin }
  utAdminName = 'utAdmin';
   { Строковый идентификатор пользовательского типа "Администрирование пользователей" }
  utAdmin = TvcmUserType(0);
   { Администрирование пользователей }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utAdmin = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utAdmin }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utAdmin
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utAdmin

class function Tkw_FormUserType_utAdmin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utAdmin';
end;//Tkw_FormUserType_utAdmin.GetWordNameForRegister

function Tkw_FormUserType_utAdmin.GetInteger: Integer;
 {-}
begin
 Result := utAdmin;
end;//Tkw_FormUserType_utAdmin.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utAdmin
 Tkw_FormUserType_utAdmin.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.