unit dd_lcBaseDocFilter;

interface

uses
 k2TagFilter, k2TagGen,
 ddDocumentFilter, ddTypes;

type
 Tdd_lcBaseDocFilter = class(TddDocumentFilter)
 private
  f_OnError: TddErrorEvent;
 public
  procedure ErrorReaction(const aMsg: AnsiString);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aOnError: TddErrorEvent): Pointer; overload;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation

uses
 l3Base;

procedure Tdd_lcBaseDocFilter.ErrorReaction(const aMsg: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg)
 else
  l3System.Msg2Log(aMsg);
end;

class function Tdd_lcBaseDocFilter.SetTo(var theGenerator: Tk2TagGenerator; aOnError: TddErrorEvent):
    Pointer;
var
 l_Filter : Tdd_lcBaseDocFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.OnError:= aOnError;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
