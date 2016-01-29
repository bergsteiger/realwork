unit PrimCreateFilter_cfRename_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters/Forms/PrimCreateFilter_cfRename_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Filters::View::Filters::PrimCreateFilter::cfRename
//
// Переименовать фильтр
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
  PrimCreateFilter_cfCreate_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы cfRename }
  cfRenameName = 'cfRename';
   { Строковый идентификатор пользовательского типа "Переименовать фильтр" }
  cfRename = TvcmUserType(cfCreate + 1);
   { Переименовать фильтр }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cfRename = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы cfRename }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cfRename
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cfRename

class function Tkw_FormUserType_cfRename.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::cfRename';
end;//Tkw_FormUserType_cfRename.GetWordNameForRegister

function Tkw_FormUserType_cfRename.GetInteger: Integer;
 {-}
begin
 Result := cfRename;
end;//Tkw_FormUserType_cfRename.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_cfRename
 Tkw_FormUserType_cfRename.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.