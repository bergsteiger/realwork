unit kwVcmHistoryGetBackCount;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmHistoryGetBackCount.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_History_GetBackCount
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
 TkwVcmHistoryGetBackCount = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryGetBackCount
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

// start class TkwVcmHistoryGetBackCount

procedure TkwVcmHistoryGetBackCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4C90B002D_var*
//#UC END# *4DAEEDE10285_4FC4C90B002D_var*
begin
//#UC START# *4DAEEDE10285_4FC4C90B002D_impl*
 aCtx.rEngine.PushInt(vcmDispatcher.History.GetBackCount);
//#UC END# *4DAEEDE10285_4FC4C90B002D_impl*
end;//TkwVcmHistoryGetBackCount.DoDoIt

class function TkwVcmHistoryGetBackCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:History:GetBackCount';
end;//TkwVcmHistoryGetBackCount.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_History_GetBackCount
 TkwVcmHistoryGetBackCount.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.