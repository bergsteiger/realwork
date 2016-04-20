unit kw_Settings_opOpenConfList;
 {* Слово словаря для вызова операции модуля Settings.OpenConfList$Op (Установки Список конфигураций) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opOpenConfList.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Settings_opOpenConfList" MUID: (7BCDAEAE5749)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWord
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type
 Tkw_Settings_opOpenConfList = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Settings.OpenConfList$Op (Установки Список конфигураций) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opOpenConfList

class function Tkw_Settings_opOpenConfList.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Установки_Список_конфигураций';
end;//Tkw_Settings_opOpenConfList.GetWordNameForRegister

class function Tkw_Settings_opOpenConfList.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_OpenConfList;
end;//Tkw_Settings_opOpenConfList.GetModuleOperationCode

initialization
 Tkw_Settings_opOpenConfList.RegisterInEngine;
 {* Регистрация Tkw_Settings_opOpenConfList }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
