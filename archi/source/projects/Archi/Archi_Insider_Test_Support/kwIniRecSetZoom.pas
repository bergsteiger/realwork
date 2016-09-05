unit kwIniRecSetZoom;
 {* IniRec:SetZoom }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwIniRecSetZoom.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwIniRecSetZoom" MUID: (4E83072D01FF)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwIniRecSetZoom = class(TtfwRegisterableWord)
  {* IniRec:SetZoom }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwIniRecSetZoom
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 //#UC START# *4E83072D01FFimpl_uses*
 //#UC END# *4E83072D01FFimpl_uses*
;

class function TkwIniRecSetZoom.GetWordNameForRegister: AnsiString;
begin
 Result := 'IniRec:SetZoom';
end;//TkwIniRecSetZoom.GetWordNameForRegister

procedure TkwIniRecSetZoom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E83072D01FF_var*
//#UC END# *4DAEEDE10285_4E83072D01FF_var*
begin
//#UC START# *4DAEEDE10285_4E83072D01FF_impl*
 if aCtx.rEngine.IsTopInt then
  ArIniRecSetZoom(aCtx.rEngine.PopInt)
 else
  Assert(False, 'Значение Zoom должно быть в виде числа!');
//#UC END# *4DAEEDE10285_4E83072D01FF_impl*
end;//TkwIniRecSetZoom.DoDoIt

initialization
 TkwIniRecSetZoom.RegisterInEngine;
 {* Регистрация TkwIniRecSetZoom }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
