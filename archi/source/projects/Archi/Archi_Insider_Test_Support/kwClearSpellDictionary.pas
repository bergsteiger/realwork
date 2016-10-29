unit kwClearSpellDictionary;
 {* Очищает пользовательский словарь проверки орфографии. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearSpellDictionary.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ClearSpellDictionary" MUID: (581338320377)
// Имя типа: "TkwClearSpellDictionary"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearSpellDictionary = {final} class(TtfwRegisterableWord)
  {* Очищает пользовательский словарь проверки орфографии. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearSpellDictionary
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 //#UC START# *581338320377impl_uses*
 //#UC END# *581338320377impl_uses*
;

class function TkwClearSpellDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearSpellDictionary';
end;//TkwClearSpellDictionary.GetWordNameForRegister

procedure TkwClearSpellDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_581338320377_var*
//#UC END# *4DAEEDE10285_581338320377_var*
begin
//#UC START# *4DAEEDE10285_581338320377_impl*
 arClearSpellDictionary;
//#UC END# *4DAEEDE10285_581338320377_impl*
end;//TkwClearSpellDictionary.DoDoIt

initialization
 TkwClearSpellDictionary.RegisterInEngine;
 {* Регистрация ClearSpellDictionary }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
