unit kwEditorTextSaveAs;
 {* ��������: ��������� ���� �� ��������� (��� ������������� �������) � ������ ������� � �������� � ��������� �����������.
������:
[code]
anExt Editor:Text:SaveAs
[code]
��� anExt - ���������� �� ������ ��������������: '.evd', .txt', .rtf', .doc' }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorTextSaveAs.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Editor_Text_SaveAs" MUID: (537D968501B2)
// ��� ����: "TkwEditorTextSaveAs"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEditorTextSaveAs = {final} class(TtfwRegisterableWord)
  {* ��������: ��������� ���� �� ��������� (��� ������������� �������) � ������ ������� � �������� � ��������� �����������.
������:
[code]
anExt Editor:Text:SaveAs
[code]
��� anExt - ���������� �� ������ ��������������: '.evd', .txt', .rtf', .doc' }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorTextSaveAs
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 , SysUtils
;

procedure TkwEditorTextSaveAs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_537D968501B2_var*
var
 l_FileExt: AnsiString;
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_537D968501B2_var*
begin
//#UC START# *4DAEEDE10285_537D968501B2_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ����������!', aCtx);
 l_FileExt := aCtx.rEngine.PopDelphiString;
 l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, l_FileExt);
 l_FileName := ExtractFileName(l_FileName);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 AcSaveTextAs(l_FileName);
//#UC END# *4DAEEDE10285_537D968501B2_impl*
end;//TkwEditorTextSaveAs.DoDoIt

class function TkwEditorTextSaveAs.GetWordNameForRegister: AnsiString;
begin
 Result := 'Editor:Text:SaveAs';
end;//TkwEditorTextSaveAs.GetWordNameForRegister

initialization
 TkwEditorTextSaveAs.RegisterInEngine;
 {* ����������� Editor_Text_SaveAs }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
