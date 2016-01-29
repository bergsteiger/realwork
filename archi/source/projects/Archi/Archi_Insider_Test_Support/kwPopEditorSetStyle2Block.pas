unit kwPopEditorSetStyle2Block;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwPopEditorSetStyle2Block.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::pop_editor_SetStyle2Block
//
// {code}
// aStyle anEditor pop:editor:SetStyle2Block
// {code}
// aStyle -  номер стиля из таблицы стилей.
// anEditor - редактор, в котором производятся изменения.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwEditorFromStackWord,
  evCustomEditorWindow,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwPopEditorSetStyle2Block = {final scriptword} class(TkwEditorFromStackWord)
  {* [code]
aStyle anEditor pop:editor:SetStyle2Block
[code]
aStyle -  номер стиля из таблицы стилей.
anEditor - редактор, в котором производятся изменения. }
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSetStyle2Block
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evOp
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwPopEditorSetStyle2Block

procedure TkwPopEditorSetStyle2Block.DoWithEditor(const aCtx: TtfwContext;
  anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4FF2EF7E03C7_var*
var
 l_StyleID: Integer;
//#UC END# *4F4CB81200CA_4FF2EF7E03C7_var*
begin
//#UC START# *4F4CB81200CA_4FF2EF7E03C7_impl*
 if aCtx.rEngine.IsTopInt then
  l_StyleID := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задан стиль для установки!');
 evSetStyle2Block(anEditor.Selection.Cursor.MostInner.ParentPoint.Obj^.AsObject, anEditor.StartOp(ev_ocUser + 100), l_StyleID);
//#UC END# *4F4CB81200CA_4FF2EF7E03C7_impl*
end;//TkwPopEditorSetStyle2Block.DoWithEditor

class function TkwPopEditorSetStyle2Block.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:SetStyle2Block';
end;//TkwPopEditorSetStyle2Block.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация pop_editor_SetStyle2Block
 TkwPopEditorSetStyle2Block.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.