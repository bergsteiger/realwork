unit gtStringHash;

interface

uses classes;

type
  TgtIntegerList = Array of Integer;

  TgtStringHash = class
  private
    Buckets: array of TgtIntegerList;
    FItems: TStringList;
    function HashOf(const Key: string): Cardinal;
    procedure Clear;
  public
    constructor Create(Size: Cardinal = 256);
    destructor Destroy; override;
    property Items: TStringList read FItems write FItems;
    function Find(const Key: string;
      ABucketCollisionIndex: Integer = 0): Integer;
  end;

implementation

constructor TgtStringHash.Create(Size: Cardinal);
begin
  inherited Create;
  FItems := TStringList.Create;
  // Adding an empty string here because
  // In the bucket, we need to check if the bucket value points to an index in this list or not
  // But integer's default value is 0. Thus we can't point to 0'th element using the integer unless
  // we init all the integer values to -1. So do not remove this Add()
  FItems.Add('');
  SetLength(Buckets, Size);
end;

destructor TgtStringHash.Destroy;
begin
  Clear;
  inherited;
end;

procedure TgtStringHash.Clear;
begin
  SetLength(Buckets, 0);
  FItems.Free;
end;

function TgtStringHash.Find(const Key: string;
  ABucketCollisionIndex: Integer = 0): Integer;
var
  Hash, BucketValue: Integer;
begin
  // Lets assign default values for result and BucketValue
  BucketValue := 0;
  // Find hash for key
  Hash := HashOf(Key) mod Cardinal(Length(Buckets));
  // If Length of bucket[Hash] is higher than APass then only get Bucketvalue
  if Length(Buckets[Hash]) > ABucketCollisionIndex then
    BucketValue := Buckets[Hash][ABucketCollisionIndex];
  // if BucketValue is 0, then it is new value
  if BucketValue = 0 then
  begin
    FItems.Add(Key);
    Result := FItems.Count - 1;
    SetLength(Buckets[Hash], ABucketCollisionIndex + 1);
    Buckets[Hash][ABucketCollisionIndex] := Result;
  end
  //BucketValue is pointing to an item in List. Verify if its same as Key
  else if FItems[BucketValue] = Key then
    Result := BucketValue
  //Bucket is pointing to different element. So increase the collusion Index and try again
  else
    Result := Find(Key, ABucketCollisionIndex + 1);
end;

function TgtStringHash.HashOf(const Key: string): Cardinal;
var
  I: Integer;
const
  A = 0.6180339887;
begin
  Result := 0;
  for I := 1 to Length(Key) do
    Result := ((Result shl 2) or (Result shr (SizeOf(Result) * 8 - 2)))
      xor Ord(Key[I]);
  Result := Trunc(Length(Buckets) * (Frac(Result * A)));
end;

end.

