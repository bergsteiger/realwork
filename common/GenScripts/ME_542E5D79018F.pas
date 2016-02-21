unit m3StorageHolder;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageHolder.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3StorageInterfaces
 , m3CommonStorage
 , m3RootStreamManagerPrim
 , ActiveX
;

type
 Tm3StorageHolder = class(Tl3CProtoObject, Im3StorageHolder)
  private
   f_Storage: Im3IndexedStorage;
   f_StorageClass: Rm3CommonStorage;
   f_RootStreamManager: Tm3RootStreamManagerPrim;
   f_Access: Tm3StoreAccess;
    {* Поле для свойства Access }
   f_FileName: WideString;
    {* Поле для свойства FileName }
   f_SharedMode: Cardinal;
    {* Поле для свойства SharedMode }
  protected
   function ReopenStorage(anAccess: Tm3StoreAccess): Im3IndexedStorage;
   function Get_Storage: Im3IndexedStorage;
   function StoreToCache(const aFileName: WideString;
    aSharedMode: Cardinal): Im3IndexedStorage;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aStorageClass: Rm3CommonStorage;
    anAccess: Tm3StoreAccess;
    const aStream: IStream); reintroduce;
   class function Make(aStorageClass: Rm3CommonStorage;
    anAccess: Tm3StoreAccess;
    const aStream: IStream): Im3StorageHolder; reintroduce;
   class function GetFromCache(const aFileName: WideString;
    anAccess: Tm3StoreAccess;
    aType: Tm3StorageType;
    aSharedMode: Cardinal;
    out theStorage: Im3IndexedStorage): Boolean;
  public
   property Access: Tm3StoreAccess
    read f_Access;
   property FileName: WideString
    read f_FileName;
   property SharedMode: Cardinal
    read f_SharedMode;
 end;//Tm3StorageHolder

implementation

uses
 l3ImplUses
 , SysUtils
 , m3StorageHolderList
 , Windows
;

constructor Tm3StorageHolder.Create(aStorageClass: Rm3CommonStorage;
 anAccess: Tm3StoreAccess;
 const aStream: IStream);
//#UC START# *542E5E1A037B_542E5D79018F_var*
//#UC END# *542E5E1A037B_542E5D79018F_var*
begin
//#UC START# *542E5E1A037B_542E5D79018F_impl*
 Assert(f_RootStreamManager = nil);
 Assert((anAccess = STGM_READ) OR (anAccess = STGM_READWRITE));
 Assert(Assigned(aStorageClass));
 Assert(aStream <> nil);
 inherited Create;
 f_Access := anAccess;
 f_StorageClass := aStorageClass;
 f_Storage := f_StorageClass.OpenRoot(anAccess, aStream, f_RootStreamManager);
 Assert(f_Storage <> nil);
 Assert(f_RootStreamManager <> nil);
//#UC END# *542E5E1A037B_542E5D79018F_impl*
end;//Tm3StorageHolder.Create

class function Tm3StorageHolder.Make(aStorageClass: Rm3CommonStorage;
 anAccess: Tm3StoreAccess;
 const aStream: IStream): Im3StorageHolder;
var
 l_Inst : Tm3StorageHolder;
begin
 l_Inst := Create(aStorageClass, anAccess, aStream);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tm3StorageHolder.Make

class function Tm3StorageHolder.GetFromCache(const aFileName: WideString;
 anAccess: Tm3StoreAccess;
 aType: Tm3StorageType;
 aSharedMode: Cardinal;
 out theStorage: Im3IndexedStorage): Boolean;
//#UC START# *542E6E450028_542E5D79018F_var*
var
 l_List : Tm3StorageHolderList;
 l_Index : Integer;
 l_Item  : Tm3StorageHolder;
//#UC END# *542E6E450028_542E5D79018F_var*
begin
//#UC START# *542E6E450028_542E5D79018F_impl*
 Result := false;
 theStorage := nil;

 if not Tm3StorageHolderList.Exists then
  Exit;

 if (aType <> m3_stArchive) then
  Exit;
  
 l_List := Tm3StorageHolderList.Instance;
 Assert(l_List <> nil);
 l_List.Lock;
 try

  if (aSharedMode = 0) then
  begin
   if l_List.FindData(aFileName, l_Index) then
    l_List.Delete(l_Index);
   // - удаляем то, что было захвачено не монопольно
   Exit;
  end;//aSharedMode = 0

  if l_List.FindData(aFileName, l_Index) then
  begin
   l_Item := l_List.Items[l_Index];

   if (l_Item.SharedMode <> aSharedMode) then
   begin
    if (l_Item.SharedMode = FILE_SHARE_READ) then
    begin
     l_List.Delete(l_Index);
     // - удаляем менеджер с более низкими разрешениями доступа
     Exit;
    end;//l_Item.Access = STGM_READ
   end;//l_Item.SharedMode <> aSharedMode

   if (l_Item.Access <> anAccess) then
   begin
    if (l_Item.Access = STGM_READ) then
    begin
     l_List.Delete(l_Index);
     // - удаляем менеджер с более низкими разрешениями доступа
     Exit;
    end;//l_Item.Access = STGM_READ
   end;//l_Item.Access <> anAccess

   theStorage := l_Item.ReopenStorage(anAccess);
   Result := (theStorage <> nil);
  end;//l_List.FindData(aFileName, l_Index)
 finally
  l_List.Unlock;
 end;//try..finally
//#UC END# *542E6E450028_542E5D79018F_impl*
end;//Tm3StorageHolder.GetFromCache

function Tm3StorageHolder.ReopenStorage(anAccess: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *542E95A901B7_542E5D79018F_var*
//#UC END# *542E95A901B7_542E5D79018F_var*
begin
//#UC START# *542E95A901B7_542E5D79018F_impl*
 Assert(f_Storage = nil);
 Result := f_StorageClass.OpenFromManager(anAccess, f_RootStreamManager);
//#UC END# *542E95A901B7_542E5D79018F_impl*
end;//Tm3StorageHolder.ReopenStorage

function Tm3StorageHolder.Get_Storage: Im3IndexedStorage;
//#UC START# *542E5D4E01DD_542E5D79018Fget_var*
//#UC END# *542E5D4E01DD_542E5D79018Fget_var*
begin
//#UC START# *542E5D4E01DD_542E5D79018Fget_impl*
 Result := f_Storage;
//#UC END# *542E5D4E01DD_542E5D79018Fget_impl*
end;//Tm3StorageHolder.Get_Storage

function Tm3StorageHolder.StoreToCache(const aFileName: WideString;
 aSharedMode: Cardinal): Im3IndexedStorage;
//#UC START# *542E736E0204_542E5D79018F_var*
var
 l_List : Tm3StorageHolderList;
 l_Index : Integer;
//#UC END# *542E736E0204_542E5D79018F_var*
begin
//#UC START# *542E736E0204_542E5D79018F_impl*
 Assert(f_RootStreamManager <> nil);
 Assert(f_Storage <> nil);
 Result := f_Storage;
 // - отдаём хранилище
 f_Storage := nil;
 // - отпускаем его
 f_FileName := aFileName;
 f_SharedMode := aSharedMode;
 if (aFileName = '') then
 // - нельзя кешировать временные хранилища
  Exit;
 if f_StorageClass.ForPlugin then
 // - для плагина - нечего вообще заморачиваться
  Exit;
 if not f_StorageClass.IsPacked then
 // - непакованные хранилища - это какая-то экзотика
  Exit;
 if (aSharedMode = 0) then
 // - нельзя кешировать монопольные хранилища
  Exit;
(* if (f_Access = STGM_READWRITE) then
 // - давайте пока кешировать хранилища только на чтение
  Exit;*)
 l_List := Tm3StorageHolderList.Instance;
 Assert(l_List <> nil);
 l_List.Lock;
 try
  if not l_List.FindData(Self, l_Index) then
   l_List.Add(Self)
  else
  begin
   if (l_List.Items[l_Index] = Self) then
   // - мы уже закешированы, выходим
    Exit;
   Assert(false, 'Для файла "' + FileName + '" уже есть другой менеджер блоков');
  end;//not l_List.FindData(Self, l_Index)
 finally
  l_List.Unlock;
 end;//try..finally
//#UC END# *542E736E0204_542E5D79018F_impl*
end;//Tm3StorageHolder.StoreToCache

procedure Tm3StorageHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_542E5D79018F_var*
//#UC END# *479731C50290_542E5D79018F_var*
begin
//#UC START# *479731C50290_542E5D79018F_impl*
 FreeAndNil(f_RootStreamManager);
 inherited;
//#UC END# *479731C50290_542E5D79018F_impl*
end;//Tm3StorageHolder.Cleanup

procedure Tm3StorageHolder.ClearFields;
begin
 f_Storage := nil;
 f_FileName := '';
 inherited;
end;//Tm3StorageHolder.ClearFields

end.
