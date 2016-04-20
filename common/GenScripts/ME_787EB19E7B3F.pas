unit kw_Monitorings_opOpenLegislationReview;
 {* Слово словаря для вызова операции модуля Monitorings.OpenLegislationReview (Мониторинги Обзор изменений законодательства) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Monitorings_opOpenLegislationReview.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Monitorings_opOpenLegislationReview" MUID: (787EB19E7B3F)

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
 Tkw_Monitorings_opOpenLegislationReview = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Monitorings.OpenLegislationReview (Мониторинги Обзор изменений законодательства) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Monitorings_opOpenLegislationReview

class function Tkw_Monitorings_opOpenLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Мониторинги_Обзор_изменений_законодательства';
end;//Tkw_Monitorings_opOpenLegislationReview.GetWordNameForRegister

class function Tkw_Monitorings_opOpenLegislationReview.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Monitorings_OpenLegislationReview;
end;//Tkw_Monitorings_opOpenLegislationReview.GetModuleOperationCode

initialization
 Tkw_Monitorings_opOpenLegislationReview.RegisterInEngine;
 {* Регистрация Tkw_Monitorings_opOpenLegislationReview }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
