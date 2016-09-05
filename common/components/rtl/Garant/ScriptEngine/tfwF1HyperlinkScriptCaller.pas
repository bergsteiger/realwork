unit tfwF1HyperlinkScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwF1HyperlinkScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwF1HyperlinkScriptCaller" MUID: (55D34A9B0067)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwHyperlinkScriptCaller
;

type
 TtfwF1HyperlinkScriptCaller = class(TtfwHyperlinkScriptCaller)
  public
   class function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString; override;
 end;//TtfwF1HyperlinkScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 //#UC START# *55D34A9B0067impl_uses*
 //#UC END# *55D34A9B0067impl_uses*
;

type
 TtfwF1HyperlinkScriptCallerResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TtfwF1HyperlinkScriptCallerResNameGetter

class function TtfwF1HyperlinkScriptCallerResNameGetter.ResName: AnsiString;
begin
 Result := 'tfwF1HyperlinkScriptCaller';
end;//TtfwF1HyperlinkScriptCallerResNameGetter.ResName

{$R tfwF1HyperlinkScriptCaller.res}

class function TtfwF1HyperlinkScriptCaller.DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *55D34AD90105_55D34A9B0067_var*
//#UC END# *55D34AD90105_55D34A9B0067_var*
begin
//#UC START# *55D34AD90105_55D34A9B0067_impl*
 Result := inherited DoResolveIncludedFilePath(aFile);
//#UC END# *55D34AD90105_55D34A9B0067_impl*
end;//TtfwF1HyperlinkScriptCaller.DoResolveIncludedFilePath

initialization
 TtfwF1HyperlinkScriptCallerResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
{$IfEnd} // NOT Defined(NoScripts)

end.
