unit kwDialogsLockDocumentGetSkipMode;
 {* ��������� ������������� ����� ������ � �������� � ������� ���������:
[code]
  ar_AsUsual // ���������� ������ � ��������� ��� ���������.
  ar_OpenDocument // ���� ���� ���������� - ��� ����� ���������.
  ar_NotOpen // ���� ���� ���������� - �� ���������.
[code] }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDialogsLockDocumentGetSkipMode.pas"
// ���������: "ScriptKeyword"
// ������� ������: "dialogs_LockDocument_GetSkipMode" MUID: (54255ED703B9)
// ��� ����: "TkwDialogsLockDocumentGetSkipMode"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDialogsLockDocumentGetSkipMode = {final} class(TtfwRegisterableWord)
  {* ��������� ������������� ����� ������ � �������� � ������� ���������:
[code]
  ar_AsUsual // ���������� ������ � ��������� ��� ���������.
  ar_OpenDocument // ���� ���� ���������� - ��� ����� ���������.
  ar_NotOpen // ���� ���� ���������� - �� ���������.
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwDialogsLockDocumentGetSkipMode
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

class function TkwDialogsLockDocumentGetSkipMode.GetWordNameForRegister: AnsiString;
begin
 Result := 'dialogs:LockDocument:GetSkipMode';
end;//TkwDialogsLockDocumentGetSkipMode.GetWordNameForRegister

procedure TkwDialogsLockDocumentGetSkipMode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54255ED703B9_var*
//#UC END# *4DAEEDE10285_54255ED703B9_var*
begin
//#UC START# *4DAEEDE10285_54255ED703B9_impl*
 aCtx.rEngine.PushInt(Ord(TarTestConfig.Instance.SkipLockDialog));
//#UC END# *4DAEEDE10285_54255ED703B9_impl*
end;//TkwDialogsLockDocumentGetSkipMode.DoDoIt

initialization
 TkwDialogsLockDocumentGetSkipMode.RegisterInEngine;
 {* ����������� dialogs_LockDocument_GetSkipMode }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
