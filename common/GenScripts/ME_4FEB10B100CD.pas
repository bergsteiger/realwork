unit atLockFile;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atLockFile.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatLockFile" MUID: (4FEB10B100CD)

interface

uses
 l3IntfUses
 , Windows
;

type
 TatLockFile = class(TObject)
  private
   f_WriteHandle: THandle;
   f_ReadHandle: THandle;
   f_LocksCount: Integer;
   f_FileName: AnsiString;
    {* Поле для свойства FileName }
  private
   function OpenForRead: Boolean; virtual;
   function OpenFile(const aAccessMode: DWORD;
    const aShareMode: DWORD): THandle; virtual;
  protected
   procedure Initialize; virtual;
   procedure AfterConstruction; override;
    {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
  public
   constructor Create(const aFileName: AnsiString); reintroduce; virtual;
   function Acquire(aTimeOut: LongWord = INFINITE): Boolean; virtual;
   procedure Release; virtual;
   destructor Destroy; override;
  public
   property FileName: AnsiString
    read f_FileName;
 end;//TatLockFile

implementation

uses
 l3ImplUses
 , DateUtils
 , SysUtils
;

constructor TatLockFile.Create(const aFileName: AnsiString);
//#UC START# *4FEB10EA02B3_4FEB10B100CD_var*
//#UC END# *4FEB10EA02B3_4FEB10B100CD_var*
begin
//#UC START# *4FEB10EA02B3_4FEB10B100CD_impl*
  inherited Create;
  f_FileName := aFileName;
  f_LocksCount := 0;
  f_WriteHandle := INVALID_HANDLE_VALUE;
  f_ReadHandle := INVALID_HANDLE_VALUE;
  //
  f_ReadHandle := OpenFile(GENERIC_READ, FILE_SHARE_WRITE); // можно открыть только первому
  if f_ReadHandle <> INVALID_HANDLE_VALUE then
  begin
    f_WriteHandle := OpenFile(GENERIC_WRITE, FILE_SHARE_READ);
    if f_WriteHandle = INVALID_HANDLE_VALUE then
    begin
      CloseHandle(f_ReadHandle);
      f_ReadHandle := INVALID_HANDLE_VALUE;
    end;
  end;
//#UC END# *4FEB10EA02B3_4FEB10B100CD_impl*
end;//TatLockFile.Create

function TatLockFile.Acquire(aTimeOut: LongWord = INFINITE): Boolean;
//#UC START# *4FEB10FD01E9_4FEB10B100CD_var*
  const
    WAIT_TIME = 100;
  var
    l_DeadLine : TDateTime;
//#UC END# *4FEB10FD01E9_4FEB10B100CD_var*
begin
//#UC START# *4FEB10FD01E9_4FEB10B100CD_impl*
  Result := f_WriteHandle <> INVALID_HANDLE_VALUE;
  if (NOT Result) then
  begin
    l_DeadLine := IncMilliSecond(Time, aTimeOut);
    repeat
      f_WriteHandle := OpenFile(GENERIC_WRITE, FILE_SHARE_READ);
      Result := f_WriteHandle <> INVALID_HANDLE_VALUE;
      if NOT Result then Sleep(WAIT_TIME);
    until Result OR (aTimeOut = 0) OR ((aTimeOut <> INFINITE) AND (Time > l_DeadLine));
  end;
  if Result then Inc(f_LocksCount);
//#UC END# *4FEB10FD01E9_4FEB10B100CD_impl*
end;//TatLockFile.Acquire

procedure TatLockFile.Release;
//#UC START# *4FEB117E0197_4FEB10B100CD_var*
//#UC END# *4FEB117E0197_4FEB10B100CD_var*
begin
//#UC START# *4FEB117E0197_4FEB10B100CD_impl*
  if (f_LocksCount = 1) AND (f_WriteHandle <> INVALID_HANDLE_VALUE) then
  begin
    CloseHandle(f_WriteHandle);
    f_WriteHandle := INVALID_HANDLE_VALUE;
  end;
  Dec(f_LocksCount);
//#UC END# *4FEB117E0197_4FEB10B100CD_impl*
end;//TatLockFile.Release

procedure TatLockFile.Initialize;
//#UC START# *4FEB11FB009A_4FEB10B100CD_var*
//#UC END# *4FEB11FB009A_4FEB10B100CD_var*
begin
//#UC START# *4FEB11FB009A_4FEB10B100CD_impl*
  //
//#UC END# *4FEB11FB009A_4FEB10B100CD_impl*
end;//TatLockFile.Initialize

function TatLockFile.OpenForRead: Boolean;
//#UC START# *4FEB12AF03A1_4FEB10B100CD_var*
//#UC END# *4FEB12AF03A1_4FEB10B100CD_var*
begin
//#UC START# *4FEB12AF03A1_4FEB10B100CD_impl*
  f_ReadHandle := OpenFile(GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE);
  Result := f_ReadHandle <> INVALID_HANDLE_VALUE;
//#UC END# *4FEB12AF03A1_4FEB10B100CD_impl*
end;//TatLockFile.OpenForRead

function TatLockFile.OpenFile(const aAccessMode: DWORD;
 const aShareMode: DWORD): THandle;
//#UC START# *4FEB12C50271_4FEB10B100CD_var*
//#UC END# *4FEB12C50271_4FEB10B100CD_var*
begin
//#UC START# *4FEB12C50271_4FEB10B100CD_impl*
  Result := CreateFile(
    PAnsiChar(f_FileName),
    aAccessMode,
    aShareMode,
    nil,
    OPEN_ALWAYS,
    FILE_ATTRIBUTE_NORMAL,
    0
  );
//#UC END# *4FEB12C50271_4FEB10B100CD_impl*
end;//TatLockFile.OpenFile

destructor TatLockFile.Destroy;
//#UC START# *48077504027E_4FEB10B100CD_var*
//#UC END# *48077504027E_4FEB10B100CD_var*
begin
//#UC START# *48077504027E_4FEB10B100CD_impl*
  if (f_ReadHandle <> INVALID_HANDLE_VALUE) then
    CloseHandle(f_ReadHandle);
  if (f_WriteHandle <> INVALID_HANDLE_VALUE) then
    CloseHandle(f_WriteHandle);
  inherited;
//#UC END# *48077504027E_4FEB10B100CD_impl*
end;//TatLockFile.Destroy

procedure TatLockFile.AfterConstruction;
 {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
//#UC START# *49F057120234_4FEB10B100CD_var*
  const
    WAIT_TIME = 100;
//#UC END# *49F057120234_4FEB10B100CD_var*
begin
//#UC START# *49F057120234_4FEB10B100CD_impl*
  if f_ReadHandle <> INVALID_HANDLE_VALUE then // если мы первые и единственные кто открыли файл
  begin
    Initialize;
    //
    CloseHandle(f_ReadHandle);
    f_ReadHandle := INVALID_HANDLE_VALUE;
    while NOT OpenForRead() do Sleep(WAIT_TIME);
    CloseHandle(f_WriteHandle);
    f_WriteHandle := INVALID_HANDLE_VALUE;
  end
  else
    while NOT OpenForRead() do Sleep(WAIT_TIME);
//#UC END# *49F057120234_4FEB10B100CD_impl*
end;//TatLockFile.AfterConstruction

end.
