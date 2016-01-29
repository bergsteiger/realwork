unit nevMeasureView;

interface

uses
 l3IntfUses
 , nevVirtualView
 , nevTools
 , afwInterfaces
 , nevBase
;

type
 TnevMeasureView = class(TnevVirtualView, InevMeasureView)
  {* ������� ������ ��� ���������. }
  procedure Create(const aControl: InevControl);
  function Make(const aControl: InevControl): InevMeasureView;
  function IsCaretInited: Boolean;
  function IsCaretVisible: Boolean;
  procedure CheckShapes;
  procedure MakePointVisible(const aTop: InevAnchor;
   const aPoint: InevBasePoint;
   var thePos: Integer);
   {* ������ ���, ����� ������ ��� ����� �� �������� ������ }
 end;//TnevMeasureView
 
implementation

uses
 l3ImplUses
 , afwMeasureCanvas
 , SysUtils
 , nevFacade
 , afwVirtualCaret
 , l3MinMax
 , l3Units
;

end.
