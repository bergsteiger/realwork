unit kwCompiledWordWorker;
 {* Базовый класс для исполняемых скомпилированных слов. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledWordWorker" MUID: (4DCBD50101CB)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
;

type
 RkwCompiledWordWorker = class of TkwCompiledWordWorker;

 TkwCompiledWordWorker = {abstract} class(TkwSourcePointWord)
  {* Базовый класс для исполняемых скомпилированных слов. }
  private
   f_WordToWork: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aWordToPush: TtfwWord;
    aWordToRun: TtfwWord;
    const aCtx: TtfwContext); reintroduce; virtual;
  public
   property WordToWork: TtfwWord
    read f_WordToWork;
 end;//TkwCompiledWordWorker
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4DCBD50101CBimpl_uses*
 //#UC END# *4DCBD50101CBimpl_uses*
;

constructor TkwCompiledWordWorker.Create(aWordToPush: TtfwWord;
 aWordToRun: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *4DCBB0CD028D_4DCBD50101CB_var*
//#UC END# *4DCBB0CD028D_4DCBD50101CB_var*
begin
//#UC START# *4DCBB0CD028D_4DCBD50101CB_impl*
 inherited Create(aCtx);
 aWordToPush.SetRefTo(f_WordToWork);
//#UC END# *4DCBB0CD028D_4DCBD50101CB_impl*
end;//TkwCompiledWordWorker.Create

procedure TkwCompiledWordWorker.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DCBD50101CB_var*
//#UC END# *479731C50290_4DCBD50101CB_var*
begin
//#UC START# *479731C50290_4DCBD50101CB_impl*
 FreeAndNil(f_WordToWork);
 inherited;
//#UC END# *479731C50290_4DCBD50101CB_impl*
end;//TkwCompiledWordWorker.Cleanup

initialization
 TkwCompiledWordWorker.RegisterClass;
 {* Регистрация TkwCompiledWordWorker }
 TtfwTypeRegistrator.RegisterType(@tfw_tiClassRef);
 {* Регистрация типа RkwCompiledWordWorker }
{$IfEnd} // NOT Defined(NoScripts)

end.
