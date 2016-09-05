unit kwWaitNo;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitNo.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "wait_No" MUID: (4DB94AE60059)
// Имя типа: "TkwWaitNo"

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
 TkwWaitNo = class(_afwImpurity_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwWaitNo
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
 //#UC START# *4DB94AE60059impl_uses*
 //#UC END# *4DB94AE60059impl_uses*
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}

class function TkwWaitNo.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:No';
end;//TkwWaitNo.GetWordNameForRegister

procedure TkwWaitNo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB94AE60059_var*
//#UC END# *4DAEEDE10285_4DB94AE60059_var*
begin
//#UC START# *4DAEEDE10285_4DB94AE60059_impl*
 {$IfNDef NoVCL}
 Tl3BatchService.Instance.PushAnswer(mrNo);
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *4DAEEDE10285_4DB94AE60059_impl*
end;//TkwWaitNo.DoDoIt

initialization
 TkwWaitNo.RegisterInEngine;
 {* Регистрация wait_No }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
