unit kwPopEditorSetStyle2Table;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwPopEditorSetStyle2Table.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::pop_editor_SetStyle2Table
//
// {code}
// aStyle anEditor pop:editor:SetStyle2Table
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
 TkwPopEditorSetStyle2Table = {final scriptword} class(TkwEditorFromStackWord)
  {* [code]
aStyle anEditor pop:editor:SetStyle2Table
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
 end;//TkwPopEditorSetStyle2Table
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  evCommonUtils
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwPopEditorSetStyle2Table

procedure TkwPopEditorSetStyle2Table.DoWithEditor(const aCtx: TtfwContext;
  anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_52B17C50008A_var*
var
 l_StyleID: Integer;
//#UC END# *4F4CB81200CA_52B17C50008A_var*
begin
//#UC START# *4F4CB81200CA_52B17C50008A_impl*
 if aCtx.rEngine.IsTopInt then
  l_StyleID := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задан стиль для установки!');
 aCtx.rCaller.Check(evSetTableStyle(anEditor), 'Не удалось поставить стиль на таблицу!');
//#UC END# *4F4CB81200CA_52B17C50008A_impl*
end;//TkwPopEditorSetStyle2Table.DoWithEditor

class function TkwPopEditorSetStyle2Table.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:editor:SetStyle2Table';
end;//TkwPopEditorSetStyle2Table.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация pop_editor_SetStyle2Table
 TkwPopEditorSetStyle2Table.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.