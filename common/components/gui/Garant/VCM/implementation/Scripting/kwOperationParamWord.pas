unit kwOperationParamWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwOperationParamWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::OperationParamWord
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
  vcmExternalInterfaces,
  kwOperationParamWordPrim,
  vcmInterfaces,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwOperationParamWord = {abstract scriptword} class(TkwOperationParamWordPrim)
 protected
 // realized methods
   procedure DoParams(const aParams: IvcmTestParams;
     const aCtx: TtfwContext); override;
 protected
 // protected methods
   function Flag: TvcmOpFlag; virtual; abstract;
 end;//TkwOperationParamWord
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwOperationParamWord

procedure TkwOperationParamWord.DoParams(const aParams: IvcmTestParams;
  const aCtx: TtfwContext);
//#UC START# *5230185F0140_5230147B0151_var*
//#UC END# *5230185F0140_5230147B0151_var*
begin
//#UC START# *5230185F0140_5230147B0151_impl*
 aCtx.rEngine.PushBool(aParams.Op.Flag[Self.Flag]);
//#UC END# *5230185F0140_5230147B0151_impl*
end;//TkwOperationParamWord.DoParams

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация OperationParamWord
 TkwOperationParamWord.RegisterClass;
{$IfEnd} //not NoScripts AND not NoVCM

end.