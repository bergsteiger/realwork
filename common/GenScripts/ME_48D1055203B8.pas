unit evTabStops;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3Interfaces
 , l3Variant
 , l3StringList
 , l3LongintList
 , l3Const
;

type
 TevTabStops = class(Tl3CacheableBase, Il3TabStops)
  {* Позиции табуляции }
  procedure Create(aTabStops: Tl3Variant);
  function Make(aTabStopsHolder: Tl3Variant): Il3TabStops;
  function Clone: Il3TabStops;
   {* клонирует позиции табуляции. }
  function Next: Tl3TabStop;
   {* следующая позиция табуляции. }
  function Filler: Tl3WString;
   {* следующий символ-заполнитель. }
  function Style: Tl3TabStopStyle;
   {* следующий стиль. }
  function NeedCutByTab: Boolean;
  procedure Reset;
 end;//TevTabStops
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , k2Tags
 , k2Base
 , SysUtils
;

end.
