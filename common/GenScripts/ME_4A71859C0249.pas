{$IfNDef dsEdition_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEdition.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsEdition_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include vcmFormDataSource.imp.pas}
 _VScroll_Parent_ = _vcmFormDataSource_;
 {$Include VScroll.imp.pas}
 _dsEdition_ = {abstract} class(_VScroll_, IdsEdition, InsVScrollListener)
  {* Базовая область ввода, для работы с редакциями }
  protected
   CompareEditions: IsdsCompareEditions;
    {* Прецедент Сравнение редакций }
  protected
   function As_InsVScrollListener: InsVScrollListener;
    {* Метод приведения нашего интерфейса к InsVScrollListener }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//_dsEdition_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include vcmFormDataSource.imp.pas}
_VScroll_Parent_ = _vcmFormDataSource_;
{$Include VScroll.imp.pas}
_dsEdition_ = _VScroll_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsEdition_imp}

{$IfNDef dsEdition_imp_impl}

{$Define dsEdition_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include vcmFormDataSource.imp.pas}

{$Include VScroll.imp.pas}

function _dsEdition_.As_InsVScrollListener: InsVScrollListener;
 {* Метод приведения нашего интерфейса к InsVScrollListener }
begin
 Result := Self;
end;//_dsEdition_.As_InsVScrollListener

procedure _dsEdition_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A71859C0249_var*
//#UC END# *479731C50290_4A71859C0249_var*
begin
//#UC START# *479731C50290_4A71859C0249_impl*
 UseCaseController.As_Il3ChangeNotifier.Unsubscribe(InsVScrollListener(Self));
 inherited;
//#UC END# *479731C50290_4A71859C0249_impl*
end;//_dsEdition_.Cleanup

procedure _dsEdition_.InitFields;
//#UC START# *47A042E100E2_4A71859C0249_var*
//#UC END# *47A042E100E2_4A71859C0249_var*
begin
//#UC START# *47A042E100E2_4A71859C0249_impl*
 inherited;
 UseCaseController.As_Il3ChangeNotifier.Subscribe(InsVScrollListener(Self));
//#UC END# *47A042E100E2_4A71859C0249_impl*
end;//_dsEdition_.InitFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsEdition_imp_impl}

{$EndIf dsEdition_imp}

