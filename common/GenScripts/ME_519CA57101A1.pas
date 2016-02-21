unit K455105826;

// Модуль: "w:\archi\source\projects\ImportExportTest\K455105826.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ietBaseTest
 {$If NOT Defined(Nemesis)}
 , dt_Jour
 {$IfEnd} // NOT Defined(Nemesis)
 , ddImportPipe
;

type
 TK455105826 = class(TietBaseTest)
  private
   f_LockJournal: TAbstractJournal;
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   procedure DoBeforeImport(const aPipe: TddImportPipe); override;
   procedure DoAfterImport(const aPipe: TddImportPipe); override;
 end;//TK455105826
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , dt_Const
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , dt_Lock
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(Archi) AND NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // Defined(Archi) AND NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , TestFrameWork
;

function TK455105826.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ImportExport';
end;//TK455105826.GetFolder

function TK455105826.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
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

initialization
 TestFramework.RegisterTest(TK455105826.Suite);
{$IfEnd} // Defined(nsTest)

end.
