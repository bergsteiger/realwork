unit evOperationDispatcherEx;

interface

uses
 l3IntfUses
 , evDisp
;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TevOperationDispatcherEx
 
implementation

uses
 l3ImplUses
;

end.
