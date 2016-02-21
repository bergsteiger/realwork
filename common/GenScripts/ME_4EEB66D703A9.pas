unit kwPopEditorParaCoordsToScreen;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaCoordsToScreen.pas"
// Стереотип: "ScriptKeyword"

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
 TkwPopEditorParaCoordsToScreen = {final} class(TkwParaCoordsToScreen)
  protected
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaCoordsToScreen
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

function TkwPopEditorParaCoordsToScreen.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4EEB66D703A9_var*
//#UC END# *4C3C927B027E_4EEB66D703A9_var*
begin
//#UC START# *4C3C927B027E_4EEB66D703A9_impl*
 Result := l3Point(aMap.Bounds.Left, aMap.Bounds.Top);
//#UC END# *4C3C927B027E_4EEB66D703A9_impl*
end;//TkwPopEditorParaCoordsToScreen.GetPoint

class function TkwPopEditorParaCoordsToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaCoordsToScreen';
end;//TkwPopEditorParaCoordsToScreen.GetWordNameForRegister

initialization
 TkwPopEditorParaCoordsToScreen.RegisterInEngine;
 {* Регистрация pop_editor_ParaCoordsToScreen }
{$IfEnd} // NOT Defined(NoScripts)

end.
