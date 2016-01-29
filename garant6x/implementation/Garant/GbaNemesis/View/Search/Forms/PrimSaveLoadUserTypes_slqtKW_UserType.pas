unit PrimSaveLoadUserTypes_slqtKW_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtKW_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtKW
//
// Поиск: По ситуации
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
  ,
  PrimSaveLoadUserTypes_slqtAttribute_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы slqtKW }
  slqtKWName = 'slqtKW';
   { Строковый идентификатор пользовательского типа "Поиск: По ситуации" }
  slqtKW = TvcmUserType(slqtAttribute + 1);
   { Поиск: По ситуации }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtKW = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtKW }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtKW
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtKW

class function Tkw_FormUserType_slqtKW.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtKW';
end;//Tkw_FormUserType_slqtKW.GetWordNameForRegister

function Tkw_FormUserType_slqtKW.GetInteger: Integer;
 {-}
begin
 Result := slqtKW;
end;//Tkw_FormUserType_slqtKW.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtKW
 Tkw_FormUserType_slqtKW.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.