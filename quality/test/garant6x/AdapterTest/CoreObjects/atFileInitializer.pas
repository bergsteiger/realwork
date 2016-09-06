unit atFileInitializer;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atFileInitializer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatFileInitializer" MUID: (50294907000B)

interface

uses
 l3IntfUses
 , Windows
 , Classes
;

type
 TatFileInitializer = class(TObject)
  private
   f_GuardFile: THandle;
   f_FileName: AnsiString;
   f_Handle: THandle;
   f_Stream: TStream;
  public
   function DupHandle: THandle; virtual;
   function TryInit: Boolean; virtual;
   procedure FinishInit; virtual;
   constructor Create(const aFileName: AnsiString = ''); reintroduce;
   destructor Destroy; override;
  public
   property FileName: AnsiString
    read f_FileName;
   property Handle: THandle
    read f_Handle;
   property Stream: TStream
    read f_Stream;
 end;//TatFileInitializer

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *50294907000Bimpl_uses*
 //#UC END# *50294907000Bimpl_uses*
;

function TatFileInitializer.DupHandle: THandle;
//#UC START# *50294A39012E_50294907000B_var*
//#UC END# *50294A39012E_50294907000B_var*
begin
//#UC START# *50294A39012E_50294907000B_impl*
  if NOT DuplicateHandle(GetCurrentProcess, Handle, GetCurrentProcess, @Result, 0, false, DUPLICATE_SAME_ACCESS) then
    Result := INVALID_HANDLE_VALUE;
//#UC END# *50294A39012E_50294907000B_impl*
end;//TatFileInitializer.DupHandle

function TatFileInitializer.TryInit: Boolean;
//#UC START# *50294A550017_50294907000B_var*
//#UC END# *50294A550017_50294907000B_var*
begin
//#UC START# *50294A550017_50294907000B_impl*
  Result := f_GuardFile <> INVALID_HANDLE_VALUE;
//#UC END# *50294A550017_50294907000B_impl*
end;//TatFileInitializer.TryInit

procedure TatFileInitializer.FinishInit;
//#UC START# *50294A61033F_50294907000B_var*
//#UC END# *50294A61033F_50294907000B_var*
begin
//#UC START# *50294A61033F_50294907000B_impl*
  FreeAndNil(f_Stream);
  // закрываем открытый на запись файл
  if f_Handle <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(f_Handle);
    f_Handle := INVALID_HANDLE_VALUE;
  end;
  // переоткрываем файл на чтение с запретом записи
  while true do
  begin
    f_Handle := CreateFile(PAnsiChar(f_FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if f_Handle = INVALID_HANDLE_VALUE then
      Sleep(100) // файл еще открыт на запись
    else
      break;
  end;
  f_Stream := THandleStream.Create(Handle);
  //
  if f_GuardFile <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(f_GuardFile);
    f_GuardFile := INVALID_HANDLE_VALUE;
  end;
//#UC END# *50294A61033F_50294907000B_impl*
end;//TatFileInitializer.FinishInit

constructor TatFileInitializer.Create(const aFileName: AnsiString = '');
//#UC START# *50294A7E0284_50294907000B_var*
 var
    l_GuardFileName : String;

  function GetTemporary : String;
    var
      l_Path, l_Name : array [0..MAX_PATH] of AnsiChar;
  begin
    if (GetTempPath(SizeOf(l_Path), l_Path) <>0) AND (GetTempFileName(l_Path, nil, 0, l_Name) <> 0) then
      Result := l_Name;
  end;
//#UC END# *50294A7E0284_50294907000B_var*
begin
//#UC START# *50294A7E0284_50294907000B_impl*
  f_Handle := INVALID_HANDLE_VALUE;
  f_GuardFile := INVALID_HANDLE_VALUE;
  if aFileName <> '' then
    f_FileName := aFileName
  else
    f_FileName := GetTemporary;

  // открываем файл на эксклюзивную запись
  f_Handle := CreateFile(PAnsiChar(f_FileName), GENERIC_WRITE or GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_DELETE, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if f_Handle <> INVALID_HANDLE_VALUE then
  begin
    l_GuardFileName := f_FileName + '.guard';
    f_GuardFile := CreateFile(PAnsiChar(l_GuardFileName), GENERIC_WRITE, FILE_SHARE_READ, nil, OPEN_ALWAYS, FILE_FLAG_DELETE_ON_CLOSE or FILE_ATTRIBUTE_HIDDEN, 0);
  end;

  if f_GuardFile = INVALID_HANDLE_VALUE then // файл не захвачен на запись, либо захвачен повторно
    FinishInit
  else
    f_Stream := THandleStream.Create(Handle);
//#UC END# *50294A7E0284_50294907000B_impl*
end;//TatFileInitializer.Create

destructor TatFileInitializer.Destroy;
//#UC START# *48077504027E_50294907000B_var*
//#UC END# *48077504027E_50294907000B_var*
begin
//#UC START# *48077504027E_50294907000B_impl*
  FreeAndNil(f_Stream);
  if f_Handle <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(f_Handle);
    f_Handle := INVALID_HANDLE_VALUE;
  end;
  DeleteFile(PAnsiChar(f_FileName)); // удалится, только если никто не использует
  if f_GuardFile <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(f_GuardFile);
    f_GuardFile := INVALID_HANDLE_VALUE;
  end;
  //
  inherited;
//#UC END# *48077504027E_50294907000B_impl*
end;//TatFileInitializer.Destroy

end.
