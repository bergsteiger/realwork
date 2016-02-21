unit kwVcmOpLongHint;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpLongHint.pas"
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
 TkwVcmOpLongHint = {final} class(TkwOperationParamWordPrim)
  protected
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpLongHint
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TkwVcmOpLongHint.DoParams(const aParams: IvcmTestParams;
 const aCtx: TtfwContext);
//#UC START# *5230185F0140_52301B0C0177_var*
//#UC END# *5230185F0140_52301B0C0177_var*
begin
//#UC START# *5230185F0140_52301B0C0177_impl*
 aCtx.rEngine.PushString(aParams.Op.LongHint);
//#UC END# *5230185F0140_52301B0C0177_impl*
end;//TkwVcmOpLongHint.DoParams

class function TkwVcmOpLongHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:LongHint';
end;//TkwVcmOpLongHint.GetWordNameForRegister

initialization
 TkwVcmOpLongHint.RegisterInEngine;
 {* Регистрация vcm_op_LongHint }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
