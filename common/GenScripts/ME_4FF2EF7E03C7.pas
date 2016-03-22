unit kwPopEditorSetStyle2Block;
 {* [code]
aStyle anEditor pop:editor:SetStyle2Block
[code]
aStyle -  номер стил€ из таблицы стилей.
anEditor - редактор, в котором производ€тс€ изменени€. }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorSetStyle2Block.pas"
// —тереотип: "ScriptKeyword"
// Ёлемент модели: "pop_editor_SetStyle2Block" MUID: (4FF2EF7E03C7)
// »м€ типа: "TkwPopEditorSetStyle2Block"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSetStyle2Block = {final} class(TkwEditorFromStackWord)
  {* [code]
aStyle anEditor pop:editor:SetStyle2Block
[code]
aStyle -  номер стил€ из таблицы стилей.
anEditor - редактор, в котором производ€тс€ изменени€. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSetStyle2Block
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evOp
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

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
  Assert(False, 'Ќе задан стиль дл€ установки!');
 evSetStyle2Block(anEditor.Selection.Cursor.MostInner.ParentPoint.Obj^.AsObject, anEditor.StartOp(ev_ocUser + 100), l_StyleID);
//#UC END# *4F4CB81200CA_4FF2EF7E03C7_impl*
end;//TkwPopEditorSetStyle2Block.DoWithEditor

class function TkwPopEditorSetStyle2Block.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SetStyle2Block';
end;//TkwPopEditorSetStyle2Block.GetWordNameForRegister

initialization
 TkwPopEditorSetStyle2Block.RegisterInEngine;
 {* –егистраци€ pop_editor_SetStyle2Block }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
