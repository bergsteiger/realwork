unit kwVcmOpHint;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpHint.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpHint = {final} class(TkwOperationParamWordPrim)
  protected
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpHint
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TkwVcmOpHint.DoParams(const aParams: IvcmTestParams;
 const aCtx: TtfwContext);
//#UC START# *5230185F0140_5230189600D2_var*
//#UC END# *5230185F0140_5230189600D2_var*
begin
//#UC START# *5230185F0140_5230189600D2_impl*
 aCtx.rEngine.PushString(aParams.Op.Hint);
//#UC END# *5230185F0140_5230189600D2_impl*
end;//TkwVcmOpHint.DoParams

class function TkwVcmOpHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Hint';
end;//TkwVcmOpHint.GetWordNameForRegister

initialization
 TkwVcmOpHint.RegisterInEngine;
 {* Регистрация vcm_op_Hint }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
