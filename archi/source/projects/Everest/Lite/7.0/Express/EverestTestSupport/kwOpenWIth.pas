unit kwOpenWith;
 {* *Формат:*  OpenWith aFileName
*Описание:* Отрывает документ с именем aFileName в новом окне редактора.
 *Пример:*
 [code]
OpenWith 'MyEvd.doc'
 [code]
 *Результат:* Будет открыт новый документ с именем файла 'MyEvd.doc' }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwOpenWith.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "OpenWith" MUID: (5143073402A1)
// Имя типа: "TkwOpenWith"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpenWith = {final} class(TtfwRegisterableWord)
  {* *Формат:*  OpenWith aFileName
*Описание:* Отрывает документ с именем aFileName в новом окне редактора.
 *Пример:*
 [code]
OpenWith 'MyEvd.doc'
 [code]
 *Результат:* Будет открыт новый документ с именем файла 'MyEvd.doc' }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpenWith
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
 , SysUtils
;

class function TkwOpenWith.GetWordNameForRegister: AnsiString;
begin
 Result := 'OpenWith';
end;//TkwOpenWith.GetWordNameForRegister

procedure TkwOpenWith.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5143073402A1_var*
var
 l_FileName: String;
//#UC END# *4DAEEDE10285_5143073402A1_var*
begin
//#UC START# *4DAEEDE10285_5143073402A1_impl*
 if aCtx.rEngine.IsTopString then
 begin
  l_FileName := aCtx.rEngine.PopDelphiString;
  l_FileName := ExtractFileName(l_FileName);
  l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
  Assert(FileExists(l_FileName), Format('Файл не существует: %s', [l_FileName]));
  OpenDocument(l_FileName);
 end // if aCtx.rEngine.IsTopString then
 else
  Assert(False, 'Не задано имя файла для открытия!');
//#UC END# *4DAEEDE10285_5143073402A1_impl*
end;//TkwOpenWith.DoDoIt

initialization
 TkwOpenWith.RegisterInEngine;
 {* Регистрация OpenWith }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
