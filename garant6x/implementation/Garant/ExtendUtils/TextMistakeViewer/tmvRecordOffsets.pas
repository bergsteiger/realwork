unit tmvRecordOffsets;

interface

uses
 l3CacheableBase,

 tmvInterfaces
 ;

type
 TtmvRecordOffsets = class(Tl3CacheableBase, ItmvRecordOffsets)
 private
  f_StartOffset: int64;
  f_EndOffset: int64;
 protected
  //ItmvRecordOffsets
  function pm_GetStartOffset: Int64;
    {-}
  function pm_GetEndOffset: Int64;
    {-}
 protected
  procedure cleanup;
   override;  
 public
  constructor Create(aStart, aEnd: int64);
   reintroduce;
    {-}
  class function Make(aStart, aEnd: int64): ItmvRecordOffsets;
    {-}
 end;//TtmvRecordOffsets

implementation

uses
 l3Base
 ;

{ TtmvRecordOffsets }

procedure TtmvRecordOffsets.cleanup;
begin
  inherited;
end;

constructor TtmvRecordOffsets.Create(aStart, aEnd: int64);
begin
 inherited Create;
 f_StartOffset := aStart;
 f_EndOffset := aEnd;
end;

class function TtmvRecordOffsets.Make(aStart,
  aEnd: int64): ItmvRecordOffsets;
var
 l_Instance: TtmvRecordOffsets;
begin
 l_Instance := TtmvRecordOffsets.Create(aStart, aEnd);
 try
  Result := l_Instance;
 finally
  l3Free(l_Instance);
 end;
end;

function TtmvRecordOffsets.pm_GetEndOffset: Int64;
begin
 Result := f_EndOffset;
end;

function TtmvRecordOffsets.pm_GetStartOffset: Int64;
begin
 Result := f_StartOffset;
end;

end.
