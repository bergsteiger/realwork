unit kwVcmOpCaption;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpCaption.pas"
// Стереотип: "ScriptKeyword"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpCaption = {final} class(TkwOperationParamWordPrim)
  protected
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpCaption
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TkwVcmOpCaption.DoParams(const aParams: IvcmTestParams;
 const aCtx: TtfwContext);
//#UC START# *5230185F0140_5230180F029A_var*
//#UC END# *5230185F0140_5230180F029A_var*
begin
//#UC START# *5230185F0140_5230180F029A_impl*
 aCtx.rEngine.PushString(aParams.Op.Caption);
//#UC END# *5230185F0140_5230180F029A_impl*
end;//TkwVcmOpCaption.DoParams

class function TkwVcmOpCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Caption';
end;//TkwVcmOpCaption.GetWordNameForRegister

initialization
 TkwVcmOpCaption.RegisterInEngine;
 {* Регистрация vcm_op_Caption }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
