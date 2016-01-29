unit kwPopEditorPasteRTF;

interface

uses
 l3IntfUses
 , kwInsertFromStreamCommon
 , tfwScriptingInterfaces
;

type
 TkwPopEditorPasteRTF = class(TkwInsertFromStreamCommon)
  {* *Формат:* rtf_file_name anEditorControl pop:editor:PasteRTF
*Описание:* Эмулирует вставку из буфера обмена данных из внешних приложений, например, текст в формате RTF из файла rtf_file_name.
*Пример:*
[code] 
Test.rtf  focused:control:push pop:editor:PasteRTF
[code] }
  function GetFormat(const aCtx: TtfwContext): Integer;
 end;//TkwPopEditorPasteRTF
 
implementation

uses
 l3ImplUses
 , evTypes
 , Windows
;

end.
