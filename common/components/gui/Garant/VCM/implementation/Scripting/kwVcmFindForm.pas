unit kwVcmFindForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmFindForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_FindForm
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
 TkwVcmFindForm = {scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmFindForm
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmInterfaces,
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

// start class TkwVcmFindForm

procedure TkwVcmFindForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F215ADB00AF_var*
var
 l_Res : Boolean;
 //l_N  : AnsiString;
 l_F  : AnsiString;
 l_ID : TvcmFormID;
 l_EF : IvcmEntityForm;
 l_UT : Integer;
//#UC END# *4DAEEDE10285_4F215ADB00AF_var*
begin
//#UC START# *4DAEEDE10285_4F215ADB00AF_impl*
 l_Res := false;
 try
  l_F := aCtx.rEngine.PopDelphiString;
  //l_N := aCtx.rEngine.PopDelphiString;
  l_UT := aCtx.rEngine.PopInt;
  l_ID.rName := l_F;
  l_ID.rID := 0;
  l_Res := vcmDispatcher.FormDispatcher.
   CurrentMainForm.AsContainer.HasForm(l_ID, vcm_ztAny, true,  @l_EF, l_UT);
 finally
  aCtx.rEngine.PushBool(l_Res);
 end;//try..finally
 if l_Res then
 begin
  aCtx.rEngine.PushObj(l_EF.VCLWinControl);
  aCtx.rEngine.Swap;
 end;//l_Res
//#UC END# *4DAEEDE10285_4F215ADB00AF_impl*
end;//TkwVcmFindForm.DoDoIt

class function TkwVcmFindForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:FindForm';
end;//TkwVcmFindForm.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_FindForm
 TkwVcmFindForm.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.