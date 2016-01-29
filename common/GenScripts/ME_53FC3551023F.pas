unit kwTestResolveInputFilePath;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwTestResolveInputFilePath = class(TtfwRegisterableWord)
  {* *Описание:* добавляет к имени файла путь к директории TestSet, где хранятся исходные файлы.
*Формат*
[code]
aFileName test:ResolveInputFilePath
[code]
где aFileName - имя файля без пути (!).
Результат помещается в стек. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTestResolveInputFilePath
 
implementation

uses
 l3ImplUses
;

end.
