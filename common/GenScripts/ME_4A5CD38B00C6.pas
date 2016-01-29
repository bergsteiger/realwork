unit nevTextParaViewBounds.imp;

interface

uses
 l3IntfUses
 , nevBase
 , nevTools
;

type
 TnevLineCoord = record
  {* Координаты строки }
 end;//TnevLineCoord
 
 _nevTextParaViewBounds_ = class(MnevViewBounds)
  function GetLC(aSelf: _nevTextParaViewBounds_;
   aMap: TnevFormatInfoPrim): TnevLineCoord;
   {* Возвращает текущую строку }
 end;//_nevTextParaViewBounds_
 
implementation

uses
 l3ImplUses
 , evTextParaTools
 , l3Types
;

end.
