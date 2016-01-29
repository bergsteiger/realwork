unit PrimCreateFilter_cfCreate_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters/Forms/PrimCreateFilter_cfCreate_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Filters::View::Filters::PrimCreateFilter::cfCreate
//
// Создать фильтр
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
   { Константы для типа формы cfCreate }
  cfCreateName = 'cfCreate';
   { Строковый идентификатор пользовательского типа "Создать фильтр" }
  cfCreate = TvcmUserType(0);
   { Создать фильтр }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cfCreate = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы cfCreate }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cfCreate
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cfCreate

class function Tkw_FormUserType_cfCreate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::cfCreate';
end;//Tkw_FormUserType_cfCreate.GetWordNameForRegister

function Tkw_FormUserType_cfCreate.GetInteger: Integer;
 {-}
begin
 Result := cfCreate;
end;//Tkw_FormUserType_cfCreate.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_cfCreate
 Tkw_FormUserType_cfCreate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.