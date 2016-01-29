unit csNonEditableDictsRequest;

interface

uses CsDataPipe, csRequestTask;

{$IFDEF RemoteDict}
type
 TddNonEditableDictsRequest = class(TddRequestTask)
 private
  f_DictsMask: LongInt;
 public
  procedure Communicate(aPipe: TCsDataPipe); override;
  property DictsMask: LongInt read f_DictsMask write f_DictsMask;
 end;
{$EndIF RemoteDict} 

implementation

{$IFDEF RemoteDict}
procedure TddNonEditableDictsRequest.Communicate(aPipe: TCsDataPipe);
begin
 inherited;
 f_DictsMask := aPipe.ReadInteger;
end;
{$EndIF RemoteDict}

end.
