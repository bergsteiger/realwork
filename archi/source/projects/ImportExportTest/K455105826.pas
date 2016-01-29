unit K455105826;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ImportExportTestLibrary"
// Модуль: "W:/archi/source/projects/ImportExportTest/K455105826.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::ImportExportTestLibrary::ImportExport::TK455105826
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
  ietBaseTest
  {$If not defined(Nemesis)}
  ,
  dt_Jour
  {$IfEnd} //not Nemesis
  ,
  ddImportPipe
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TK455105826 = class(TietBaseTest)
 private
 // private fields
   f_LockJournal : TAbstractJournal;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   procedure DoBeforeImport(const aPipe: TddImportPipe); override;
   procedure DoAfterImport(const aPipe: TddImportPipe); override;
 end;//TK455105826
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  dt_Const
  {$If not defined(Nemesis)}
  ,
  dt_IFltr
  {$IfEnd} //not Nemesis
  ,
  dt_Types
  {$If not defined(Nemesis)}
  ,
  dt_Lock
  {$IfEnd} //not Nemesis
  
  {$If defined(Archi) AND not defined(Nemesis)}
  ,
  dt_LinkServ
  {$IfEnd} //Archi AND not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Doc
  {$IfEnd} //not Nemesis
  ,
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TK455105826

function TK455105826.GetFolder: AnsiString;
 {-}
begin
 Result := 'ImportExport';
end;//TK455105826.GetFolder

function TK455105826.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '519CA57101A1';
end;//TK455105826.GetModelElementGUID

procedure TK455105826.DoBeforeImport(const aPipe: TddImportPipe);
//#UC START# *5195F73400EE_519CA57101A1_var*
var
 l_Mask   : LongInt;
 l_DocID  : TDocID;
const
 c_TestStationID: TStationID = 'TEST    ';
//#UC END# *5195F73400EE_519CA57101A1_var*
begin
//#UC START# *5195F73400EE_519CA57101A1_impl*
 aPipe.NeedLockBase := False;
 aPipe.CheckDocuments := True;
 aPipe.SameDocuments := sdrDelete;
 // лочим один из документов
 f_LockJournal := TAbstractJournal.Create(c_TestStationID, GetLockJournalName(CurrentFamily));
 l_DocID := 70213052;
 LinkServer(CurrentFamily).Renum.GetRNumber(l_DocID);
 DocumentServer(CurrentFamily).FileTbl.ClearFullRec;
 DocumentServer(CurrentFamily).FileTbl.PutToFullRec(fId_Fld, l_DocID);
 DocumentServer(CurrentFamily).FileTbl.AddFRec; // это необходимо, потому что если нет записи, то документ нельзя залочить
 l_Mask := acFullBlock;
 f_LockJournal.Lock(l_DocID, l_Mask, dtlExclusive);
 //f_LockHandle := LockServer.FullLockDoc(CurrentFamily, 70213052);
//#UC END# *5195F73400EE_519CA57101A1_impl*
end;//TK455105826.DoBeforeImport

procedure TK455105826.DoAfterImport(const aPipe: TddImportPipe);
//#UC START# *5195F75F02CB_519CA57101A1_var*
//#UC END# *5195F75F02CB_519CA57101A1_var*
begin
//#UC START# *5195F75F02CB_519CA57101A1_impl*
 FreeAndNil(f_LockJournal);
//#UC END# *5195F75F02CB_519CA57101A1_impl*
end;//TK455105826.DoAfterImport

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TK455105826.Suite);

end.