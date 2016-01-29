unit kw_Settings_opOpenStyleEditorAsModal;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/kw_Settings_opOpenStyleEditorAsModal.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Основные прецеденты::Settings::View::Settings::Tkw_Settings_opOpenStyleEditorAsModal
//
// Слово словаря для вызова операции модуля Settings.OpenStyleEditorAsModal$Op (Установки Редактор
// стилей...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  tfwModuleOperationWord
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
 Tkw_Settings_opOpenStyleEditorAsModal = {final scriptword} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Settings.OpenStyleEditorAsModal$Op (Установки Редактор стилей...) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Settings_opOpenStyleEditorAsModal
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Settings_opOpenStyleEditorAsModal

class function Tkw_Settings_opOpenStyleEditorAsModal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'моп::Установки_Редактор_стилей...';
end;//Tkw_Settings_opOpenStyleEditorAsModal.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Settings_opOpenStyleEditorAsModal.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Settings_OpenStyleEditorAsModal;
end;//Tkw_Settings_opOpenStyleEditorAsModal.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Settings_opOpenStyleEditorAsModal
 Tkw_Settings_opOpenStyleEditorAsModal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.