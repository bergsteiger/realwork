unit m3NewStorageStreamPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3NewStorageStreamPrim.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3CommonStorageStream
 , m3StorageBlock
 , m3StoreHeaderDataPrim
 , m3StorageInterfaces
 , Classes
;

type
 Tm3NewStorageStreamPrim = {abstract} class(Tm3CommonStorageStream)
  private
   f_Block: Tm3StorageBlock;
   f_HeaderData: Tm3StoreHeaderDataPrim;
   f_Position: Int64;
  protected
   procedure MoveStreamPointer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoRead(aBuff: Pointer;
    aSize: Integer;
    var theResult: Integer;
    var theReturn: hResult); override;
   procedure DoWrite(aBuff: Pointer;
    aSize: Integer;
    var theResult: Integer;
    var theReturn: hResult); override;
   procedure DoSeek(anOffset: Int64;
    anOrigin: TSeekOrigin;
    var theResult: Int64;
    var theReturn: hResult); override;
   procedure DoSetSize(aSize: Int64;
    var theReturn: hResult); override;
   function DoGetSize: Int64; override;
   function DoGetName: WideString; override;
  public
   constructor Create(anAccess: Tm3StoreAccess;
    aHeaderData: Tm3StoreHeaderDataPrim); reintroduce;
 end;//Tm3NewStorageStreamPrim

implementation

uses
 l3ImplUses
 , Windows
 , l3Base
 , ComObj
 , m2COMLib
 , ActiveX
 , m2S32Lib
 , m2S64Lib
 , SysUtils
 , m2MemLib
 , m3Exceptions
;

procedure Tm3NewStorageStreamPrim.MoveStreamPointer;
//#UC START# *5448F1A501FE_5448F0A40180_var*
var
 l_Next : Tm3StorageBlock;  
//#UC END# *5448F1A501FE_5448F0A40180_var*
begin
//#UC START# *5448F1A501FE_5448F0A40180_impl*
 if f_Block.IsFull then
 begin
  l_Next := f_Block.CreateNext;
  try
   l_Next.SetRefTo(f_Block);
  finally
   FreeAndNil(l_Next);
  end;//try..finally
 end;//f_Block.IsFull
//#UC END# *5448F1A501FE_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.MoveStreamPointer

constructor Tm3NewStorageStreamPrim.Create(anAccess: Tm3StoreAccess;
 aHeaderData: Tm3StoreHeaderDataPrim);
//#UC START# *5448F1C80365_5448F0A40180_var*
//#UC END# *5448F1C80365_5448F0A40180_var*
begin
//#UC START# *5448F1C80365_5448F0A40180_impl*
 Assert((anAccess = m3_saRead) OR (anAccess = m3_saReadWrite) OR
        (anAccess = STGM_READ) OR (anAccess = STGM_READWRITE));
 Assert(aHeaderData <> nil);
 aHeaderData.SetRefTo(f_HeaderData);
 f_Position := 0;
 inherited Create(anAccess, aHeaderData.Stream, aHeaderData.Name);
 f_Block := Tm3StorageBlock.Create(aHeaderData);
 if not Self.ReadOnly then
  if (aHeaderData.Stream.Logger <> nil) then
   aHeaderData.Stream.Logger.ToLog('Получен поток для записи: ' + ClassName + ' имя: ' + aHeaderData.Name.AsString);
//#UC END# *5448F1C80365_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.Create

procedure Tm3NewStorageStreamPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5448F0A40180_var*
//#UC END# *479731C50290_5448F0A40180_var*
begin
//#UC START# *479731C50290_5448F0A40180_impl*
 try
  FreeAndNil(f_Block); 
 finally
  FreeAndNil(f_HeaderData);
  inherited;
 end;//try..finally 
//#UC END# *479731C50290_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.Cleanup

procedure Tm3NewStorageStreamPrim.DoRead(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27CF501C4_5448F0A40180_var*
var
 l_SizeToRead : Integer;
 l_Size : Integer;
//#UC END# *4FA27CF501C4_5448F0A40180_var*
begin
//#UC START# *4FA27CF501C4_5448F0A40180_impl*
 if SUCCEEDED(theReturn) then
 begin
  while (theResult <> aSize) do
  begin
   l_SizeToRead := aSize - theResult;
   l_SizeToRead := m2S64Min(f_HeaderData.RRealSize - f_Position, l_SizeToRead);
   l_Size := f_Block.Read(PANSIChar(aBuff) + theResult, l_SizeToRead);
   if (l_Size = 0) then
    break;
   Inc(theResult, l_Size);
   Inc(f_Position, l_Size);
   MoveStreamPointer;
  end;//while (theResult <> aSize)
 end;//SUCCEEDED(theReturn)
//#UC END# *4FA27CF501C4_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.DoRead

procedure Tm3NewStorageStreamPrim.DoWrite(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27D310344_5448F0A40180_var*
var
 l_SizeToWrite : Integer;
 l_Size : Integer;
//#UC END# *4FA27D310344_5448F0A40180_var*
begin
//#UC START# *4FA27D310344_5448F0A40180_impl*
 Assert(not Self.ReadOnly);
 if SUCCEEDED(theReturn) then
 begin
  while (theResult <> aSize) do
  begin
   l_SizeToWrite := aSize - theResult;
   l_Size := f_Block.Write(PANSIChar(aBuff) + theResult, l_SizeToWrite);
   if (l_Size = 0) then
    break;
   Inc(theResult, l_Size);
   Inc(f_Position, l_Size);
   f_HeaderData.RRealSize := m2S64Max(f_HeaderData.RRealSize, f_Position);
   MoveStreamPointer;
  end;//while (theResult <> aSize)
 end;//SUCCEEDED(theReturn)
//#UC END# *4FA27D310344_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.DoWrite

procedure Tm3NewStorageStreamPrim.DoSeek(anOffset: Int64;
 anOrigin: TSeekOrigin;
 var theResult: Int64;
 var theReturn: hResult);
//#UC START# *4FA27D5302C5_5448F0A40180_var*

 procedure __Seek(const aPosition: Int64;
                  var   theResult: Int64);
 var
  l_Next : Tm3StorageBlock;
  l_BlockIndex : Int64;
 begin//__Seek
  if ((APosition >= 0) and (APosition <= f_HeaderData.RRealSize)) then
  begin
   if (APosition <> f_Position) then
   begin
    l_BlockIndex := APosition div f_HeaderData.Stream.ClusterBodySize;

    if (l_BlockIndex <> f_Block.Index) then
    begin
     if (l_BlockIndex = 0) then
     begin
      FreeAndNil(f_Block);
      f_Block := Tm3StorageBlock.Create(f_HeaderData);
     end//l_BlockIndex = 0
     else
     if (l_BlockIndex > f_Block.Index) then
     begin
      while (l_BlockIndex <> f_Block.Index) do
      begin
       l_Next := f_Block.CreateNext;
       try
        l_Next.SetRefTo(f_Block);
       finally
        FreeAndNil(l_Next);
       end;//try..finally
      end;//l_BlockIndex <> f_Block.Index
     end//l_BlockIndex > f_Block.Index
     else
     if (l_BlockIndex < f_Block.Index) then
     begin
      while (l_BlockIndex <> f_Block.Index) do
      begin
       l_Next := f_Block.CreatePrev;
       try
        l_Next.SetRefTo(f_Block);
       finally
        FreeAndNil(l_Next);
       end;//try..finally
      end;//l_BlockIndex <> f_Block.Index
     end;//l_BlockIndex > f_Block.Index
    end;//l_BlockIndex <> f_Block.Index

    Assert(l_BlockIndex = f_Block.Index);

    f_Block.SetPositionInStream(aPosition);
    f_Position := aPosition;
   end;//APosition <> FPosition
  end//((APosition >= 0) and (APosition <= RRealSize))
  else
   Assert(false, 'Смещаемся за границу потока');
  theResult := f_Position;
 end;//__Seek

//#UC END# *4FA27D5302C5_5448F0A40180_var*
begin
//#UC START# *4FA27D5302C5_5448F0A40180_impl*
 if SUCCEEDED(theReturn) then
 begin
  case anOrigin of
   soBeginning:
    __Seek(anOffset, theResult);
   soCurrent:
    __Seek(anOffset + f_Position, theResult);
   soEnd:
    __Seek(anOffset + f_HeaderData.RRealSize, theResult);
   else
   begin
    Assert(false, 'Неверный anOrigin');
    OleError(E_UNEXPECTED);
   end;//else
  end;//case anOrigin
 end;//SUCCEEDED(theReturn)
//#UC END# *4FA27D5302C5_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.DoSeek

procedure Tm3NewStorageStreamPrim.DoSetSize(aSize: Int64;
 var theReturn: hResult);
//#UC START# *4FA27DCD02B4_5448F0A40180_var*

 procedure __GrowSize(const ASize: Int64);
 const
  CMaxBuffSize = 1024*1024;
 var
  LBuff     : Pointer;
  LBuffSize : LongInt;
  LSize     : Int64;
 begin//__GrowSize
  LSize := ASize;
  LBuffSize := LongInt(m2S64Min(LSize, CMaxBuffSize));
  m2MEMAlloc(LBuff, LBuffSize, 0);
  try
   while (LSize <> 0) do
   begin
    LBuffSize := LongInt(m2S64Min(LSize, Int64(LBuffSize)));
    m2COMWriteBuffer(Self, LBuff^, LBuffSize);
    Dec(LSize, LBuffSize);
   end;//LSize <> 0
  finally
   m2MEMFree(LBuff);
  end;//try..finally
 end;//__GrowSize

 procedure __ReduceSize(const ASize: Int64);
 var
  l_Pos : Int64;
 begin//__ReduceSize
  m2COMSeek(Self, aSize, STREAM_SEEK_SET);
  if (f_Position = 0) then
  begin
   FreeAndNil(f_Block);
   l_Pos := f_HeaderData.FirstCluster;
   f_HeaderData.Stream.RemoveTOCBuffData(l_Pos);
   f_HeaderData.FirstCluster := l_Pos;
   f_Block := Tm3StorageBlock.Create(f_HeaderData);
  end//f_Position = 0
  else
  begin
   l_Pos := f_Block.NextPosition;
   f_HeaderData.Stream.RemoveTOCBuffData(l_Pos);
   f_Block.NextPosition := l_Pos;
  end;//f_Position = 0
  f_HeaderData.RRealSize := f_Position;
 end;//__ReduceSize

var
 l_Size : Int64;
//#UC END# *4FA27DCD02B4_5448F0A40180_var*
begin
//#UC START# *4FA27DCD02B4_5448F0A40180_impl*
 Assert(not Self.ReadOnly);
 if SUCCEEDED(theReturn) then
 begin
  l_Size := m2COMSeek(Self, 0, STREAM_SEEK_END);
  if (l_Size < ASize) then
   __GrowSize(ASize - l_Size)
  else
  if (l_Size > ASize) then
   __ReduceSize(ASize);
 end;//SUCCEEDED(theReturn)
//#UC END# *4FA27DCD02B4_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.DoSetSize

function Tm3NewStorageStreamPrim.DoGetSize: Int64;
//#UC START# *4FA2802E0231_5448F0A40180_var*
//#UC END# *4FA2802E0231_5448F0A40180_var*
begin
//#UC START# *4FA2802E0231_5448F0A40180_impl*
 Result := f_HeaderData.RRealSize;
//#UC END# *4FA2802E0231_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.DoGetSize

function Tm3NewStorageStreamPrim.DoGetName: WideString;
//#UC START# *5412FB880320_5448F0A40180_var*
//#UC END# *5412FB880320_5448F0A40180_var*
begin
//#UC START# *5412FB880320_5448F0A40180_impl*
 Result := f_HeaderData.Name.AsWideString;
//#UC END# *5412FB880320_5448F0A40180_impl*
end;//Tm3NewStorageStreamPrim.DoGetName

end.
