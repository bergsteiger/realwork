unit kw_CommonPost_opSavePostList;
 {* Слово словаря для вызова операции модуля CommonPost.SavePostList$Op (Файл Экспортировать все индивидуальные ленты в файл) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\kw_CommonPost_opSavePostList.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_CommonPost_opSavePostList" MUID: (08BD36053A81)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
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
 Tkw_CommonPost_opSavePostList = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля CommonPost.SavePostList$Op (Файл Экспортировать все индивидуальные ленты в файл) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_CommonPost_opSavePostList

class function Tkw_CommonPost_opSavePostList.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Файл_Экспортировать_все_индивидуальные_ленты_в_файл';
end;//Tkw_CommonPost_opSavePostList.GetWordNameForRegister

class function Tkw_CommonPost_opSavePostList.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_CommonPost_SavePostList;
end;//Tkw_CommonPost_opSavePostList.GetModuleOperationCode

initialization
 Tkw_CommonPost_opSavePostList.RegisterInEngine;
 {* Регистрация Tkw_CommonPost_opSavePostList }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)
end.
