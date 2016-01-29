unit kwArchiCloseDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiCloseDocument.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiCloseDocument
//
// *������:* �������
// *��������:* ��������� ������� �������� ���� � ����. � �������� ���� ����� ��������� ����
// ���������, ���� ��������� ���������, ���� �������� � �.�.
// *������:*
// {code}
// '76.bmp' �������_���������_�����_��
// TRY
// carPictureViewer TryFocus ASSERT
// acCut arMainActionList carMainForm Action:Execute
// ProcessMessages
// acPaste arMainActionList carMainForm Action:Execute
// ProcessMessages
// FINALLY
// wait:No
// �������
// waited:? ASSERT
// END
// {code}
// *���������:*
// ������� ��������� ����� �� ������������ �����, ��������� � ���� ����� �������� �������� (�
// ������ ������, �����������/������� ��������� �/�� ������ ������) � ��������� �������� ���
// ������� � ������������� ����������.
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwArchiCloseDocument = {scriptword} class(TtfwRegisterableWord)
  {* *������:* �������
*��������:* ��������� ������� �������� ���� � ����. � �������� ���� ����� ��������� ���� ���������, ���� ��������� ���������, ���� �������� � �.�.
 *������:*
[code]
 '76.bmp' �������_���������_�����_��
 TRY
   carPictureViewer TryFocus ASSERT
   acCut arMainActionList carMainForm Action:Execute
   ProcessMessages
   acPaste arMainActionList carMainForm Action:Execute
   ProcessMessages
 FINALLY
  wait:No
  �������
  waited:? ASSERT
 END
[code]
 *���������:*
 ������� ��������� ����� �� ������������ �����, ��������� � ���� ����� �������� �������� (� ������ ������, �����������/������� ��������� �/�� ������ ������) � ��������� �������� ��� ������� � ������������� ����������.
*����������:*
 � �������� �������� ����������� �� ������������, ��� ��� ���� ����� ������� ������� � �����:
[code]
 w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiCloseDocument
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwArchiCloseDocument

procedure TkwArchiCloseDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE632EF020B_var*
//#UC END# *4DAEEDE10285_4DE632EF020B_var*
begin
//#UC START# *4DAEEDE10285_4DE632EF020B_impl*
 aCtx.rCaller.Check(arCloseActiveDocument);
//#UC END# *4DAEEDE10285_4DE632EF020B_impl*
end;//TkwArchiCloseDocument.DoDoIt

class function TkwArchiCloseDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������';
end;//TkwArchiCloseDocument.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwArchiCloseDocument
 TkwArchiCloseDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.