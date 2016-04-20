unit kw_Tips_opShowDayTips;
 {* Слово словаря для вызова операции модуля Tips.ShowDayTips (Совет дня) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\kw_Tips_opShowDayTips.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Tips_opShowDayTips" MUID: (86D7BA65C042)

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
 Tkw_Tips_opShowDayTips = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Tips.ShowDayTips (Совет дня) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Tips_opShowDayTips

class function Tkw_Tips_opShowDayTips.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Совет_дня_ShowDayTips';
end;//Tkw_Tips_opShowDayTips.GetWordNameForRegister

class function Tkw_Tips_opShowDayTips.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Tips_ShowDayTips;
end;//Tkw_Tips_opShowDayTips.GetModuleOperationCode

initialization
 Tkw_Tips_opShowDayTips.RegisterInEngine;
 {* Регистрация Tkw_Tips_opShowDayTips }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
