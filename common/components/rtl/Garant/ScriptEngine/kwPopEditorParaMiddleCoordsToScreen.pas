unit kwPopEditorParaMiddleCoordsToScreen;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaMiddleCoordsToScreen.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_ParaMiddleCoordsToScreen" MUID: (4F95434701ED)
// Имя типа: "TkwPopEditorParaMiddleCoordsToScreen"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwParaCoordsToScreen
 , l3Units
 , nevTools
;

type
 TkwPopEditorParaMiddleCoordsToScreen = {final} class(TkwParaCoordsToScreen)
  protected
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaMiddleCoordsToScreen
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Types
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TkwPopEditorParaMiddleCoordsToScreen.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4F95434701ED_var*
//#UC END# *4C3C927B027E_4F95434701ED_var*
begin
//#UC START# *4C3C927B027E_4F95434701ED_impl*
 Result := l3Point((aMap.Bounds.Left + aMap.Bounds.Right) div 2, aMap.Bounds.Top);
//#UC END# *4C3C927B027E_4F95434701ED_impl*
end;//TkwPopEditorParaMiddleCoordsToScreen.GetPoint

class function TkwPopEditorParaMiddleCoordsToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaMiddleCoordsToScreen';
end;//TkwPopEditorParaMiddleCoordsToScreen.GetWordNameForRegister

initialization
 TkwPopEditorParaMiddleCoordsToScreen.RegisterInEngine;
 {* Регистрация pop_editor_ParaMiddleCoordsToScreen }
{$IfEnd} // NOT Defined(NoScripts)

end.
