unit kwWasWait;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWasWait.pas"
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
 {$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}
 TkwWasWait = class(_afwImpurity_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwWasWait
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}

procedure TkwWasWait.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB94B3103DB_var*
var
 l_WasWait : Boolean;
//#UC END# *4DAEEDE10285_4DB94B3103DB_var*
begin
//#UC START# *4DAEEDE10285_4DB94B3103DB_impl*
 l_WasWait := false;
 try
  l_WasWait := Tl3BatchService.Instance.CheckWasDialog;
 except
  aCtx.rEngine.PushBool(false);
  raise;
 end;//l_WasWait
 aCtx.rEngine.PushBool(l_WasWait);
//#UC END# *4DAEEDE10285_4DB94B3103DB_impl*
end;//TkwWasWait.DoDoIt

class function TkwWasWait.GetWordNameForRegister: AnsiString;
begin
 Result := 'waited:?';
end;//TkwWasWait.GetWordNameForRegister

initialization
 TkwWasWait.RegisterInEngine;
 {* Регистрация Was_Wait }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
