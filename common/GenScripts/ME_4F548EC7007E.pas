unit kwPopEditorSelectColumn;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSelectColumn = class(TkwEditorFromStackWord)
  {* *������:* aColID anEditorControl pop:editor:SelectCells
*��������:* �������� ������� �������. ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aColID - Integer
*������:*
[code] 
2 focused:control:push pop:editor:SelectCells
[code] 
*���������:* �������� ������ �������. }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorSelectColumn
 
implementation

uses
 l3ImplUses
 , evCursorTools
;

end.
