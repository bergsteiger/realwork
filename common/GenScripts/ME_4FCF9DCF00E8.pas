{$IfNDef atDeleteFoldersObjectAddon_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas"
// Стереотип: "Impurity"

{$Define atDeleteFoldersObjectAddon_imp}

 _atDeleteFoldersObjectAddon_ = class(_atDeleteFoldersObjectAddon_Parent_, IatFoldersNodeCallback)
  protected
   procedure ExecuteSelf; override;
   procedure OnFoldersNode(const aFoldersNode: IFoldersNode);
 end;//_atDeleteFoldersObjectAddon_

{$Else atDeleteFoldersObjectAddon_imp}

{$IfNDef atDeleteFoldersObjectAddon_imp_impl}

{$Define atDeleteFoldersObjectAddon_imp_impl}

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

{$EndIf atDeleteFoldersObjectAddon_imp_impl}

{$EndIf atDeleteFoldersObjectAddon_imp}

