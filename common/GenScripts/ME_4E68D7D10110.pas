unit kwPopEditorUpdateCursorFromHotSpot;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpot.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorUpdateCursorFromHotSpot = class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorUpdateCursorFromHotSpot
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

type
 TevCustomEditorWindowHack = class(TevCustomEditorWindow)
 end;//TevCustomEditorWindowHack

procedure TkwPopEditorUpdateCursorFromHotSpot.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4E68D7D10110_var*
//#UC END# *4F4CB81200CA_4E68D7D10110_var*
begin
//#UC START# *4F4CB81200CA_4E68D7D10110_impl*
 TevCustomEditorWindowHack(anEditor).UpdateCursorFromHotSpot;
//#UC END# *4F4CB81200CA_4E68D7D10110_impl*
end;//TkwPopEditorUpdateCursorFromHotSpot.DoWithEditor

class function TkwPopEditorUpdateCursorFromHotSpot.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:UpdateCursorFromHotSpot';
end;//TkwPopEditorUpdateCursorFromHotSpot.GetWordNameForRegister

initialization
 TkwPopEditorUpdateCursorFromHotSpot.RegisterInEngine;
 {* Регистрация pop_editor_UpdateCursorFromHotSpot }
{$IfEnd} // NOT Defined(NoScripts)

end.
