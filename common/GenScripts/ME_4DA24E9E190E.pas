unit kw_Search_opOpenConsult;
 {* Слово словаря для вызова операции модуля Search.OpenConsult (Поиск) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opOpenConsult.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Search_opOpenConsult" MUID: (4DA24E9E190E)

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
 Tkw_Search_opOpenConsult = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Search.OpenConsult (Поиск) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opOpenConsult

class function Tkw_Search_opOpenConsult.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Поиск_OpenConsult';
end;//Tkw_Search_opOpenConsult.GetWordNameForRegister

class function Tkw_Search_opOpenConsult.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_OpenConsult;
end;//Tkw_Search_opOpenConsult.GetModuleOperationCode

initialization
 Tkw_Search_opOpenConsult.RegisterInEngine;
 {* Регистрация Tkw_Search_opOpenConsult }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
