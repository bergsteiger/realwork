unit kwPopEditorWheelScroll;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorWheelScroll = class(TkwEditorFromStackWord)
  {* *������:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*��������:* ������������ �������� � ������� ���������. aVeritcal - ���� true, �� ����������� �����������. aUp - ������������ �����, ���� true
*������:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorWheelScroll
 
implementation

uses
 l3ImplUses
;

end.
