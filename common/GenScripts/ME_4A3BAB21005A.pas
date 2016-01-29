unit nevSolidParaAnchor;

interface

uses
 l3IntfUses
 , nevLeafParaAnchor
 , nevBase
 , nevTools
;

type
 TnevSolidParaAnchor = class(TnevLeafParaAnchor)
  {* якорь листьевого параграфа не имеющего делени€ на строки }
  function GetAtStart: Boolean;
  function GetAtEnd(const aView: InevView): Boolean;
  function GetVertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function GetY: Integer;
  procedure SetY(aValue: Integer);
 end;//TnevSolidParaAnchor
 
implementation

uses
 l3ImplUses
 , nevFacade
 , l3MinMax
;

end.
