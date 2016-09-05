unit kwVcmHistoryDeleteForwardItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteForwardItem.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_History_DeleteForwardItem" MUID: (53DA56FB028B)
// Имя типа: "TkwVcmHistoryDeleteForwardItem"

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
 TkwVcmHistoryDeleteForwardItem = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmHistoryDeleteForwardItem
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
 //#UC START# *53DA56FB028Bimpl_uses*
 //#UC END# *53DA56FB028Bimpl_uses*
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

class function TkwVcmHistoryDeleteForwardItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:DeleteForwardItem';
end;//TkwVcmHistoryDeleteForwardItem.GetWordNameForRegister

procedure TkwVcmHistoryDeleteForwardItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53DA56FB028B_var*
//#UC END# *4DAEEDE10285_53DA56FB028B_var*
begin
//#UC START# *4DAEEDE10285_53DA56FB028B_impl*
 if (vcmDispatcher.History <> nil) then
  vcmDispatcher.History.DeleteForwardItem;
//#UC END# *4DAEEDE10285_53DA56FB028B_impl*
end;//TkwVcmHistoryDeleteForwardItem.DoDoIt

initialization
 TkwVcmHistoryDeleteForwardItem.RegisterInEngine;
 {* Регистрация vcm_History_DeleteForwardItem }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
