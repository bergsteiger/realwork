unit kwOperationParamWord;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWord.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmExternalInterfaces
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwOperationParamWord = {abstract} class(TkwOperationParamWordPrim)
  protected
   function Flag: TvcmOpFlag; virtual; abstract;
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); override;
 end;//TkwOperationParamWord
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TkwOperationParamWord.DoParams(const aParams: IvcmTestParams;
 const aCtx: TtfwContext);
//#UC START# *5230185F0140_5230147B0151_var*
//#UC END# *5230185F0140_5230147B0151_var*
begin
//#UC START# *5230185F0140_5230147B0151_impl*
 aCtx.rEngine.PushBool(aParams.Op.Flag[Self.Flag]);
//#UC END# *5230185F0140_5230147B0151_impl*
end;//TkwOperationParamWord.DoParams

initialization
 TkwOperationParamWord.RegisterClass;
 {* Регистрация OperationParamWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
