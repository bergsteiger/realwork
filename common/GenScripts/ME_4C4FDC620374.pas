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
  {* ���� ������� � �������� ������ ��� ������ InsertStream }
  function TextForInsert: AnsiString;
   {* ����� ��� ������� }
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
