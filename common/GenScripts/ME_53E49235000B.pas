unit vtGauge;

interface

uses
 l3IntfUses
 , Gauges
;

type
 TvtGauge = class(TGauge)
  procedure Free(var Dummy: Integer);
   {* Для ловли Free }
 end;//TvtGauge
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
