unit m3StorageBlock;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StorageBlock.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::m3::m3CoreObjects::m3StorageBlock
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3_String,
  l3Memory,
  l3CProtoObject,
  m3StoreHeaderDataPrim,
  m3RootStreamManagerPrimPrim,
  m3FileRegion
  ;

type
 Tm3StorageBlockHeaderData = packed record
//#UC START# *544F7C6800E1publ*
   rNextPosition: Int64;
     {* - следующий блок. }
   rPrevPosition: Int64;
     {* - предыдущий блок. }
//#UC END# *544F7C6800E1publ*
 end;//Tm3StorageBlockHeaderData

const
  { Defaults }
 m3ClusterSize = 256;

type
 Tm3StorageBlockHeader = packed record
   rData : Tm3StorageBlockHeaderData;
//#UC START# *5411C56D039Cpubl*
   {$IfDef m3ClusterHasCRC}
   rBodyCRC: LongInt;
   {$EndIf m3ClusterHasCRC}
     {* - контрольная сумма. }
//#UC END# *5411C56D039Cpubl*
 end;//Tm3StorageBlockHeader

 Tm3LockedRegion = record
   rForRead : Boolean;
   rRegion : Tm3FileRegion;
 end;//Tm3LockedRegion

 Rm3StorageBlock = class of Tm3StorageBlock;

 Tm3StorageBlock = class(Tl3CProtoObject)
 private
 // private fields
   rHeader : Tm3StorageBlockHeader;
   f_BufferModified : Boolean;
   f_Body : PANSIChar;
   f_Manager : Tm3RootStreamManagerPrimPrim;
   f_HeaderData : Tm3StoreHeaderDataPrim;
   f_IsReadOnly : Boolean;
   f_PrevBlock : Tm3StorageBlock;
   f_Offset : Int64;
   rHeaderCompare : Tm3StorageBlockHeaderData;
   f_Position : Int64;
    {* Поле для свойства Position}
   f_Name : Tl3_String;
    {* Поле для свойства Name}
   f_Index : Int64;
    {* Поле для свойства Index}
 protected
 // property methods
   function pm_GetNextPosition: Int64;
   procedure pm_SetNextPosition(aValue: Int64);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   procedure Save;
   function Modified: Boolean;
   procedure Load;
   function LockData(aForRead: Boolean): Tm3LockedRegion;
   procedure UnlockData(const aPrevRegion: Tm3LockedRegion);
   function CheckBody: PANSIChar;
   function HeaderModified: Boolean;
   constructor CreatePrim(aManager: Tm3RootStreamManagerPrimPrim;
     aName: Tl3_String;
     aReadOnly: Boolean;
     aPosition: Int64;
     aPrevBlock: Tm3StorageBlock;
     anIndex: Int64);
 public
 // public methods
   constructor Create(aHeaderData: Tm3StoreHeaderDataPrim); reintroduce;
   function CreatePrev: Tm3StorageBlock;
   function Read(aBuffer: PANSIChar;
     aSizeToRead: Integer): Integer;
   function Write(aBuffer: PANSIChar;
     aSizeToWrite: Integer): Integer;
   function IsFull: Boolean;
   function CreateNext: Tm3StorageBlock;
   procedure SetPositionInStream(aPosition: Int64);
 protected
 // protected properties
   property Position: Int64
     read f_Position;
 public
 // public properties
   property Name: Tl3_String
     read f_Name;
   property Index: Int64
     read f_Index;
   property NextPosition: Int64
     read pm_GetNextPosition
     write pm_SetNextPosition;
 end;//Tm3StorageBlock

function Tm3LockedRegion_C(aForRead: Boolean;
     const aRegion: Tm3FileRegion): Tm3LockedRegion;

var
   m3TOCBuffers : Pl3MemoryChain;

implementation

uses
  m3Exceptions,
  m2MemLib,
  SysUtils,
  m2S32Lib,
  m2S64Lib,
  ComObj,
  Windows,
  l3Base
  ;

// start class Tm3StorageBlock

constructor Tm3StorageBlock.Create(aHeaderData: Tm3StoreHeaderDataPrim);
//#UC START# *5413163101BA_5411C58501E2_var*
//#UC END# *5413163101BA_5411C58501E2_var*
begin
//#UC START# *5413163101BA_5411C58501E2_impl*
 Assert(aHeaderData <> nil);
 aHeaderData.SetRefTo(f_HeaderData);
 CreatePrim(aHeaderData.Stream, aHeaderData.Name, aHeaderData.IsReadOnly, aHeaderData.FirstCluster, nil, 0);
//#UC END# *5413163101BA_5411C58501E2_impl*
end;//Tm3StorageBlock.Create

procedure Tm3StorageBlock.Save;
//#UC START# *5444F8D6030E_5411C58501E2_var*
var
 l_IsNew : Boolean;
 l_PrevRegion : Tm3LockedRegion; 
//#UC END# *5444F8D6030E_5411C58501E2_var*
begin
//#UC START# *5444F8D6030E_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(f_Manager <> nil);
 Assert(not Self.f_IsReadOnly);
 if Self.Modified then
 begin
  f_Manager.Lock;
  try
   l_IsNew := false;

   if (Self.Position = -1) then
   begin
    l_IsNew := true;
    Self.f_Position := f_Manager.AllocNewCluster;
   end;//Self.Position = -1

   Assert(Self.Position >= 0);
   l_PrevRegion := Self.LockData(false);
   try
    if l_IsNew OR HeaderModified then
     f_Manager.WriteData(Self.Position, Self.rHeader, SizeOf(Self.rHeader));
    if (Self.f_Body <> nil) then
    begin
     if Self.f_BufferModified then
      f_Manager.WriteData(Self.Position + SizeOf(Self.rHeader), Self.f_Body^, f_Manager.ClusterBodySize)
     else
      Assert(not l_IsNew);
    end//Self.f_Body <> nil
    else
    begin
     Assert(not f_BufferModified);
     Assert(not l_IsNew);
    end;//Self.f_Body <> nil
   finally
    Self.UnlockData(l_PrevRegion);
   end;//try..finally

   if l_IsNew then
   begin
    if (Self.rHeader.rData.rPrevPosition <> -1) then
    begin
     Assert(Self.Index > 0);
     Assert(f_PrevBlock <> nil);
     Assert(f_PrevBlock.NextPosition = -1, 'Следующая позиция предыдущего блока уже инициализирована');
     f_PrevBlock.NextPosition := Self.Position;
     FreeAndNil(f_PrevBlock);
     // - отпускаем предыдущий блок, т.к. он нам уже не нужен
     // - тут в ПРЕДЫДУЩИЙ блок пишем указатель на СЕБЯ
    end//Self.rData.rPrevPosition <> -1
    else
    begin
     Assert(Self.Index = 0);
     Assert(f_HeaderData <> nil);
     f_HeaderData.FirstCluster := Self.Position;
     // - тут в заголовок потока пишем указатель на СЕБЯ
     //   вообще говоря - нехило бы наверное заголовок СРАЗУ сохранить
    end;//Self.rHeader.rData.rPrevPosition <> -1
   end;//l_IsNew

   Self.rHeaderCompare := Self.rHeader.rData;
   Self.f_BufferModified := false;
  finally
   f_Manager.Unlock;
  end;//try..finally
 end;//Self.Modified
//#UC END# *5444F8D6030E_5411C58501E2_impl*
end;//Tm3StorageBlock.Save

function Tm3StorageBlock.Modified: Boolean;
//#UC START# *54450FC60393_5411C58501E2_var*
//#UC END# *54450FC60393_5411C58501E2_var*
begin
//#UC START# *54450FC60393_5411C58501E2_impl*
 Result := Self.f_BufferModified OR Self.HeaderModified;
//#UC END# *54450FC60393_5411C58501E2_impl*
end;//Tm3StorageBlock.Modified

procedure Tm3StorageBlock.Load;
//#UC START# *54464CDE02A7_5411C58501E2_var*
var
 l_PrevRegion : Tm3LockedRegion;
//#UC END# *54464CDE02A7_5411C58501E2_var*
begin
//#UC START# *54464CDE02A7_5411C58501E2_impl*
 Assert(f_Manager <> nil);
 Assert(Self.Position >= 0);
 f_Manager.Lock;
 try
  l_PrevRegion := Self.LockData(true);
  try
   f_Manager.ReadData(Self.Position, Self.rHeader, SizeOf(Self.rHeader));
   if (Self.f_Body <> nil) then
    f_Manager.ReadDataAtCurrent(Self.f_Body^, f_Manager.ClusterBodySize);
   Self.rHeaderCompare := Self.rHeader.rData;
   Self.f_BufferModified := false;
  finally
   Self.UnlockData(l_PrevRegion);
  end;//try..finally
 finally
  f_Manager.Unlock;
 end;//try..finally

 Em3InvalidStreamPos.Check(f_Manager.IsValidLink,
                           Self.Name,
                           Self.rHeader.rData.rPrevPosition);
 Em3InvalidStreamPos.Check(f_Manager.IsValidLink,
                           Self.Name,
                           Self.rHeader.rData.rNextPosition);
//#UC END# *54464CDE02A7_5411C58501E2_impl*
end;//Tm3StorageBlock.Load

function Tm3StorageBlock.LockData(aForRead: Boolean): Tm3LockedRegion;
//#UC START# *544775240322_5411C58501E2_var*

 procedure DoLock(const aRegion: Tm3FileRegion);
 begin//DoLock
  if aForRead then
   f_Manager.LockRegion(aForRead, aRegion)
  else
  begin
   while true do
   begin
    try
     f_Manager.LockRegion(aForRead, aRegion);
    except
     on E: EOleSysError do
     begin
      if (E.ErrorCode = STG_E_LOCKVIOLATION) then
      begin
       l3System.Msg2Log('Попытка залочки данных');
       continue;
      end//E.ErrorCode = STG_E_LOCKVIOLATION
      else
       raise;
     end;//on E: EOleSysError
    end;//try..except 
    break;
   end;//while true
  end;//aForRead
 end;//DoLock
 
//#UC END# *544775240322_5411C58501E2_var*
begin
//#UC START# *544775240322_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(Self.Position >= 0);
 Assert(f_Manager <> nil);
 if (Self.f_Body = nil) then
  Result := Tm3LockedRegion_C(aForRead, Tm3FileRegion_C(Self.Position, f_Manager.ClusterHeaderSize))
 else
  Result := Tm3LockedRegion_C(aForRead, Tm3FileRegion_C(Self.Position, f_Manager.ClusterSize));
 DoLock(Result.rRegion); 
//#UC END# *544775240322_5411C58501E2_impl*
end;//Tm3StorageBlock.LockData

procedure Tm3StorageBlock.UnlockData(const aPrevRegion: Tm3LockedRegion);
//#UC START# *544775440281_5411C58501E2_var*
//#UC END# *544775440281_5411C58501E2_var*
begin
//#UC START# *544775440281_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(Self.Position >= 0);
 Assert(f_Manager <> nil);
 f_Manager.UnlockRegion(aPrevRegion.rForRead, aPrevRegion.rRegion);
//#UC END# *544775440281_5411C58501E2_impl*
end;//Tm3StorageBlock.UnlockData

function Tm3StorageBlock.CreatePrev: Tm3StorageBlock;
//#UC START# *5447879403DD_5411C58501E2_var*
//#UC END# *5447879403DD_5411C58501E2_var*
begin
//#UC START# *5447879403DD_5411C58501E2_impl*
 Assert(Self.Index > 0);
 Assert(Self.rHeader.rData.rPrevPosition >= 0);
 if (f_PrevBlock <> nil) then
 begin
  Result := f_PrevBlock.Use;
 end//f_PrevBlock <> nil
 else
 begin
  Assert(Self.Position >= 0);
  Result := Rm3StorageBlock(Self.ClassType).CreatePrim(f_Manager,
                                                      Name,
                                                      Self.f_IsReadOnly,
                                                      Self.rHeader.rData.rPrevPosition,
                                                      nil,
                                                      Self.Index - 1);
 end;//f_PrevBlock <> nil
//#UC END# *5447879403DD_5411C58501E2_impl*
end;//Tm3StorageBlock.CreatePrev

function Tm3StorageBlock.CheckBody: PANSIChar;
//#UC START# *544A1524017E_5411C58501E2_var*
var
 l_Reg : Tm3LockedRegion;
//#UC END# *544A1524017E_5411C58501E2_var*
begin
//#UC START# *544A1524017E_5411C58501E2_impl*
 Assert(f_Manager <> nil); 
 if (Self.f_Body = nil) then
 begin
  Assert(not Self.f_BufferModified);
  f_Manager.Lock;
  try
   m3TOCBuffers^.AllocItemZ(Pointer(Self.f_Body), f_Manager.ClusterBodySize);
   if (Self.Position <> -1) then
   // - иначе нечего читать, видимо это НОВЫЙ блок, который только начинают писать
   begin
    Assert(Self.Position >= 0);
    try
     l_Reg := Self.LockData(true);
    except
     m3TOCBuffers^.FreeItem(Pointer(Self.f_Body));
     // - чтобы ненароком мусор не сохранить
     raise;
    end;//try..except
    try
     f_Manager.ReadData(Self.Position + SizeOf(Self.rHeader), Self.f_Body^, f_Manager.ClusterBodySize);
    finally
     Self.UnlockData(l_Reg);
    end;//try..finally
   end;//Self.Position <> -1
  finally
   f_Manager.Unlock;
  end;//try..finally
 end;//Self.f_Body = nil
 Assert(Self.f_Body <> nil);
 Result := Self.f_Body;
 Result := Result + Self.f_Offset;
//#UC END# *544A1524017E_5411C58501E2_impl*
end;//Tm3StorageBlock.CheckBody

function Tm3StorageBlock.HeaderModified: Boolean;
//#UC START# *544A6E4A021A_5411C58501E2_var*
//#UC END# *544A6E4A021A_5411C58501E2_var*
begin
//#UC START# *544A6E4A021A_5411C58501E2_impl*
 Result := (Self.rHeader.rData.rPrevPosition <> Self.rHeaderCompare.rPrevPosition) OR
           (Self.rHeader.rData.rNextPosition <> Self.rHeaderCompare.rNextPosition);
//#UC END# *544A6E4A021A_5411C58501E2_impl*
end;//Tm3StorageBlock.HeaderModified

function Tm3StorageBlock.Read(aBuffer: PANSIChar;
  aSizeToRead: Integer): Integer;
//#UC START# *544F498B01DC_5411C58501E2_var*
var
 l_Body : PANSIChar;
//#UC END# *544F498B01DC_5411C58501E2_var*
begin
//#UC START# *544F498B01DC_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(f_Manager <> nil);
 Assert(aSizeToRead >= 0);
 Result := m2S32Min(f_Manager.ClusterBodySize - Self.f_Offset, aSizeToRead);
 Assert(Result >= 0);
 if (Result > 0) then
 begin
  l_Body := Self.CheckBody;
  m2MEMCopy(aBuffer, l_Body, Result);
  Inc(Self.f_Offset, Result);
 end;//Result > 0
 Assert(Self.f_Offset <= f_Manager.ClusterBodySize, 'Не можем перепрыгивать через кластеры');
//#UC END# *544F498B01DC_5411C58501E2_impl*
end;//Tm3StorageBlock.Read

function Tm3StorageBlock.Write(aBuffer: PANSIChar;
  aSizeToWrite: Integer): Integer;
//#UC START# *544F49CF014E_5411C58501E2_var*
var
 l_Body : PANSIChar;
//#UC END# *544F49CF014E_5411C58501E2_var*
begin
//#UC START# *544F49CF014E_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(f_Manager <> nil);
 Assert(aSizeToWrite >= 0);
 Result := m2S32Min(f_Manager.ClusterBodySize - Self.f_Offset, aSizeToWrite);
 Assert(Result >= 0);
 if (Result > 0) then
 begin
  l_Body := Self.CheckBody;
  //Self.f_BufferModified := true;
  if not Self.f_BufferModified then
  begin
   if (Self.Position = -1) then
    Self.f_BufferModified := true
    // - чтобы при выходе записать новые кластера
   else
    Self.f_BufferModified := m2MEMCompare(l_Body, aBuffer, Result) <> 0;
  end;//not Self.f_BufferModified
  m2MEMCopy(l_Body, aBuffer, Result);
  Inc(Self.f_Offset, Result);
 end;//Result > 0
 Assert(Self.f_Offset <= f_Manager.ClusterBodySize, 'Не можем перепрыгивать через кластеры');
//#UC END# *544F49CF014E_5411C58501E2_impl*
end;//Tm3StorageBlock.Write

function Tm3StorageBlock.IsFull: Boolean;
//#UC START# *544F51F9003F_5411C58501E2_var*
//#UC END# *544F51F9003F_5411C58501E2_var*
begin
//#UC START# *544F51F9003F_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(f_Manager <> nil);
 Result := (Self.f_Offset >= f_Manager.ClusterBodySize);
//#UC END# *544F51F9003F_5411C58501E2_impl*
end;//Tm3StorageBlock.IsFull

function Tm3StorageBlock.CreateNext: Tm3StorageBlock;
//#UC START# *54465535030A_5411C58501E2_var*
//#UC END# *54465535030A_5411C58501E2_var*
begin
//#UC START# *54465535030A_5411C58501E2_impl*
 if (Self.Position = -1) then
  if Self.Modified then
   Self.Save;
 Assert(Self.Position >= 0);
 Result := Rm3StorageBlock(Self.ClassType).CreatePrim(f_Manager,
                                                      Name,
                                                      Self.f_IsReadOnly,
                                                      Self.NextPosition,
                                                      Self,
                                                      Self.Index + 1);
//#UC END# *54465535030A_5411C58501E2_impl*
end;//Tm3StorageBlock.CreateNext

constructor Tm3StorageBlock.CreatePrim(aManager: Tm3RootStreamManagerPrimPrim;
  aName: Tl3_String;
  aReadOnly: Boolean;
  aPosition: Int64;
  aPrevBlock: Tm3StorageBlock;
  anIndex: Int64);
//#UC START# *5446556801C7_5411C58501E2_var*
var
 l_PrevPosition : Int64;
//#UC END# *5446556801C7_5411C58501E2_var*
begin
//#UC START# *5446556801C7_5411C58501E2_impl*
 Self.rHeaderCompare := Self.rHeader.rData;
 Self.f_BufferModified := false;
 Assert(anIndex >= 0);
 Assert((anIndex > 0) OR (f_HeaderData <> nil));
 Assert(aPosition >= -1);
 if (aPrevBlock = nil) then
  l_PrevPosition := -1
 else
  l_PrevPosition := aPrevBlock.Position; 
 Assert(l_PrevPosition >= -1);
 Assert({(f_HeaderData <> nil)} (anIndex = 0) OR (l_PrevPosition >= 0) OR ((aPrevBlock = nil) AND (aPosition >= 0)));
 Assert(aManager <> nil);
 Assert(aName <> nil);
 f_Offset := 0;
 f_Index := anIndex;
 f_IsReadOnly := aReadOnly;
 aManager.SetRefTo(f_Manager);
 aName.SetRefTo(f_Name);
 aPrevBlock.SetRefTo(f_PrevBlock);
 inherited Create;
 rHeader.rData.rPrevPosition := l_PrevPosition;
 rHeader.rData.rNextPosition := -1;
 {$IfDef m3ClusterHasCRC}
 rHeader.rBodyCRC := 0;
 {$EndIf m3ClusterHasCRC}
 Self.rHeaderCompare := Self.rHeader.rData;
 
 f_Body := nil;
 f_Position := aPosition;

 if (Self.Position <> -1) then
 begin
  FreeAndNil(f_PrevBlock);
  // - предыдущий блок нам уже не нужен, т.к. у нас уже распределена наша позиция 
  Load;
  Assert((Self.Index = 0) OR (Self.rHeader.rData.rPrevPosition >= 0));
 end;//Self.Position <> -1
//#UC END# *5446556801C7_5411C58501E2_impl*
end;//Tm3StorageBlock.CreatePrim

procedure Tm3StorageBlock.SetPositionInStream(aPosition: Int64);
//#UC START# *5450F5B9010F_5411C58501E2_var*
//#UC END# *5450F5B9010F_5411C58501E2_var*
begin
//#UC START# *5450F5B9010F_5411C58501E2_impl*
 Assert(Self <> nil);
 Assert(f_Manager <> nil);
 Assert(Self.Index = aPosition div f_Manager.ClusterBodySize);
 Self.f_Offset := aPosition mod f_Manager.ClusterBodySize;
//#UC END# *5450F5B9010F_5411C58501E2_impl*
end;//Tm3StorageBlock.SetPositionInStream

function Tm3LockedRegion_C(aForRead: Boolean;
         const aRegion: Tm3FileRegion): Tm3LockedRegion;
//#UC START# *5450E3910297_5450E35203B6_var*
//#UC END# *5450E3910297_5450E35203B6_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5450E3910297_5450E35203B6_impl*
 Result.rForRead := aForRead;
 Result.rRegion := aRegion;
//#UC END# *5450E3910297_5450E35203B6_impl*
end;//Tm3LockedRegion.C

// start class Tm3StorageBlock

function Tm3StorageBlock.pm_GetNextPosition: Int64;
//#UC START# *5448EBF902BB_5411C58501E2get_var*
//#UC END# *5448EBF902BB_5411C58501E2get_var*
begin
//#UC START# *5448EBF902BB_5411C58501E2get_impl*
 Result := Self.rHeader.rData.rNextPosition;
//#UC END# *5448EBF902BB_5411C58501E2get_impl*
end;//Tm3StorageBlock.pm_GetNextPosition

procedure Tm3StorageBlock.pm_SetNextPosition(aValue: Int64);
//#UC START# *5448EBF902BB_5411C58501E2set_var*
//#UC END# *5448EBF902BB_5411C58501E2set_var*
begin
//#UC START# *5448EBF902BB_5411C58501E2set_impl*
 Self.rHeader.rData.rNextPosition := aValue;
//#UC END# *5448EBF902BB_5411C58501E2set_impl*
end;//Tm3StorageBlock.pm_SetNextPosition

procedure Tm3StorageBlock.Cleanup;
//#UC START# *479731C50290_5411C58501E2_var*

 procedure DoSave;
 begin//DoSave
  try
   Self.Save;
  except
   on E: Em3InvalidStoreData do
    l3System.Exception2Log(E);
   on E: Exception do
    l3System.Exception2Log(E);
  end;//try..except
 end;//DoSave

//#UC END# *479731C50290_5411C58501E2_var*
begin
//#UC START# *479731C50290_5411C58501E2_impl*
 if (f_Manager <> nil) then
 begin
  if Self.Modified then
   DoSave;
 end;//f_Manager <> nil
 Assert(not Modified);
 m3TOCBuffers^.FreeItem(Pointer(f_Body));
 f_Position := -1;
 f_BufferModified := false;
 FreeAndNil(f_PrevBlock);
 FreeAndNil(f_Manager);
 FreeAndNil(f_HeaderData);
 FreeAndNil(f_Name);
 inherited;
//#UC END# *479731C50290_5411C58501E2_impl*
end;//Tm3StorageBlock.Cleanup

initialization
//#UC START# *5413162303A4*
 m3TOCBuffers := l3NewMemoryChain(m3ClusterSize);
//#UC END# *5413162303A4*

end.