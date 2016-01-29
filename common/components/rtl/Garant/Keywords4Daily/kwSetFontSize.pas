unit kwSetFontSize;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Keywords4Daily"
// Модуль: "w:/common/components/rtl/Garant/Keywords4Daily/kwSetFontSize.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi Tests::Keywords4Daily::SupportWords::SetFontSize
//
// Устанавливает размер шрифта для стиля "Нормальный".
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwSetFontSize = {final scriptword} class(TtfwRegisterableWord)
  {* Устанавливает размер шрифта для стиля "Нормальный". }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSetFontSize
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  evStyleInterface,
  SysUtils
  ;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwSetFontSize

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

class function TkwSetFontSize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SetFontSize';
end;//TkwSetFontSize.GetWordNameForRegister

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация SetFontSize
 TkwSetFontSize.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.