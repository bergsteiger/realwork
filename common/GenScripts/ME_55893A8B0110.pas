unit ddExceptionHandler;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ExceptionHandler
;

type
 TddExceptionHandler = class(Tl3ProtoObject, Il3ExceptionHandler)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure HandleException(Sender: TObject);
 end;//TddExceptionHandler
 
implementation

uses
 l3ImplUses
 , Forms
;

end.
