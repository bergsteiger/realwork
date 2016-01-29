unit kwPopEditorPrintAcnhor;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , nevTools
 , evCustomEditorWindow
;

type
 TkwPopEditorPrintAcnhor = class(TkwEditorFromStackWord)
  {* *������:* aTopAnchor anEditorControl pop:editor:PrintAcnhor
*��������:* �������� ������� �������� �����, ������� ��������, �������, PID �������� � �.�. aTopAnchor - true - ������� �����, false - ������ �����.
*������:*
[code] 
true focused:control:push pop:editor:PrintAcnhor
[code] 
*���������:* � ��������� �� �������� ���� � ����� ���������� �������� "true" ��� "false" }
  procedure SaveAnchor(const aCtx: TtfwContext;
   const anAnchor: InevBasePoint;
   anEditor: TevCustomEditorWindow);
  function CheckBaseLine(const aCtx: TtfwContext;
   const anAnchor: InevBasePoint;
   anEditor: TevCustomEditorWindow): Boolean;
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorPrintAcnhor
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
