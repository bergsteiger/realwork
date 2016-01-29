unit evDropControl;

interface

uses
 l3IntfUses
 , evEditControl
 , evQueryCardDropControlsInt
 , Controls
 , l3Interfaces
 , nevTools
 , l3Units
 , nevBase
 , Messages
;

type
 TevDropControl = class(TevEditControl, IevDropControl)
  function DropContainer: IevDropContainer;
   {* ���������� ��������� ���������� � ���������� ������� ������ }
  function GetControl: TControl;
  procedure CalcControlPosition(const aView: InevView;
   const aPt0: Tl3Point;
   const aExtend: Tl3Point;
   var aDropPoint: TPoint;
   var aInvert: Boolean;
   var aWidth: Integer);
  function DocumentToScreen(const aPt: Tl3Point): TPoint;
  function DropControlHeigth: Integer;
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* ���������� ���������� ������ �� ��������� ����������� }
  function PtInButton(const aPt: TnevPoint;
   const aMap: InevMap): Boolean;
   {* ������ �� ������ ��������� }
  procedure DoEscPressed;
  procedure DoDropDownCurrentChanged(const aNode: InevSimpleNode);
  procedure DoAfterHideControl;
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
  function Down: Boolean;
   {* ������ �� ������ � ���������. }
  function DropDown(const aView: InevView;
   const aTextPara: InevPara;
   ByUser: Boolean): Boolean;
   {* ��������� ��������� ������ ��� ���������. }
  function Para: InevPara;
  procedure DropDownCurrentChanged(const aNode: InevSimpleNode);
 end;//TevDropControl
 
implementation

uses
 l3ImplUses
 , Windows
 , k2Tags
 , OvcConst
 , Forms
 , nevFacade
 , SysUtils
;

end.
