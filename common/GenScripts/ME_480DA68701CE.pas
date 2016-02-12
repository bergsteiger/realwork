{$IfNDef evStyleTableListener_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas"
// Стереотип: "Impurity"

{$Define evStyleTableListener_imp}

{$If NOT Defined(DesignTimeLibrary)}
 _evStyleTableListenerPrim_Parent_ = _evStyleTableListener_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas}
 _evStyleTableListener_ = class(_evStyleTableListenerPrim_)
  {* Объект, слушающий изменения таблицы стилей }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//_evStyleTableListener_

{$Else NOT Defined(DesignTimeLibrary)}

_evStyleTableListenerPrim_Parent_ = _evStyleTableListener_Parent_;
{$Include w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas}
_evStyleTableListener_ = _evStyleTableListenerPrim_;

{$IfEnd} // NOT Defined(DesignTimeLibrary)
{$Else evStyleTableListener_imp}

{$IfNDef evStyleTableListener_imp_impl}

{$Define evStyleTableListener_imp_impl}

{$If NOT Defined(DesignTimeLibrary)}
{$Include w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas}

procedure _evStyleTableListener_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_480DA68701CE_var*
//#UC END# *479731C50290_480DA68701CE_var*
begin
//#UC START# *479731C50290_480DA68701CE_impl*
 evDelStyleTableSpy(Self);
 inherited;
//#UC END# *479731C50290_480DA68701CE_impl*
end;//_evStyleTableListener_.Cleanup
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$EndIf evStyleTableListener_imp_impl}

{$EndIf evStyleTableListener_imp}

