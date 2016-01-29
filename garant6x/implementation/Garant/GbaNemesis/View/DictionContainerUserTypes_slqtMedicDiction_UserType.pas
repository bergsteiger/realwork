unit DictionContainerUserTypes_slqtMedicDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DictionContainerUserTypes_slqtMedicDiction_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::DictionLike::View::DictionLikeForms::DictionContainerUserTypes::slqtMedicDiction
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
  DictionContainerUserTypes_slqtDiction_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы slqtMedicDiction }
  slqtMedicDictionName = 'slqtMedicDiction';
   { Строковый идентификатор пользовательского типа "Словарь медицинских терминов" }
  slqtMedicDiction = TvcmUserType(slqtDiction + 1);
   { Словарь медицинских терминов }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtMedicDiction = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtMedicDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtMedicDiction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtMedicDiction

class function Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtMedicDiction';
end;//Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister

function Tkw_FormUserType_slqtMedicDiction.GetInteger: Integer;
 {-}
begin
 Result := slqtMedicDiction;
end;//Tkw_FormUserType_slqtMedicDiction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtMedicDiction
 Tkw_FormUserType_slqtMedicDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.