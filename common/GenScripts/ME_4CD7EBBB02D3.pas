unit InsertBreakInTextTableTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 TInsertBreakInTextTableTest = class(TTextViaEditorProcessorWithNavigate)
  {* Вставка текста в моноширинную таблицу в режиме рисования текста. }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* Устанавливает курсор или выделение }
  procedure DoProcess(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
 end;//TInsertBreakInTextTableTest
 
implementation

uses
 l3ImplUses
 , nevBase
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
