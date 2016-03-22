unit tfwDictionaryDataIteratorPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryDataIteratorPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDictionaryDataIteratorPrim" MUID: (55AE5B950148)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIteratableParent
 , tfwDictionaryEx
;

type
 TtfwDictionaryDataIteratorPrim = {abstract} class(TtfwIteratableParent)
  private
   f_Dictionary: TtfwDictionaryEx;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aDictionary: TtfwDictionaryEx); reintroduce;
  protected
   property Dictionary: TtfwDictionaryEx
    read f_Dictionary;
 end;//TtfwDictionaryDataIteratorPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwDictionaryDataIteratorPrim.Create(aDictionary: TtfwDictionaryEx);
//#UC START# *55AE5C1603DE_55AE5B950148_var*
//#UC END# *55AE5C1603DE_55AE5B950148_var*
begin
//#UC START# *55AE5C1603DE_55AE5B950148_impl*
 Assert(aDictionary <> nil);
 inherited Create;
 f_Dictionary := aDictionary;
 //aDictionary.SetRefTo(f_Dictionary);
//#UC END# *55AE5C1603DE_55AE5B950148_impl*
end;//TtfwDictionaryDataIteratorPrim.Create

procedure TtfwDictionaryDataIteratorPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55AE5B950148_var*
//#UC END# *479731C50290_55AE5B950148_var*
begin
//#UC START# *479731C50290_55AE5B950148_impl*
 //FreeAndNil(f_Dictionary);
 f_Dictionary := nil;
 inherited;
//#UC END# *479731C50290_55AE5B950148_impl*
end;//TtfwDictionaryDataIteratorPrim.Cleanup
{$IfEnd} // NOT Defined(NoScripts)

end.
