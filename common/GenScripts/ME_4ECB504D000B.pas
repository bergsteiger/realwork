unit kwEditorSetTOC;
 {* редактор:установить_оглавление }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorSetTOC.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwEditorSetTOC" MUID: (4ECB504D000B)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEditorSetTOC = class(TtfwRegisterableWord)
  {* редактор:установить_оглавление }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwEditorSetTOC
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

class function TkwEditorSetTOC.GetWordNameForRegister: AnsiString;
begin
 Result := 'редактор:установить_оглавление';
end;//TkwEditorSetTOC.GetWordNameForRegister

procedure TkwEditorSetTOC.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4ECB504D000B_var*
var
 l_BlockID: Integer;
//#UC END# *4DAEEDE10285_4ECB504D000B_var*
begin
//#UC START# *4DAEEDE10285_4ECB504D000B_impl*
 if aCtx.rEngine.IsTopInt then
  l_BlockID := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задан номер блока!');
 ArSetContentsSub(l_BlockID);
//#UC END# *4DAEEDE10285_4ECB504D000B_impl*
end;//TkwEditorSetTOC.DoDoIt

initialization
 TkwEditorSetTOC.RegisterInEngine;
 {* Регистрация TkwEditorSetTOC }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
