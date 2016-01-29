unit atFileBasedSemaphore;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atFileBasedSemaphore.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatFileBasedSemaphore
//
// Обеспечивает функциональность в стиле семафора. Работает на файлах.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  Windows
  ;

const
  { WaitConsts }
 FBS_WAIT_FOREVER = -1;

type
 TatFileBasedSemaphore = class(TObject)
  {* Обеспечивает функциональность в стиле семафора. Работает на файлах. }
 private
 // private fields
   f_FileName : AnsiString;
   f_MaxEnteredCount : Integer;
   f_LocksCount : Integer;
   f_WriteHandle : THandle;
   f_ReadHandle : THandle;
   f_IsEntered : Boolean;
 private
 // private methods
   function LockForWrite(const aTimeOut: Int64 = FBS_WAIT_FOREVER): Boolean; virtual;
   procedure UnlockForWrite; virtual;
   function GetCurrEnteredCount: Integer; virtual;
   procedure SetCurrEnteredCount(const aCount: Integer); virtual;
   function OpenFile(const aAccessMode: DWORD;
    const aShareMode: DWORD): THandle; virtual;
   function OpenForRead: Boolean; virtual;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create(const aFileName: AnsiString;
    const aMaxEnteredCount: Integer = 1); reintroduce;
   function Enter(const aTimeOut: Int64 = FBS_WAIT_FOREVER): Boolean; virtual;
   procedure Leave; virtual;
 end;//TatFileBasedSemaphore

implementation

uses
  Classes,
  SysUtils,
  DateUtils
  ;

// start class TatFileBasedSemaphore

constructor TatFileBasedSemaphore.Create(const aFileName: AnsiString;
  const aMaxEnteredCount: Integer = 1);
//#UC START# *4A4DFFB801BA_4A4DFF7800C9_var*
  const
    WAIT_TIME = 300;
//#UC END# *4A4DFFB801BA_4A4DFF7800C9_var*
begin
//#UC START# *4A4DFFB801BA_4A4DFF7800C9_impl*
  inherited Create;
  f_MaxEnteredCount := aMaxEnteredCount;
  f_FileName := aFileName;
  f_LocksCount := 0;
  f_WriteHandle := INVALID_HANDLE_VALUE;
  f_ReadHandle := INVALID_HANDLE_VALUE;
  f_IsEntered := false;
  //
  // проверяем, смотрит ли кто-то на этот файл
  f_ReadHandle := OpenFile(GENERIC_READ, FILE_SHARE_WRITE);
  if f_ReadHandle <> INVALID_HANDLE_VALUE then // никто не держит, значит чистим его
    if LockForWrite() then
      try
        SetCurrEnteredCount(0);
        CloseHandle(f_ReadHandle);
      finally
        UnlockForWrite();
      end;
  // открываем файл на чтение
  while NOT OpenForRead() do Sleep(WAIT_TIME);  // можем не открыть только в случае если его кто-нибудь чистит
//#UC END# *4A4DFFB801BA_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.Create

function TatFileBasedSemaphore.Enter(const aTimeOut: Int64 = FBS_WAIT_FOREVER): Boolean;
//#UC START# *4A4E001901F9_4A4DFF7800C9_var*
  const
    WAIT_TIME = 300;
  var
    l_CurrEnteredCount : Integer;
    l_DeadLine : TDateTime;
//#UC END# *4A4E001901F9_4A4DFF7800C9_var*
begin
//#UC START# *4A4E001901F9_4A4DFF7800C9_impl*
  Result := false;
  // пытаемся занять место
  l_DeadLine := Time;
  l_DeadLine := IncMilliSecond(l_DeadLine, aTimeOut);
  //
  repeat
    // узнаем сколько уже вошло внутрь
    l_CurrEnteredCount := GetCurrEnteredCount();
    if (l_CurrEnteredCount < f_MaxEnteredCount) then
    begin
      //
      if LockForWrite(0) then
        try
          // проверяем еще раз, а то может кто-то был быстрее
          l_CurrEnteredCount := GetCurrEnteredCount();
          Assert(l_CurrEnteredCount <= f_MaxEnteredCount , 'l_CurrEnteredCount <= f_MaxEnteredCount');
          if (l_CurrEnteredCount < f_MaxEnteredCount) then
          begin
            CloseHandle(f_ReadHandle);
            while NOT OpenForRead() do Sleep(WAIT_TIME);
            //
            l_CurrEnteredCount := GetCurrEnteredCount();
            if (l_CurrEnteredCount < f_MaxEnteredCount) then
            begin
              Inc(l_CurrEnteredCount);
              SetCurrEnteredCount(l_CurrEnteredCount);
              f_IsEntered := true;
              Result := true;
            end;
          end;
        finally
          UnlockForWrite();
        end;
    end;
    //
    if NOT Result then Sleep(WAIT_TIME);
  until Result OR (aTimeOut = 0) OR ((aTimeOut <> FBS_WAIT_FOREVER) AND (Time > l_DeadLine));
//#UC END# *4A4E001901F9_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.Enter

procedure TatFileBasedSemaphore.Leave;
//#UC START# *4A4E009800B1_4A4DFF7800C9_var*
  var
    l_CurrEnteredCount : Integer;
//#UC END# *4A4E009800B1_4A4DFF7800C9_var*
begin
//#UC START# *4A4E009800B1_4A4DFF7800C9_impl*
  if f_IsEntered AND (f_ReadHandle <> INVALID_HANDLE_VALUE) AND LockForWrite() then
    try
      l_CurrEnteredCount := GetCurrEnteredCount();
      Assert(l_CurrEnteredCount > 0 , 'l_CurrEnteredCount > 0');
      //
      Dec(l_CurrEnteredCount);
      SetCurrEnteredCount(l_CurrEnteredCount);
      f_IsEntered := false;
    finally
      UnlockForWrite();
    end;
//#UC END# *4A4E009800B1_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.Leave

function TatFileBasedSemaphore.LockForWrite(const aTimeOut: Int64 = FBS_WAIT_FOREVER): Boolean;
//#UC START# *4A4E03BE0171_4A4DFF7800C9_var*
  const
    WAIT_TIME = 100;
  var
    l_DeadLine : TDateTime;
//#UC END# *4A4E03BE0171_4A4DFF7800C9_var*
begin
//#UC START# *4A4E03BE0171_4A4DFF7800C9_impl*
  Result := f_WriteHandle <> INVALID_HANDLE_VALUE;
  if (NOT Result) then
  begin
    l_DeadLine := Time;
    l_DeadLine := IncMilliSecond(l_DeadLine, aTimeOut);
    repeat
      f_WriteHandle := OpenFile(GENERIC_WRITE, FILE_SHARE_READ);
      Result := f_WriteHandle <> INVALID_HANDLE_VALUE;
      if NOT Result then Sleep(WAIT_TIME);
    until Result OR (aTimeOut = 0) OR ((aTimeOut <> FBS_WAIT_FOREVER) AND (Time > l_DeadLine));
  end;
  if Result then Inc(f_LocksCount);
//#UC END# *4A4E03BE0171_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.LockForWrite

procedure TatFileBasedSemaphore.UnlockForWrite;
//#UC START# *4A4E03C90305_4A4DFF7800C9_var*
//#UC END# *4A4E03C90305_4A4DFF7800C9_var*
begin
//#UC START# *4A4E03C90305_4A4DFF7800C9_impl*
  if (f_LocksCount = 1) AND (f_WriteHandle <> INVALID_HANDLE_VALUE) then
  begin
    CloseHandle(f_WriteHandle);
    f_WriteHandle := INVALID_HANDLE_VALUE;
  end;
  Dec(f_LocksCount);
//#UC END# *4A4E03C90305_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.UnlockForWrite

function TatFileBasedSemaphore.GetCurrEnteredCount: Integer;
//#UC START# *4A4E03D502B3_4A4DFF7800C9_var*
  var
    l_BytesRead : DWORD;
//#UC END# *4A4E03D502B3_4A4DFF7800C9_var*
begin
//#UC START# *4A4E03D502B3_4A4DFF7800C9_impl*
  Result := 0;
  SetFilePointer(f_ReadHandle, 0, nil, FILE_BEGIN);
  ReadFile(f_ReadHandle, Result, SizeOf(Result), l_BytesRead, nil);
  if (l_BytesRead <> SizeOf(Result)) then
    Result := 0;
//#UC END# *4A4E03D502B3_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.GetCurrEnteredCount

procedure TatFileBasedSemaphore.SetCurrEnteredCount(const aCount: Integer);
//#UC START# *4A4E040D0305_4A4DFF7800C9_var*
  var
    l_BytesWritten : DWORD;
//#UC END# *4A4E040D0305_4A4DFF7800C9_var*
begin
//#UC START# *4A4E040D0305_4A4DFF7800C9_impl*
  if LockForWrite() then
    try
      SetFilePointer(f_WriteHandle, 0, nil, FILE_BEGIN);
      WriteFile(f_WriteHandle, aCount, SizeOf(aCount), l_BytesWritten, nil);
      FlushFileBuffers(f_WriteHandle);
    finally
      UnlockForWrite();
    end;
//#UC END# *4A4E040D0305_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.SetCurrEnteredCount

function TatFileBasedSemaphore.OpenFile(const aAccessMode: DWORD;
  const aShareMode: DWORD): THandle;
//#UC START# *4A4E3AE300B6_4A4DFF7800C9_var*
//#UC END# *4A4E3AE300B6_4A4DFF7800C9_var*
begin
//#UC START# *4A4E3AE300B6_4A4DFF7800C9_impl*
  Result := CreateFile(
    PAnsiChar(f_FileName),
    aAccessMode,
    aShareMode,
    nil,
    OPEN_ALWAYS,
    FILE_ATTRIBUTE_NORMAL,
    0
  );
//#UC END# *4A4E3AE300B6_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.OpenFile

function TatFileBasedSemaphore.OpenForRead: Boolean;
//#UC START# *4A51E57100CE_4A4DFF7800C9_var*
//#UC END# *4A51E57100CE_4A4DFF7800C9_var*
begin
//#UC START# *4A51E57100CE_4A4DFF7800C9_impl*
  f_ReadHandle := OpenFile(GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE);
  Result := f_ReadHandle <> INVALID_HANDLE_VALUE;
//#UC END# *4A51E57100CE_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.OpenForRead

destructor TatFileBasedSemaphore.Destroy;
//#UC START# *48077504027E_4A4DFF7800C9_var*
//#UC END# *48077504027E_4A4DFF7800C9_var*
begin
//#UC START# *48077504027E_4A4DFF7800C9_impl*
  Leave();
  if (f_ReadHandle <> INVALID_HANDLE_VALUE) then
    CloseHandle(f_ReadHandle);
  if (f_WriteHandle <> INVALID_HANDLE_VALUE) then
    CloseHandle(f_WriteHandle);
  inherited;
//#UC END# *48077504027E_4A4DFF7800C9_impl*
end;//TatFileBasedSemaphore.Destroy

end.