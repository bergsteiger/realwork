unit ddConfigStorages;

// Модуль: "w:\common\components\rtl\Garant\dd\ddConfigStorages.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddConfigStorages" MUID: (5214AEF201AE)

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 IddConfigStorage = interface
  {* Интерфейс для чтения-записи данных конфигурации }
  ['{86F1D5B0-F190-4497-AA2E-1E9F453F7066}']
  function Get_Section: AnsiString;
  procedure Set_Section(const aValue: AnsiString);
  function ReadBool(const Alias: AnsiString;
   Default: Boolean): Boolean;
  function ReadDateTime(const Alias: AnsiString;
   Default: TDateTime): TDateTime;
  function ReadInteger(const Alias: AnsiString;
   Default: Integer): Integer;
  function ReadString(const Alias: AnsiString;
   const Default: AnsiString): Il3CString;
  procedure WriteBool(const Alias: AnsiString;
   B: Boolean);
  procedure WriteDateTime(const Alias: AnsiString;
   DT: TDateTime);
  procedure WriteInteger(const Alias: AnsiString;
   I: Integer);
  procedure WriteString(const Alias: AnsiString;
   const S: AnsiString);
  property Section: AnsiString
   read Get_Section
   write Set_Section;
 end;//IddConfigStorage

implementation

uses
 l3ImplUses
 //#UC START# *5214AEF201AEimpl_uses*
 //#UC END# *5214AEF201AEimpl_uses*
;

end.
