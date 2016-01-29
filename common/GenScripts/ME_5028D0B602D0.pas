unit kwPopEditorPrintTableCellsParams;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorPrintTableCellsParams = class(TkwEditorFromStackWord)
  {* *������:* anEditorControl pop:editor:PrintTableCellsParams
*��������:* �������� ��������� ���������� ����� �������: ��� �����������, ���� ������������, �� ����� ������ � ������ ������, ����� ������ � ������ ����� � ����� ��������� ������/����� ������, ��� ��� ������. ��������� ��������� � ������� ���� ������ �����������.
*������:*
[code] 
focused:control:push pop:editor:PrintTableCellsParams
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorPrintTableCellsParams
 
implementation

uses
 l3ImplUses
 , nevBase
 , nevFormatInfoUtils
 , l3Base
 , SysUtils
 , nevFacade
;

end.
