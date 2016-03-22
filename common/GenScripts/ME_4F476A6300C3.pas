unit kwInnerIncludedInChildren;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncludedInChildren.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwInnerIncluded
 , tfwScriptingInterfaces
;

type
 TkwInnerIncludedInChildren = class(TkwInnerIncluded)
  private
   f_WordToIncludeTo: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FillContext(const anOldContext: TtfwContext;
    var theNewContext: TtfwContext); override;
  public
   constructor Create(const aFileName: AnsiString;
    aWordToIncludeTo: TtfwWord); reintroduce;
 end;//TkwInnerIncludedInChildren
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TkwInnerIncludedInChildren.Create(const aFileName: AnsiString;
 aWordToIncludeTo: TtfwWord);
//#UC START# *4F476C1500DF_4F476A6300C3_var*
//#UC END# *4F476C1500DF_4F476A6300C3_var*
begin
//#UC START# *4F476C1500DF_4F476A6300C3_impl*
 inherited Create(aFileName);
 aWordToIncludeTo.SetRefTo(f_WordToIncludeTo);
//#UC END# *4F476C1500DF_4F476A6300C3_impl*
end;//TkwInnerIncludedInChildren.Create

procedure TkwInnerIncludedInChildren.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F476A6300C3_var*
//#UC END# *479731C50290_4F476A6300C3_var*
begin
//#UC START# *479731C50290_4F476A6300C3_impl*
 FreeAndNil(f_WordToIncludeTo);
 inherited;
//#UC END# *479731C50290_4F476A6300C3_impl*
end;//TkwInnerIncludedInChildren.Cleanup

procedure TkwInnerIncludedInChildren.FillContext(const anOldContext: TtfwContext;
 var theNewContext: TtfwContext);
//#UC START# *4F3AA59B025A_4F476A6300C3_var*
//#UC END# *4F3AA59B025A_4F476A6300C3_var*
begin
//#UC START# *4F3AA59B025A_4F476A6300C3_impl*
 inherited;
 theNewContext.rKeyWords := f_WordToIncludeTo;
 theNewContext.rCompiler := f_WordToIncludeTo;
//#UC END# *4F3AA59B025A_4F476A6300C3_impl*
end;//TkwInnerIncludedInChildren.FillContext

initialization
!!! Lost ini !!!
 {* Регистрация TkwInnerIncludedInChildren }
{$IfEnd} // NOT Defined(NoScripts)

end.
