unit afwMeasureCanvas;

interface

uses
 l3IntfUses
 , l3VirtualCanvas
 , afwInterfaces
 , l3InternalInterfaces
 , l3Interfaces
;

type
 TafwMeasureCanvas = class(Tl3VirtualCanvas)
  {* ����� ��� ��������� � ���������� ������� �������. }
  procedure Create(const anExtent: TafwPoint;
   const aCaret: IafwCaret);
  function Make(const anExtent: TafwPoint;
   const aCaret: IafwCaret): Il3Canvas;
 end;//TafwMeasureCanvas
 
implementation

uses
 l3ImplUses
;

end.
