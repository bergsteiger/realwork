unit DictionContainerUserTypes_slqtDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DictionContainerUserTypes_slqtDiction_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::DictionLike::View::DictionLikeForms::DictionContainerUserTypes::slqtDiction
//
// Толковый словарь
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
   { Константы для типа формы slqtDiction }
  slqtDictionName = 'slqtDiction';
   { Строковый идентификатор пользовательского типа "Толковый словарь" }
  slqtDiction = TvcmUserType(0);
   { Толковый словарь }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtDiction = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtDiction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtDiction

class function Tkw_FormUserType_slqtDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtDiction';
end;//Tkw_FormUserType_slqtDiction.GetWordNameForRegister

function Tkw_FormUserType_slqtDiction.GetInteger: Integer;
 {-}
begin
 Result := slqtDiction;
end;//Tkw_FormUserType_slqtDiction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtDiction
 Tkw_FormUserType_slqtDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.