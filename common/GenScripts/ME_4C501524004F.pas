unit K228692538;

interface

uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 TK228692538 = class(TInsertStreamTest)
  {* [RequestLink:228692538] }
  function TextForInsert: AnsiString;
   {* ����� ��� ������� }
  procedure Navigate(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
   {* ������������� ������ ��� ��������� }
 end;//TK228692538
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
