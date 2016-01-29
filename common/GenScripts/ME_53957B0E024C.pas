unit kwPopEditorPasteEVDTroughClipboard;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorPasteEVDTroughClipboard = class(TkwEditorFromStackWord)
  {* Описание: загружает EVD'файл в виде текста в буфер обмена, а потом вставляет в редактор.
Формат: 
[code]
anEditor aFileName pop:editor:PasteEVDTroughClipboard
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorPasteEVDTroughClipboard
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Memory
 , l3Stream
 , l3Base
 , evTypes
 , Windows
;

end.
