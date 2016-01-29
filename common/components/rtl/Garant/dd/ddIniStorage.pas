unit ddIniStorage;
{1 Хранилище, основанное на TIniFile }

interface

uses
  SysUtils, IniFiles, ddConfigStorages, l3Interfaces;

type
  TddIniStorage = class(TObject, IddConfigStorage)
    procedure FreeInstance;
      override;
    function  Get_Section: AnsiString;
      stdcall;
    function  QueryInterface(const IID: TGUID; out Obj): HResult;
      stdcall;
    function ReadBool(const Alias: AnsiString; Default: Boolean): Boolean; stdcall;
    function ReadDateTime(const Alias: AnsiString; Default: TDateTime): TDateTime; stdcall;
    function ReadInteger(const Alias: AnsiString; Default: Integer): Integer; stdcall;
    function ReadString(const Alias: AnsiString; const Default: AnsiString): Il3CString; stdcall;
    procedure Set_Section(const Value: AnsiString); stdcall;
    procedure WriteBool(const Alias: AnsiString; B: Boolean); stdcall;
    procedure WriteDateTime(const Alias: AnsiString; DT: TDateTime); stdcall;
    procedure WriteInteger(const Alias: AnsiString; I: Integer); stdcall;
    procedure WriteString(const Alias: AnsiString; const S: AnsiString); stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  private
    FRefCount: Integer;
    FSection: AnsiString;
    f_Ini: TIniFile;
  public
    constructor Create(const FileName: AnsiString);
    class function Make(const FileName: AnsiString): IddConfigStorage;
    destructor Destroy; overload; override;
    property Ini: TIniFile read f_Ini;
  end;

implementation

uses
  Windows,
  l3Base;

{
******************************** TddIniStorage *********************************
}
constructor TddIniStorage.Create(const FileName: AnsiString);
begin
  f_Ini:= TIniFile.Create(FileName);
  InterlockedIncrement(fRefCount);
end;

destructor TddIniStorage.Destroy;
begin
  if (InterlockedDecrement(fRefCount) = 0) then
  begin
   Inc(fRefCount);
   try
    f_Ini.Free;
    inherited Destroy;
   finally
    Dec(fRefCount);
   end;{try..finally}
  end;{f_RefCount = 0}
end;

procedure TddIniStorage.FreeInstance;
begin
  if (fRefCount = 0) then
   inherited;
end;

function TddIniStorage.Get_Section: AnsiString;
begin
  Result:= FSection;
end;

class function TddIniStorage.Make(
  const FileName: AnsiString): IddConfigStorage;
var
 l_Storage: TddIniStorage;
begin
 l_Storage := TddIniStorage.Create(FileName);
 try
  Result := l_Storage;
 finally
  l_Storage.Free;
 end;//try..finally
end;

function TddIniStorage.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if TObject(Self).GetInterface(IID, Obj) then
    Result := S_Ok
  else
    Result:= E_NoInterface
end;

function TddIniStorage.ReadBool(const Alias: AnsiString; Default: Boolean): Boolean;
begin
  Result:= f_Ini.ReadBool(FSection, Alias, Default);
end;

function TddIniStorage.ReadDateTime(const Alias: AnsiString; Default: TDateTime): TDateTime;
begin
 Result:= f_Ini.ReadDateTime(FSection, Alias, Default);
end;

function TddIniStorage.ReadInteger(const Alias: AnsiString; Default: Integer): Integer;
begin
  Result:= f_Ini.ReadInteger(FSection, Alias, Default);
end;

function TddIniStorage.ReadString(const Alias: AnsiString; const Default: AnsiString): Il3CString;
begin
  Result:= l3CStr(f_Ini.ReadString(FSection, Alias, Default));
end;

procedure TddIniStorage.Set_Section(const Value: AnsiString);
begin
  if FSection <> Value then
   FSection:= Value;
end;

procedure TddIniStorage.WriteBool(const Alias: AnsiString; B: Boolean);
begin
  f_Ini.WriteBool(FSection, Alias, B);
end;

procedure TddIniStorage.WriteDateTime(const Alias: AnsiString; DT: TDateTime);
begin
  f_Ini.WriteDateTime(FSection, Alias, DT);
end;

procedure TddIniStorage.WriteInteger(const Alias: AnsiString; I: Integer);
begin
  f_Ini.WriteInteger(FSection, Alias, I);
end;

procedure TddIniStorage.WriteString(const Alias: AnsiString; const S: AnsiString);
begin
  f_Ini.WriteString(FSection, Alias, S);
end;

function TddIniStorage._AddRef: Integer;
begin
  Result :=InterlockedIncrement(fRefCount);
end;

function TddIniStorage._Release: Integer;
begin
  Result := InterlockedDecrement(fRefCount);
  if Result = 0 then
  begin
   InterlockedIncrement(fRefCount);
   Free;
  end;
end;


end.
