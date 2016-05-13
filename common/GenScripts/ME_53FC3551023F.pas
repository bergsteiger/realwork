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
// ������� ������: "test_ResolveInputFilePath" MUID: (53FC3551023F)
// ��� ����: "TkwTestResolveInputFilePath"

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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwTestResolveInputFilePath
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwTestResolveInputFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'test:ResolveInputFilePath';
end;//TkwTestResolveInputFilePath.GetWordNameForRegister

procedure TkwTestResolveInputFilePath.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53FC3551023F_var*
//#UC END# *4DAEEDE10285_53FC3551023F_var*
begin
//#UC START# *4DAEEDE10285_53FC3551023F_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ��� �����!', aCtx);
 aCtx.rEngine.PushString(aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_53FC3551023F_impl*
end;//TkwTestResolveInputFilePath.DoDoIt

initialization
 TkwTestResolveInputFilePath.RegisterInEngine;
 {* ����������� test_ResolveInputFilePath }
{$IfEnd} // NOT Defined(NoScripts)

end.
