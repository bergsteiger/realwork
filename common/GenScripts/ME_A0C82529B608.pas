unit kw_Search_opPublishSourceSearch;
 {* Слово словаря для вызова операции модуля Search.PublishSourceSearch$Op (Поиск) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opPublishSourceSearch.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Search_opPublishSourceSearch" MUID: (A0C82529B608)

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
 Tkw_Search_opPublishSourceSearch = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Search.PublishSourceSearch$Op (Поиск) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opPublishSourceSearch

class function Tkw_Search_opPublishSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Поиск_PublishSourceSearch';
end;//Tkw_Search_opPublishSourceSearch.GetWordNameForRegister

class function Tkw_Search_opPublishSourceSearch.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_PublishSourceSearch;
end;//Tkw_Search_opPublishSourceSearch.GetModuleOperationCode

initialization
 Tkw_Search_opPublishSourceSearch.RegisterInEngine;
 {* Регистрация Tkw_Search_opPublishSourceSearch }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
