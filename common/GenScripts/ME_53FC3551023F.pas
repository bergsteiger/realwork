unit kwTestResolveInputFilePath;
 {* *��������:* ��������� � ����� ����� ���� � ���������� TestSet, ��� �������� �������� �����.
*������*
[code]
aFileName test:ResolveInputFilePath
[code]
��� aFileName - ��� ����� ��� ���� (!).
��������� ���������� � ����. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwTestResolveInputFilePath.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwTestResolveInputFilePath = {final} class(TtfwRegisterableWord)
  {* *��������:* ��������� � ����� ����� ���� � ���������� TestSet, ��� �������� �������� �����.
*������*
[code]
aFileName test:ResolveInputFilePath
[code]
��� aFileName - ��� ����� ��� ���� (!).
��������� ���������� � ����. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTestResolveInputFilePath
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwTestResolveInputFilePath.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53FC3551023F_var*
//#UC END# *4DAEEDE10285_53FC3551023F_var*
begin
//#UC START# *4DAEEDE10285_53FC3551023F_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ��� �����!', aCtx);
 aCtx.rEngine.PushString(aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_53FC3551023F_impl*
end;//TkwTestResolveInputFilePath.DoDoIt

class function TkwTestResolveInputFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'test:ResolveInputFilePath';
end;//TkwTestResolveInputFilePath.GetWordNameForRegister

initialization
 TkwTestResolveInputFilePath.RegisterInEngine;
 {* ����������� test_ResolveInputFilePath }
{$IfEnd} // NOT Defined(NoScripts)

end.
