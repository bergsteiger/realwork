unit kwDialogsLockDocumentSetSkipMode;
 {* ������������� ����� ������ � �������� � ������� ���������:
[code]
  ar_AsUsual // ���������� ������ � ��������� ��� ���������.
  ar_OpenDocument // ���� ���� ���������� - ��� ����� ���������.
  ar_NotOpen // ���� ���� ���������� - �� ���������.
[code]
������:
[code]
aMode dialogs:LockDocument:SetSkipMode
[code] }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDialogsLockDocumentSetSkipMode.pas"
// ���������: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDialogsLockDocumentSetSkipMode = {final} class(TtfwRegisterableWord)
  {* ������������� ����� ������ � �������� � ������� ���������:
[code]
  ar_AsUsual // ���������� ������ � ��������� ��� ���������.
  ar_OpenDocument // ���� ���� ���������� - ��� ����� ���������.
  ar_NotOpen // ���� ���� ���������� - �� ���������.
[code]
������:
[code]
aMode dialogs:LockDocument:SetSkipMode
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDialogsLockDocumentSetSkipMode
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

procedure TkwDialogsLockDocumentSetSkipMode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54255FED0328_var*
//#UC END# *4DAEEDE10285_54255FED0328_var*
begin
//#UC START# *4DAEEDE10285_54255FED0328_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, '�� ����� ����� ������ �������!', aCtx);
 TarTestConfig.Instance.SkipLockDialog := TarSkipDialog(aCtx.rEngine.PopInt);
//#UC END# *4DAEEDE10285_54255FED0328_impl*
end;//TkwDialogsLockDocumentSetSkipMode.DoDoIt

class function TkwDialogsLockDocumentSetSkipMode.GetWordNameForRegister: AnsiString;
begin
 Result := 'dialogs:LockDocument:SetSkipMode';
end;//TkwDialogsLockDocumentSetSkipMode.GetWordNameForRegister

initialization
 TkwDialogsLockDocumentSetSkipMode.RegisterInEngine;
 {* ����������� dialogs_LockDocument_SetSkipMode }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
