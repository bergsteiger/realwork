unit K228692711;

interface

uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TK228692711 = class(TInsertStreamTest)
  {* [RequestLink:228692711] }
  function TextForInsert: AnsiString;
   {* ����� ��� ������� }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* ������������� ������ ��� ��������� }
 end;//TK228692711
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
