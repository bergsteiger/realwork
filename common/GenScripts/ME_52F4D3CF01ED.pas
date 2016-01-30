unit kwVcmHistoryClear;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryClear.pas"
// Стереотип: "ScriptKeyword"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include VCMWord.imp.pas}
 TkwVcmHistoryClear = {final} class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryClear
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
;

{$Include VCMWord.imp.pas}

procedure TkwVcmHistoryClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52F4D3CF01ED_var*
//#UC END# *4DAEEDE10285_52F4D3CF01ED_var*
begin
//#UC START# *4DAEEDE10285_52F4D3CF01ED_impl*
 if (vcmDispatcher.History <> nil) then
  vcmDispatcher.History.Clear(false);
//#UC END# *4DAEEDE10285_52F4D3CF01ED_impl*
end;//TkwVcmHistoryClear.DoDoIt

class function TkwVcmHistoryClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:Clear';
end;//TkwVcmHistoryClear.GetWordNameForRegister

initialization
 TkwVcmHistoryClear.RegisterInEngine;
 {* Регистрация vcm_History_Clear }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
