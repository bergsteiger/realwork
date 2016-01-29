unit kwOperationParamWordPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwOperationParamWordPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::OperationParamWordPrim
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
  vcmInterfaces,
  tfwScriptingInterfaces,
  tfwRegisterableWord
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwOperationParamWordPrim = {abstract scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected methods
   procedure DoParams(const aParams: IvcmTestParams;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwOperationParamWordPrim
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwOperationParamWordPrim

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

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация OperationParamWordPrim
 TkwOperationParamWordPrim.RegisterClass;
{$IfEnd} //not NoScripts AND not NoVCM

end.