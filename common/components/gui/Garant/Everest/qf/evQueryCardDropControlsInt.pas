unit evQueryCardDropControlsInt;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/qf/evQueryCardDropControlsInt.pas"
// �����: 28.09.1999 10:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evQueryCardDropControlsInt
//
// //����� �� ���� ��������: IevDropControl (IevDropCombo, IevDropCalendar) -
// //���������� ����������, �������������� ������������� ��� ������������� ������
// //������, IevEditorControlXXXX - �������, ��� ������������� �� �������
// //�������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  nevBase,
  Types,
  Messages,
  nevTools
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;

type
 InevBase = nevTools.InevBase;

 IevDropControl = interface(InevBase)
   ['{5E113509-2D7B-4E1F-B96E-18C6C4A0ACC1}']
   function Get_Down: Boolean;
   procedure Set_Down(aValue: Boolean);
   function Get_Para: InevPara;
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
   property Down: Boolean
     read Get_Down
     write Set_Down;
     {* ������ �� ������ � ���������. }
   property Para: InevPara
     read Get_Para;
 end;//IevDropControl

 IevDropCombo = interface(InevBase)
   ['{11B2B5C6-D288-41EF-AEA4-2E7971EADBA5}']
   function Get_IsList: Boolean;
   function GetNode(anIndex: Integer): InevSimpleNode;
     {* ���������� ����. }
   procedure ChooseNode(const Value: InevSimpleNode;
    NeedHide: Boolean = True);
     {* ���������� ������ ���� � ������ ��� ��� ��������. }
   property IsList: Boolean
     read Get_IsList;
 end;//IevDropCombo

 IevDropCalendar = interface(InevBase)
   ['{D2B498FA-0D25-4054-906A-9927577F4636}']
   function Get_ADate: TDateTime;
   procedure Set_ADate(aValue: TDateTime);
   procedure ApplyDate(Value: TDateTime);
     {* ������� ��������� ���� � ���������. }
   procedure ChooseDate(Sender: TObject);
   procedure CancelDate(Sender: TObject);
   property aDate: TDateTime
     read Get_ADate
     write Set_ADate;
     {* ���� �� ��������. }
 end;//IevDropCalendar

 IevDropContainer = interface(InevBase)
  {* ��������� ��� ���������� ���������. }
   ['{0E8CE655-459D-466F-BAF3-CFF3FFE2631A}']
   function Get_Tree: InevSimpleTree;
   procedure Set_Tree(const aValue: InevSimpleTree);
   procedure Set_Current(aValue: Integer);
   function Get_ESCPressed: Boolean;
   procedure Set_ESCPressed(aValue: Boolean);
   function Get_DropTextStyle: Tl3StyleId;
   procedure Set_DropTextStyle(aValue: Tl3StyleId);
   function Get_AllowEmptyCurrent: Boolean;
   procedure Set_AllowEmptyCurrent(aValue: Boolean);
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
   property Tree: InevSimpleTree
     read Get_Tree
     write Set_Tree;
   property Current: Integer
     write Set_Current;
   property ESCPressed: Boolean
     read Get_ESCPressed
     write Set_ESCPressed;
     {* ����, ������������ ��� ������������� �������� ������ ��� ������ ����. }
   property DropTextStyle: Tl3StyleId
     read Get_DropTextStyle
     write Set_DropTextStyle;
   property AllowEmptyCurrent: Boolean
     read Get_AllowEmptyCurrent
     write Set_AllowEmptyCurrent;
 end;//IevDropContainer

implementation

end.