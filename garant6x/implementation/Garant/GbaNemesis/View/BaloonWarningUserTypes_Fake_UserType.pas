unit BaloonWarningUserTypes_Fake_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_Fake_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::Fake
//
// Предупреждение
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
   { Константы для типа формы Fake }
  FakeName = 'Fake';
   { Строковый идентификатор пользовательского типа "Предупреждение" }
  Fake = TvcmUserType(0);
   { Предупреждение }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_Fake = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы Fake }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_Fake
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_Fake

class function Tkw_FormUserType_Fake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::Fake';
end;//Tkw_FormUserType_Fake.GetWordNameForRegister

function Tkw_FormUserType_Fake.GetInteger: Integer;
 {-}
begin
 Result := Fake;
end;//Tkw_FormUserType_Fake.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_Fake
 Tkw_FormUserType_Fake.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.