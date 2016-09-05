unit tfwCodeIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCodeIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwCodeIterator" MUID: (52E7D66E02FF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwWordsIterator
;

type
 TtfwCodeIterator = class(TtfwWordsIterator)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TtfwCodeIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *52E7D66E02FFimpl_uses*
 //#UC END# *52E7D66E02FFimpl_uses*
;

procedure TtfwCodeIterator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52E7D66E02FF_var*
//#UC END# *479731C50290_52E7D66E02FF_var*
begin
//#UC START# *479731C50290_52E7D66E02FF_impl*
 //FreeAndNil(f_Code);
 //f_Code := nil;
 inherited;
//#UC END# *479731C50290_52E7D66E02FF_impl*
end;//TtfwCodeIterator.Cleanup
{$IfEnd} // NOT Defined(NoScripts)

end.
