unit kwWordPtrWorker;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrWorker.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 TkwWordPtrWorker = {abstract} class(TtfwWord)
  protected
   f_Word: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aWord: TtfwWord); reintroduce;
 end;//TkwWordPtrWorker
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

constructor TkwWordPtrWorker.Create(aWord: TtfwWord);
//#UC START# *4F37AE8B03CE_4F37ADFF0150_var*
//#UC END# *4F37AE8B03CE_4F37ADFF0150_var*
begin
//#UC START# *4F37AE8B03CE_4F37ADFF0150_impl*
 inherited Create;
 f_Word := aWord;
//#UC END# *4F37AE8B03CE_4F37ADFF0150_impl*
end;//TkwWordPtrWorker.Create

procedure TkwWordPtrWorker.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F37ADFF0150_var*
//#UC END# *479731C50290_4F37ADFF0150_var*
begin
//#UC START# *479731C50290_4F37ADFF0150_impl*
 f_Word := nil;
 inherited;
//#UC END# *479731C50290_4F37ADFF0150_impl*
end;//TkwWordPtrWorker.Cleanup

initialization
 TkwWordPtrWorker.RegisterClass;
 {* Регистрация TkwWordPtrWorker }
{$IfEnd} // NOT Defined(NoScripts)

end.
