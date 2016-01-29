unit l3ExceptionHandler;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3ExceptionHandler = interface
  {* �������� ������� Tl3ExceptionHandler }
  procedure HandleException(Sender: TObject);
 end;//Ml3ExceptionHandler
 *)
 
type
 Il3ExceptionHandler = interface
  {* ��������� ������� Tl3ExceptionHandler }
  procedure HandleException(Sender: TObject);
 end;//Il3ExceptionHandler
 
 Tl3ExceptionHandler = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure HandleException(Sender: TObject);
 end;//Tl3ExceptionHandler
 
implementation

uses
 l3ImplUses
;

end.
