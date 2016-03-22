unit kwSaveWithOtherExtention;
 {* *Формат:*  расширение SaveWithOtherExtention
*Описание:*  Сохраняет текущий открытый файл в редакторе под тем же именем, но с другим расширеним, заданынм через параметр "расширение" 
 *Пример:*
 [code]
'.nsr' SaveWithOtherExtention
 [code]
*Результат:* Открытый файл в редакторе будет сохранен с расширением nsr (с преобразованием в формат NSRC, если нужно). }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwSaveWithOtherExtention.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "SaveWithOtherExtention" MUID: (512DD336009D)
// Имя типа: "TkwSaveWithOtherExtention"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSaveWithOtherExtention = {final} class(TtfwRegisterableWord)
  {* *Формат:*  расширение SaveWithOtherExtention
*Описание:*  Сохраняет текущий открытый файл в редакторе под тем же именем, но с другим расширеним, заданынм через параметр "расширение" 
 *Пример:*
 [code]
'.nsr' SaveWithOtherExtention
 [code]
*Результат:* Открытый файл в редакторе будет сохранен с расширением nsr (с преобразованием в формат NSRC, если нужно). }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSaveWithOtherExtention
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
 , SysUtils
;

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

class function TkwSaveWithOtherExtention.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveWithOtherExtention';
end;//TkwSaveWithOtherExtention.GetWordNameForRegister

initialization
 TkwSaveWithOtherExtention.RegisterInEngine;
 {* Регистрация SaveWithOtherExtention }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
