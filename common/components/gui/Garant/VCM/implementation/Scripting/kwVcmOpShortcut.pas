unit kwVcmOpShortcut;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpShortcut.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Shortcut
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
 TkwVcmOpShortcut = {final scriptword} class(TkwOperationParamWordPrim)
 protected
 // realized methods
   procedure DoParams(const aParams: IvcmTestParams;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpShortcut
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpShortcut

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
 {-}
begin
 Result := 'vcm:op:Shortcut';
end;//TkwVcmOpShortcut.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_op_Shortcut
 TkwVcmOpShortcut.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.