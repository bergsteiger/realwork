unit kwPopEditorSelectCellsVertical;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorSelectCellsVertical.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_SelectCellsVertical
//
// *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl
// pop:editor:SelectCellsVertical
// *��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell)
// �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� �������
// � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
// *������:*
// {code}
// 0 0 2 2 focused:control:push pop:editor:SelectCellsVertical
// {code}
// *���������:* �������� �������� ����� � ������� �� (0, 0) �� (2, 2) � �������� ���������.
// *����������:* � ������ ������ ������ ���� ������ ���� ��������, ����� ��������� �����
// ������������.
// *���������� 2:* ����� � ��������� ������ ������ ���� �������� �� ������ ����. �����  ��������
// ��������� �� ������.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwSelectCellsWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopEditorSelectCellsVertical = {final scriptword} class(TkwSelectCellsWord)
  {* *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCellsVertical
*��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell) �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
*������:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCellsVertical
[code] 
*���������:* �������� �������� ����� � ������� �� (0, 0) �� (2, 2) � �������� ���������.
*����������:* � ������ ������ ������ ���� ������ ���� ��������, ����� ��������� ����� ������������.
*���������� 2:* ����� � ��������� ������ ������ ���� �������� �� ������ ����. �����  �������� ��������� �� ������. }
 protected
 // realized methods
   function IsVertical: Boolean; override;
     {* ��� ��������� ���� �������� ������ ����. }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCellsVertical
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwPopEditorSelectCellsVertical

function TkwPopEditorSelectCellsVertical.IsVertical: Boolean;
//#UC START# *4F6042D20081_4F6044140356_var*
//#UC END# *4F6042D20081_4F6044140356_var*
begin
//#UC START# *4F6042D20081_4F6044140356_impl*
 Result := True;
//#UC END# *4F6042D20081_4F6044140356_impl*
end;//TkwPopEditorSelectCellsVertical.IsVertical

class function TkwPopEditorSelectCellsVertical.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:SelectCellsVertical';
end;//TkwPopEditorSelectCellsVertical.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_SelectCellsVertical
 TkwPopEditorSelectCellsVertical.RegisterInEngine;
{$IfEnd} //not NoScripts

end.