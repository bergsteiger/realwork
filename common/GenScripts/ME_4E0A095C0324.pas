unit kwArchiNewDocument;
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

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiNewDocument.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwArchiNewDocument" MUID: (4E0A095C0324)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCreateNewFile
 , tfwScriptingInterfaces
;

type
 TkwArchiNewDocument = class(TkwCreateNewFile)
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
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiNewDocument
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

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
begin
 Result := '�������';
end;//TkwArchiNewDocument.GetWordNameForRegister

initialization
 TkwArchiNewDocument.RegisterInEngine;
 {* ����������� TkwArchiNewDocument }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
