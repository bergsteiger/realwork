unit m3BaseHeaderStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3BaseHeaderStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::HeaderStream::Tm3BaseHeaderStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3LinkedStream,
  m3Const,
  Classes
  ;

const
  { Defaults }
 cHeaderFullSize = m3Const.Cm3BasClaDefHeaderSize;

type
 Tm3BaseHeaderStream = class(Tm3LinkedStream)
 private
 // private fields
   FHeaderLocked : Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoSeek(anOffset: Int64;
     anOrigin: TSeekOrigin;
     var theResult: Int64;
     var theReturn: hResult); override;
   procedure DoSetSize(aSize: Int64;
     var theReturn: hResult); override;
   procedure LockRegion(anOffset: Int64;
     aSize: Int64;
     aLockType: Integer;
     var theReturn: hResult); override;
   procedure UnlockRegion(anOffset: Int64;
     aSize: Int64;
     aLockType: Integer;
     var theReturn: hResult); override;
   function DoGetSize: Int64; override;
 protected
 // protected fields
   FHeaderSize : Integer;
   FHeaderLoaded : Integer;
 protected
 // protected methods
   procedure DefaultInitAction; virtual;
   procedure DefaultDoneAction; virtual;
   function DoLockHeader: Boolean; virtual;
   function DoUnlockHeader: Boolean; virtual;
 public
 // public methods
   procedure LockHeader;
     {* закрывает заголовок }
   procedure UnlockHeader;
     {* открывает заголовок }
   procedure DoSaveHeader(aForceSave: Boolean); virtual; abstract;
     {* сохраняет заголовок }
   procedure DoLoadHeader; virtual; abstract;
     {* загружает заголовок в память }
   procedure LoadHeader;
     {* Сигнатура метода LoadHeader }
   procedure SaveHeader(aForceSave: Boolean = false);
 end;//Tm3BaseHeaderStream

implementation

uses
  ComObj,
  m2COMLib,
  ActiveX,
  l3Base,
  l3Interlocked
  ;

// start class Tm3BaseHeaderStream

procedure Tm3BaseHeaderStream.LockHeader;
//#UC START# *53FDFE220358_53FF134A03BA_var*
//#UC END# *53FDFE220358_53FF134A03BA_var*
begin
//#UC START# *53FDFE220358_53FF134A03BA_impl*
 Assert(FHeaderSize > CAnyGUIDLength);
 if (FHeaderLocked = 0) then
  DoLockHeader;
 l3InterlockedIncrement(FHeaderLocked);
//#UC END# *53FDFE220358_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.LockHeader

procedure Tm3BaseHeaderStream.UnlockHeader;
//#UC START# *53FDFE3802D0_53FF134A03BA_var*
//#UC END# *53FDFE3802D0_53FF134A03BA_var*
begin
//#UC START# *53FDFE3802D0_53FF134A03BA_impl*
 Assert(FHeaderSize > CAnyGUIDLength);
 if (l3InterlockedDecrement(FHeaderLocked) = 0) then
  DoUnlockHeader;
//#UC END# *53FDFE3802D0_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.UnlockHeader

procedure Tm3BaseHeaderStream.LoadHeader;
//#UC START# *53FF1F6901C5_53FF134A03BA_var*
//#UC END# *53FF1F6901C5_53FF134A03BA_var*
begin
//#UC START# *53FF1F6901C5_53FF134A03BA_impl*
 if (FHeaderLoaded = 0) then
  if (InnerStream <> nil) AND (m2COMGetStatStgMode(InnerStream) AND STGM_WRITE = 0) then
   // - мы не можем считать Header - значит он уже должен быть у нас
  begin
   LockHeader;
   try
    DoLoadHeader;
   finally
    UnlockHeader;
   end;//try..finally
  end;//_Stream <> nil..
 l3InterlockedIncrement(FHeaderLoaded);
//#UC END# *53FF1F6901C5_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.LoadHeader

procedure Tm3BaseHeaderStream.SaveHeader(aForceSave: Boolean = false);
//#UC START# *53FF1F90030A_53FF134A03BA_var*
//#UC END# *53FF1F90030A_53FF134A03BA_var*
begin
//#UC START# *53FF1F90030A_53FF134A03BA_impl*
 if (l3InterlockedDecrement(FHeaderLoaded) = 0) then
  if (InnerStream <> nil) AND not ReadOnly then
  begin
   LockHeader;
   try
    DoSaveHeader(aForceSave);
   finally
    UnlockHeader;
   end;//try..finally
  end;//FHeaderLoaded = 0..
//#UC END# *53FF1F90030A_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.SaveHeader

procedure Tm3BaseHeaderStream.DefaultInitAction;
//#UC START# *53FDFD1D0164_53FF134A03BA_var*
//#UC END# *53FDFD1D0164_53FF134A03BA_var*
begin
//#UC START# *53FDFD1D0164_53FF134A03BA_impl*
 LoadHeader;
//#UC END# *53FDFD1D0164_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DefaultInitAction

procedure Tm3BaseHeaderStream.DefaultDoneAction;
//#UC START# *53FDFD34034B_53FF134A03BA_var*
//#UC END# *53FDFD34034B_53FF134A03BA_var*
begin
//#UC START# *53FDFD34034B_53FF134A03BA_impl*
 SaveHeader;
//#UC END# *53FDFD34034B_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DefaultDoneAction

function Tm3BaseHeaderStream.DoLockHeader: Boolean;
//#UC START# *540F07260255_53FF134A03BA_var*
//#UC END# *540F07260255_53FF134A03BA_var*
begin
//#UC START# *540F07260255_53FF134A03BA_impl*
 Result := m2COMTimeLock(InnerStream, CAnyGUIDLength, Int64(FHeaderSize) - CAnyGUIDLength);
//#UC END# *540F07260255_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DoLockHeader

function Tm3BaseHeaderStream.DoUnlockHeader: Boolean;
//#UC START# *540F072F02B4_53FF134A03BA_var*
//#UC END# *540F072F02B4_53FF134A03BA_var*
begin
//#UC START# *540F072F02B4_53FF134A03BA_impl*
 Result := m2COMTimeUnlock(InnerStream, CAnyGUIDLength, Int64(FHeaderSize) - CAnyGUIDLength);
//#UC END# *540F072F02B4_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DoUnlockHeader

procedure Tm3BaseHeaderStream.Cleanup;
//#UC START# *479731C50290_53FF134A03BA_var*
//#UC END# *479731C50290_53FF134A03BA_var*
begin
//#UC START# *479731C50290_53FF134A03BA_impl*
 FHeaderSize := 0;
 FHeaderLocked := 0;
 FHeaderLoaded := 0;
 inherited;
//#UC END# *479731C50290_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.Cleanup

procedure Tm3BaseHeaderStream.DoSeek(anOffset: Int64;
  anOrigin: TSeekOrigin;
  var theResult: Int64;
  var theReturn: hResult);
//#UC START# *4FA27D5302C5_53FF134A03BA_var*
var
 LOffset : Int64;
//#UC END# *4FA27D5302C5_53FF134A03BA_var*
begin
//#UC START# *4FA27D5302C5_53FF134A03BA_impl*
 if SUCCEEDED(theReturn) then
 begin
  if (anOrigin = soBeginning) then
   LOffset := anOffset + Int64(FHeaderSize)
  else
  if (anOrigin = soEnd) then
  begin
   Assert(anOffset = 0, 'Если это всплывёт, то можно этот Assert временно закомментирровать');
   LOffset := anOffset;
  end//AOrigin = soEnd
  else
   LOffset := anOffset;
  theResult := m2COMSeek(InnerStream, LOffset, Ord(anOrigin)) - Int64(FHeaderSize);
 end;//SUCCEEDED(AReturn)
//#UC END# *4FA27D5302C5_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DoSeek

procedure Tm3BaseHeaderStream.DoSetSize(aSize: Int64;
  var theReturn: hResult);
//#UC START# *4FA27DCD02B4_53FF134A03BA_var*
//#UC END# *4FA27DCD02B4_53FF134A03BA_var*
begin
//#UC START# *4FA27DCD02B4_53FF134A03BA_impl*
 if SUCCEEDED(theReturn) then
  theReturn := InnerStream.SetSize(aSize + Int64(FHeaderSize));
//#UC END# *4FA27DCD02B4_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DoSetSize

procedure Tm3BaseHeaderStream.LockRegion(anOffset: Int64;
  aSize: Int64;
  aLockType: Integer;
  var theReturn: hResult);
//#UC START# *4FA27E100218_53FF134A03BA_var*
//#UC END# *4FA27E100218_53FF134A03BA_var*
begin
//#UC START# *4FA27E100218_53FF134A03BA_impl*
 if SUCCEEDED(theReturn) then
  theReturn := InnerStream.LockRegion(Int64(FHeaderSize) + anOffset, aSize, aLockType);
//#UC END# *4FA27E100218_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.LockRegion

procedure Tm3BaseHeaderStream.UnlockRegion(anOffset: Int64;
  aSize: Int64;
  aLockType: Integer;
  var theReturn: hResult);
//#UC START# *4FA27E4C0342_53FF134A03BA_var*
//#UC END# *4FA27E4C0342_53FF134A03BA_var*
begin
//#UC START# *4FA27E4C0342_53FF134A03BA_impl*
 if SUCCEEDED(theReturn) then
  theReturn := InnerStream.UnlockRegion(Int64(FHeaderSize) + anOffset, aSize, aLockType);
//#UC END# *4FA27E4C0342_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.UnlockRegion

function Tm3BaseHeaderStream.DoGetSize: Int64;
//#UC START# *4FA2802E0231_53FF134A03BA_var*
//#UC END# *4FA2802E0231_53FF134A03BA_var*
begin
//#UC START# *4FA2802E0231_53FF134A03BA_impl*
 Result := {m2COMGetStatStgSize}m2COMGetSize(InnerStream) - Int64(FHeaderSize);
//#UC END# *4FA2802E0231_53FF134A03BA_impl*
end;//Tm3BaseHeaderStream.DoGetSize

end.