unit ListUserTypes_lftCToPart_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftCToPart_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftCToPart
//
// Ссылки на фрагмент
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
  ListUserTypes_lftRespondent_UserType,
  ListUserTypes_lftSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftCToPart }
  lftCToPartName = 'lftCToPart';
   { Строковый идентификатор пользовательского типа "Ссылки на фрагмент" }
  lftCToPart = TvcmUserType(lftSynchroView + 1);
   { Ссылки на фрагмент }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftCToPart = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftCToPart }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftCToPart
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftCToPart

class function Tkw_FormUserType_lftCToPart.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftCToPart';
end;//Tkw_FormUserType_lftCToPart.GetWordNameForRegister

function Tkw_FormUserType_lftCToPart.GetInteger: Integer;
 {-}
begin
 Result := lftCToPart;
end;//Tkw_FormUserType_lftCToPart.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftCToPart
 Tkw_FormUserType_lftCToPart.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.