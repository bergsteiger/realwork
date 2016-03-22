unit m3RootStreamManagerPrimPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrimPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3RootStreamManagerPrimPrim" MUID: (543F7EF202C6)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Logger
 , l3CustomString
 , m3FileRegion
 , SyncObjs
;

type
 _l3CriticalSectionHolder_Parent_ = Tl3CProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3RootStreamManagerPrimPrim = {abstract} class(_l3CriticalSectionHolder_)
  private
   f_Logger: Tl3Logger;
    {* Поле для свойства Logger }
  protected
   function DoIsValidPosition(aPosition: Int64;
    aName: Tl3CustomString): Boolean; virtual;
   procedure DoUnlockRegion(aForRead: Boolean;
    const aRegion: Tm3FileRegion); virtual; abstract;
   procedure DoLockRegion(aForRead: Boolean;
    const aRegion: Tm3FileRegion); virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure ReadData(aPosition: Int64;
    out aData;
    aSize: Integer); virtual; abstract;
   procedure WriteData(aPosition: Int64;
    const aData;
    aSize: Integer); virtual; abstract;
   function AllocatedStreamSize: Int64; virtual; abstract;
   procedure SetPositionAndValidateIt(aPosition: Int64;
    var thePosition: Int64); virtual; abstract;
   constructor Create(aLogger: Tl3Logger); reintroduce;
   function IsValidLink(aPosition: Int64;
    aName: Tl3CustomString): Boolean;
   function IsValidPosition(aPosition: Int64;
    aName: Tl3CustomString): Boolean;
   procedure LockRegion(aForRead: Boolean;
    const aRegion: Tm3FileRegion);
   procedure UnlockRegion(aForRead: Boolean;
    const aRegion: Tm3FileRegion);
   procedure ReloadHeader(aName: Tl3CustomString); virtual; abstract;
   procedure ReadDataAtCurrent(out aData;
    aSize: Integer); virtual; abstract;
   function ClusterBodySize: Int64; virtual; abstract;
   function AllocNewCluster: Int64; virtual; abstract;
   function ClusterHeaderSize: Int64; virtual; abstract;
   function ClusterSize: Int64;
   procedure RemoveTOCBuffData(var ATOCBuffDataPosition: Int64); virtual; abstract;
  public
   property Logger: Tl3Logger
    read f_Logger;
 end;//Tm3RootStreamManagerPrimPrim

implementation

uses
 l3ImplUses
 , m2COMLib
 , SysUtils
 , l3Base
;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

constructor Tm3RootStreamManagerPrimPrim.Create(aLogger: Tl3Logger);
//#UC START# *543F9D22008D_543F7EF202C6_var*
//#UC END# *543F9D22008D_543F7EF202C6_var*
begin
//#UC START# *543F9D22008D_543F7EF202C6_impl*
 aLogger.SetRefTo(f_Logger);
 inherited Create;
//#UC END# *543F9D22008D_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.Create

function Tm3RootStreamManagerPrimPrim.IsValidLink(aPosition: Int64;
 aName: Tl3CustomString): Boolean;
//#UC START# *540EFD670025_543F7EF202C6_var*
//#UC END# *540EFD670025_543F7EF202C6_var*
begin
//#UC START# *540EFD670025_543F7EF202C6_impl*
 if (aPosition = -1) then
  Result := true
 else
  Result := IsValidPosition(aPosition, aName); 
//#UC END# *540EFD670025_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.IsValidLink

function Tm3RootStreamManagerPrimPrim.DoIsValidPosition(aPosition: Int64;
 aName: Tl3CustomString): Boolean;
//#UC START# *540EFD500389_543F7EF202C6_var*
//#UC END# *540EFD500389_543F7EF202C6_var*
begin
//#UC START# *540EFD500389_543F7EF202C6_impl*
 Result := (aPosition <= Self.AllocatedStreamSize);
//#UC END# *540EFD500389_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.DoIsValidPosition

function Tm3RootStreamManagerPrimPrim.IsValidPosition(aPosition: Int64;
 aName: Tl3CustomString): Boolean;
//#UC START# *543FA0F703D6_543F7EF202C6_var*
var
 l_S : String;
//#UC END# *543FA0F703D6_543F7EF202C6_var*
begin
//#UC START# *543FA0F703D6_543F7EF202C6_impl*
 if (aPosition = High(aPosition)) then
  Result := false
 else 
 if (aPosition < 0) then
  Result := false
 else
 begin
  Result := DoIsValidPosition(aPosition, aName);
  if not Result then
  begin
   l_S := 'Не удалось провалидировать позицию, в потоке: ' + aName.AsString;
   if (Logger <> nil) then
    Logger.ToLog(l_S);
   l3System.Stack2Log(l_S);
  end;//not Result
 end;//aPosition < 0
//#UC END# *543FA0F703D6_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.IsValidPosition

procedure Tm3RootStreamManagerPrimPrim.LockRegion(aForRead: Boolean;
 const aRegion: Tm3FileRegion);
//#UC START# *543FAAB80195_543F7EF202C6_var*
//#UC END# *543FAAB80195_543F7EF202C6_var*
begin
//#UC START# *543FAAB80195_543F7EF202C6_impl*
 Assert(Self <> nil);
 DoLockRegion(aForRead, aRegion);
//#UC END# *543FAAB80195_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.LockRegion

procedure Tm3RootStreamManagerPrimPrim.UnlockRegion(aForRead: Boolean;
 const aRegion: Tm3FileRegion);
//#UC START# *543FAAD0011B_543F7EF202C6_var*
//#UC END# *543FAAD0011B_543F7EF202C6_var*
begin
//#UC START# *543FAAD0011B_543F7EF202C6_impl*
 Assert(Self <> nil);
 DoUnlockRegion(aForRead, aRegion);
//#UC END# *543FAAD0011B_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.UnlockRegion

function Tm3RootStreamManagerPrimPrim.ClusterSize: Int64;
//#UC START# *54253CF402B1_543F7EF202C6_var*
//#UC END# *54253CF402B1_543F7EF202C6_var*
begin
//#UC START# *54253CF402B1_543F7EF202C6_impl*
 Assert(Self <> nil);
 Result := Self.ClusterHeaderSize + Self.ClusterBodySize;
//#UC END# *54253CF402B1_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.ClusterSize

procedure Tm3RootStreamManagerPrimPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_543F7EF202C6_var*
//#UC END# *479731C50290_543F7EF202C6_var*
begin
//#UC START# *479731C50290_543F7EF202C6_impl*
 inherited;
 FreeAndNil(f_Logger);
//#UC END# *479731C50290_543F7EF202C6_impl*
end;//Tm3RootStreamManagerPrimPrim.Cleanup

end.
