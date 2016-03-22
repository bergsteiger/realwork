unit kwDualCompiledWordContainer;
 {* Контейнер для хранения парных скомпилированных слов (begin end) }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwDualCompiledWordContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwDualCompiledWordContainer" MUID: (4DBAC27801EF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwDualCompiledWordContainer = {abstract} class(TkwCompiledWordContainer)
  {* Контейнер для хранения парных скомпилированных слов (begin end) }
  protected
   f_ElseBranch: TtfwWord;
  protected
   function pm_GetElseBranch: TtfwWord;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aIf: TtfwWord;
    aElse: TtfwWord;
    const aCtx: TtfwContext); reintroduce;
  public
   property ElseBranch: TtfwWord
    read pm_GetElseBranch;
 end;//TkwDualCompiledWordContainer
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , tfwClassRef
;

function TkwDualCompiledWordContainer.pm_GetElseBranch: TtfwWord;
//#UC START# *53DB68CF0124_4DBAC27801EFget_var*
//#UC END# *53DB68CF0124_4DBAC27801EFget_var*
begin
//#UC START# *53DB68CF0124_4DBAC27801EFget_impl*
 Result := f_ElseBranch;
//#UC END# *53DB68CF0124_4DBAC27801EFget_impl*
end;//TkwDualCompiledWordContainer.pm_GetElseBranch

constructor TkwDualCompiledWordContainer.Create(aIf: TtfwWord;
 aElse: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *4DB6F4CB03BE_4DBAC27801EF_var*
//#UC END# *4DB6F4CB03BE_4DBAC27801EF_var*
begin
//#UC START# *4DB6F4CB03BE_4DBAC27801EF_impl*
 inherited Create(aIf, aCtx);
 aElse.SetRefTo(f_ElseBranch);
//#UC END# *4DB6F4CB03BE_4DBAC27801EF_impl*
end;//TkwDualCompiledWordContainer.Create

procedure TkwDualCompiledWordContainer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DBAC27801EF_var*
//#UC END# *479731C50290_4DBAC27801EF_var*
begin
//#UC START# *479731C50290_4DBAC27801EF_impl*
 FreeAndNil(f_ElseBranch);
 inherited;
//#UC END# *479731C50290_4DBAC27801EF_impl*
end;//TkwDualCompiledWordContainer.Cleanup

initialization
 TkwDualCompiledWordContainer.RegisterClass;
 {* Регистрация TkwDualCompiledWordContainer }
{$IfEnd} // NOT Defined(NoScripts)

end.
