unit kwWaitCancel;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitCancel.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "wait_Cancel" MUID: (4FFFE217028B)
// Имя типа: "TkwWaitCancel"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _afwImpurity_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}
 TkwWaitCancel = {final} class(_afwImpurity_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwWaitCancel
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}

class function TkwWaitCancel.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:Cancel';
end;//TkwWaitCancel.GetWordNameForRegister

procedure TkwWaitCancel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FFFE217028B_var*
//#UC END# *4DAEEDE10285_4FFFE217028B_var*
begin
//#UC START# *4DAEEDE10285_4FFFE217028B_impl*
 Tl3BatchService.Instance.PushAnswer(mrCancel);
//#UC END# *4DAEEDE10285_4FFFE217028B_impl*
end;//TkwWaitCancel.DoDoIt

initialization
 TkwWaitCancel.RegisterInEngine;
 {* Регистрация wait_Cancel }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
