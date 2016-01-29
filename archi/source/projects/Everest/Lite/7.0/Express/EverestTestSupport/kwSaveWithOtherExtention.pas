unit kwSaveWithOtherExtention;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestTestSupport"
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/kwSaveWithOtherExtention.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::SaveWithOtherExtention
//
// *Формат:*  расширение SaveWithOtherExtention
// *Описание:*  Сохраняет текущий открытый файл в редакторе под тем же именем, но с другим
// расширеним, заданынм через параметр "расширение"
// *Пример:*
// {code}
// '.nsr' SaveWithOtherExtention
// {code}
// *Результат:* Открытый файл в редакторе будет сохранен с расширением nsr (с преобразованием в
// формат NSRC, если нужно).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TkwSaveWithOtherExtention = {final scriptword} class(TtfwRegisterableWord)
  {* *Формат:*  расширение SaveWithOtherExtention
*Описание:*  Сохраняет текущий открытый файл в редакторе под тем же именем, но с другим расширеним, заданынм через параметр "расширение" 
 *Пример:*
 [code]
'.nsr' SaveWithOtherExtention
 [code]
*Результат:* Открытый файл в редакторе будет сохранен с расширением nsr (с преобразованием в формат NSRC, если нужно). }
 protected
 // realized methods
    {$If not defined(NoScripts)}
   procedure DoDoIt(const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//TkwSaveWithOtherExtention
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  EverestLiteAdapter,
  SysUtils
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TkwSaveWithOtherExtention

{$If not defined(NoScripts)}
procedure TkwSaveWithOtherExtention.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512DD336009D_var*
var
 l_FileExt  : String;
 l_FileName : String;
//#UC END# *4DAEEDE10285_512DD336009D_var*
begin
//#UC START# *4DAEEDE10285_512DD336009D_impl*
 if aCtx.rEngine.IsTopString then
 begin
  l_FileExt := aCtx.rEngine.PopDelphiString;
  l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, l_FileExt);
  l_FileName := ExtractFileName(l_FileName);
  l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
  SaveDocumentAs(l_FileName);
 end // if aCtx.rEngine.IsTopString then
 else
  Assert(False, 'Не задано новое расширение!');
//#UC END# *4DAEEDE10285_512DD336009D_impl*
end;//TkwSaveWithOtherExtention.DoDoIt
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwSaveWithOtherExtention.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SaveWithOtherExtention';
end;//TkwSaveWithOtherExtention.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// Регистрация SaveWithOtherExtention
 TkwSaveWithOtherExtention.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest

end.