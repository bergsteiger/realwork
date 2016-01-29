unit archiDBTest;

interface

uses
 l3IntfUses
 , BaseTest
 , dt_Sab
 , dtIntf
;

type
 TarchiDBTest = class(TBaseTest)
  {* Ѕазовый класс дл€ тестов, использующих базу данных }
  procedure UnpackDatabase;
  procedure ConnectToDatabase;
  procedure DeleteDatabase;
  procedure DisconnectFromDatabase;
  function GetDatabasePath: AnsiString;
 end;//TarchiDBTest
 
implementation

uses
 l3ImplUses
 , ZipForge
 , KTestRunner
 , ddHTinit
 , dt_Const
 , dt_Types
 , l3IniFile
 , l3FileUtils
 , ddClientBaseEngine
 , m3StorageHolderList
 , SysUtils
;

end.
