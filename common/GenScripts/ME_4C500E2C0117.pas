unit K228692531;

interface

uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TK228692531 = class(TInsertStreamTest)
  {* [RequestLink:228692531] }
  function TextForInsert: AnsiString;
   {* Текст для вставки }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* Устанавливает курсор или выделение }
 end;//TK228692531
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
