{$IfNDef dsSituation_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSituation.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsSituation_imp}

 _InitDataType_ = IdeSearch;
 {$Include dsTagSimpleTree.imp.pas}
 _CurrentChangedListener_Parent_ = _dsTagSimpleTree_;
 {$Include CurrentChangedListener.imp.pas}
 _dsSituation_ = {abstract} class(_CurrentChangedListener_, IdsSituation, IbsCurrentChangedListener)
  {* отложенное обновление представлений при перемещении по деревьям ППС 6.х (CQ: OIT5-28303) }
  private
   CurrentChangedListener: IbsCurrentChangedListener;
   f_BlockNotification: Integer;
    {* Поле для свойства BlockNotification }
  protected
   function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
    {* Метод приведения нашего интерфейса к IbsCurrentChangedListener }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
    {* сменился текущий. }
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); override;
  private
   property BlockNotification: Integer
    read f_BlockNotification
    write f_BlockNotification;
 end;//_dsSituation_

{$Else dsSituation_imp}

{$IfNDef dsSituation_imp_impl}

{$Define dsSituation_imp_impl}

{$Include dsTagSimpleTree.imp.pas}

{$Include CurrentChangedListener.imp.pas}

function _dsSituation_.As_IbsCurrentChangedListener: IbsCurrentChangedListener;
 {* Метод приведения нашего интерфейса к IbsCurrentChangedListener }
begin
 Result := Self;
end;//_dsSituation_.As_IbsCurrentChangedListener

procedure _dsSituation_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49242CB201D0_var*
//#UC END# *479731C50290_49242CB201D0_var*
begin
//#UC START# *479731C50290_49242CB201D0_impl*
 if (UseCaseController <> nil) then
  UseCaseController.As_Il3ChangeNotifier.Unsubscribe(IbsCurrentChangedListener(Self));
 inherited;
//#UC END# *479731C50290_49242CB201D0_impl*
end;//_dsSituation_.Cleanup

procedure _dsSituation_.InitFields;
//#UC START# *47A042E100E2_49242CB201D0_var*
//#UC END# *47A042E100E2_49242CB201D0_var*
begin
//#UC START# *47A042E100E2_49242CB201D0_impl*
 inherited;
 BlockNotification := 0;
 if (UseCaseController <> nil) then
  UseCaseController.As_Il3ChangeNotifier.Subscribe(IbsCurrentChangedListener(Self));
//#UC END# *47A042E100E2_49242CB201D0_impl*
end;//_dsSituation_.InitFields

procedure _dsSituation_.DoCurrentChanged(const aNode: Il3SimpleNode);
 {* сменился текущий. }
//#UC START# *47F0C1BF0314_49242CB201D0_var*
//#UC END# *47F0C1BF0314_49242CB201D0_var*
begin
//#UC START# *47F0C1BF0314_49242CB201D0_impl*
 inherited;
 if (CurrentChangedListener <> nil) then
 begin
  Inc(f_BlockNotification);
  try
   CurrentChangedListener.Process(aNode);
  finally
   Dec(f_BlockNotification);
  end;//try..finally
 end;//CurrentChangedListener <> nil
//#UC END# *47F0C1BF0314_49242CB201D0_impl*
end;//_dsSituation_.DoCurrentChanged

procedure _dsSituation_.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *49242A4E0252_49242CB201D0_var*
//#UC END# *49242A4E0252_49242CB201D0_var*
begin
//#UC START# *49242A4E0252_49242CB201D0_impl*
 if (BlockNotification = 0) then
  inherited;
//#UC END# *49242A4E0252_49242CB201D0_impl*
end;//_dsSituation_.CurrentChangedNotification

{$EndIf dsSituation_imp_impl}

{$EndIf dsSituation_imp}

