unit kwPopEditorSelectCellsVertical;
 {* *������:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCellsVertical
*��������:* �������� �������� ����� � ������� ���� ������� �� ��������� (aStartCell, aRowCell) �� �������� (aFinishCell, aFinishRow). ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aStartCell aStartRow aFinshCell aFinishRow - Integer
*������:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCellsVertical
[code] 
*���������:* �������� �������� ����� � ������� �� (0, 0) �� (2, 2) � �������� ���������.
*����������:* � ������ ������ ������ ���� ������ ���� ��������, ����� ��������� ����� ������������.
*���������� 2:* ����� � ��������� ������ ������ ���� �������� �� ������ ����. �����  �������� ��������� �� ������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas"
// ���������: "ScriptKeyword"
// ������� ������: "pop_editor_SelectCellsVertical" MUID: (4F6044140356)
// ��� ����: "TkwPopEditorSelectCellsVertical"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCellsVertical = {final} class(TkwSelectCellsWord)
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
   function IsVertical: Boolean; override;
    {* ��� ��������� ���� �������� ������ ����. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCellsVertical
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
;

function TkwPopEditorSelectCellsVertical.IsVertical: Boolean;
 {* ��� ��������� ���� �������� ������ ����. }
//#UC START# *4F6042D20081_4F6044140356_var*
//#UC END# *4F6042D20081_4F6044140356_var*
begin
//#UC START# *4F6042D20081_4F6044140356_impl*
 Result := True;
//#UC END# *4F6042D20081_4F6044140356_impl*
end;//TkwPopEditorSelectCellsVertical.IsVertical

class function TkwPopEditorSelectCellsVertical.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectCellsVertical';
end;//TkwPopEditorSelectCellsVertical.GetWordNameForRegister

initialization
 TkwPopEditorSelectCellsVertical.RegisterInEngine;
 {* ����������� pop_editor_SelectCellsVertical }
{$IfEnd} // NOT Defined(NoScripts)

end.
