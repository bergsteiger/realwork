unit kwLoadFromFile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Keywords4Daily"
// Модуль: "w:/common/components/rtl/Garant/Keywords4Daily/kwLoadFromFile.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi Tests::Keywords4Daily::SupportWords::LoadFromFile
//
// Загружает файл в форму дочернего класса TPrimTextLoadForm.
// *Формат:* имя_файла LoadFromFile
// *Примечание:* Создан специально для тестов DailyTests в результате переделок form:Needs. Имя
// файла можно подавать без пути - будет автоматически добавлен путь к данным для тестов.
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
 _LoadUnits_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\Daily\LoadUnits.imp.pas}
 TkwLoadFromFile = {final scriptword} class(_LoadUnits_)
  {* Загружает файл в форму дочернего класса TPrimTextLoadForm. 
*Формат:* имя_файла LoadFromFile
*Примечание:* Создан специально для тестов DailyTests в результате переделок form:Needs. Имя файла можно подавать без пути - будет автоматически добавлен путь к данным для тестов. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwLoadFromFile
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  PrimTextLoad_Form,
  Document_Const
  ;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

{$Include w:\common\components\gui\Garant\Daily\LoadUnits.imp.pas}

// start class TkwLoadFromFile

procedure TkwLoadFromFile.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_509A5CCB022A_var*
var
 l_Form     : TObject;
 l_FileName : String;
//#UC END# *4DAEEDE10285_509A5CCB022A_var*
begin
//#UC START# *4DAEEDE10285_509A5CCB022A_impl*
 if aCtx.rEngine.IsTopObj then
 begin
  l_Form := aCtx.rEngine.PopObj;
  if aCtx.rEngine.IsTopString then
  begin
   l_FileName := aCtx.rEngine.PopDelphiString;
   l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
   with (l_Form as TPrimTextLoadForm) do
   begin
    LoadManager.FileName := l_FileName;
    LoadManager.Load(TextSource, k2_typDocument);
    AfterLoad;
   end // with (aForm as TPrimTextLoadForm) do
  end
  else
   Assert(False, 'Не задано название файла!');
 end // if aCtx.rEngine.IsTopObj then
 else
  Assert(False, 'Не задана форма для загрузки текста!');
//#UC END# *4DAEEDE10285_509A5CCB022A_impl*
end;//TkwLoadFromFile.DoDoIt

class function TkwLoadFromFile.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'LoadFromFile';
end;//TkwLoadFromFile.GetWordNameForRegister

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация LoadFromFile
 TkwLoadFromFile.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.