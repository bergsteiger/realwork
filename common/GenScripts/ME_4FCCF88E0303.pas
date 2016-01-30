unit atClearUserJournalOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atClearUserJournalOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatClearUserJournalOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
 end;//TatClearUserJournalOperation

implementation

uses
 l3ImplUses
 , atUserJournalHelper
 , atLogger
;

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
