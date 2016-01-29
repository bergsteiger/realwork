unit m3TOCHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3TOCHandle.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3TOCHandle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  m3StorageInterfaces,
  l3_String,
  m3Persistent,
  m3RootStreamManagerPrim,
  ActiveX
  ;

type
 Tm3TOCHandle = class(Tm3Persistent)
 private
 // private fields
   f_HandleName : Tl3_String;
    {* Поле для свойства HandleName}
 protected
 // property methods
   procedure pm_SetHandleName(aValue: Tl3_String);
 protected
 // realized methods
   procedure Load(const aStream: IStream); override;
   procedure Save(const aStream: IStream); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure BeforeAddToCache; override;
     {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public fields
   StoreInfo : Tm3StoreInfo;
 public
 // public methods
   constructor Create; reintroduce;
   class function CreateNew(aManager: Tm3RootStreamManagerPrim;
     const aName: Tl3WString;
     aStoreType: Tm3StoreType): Tm3TOCHandle;
 public
 // public properties
   property HandleName: Tl3_String
     read f_HandleName
     write pm_SetHandleName;
     {* имя вхождения директории }
 end;//Tm3TOCHandle

implementation

uses
  l3Chars,
  SysUtils,
  m3Exceptions
  ;

// start class Tm3TOCHandle

constructor Tm3TOCHandle.Create;
//#UC START# *542193BF033E_54219331013F_var*
//#UC END# *542193BF033E_54219331013F_var*
begin
//#UC START# *542193BF033E_54219331013F_impl*
 StoreInfo := Tm3StoreInfo_C(-1, m3_stNone);
 if (f_HandleName = nil) then
  f_HandleName := Tl3_String.Make(CP_Unicode);
 inherited;
//#UC END# *542193BF033E_54219331013F_impl*
end;//Tm3TOCHandle.Create

class function Tm3TOCHandle.CreateNew(aManager: Tm3RootStreamManagerPrim;
  const aName: Tl3WString;
  aStoreType: Tm3StoreType): Tm3TOCHandle;
//#UC START# *5421943000C9_54219331013F_var*
var
 l_TOCItemDataPosition : Int64;
 l_Name                : Tl3_String;
//#UC END# *5421943000C9_54219331013F_var*
begin
//#UC START# *5421943000C9_54219331013F_impl*
 l_Name := Tl3_String.Make(aName);
 try
  l_TOCItemDataPosition := aManager.AllocNewFATElement;
  Em3InvalidStreamPos.Check(aManager.IsValidPosition,
                            l_Name,
                            l_TOCItemDataPosition);
  try
   Result := Self.Create;
   try
    Result.HandleName := l_Name;
    Result.StoreInfo := Tm3StoreInfo_C(l_TOCItemDataPosition, aStoreType);
   except
    FreeAndNil(Result);
    raise;
   end;//try..except
  except
   aManager.RemoveFATElementAtPos(l_TOCItemDataPosition);
   raise;
  end;//try..except
 finally
  FreeAndNil(l_Name);
 end;//try..finally
//#UC END# *5421943000C9_54219331013F_impl*
end;//Tm3TOCHandle.CreateNew

procedure Tm3TOCHandle.pm_SetHandleName(aValue: Tl3_String);
//#UC START# *5421939F018F_54219331013Fset_var*
//#UC END# *5421939F018F_54219331013Fset_var*
begin
//#UC START# *5421939F018F_54219331013Fset_impl*
 if (aValue = nil) then
  FreeAndNil(f_HandleName)
 else
 if (f_HandleName = nil) then
  f_HandleName := Tl3_String.Make(aValue)
 else
  f_HandleName.Assign(aValue); 
//#UC END# *5421939F018F_54219331013Fset_impl*
end;//Tm3TOCHandle.pm_SetHandleName

procedure Tm3TOCHandle.Load(const aStream: IStream);
//#UC START# *542194B001E1_54219331013F_var*
var
 l_I : Integer;
//#UC END# *542194B001E1_54219331013F_var*
begin
//#UC START# *542194B001E1_54219331013F_impl*
 LoadWideString(aStream, HandleName);
 LoadBuff(AStream, @l_I, SizeOf(l_I));
 StoreInfo.rStoreType := l_I;
 LoadBuff(AStream, @StoreInfo.rPosition, SizeOf(StoreInfo.rPosition));
//#UC END# *542194B001E1_54219331013F_impl*
end;//Tm3TOCHandle.Load

procedure Tm3TOCHandle.Save(const aStream: IStream);
//#UC START# *542194C102F7_54219331013F_var*
var
 l_I : Integer;
//#UC END# *542194C102F7_54219331013F_var*
begin
//#UC START# *542194C102F7_54219331013F_impl*
 SaveWideString(aStream, HandleName);
 l_I := StoreInfo.rStoreType;
 SaveBuff(AStream, @l_I, SizeOf(l_I));
 SaveBuff(AStream, @StoreInfo.rPosition, SizeOf(StoreInfo.rPosition));
//#UC END# *542194C102F7_54219331013F_impl*
end;//Tm3TOCHandle.Save

procedure Tm3TOCHandle.Cleanup;
//#UC START# *479731C50290_54219331013F_var*
//#UC END# *479731C50290_54219331013F_var*
begin
//#UC START# *479731C50290_54219331013F_impl*
 HandleName := nil;
 inherited;
//#UC END# *479731C50290_54219331013F_impl*
end;//Tm3TOCHandle.Cleanup

procedure Tm3TOCHandle.BeforeAddToCache;
//#UC START# *479F2B3302C1_54219331013F_var*
//#UC END# *479F2B3302C1_54219331013F_var*
begin
//#UC START# *479F2B3302C1_54219331013F_impl*
 if (f_HandleName <> nil) then
 begin
  if (f_HandleName.RefCount = 1) then
   f_HandleName.BeforeAddToCache
  else
   FreeAndNil(f_HandleName);
 end;//f_HandleName <> nil
 StoreInfo := Tm3StoreInfo_C(-1, m3_stNone);
 inherited;
//#UC END# *479F2B3302C1_54219331013F_impl*
end;//Tm3TOCHandle.BeforeAddToCache

{$If not defined(DesignTimeLibrary)}
class function Tm3TOCHandle.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_54219331013F_var*
//#UC END# *47A6FEE600FC_54219331013F_var*
begin
//#UC START# *47A6FEE600FC_54219331013F_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54219331013F_impl*
end;//Tm3TOCHandle.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.