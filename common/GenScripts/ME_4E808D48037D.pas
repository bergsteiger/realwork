unit kwQueryCardFromStackWord;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evCustomEditorWindow
;

type
 TkwQueryCardFromStackWord = class(TkwEditorFromStackWord)
  {* ����� ���������� � ������� ���������� ��� � ��������� ������� }
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwQueryCardFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
