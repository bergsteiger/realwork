unit dd_lcBaseHeaderFilter;

interface

uses
  k2TagGen, ddHeaderFilter, ddTypes;

type
 Tdd_lcBaseHeaderFilter = class(TddHeaderFilter)
 private
  f_Category: Integer;
  f_OnError: TddErrorEvent;
 public
  procedure ErrorReaction(const aMsg: AnsiString); overload;
  procedure SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
      aOnError: TddErrorEvent): Pointer; overload;
 end;

implementation

uses
  l3Base;

procedure Tdd_lcBaseHeaderFilter.ErrorReaction(const aMsg: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg, f_Category)
 else
  l3System.Msg2Log(aMsg);
end;

procedure Tdd_lcBaseHeaderFilter.SetOnError(aCategory: Integer; aHandler:
    TddErrorEvent);
begin
 f_Onerror:= aHandler;
 f_Category:= aCategory;
end;

class function Tdd_lcBaseHeaderFilter.SetTo(var theGenerator: Tk2TagGenerator;
    aCategory: Integer; aOnError: TddErrorEvent): Pointer;
var
 l_Filter : Tdd_lcBaseHeaderFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
