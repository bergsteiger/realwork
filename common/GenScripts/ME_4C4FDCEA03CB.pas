unit K228691360;

interface

uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TK228691360 = class(TInsertStreamTest)
  {* [RequestLink:228691360] }
  function TextForInsert: AnsiString;
   {* Текст для вставки }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* Устанавливает курсор или выделение }
 end;//TK228691360
 
implementation

uses
 l3ImplUses
 , evMsgCode
 , evOp
 , TestFrameWork
;

end.
