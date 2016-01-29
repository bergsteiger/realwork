unit kwVcmOpCaption;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmOpCaption.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_op_Caption
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
 TkwVcmOpCaption = {final scriptword} class(TkwOperationParamWordPrim)
 protected
 // realized methods
   procedure DoParams(const aParams: IvcmTestParams;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpCaption
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwVcmOpCaption

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
 {-}
begin
 Result := 'vcm:op:Caption';
end;//TkwVcmOpCaption.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_op_Caption
 TkwVcmOpCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.