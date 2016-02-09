unit kwPopEditorResizeTableColumn;
 {* �������� ������ ������� �������. ������:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - ����� ������, ������� �����
 * aRow - ����� ������
 * aDelta - �������� ������� (������������� - ������, ������������� - �����).
[panel] }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
;

type
 TkwPopEditorResizeTableColumn = class(TkwEditorFromStackTableColumnResize)
  {* �������� ������ ������� �������. ������:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - ����� ������, ������� �����
 * aRow - ����� ������
 * aDelta - �������� ������� (������������� - ������, ������������� - �����).
[panel] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorResizeTableColumn
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 , CommentPara_Const
 , TextPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

class function TkwPopEditorResizeTableColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ResizeTableColumn';
end;//TkwPopEditorResizeTableColumn.GetWordNameForRegister

initialization
 TkwPopEditorResizeTableColumn.RegisterInEngine;
 {* ����������� pop_editor_ResizeTableColumn }
{$IfEnd} // NOT Defined(NoScripts)

end.
