unit kwVcmHistoryGetForwardCount;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmHistoryGetForwardCount.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_History_GetForwardCount
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
 TkwVcmHistoryGetForwardCount = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryGetForwardCount
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

// start class TkwVcmHistoryGetForwardCount

procedure TkwVcmHistoryGetForwardCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4CEF40288_var*
//#UC END# *4DAEEDE10285_4FC4CEF40288_var*
begin
//#UC START# *4DAEEDE10285_4FC4CEF40288_impl*
 aCtx.rEngine.PushInt(vcmDispatcher.History.GetForwardCount);
//#UC END# *4DAEEDE10285_4FC4CEF40288_impl*
end;//TkwVcmHistoryGetForwardCount.DoDoIt

class function TkwVcmHistoryGetForwardCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:History:GetForwardCount';
end;//TkwVcmHistoryGetForwardCount.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_History_GetForwardCount
 TkwVcmHistoryGetForwardCount.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.