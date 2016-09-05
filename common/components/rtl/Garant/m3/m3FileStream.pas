unit m3FileStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3FileStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3FileStream" MUID: (4FA276920090)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseStream
 , Windows
 , ActiveX
 , m3FileStreamMapView
 , Classes
;

type
 Tm3FileStream = class(Tm3BaseStream)
  private
   FHandle: THandle;
   f_Name: WideString;
   f_SharedMode: LongWord;
  private
   procedure SysCheck(AResult: LongBool);
  protected
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
   procedure LockRegion(anOffset: Int64;
    aSize: Int64;
    aLockType: Integer;
    var theReturn: hResult); override;
   procedure UnlockRegion(anOffset: Int64;
    aSize: Int64;
    aLockType: Integer;
    var theReturn: hResult); override;
   function DoGetSize: Int64; override;
   function DoGetLocksSupported: Integer; override;
   function DoGetName: WideString; override;
  public
   constructor Create(const AName: WideString;
    AAccess: LongWord;
    ASharedMode: LongWord;
    ADistribution: LongWord;
    AFlags: LongWord); reintroduce;
   class function Make(const AName: WideString;
    AAccess: LongWord;
    ASharedMode: LongWord;
    ADistribution: LongWord;
    AFlags: LongWord): IStream; reintroduce;
   function CreateMapView(AProtect: LongWord;
    AAccess: LongWord): Tm3FileStreamMapView;
   procedure Commit(aFlags: Integer;
    var theReturn: hResult); override;
 end;//Tm3FileStream

implementation

uses
 l3ImplUses
 , ComObj
 , SysUtils
 , l3Base
 , m2AddPrc
 , StrUtils
 //#UC START# *4FA276920090impl_uses*
 //#UC END# *4FA276920090impl_uses*
;

procedure Tm3FileStream.SysCheck(AResult: LongBool);
//#UC START# *5481A7080336_4FA276920090_var*
var
 LError      : Integer;
 l_ErrorPrim : Integer;
//#UC END# *5481A7080336_4FA276920090_var*
begin
//#UC START# *5481A7080336_4FA276920090_impl*
 if not(AResult) then
 begin
  l_ErrorPrim := GetLastError;
  LError:=Integer(l_ErrorPrim and $0000ffff);
  case LError of
   ERROR_SUCCESS: ;
   ERROR_INVALID_FUNCTION,
   ERROR_FILE_NOT_FOUND,
   ERROR_PATH_NOT_FOUND,
   ERROR_TOO_MANY_OPEN_FILES,
   ERROR_ACCESS_DENIED,
   ERROR_NOT_ENOUGH_MEMORY,
   ERROR_WRITE_FAULT,
   ERROR_READ_FAULT,
   ERROR_SHARING_VIOLATION,
   ERROR_LOCK_VIOLATION,
   ERROR_DISK_FULL:
    OleError(MakeResult(SEVERITY_ERROR,FACILITY_STORAGE,LError));
   else
   begin
    l3System.Stack2Log(Format('! Системная ошибка %d %d', [l_ErrorPrim,LError]));
    OleError(MakeResult(SEVERITY_ERROR,FACILITY_WIN32,LError));
   end;//else
  end;//case LError
 end;//not(AResult)
//#UC END# *5481A7080336_4FA276920090_impl*
end;//Tm3FileStream.SysCheck

constructor Tm3FileStream.Create(const AName: WideString;
 AAccess: LongWord;
 ASharedMode: LongWord;
 ADistribution: LongWord;
 AFlags: LongWord);
//#UC START# *5481A82803BB_4FA276920090_var*

 function  lGetAccess(const AAccess: LongWord): LongInt;
 begin
  if ((AAccess and (GENERIC_READ or GENERIC_WRITE)) = (GENERIC_READ or GENERIC_WRITE)) then
   Result := STGM_READWRITE
  else
  begin
   if ((AAccess and GENERIC_WRITE) <> 0) then
    Result := STGM_WRITE
   else
    Result := STGM_READ;
  end;
 end;

 function    __CreateFile(const AName: WideString;
                          const AAccess: DWORD;
                          const ASharedMode: DWORD;
                          const ADistribution: DWORD;
                          const AFlags: DWORD;
                          var   AHandle: THandle): BOOL;

  function    __CheckLastError : LongWord;
  begin
   Result := GetLastError;
   SetLastError(Result);
  end;

 resourcestring
  SInfValue = 'File operation';

 const
  CSharedMask = $ffffffff;
 const
  Cm3BasClaDefaultTimeOut = 60 * 1000;
  //Cm3BasClaDefaultTimeOut = 300000;
 var
  LString    : AnsiString;
  LTickCount : LongWord;
  LTimeOut   : LongInt;
 begin
  LTickCount := GetTickCount;
  repeat
   if (Win32Platform = VER_PLATFORM_WIN32_NT) then
    AHandle := CreateFileW(PWideChar(AName),AAccess,(ASharedMode and CSharedMask),nil,ADistribution,AFlags,0)
   else
    AHandle := CreateFileA(m2MakeAnsiString(LString,AName),AAccess,(ASharedMode and CSharedMask),nil,ADistribution,AFlags,0);

   Result := (AHandle <> INVALID_HANDLE_VALUE);

   if (Result or (__CheckLastError <> ERROR_SHARING_VIOLATION)) then
    Exit;

   LTimeOut := LongInt(GetTickCount - LTickCount);

   if (LTimeOut > Cm3BasClaDefaultTimeOut) then
    Break;

   Sleep(0);

  until False;
 end;

//#UC END# *5481A82803BB_4FA276920090_var*
begin
//#UC START# *5481A82803BB_4FA276920090_impl*
 f_Name := aName;
 f_SharedMode := ASharedMode;
 inherited Create(lGetAccess(AAccess));
 try
  SysCheck(__CreateFile(AName,AAccess,ASharedMode,ADistribution,AFlags,FHandle));
 except
  on E: EOleSysError do
  begin
   if (E.ErrorCode = STG_E_FILENOTFOUND) OR (E.ErrorCode = STG_E_PATHNOTFOUND) then
    raise EOleSysError.Create(ANSIReplaceStr(E.Message, '%1', '"' + AName + '"'), E.ErrorCode, E.HelpContext)
   else
    raise;
  end;//on E: EOleSysError
 end;//try..except
//#UC END# *5481A82803BB_4FA276920090_impl*
end;//Tm3FileStream.Create

class function Tm3FileStream.Make(const AName: WideString;
 AAccess: LongWord;
 ASharedMode: LongWord;
 ADistribution: LongWord;
 AFlags: LongWord): IStream;
var
 l_Inst : Tm3FileStream;
begin
 l_Inst := Create(AName, AAccess, ASharedMode, ADistribution, AFlags);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tm3FileStream.Make

function Tm3FileStream.CreateMapView(AProtect: LongWord;
 AAccess: LongWord): Tm3FileStreamMapView;
//#UC START# *5481A8860001_4FA276920090_var*
//#UC END# *5481A8860001_4FA276920090_var*
begin
//#UC START# *5481A8860001_4FA276920090_impl*
 Win32Check(FlushFileBuffers(FHandle));
 if (LongInt(GetFileSize(FHandle, nil)) <> 0) then
  Result := Tm3FileStreamMapView.Create(Self, FHandle, AProtect, AAccess)
 else
  Result := nil;
//#UC END# *5481A8860001_4FA276920090_impl*
end;//Tm3FileStream.CreateMapView

procedure Tm3FileStream.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FA276920090_var*
//#UC END# *479731C50290_4FA276920090_var*
begin
//#UC START# *479731C50290_4FA276920090_impl*
 if (FHandle <> 0) and (FHandle <> INVALID_HANDLE_VALUE) then
 begin
  SysCheck(CloseHandle(FHandle));
  FHandle := 0;
 end;
 inherited;
//#UC END# *479731C50290_4FA276920090_impl*
end;//Tm3FileStream.Cleanup

procedure Tm3FileStream.DoRead(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27CF501C4_4FA276920090_var*
//#UC END# *4FA27CF501C4_4FA276920090_var*
begin
//#UC START# *4FA27CF501C4_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
  SysCheck(Windows.ReadFile(FHandle,ABuff^,LongWord(ASize),LongWord(theResult), nil));
//#UC END# *4FA27CF501C4_4FA276920090_impl*
end;//Tm3FileStream.DoRead

procedure Tm3FileStream.DoWrite(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27D310344_4FA276920090_var*
//#UC END# *4FA27D310344_4FA276920090_var*
begin
//#UC START# *4FA27D310344_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
  SysCheck(Windows.WriteFile(FHandle,ABuff^,LongWord(ASize),LongWord(theResult),nil));
//#UC END# *4FA27D310344_4FA276920090_impl*
end;//Tm3FileStream.DoWrite

procedure Tm3FileStream.DoSeek(anOffset: Int64;
 anOrigin: TSeekOrigin;
 var theResult: Int64;
 var theReturn: hResult);
//#UC START# *4FA27D5302C5_4FA276920090_var*

  function __SetFilePointer(AHandle : THandle;
                            AOrigin : TSeekOrigin;
                            AOffset : Int64;
                            var AResult: Int64): LongBool;
  type
   T64to32 = packed record
    RLoLongWord: LongWord;
    RHiLongWord: LongWord;
   end;//T64to32
  var
   LOffset : Int64;
  begin//__SetFilePointer
   LOffset := AOffset;
   with T64to32(LOffset) do
   begin
    RLoLongWord := SetFilePointer(AHandle,
                                  LongInt(RLoLongWord),
                                  @RHiLongWord,
                                  Ord(AOrigin));
    Result := (RLoLongWord <> LongWord(-1));
   end;//with T64to32(LOffset)
   AResult:=LOffset;
  end;//__SetFilePointer

//#UC END# *4FA27D5302C5_4FA276920090_var*
begin
//#UC START# *4FA27D5302C5_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
  SysCheck(__SetFilePointer(FHandle, anOrigin, anOffset, theResult));
//#UC END# *4FA27D5302C5_4FA276920090_impl*
end;//Tm3FileStream.DoSeek

procedure Tm3FileStream.DoSetSize(aSize: Int64;
 var theReturn: hResult);
//#UC START# *4FA27DCD02B4_4FA276920090_var*
//#UC END# *4FA27DCD02B4_4FA276920090_var*
begin
//#UC START# *4FA27DCD02B4_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
 begin
  OleCheck(Self.IStreamSeek(ASize,STREAM_SEEK_SET,PInt64(nil)^));
  SysCheck(SetEndOfFile(FHandle));
 end;
//#UC END# *4FA27DCD02B4_4FA276920090_impl*
end;//Tm3FileStream.DoSetSize

procedure Tm3FileStream.LockRegion(anOffset: Int64;
 aSize: Int64;
 aLockType: Integer;
 var theReturn: hResult);
//#UC START# *4FA27E100218_4FA276920090_var*

  function __LockFile(const AHandle: THandle;
                      const AOffset: Int64;
                      const ASize: Int64): LongBool;
  type
   T64to32 = packed record
    RLoLongWord: LongWord;
    RHiLongWord: LongWord;
   end;//T64to32
  begin//__LockFile
   Result:=LockFile(AHandle,T64to32(AOffset).RLoLongWord,T64to32(AOffset).RHiLongWord,T64to32(ASize).RLoLongWord,T64to32(ASize).RHiLongWord);
  end;//__LockFile

//#UC END# *4FA27E100218_4FA276920090_var*
begin
//#UC START# *4FA27E100218_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
 begin
  if (ALockType = LOCK_EXCLUSIVE) then
  begin
   if (f_SharedMode <> 0) AND (f_SharedMode <> FILE_SHARE_READ) then
    SysCheck(__LockFile(FHandle, anOffset, ASize))
  end//ALockType = LOCK_EXCLUSIVE
  else
   theReturn := STG_E_INVALIDFUNCTION;
 end;//SUCCEEDED(AReturn)
//#UC END# *4FA27E100218_4FA276920090_impl*
end;//Tm3FileStream.LockRegion

procedure Tm3FileStream.UnlockRegion(anOffset: Int64;
 aSize: Int64;
 aLockType: Integer;
 var theReturn: hResult);
//#UC START# *4FA27E4C0342_4FA276920090_var*

 function  __UnlockFile(const AHandle: THandle;
                        const AOffset: Int64;
                        const ASize: Int64): LongBool;
 type
  T64to32 = packed record
   RLoLongWord : LongWord;
   RHiLongWord : LongWord;
  end;//T64to32
 begin//__UnlockFile
  Result := UnlockFile(AHandle,T64to32(AOffset).RLoLongWord,T64to32(AOffset).RHiLongWord,T64to32(ASize).RLoLongWord,T64to32(ASize).RHiLongWord);
 end;//__UnlockFile

//#UC END# *4FA27E4C0342_4FA276920090_var*
begin
//#UC START# *4FA27E4C0342_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
 begin
  if (ALockType = LOCK_EXCLUSIVE) then
  begin
   if (f_SharedMode <> 0) AND (f_SharedMode <> FILE_SHARE_READ) then
    SysCheck(__UnlockFile(FHandle, anOffset, ASize));
  end//ALockType = LOCK_EXCLUSIVE
  else
   theReturn := STG_E_INVALIDFUNCTION;
 end;//SUCCEEDED(AReturn)
//#UC END# *4FA27E4C0342_4FA276920090_impl*
end;//Tm3FileStream.UnlockRegion

function Tm3FileStream.DoGetSize: Int64;
//#UC START# *4FA2802E0231_4FA276920090_var*

 function __GetFileSize: Int64;
 type
  T64to32 = packed record
   RLoLongWord: LongWord;
   RHiLongWord: LongWord;
  end;//T64to32
 var
  LSize   : Int64;
  LResult : T64to32 absolute LSize;
 begin//__GetFileSize
  LResult.RLoLongWord := Windows.GetFileSize(FHandle, @LResult.RHiLongWord);
  SysCheck(LResult.RLoLongWord <> LongWord(-1));
  Result := LSize;
 end;//__GetFileSize

//#UC END# *4FA2802E0231_4FA276920090_var*
begin
//#UC START# *4FA2802E0231_4FA276920090_impl*
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
(*  SysCheck(JwaWinBase.GetFileSizeEx(FHandle, LARGE_INTEGER(Result)))*)
  Result := __GetFileSize
 else
  Result := __GetFileSize;
(*  Result := inherited pm_GetSize;*)
//#UC END# *4FA2802E0231_4FA276920090_impl*
end;//Tm3FileStream.DoGetSize

function Tm3FileStream.DoGetLocksSupported: Integer;
//#UC START# *4FA2805002E3_4FA276920090_var*
//#UC END# *4FA2805002E3_4FA276920090_var*
begin
//#UC START# *4FA2805002E3_4FA276920090_impl*
 if (f_SharedMode = 0) OR (f_SharedMode = FILE_SHARE_READ) then
  Result := 0
 else
  Result := LOCK_EXCLUSIVE;
//#UC END# *4FA2805002E3_4FA276920090_impl*
end;//Tm3FileStream.DoGetLocksSupported

procedure Tm3FileStream.Commit(aFlags: Integer;
 var theReturn: hResult);
//#UC START# *4FA280DB0288_4FA276920090_var*
//#UC END# *4FA280DB0288_4FA276920090_var*
begin
//#UC START# *4FA280DB0288_4FA276920090_impl*
 if SUCCEEDED(theReturn) then
 begin
  if (AFlags = STGC_DEFAULT) then
   SysCheck(FlushFileBuffers(FHandle))
  else
   theReturn := STG_E_INVALIDFLAG;
 end;//SUCCEEDED(theReturn)
//#UC END# *4FA280DB0288_4FA276920090_impl*
end;//Tm3FileStream.Commit

function Tm3FileStream.DoGetName: WideString;
//#UC START# *5412FB880320_4FA276920090_var*
//#UC END# *5412FB880320_4FA276920090_var*
begin
//#UC START# *5412FB880320_4FA276920090_impl*
 Result := f_Name;
//#UC END# *5412FB880320_4FA276920090_impl*
end;//Tm3FileStream.DoGetName

end.
