unit kwPopEditorDP2LP;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorDP2LP = class(TkwEditorFromStackWord)
  {* *������:* X Y anEditorControl pop:editor:DP2LP
*��������:* �������� �������� ����� �� ����� ����� � �������.
*������:*
[code] 
100 100  focused:control:push pop:editor:DP2LP
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorDP2LP
 
implementation

uses
 l3ImplUses
 , l3Units
;

end.
