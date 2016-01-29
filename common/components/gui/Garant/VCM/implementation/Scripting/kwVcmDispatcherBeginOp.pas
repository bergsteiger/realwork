unit kwVcmDispatcherBeginOp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmDispatcherBeginOp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_Dispatcher_BeginOp
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include ..\Scripting\VCMWord.imp.pas}
 TkwVcmDispatcherBeginOp = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherBeginOp
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmForm
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  StdRes,
  vcmBase,
  afwAnswer
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

{$Include ..\Scripting\VCMWord.imp.pas}

// start class TkwVcmDispatcherBeginOp

procedure TkwVcmDispatcherBeginOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F69BC1C02CC_var*
//#UC END# *4DAEEDE10285_4F69BC1C02CC_var*
begin
//#UC START# *4DAEEDE10285_4F69BC1C02CC_impl*
 vcmDispatcher.BeginOp;
//#UC END# *4DAEEDE10285_4F69BC1C02CC_impl*
end;//TkwVcmDispatcherBeginOp.DoDoIt

class function TkwVcmDispatcherBeginOp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Dispatcher:BeginOp';
end;//TkwVcmDispatcherBeginOp.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_Dispatcher_BeginOp
 TkwVcmDispatcherBeginOp.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.