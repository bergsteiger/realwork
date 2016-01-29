unit kw_Settings_UserProperties;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/kw_Settings_UserProperties.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::Settings::View::Settings::Tkw_Settings_UserProperties
//
// Слово словаря для вызова операции модуля Settings.UserProperties (Установки Изменить мои
// регистрационные данные...)
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
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}
 Tkw_Settings_UserProperties = class(_tfwModuleOperationWord_)
  {* Слово словаря для вызова операции модуля Settings.UserProperties (Установки Изменить мои регистрационные данные...) }
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts
 public
 // overridden public methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//Tkw_Settings_UserProperties
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwAutoregisteredDiction
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine,
  kwString,
  vcmModulesCollectionItem,
  vcmBaseOperationsCollectionItem,
  l3Except,
  vcmBaseMenuManager
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = Tkw_Settings_UserProperties;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}

// start class Tkw_Settings_UserProperties

{$If not defined(NoScripts)}
class function Tkw_Settings_UserProperties.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Установки_Изменить_мои_регистрационные_данные...';
end;//Tkw_Settings_UserProperties.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function Tkw_Settings_UserProperties.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Settings_UserProperties;
end;//Tkw_Settings_UserProperties.GetModuleOperationCode
{$IfEnd} //not NoScripts

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}
{$IfEnd} //not Admin AND not Monitorings

end.