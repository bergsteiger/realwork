unit kw_Common_opOpenInformation;
 {* Слово словаря для вызова операции модуля Common.OpenInformation (Окна Справочная информация) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opOpenInformation.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Common_opOpenInformation" MUID: (0C9DFDD210A2)

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
 Tkw_Common_opOpenInformation = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.OpenInformation (Окна Справочная информация) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opOpenInformation

class function Tkw_Common_opOpenInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Окна_Справочная_информация';
end;//Tkw_Common_opOpenInformation.GetWordNameForRegister

class function Tkw_Common_opOpenInformation.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_OpenInformation;
end;//Tkw_Common_opOpenInformation.GetModuleOperationCode

initialization
 Tkw_Common_opOpenInformation.RegisterInEngine;
 {* Регистрация Tkw_Common_opOpenInformation }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
