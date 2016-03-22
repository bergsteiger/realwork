unit kwGotoSub;
 {* окно_редактора:перейти_к_метке }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwGotoSub.pas"
// —тереотип: "ScriptKeyword"
// Ёлемент модели: "TkwGotoSub" MUID: (4EEF07E80201)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwGotoSub = class(TtfwRegisterableWord)
  {* окно_редактора:перейти_к_метке }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGotoSub
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

procedure TkwGotoSub.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EEF07E80201_var*
var
 l_Index: Integer;
//#UC END# *4DAEEDE10285_4EEF07E80201_var*
begin
//#UC START# *4DAEEDE10285_4EEF07E80201_impl*
 if aCtx.rEngine.IsTopInt then
  l_Index := aCtx.rEngine.PopInt
 else
  Assert(False, 'Ќе задан номер метки!');
 ArGotoSub(l_Index);
//#UC END# *4DAEEDE10285_4EEF07E80201_impl*
end;//TkwGotoSub.DoDoIt

class function TkwGotoSub.GetWordNameForRegister: AnsiString;
begin
 Result := 'окно_редактора:перейти_к_метке';
end;//TkwGotoSub.GetWordNameForRegister

initialization
 TkwGotoSub.RegisterInEngine;
 {* –егистраци€ TkwGotoSub }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
