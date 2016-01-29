unit InsertStreamTestWithImplementedNavigate;

interface

uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TInsertStreamTestWithImplementedNavigate = class(TInsertStreamTest)
  {* То же что и TInsertStreamTest, но с пустым Navigate }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* Устанавливает курсор или выделение }
 end;//TInsertStreamTestWithImplementedNavigate
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
