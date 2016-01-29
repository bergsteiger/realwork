unit atClearUserJournalOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atClearUserJournalOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatClearUserJournalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatClearUserJournalOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatClearUserJournalOperation

implementation

uses
  atUserJournalHelper,
  atLogger
  ;

// start class TatClearUserJournalOperation

procedure TatClearUserJournalOperation.ExecuteSelf;
//#UC START# *48089F460352_4FCCF88E0303_var*
//#UC END# *48089F460352_4FCCF88E0303_var*
begin
//#UC START# *48089F460352_4FCCF88E0303_impl*
  TatUserJournalHelper.Clear;
  Logger.Info('Журнал работы очищен');
//#UC END# *48089F460352_4FCCF88E0303_impl*
end;//TatClearUserJournalOperation.ExecuteSelf

end.