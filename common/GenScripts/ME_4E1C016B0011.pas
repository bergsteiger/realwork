unit DrawOutputSupport.imp;

interface

uses
 l3IntfUses
 , nevShapesPaintedSpy
 , evCustomEditorWindow
 , nevTools
;

type
 _DrawOutputSupport_ = class(InevShapesLogger)
  {* ��������� ���������� ���������� �� ������������ � ���� ��� ������������ ��������� � ��������. }
  procedure SaveDrawing(const aText: TevCustomEditorWindow);
   {* ��������� ���������� �� ������������. }
  procedure DoRepaint(aText: TevCustomEditorWindow);
  function DoOpenLog(const aView: InevView): AnsiString;
  procedure DoCloseLog(const aLogName: AnsiString);
  function OpenLog(const aView: InevView): AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
  function LogScreen(const aView: InevView): Boolean;
 end;//_DrawOutputSupport_
 
implementation

uses
 l3ImplUses
;

end.
