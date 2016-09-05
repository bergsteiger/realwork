unit kwSetExpiredStyle;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSetExpiredStyle.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwSetExpiredStyle" MUID: (4F22AFC0008A)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSetExpiredStyle = class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwSetExpiredStyle
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 //#UC START# *4F22AFC0008Aimpl_uses*
 //#UC END# *4F22AFC0008Aimpl_uses*
;

class function TkwSetExpiredStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'окно_редактора:SetExpiredStyle';
end;//TkwSetExpiredStyle.GetWordNameForRegister

procedure TkwSetExpiredStyle.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F22AFC0008A_var*
//#UC END# *4DAEEDE10285_4F22AFC0008A_var*
begin
//#UC START# *4DAEEDE10285_4F22AFC0008A_impl*
 if aCtx.rEngine.IsTopInt then
  aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задано значение StyleID');
//#UC END# *4DAEEDE10285_4F22AFC0008A_impl*
end;//TkwSetExpiredStyle.DoDoIt

initialization
 TkwSetExpiredStyle.RegisterInEngine;
 {* Регистрация TkwSetExpiredStyle }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
