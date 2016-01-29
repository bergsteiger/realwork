unit m4DBInterfaces;

interface

uses
 l3IntfUses
 , l3Types
 , m3DBInterfaces
 , m3StorageInterfaces
;

type
 Tm4WordAction = procedure(aHandle: Integer;
  const aStr: Tl3PCharLen);
 
 Im4DB = interface
  procedure DeleteIndex;
   {* ”дал€ет текстовый индекс }
  procedure DeleteIndexDelta;
  function BuildIndex(aDelta: Boolean;
   aExitIfExists: Boolean;
   anIndexID: Integer): Integer;
   {* строит контекстный индкс. ¬озвращает число проиндексированных файлов. }
  procedure UpdateIndex(anIndexID: Integer);
   {* обновл€ет или перестраивает индекс (в зависимости от его состо€ни€). }
  procedure DeleteVersion;
   {* ”дал€ет хранилище версий }
  function CompareVersionWithBackup: Boolean;
  procedure CopyBackupToVersion;
  procedure CopyVersionToBackup;
  procedure ExtractMainTo(const aDir: AnsiString);
  procedure ExtractVersionTo(const aDir: AnsiString);
  procedure ExtractBackupTo(const aDir: AnsiString);
  procedure Start(aOpenMode: Tm3StoreAccess);
   {* начинает процесс с базой. }
  function Update(aNotEmpty: Boolean;
   aPurgeDeletedObjects: Boolean): Boolean;
   {* переливает файлы из переменной части в посто€нную. }
  function Purge: integer;
   {* удал€ет файлы, помеченные как удаленные и возвращает число удаленных. }
  procedure Finish;
   {* заканчивает процесс с базой. }
  procedure Stop;
   {* остановить текущий процесс. }
 end;//Im4DB
 
implementation

uses
 l3ImplUses
;

end.
