unit kwPopEditorResizeTableColumn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwPopEditorResizeTableColumn.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::pop_editor_ResizeTableColumn
//
// �������� ������ ������� �������. ������:
// {code}   aDelta aCol aRow editor:ResizeTableColumn {code}
// {panel}
// * aCol - ����� ������, ������� �����
// * aRow - ����� ������
// * aDelta - �������� ������� (������������� - ������, ������������� - �����).
// {panel}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwEditorFromStackTableColumnResize
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopEditorResizeTableColumn = {scriptword} class(TkwEditorFromStackTableColumnResize)
  {* �������� ������ ������� �������. ������:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - ����� ������, ������� �����
 * aRow - ����� ������
 * aDelta - �������� ������� (������������� - ������, ������������� - �����).
[panel] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorResizeTableColumn
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  evOp,
  CommentPara_Const,
  TextPara_Const
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwPopEditorResizeTableColumn

class function TkwPopEditorResizeTableColumn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:ResizeTableColumn';
end;//TkwPopEditorResizeTableColumn.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_editor_ResizeTableColumn
 TkwPopEditorResizeTableColumn.RegisterInEngine;
{$IfEnd} //not NoScripts

end.