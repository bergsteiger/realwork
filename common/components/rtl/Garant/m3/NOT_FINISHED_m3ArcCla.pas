unit NOT_FINISHED_m3ArcCla;

// Модуль: "w:\common\components\rtl\Garant\m3\NOT_FINISHED_m3ArcCla.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseArcStream
;

type
 Tm3ArcInflateStream = {abstract} class(Tm3BaseArcStream)
 end;//Tm3ArcInflateStream

 Tm3ArcDeflateStream = {abstract} class(Tm3BaseArcStream)
 end;//Tm3ArcDeflateStream

 Tm3LZOInflateStream = class(Tm3ArcInflateStream)
 end;//Tm3LZOInflateStream

 Tm3LZODeflateStream = class(Tm3ArcDeflateStream)
 end;//Tm3LZODeflateStream

implementation

uses
 l3ImplUses
 , m3ArcHandle
 , m3ArcHandleList
;

end.
