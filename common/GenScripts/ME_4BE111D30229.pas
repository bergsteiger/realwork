unit TextViaEditorProcessor;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TTextViaEditorProcessor = class(TTextEditorVisitor)
  {* Обработчик текста через редактор }
  function EtalonFileExtension: AnsiString;
   {* Расширение эталонного файла }
  function HeaderBegin: AnsiChar;
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TTextViaEditorProcessor
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
