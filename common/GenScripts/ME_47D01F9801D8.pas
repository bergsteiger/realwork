unit evControlContainerEX;

interface

uses
 l3IntfUses
 , evControlContainer
 , evQueryCardDropControlsInt
 , evDropCalendar
 , evDropTree
 , l3Core
 , ImgList
 , nevBase
 , Controls
 , l3Interfaces
 , nevTools
 , Types
 , l3Variant
 , Messages
;

type
 TevControlContainerEX = class(TevControlContainer, IevDropContainer)
  procedure UpdateMask;
   {* ��������� �����. }
  function FormatSettingsChange(var Message: TMessage): Boolean;
   {* ���������� ��������� ������� ����. }
  procedure UpdateFormat;
   {* ��������� ������ ����. }
  procedure NeedCloseTree(Sender: TObject);
  procedure CancelDate(Sender: TObject);
   {* ���������� ������ �� ������ ����. }
  function DoGetItemImage(Sender: TObject;
   Index: Integer;
   var aImages: TCustomImageList): Integer;
  procedure ChooseNode(Sender: TObject;
   const Value: InevSimpleNode);
  procedure StartSize(Sender: TObject);
  procedure EndSize(Sender: TObject);
  function OwnerAssigned: Boolean;
  procedure TreeCurrentChanged(Sender: TObject;
   aNewCurrent: Integer;
   aOldCurrent: Integer);
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
  function Tree: InevSimpleTree;
  function Current: Integer;
  function IsSameTreeRoot(const aRoot: InevNode): Boolean;
  procedure DropControlChanging;
  procedure DropControlChanged;
  function GetCurrentNode: InevSimpleNode;
  function IsSimpleTree: Boolean;
  function ESCPressed: Boolean;
   {* ����, ������������ ��� ������������� �������� ������ ��� ������ ����. }
  procedure DoHideDroppedControl(CanSetFocus: Boolean);
  function DoMouseWheel(aDown: Boolean): Boolean;
  function DropTextStyle: Tl3StyleId;
  function AllowEmptyCurrent: Boolean;
 end;//TevControlContainerEX
 
implementation

uses
 l3ImplUses
 , l3Date
 , Forms
 , SysUtils
 , l3ImageList
 , evQueryCardInt
 , l3Base
 , l3ControlsTypes
 , k2Tags
 , Classes
 , evdTypes
 , Windows
 , l3String
 , LeafPara_Const
 , l3Defaults
 , Graphics
;

end.
