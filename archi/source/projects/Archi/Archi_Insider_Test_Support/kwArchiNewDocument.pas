unit kwArchiNewDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiNewDocument.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiNewDocument
//
// *������:* �������
// *��������:* �������� ��������� �� �����. ��� ����� ��������� � ��������� �����, �� ������������
// ���������� evd.
// *������:*
// {code}
// �������
// {code}
// *���������:*
// ������� �������� �� ����� ��������_�����.evd
// *����������:*
// � �������� �������� ����������� �� ������������, ��� ��� ���� ����� ������� ������� � �����:
// {code}
// w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwCreateNewFile,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwArchiNewDocument = {scriptword} class(TkwCreateNewFile)
  {* *������:* �������
*��������:* �������� ��������� �� �����. ��� ����� ��������� � ��������� �����, �� ������������ ���������� evd.
*������:*
[code]
 �������
[code]
*���������:*
 ������� �������� �� ����� ��������_�����.evd
*����������:*
 � �������� �������� ����������� �� ������������, ��� ��� ���� ����� ������� ������� � �����:
[code]
 w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
[code] }
 protected
 // realized methods
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiNewDocument
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter,
  dt_Types,
  SysUtils
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwArchiNewDocument

function TkwArchiNewDocument.DoWithFileName(const aCtx: TtfwContext): AnsiString;
//#UC START# *52BD79600196_4E0A095C0324_var*
//#UC END# *52BD79600196_4E0A095C0324_var*
begin
//#UC START# *52BD79600196_4E0A095C0324_impl*
 Result := ChangeFileExt(aCtx.rStreamFactory.Filename, '.evd');
 Result := ExtractFileName(Result);
 Result := aCtx.rCaller.ResolveInputFilePath(Result);
//#UC END# *52BD79600196_4E0A095C0324_impl*
end;//TkwArchiNewDocument.DoWithFileName

class function TkwArchiNewDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������';
end;//TkwArchiNewDocument.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwArchiNewDocument
 TkwArchiNewDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.