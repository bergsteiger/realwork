unit m3PrimStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3PrimStream.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseStream
 , Classes
 , m3StorageInterfaces
 , l3Interfaces
 , m2InternalInterfaces
;

type
 _m3BaseStore_Parent_ = Tl3Stream;
 {$Include w:\common\components\rtl\Garant\m3\m3BaseStore.imp.pas}
 Tm3PrimStream = {abstract} class(_m3BaseStore_)
  protected
   procedure DoRead(aBuff: Pointer;
    aSize: Integer;
    var theResult: Integer;
    var theReturn: hResult); virtual;
   procedure DoWrite(aBuff: Pointer;
    aSize: Integer;
    var theResult: Integer;
    var theReturn: hResult); virtual;
   procedure DoSeek(anOffset: Int64;
    anOrigin: TSeekOrigin;
    var theResult: Int64;
    var theReturn: hResult); virtual;
   procedure DoSetSize(aSize: Int64;
    var theReturn: hResult); virtual;
   procedure LockRegion(anOffset: Int64;
    aSize: Int64;
    aLockType: Integer;
    var theReturn: hResult); virtual;
   procedure UnlockRegion(anOffset: Int64;
    aSize: Int64;
    aLockType: Integer;
    var theReturn: hResult); virtual;
   procedure Stat(var theStatStg: TStatStg;
    aStatFlag: Integer;
    var theReturn: hResult); virtual;
   procedure Revert(var theReturn: hResult);
   procedure Clone(var theStream: IStream;
    var theReturn: hResult);
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function DoGetPosition: Int64; override;
   function DoGetSize: Int64; override;
   procedure SetSize(const NewSize: Int64); override;
  public
   procedure Commit(aFlags: Integer;
    var theReturn: hResult); virtual;
   constructor Create(anAccess: Tm3StoreAccess); reintroduce;
   function Read(var Buffer;
    Count: Integer): Integer; override;
   function Write(const Buffer;
    Count: Integer): Integer; override;
   function Seek(const Offset: Int64;
    Origin: TSeekOrigin): Int64; override;
 end;//Tm3PrimStream

implementation

uses
 l3ImplUses
 , Windows
 , m2COMLib
 , ActiveX
 , ComObj
;

{$Include w:\common\components\rtl\Garant\m3\m3BaseStore.imp.pas}

procedure Tm3PrimStream.DoRead(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27CF501C4_5481CCCF0319_var*
//#UC END# *4FA27CF501C4_5481CCCF0319_var*
begin
//#UC START# *4FA27CF501C4_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA27CF501C4_5481CCCF0319_impl*
end;//Tm3PrimStream.DoRead

procedure Tm3PrimStream.DoWrite(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27D310344_5481CCCF0319_var*
//#UC END# *4FA27D310344_5481CCCF0319_var*
begin
//#UC START# *4FA27D310344_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA27D310344_5481CCCF0319_impl*
end;//Tm3PrimStream.DoWrite

procedure Tm3PrimStream.DoSeek(anOffset: Int64;
 anOrigin: TSeekOrigin;
 var theResult: Int64;
 var theReturn: hResult);
//#UC START# *4FA27D5302C5_5481CCCF0319_var*
//#UC END# *4FA27D5302C5_5481CCCF0319_var*
begin
//#UC START# *4FA27D5302C5_5481CCCF0319_impl*
 if SUCCEEDED(theReturn) then
  theReturn := E_NOTIMPL;
//#UC END# *4FA27D5302C5_5481CCCF0319_impl*
end;//Tm3PrimStream.DoSeek

procedure Tm3PrimStream.DoSetSize(aSize: Int64;
 var theReturn: hResult);
//#UC START# *4FA27DCD02B4_5481CCCF0319_var*
//#UC END# *4FA27DCD02B4_5481CCCF0319_var*
begin
//#UC START# *4FA27DCD02B4_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA27DCD02B4_5481CCCF0319_impl*
end;//Tm3PrimStream.DoSetSize

procedure Tm3PrimStream.LockRegion(anOffset: Int64;
 aSize: Int64;
 aLockType: Integer;
 var theReturn: hResult);
//#UC START# *4FA27E100218_5481CCCF0319_var*
//#UC END# *4FA27E100218_5481CCCF0319_var*
begin
//#UC START# *4FA27E100218_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA27E100218_5481CCCF0319_impl*
end;//Tm3PrimStream.LockRegion

procedure Tm3PrimStream.UnlockRegion(anOffset: Int64;
 aSize: Int64;
 aLockType: Integer;
 var theReturn: hResult);
//#UC START# *4FA27E4C0342_5481CCCF0319_var*
//#UC END# *4FA27E4C0342_5481CCCF0319_var*
begin
//#UC START# *4FA27E4C0342_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA27E4C0342_5481CCCF0319_impl*
end;//Tm3PrimStream.UnlockRegion

procedure Tm3PrimStream.Stat(var theStatStg: TStatStg;
 aStatFlag: Integer;
 var theReturn: hResult);
//#UC START# *4FA27E6A001B_5481CCCF0319_var*
//#UC END# *4FA27E6A001B_5481CCCF0319_var*
begin
//#UC START# *4FA27E6A001B_5481CCCF0319_impl*
 if SUCCEEDED(theReturn) then
 begin
  with theStatStg do
  begin
   if (AStatFlag = STATFLAG_NONAME) then
    pwcsName := nil
   else 
    m2COMAllocWideBuff(pwcsName, DoGetName);
   dwType := STGTY_STREAM;
   cbSize := DoGetSize;
   grfMode := DoGetAccess;
   grfLocksSupported := DoGetLocksSupported;
   clsid := GUID_NULL;
   grfStateBits := 0;
  end;//with AStatStg
 end;//SUCCEEDED(theReturn)
//#UC END# *4FA27E6A001B_5481CCCF0319_impl*
end;//Tm3PrimStream.Stat

procedure Tm3PrimStream.Commit(aFlags: Integer;
 var theReturn: hResult);
//#UC START# *4FA280DB0288_5481CCCF0319_var*
//#UC END# *4FA280DB0288_5481CCCF0319_var*
begin
//#UC START# *4FA280DB0288_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA280DB0288_5481CCCF0319_impl*
end;//Tm3PrimStream.Commit

procedure Tm3PrimStream.Revert(var theReturn: hResult);
//#UC START# *4FA2812803CF_5481CCCF0319_var*
//#UC END# *4FA2812803CF_5481CCCF0319_var*
begin
//#UC START# *4FA2812803CF_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA2812803CF_5481CCCF0319_impl*
end;//Tm3PrimStream.Revert

procedure Tm3PrimStream.Clone(var theStream: IStream;
 var theReturn: hResult);
//#UC START# *4FA2814A0215_5481CCCF0319_var*
//#UC END# *4FA2814A0215_5481CCCF0319_var*
begin
//#UC START# *4FA2814A0215_5481CCCF0319_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     theReturn:=E_NOTIMPL;

    end;

//#UC END# *4FA2814A0215_5481CCCF0319_impl*
end;//Tm3PrimStream.Clone

constructor Tm3PrimStream.Create(anAccess: Tm3StoreAccess);
//#UC START# *542178610150_5481CCCF0319_var*
//#UC END# *542178610150_5481CCCF0319_var*
begin
//#UC START# *542178610150_5481CCCF0319_impl*
 inherited Create(anAccess);
//#UC END# *542178610150_5481CCCF0319_impl*
end;//Tm3PrimStream.Create

{$If NOT Defined(DesignTimeLibrary)}
class function Tm3PrimStream.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_5481CCCF0319_var*
//#UC END# *47A6FEE600FC_5481CCCF0319_var*
begin
//#UC START# *47A6FEE600FC_5481CCCF0319_impl*
 Result := true;
//#UC END# *47A6FEE600FC_5481CCCF0319_impl*
end;//Tm3PrimStream.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function Tm3PrimStream.Read(var Buffer;
 Count: Integer): Integer;
//#UC START# *49BE656C006E_5481CCCF0319_var*
var
 l_Return : hResult;
//#UC END# *49BE656C006E_5481CCCF0319_var*
begin
//#UC START# *49BE656C006E_5481CCCF0319_impl*
 Result := 0;
 l_Return := S_Ok;
 DoRead(@Buffer, Count, Result, l_Return);
 OleCheck(l_Return);
//#UC END# *49BE656C006E_5481CCCF0319_impl*
end;//Tm3PrimStream.Read

function Tm3PrimStream.Write(const Buffer;
 Count: Integer): Integer;
//#UC START# *49BE658C0261_5481CCCF0319_var*
var
 l_Return : hResult;
//#UC END# *49BE658C0261_5481CCCF0319_var*
begin
//#UC START# *49BE658C0261_5481CCCF0319_impl*
 Result := 0;
 l_Return := S_Ok;
 DoWrite(@Buffer, Count, Result, l_Return);
 OleCheck(l_Return);
//#UC END# *49BE658C0261_5481CCCF0319_impl*
end;//Tm3PrimStream.Write

function Tm3PrimStream.Seek(const Offset: Int64;
 Origin: TSeekOrigin): Int64;
//#UC START# *49BE65E80020_5481CCCF0319_var*
var
 l_Return : hResult;
//#UC END# *49BE65E80020_5481CCCF0319_var*
begin
//#UC START# *49BE65E80020_5481CCCF0319_impl*
 Result := 0;
 l_Return := S_Ok;
 DoSeek(Offset, Origin, Result, l_Return);
 OleCheck(l_Return);
//#UC END# *49BE65E80020_5481CCCF0319_impl*
end;//Tm3PrimStream.Seek

function Tm3PrimStream.DoGetPosition: Int64;
//#UC START# *4FA280090314_5481CCCF0319_var*
var
 l_Return : hResult;
//#UC END# *4FA280090314_5481CCCF0319_var*
begin
//#UC START# *4FA280090314_5481CCCF0319_impl*
 Result := 0;
 l_Return := S_Ok;
 DoSeek(0,soCurrent,Result,l_Return);
 OleCheck(l_Return);
//#UC END# *4FA280090314_5481CCCF0319_impl*
end;//Tm3PrimStream.DoGetPosition

function Tm3PrimStream.DoGetSize: Int64;
//#UC START# *4FA2802E0231_5481CCCF0319_var*
var
 LPosition : Int64;
 l_Return : hResult;
 l_Fake : Int64;
//#UC END# *4FA2802E0231_5481CCCF0319_var*
begin
//#UC START# *4FA2802E0231_5481CCCF0319_impl*
 Result := 0;
 l_Return := S_Ok;
 DoSeek(0,soCurrent,LPosition,l_Return);
 OleCheck(l_Return);
 try
  DoSeek(0,soEnd,Result,l_Return);
  OleCheck(l_Return);
 finally
  DoSeek(LPosition,soBeginning,l_Fake,l_Return);
  OleCheck(l_Return);
 end;//try..finally
//#UC END# *4FA2802E0231_5481CCCF0319_impl*
end;//Tm3PrimStream.DoGetSize

procedure Tm3PrimStream.SetSize(const NewSize: Int64);
//#UC START# *5481E0EE0096_5481CCCF0319_var*
var
 l_Return : hResult;
//#UC END# *5481E0EE0096_5481CCCF0319_var*
begin
//#UC START# *5481E0EE0096_5481CCCF0319_impl*
 l_Return := S_Ok;
 DoSetSize(NewSize, l_Return);
 OleCheck(l_Return);
//#UC END# *5481E0EE0096_5481CCCF0319_impl*
end;//Tm3PrimStream.SetSize

end.
