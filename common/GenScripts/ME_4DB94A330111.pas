unit kwWaitYes;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitYes.pas"
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
 TkwWaitYes = class(_afwImpurity_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwWaitYes
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include afwImpurity.imp.pas}

procedure TkwWaitYes.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB94A330111_var*
//#UC END# *4DAEEDE10285_4DB94A330111_var*
begin
//#UC START# *4DAEEDE10285_4DB94A330111_impl*
 Tl3BatchService.Instance.PushAnswer(mrYes);
//#UC END# *4DAEEDE10285_4DB94A330111_impl*
end;//TkwWaitYes.DoDoIt

class function TkwWaitYes.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:Yes';
end;//TkwWaitYes.GetWordNameForRegister

initialization
 TkwWaitYes.RegisterInEngine;
 {* Регистрация wait_Yes }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
