unit kwEntityOperationTest;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationTest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwEntityOperationTest" MUID: (5230072D031A)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwEntityOperationPrim
 , tfwScriptingInterfaces
 , vcmExternalInterfaces
;

type
 TkwEntityOperationTest = class(TkwEntityOperationPrim)
  protected
   procedure DoOp(const aCtx: TtfwContext;
    const anOp: TvcmOPID); override;
 end;//TkwEntityOperationTest
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 , vcmInterfaces
;

procedure TkwEntityOperationTest.DoOp(const aCtx: TtfwContext;
 const anOp: TvcmOPID);
//#UC START# *523008BC0096_5230072D031A_var*
var
 l_Params : IvcmTestParams;
//#UC END# *523008BC0096_5230072D031A_var*
begin
//#UC START# *523008BC0096_5230072D031A_impl*
 l_Params := TvcmTestParams.Make;
 l_Params.Op.Flag[vcm_ofEnabled] := true;
 l_Params.Op.Flag[vcm_ofVisible] := true;
 l_Params.Op.Flag[vcm_ofChecked] := false;
 l_Params.Op.Flag[vcm_ofDefault] := f_Op.IsDefault;
 l_Params.Op.Caption := TtfwCStringFactory.C(f_Op.Caption);
 l_Params.Op.Hint := TtfwCStringFactory.C(f_Op.Hint);
 l_Params.Op.LongHint := TtfwCStringFactory.C(f_Op.LongHint);
 l_Params.Op.ImageIndex := f_Op.ImageIndex;
 l_Params.Op.Shortcut := f_Op.Shortcut;
 vcmDispatcher.EntityOperation(anOp, l_Params);
 aCtx.rEngine.PushIntf(l_Params, TypeInfo(IvcmTestParams));
//#UC END# *523008BC0096_5230072D031A_impl*
end;//TkwEntityOperationTest.DoOp

initialization
 TkwEntityOperationTest.RegisterClass;
 {* Регистрация TkwEntityOperationTest }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
