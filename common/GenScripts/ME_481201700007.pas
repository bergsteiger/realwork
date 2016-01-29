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
  {* Область вывода для измерений. }
  procedure Create(const aControl: InevControl);
  function Make(const aControl: InevControl): InevMeasureView;
  function IsCaretInited: Boolean;
  function IsCaretVisible: Boolean;
  procedure CheckShapes;
  procedure MakePointVisible(const aTop: InevAnchor;
   const aPoint: InevBasePoint;
   var thePos: Integer);
   {* Делает так, чтобы курсор был видим на заданном экране }
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
