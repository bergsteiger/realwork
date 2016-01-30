unit m3CommonStorage;

// Модуль: "w:\common\components\rtl\Garant\m3\m3CommonStorage.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3StoragePrim
 , ActiveX
 , m3TOCHandleList
 , l3Interfaces
 , m3StorageInterfaces
 , l3_String
 , m3RootStreamManagerPrim
;

type
 Tm3IndexInfo = packed record
  {* Информация об индексе }
 //#UC START# *542177F90247publ*
    rPosition : Int64;
    rBits     : Byte;
    rMaxBits  : Byte;
 //#UC END# *542177F90247publ*
 end;//Tm3IndexInfo

 Tm3StoreOperation = (
  {* Операция с элементом хранилища }
  m3_soOpen
  , m3_soCreate
  , m3_soDelete
 );//Tm3StoreOperation

 Rm3CommonStorage = class of Tm3CommonStorage;

 Tm3CommonStorage = {abstract} class(Tm3StoragePrim)
  protected
   f_IndexStream: IStream;
   f_IndexInfo: Tm3IndexInfo;
   f_TableOfContents: Tm3TOCHandleList;
   f_CanAllocateIndex: Boolean;
  protected
   function IsValidName(aName: PWideChar;
    aLen: Integer = -1): Boolean; overload;
   function IsValidName(const aName: Tl3WString): Boolean; overload;
   function IsValidName(const aName: Tl3WString;
    out anIndex: Integer): Boolean; overload;
   procedure CheckIndexStream(aNeedCreate: Boolean;
    aForIterate: Boolean); virtual; abstract;
   class function SubStorageClass: Rm3CommonStorage;
   procedure DoSaveTableOfContents; virtual; abstract;
   procedure SaveTableOfContents;
   function Manager: Tm3RootStreamManagerPrim; virtual; abstract;
   procedure LoadTableOfContents;
   procedure DoLoadTableOfContents; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeRelease; override;
   function DoGetSize: Int64; override;
   procedure ClearFields; override;
  public
   constructor Create(anAccess: Tm3StoreAccess); reintroduce;
   class function Make(anAccess: Tm3StoreAccess;
    aName: Tl3_String;
    aManager: Tm3RootStreamManagerPrim;
    aPosition: Int64): Im3IndexedStorage; virtual; abstract;
   class function OpenRoot(anAccess: Tm3StoreAccess;
    const aStream: IStream;
    out theManager: Tm3RootStreamManagerPrim): Im3IndexedStorage; virtual; abstract;
   class function ForPlugin: Boolean; virtual;
   class function IsPacked: Boolean; virtual;
   class function OpenFromManager(anAccess: Tm3StoreAccess;
    aManager: Tm3RootStreamManagerPrim): Im3IndexedStorage; virtual; abstract;
 end;//Tm3CommonStorage

implementation

uses
 l3ImplUses
 , m3Const
 , l3Const
 , l3String
 , SysUtils
 , l3StringEx
 , m3CommonStorageStream
 , l3Base
;

function Tm3CommonStorage.IsValidName(aName: PWideChar;
 aLen: Integer = -1): Boolean;
//#UC START# *542176B30215_542176490191_var*
var
 l_Index : Integer;
//#UC END# *542176B30215_542176490191_var*
begin
//#UC START# *542176B30215_542176490191_impl*
 if (aName <> nil) then
 begin
  if (aLen = -1) then
   aLen := l3StrLen(aName);
  if (aLen > 0) then
  begin
   Result := true;
   for l_Index := 0 to Pred(aLen) do
    if (aName[l_Index] in [WideChar($003a),WideChar($002f),WideChar($005c)]) then
    begin
     Result := false;
     Exit;
    end;//aName[l_Index]
  end//aLen > 0
  else
   Result := false;
 end//aName <> nil
 else
  Result := false;  
//#UC END# *542176B30215_542176490191_impl*
end;//Tm3CommonStorage.IsValidName

function Tm3CommonStorage.IsValidName(const aName: Tl3WString): Boolean;
//#UC START# *542176D80213_542176490191_var*
//#UC END# *542176D80213_542176490191_var*
begin
//#UC START# *542176D80213_542176490191_impl*
 if (AName.SCodePage = CP_Unicode) then
  Result := IsValidName(PWideChar(aName.S), aName.SLen)
 else
  Result := IsValidName(PWideChar(Tl3Str(aName).AsWideString), aName.SLen);
//#UC END# *542176D80213_542176490191_impl*
end;//Tm3CommonStorage.IsValidName

function Tm3CommonStorage.IsValidName(const aName: Tl3WString;
 out anIndex: Integer): Boolean;
//#UC START# *542177090147_542176490191_var*
var
 l_Name : AnsiString;
//#UC END# *542177090147_542176490191_var*
begin
//#UC START# *542177090147_542176490191_impl*
 Result := false;
 if not l3IsNil(aName) then
 begin
  if (aName.SCodePage = CP_Unicode) then
  begin
   if (aName.SLen > 0) AND (PWideChar(aName.S)[0] = m3UnicodeIndexPrefix) then
    PWideChar(aName.S)[0] := WideChar(m3IndexPrefix);
  end;//aName.SCodePage = CP_Unicode
  l_Name := l3PCharLen2String(aName);
  if (l_Name[1] = m3IndexPrefix) then
  begin
   System.Delete(l_Name, 1, 1);
   try
    anIndex := StrToInt(l_Name);
    Assert(anIndex >= 0);
    Result := true;
   except
    on EConvertError do;
   end;//try..except
  end;//l_Name[1] = m3IndexPrefix
 end;//not l3IsNil(aName)
//#UC END# *542177090147_542176490191_impl*
end;//Tm3CommonStorage.IsValidName

constructor Tm3CommonStorage.Create(anAccess: Tm3StoreAccess);
//#UC START# *5421789103A7_542176490191_var*
const
 cBitsForPart = 8;
//#UC END# *5421789103A7_542176490191_var*
begin
//#UC START# *5421789103A7_542176490191_impl*
 f_IndexInfo.rPosition := Int64(-1);
 f_IndexInfo.rBits := cBitsForPart;
 f_IndexInfo.rMaxBits := l3BitInLong;
 f_CanAllocateIndex := false;
 f_TableOfContents := Tm3TOCHandleList.Create;
 inherited Create(anAccess);
 f_CanAllocateIndex := not Self.ReadOnly;
//#UC END# *5421789103A7_542176490191_impl*
end;//Tm3CommonStorage.Create

class function Tm3CommonStorage.SubStorageClass: Rm3CommonStorage;
//#UC START# *5422B2BF026C_542176490191_var*
//#UC END# *5422B2BF026C_542176490191_var*
begin
//#UC START# *5422B2BF026C_542176490191_impl*
 Result := Self;
//#UC END# *5422B2BF026C_542176490191_impl*
end;//Tm3CommonStorage.SubStorageClass

procedure Tm3CommonStorage.SaveTableOfContents;
//#UC START# *5422C41A00FE_542176490191_var*
//#UC END# *5422C41A00FE_542176490191_var*
begin
//#UC START# *5422C41A00FE_542176490191_impl*
 Assert(Self <> nil);
 if (f_TableOfContents <> nil) then
  if f_TableOfContents.Modified then
  begin
   f_TableOfContents.Modified := false;
   if not Self.ReadOnly then
    DoSaveTableOfContents;
  end;//f_TableOfContents.Modified
//#UC END# *5422C41A00FE_542176490191_impl*
end;//Tm3CommonStorage.SaveTableOfContents

procedure Tm3CommonStorage.LoadTableOfContents;
//#UC START# *5422CF5F0248_542176490191_var*
//#UC END# *5422CF5F0248_542176490191_var*
begin
//#UC START# *5422CF5F0248_542176490191_impl*
 Assert(Self <> nil);
 Assert(f_TableOfContents <> nil);
 DoLoadTableOfContents;
//#UC END# *5422CF5F0248_542176490191_impl*
end;//Tm3CommonStorage.LoadTableOfContents

class function Tm3CommonStorage.ForPlugin: Boolean;
//#UC START# *542E61B501C9_542176490191_var*
//#UC END# *542E61B501C9_542176490191_var*
begin
//#UC START# *542E61B501C9_542176490191_impl*
 Result := false;
//#UC END# *542E61B501C9_542176490191_impl*
end;//Tm3CommonStorage.ForPlugin

class function Tm3CommonStorage.IsPacked: Boolean;
//#UC START# *542E61D70049_542176490191_var*
//#UC END# *542E61D70049_542176490191_var*
begin
//#UC START# *542E61D70049_542176490191_impl*
 Result := false;
//#UC END# *542E61D70049_542176490191_impl*
end;//Tm3CommonStorage.IsPacked

procedure Tm3CommonStorage.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_542176490191_var*
//#UC END# *479731C50290_542176490191_var*
begin
//#UC START# *479731C50290_542176490191_impl*
 FreeAndNil(f_TableOfContents);
 f_IndexStream := nil;
 inherited;
//#UC END# *479731C50290_542176490191_impl*
end;//Tm3CommonStorage.Cleanup

procedure Tm3CommonStorage.BeforeRelease;
//#UC START# *49BFC98902FF_542176490191_var*
var
 l_M : Tm3RootStreamManagerPrim;
//#UC END# *49BFC98902FF_542176490191_var*
begin
//#UC START# *49BFC98902FF_542176490191_impl*
 inherited;
 try
  SaveTableOfContents;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   l_M := Self.Manager;
   if (l_M <> nil) then
    if (l_M.Logger <> nil) then
     l_M.Logger.ToLog('Исключение "' + E.Message + '" при записи оглавления');
  end;//on E: Exception
 end;//try..except
//#UC END# *49BFC98902FF_542176490191_impl*
end;//Tm3CommonStorage.BeforeRelease

function Tm3CommonStorage.DoGetSize: Int64;
//#UC START# *4FA2802E0231_542176490191_var*
//#UC END# *4FA2802E0231_542176490191_var*
begin
//#UC START# *4FA2802E0231_542176490191_impl*
 Lock;
 try
  Result := Int64(f_TableOfContents.Count);
 finally
  Unlock;
 end;//try..finally
//#UC END# *4FA2802E0231_542176490191_impl*
end;//Tm3CommonStorage.DoGetSize

procedure Tm3CommonStorage.ClearFields;
begin
 f_IndexStream := nil;
 inherited;
end;//Tm3CommonStorage.ClearFields

end.
