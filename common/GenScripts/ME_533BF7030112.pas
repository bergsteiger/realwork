unit vgRemindersLineWithState;

interface

uses
 l3IntfUses
 , vgRemindersLine
;

type
 TvgRemindersLineWithState = class(TvgRemindersLine)
  procedure CheckName;
  function MakeId(const aId: AnsiString): AnsiString;
 end;//TvgRemindersLineWithState
 
implementation

uses
 l3ImplUses
 , afwConsts
 , Types
 , TtfwClassRef_Proxy
;

end.
