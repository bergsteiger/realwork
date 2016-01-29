{$IfNDef atDeleteFoldersObjectAddon_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atDeleteFoldersObjectAddon.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atDeleteFoldersObjectAddon
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atDeleteFoldersObjectAddon_imp}
 _atDeleteFoldersObjectAddon_ = {mixin} class(_atDeleteFoldersObjectAddon_Parent_, IatFoldersNodeCallback)
 protected
 // realized methods
   procedure ExecuteSelf; override;
   procedure OnFoldersNode(const aFoldersNode: IFoldersNode);
 end;//_atDeleteFoldersObjectAddon_

{$Else atDeleteFoldersObjectAddon_imp}

// start class _atDeleteFoldersObjectAddon_

procedure _atDeleteFoldersObjectAddon_.ExecuteSelf;
//#UC START# *48089F460352_4FCF9DCF00E8_var*
//#UC END# *48089F460352_4FCF9DCF00E8_var*
begin
//#UC START# *48089F460352_4FCF9DCF00E8_impl*
  inherited;
  Logger.Info('Удалено %d объектов.', [f_ProcessedObjects]);
//#UC END# *48089F460352_4FCF9DCF00E8_impl*
end;//_atDeleteFoldersObjectAddon_.ExecuteSelf

procedure _atDeleteFoldersObjectAddon_.OnFoldersNode(const aFoldersNode: IFoldersNode);
//#UC START# *4FCF8EE001D4_4FCF9DCF00E8_var*
//#UC END# *4FCF8EE001D4_4FCF9DCF00E8_var*
begin
//#UC START# *4FCF8EE001D4_4FCF9DCF00E8_impl*
 inherited;
 aFoldersNode.DeleteNode;
//#UC END# *4FCF8EE001D4_4FCF9DCF00E8_impl*
end;//_atDeleteFoldersObjectAddon_.OnFoldersNode

{$EndIf atDeleteFoldersObjectAddon_imp}
