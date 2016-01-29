unit PrimCommonDiction_utMedicDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimCommonDiction_utMedicDiction_UserType.pas"
// Начат: 27.01.2009 12:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::Diction::View::Diction::PrimCommonDiction::utMedicDiction
//
// Словарь медицинских терминов
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
  PrimCommonDiction_utTips_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utMedicDiction }
  utMedicDictionName = 'utMedicDiction';
   { Строковый идентификатор пользовательского типа "Словарь медицинских терминов" }
  utMedicDiction = TvcmUserType(utTips + 1);
   { Словарь медицинских терминов }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utMedicDiction = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utMedicDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utMedicDiction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utMedicDiction

class function Tkw_FormUserType_utMedicDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utMedicDiction';
end;//Tkw_FormUserType_utMedicDiction.GetWordNameForRegister

function Tkw_FormUserType_utMedicDiction.GetInteger: Integer;
 {-}
begin
 Result := utMedicDiction;
end;//Tkw_FormUserType_utMedicDiction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utMedicDiction
 Tkw_FormUserType_utMedicDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.