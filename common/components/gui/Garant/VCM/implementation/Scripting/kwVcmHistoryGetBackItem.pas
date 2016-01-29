unit kwVcmHistoryGetBackItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmHistoryGetBackItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_History_GetBackItem
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
 TkwVcmHistoryGetBackItem = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryGetBackItem
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

// start class TkwVcmHistoryGetBackItem

procedure TkwVcmHistoryGetBackItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4C928013F_var*
//#UC END# *4DAEEDE10285_4FC4C928013F_var*
begin
//#UC START# *4DAEEDE10285_4FC4C928013F_impl*
 aCtx.rEngine.PushString(vcmDispatcher.History.GetBackItem(aCtx.rEngine.PopInt));
//#UC END# *4DAEEDE10285_4FC4C928013F_impl*
end;//TkwVcmHistoryGetBackItem.DoDoIt

class function TkwVcmHistoryGetBackItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:History:GetBackItem';
end;//TkwVcmHistoryGetBackItem.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_History_GetBackItem
 TkwVcmHistoryGetBackItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.