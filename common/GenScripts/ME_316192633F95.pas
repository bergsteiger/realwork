unit kw_Search_opBaseSearch;
 {* Слово словаря для вызова операции модуля Search.BaseSearch$Op (Поиск) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opBaseSearch.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Search_opBaseSearch" MUID: (316192633F95)

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
 Tkw_Search_opBaseSearch = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Search.BaseSearch$Op (Поиск) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opBaseSearch

class function Tkw_Search_opBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Поиск_BaseSearch';
end;//Tkw_Search_opBaseSearch.GetWordNameForRegister

class function Tkw_Search_opBaseSearch.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_BaseSearch;
end;//Tkw_Search_opBaseSearch.GetModuleOperationCode

initialization
 Tkw_Search_opBaseSearch.RegisterInEngine;
 {* Регистрация Tkw_Search_opBaseSearch }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
