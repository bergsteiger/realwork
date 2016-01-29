unit nevTextParaAnchor;

interface

uses
 l3IntfUses
 , nevLeafParaAnchor
 , nevBase
 , nevTools
;

type
 TnevTextParaAnchor = class(TnevLeafParaAnchor)
  function GetAtStart: Boolean;
  function GetAtEnd(const aView: InevView): Boolean;
  function GetVertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function GetLC(aSelf: _nevTextParaViewBounds_;
   aMap: TnevFormatInfoPrim): TnevLineCoord;
   {* Возвращает текущую строку }
  procedure SetLinePrim(aValue: Integer;
   aMap: TnevFormatInfoPrim);
 end;//TnevTextParaAnchor
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , evTextParaTools
 , SysUtils
 , l3Types
;

end.
