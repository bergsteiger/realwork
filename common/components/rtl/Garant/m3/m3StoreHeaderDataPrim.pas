unit m3StoreHeaderDataPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StoreHeaderDataPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3StoreHeaderDataPrim" MUID: (54084CDE023E)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3_String
 , m3RootStreamManagerPrimPrim
;

type
 Rm3StoreHeaderDataPrim = class of Tm3StoreHeaderDataPrim;

 Tm3StoreHeaderDataPrim = class(Tl3CProtoObject)
  private
   f_Lock: Integer;
   f_Position: Int64;
   f_IsReadOnly: Boolean;
   f_Name: Tl3_String;
   f_Stream: Tm3RootStreamManagerPrimPrim;
  protected
   function pm_GetrRealSizePrim: Int64; virtual; abstract;
   procedure pm_SetrRealSizePrim(aValue: Int64); virtual; abstract;
   function pm_GetFirstClusterPrim: Int64; virtual; abstract;
   procedure pm_SetFirstClusterPrim(aValue: Int64); virtual; abstract;
   function pm_GetrTOCItemListPositionPrim: Int64; virtual; abstract;
   procedure pm_SetrTOCItemListPositionPrim(aValue: Int64); virtual; abstract;
   procedure pm_SetPosition(aValue: Int64);
   function pm_GetLocked: Boolean;
   function pm_GetrTOCItemListPosition: Int64;
   procedure pm_SetrTOCItemListPosition(aValue: Int64);
   function pm_GetrRealSize: Int64;
   procedure pm_SetrRealSize(aValue: Int64);
   function pm_GetFirstCluster: Int64;
   procedure pm_SetFirstCluster(aValue: Int64);
   class function DataSize: Integer; virtual; abstract;
   function Modified: Boolean; virtual; abstract;
   procedure DoDoLoad; virtual; abstract;
   procedure DoDoSave; virtual; abstract;
   procedure Load;
   procedure Save;
   procedure DoSaveNextPosition(aNextPosition: Int64); virtual; abstract;
   procedure Lock;
   procedure Unlock;
   constructor CreatePrim(aStream: Tm3RootStreamManagerPrimPrim;
    aPosition: Int64;
    aIsReadOnly: Boolean;
    aName: Tl3_String;
    aNeedLock: Boolean); reintroduce;
   procedure InitData(aNew: Boolean); virtual; abstract;
   procedure DoLoad;
   procedure DoSave;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function SaveToExistingPlace: Int64;
   constructor CreateNew(aStream: Tm3RootStreamManagerPrimPrim); reintroduce;
   constructor Create(aStream: Tm3RootStreamManagerPrimPrim;
    aPosition: Int64;
    aIsReadOnly: Boolean;
    aName: Tl3_String); reintroduce;
   function SaveToNewPlace(var theRootSize: Int64): Int64;
   constructor CreateAtExistingPlace(aStream: Tm3RootStreamManagerPrimPrim;
    aPosition: Int64); reintroduce;
   constructor CreateForDeletion(aStream: Tm3RootStreamManagerPrimPrim;
    aPosition: Int64); reintroduce;
   procedure Delete(aNextPosition: Int64);
  protected
   property rRealSizePrim: Int64
    read pm_GetrRealSizePrim
    write pm_SetrRealSizePrim;
   property FirstClusterPrim: Int64
    read pm_GetFirstClusterPrim
    write pm_SetFirstClusterPrim;
   property rTOCItemListPositionPrim: Int64
    read pm_GetrTOCItemListPositionPrim
    write pm_SetrTOCItemListPositionPrim;
   property Position: Int64
    read f_Position
    write pm_SetPosition;
   property Locked: Boolean
    read pm_GetLocked;
  public
   property IsReadOnly: Boolean
    read f_IsReadOnly;
   property Name: Tl3_String
    read f_Name;
   property rTOCItemListPosition: Int64
    read pm_GetrTOCItemListPosition
    write pm_SetrTOCItemListPosition;
   property rRealSize: Int64
    read pm_GetrRealSize
    write pm_SetrRealSize;
   property FirstCluster: Int64
    read pm_GetFirstCluster
    write pm_SetFirstCluster;
   property Stream: Tm3RootStreamManagerPrimPrim
    read f_Stream;
 end;//Tm3StoreHeaderDataPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , m3Exceptions
 , m2COMLib
 , ActiveX
 , ComObj
 , l3Base
 , Windows
 , m3FileRegion
 , l3Interlocked
;

procedure Tm3StoreHeaderDataPrim.pm_SetPosition(aValue: Int64);
//#UC START# *540D8F84003A_54084CDE023Eset_var*
//#UC END# *540D8F84003A_54084CDE023Eset_var*
begin
//#UC START# *540D8F84003A_54084CDE023Eset_impl*
 if (f_Position = aValue) then
  Exit;
 Assert(not Self.Locked);
 Assert((f_Position = -1) OR (aValue = -1));
 f_Position := aValue; 
//#UC END# *540D8F84003A_54084CDE023Eset_impl*
end;//Tm3StoreHeaderDataPrim.pm_SetPosition

function Tm3StoreHeaderDataPrim.pm_GetLocked: Boolean;
//#UC START# *54197985018A_54084CDE023Eget_var*
//#UC END# *54197985018A_54084CDE023Eget_var*
begin
//#UC START# *54197985018A_54084CDE023Eget_impl*
 Result := (f_Lock > 0);
//#UC END# *54197985018A_54084CDE023Eget_impl*
end;//Tm3StoreHeaderDataPrim.pm_GetLocked

function Tm3StoreHeaderDataPrim.pm_GetrTOCItemListPosition: Int64;
//#UC START# *54197B6E02B7_54084CDE023Eget_var*
//#UC END# *54197B6E02B7_54084CDE023Eget_var*
begin
//#UC START# *54197B6E02B7_54084CDE023Eget_impl*
 Result := rTOCItemListPositionPrim; 
//#UC END# *54197B6E02B7_54084CDE023Eget_impl*
end;//Tm3StoreHeaderDataPrim.pm_GetrTOCItemListPosition

procedure Tm3StoreHeaderDataPrim.pm_SetrTOCItemListPosition(aValue: Int64);
//#UC START# *54197B6E02B7_54084CDE023Eset_var*
//#UC END# *54197B6E02B7_54084CDE023Eset_var*
begin
//#UC START# *54197B6E02B7_54084CDE023Eset_impl*
 Assert(Self.Locked);
 rTOCItemListPositionPrim := aValue; 
//#UC END# *54197B6E02B7_54084CDE023Eset_impl*
end;//Tm3StoreHeaderDataPrim.pm_SetrTOCItemListPosition

function Tm3StoreHeaderDataPrim.pm_GetrRealSize: Int64;
//#UC START# *54197B970229_54084CDE023Eget_var*
//#UC END# *54197B970229_54084CDE023Eget_var*
begin
//#UC START# *54197B970229_54084CDE023Eget_impl*
 Result := rRealSizePrim;
//#UC END# *54197B970229_54084CDE023Eget_impl*
end;//Tm3StoreHeaderDataPrim.pm_GetrRealSize

procedure Tm3StoreHeaderDataPrim.pm_SetrRealSize(aValue: Int64);
//#UC START# *54197B970229_54084CDE023Eset_var*
//#UC END# *54197B970229_54084CDE023Eset_var*
begin
//#UC START# *54197B970229_54084CDE023Eset_impl*
 Assert(Self.Locked);
 Assert((aValue > 0) OR (Position > 0), 'Нельзя уменьшать данные корневого потока');
 rRealSizePrim := aValue;
//#UC END# *54197B970229_54084CDE023Eset_impl*
end;//Tm3StoreHeaderDataPrim.pm_SetrRealSize

function Tm3StoreHeaderDataPrim.pm_GetFirstCluster: Int64;
//#UC START# *54197BF1039F_54084CDE023Eget_var*
//#UC END# *54197BF1039F_54084CDE023Eget_var*
begin
//#UC START# *54197BF1039F_54084CDE023Eget_impl*
 Result := FirstClusterPrim;
//#UC END# *54197BF1039F_54084CDE023Eget_impl*
end;//Tm3StoreHeaderDataPrim.pm_GetFirstCluster

procedure Tm3StoreHeaderDataPrim.pm_SetFirstCluster(aValue: Int64);
//#UC START# *54197BF1039F_54084CDE023Eset_var*
//#UC END# *54197BF1039F_54084CDE023Eset_var*
begin
//#UC START# *54197BF1039F_54084CDE023Eset_impl*
 Assert(Self.Locked);
 Assert((aValue = -1) OR (Self.FirstCluster = -1), 'Начальный блок потока может только распределяться или освобождаться, но не меняться');
 Assert((aValue >= 0) OR (Position > 0), 'Нельзя удалять заголовок корневого хранилища');
 Self.FirstClusterPrim := aValue;
//#UC END# *54197BF1039F_54084CDE023Eset_impl*
end;//Tm3StoreHeaderDataPrim.pm_SetFirstCluster

function Tm3StoreHeaderDataPrim.SaveToExistingPlace: Int64;
//#UC START# *540D8FE0012F_54084CDE023E_var*
//#UC END# *540D8FE0012F_54084CDE023E_var*
begin
//#UC START# *540D8FE0012F_54084CDE023E_impl*
 Assert(f_Position >= 0);
 Result := -1;
 Stream.Lock;
 try
  Stream.ReadData(Position, Result, SizeOf(Result));
  // - на самом деле ТИПА ЗНАЕМ, что там лежит rNextPosition
  DoSave;
 finally
  Stream.Unlock;
 end;//try..finally
//#UC END# *540D8FE0012F_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.SaveToExistingPlace

procedure Tm3StoreHeaderDataPrim.Load;
//#UC START# *540D900803CA_54084CDE023E_var*
//#UC END# *540D900803CA_54084CDE023E_var*
begin
//#UC START# *540D900803CA_54084CDE023E_impl*
 Assert(f_Position >= 0);
 DoLoad;
 Em3InvalidStreamSize.Check(Stream.IsValidPosition,
                            f_Name,
                            Self.rRealSize);
//#UC END# *540D900803CA_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Load

procedure Tm3StoreHeaderDataPrim.Save;
//#UC START# *540D90140162_54084CDE023E_var*
//#UC END# *540D90140162_54084CDE023E_var*
begin
//#UC START# *540D90140162_54084CDE023E_impl*
 Assert(Self <> nil);
 if (Self = nil) then
  Exit;
 Assert(f_Position >= 0);
 if not f_IsReadOnly then
  if Modified then
  begin
(*   Em3InvalidStreamPos.Check(Stream.IsValidPosition,
                             f_Name,
                             f_Position);*)
   Em3InvalidStreamSize.Check(Stream.IsValidPosition,
                              f_Name,
                              Self.rRealSize);
   Em3InvalidStreamPos.Check(Stream.IsValidLink,
                             f_Name,
                             Self.FirstCluster);
   Em3InvalidStreamPos.Check(Stream.IsValidLink,
                             f_Name,
                             Self.RTOCItemListPosition);
(*   Em3InvalidStreamPos.Check(Stream.IsValidLink,
                             f_Name,
                             Self.rNextPosition);*)
   DoSave;
  end;//Modified
//#UC END# *540D90140162_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Save

constructor Tm3StoreHeaderDataPrim.CreateNew(aStream: Tm3RootStreamManagerPrimPrim);
//#UC START# *540D903E004D_54084CDE023E_var*
//#UC END# *540D903E004D_54084CDE023E_var*
begin
//#UC START# *540D903E004D_54084CDE023E_impl*
 CreatePrim(aStream, -1, false, nil, true);
//#UC END# *540D903E004D_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.CreateNew

constructor Tm3StoreHeaderDataPrim.Create(aStream: Tm3RootStreamManagerPrimPrim;
 aPosition: Int64;
 aIsReadOnly: Boolean;
 aName: Tl3_String);
//#UC START# *540D9056031E_54084CDE023E_var*
//#UC END# *540D9056031E_54084CDE023E_var*
begin
//#UC START# *540D9056031E_54084CDE023E_impl*
 Assert(aPosition >= 0);
 Assert(aName <> nil);
 CreatePrim(aStream, aPosition, aIsReadOnly, aName, true);
//#UC END# *540D9056031E_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Create

function Tm3StoreHeaderDataPrim.SaveToNewPlace(var theRootSize: Int64): Int64;
//#UC START# *540DC60D01CD_54084CDE023E_var*
var
 l_RootSize : Int64;
 l_Position : Int64;
//#UC END# *540DC60D01CD_54084CDE023E_var*
begin
//#UC START# *540DC60D01CD_54084CDE023E_impl*
 Assert(f_Position = -1);
 try
  Assert(not Self.IsReadOnly);
  Stream.Lock;
  try
   l_RootSize := theRootSize;
   try
    Stream.SetPositionAndValidateIt(theRootSize, l_Position);
    Self.Position := l_Position;
    Em3InvalidNewPositionOfRoot.Check(Position, theRootSize);
    DoSave;
    Inc(theRootSize, Int64(Self.DataSize));
   except
    theRootSize := l_RootSize;
    raise;
   end;//try..except
  finally
   Stream.Unlock;
  end;//try..finally
  Assert(f_Position >= 0);
 except
  Position := -1;
  raise;
 end;//try..except
 Result := Position;
//#UC END# *540DC60D01CD_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.SaveToNewPlace

procedure Tm3StoreHeaderDataPrim.Lock;
//#UC START# *540DDC330067_54084CDE023E_var*
//#UC END# *540DDC330067_54084CDE023E_var*
begin
//#UC START# *540DDC330067_54084CDE023E_impl*
 Assert(Self <> nil);
 Assert(f_Position >= 0);
 if (f_Lock = 0) then
 begin
  try
   Stream.LockRegion(Self.IsReadOnly, Tm3FileRegion_C(f_Position, Self.DataSize));
  except
   on E: EOleSysError do
   begin
    if (E.ErrorCode <> STG_E_LOCKVIOLATION) then
     l3System.Exception2Log(E);
    raise;
   end;//E: EOleSysError
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    raise;
   end;//E: Exception
  end;//try..except
 end;//f_Lock = 0
 l3InterlockedIncrement(f_Lock);
//#UC END# *540DDC330067_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Lock

procedure Tm3StoreHeaderDataPrim.Unlock;
//#UC START# *540DDC4601C6_54084CDE023E_var*
//#UC END# *540DDC4601C6_54084CDE023E_var*
begin
//#UC START# *540DDC4601C6_54084CDE023E_impl*
 Assert(Self <> nil);
 Assert(f_Position >= 0);
 if (f_Lock <= 0) then
  Exit;
 if (l3InterlockedDecrement(f_Lock) = 0) then
  Stream.UnlockRegion(Self.IsReadOnly, Tm3FileRegion_C(f_Position, Self.DataSize));
//#UC END# *540DDC4601C6_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Unlock

constructor Tm3StoreHeaderDataPrim.CreatePrim(aStream: Tm3RootStreamManagerPrimPrim;
 aPosition: Int64;
 aIsReadOnly: Boolean;
 aName: Tl3_String;
 aNeedLock: Boolean);
//#UC START# *540EEFD70388_54084CDE023E_var*
//#UC END# *540EEFD70388_54084CDE023E_var*
begin
//#UC START# *540EEFD70388_54084CDE023E_impl*
 Assert(aStream <> nil);
 f_Lock := 0;
 if (aPosition <> -1) then
  Em3InvalidStreamPos.Check(aStream.IsValidPosition, aName, aPosition);
 aName.SetRefTo(f_Name);
 inherited Create;
 f_Position := aPosition;
 aStream.SetRefTo(f_Stream);
 f_IsReadOnly := aIsReadOnly;
 InitData((f_Position < 0) OR (f_Name = nil));
 if aNeedLock then
  if (f_Position >= 0) then
   if not Self.IsReadOnly then
    Lock;
 if (f_Position >= 0) then
  if (f_Name <> nil) then
   Load;
//#UC END# *540EEFD70388_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.CreatePrim

constructor Tm3StoreHeaderDataPrim.CreateAtExistingPlace(aStream: Tm3RootStreamManagerPrimPrim;
 aPosition: Int64);
//#UC START# *541025B80378_54084CDE023E_var*
//#UC END# *541025B80378_54084CDE023E_var*
begin
//#UC START# *541025B80378_54084CDE023E_impl*
 Assert(aPosition >= 0);
 CreatePrim(aStream, aPosition, false, nil, true);
//#UC END# *541025B80378_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.CreateAtExistingPlace

constructor Tm3StoreHeaderDataPrim.CreateForDeletion(aStream: Tm3RootStreamManagerPrimPrim;
 aPosition: Int64);
//#UC START# *541026120318_54084CDE023E_var*
//#UC END# *541026120318_54084CDE023E_var*
begin
//#UC START# *541026120318_54084CDE023E_impl*
 Assert(aPosition >= 0);
 CreatePrim(aStream, aPosition, false, nil, false);
//#UC END# *541026120318_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.CreateForDeletion

procedure Tm3StoreHeaderDataPrim.DoLoad;
//#UC START# *541078E20019_54084CDE023E_var*
//#UC END# *541078E20019_54084CDE023E_var*
begin
//#UC START# *541078E20019_54084CDE023E_impl*
 Self.Lock;
 try
  Stream.Lock;
  try
   DoDoLoad;
  finally
   Stream.Unlock;
  end;//try..finally
 finally
  Self.Unlock;
 end;//try..finally
//#UC END# *541078E20019_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.DoLoad

procedure Tm3StoreHeaderDataPrim.DoSave;
//#UC START# *541078ED0397_54084CDE023E_var*
//#UC END# *541078ED0397_54084CDE023E_var*
begin
//#UC START# *541078ED0397_54084CDE023E_impl*
 Assert(not Self.IsReadOnly);
 Self.Lock;
 try
  Stream.Lock;
  try
   if (Position = 0) then
   begin
    Assert((FirstCluster >= 0) OR (f_Name = nil), 'Нельзя удалять заголовок корневого хранилища');
(*    if (Stream.Logger <> nil) then
     Stream.Logger.ToLog('Записываем данные элемента: ' + f_Name.AsString + ' FirstCluster = ' + IntToStr(FirstCluster) + ' rRealSize = ' + IntToStr(rRealSize));
    l3System.Stack2Log('Записываем данные элемента: ' + f_Name.AsString + ' FirstCluster = ' + IntToStr(FirstCluster) + ' rRealSize = ' + IntToStr(rRealSize));*)
   end;//Position = 0
   DoDoSave;
  finally
   Stream.Unlock;
  end;//try..finally
 finally
  Self.Unlock;
 end;//try..finally
//#UC END# *541078ED0397_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.DoSave

procedure Tm3StoreHeaderDataPrim.Delete(aNextPosition: Int64);
//#UC START# *5411719C0255_54084CDE023E_var*
//#UC END# *5411719C0255_54084CDE023E_var*
begin
//#UC START# *5411719C0255_54084CDE023E_impl*
 Assert(not Self.IsReadOnly);
 Assert(not Self.Locked);
 Self.Lock;
 try
  Stream.Lock;
  try
   DoSaveNextPosition(aNextPosition);
  finally
   Stream.Unlock;
  end;//try..finally
 finally
  Self.Unlock;
 end;//try..finally
 Position := -1;
//#UC END# *5411719C0255_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Delete

procedure Tm3StoreHeaderDataPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54084CDE023E_var*
//#UC END# *479731C50290_54084CDE023E_var*
begin
//#UC START# *479731C50290_54084CDE023E_impl*
 if not Self.IsReadOnly then
  if (f_Position >= 0) then
   try
    if (f_Name <> nil) then
    begin
     Assert(Locked OR not Modified);
     Save;
    end;//f_Name <> nil
   except
    on E: Em3InvalidStoreData do
     l3System.Exception2Log(E);
   end;//try..except
 if Self.IsReadOnly then
  Assert(not Self.Locked);
 while Self.Locked do
  Unlock;
 FreeAndNil(f_Name);
 FreeAndNil(f_Stream);
 inherited;
//#UC END# *479731C50290_54084CDE023E_impl*
end;//Tm3StoreHeaderDataPrim.Cleanup

end.
