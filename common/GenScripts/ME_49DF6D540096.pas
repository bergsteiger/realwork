unit evLeafParaCursor;

interface

uses
 l3IntfUses
 , evParaCursor
 , nevTools
 , nevBase
;

type
 TevLeafParaCursor = class(TevParaCursor, InevLeafPoint)
  function ObjMap(const aView: InevView): TnevFormatInfoPrim;
  function GetPaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
  procedure DoInitPointByPt(const aView: InevView;
   const aPoint: TnevPoint;
   const aMap: InevMap);
  procedure InitPointByPt(const aView: InevView;
   const aPoint: TnevPoint;
   const aMap: InevMap);
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//TevLeafParaCursor
 
implementation

uses
 l3ImplUses
 , evOp
 , SysUtils
;

end.
