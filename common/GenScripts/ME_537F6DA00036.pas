unit dtNumRange;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TdtNumRange = class(Tl3ProtoObject)
  {* вспомогательный тип для TNumSet }
  procedure Create(aLowNum: LongWord;
   aHiNum: LongWord);
  function HasIntersectionWith(aRange: TdtNumRange): Boolean;
  procedure JoinWith(aRange: TdtNumRange);
  function Amount: Integer;
 end;//TdtNumRange
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3MinMax
;

end.
