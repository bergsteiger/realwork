unit kwPopEditorCheckWithEtalon;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorCheckWithEtalon.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_CheckWithEtalon
//
// *��������:*
// �������������� �������� �������� ������ �� ������������ ��� ������. ���������� ������ ��
// ��������� ��������� ������ ����� ��������� �������. ��������� ���� � ������ NNN.shapes - ��� NNN
// - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������
// �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������,
// �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ����
// ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ���������
// ������.
// *������:*
// {code}
// anEditor pop:editor:CheckWithEtalon aProc
// {code}
// ��� anEditor - ��������� �� ��������, � ������� ����� ��������� ���������. aProc - ���������,
// ���������� ���������.
// *������:*
// {code}
// focused:control:push pop:editor:CheckWithEtalon "��������� ������ �������"
// {code}
// ��������� ��������� � ���������, ��� ��������� ����� ����� ���������� ������� "��������� ������
// �������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwWordWorker,
  tfwScriptingInterfaces,
  kwCompiledWordWorker
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopEditorCheckWithEtalon = {final scriptword} class(TtfwWordWorker)
  {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ���������� ������ �� ��������� ��������� ������ ����� ��������� �������. ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:CheckWithEtalon aProc
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ��������� ���������. aProc - ���������, ���������� ���������.
*������:*
[code]
focused:control:push pop:editor:CheckWithEtalon "��������� ������ �������"
[code]
��������� ��������� � ���������, ��� ��������� ����� ����� ���������� ������� "��������� ������ �������". }
 protected
 // realized methods
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorCheckWithEtalon
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwCompiledCheckWithEtalon
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwPopEditorCheckWithEtalon

function TkwPopEditorCheckWithEtalon.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_50D44F67024C_var*
//#UC END# *4DCBD67C0362_50D44F67024C_var*
begin
//#UC START# *4DCBD67C0362_50D44F67024C_impl*
 Result := TkwCompiledCheckWithEtalon;
//#UC END# *4DCBD67C0362_50D44F67024C_impl*
end;//TkwPopEditorCheckWithEtalon.CompiledWorkerClass

class function TkwPopEditorCheckWithEtalon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:CheckWithEtalon';
end;//TkwPopEditorCheckWithEtalon.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_CheckWithEtalon
 TkwPopEditorCheckWithEtalon.RegisterInEngine;
{$IfEnd} //not NoScripts

end.