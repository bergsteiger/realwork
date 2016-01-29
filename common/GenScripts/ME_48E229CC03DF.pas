unit evEditorWindowHotSpot;

interface

uses
 l3IntfUses
 , l3Tool
 , nevGUIInterfaces
 , nevTools
 , nevBase
 , l3Interfaces
 , l3Base
 , afwInterfaces
 , l3IID
;

type
 TevForeignHotSpotMode = (
  ev_fhsmNone
  , ev_fhsmDisabled
  , ev_fhsmEnabled
 );//TevForeignHotSpotMode
 
 TevEditorWindowHotSpot = class(Tl3Tool, IevAdvancedHotSpot, IevHotSpot)
  procedure DoBeforeSelection(const aView: InevControlView);
   {* ���������� ����� ������ ��������� }
  function NeedSelectCursor(const aView: InevControlView;
   const aPt: TnevPoint): Boolean;
   {* ��������� ������������ ��������� ��� �������� ���� �, ����
             ��������� ������������� �� ��������� ���������-�������, ��
             ������������ � ����������� � DoBeforeSelection ����� }
  function CheckCursorPos(const aView: InevView): Boolean;
   {* ���������� ��� �������� ���������������� ������� �/��� ���������
             ���������. ����������� ����� ���������� ������ ����, ����
             ���������� �� ���� ����������� ����� �������� }
  function DoLButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  function DoLButtonDown(const aView: InevControlView;
   const aKeys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  procedure Create(const anOwner: Il3ToolOwner;
   const aForeignHotSpot: IevHotSpot);
  function Make(const anOwner: Il3ToolOwner;
   const aForeignHotSpot: IevHotSpot): IevHotSpot;
  function DoMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState): Boolean;
   {* ������������ �������� ����, ����� ������� ����� ������ }
  function TryDragDrop(const aKeys: TevMouseState): Boolean;
  procedure TranslatePt(const aView: InevControlView;
   const aKeys: TevMouseState);
   {* ����������� ����� aPt � ClickCursor ��� StartMark.
             ���� ������������� � StartMark, �� FinishMark = ClickCursor }
  procedure AlignMarks(const aView: InevControlView;
   const aKeys: TevMouseState);
   {* "�����������" StartMark � FinishMark - �������� �� ������� ����� }
  procedure ExtendBlock(const aView: InevControlView);
   {* ������������� StartMark � FinishMark � ��������� }
  procedure DoExtendBlock(const aView: InevControlView;
   const aSelection: InevSelection);
   {* ������������� StartMark � FinishMark � ��������� }
  function DoLButtonUp(const aView: InevControlView;
   const aKeys: TevMouseState;
   aNeedUnselect: Boolean): Boolean;
   {* ������������ ���������� ����� ������ ���� }
  function BeginMouseOp(const aView: InevControlView;
   out theSelection: Tl3Base): InevOp;
   {* ������ ����������� ������. ��� �������� ������ ���� ���������� OpPack.
             theSelection - ������, ���������� ���������, ��� ���� �����������
             ���������� l3Free � ������ finally }
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
  function MouseMove(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ����������� ���� }
  function LButtonDown(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� ����� ������ ���� }
  function LButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ����� ������ ���� }
  function LButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� ������� ����� ������ ���� }
  function RButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ������� ������ ������ ���� }
  function RButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ������ ������� ���� }
  function MButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ������� ������ ���� }
  function MButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ������ ���� }
  function CanDrag: Boolean;
 end;//TevEditorWindowHotSpot
 
implementation

uses
 l3ImplUses
 , evCustomEditorWindow
 , evTypes
 , l3InternalInterfaces
 , evMsgCode
 , evDataObject
 , SysUtils
 , evOp
 , evExcept
 , Classes
 , l3Variant
;

end.
