unit kwPopEditorSelectCells;
 {* *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
*��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell) �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
*������:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCells
[code] 
*���������:* �������� �������� ����� � ������� �� (0, 0) �� (2, 2) � �������� ���������.
*����������:* � ������ ������ ������ ���� ������ ���� ��������, ����� ��������� ����� ������������.
*���������� 2:* ����� � ��������� ������ ������ ���� �������� �� ������ ����. �����  �������� ��������� �� ������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas"
// ���������: "ScriptKeyword"
// ������� ������: "pop_editor_SelectCells" MUID: (4F4DD643008C)
// ��� ����: "TkwPopEditorSelectCells"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCells = {final} class(TkwSelectCellsWord)
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
   function IsVertical: Boolean; override;
    {* ��� ��������� ���� �������� ������ ����. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCells
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4F4DD643008Cimpl_uses*
 //#UC END# *4F4DD643008Cimpl_uses*
;

function TkwPopEditorSelectCells.IsVertical: Boolean;
 {* ��� ��������� ���� �������� ������ ����. }
//#UC START# *4F6042D20081_4F4DD643008C_var*
//#UC END# *4F6042D20081_4F4DD643008C_var*
begin
//#UC START# *4F6042D20081_4F4DD643008C_impl*
 Result := False;
//#UC END# *4F6042D20081_4F4DD643008C_impl*
end;//TkwPopEditorSelectCells.IsVertical

class function TkwPopEditorSelectCells.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectCells';
end;//TkwPopEditorSelectCells.GetWordNameForRegister

initialization
 TkwPopEditorSelectCells.RegisterInEngine;
 {* ����������� pop_editor_SelectCells }
{$IfEnd} // NOT Defined(NoScripts)

end.
