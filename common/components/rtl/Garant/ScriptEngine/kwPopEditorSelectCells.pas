unit kwPopEditorSelectCells;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorSelectCells.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_SelectCells
//
// *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
// *��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell)
// �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� �������
// � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
// *������:*
// {code}
// 0 0 2 2 focused:control:push pop:editor:SelectCells
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
 TkwPopEditorSelectCells = {final scriptword} class(TkwSelectCellsWord)
  {* *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
*��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell) �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
*������:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCells
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
 end;//TkwPopEditorSelectCells
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwPopEditorSelectCells

function TkwPopEditorSelectCells.IsVertical: Boolean;
//#UC START# *4F6042D20081_4F4DD643008C_var*
//#UC END# *4F6042D20081_4F4DD643008C_var*
begin
//#UC START# *4F6042D20081_4F4DD643008C_impl*
 Result := False;
//#UC END# *4F6042D20081_4F4DD643008C_impl*
end;//TkwPopEditorSelectCells.IsVertical

class function TkwPopEditorSelectCells.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:SelectCells';
end;//TkwPopEditorSelectCells.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_SelectCells
 TkwPopEditorSelectCells.RegisterInEngine;
{$IfEnd} //not NoScripts

end.