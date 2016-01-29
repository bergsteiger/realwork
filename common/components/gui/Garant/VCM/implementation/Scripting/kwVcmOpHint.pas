unit kwVcmOpHint;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpHint.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Hint
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
  kwOperationParamWordPrim,
  vcmInterfaces,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwVcmOpHint = {final scriptword} class(TkwOperationParamWordPrim)
 protected
 // realized methods
   procedure DoParams(const aParams: IvcmTestParams;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpHint
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpHint

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
 {-}
begin
 Result := 'vcm:op:Hint';
end;//TkwVcmOpHint.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_op_Hint
 TkwVcmOpHint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.