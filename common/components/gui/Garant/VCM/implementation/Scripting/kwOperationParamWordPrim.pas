unit kwOperationParamWordPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWordPrim.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "OperationParamWordPrim" MUID: (5230182A02A3)
// Имя типа: "TkwOperationParamWordPrim"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwOperationParamWordPrim = {abstract} class(TtfwRegisterableWord)
  protected
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOperationParamWordPrim
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 //#UC START# *5230182A02A3impl_uses*
 //#UC END# *5230182A02A3impl_uses*
;

procedure TkwOperationParamWordPrim.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5230182A02A3_var*
var
 l_Params : IvcmTestParams;
//#UC END# *4DAEEDE10285_5230182A02A3_var*
begin
//#UC START# *4DAEEDE10285_5230182A02A3_impl*
 l_Params := IvcmTestParams(aCtx.rEngine.PopIntf(IvcmTestParams));
 DoParams(l_Params, aCtx);
//#UC END# *4DAEEDE10285_5230182A02A3_impl*
end;//TkwOperationParamWordPrim.DoDoIt

initialization
 TkwOperationParamWordPrim.RegisterClass;
 {* Регистрация OperationParamWordPrim }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
