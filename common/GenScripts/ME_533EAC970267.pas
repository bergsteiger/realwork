unit vgRemindersLineList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vgRemindersLine
;

type
 TvgRemindersLineList = class(Tl3ProtoDataContainer)
  function Exists: Boolean;
 end;//TvgRemindersLineList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
