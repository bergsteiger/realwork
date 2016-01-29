unit evQueryCardDropControlsInt;

interface

uses
 l3IntfUses
 , nevTools
 , Messages
 , nevBase
 , l3Interfaces
 , Controls
 , Types
;

type
 InevBase = nevTools.InevBase;
 
 IevDropControl = interface
  procedure AfterHideControl;
  procedure EscPressed;
   {* ���������� �������� ������ �� ESC. }
  procedure HideControl;
   {* ������ ���������� �������. }
  function MouseWheel(aDown: Boolean): Boolean;
   {* ���������� ��������� ������ ����. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown): Boolean;
  procedure CloseTree;
   {* ������ ������ ��� �� ������� Esc - � �������� ��������� ���������. }
  function DropDown(const aView: InevView;
   const aTextPara: InevPara;
   ByUser: Boolean): Boolean;
   {* ��������� ��������� ������ ��� ���������. }
  procedure DropDownCurrentChanged(const aNode: InevSimpleNode);
 end;//IevDropControl
 
 IevDropCombo = interface
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* ���������� ����. }
  procedure ChooseNode(const Value: InevSimpleNode;
   NeedHide: Boolean);
   {* ���������� ������ ���� � ������ ��� ��� ��������. }
 end;//IevDropCombo
 
 IevDropCalendar = interface
  procedure ApplyDate(Value: TDateTime);
   {* ������� ��������� ���� � ���������. }
  procedure ChooseDate(Sender: TObject);
  procedure CancelDate(Sender: TObject);
 end;//IevDropCalendar
 
 IevDropContainer = interface
  {* ��������� ��� ���������� ���������. }
  function EditMask: AnsiString;
   {* ������ �����. }
  function DateFormat: AnsiString;
   {* ������ ����. }
  procedure SetDropTree(const ATreeDrop: IevDropControl;
   const ATagWrap: InevPara);
   {* ����������/��������� ���������� ������. }
  function IsDropTreeVisible: Boolean;
   {* ��������� ������������ �� ���� ��������� ��� ������. }
  procedure ApplyDate(Value: TDateTime);
   {* ������� ��������� ���� � ���������. }
  procedure ChooseDate(Sender: TObject);
   {* ���������� ������ ������� ����. }
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* ���������� ���������� ������� �� ��������� �����������. }
  procedure ShowControl(const aPoint: TPoint;
   AInvert: Boolean;
   AWnd: hWnd;
   AWidth: Integer;
   AHeight: Integer);
   {* ����� �������� �� �����. }
  function DropControlHeigth: Integer;
   {* ������ ����������� ��������. }
  procedure HideControl(NeedFocus: Boolean);
   {* ������ ���������� ������. }
  function GetDropTreeNode(anIndex: Integer): InevSimpleNode;
  function CheckControl(const aDropControl: IevDropControl): Boolean;
  function GetControl: TControl;
   {* ���������� �������. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Variant): Boolean;
   {* ��������� ������� �� ����������. }
  function IsSameTreeRoot(const aRoot: InevNode): Boolean;
  procedure DropControlChanging;
  procedure DropControlChanged;
  function GetCurrentNode: InevSimpleNode;
  function IsSimpleTree: Boolean;
 end;//IevDropContainer
 
implementation

uses
 l3ImplUses
;

end.
