unit archiDBTest;
 {* Базовый класс для тестов, использующих базу данных }

// Модуль: "w:\archi\source\projects\ImportExportTest\ArchiDBTests\archiDBTest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarchiDBTest" MUID: (55F29BD60218)

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TarchiDBTest = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* Базовый класс для тестов, использующих базу данных }
  protected
   f_SabFiller: IValueSetFiller;
   f_NumSab: ISab;
  private
   function GetDatabasePath: AnsiString;
  protected
   procedure UnpackDatabase;
   procedure ConnectToDatabase;
   procedure DeleteDatabase;
   procedure DisconnectFromDatabase;
 end;//TarchiDBTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , ZipForge
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , ddHTinit
 , dt_Const
 , dt_Types
 , l3IniFile
 , l3FileUtils
 {$If Defined(AppClientSide) AND NOT Defined(Nemesis)}
 , ddClientBaseEngine
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(Nemesis)
 , m3StorageHolderList
 , SysUtils
;

{$If NOT Defined(NotTunedDUnit)}
procedure TarchiDBTest.UnpackDatabase;
//#UC START# *5195F36403BC_55F29BD60218_var*
var
 l_Zip : TZipForge;
 l_ZipFN: AnsiString;
//#UC END# *5195F36403BC_55F29BD60218_var*
begin
//#UC START# *5195F36403BC_55F29BD60218_impl*
 l_ZipFN := g_CVSPath + '\testbase.zip';
 Check(FileExists(l_ZipFN), Format('Не найден архив с пустой базой (%s)', [l_ZipFN]));
 l_Zip := TZipForge.Create(nil);
 try
  l_Zip.FileName := l_ZipFN;
  DelDir(GetDatabasePath); // на случай, если база осталась от какого-то из предыдущих тестов...
  ForceDirectories(GetDatabasePath);
  l_Zip.BaseDir := GetDatabasePath;
  l_Zip.OpenArchive;
  l_Zip.ExtractFiles('*.*');
 finally
  FreeAndNil(l_Zip);
 end;
//#UC END# *5195F36403BC_55F29BD60218_impl*
end;//TarchiDBTest.UnpackDatabase

procedure TarchiDBTest.ConnectToDatabase;
//#UC START# *5195F59C007D_55F29BD60218_var*
//#UC END# *5195F59C007D_55F29BD60218_var*
begin
//#UC START# *5195F59C007D_55F29BD60218_impl*
 InitStationAndServerConfig;
 Check(InitBaseEngine(GetDatabasePath, 'fireton', 'pyro', True), 'Не удалось подключиться к базе данных');
//#UC END# *5195F59C007D_55F29BD60218_impl*
end;//TarchiDBTest.ConnectToDatabase

procedure TarchiDBTest.DeleteDatabase;
//#UC START# *5195F6A9018D_55F29BD60218_var*
//#UC END# *5195F6A9018D_55F29BD60218_var*
begin
//#UC START# *5195F6A9018D_55F29BD60218_impl*
 Check(DelDir(GetDatabasePath), 'Не удалось удалить базу после теста');
//#UC END# *5195F6A9018D_55F29BD60218_impl*
end;//TarchiDBTest.DeleteDatabase

procedure TarchiDBTest.DisconnectFromDatabase;
//#UC START# *5195F68401A9_55F29BD60218_var*
//#UC END# *5195F68401A9_55F29BD60218_var*
begin
//#UC START# *5195F68401A9_55F29BD60218_impl*
 f_SabFiller := nil;
 f_NumSab := nil;
 DoneClientBaseEngine;
 Tm3StorageHolderList.DropAll;
//#UC END# *5195F68401A9_55F29BD60218_impl*
end;//TarchiDBTest.DisconnectFromDatabase

function TarchiDBTest.GetDatabasePath: AnsiString;
//#UC START# *519615B000D3_55F29BD60218_var*
//#UC END# *519615B000D3_55F29BD60218_var*
begin
//#UC START# *519615B000D3_55F29BD60218_impl*
 Result := ExtractFilePath(ParamStr(0)) + 'DB';
//#UC END# *519615B000D3_55F29BD60218_impl*
end;//TarchiDBTest.GetDatabasePath
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
