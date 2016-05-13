unit kwWaitOk;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwWaitOk.pas"
// ���������: "ScriptKeyword"
// ������� ������: "wait_Ok" MUID: (4DDE8A650180)
// ��� ����: "TkwWaitOk"

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
 TkwWaitOk = class(_afwImpurity_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwWaitOk
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3BatchService
 , Controls
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\afwImpurity.imp.pas}

class function TkwWaitOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'wait:Ok';
end;//TkwWaitOk.GetWordNameForRegister

procedure TkwWaitOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DDE8A650180_var*
//#UC END# *4DAEEDE10285_4DDE8A650180_var*
begin
//#UC START# *4DAEEDE10285_4DDE8A650180_impl*
 Tl3BatchService.Instance.PushAnswer(mrOk);
//#UC END# *4DAEEDE10285_4DDE8A650180_impl*
end;//TkwWaitOk.DoDoIt

initialization
 TkwWaitOk.RegisterInEngine;
 {* ����������� wait_Ok }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
