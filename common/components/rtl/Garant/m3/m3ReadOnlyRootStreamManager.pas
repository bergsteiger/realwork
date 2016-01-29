unit m3ReadOnlyRootStreamManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3ReadOnlyRootStreamManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3ReadOnlyRootStreamManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3RootStreamManagerPrim,
  l3CustomString,
  m3FileRegion,
  m3StoreHeaderDataPrim
  ;

type
 Tm3ReadOnlyRootStreamManager = class(Tm3RootStreamManagerPrim)
 private
 // private fields
   f_Other : Tm3RootStreamManagerPrim;
 protected
 // realized methods
   procedure DoLockRegion(aForRead: Boolean;
     const aRegion: Tm3FileRegion); override;
   procedure DoUnlockRegion(aForRead: Boolean;
     const aRegion: Tm3FileRegion); override;
   function StoreHeaderDataClass: Rm3StoreHeaderDataPrim; override;
   function pm_GetRootStorageFATElement: Int64; override;
   procedure RemoveTOCBuffData(var ATOCBuffDataPosition: Int64); override;
   function AllocNewFATElement: Int64; override;
   procedure RemoveFATElementAtPos(aPosition: Int64); override;
   function ClusterHeaderSize: Int64; override;
   function ClusterBodySize: Int64; override;
   function AllocNewCluster: Int64; override;
   function ReadOnly: Boolean; override;
   procedure ReadData(aPosition: Int64;
     out aData;
     aSize: Integer); override;
   procedure WriteData(aPosition: Int64;
     const aData;
     aSize: Integer); override;
   function AllocatedStreamSize: Int64; override;
   procedure SetPositionAndValidateIt(aPosition: Int64;
     var thePosition: Int64); override;
   procedure ReloadHeader(aName: Tl3CustomString); override;
   procedure ReadDataAtCurrent(out aData;
     aSize: Integer); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoIsValidPosition(aPosition: Int64;
     aName: Tl3CustomString): Boolean; override;
 public
 // public methods
   constructor Create(anOther: Tm3RootStreamManagerPrim); reintroduce;
 end;//Tm3ReadOnlyRootStreamManager

implementation

uses
  SysUtils
  ;

// start class Tm3ReadOnlyRootStreamManager

constructor Tm3ReadOnlyRootStreamManager.Create(anOther: Tm3RootStreamManagerPrim);
//#UC START# *544102A6036C_5441022F00F3_var*
//#UC END# *544102A6036C_5441022F00F3_var*
begin
//#UC START# *544102A6036C_5441022F00F3_impl*
 Assert(anOther <> nil);
 anOther.SetrefTo(f_Other);
 inherited Create(anOther.Logger);
//#UC END# *544102A6036C_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.Create

procedure Tm3ReadOnlyRootStreamManager.DoLockRegion(aForRead: Boolean;
  const aRegion: Tm3FileRegion);
//#UC START# *541021B90213_5441022F00F3_var*
//#UC END# *541021B90213_5441022F00F3_var*
begin
//#UC START# *541021B90213_5441022F00F3_impl*
 f_Other.LockRegion(true{aForRead}, aRegion);
//#UC END# *541021B90213_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.DoLockRegion

procedure Tm3ReadOnlyRootStreamManager.DoUnlockRegion(aForRead: Boolean;
  const aRegion: Tm3FileRegion);
//#UC START# *541021E4022F_5441022F00F3_var*
//#UC END# *541021E4022F_5441022F00F3_var*
begin
//#UC START# *541021E4022F_5441022F00F3_impl*
 f_Other.UnlockRegion(true{aForRead}, aRegion);
//#UC END# *541021E4022F_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.DoUnlockRegion

function Tm3ReadOnlyRootStreamManager.StoreHeaderDataClass: Rm3StoreHeaderDataPrim;
//#UC START# *5411A48C0040_5441022F00F3_var*
//#UC END# *5411A48C0040_5441022F00F3_var*
begin
//#UC START# *5411A48C0040_5441022F00F3_impl*
 Result := f_Other.StoreHeaderDataClass; 
//#UC END# *5411A48C0040_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.StoreHeaderDataClass

function Tm3ReadOnlyRootStreamManager.pm_GetRootStorageFATElement: Int64;
//#UC START# *5411B3280387_5441022F00F3get_var*
//#UC END# *5411B3280387_5441022F00F3get_var*
begin
//#UC START# *5411B3280387_5441022F00F3get_impl*
 Result := f_Other.RootStorageFATElement;
//#UC END# *5411B3280387_5441022F00F3get_impl*
end;//Tm3ReadOnlyRootStreamManager.pm_GetRootStorageFATElement

procedure Tm3ReadOnlyRootStreamManager.RemoveTOCBuffData(var ATOCBuffDataPosition: Int64);
//#UC START# *5411C6960184_5441022F00F3_var*
//#UC END# *5411C6960184_5441022F00F3_var*
begin
//#UC START# *5411C6960184_5441022F00F3_impl*
 Assert(false, 'Хранилище только на чтение');
//#UC END# *5411C6960184_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.RemoveTOCBuffData

function Tm3ReadOnlyRootStreamManager.AllocNewFATElement: Int64;
//#UC START# *5423BF3603A1_5441022F00F3_var*
//#UC END# *5423BF3603A1_5441022F00F3_var*
begin
//#UC START# *5423BF3603A1_5441022F00F3_impl*
 Result := -1;
 Assert(false, 'Хранилище только на чтение');
//#UC END# *5423BF3603A1_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.AllocNewFATElement

procedure Tm3ReadOnlyRootStreamManager.RemoveFATElementAtPos(aPosition: Int64);
//#UC START# *5423BF5A00DC_5441022F00F3_var*
//#UC END# *5423BF5A00DC_5441022F00F3_var*
begin
//#UC START# *5423BF5A00DC_5441022F00F3_impl*
 Assert(false, 'Хранилище только на чтение');
//#UC END# *5423BF5A00DC_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.RemoveFATElementAtPos

function Tm3ReadOnlyRootStreamManager.ClusterHeaderSize: Int64;
//#UC START# *54253CB801D8_5441022F00F3_var*
//#UC END# *54253CB801D8_5441022F00F3_var*
begin
//#UC START# *54253CB801D8_5441022F00F3_impl*
 Result := f_Other.ClusterHeaderSize;
//#UC END# *54253CB801D8_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.ClusterHeaderSize

function Tm3ReadOnlyRootStreamManager.ClusterBodySize: Int64;
//#UC START# *5425479101D1_5441022F00F3_var*
//#UC END# *5425479101D1_5441022F00F3_var*
begin
//#UC START# *5425479101D1_5441022F00F3_impl*
 Result := f_Other.ClusterBodySize;
//#UC END# *5425479101D1_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.ClusterBodySize

function Tm3ReadOnlyRootStreamManager.AllocNewCluster: Int64;
//#UC START# *5429114F00E8_5441022F00F3_var*
//#UC END# *5429114F00E8_5441022F00F3_var*
begin
//#UC START# *5429114F00E8_5441022F00F3_impl*
 Result := -1;
 Assert(false, 'Хранилище только на чтение');
//#UC END# *5429114F00E8_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.AllocNewCluster

function Tm3ReadOnlyRootStreamManager.ReadOnly: Boolean;
//#UC START# *542E69CA007F_5441022F00F3_var*
//#UC END# *542E69CA007F_5441022F00F3_var*
begin
//#UC START# *542E69CA007F_5441022F00F3_impl*
 Result := true;
//#UC END# *542E69CA007F_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.ReadOnly

procedure Tm3ReadOnlyRootStreamManager.ReadData(aPosition: Int64;
  out aData;
  aSize: Integer);
//#UC START# *543F8E8F0358_5441022F00F3_var*
//#UC END# *543F8E8F0358_5441022F00F3_var*
begin
//#UC START# *543F8E8F0358_5441022F00F3_impl*
 f_Other.ReadData(aPosition, aData, aSize);
//#UC END# *543F8E8F0358_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.ReadData

procedure Tm3ReadOnlyRootStreamManager.WriteData(aPosition: Int64;
  const aData;
  aSize: Integer);
//#UC START# *543F8ED700E2_5441022F00F3_var*
//#UC END# *543F8ED700E2_5441022F00F3_var*
begin
//#UC START# *543F8ED700E2_5441022F00F3_impl*
 Assert(false, 'Хранилище только на чтение');
//#UC END# *543F8ED700E2_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.WriteData

function Tm3ReadOnlyRootStreamManager.AllocatedStreamSize: Int64;
//#UC START# *543F90700143_5441022F00F3_var*
//#UC END# *543F90700143_5441022F00F3_var*
begin
//#UC START# *543F90700143_5441022F00F3_impl*
 Result := f_Other.AllocatedStreamSize;
//#UC END# *543F90700143_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.AllocatedStreamSize

procedure Tm3ReadOnlyRootStreamManager.SetPositionAndValidateIt(aPosition: Int64;
  var thePosition: Int64);
//#UC START# *543F960901AE_5441022F00F3_var*
//#UC END# *543F960901AE_5441022F00F3_var*
begin
//#UC START# *543F960901AE_5441022F00F3_impl*
 f_Other.SetPositionAndValidateIt(aPosition, thePosition);
//#UC END# *543F960901AE_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.SetPositionAndValidateIt

procedure Tm3ReadOnlyRootStreamManager.ReloadHeader(aName: Tl3CustomString);
//#UC START# *543FAEB90303_5441022F00F3_var*
//#UC END# *543FAEB90303_5441022F00F3_var*
begin
//#UC START# *543FAEB90303_5441022F00F3_impl*
 f_Other.ReloadHeader(aName);
//#UC END# *543FAEB90303_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.ReloadHeader

procedure Tm3ReadOnlyRootStreamManager.ReadDataAtCurrent(out aData;
  aSize: Integer);
//#UC START# *54411B71009B_5441022F00F3_var*
//#UC END# *54411B71009B_5441022F00F3_var*
begin
//#UC START# *54411B71009B_5441022F00F3_impl*
 f_Other.ReadDataAtCurrent(aData, aSize);
//#UC END# *54411B71009B_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.ReadDataAtCurrent

procedure Tm3ReadOnlyRootStreamManager.Cleanup;
//#UC START# *479731C50290_5441022F00F3_var*
//#UC END# *479731C50290_5441022F00F3_var*
begin
//#UC START# *479731C50290_5441022F00F3_impl*
 FreeAndnil(f_Other);
 inherited;
//#UC END# *479731C50290_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.Cleanup

function Tm3ReadOnlyRootStreamManager.DoIsValidPosition(aPosition: Int64;
  aName: Tl3CustomString): Boolean;
//#UC START# *540EFD500389_5441022F00F3_var*
//#UC END# *540EFD500389_5441022F00F3_var*
begin
//#UC START# *540EFD500389_5441022F00F3_impl*
 Result := inherited DoIsValidPosition(aPosition, aName);
 if not Result then
 begin
  ReloadHeader(aName);
  Result := inherited DoIsValidPosition(aPosition, aName);
 end;//not Result
//#UC END# *540EFD500389_5441022F00F3_impl*
end;//Tm3ReadOnlyRootStreamManager.DoIsValidPosition

end.