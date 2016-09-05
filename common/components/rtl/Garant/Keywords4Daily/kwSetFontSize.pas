unit kwSetFontSize;
 {* Устанавливает размер шрифта для стиля "Нормальный". }

// Модуль: "w:\common\components\rtl\Garant\Keywords4Daily\kwSetFontSize.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "SetFontSize" MUID: (509B8C5A0200)
// Имя типа: "TkwSetFontSize"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSetFontSize = {final} class(TtfwRegisterableWord)
  {* Устанавливает размер шрифта для стиля "Нормальный". }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwSetFontSize
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evStyleInterface
 , SysUtils
 //#UC START# *509B8C5A0200impl_uses*
 //#UC END# *509B8C5A0200impl_uses*
;

class function TkwSetFontSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetFontSize';
end;//TkwSetFontSize.GetWordNameForRegister

procedure TkwSetFontSize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_509B8C5A0200_var*
var
 l_Size: Integer;
 l_SI  : TevStyleInterface;
//#UC END# *4DAEEDE10285_509B8C5A0200_var*
begin
//#UC START# *4DAEEDE10285_509B8C5A0200_impl*
 if aCtx.rEngine.IsTopInt then
 begin
  l_Size := aCtx.rEngine.PopInt;
  l_SI := TevStyleInterface.Make;
  l_SI.Font.Size := l_Size;
  FreeAndNil(l_SI);
 end // if aCtx.rEngine.IsTopInt then
 else
  Assert(False, 'Размер шрифта!'); 
//#UC END# *4DAEEDE10285_509B8C5A0200_impl*
end;//TkwSetFontSize.DoDoIt

initialization
 TkwSetFontSize.RegisterInEngine;
 {* Регистрация SetFontSize }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
