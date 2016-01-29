unit archiDBTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ArchiDBTests"
// Модуль: "W:/archi/source/projects/ImportExportTest/ArchiDBTests/archiDBTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$ImportExprortTest::ArchiDBTests::ArchiDBTests::TarchiDBTest
//
// Базовый класс для тестов, использующих базу данных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include W:\archi\source\projects\ImportExportTest.inc}

interface

{$If defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If not defined(Nemesis)}
  ,
  dt_Sab
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dtIntf
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TarchiDBTest = class(TBaseTest)
  {* Базовый класс для тестов, использующих базу данных }
 private
 // private methods
   function GetDatabasePath: AnsiString;
 protected
 // protected fields
   f_SabFiller : IValueSetFiller;
   f_NumSab : ISab;
 protected
 // protected methods
   procedure UnpackDatabase;
   procedure ConnectToDatabase;
   procedure DeleteDatabase;
   procedure DisconnectFromDatabase;
 end;//TarchiDBTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  ZipForge
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  ddHTinit,
  dt_Const,
  dt_Types,
  l3IniFile,
  l3FileUtils
  {$If defined(AppClientSide) AND not defined(Nemesis)}
  ,
  ddClientBaseEngine
  {$IfEnd} //AppClientSide AND not Nemesis
  ,
  m3StorageHolderList,
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TarchiDBTest

function TarchiDBTest.GetDatabasePath: AnsiString;
//#UC START# *519615B000D3_55F29BD60218_var*
//#UC END# *519615B000D3_55F29BD60218_var*
begin
//#UC START# *519615B000D3_55F29BD60218_impl*
 Result := ExtractFilePath(ParamStr(0)) + 'DB';
//#UC END# *519615B000D3_55F29BD60218_impl*
end;//TarchiDBTest.GetDatabasePath

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

{$IfEnd} //nsTest

end.