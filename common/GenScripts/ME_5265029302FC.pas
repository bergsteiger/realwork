unit kwPopEditorInsertStream;

interface

uses
 l3IntfUses
 , kwInsertFromStreamCommon
 , tfwScriptingInterfaces
;

type
 TkwPopEditorInsertStream = class(TkwInsertFromStreamCommon)
  {* *Формат:* aFromat file_name anEditorControl pop:editor:InsertStream
*Описание:* Эмулирует вставку из буфера обмена данных из внешних приложений, например, текст в формате aFromat  из файла file_name.
*Пример:*
[code] 
Test.rtf CF_RTF  focused:control:push pop:editor:InsertStream
[code] }
  function GetFormat(const aCtx: TtfwContext): Integer;
 end;//TkwPopEditorInsertStream
 
implementation

uses
 l3ImplUses
;

end.
