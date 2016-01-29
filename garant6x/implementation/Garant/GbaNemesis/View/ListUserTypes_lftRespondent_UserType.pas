unit ListUserTypes_lftRespondent_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftRespondent_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftRespondent
//
// Ссылки из документа
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
  ListUserTypes_lftNone_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftRespondent }
  lftRespondentName = 'lftRespondent';
   { Строковый идентификатор пользовательского типа "Ссылки из документа" }
  lftRespondent = TvcmUserType(lftNone + 1);
   { Ссылки из документа }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftRespondent = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftRespondent }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftRespondent
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftRespondent

class function Tkw_FormUserType_lftRespondent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftRespondent';
end;//Tkw_FormUserType_lftRespondent.GetWordNameForRegister

function Tkw_FormUserType_lftRespondent.GetInteger: Integer;
 {-}
begin
 Result := lftRespondent;
end;//Tkw_FormUserType_lftRespondent.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftRespondent
 Tkw_FormUserType_lftRespondent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.