unit evControlParaHotSpot;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevGUIInterfaces
 , nevTools
 , evQueryCardInt
 , l3Variant
 , afwInterfaces
 , l3Units
;

type
 TevControlParaHotSpot = class(Tk2TagTool, IevMouseMoveHandler, IevHotSpot)
  {* ���������� "������� �����" ��� ���������, ��������������� ������� ����� }
  function PtInButton(const aPt: TafwPoint): Boolean;
   {* ������ �� ������ ��������� }
  function PtInCtrButton(const aPt: Tl3Point): Boolean;
   {* ������ �� ������-��������� }
  function PtInPara(const aPt: TafwPoint): Boolean;
  function PtToPara(const aPt: TafwPoint): Tl3Point;
   {* ��������� �� ���������� ��������� � ���������� ��������� }
  procedure TrySendToGroup(aTag: Tl3Variant);
  procedure CheckMapValid(const aView: InevControlView);
  procedure Create(const aMap: InevMap;
   aTagWrap: Tl3Variant);
  function Make(const aMap: InevMap;
   aTagWrap: Tl3Variant): IevHotSpot;
   {* ��������� ����� }
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* ���������� �������� MouseMove, ������������ ��������� }
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
 end;//TevControlParaHotSpot
 
implementation

uses
 l3ImplUses
 , evdTypes
 , SysUtils
 , evControlParaConst
 , evMsgCode
 , k2Tags
 , ControlsBlock_Const
 , evParaTools
;

end.
