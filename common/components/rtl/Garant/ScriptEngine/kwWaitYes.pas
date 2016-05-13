unit kwWaitYes;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitYes.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "wait_Yes" MUID: (4DB94A330111)
// Имя типа: "TkwWaitYes"

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
 TkwWaitYes = class(_afwImpurity_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwWaitYes
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}

class function TkwWaitYes.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:Yes';
end;//TkwWaitYes.GetWordNameForRegister

procedure TkwWaitYes.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB94A330111_var*
//#UC END# *4DAEEDE10285_4DB94A330111_var*
begin
//#UC START# *4DAEEDE10285_4DB94A330111_impl*
 Tl3BatchService.Instance.PushAnswer(mrYes);
//#UC END# *4DAEEDE10285_4DB94A330111_impl*
end;//TkwWaitYes.DoDoIt

initialization
 TkwWaitYes.RegisterInEngine;
 {* Регистрация wait_Yes }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
