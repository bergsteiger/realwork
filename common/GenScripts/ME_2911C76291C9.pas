unit kw_Inpharm_opDrugList;
 {* Слово словаря для вызова операции модуля Inpharm.DrugList$Op (Инфарм Список выпускаемых препаратов) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\kw_Inpharm_opDrugList.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Inpharm_opDrugList" MUID: (2911C76291C9)

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
 Tkw_Inpharm_opDrugList = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Inpharm.DrugList$Op (Инфарм Список выпускаемых препаратов) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Inpharm_opDrugList

class function Tkw_Inpharm_opDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Инфарм_Список_выпускаемых_препаратов';
end;//Tkw_Inpharm_opDrugList.GetWordNameForRegister

class function Tkw_Inpharm_opDrugList.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Inpharm_DrugList;
end;//Tkw_Inpharm_opDrugList.GetModuleOperationCode

initialization
 Tkw_Inpharm_opDrugList.RegisterInEngine;
 {* Регистрация Tkw_Inpharm_opDrugList }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
