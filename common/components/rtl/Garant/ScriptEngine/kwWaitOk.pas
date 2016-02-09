unit kwWaitOk;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitOk.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _afwImpurity_Parent_ = TtfwRegisterableWord;
 {$Include afwImpurity.imp.pas}
 TkwWaitOk = class(_afwImpurity_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwWaitOk
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include afwImpurity.imp.pas}

procedure TkwWaitOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DDE8A650180_var*
//#UC END# *4DAEEDE10285_4DDE8A650180_var*
begin
//#UC START# *4DAEEDE10285_4DDE8A650180_impl*
 Tl3BatchService.Instance.PushAnswer(mrOk);
//#UC END# *4DAEEDE10285_4DDE8A650180_impl*
end;//TkwWaitOk.DoDoIt

class function TkwWaitOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:Ok';
end;//TkwWaitOk.GetWordNameForRegister

initialization
 TkwWaitOk.RegisterInEngine;
 {* Регистрация wait_Ok }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
