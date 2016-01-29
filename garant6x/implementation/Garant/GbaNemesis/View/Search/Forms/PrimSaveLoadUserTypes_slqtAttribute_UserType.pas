unit PrimSaveLoadUserTypes_slqtAttribute_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtAttribute_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtAttribute
//
// Поиск: По реквизитам
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
   { Константы для типа формы slqtAttribute }
  slqtAttributeName = 'slqtAttribute';
   { Строковый идентификатор пользовательского типа "Поиск: По реквизитам" }
  slqtAttribute = TvcmUserType(0);
   { Поиск: По реквизитам }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtAttribute = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtAttribute }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtAttribute
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtAttribute

class function Tkw_FormUserType_slqtAttribute.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtAttribute';
end;//Tkw_FormUserType_slqtAttribute.GetWordNameForRegister

function Tkw_FormUserType_slqtAttribute.GetInteger: Integer;
 {-}
begin
 Result := slqtAttribute;
end;//Tkw_FormUserType_slqtAttribute.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtAttribute
 Tkw_FormUserType_slqtAttribute.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.