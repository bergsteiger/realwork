unit kwArchiNewEmptyDocument;
 {* *������:* �������_������
*��������:* �������� ������� ���������. 
*������:*
[code]
 �������_������
[code]
*���������:*
 ������� ������ ��������
*����������:*
 � �������� �������� ����������� �� ������������, ��� ��� ���� ����� ������� ������� � �����:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
[code] }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiNewEmptyDocument.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwArchiNewEmptyDocument" MUID: (4E8EE51103C2)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCreateNewFile
 , tfwScriptingInterfaces
;

type
 TkwArchiNewEmptyDocument = class(TkwCreateNewFile)
  {* *������:* �������_������
*��������:* �������� ������� ���������. 
*������:*
[code]
 �������_������
[code]
*���������:*
 ������� ������ ��������
*����������:*
 � �������� �������� ����������� �� ������������, ��� ��� ���� ����� ������� ������� � �����:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
[code] }
  protected
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiNewEmptyDocument
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
 , dt_Types
 , SysUtils
;

function TkwArchiNewEmptyDocument.DoWithFileName(const aCtx: TtfwContext): AnsiString;
//#UC START# *52BD79600196_4E8EE51103C2_var*
//#UC END# *52BD79600196_4E8EE51103C2_var*
begin
//#UC START# *52BD79600196_4E8EE51103C2_impl*
 Result := '';
//#UC END# *52BD79600196_4E8EE51103C2_impl*
end;//TkwArchiNewEmptyDocument.DoWithFileName

class function TkwArchiNewEmptyDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '�������_������';
end;//TkwArchiNewEmptyDocument.GetWordNameForRegister

initialization
 TkwArchiNewEmptyDocument.RegisterInEngine;
 {* ����������� TkwArchiNewEmptyDocument }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
