unit kwVcmOpShortcut;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpShortcut.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_op_Shortcut" MUID: (523018BE02F9)
// Имя типа: "TkwVcmOpShortcut"

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
 TkwVcmOpShortcut = {final} class(TkwOperationParamWordPrim)
  protected
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpShortcut
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TkwVcmOpShortcut.DoParams(const aParams: IvcmTestParams;
 const aCtx: TtfwContext);
//#UC START# *5230185F0140_523018BE02F9_var*
//#UC END# *5230185F0140_523018BE02F9_var*
begin
//#UC START# *5230185F0140_523018BE02F9_impl*
 aCtx.rEngine.PushInt(aParams.Op.Shortcut);
//#UC END# *5230185F0140_523018BE02F9_impl*
end;//TkwVcmOpShortcut.DoParams

class function TkwVcmOpShortcut.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:Shortcut';
end;//TkwVcmOpShortcut.GetWordNameForRegister

initialization
 TkwVcmOpShortcut.RegisterInEngine;
 {* Регистрация vcm_op_Shortcut }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
