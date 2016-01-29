unit kwArchiOpenDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiOpenDocument.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiOpenDocument
//
// *������:*  �����_��������� ����������_����� �������
// *��������:* ��������� �������� �� ������. ��������� ���������� ���� ����������/������� ���
// ������� ������ ���������.
// *������:*
// {code}
// 10003000 true �������
// {code}
// *���������:* ��������� ����������� ��
// *����������:*
// ��������� ������� ���������� � ������, ������� � �������� ����, ��������� � �����:
// {code}
// w:\archi\source\projects\Archi\TestSet\Dictionary\DocumentConst.script"
// {code}
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
 TkwArchiOpenDocument = {scriptword} class(TtfwRegisterableWord)
  {* *������:*  �����_��������� ����������_����� �������
*��������:* ��������� �������� �� ������. ��������� ���������� ���� ����������/������� ��� ������� ������ ���������.
 *������:*
 [code]
 10003000 true �������
 [code]
 *���������:* ��������� ����������� ��
 *����������:*
 ��������� ������� ���������� � ������, ������� � �������� ����, ��������� � �����:
 [code]
 w:\archi\source\projects\Archi\TestSet\Dictionary\DocumentConst.script"
 [code]
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
 end;//TkwArchiOpenDocument
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwArchiOpenDocument

procedure TkwArchiOpenDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE6299E021A_var*
//#UC END# *4DAEEDE10285_4DE6299E021A_var*
begin
//#UC START# *4DAEEDE10285_4DE6299E021A_impl*
 if aCtx.rEngine.IsTopString then
  aCtx.rCaller.Check(arOpenByNumberAsString(aCtx.rEngine.PopDelphiString, true))
 else
 if aCtx.rEngine.IsTopBool then
 begin
  if aCtx.rEngine.PopBool then
   aCtx.rCaller.Check(arOpenDocumentByNumber(aCtx.rEngine.PopInt, 0, True))
  else
   aCtx.rCaller.Check(arOpenDocumentByNumber(aCtx.rEngine.PopInt, 0, False));
 end//aCtx.rEngine.IsTopBool
 else
  aCtx.rCaller.Check(arOpenDocumentByNumber(aCtx.rEngine.PopInt, 0, False));
//#UC END# *4DAEEDE10285_4DE6299E021A_impl*
end;//TkwArchiOpenDocument.DoDoIt

class function TkwArchiOpenDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������';
end;//TkwArchiOpenDocument.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwArchiOpenDocument
 TkwArchiOpenDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.