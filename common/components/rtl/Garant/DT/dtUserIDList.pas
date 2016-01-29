unit dtUserIDList;

interface

uses
  l3CardinalList,
  Classes,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;

type
  _l3Storable_Parent_ = Tl3CardinalList;
  {$Include ..\L3\l3Storable.imp.pas}
  TdtUserIDList = class(_l3Storable_)
  protected
  // realized methods
    procedure SaveToStream(aStream: TStream); override; // can raise El3Exception
      {* Сохраняет в поток. }
    procedure LoadFromStream(aStream: TStream;
     aNeedSort: Boolean); override; // can raise El3Exception
      {* Загружает из потока. }
  public
    procedure Load(aStream: TStream);
    procedure Save(aStream: TStream);
  end;

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils,
  l3Stream,
  dt_types
  ;

type _Instance_R_ = TdtUserIDList;

{$Include ..\L3\l3Storable.imp.pas}

{ TdtUserIDList }

procedure TdtUserIDList.Load(aStream: TStream);
var
 l_Size : Longint;
 l_Count : Long;
begin
 with aStream do
 begin
  aStream.Read(l_Count, SizeOf(l_Count));
  Count := l_Count;
  if Count > 0 then
  begin
   l_Size := Count*SizeOf(Longint);
   Read(ItemSlot(0)^, l_Size);
   if Sorted then Sort;
  end; // Count > 0
 end;//with aStream
end;

procedure TdtUserIDList.LoadFromStream(aStream: TStream;
  aNeedSort: Boolean);

 procedure LoadFromStreamError;
 begin
  raise El3Exception.Create('Длина потока не кратна размеру элемента');
 end;

var
 l_Size : Longint;

begin
 with aStream do
 begin
  l_Size := Size - Position;
  if (l_Size > 0) then
  begin
   if (l_Size mod SizeOf(LongInt) <> 0) then
    LoadFromStreamError
   else
   begin
    Count := l_Size div SizeOf(LongInt);
    Read(ItemSlot(0)^, l_Size);
    if Sorted and aNeedSort then Sort;
   end;//l_Size mod SizeOf(LongInt)..
  end;//l_Size > 0
 end;//with aStream
end;

procedure TdtUserIDList.Save(aStream: TStream);
var
 l_Count: Long;
begin
 l_Count := Count;
 aStream.Write(l_Count, SizeOf(l_Count));
 SaveToStream(aStream);
end;

procedure TdtUserIDList.SaveToStream(aStream: TStream);

 function _WriteUserID(aWord: PObject; anIndex: Long): Bool;
 begin
  Result := true;
  aStream.Write(PUserID(aWord)^, SizeOf(PUserID(aWord)^));
 end;

begin
 IterateAllF(l3L2IA(@_WriteUserID));
end;

end.
