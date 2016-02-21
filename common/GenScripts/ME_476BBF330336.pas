unit m4DBInterfaces;
 {* »нтерфейсы индексируемого хранилища. }

// ћодуль: "w:\common\components\rtl\Garant\m4\m4DBInterfaces.pas"
// —тереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\m4\m4Define.inc}

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
  ['{6C9973E5-00A7-46C0-BA8F-E28FFB54D94D}']
  function pm_GetPackedIndex: Boolean;
  procedure pm_SetPackedIndex(aValue: Boolean);
  function pm_GetFakeIndex: Boolean;
  procedure pm_SetFakeIndex(aValue: Boolean);
  procedure DeleteIndex;
   {* ”дал€ет текстовый индекс }
  procedure DeleteIndexDelta;
  function BuildIndex(aDelta: Boolean = False;
   aExitIfExists: Boolean = False;
   anIndexID: Integer = 1): Integer;
   {* строит контекстный индкс. ¬озвращает число проиндексированных файлов. }
  procedure UpdateIndex(anIndexID: Integer = 1);
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
  function Update(aNotEmpty: Boolean = True;
   aPurgeDeletedObjects: Boolean = True): Boolean;
   {* переливает файлы из переменной части в посто€нную. }
  function Purge: integer;
   {* удал€ет файлы, помеченные как удаленные и возвращает число удаленных. }
  procedure Finish;
   {* заканчивает процесс с базой. }
  procedure Stop;
   {* остановить текущий процесс. }
  property PackedIndex: Boolean
   read pm_GetPackedIndex
   write pm_SetPackedIndex;
   {* паковать ли индекс? }
  property FakeIndex: Boolean
   read pm_GetFakeIndex
   write pm_SetFakeIndex;
   {* индексировать в пустоту? }
 end;//Im4DB

implementation

uses
 l3ImplUses
;

end.
