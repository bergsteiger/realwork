unit kwVcmFindForm;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmFindForm.pas"
// Стереотип: "ScriptKeyword"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include VCMWord.imp.pas}
 TkwVcmFindForm = class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmFindForm
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmInterfaces
 , vcmForm
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , StdRes
 , vcmBase
 , afwAnswer
;

{$Include VCMWord.imp.pas}

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
begin
 Result := 'vcm:FindForm';
end;//TkwVcmFindForm.GetWordNameForRegister

initialization
 TkwVcmFindForm.RegisterInEngine;
 {* Регистрация vcm_FindForm }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
