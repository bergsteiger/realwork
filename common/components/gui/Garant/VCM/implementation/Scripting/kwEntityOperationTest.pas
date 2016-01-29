unit kwEntityOperationTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwEntityOperationTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Scripting::Operations::TkwEntityOperationTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  kwEntityOperationPrim,
  vcmExternalInterfaces,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwEntityOperationTest = class(TkwEntityOperationPrim)
 protected
 // realized methods
   procedure DoOp(const aCtx: TtfwContext;
     const anOp: TvcmOPID); override;
 end;//TkwEntityOperationTest
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmBase,
  vcmInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwEntityOperationTest

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

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TkwEntityOperationTest
 TkwEntityOperationTest.RegisterClass;
{$IfEnd} //not NoScripts AND not NoVCM

end.