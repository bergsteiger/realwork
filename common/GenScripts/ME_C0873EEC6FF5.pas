unit kw_Common_LetterToDevelopers;
 {* Слово словаря для вызова операции модуля Common.LetterToDevelopers (Окна Письмо разработчикам) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_LetterToDevelopers.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Tkw_Common_LetterToDevelopers" MUID: (C0873EEC6FF5)

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
 Tkw_Common_LetterToDevelopers = {final} class(TtfwModuleOperationWord)
  {* Слово словаря для вызова операции модуля Common.LetterToDevelopers (Окна Письмо разработчикам) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_LetterToDevelopers

class function Tkw_Common_LetterToDevelopers.GetWordNameForRegister: AnsiString;
begin
 Result := 'моп::Окна_Письмо_разработчикам';
end;//Tkw_Common_LetterToDevelopers.GetWordNameForRegister

class function Tkw_Common_LetterToDevelopers.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_LetterToDevelopers;
end;//Tkw_Common_LetterToDevelopers.GetModuleOperationCode

initialization
 Tkw_Common_LetterToDevelopers.RegisterInEngine;
 {* Регистрация Tkw_Common_LetterToDevelopers }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
