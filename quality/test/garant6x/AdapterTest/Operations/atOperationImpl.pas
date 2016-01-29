unit atOperationImpl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atOperationImpl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x_test::AdapterTest::Operations::atOperationImpl
//
// Регистрирует в фабрике операции.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface


implementation

uses
  atDeleteBookmarkOperation,
  atDeleteCommentOperation,
  atDeleteListOperation,
  atDeleteFoldersOperation,
  atGetCRListFromDocumentOperation,
  atGuestLoginOperation,
  atLoadDocumentsByIDFromListOperation,
  atLoginOperation,
  atLogoutOperation,
  atOpenDocumentsFromListOperation,
  atOpenRedactionsOperation,
  atSynchroPointOperation,
  atSortListOperation,
  atPauseOperation,
  atSaveListToFolderOperation,
  atSemaphoreOperation,
  atSendConsultationOperation,
  atSetBookmarkOperation,
  atSetCommentOperation,
  atSleepOperation,
  atAbortOperation,
  atBaseSearchOperation,
  atCreateFoldersOperation,
  atCycleOperation,
  atDeleteAllOperation,
  atOperationFactory,
  atTestChatOperation,
  atOpenListByRubricatorOperation,
  atCompareRedactionsOperation,
  atExecuteUserJournalOperation,
  atClearUserJournalOperation,
  atOpenSavedBookmarkOperation,
  atOpenSavedListOperation,
  atExecuteSavedQueryOperation,
  atLoginFromListOperation,
  atSaveFoldersQueryToXMLOperation,
  atSaveJournalQueryToXMLOperation,
  atExecuteQueryFromXMLOperation,
  atAddLastQueryToJournalOperation,
  atFiltrateTreeOperation,
  atDumpTreeOperation,
  atContextSearchInDocumentOperation,
  atDocumentUnderControlOperation,
  atIterateDocumentsUnderControlOperation,
  atJurQueryTestOperation,
  atSaveListToFileOperation,
  atCompareSavedListOperation
  ;


initialization
//#UC START# *4AC1FD2D02BF*
  with OperationFactory do
  begin
    RegisterOperation(TatLoginOperation);
    RegisterOperation(TatSleepOperation);
    RegisterOperation(TatLogoutOperation);
    RegisterOperation(TatGuestLoginOperation);
    RegisterOperation(TatLoadDocumentsByIDFromListOperation);
    RegisterOperation(TatSetBookmarkOperation);
    RegisterOperation(TatDeleteBookmarkOperation);
    RegisterOperation(TatSetCommentOperation);
    RegisterOperation(TatDeleteCommentOperation);
    RegisterOperation(TatBaseSearchOperation);
    RegisterOperation(TatCreateFoldersOperation);
    RegisterOperation(TatDeleteFoldersOperation);
    RegisterOperation(TatSaveListToFolderOperation);
    RegisterOperation(TatOpenDocumentsFromListOperation);
    RegisterOperation(TatDeleteListOperation);
    RegisterOperation(TatDeleteAllOperation);
    RegisterOperation(TatCycleOperation);
    RegisterOperation(TatAbortOperation);
    RegisterOperation(TatOpenRedactionsOperation);
    RegisterOperation(TatSynchroPointOperation);
    RegisterOperation(TatGetCRListFromDocumentOperation);
    RegisterOperation(TatSortListOperation);
    RegisterOperation(TatSemaphoreOperation);
    RegisterOperation(TatPauseOperation);
    RegisterOperation(TatSendConsultationOperation);
    RegisterOperation(TatTestChatOperation);
    RegisterOperation(TatOpenListByRubricatorOperation);
    RegisterOperation(TatCompareRedactionsOperation);
    RegisterOperation(TatExecuteUserJournalOperation);
    RegisterOperation(TatClearUserJournalOperation);
    RegisterOperation(TatOpenSavedBookmarkOperation);
    RegisterOperation(TatOpenSavedListOperation);
    RegisterOperation(TatExecuteSavedQueryOperation);
    RegisterOperation(TatLoginFromListOperation);
    RegisterOperation(TatSaveFoldersQueryToXMLOperation);
    RegisterOperation(TatSaveJournalQueryToXMLOperation);
    RegisterOperation(TatExecuteQueryFromXMLOperation);
    RegisterOperation(TatAddLastQueryToJournalOperation);
    RegisterOperation(TatFiltrateTreeOperation);
    RegisterOperation(TatDumpTreeOperation);
    RegisterOperation(TatContextSearchInDocumentOperation);
    RegisterOperation(TatDocumentUnderControlOperation);
    RegisterOperation(TatIterateDocumentsUnderControlOperation);
    RegisterOperation(TatJurQueryTestOperation);
    RegisterOperation(TatSaveListToFileOperation);
    RegisterOperation(TatCompareSavedListOperation);
  end;
//#UC END# *4AC1FD2D02BF*

end.