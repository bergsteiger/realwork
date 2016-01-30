unit kwPopEditorSetStyle2Table;
 {* [code]
aStyle anEditor pop:editor:SetStyle2Table
[code]
aStyle -  номер стил€ из таблицы стилей.
anEditor - редактор, в котором производ€тс€ изменени€. }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorSetStyle2Table.pas"
// —тереотип: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSetStyle2Table = {final} class(TkwEditorFromStackWord)
  {* [code]
aStyle anEditor pop:editor:SetStyle2Table
[code]
aStyle -  номер стил€ из таблицы стилей.
anEditor - редактор, в котором производ€тс€ изменени€. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSetStyle2Table
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCommonUtils
;

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
  Assert(False, 'Ќе задан стиль дл€ установки!');
 aCtx.rCaller.Check(evSetTableStyle(anEditor), 'Ќе удалось поставить стиль на таблицу!');
//#UC END# *4F4CB81200CA_52B17C50008A_impl*
end;//TkwPopEditorSetStyle2Table.DoWithEditor

class function TkwPopEditorSetStyle2Table.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SetStyle2Table';
end;//TkwPopEditorSetStyle2Table.GetWordNameForRegister

initialization
 TkwPopEditorSetStyle2Table.RegisterInEngine;
 {* –егистраци€ pop_editor_SetStyle2Table }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
