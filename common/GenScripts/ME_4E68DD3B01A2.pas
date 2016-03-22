unit kwPopEditorUpdateCursorFromHotSpotEx;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpotEx.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_UpdateCursorFromHotSpotEx" MUID: (4E68DD3B01A2)
// Имя типа: "TkwPopEditorUpdateCursorFromHotSpotEx"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorUpdateCursorFromHotSpotEx = class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorUpdateCursorFromHotSpotEx
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TevCustomEditorWindowHack = class(TevCustomEditorWindow)
 end;//TevCustomEditorWindowHack

procedure TkwPopEditorUpdateCursorFromHotSpotEx.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4E68DD3B01A2_var*
var
 l_X, l_Y : Integer;
//#UC END# *4F4CB81200CA_4E68DD3B01A2_var*
begin
//#UC START# *4F4CB81200CA_4E68DD3B01A2_impl*
 l_Y := aCtx.rEngine.PopInt;
 l_X := aCtx.rEngine.PopInt;
 TevCustomEditorWindowHack(anEditor).UpdateCursorFromHotSpotEx(l_X, l_Y);
//#UC END# *4F4CB81200CA_4E68DD3B01A2_impl*
end;//TkwPopEditorUpdateCursorFromHotSpotEx.DoWithEditor

class function TkwPopEditorUpdateCursorFromHotSpotEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:UpdateCursorFromHotSpotEx';
end;//TkwPopEditorUpdateCursorFromHotSpotEx.GetWordNameForRegister

initialization
 TkwPopEditorUpdateCursorFromHotSpotEx.RegisterInEngine;
 {* Регистрация pop_editor_UpdateCursorFromHotSpotEx }
{$IfEnd} // NOT Defined(NoScripts)

end.
