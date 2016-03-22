{$IfNDef evCacheableStyleTableListener_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evCacheableStyleTableListener.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "evCacheableStyleTableListener" MUID: (4A485B9801E0)
// Имя типа: "_evCacheableStyleTableListener_"

{$Define evCacheableStyleTableListener_imp}

{$If NOT Defined(DesignTimeLibrary)}
 _evStyleTableListenerPrim_Parent_ = _evCacheableStyleTableListener_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas}
 _evCacheableStyleTableListener_ = class(_evStyleTableListenerPrim_)
  {* Подписчик на изменение таблицы стилей, который держит какие-то параметры зависящие от с тилей в то время, когда находится в кеше }
  protected
   procedure Release; override;
 end;//_evCacheableStyleTableListener_

{$Else NOT Defined(DesignTimeLibrary)}

_evStyleTableListenerPrim_Parent_ = _evCacheableStyleTableListener_Parent_;
{$Include w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas}
_evCacheableStyleTableListener_ = _evStyleTableListenerPrim_;

{$IfEnd} // NOT Defined(DesignTimeLibrary)
{$Else evCacheableStyleTableListener_imp}

{$IfNDef evCacheableStyleTableListener_imp_impl}

{$Define evCacheableStyleTableListener_imp_impl}

{$If NOT Defined(DesignTimeLibrary)}
{$Include w:\common\components\gui\Garant\Everest\evStyleTableListenerPrim.imp.pas}

procedure _evCacheableStyleTableListener_.Release;
//#UC START# *479F2AFB0397_4A485B9801E0_var*
//#UC END# *479F2AFB0397_4A485B9801E0_var*
begin
//#UC START# *479F2AFB0397_4A485B9801E0_impl*
 evDelStyleTableSpy(Self);
 inherited;
//#UC END# *479F2AFB0397_4A485B9801E0_impl*
end;//_evCacheableStyleTableListener_.Release
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$EndIf evCacheableStyleTableListener_imp_impl}

{$EndIf evCacheableStyleTableListener_imp}

