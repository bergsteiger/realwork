unit kwVcmHistoryDeleteBackItem;
 {* Удаляет один элемент истории из списка Back.
 *Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttribute
 Ok
 OnTest
 vcm:history:DeleteBackItem
[code] }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteBackItem.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_History_DeleteBackItem" MUID: (4E82CEBA0299)
// Имя типа: "TkwVcmHistoryDeleteBackItem"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}
 TkwVcmHistoryDeleteBackItem = class(_VCMWord_)
  {* Удаляет один элемент истории из списка Back.
 *Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttribute
 Ok
 OnTest
 vcm:history:DeleteBackItem
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmHistoryDeleteBackItem
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmForm
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , StdRes
 , vcmBase
 , afwAnswer
 //#UC START# *4E82CEBA0299impl_uses*
 //#UC END# *4E82CEBA0299impl_uses*
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

class function TkwVcmHistoryDeleteBackItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:DeleteBackItem';
end;//TkwVcmHistoryDeleteBackItem.GetWordNameForRegister

procedure TkwVcmHistoryDeleteBackItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E82CEBA0299_var*
//#UC END# *4DAEEDE10285_4E82CEBA0299_var*
begin
//#UC START# *4DAEEDE10285_4E82CEBA0299_impl*
 if (vcmDispatcher.History <> nil) then
  vcmDispatcher.History.DeleteBackItem;
//#UC END# *4DAEEDE10285_4E82CEBA0299_impl*
end;//TkwVcmHistoryDeleteBackItem.DoDoIt

initialization
 TkwVcmHistoryDeleteBackItem.RegisterInEngine;
 {* Регистрация vcm_History_DeleteBackItem }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
