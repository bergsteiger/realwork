unit ddConfigStorages;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 IddConfigStorage = interface
  {* Интерфейс для чтения-записи данных конфигурации }
  function ReadBool(const Alias: AnsiString;
   Default: Boolean): Boolean; stdcall;
  function ReadDateTime(const Alias: AnsiString;
   Default: TDateTime): TDateTime; stdcall;
  function ReadInteger(const Alias: AnsiString;
   Default: Integer): Integer; stdcall;
  function ReadString(const Alias: AnsiString;
   const Default: AnsiString): Il3CString; stdcall;
  procedure WriteBool(const Alias: AnsiString;
   B: Boolean); stdcall;
  procedure WriteDateTime(const Alias: AnsiString;
   DT: TDateTime); stdcall;
  procedure WriteInteger(const Alias: AnsiString;
   I: Integer); stdcall;
  procedure WriteString(const Alias: AnsiString;
   const S: AnsiString); stdcall;
 end;//IddConfigStorage
 
implementation

uses
 l3ImplUses
;

end.
