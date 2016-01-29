unit DocumentUserTypes_dftTips_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftTips_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftTips
//
// Совет дня
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
  DocumentUserTypes_dftAnnotationSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftTips }
  dftTipsName = 'dftTips';
   { Строковый идентификатор пользовательского типа "Совет дня" }
  dftTips = TvcmUserType(dftAnnotationSynchroView + 1);
   { Совет дня }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftTips = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftTips }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftTips
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftTips

class function Tkw_FormUserType_dftTips.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftTips';
end;//Tkw_FormUserType_dftTips.GetWordNameForRegister

function Tkw_FormUserType_dftTips.GetInteger: Integer;
 {-}
begin
 Result := dftTips;
end;//Tkw_FormUserType_dftTips.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftTips
 Tkw_FormUserType_dftTips.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.