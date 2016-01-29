unit nevLeafParaAnchor;

interface

uses
 l3IntfUses
 , nevAnchor
 , nevTools
 , nevBase
;

type
 TnevLeafParaAnchor = class(TnevAnchor, InevLeafPoint)
  {* ����� ��� ��������� ���������� }
  function ObjMap(const aView: InevView): TnevFormatInfoPrim;
  function GetPaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
  procedure InitPointByPt(const aView: InevView;
   const aPoint: TnevPoint;
   const aMap: InevMap);
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//TnevLeafParaAnchor
 
implementation

uses
 l3ImplUses
;

end.
