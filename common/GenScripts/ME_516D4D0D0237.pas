{$IfNDef UnknownImpl_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\UnknownImpl.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "UnknownImpl" MUID: (516D4D0D0237)
// Имя типа: "_UnknownImpl_"

{$Define UnknownImpl_imp}

 _RefCounted_Parent_ = _UnknownImpl_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}
 _UnknownImpl_ = class(_RefCounted_)
  public
   function _AddRef: Integer; stdcall;
    {* Увеличивает счетчик ссылок. }
   function _Release: Integer; stdcall;
    {* Уменьшает счетчик ссылок. }
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; stdcall;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//_UnknownImpl_

{$Else UnknownImpl_imp}

{$IfNDef UnknownImpl_imp_impl}

{$Define UnknownImpl_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

function _UnknownImpl_._AddRef: Integer;
 {* Увеличивает счетчик ссылок. }
//#UC START# *47913C24007F_516D4D0D0237_var*
//#UC END# *47913C24007F_516D4D0D0237_var*
begin
//#UC START# *47913C24007F_516D4D0D0237_impl*
 Use;
 Result := RefCount;
 // - тут есть проблемы с многопоточностью
//#UC END# *47913C24007F_516D4D0D0237_impl*
end;//_UnknownImpl_._AddRef

function _UnknownImpl_._Release: Integer;
 {* Уменьшает счетчик ссылок. }
//#UC START# *47913C5301A1_516D4D0D0237_var*
var
 l_RC : Integer;
//#UC END# *47913C5301A1_516D4D0D0237_var*
begin
//#UC START# *47913C5301A1_516D4D0D0237_impl*
 l_RC := RefCount - 1;
 Free;
 Result := l_RC;
 // - тут есть проблемы с многопоточностью
//#UC END# *47913C5301A1_516D4D0D0237_impl*
end;//_UnknownImpl_._Release

function _UnknownImpl_.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47913CBF0265_516D4D0D0237_var*
//#UC END# *47913CBF0265_516D4D0D0237_var*
begin
//#UC START# *47913CBF0265_516D4D0D0237_impl*
 if TObject(Self).GetInterface(IID, Obj) then
  Result := S_Ok
 else
  Result := E_NoInterface;
//#UC END# *47913CBF0265_516D4D0D0237_impl*
end;//_UnknownImpl_.QueryInterface

{$EndIf UnknownImpl_imp_impl}

{$EndIf UnknownImpl_imp}

