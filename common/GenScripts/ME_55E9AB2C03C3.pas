{$IfNDef tfwDictionaryListIterator_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "tfwDictionaryListIterator" MUID: (55E9AB2C03C3)
// Имя типа: "_tfwDictionaryListIterator_"

{$Define tfwDictionaryListIterator_imp}

{$If NOT Defined(NoScripts)}
 _tfwDictionaryListIteratorPrim_Parent_ = TtfwIteratableParent;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIteratorPrim.imp.pas}
 _tfwDictionaryListIterator_ = {abstract} class(_tfwDictionaryListIteratorPrim_)
  private
   f_ListToIterate: _ListType_;
  protected
   function ListToIterate: _ListType_; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aListToIterate: _ListType_); reintroduce;
   class function Make(const aListToIterate: _ListType_): ItfwValueList; reintroduce;
 end;//_tfwDictionaryListIterator_

{$Else NOT Defined(NoScripts)}

_tfwDictionaryListIteratorPrim_Parent_ = TtfwIteratableParent;
{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIteratorPrim.imp.pas}
_tfwDictionaryListIterator_ = _tfwDictionaryListIteratorPrim_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwDictionaryListIterator_imp}

{$IfNDef tfwDictionaryListIterator_imp_impl}

{$Define tfwDictionaryListIterator_imp_impl}

{$If NOT Defined(NoScripts)}
{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIteratorPrim.imp.pas}

constructor _tfwDictionaryListIterator_.Create(const aListToIterate: _ListType_);
//#UC START# *55E9ABC00239_55E9AB2C03C3_var*
//#UC END# *55E9ABC00239_55E9AB2C03C3_var*
begin
//#UC START# *55E9ABC00239_55E9AB2C03C3_impl*
 inherited Create;
 f_ListToIterate := aListToIterate;
 //aListToIterate.SetRefTo(f_ListToIterate);
//#UC END# *55E9ABC00239_55E9AB2C03C3_impl*
end;//_tfwDictionaryListIterator_.Create

class function _tfwDictionaryListIterator_.Make(const aListToIterate: _ListType_): ItfwValueList;
var
 l_Inst : _tfwDictionaryListIterator_;
begin
 l_Inst := Create(aListToIterate);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_tfwDictionaryListIterator_.Make

function _tfwDictionaryListIterator_.ListToIterate: _ListType_;
//#UC START# *55AE64E00011_55E9AB2C03C3_var*
//#UC END# *55AE64E00011_55E9AB2C03C3_var*
begin
//#UC START# *55AE64E00011_55E9AB2C03C3_impl*
 Result := f_ListToIterate;
//#UC END# *55AE64E00011_55E9AB2C03C3_impl*
end;//_tfwDictionaryListIterator_.ListToIterate

procedure _tfwDictionaryListIterator_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55E9AB2C03C3_var*
//#UC END# *479731C50290_55E9AB2C03C3_var*
begin
//#UC START# *479731C50290_55E9AB2C03C3_impl*
 //FreeAndNil(f_ListToIterate);
 f_ListToIterate := nil;
 inherited;
//#UC END# *479731C50290_55E9AB2C03C3_impl*
end;//_tfwDictionaryListIterator_.Cleanup
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwDictionaryListIterator_imp_impl}

{$EndIf tfwDictionaryListIterator_imp}

