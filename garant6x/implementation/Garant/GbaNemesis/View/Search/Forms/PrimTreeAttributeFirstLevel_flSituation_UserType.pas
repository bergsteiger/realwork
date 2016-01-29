unit PrimTreeAttributeFirstLevel_flSituation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimTreeAttributeFirstLevel_flSituation_UserType.pas"
// Начат: 27.01.2009 11:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimTreeAttributeFirstLevel::flSituation
//
// Ситуации первого уровня (вкладка)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
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
   { Константы для типа формы flSituation }
  flSituationName = 'flSituation';
   { Строковый идентификатор пользовательского типа "Ситуации первого уровня (вкладка)" }
  flSituation = TvcmUserType(0);
   { Ситуации первого уровня (вкладка) }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_flSituation = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы flSituation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_flSituation
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_flSituation

class function Tkw_FormUserType_flSituation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::flSituation';
end;//Tkw_FormUserType_flSituation.GetWordNameForRegister

function Tkw_FormUserType_flSituation.GetInteger: Integer;
 {-}
begin
 Result := flSituation;
end;//Tkw_FormUserType_flSituation.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_flSituation
 Tkw_FormUserType_flSituation.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.