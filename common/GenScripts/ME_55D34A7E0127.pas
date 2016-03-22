unit tfwArchiHyperlinkScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwArchiHyperlinkScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwArchiHyperlinkScriptCaller" MUID: (55D34A7E0127)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwHyperlinkScriptCaller
;

type
 TtfwArchiHyperlinkScriptCaller = class(TtfwHyperlinkScriptCaller)
  public
   class function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString; override;
 end;//TtfwArchiHyperlinkScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
;

type
 //#UC START# *2601B8C0800Aci*
 //#UC END# *2601B8C0800Aci*
 //#UC START# *2601B8C0800Acit*
 //#UC END# *2601B8C0800Acit*
 TtfwArchiHyperlinkScriptCallerResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *2601B8C0800Apubl*
 //#UC END# *2601B8C0800Apubl*
 end;//TtfwArchiHyperlinkScriptCallerResNameGetter

class function TtfwArchiHyperlinkScriptCallerResNameGetter.ResName: AnsiString;
begin
  Result := 'tfwArchiHyperlinkScriptCaller';
end;//TtfwArchiHyperlinkScriptCallerResNameGetter.ResName

 {$R tfwArchiHyperlinkScriptCaller.res}

class function TtfwArchiHyperlinkScriptCaller.DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *55D34AD90105_55D34A7E0127_var*
//#UC END# *55D34AD90105_55D34A7E0127_var*
begin
//#UC START# *55D34AD90105_55D34A7E0127_impl*
 Result := inherited DoResolveIncludedFilePath(aFile);
//#UC END# *55D34AD90105_55D34A7E0127_impl*
end;//TtfwArchiHyperlinkScriptCaller.DoResolveIncludedFilePath

initialization
 TtfwArchiHyperlinkScriptCallerResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
{$IfEnd} // NOT Defined(NoScripts)

end.
