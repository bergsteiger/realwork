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
  {* �� �� ��� � TInsertStreamTest, �� � ������ Navigate }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* ������������� ������ ��� ��������� }
 end;//TInsertStreamTestWithImplementedNavigate
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
