unit PrimCommonDiction_utTips_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimCommonDiction_utTips_UserType.pas"
// Начат: 27.01.2009 12:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::Diction::View::Diction::PrimCommonDiction::utTips
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utTips }
  utTipsName = 'utTips';
   { Строковый идентификатор пользовательского типа "Совет дня" }
  utTips = TvcmUserType(0);
   { Совет дня }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utTips = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utTips }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utTips
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utTips

class function Tkw_FormUserType_utTips.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utTips';
end;//Tkw_FormUserType_utTips.GetWordNameForRegister

function Tkw_FormUserType_utTips.GetInteger: Integer;
 {-}
begin
 Result := utTips;
end;//Tkw_FormUserType_utTips.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utTips
 Tkw_FormUserType_utTips.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.