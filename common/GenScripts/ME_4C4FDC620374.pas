unit InsertStreamTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 TInsertStreamTest = class(TTextViaEditorProcessorWithNavigate)
  {* Тест вставки в редактор текста при помощи InsertStream }
  function TextForInsert: AnsiString;
   {* Текст для вставки }
  procedure DoProcess(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
 end;//TInsertStreamTest
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3Memory
 , SysUtils
 , TestFrameWork
;

end.
