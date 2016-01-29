unit kwVcmDispatcherEndOp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmDispatcherEndOp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_Dispatcher_EndOp
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
 TkwVcmDispatcherEndOp = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherEndOp
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

// start class TkwVcmDispatcherEndOp

procedure TkwVcmDispatcherEndOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F69BC2601EB_var*
//#UC END# *4DAEEDE10285_4F69BC2601EB_var*
begin
//#UC START# *4DAEEDE10285_4F69BC2601EB_impl*
 vcmDispatcher.EndOp;
//#UC END# *4DAEEDE10285_4F69BC2601EB_impl*
end;//TkwVcmDispatcherEndOp.DoDoIt

class function TkwVcmDispatcherEndOp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Dispatcher:EndOp';
end;//TkwVcmDispatcherEndOp.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_Dispatcher_EndOp
 TkwVcmDispatcherEndOp.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.