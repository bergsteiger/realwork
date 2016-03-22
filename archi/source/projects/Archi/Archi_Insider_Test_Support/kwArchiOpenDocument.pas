unit kwArchiOpenDocument;
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

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiOpenDocument.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwArchiOpenDocument" MUID: (4DE6299E021A)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwArchiOpenDocument = class(TtfwRegisterableWord)
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
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiOpenDocument
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

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
begin
 Result := '�������';
end;//TkwArchiOpenDocument.GetWordNameForRegister

initialization
 TkwArchiOpenDocument.RegisterInEngine;
 {* ����������� TkwArchiOpenDocument }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
