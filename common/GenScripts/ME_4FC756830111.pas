unit seModalWorkerList;

interface

uses
 l3IntfUses
 , seModalWorkerListPrim
;

type
 TseModalWorkerList = class(TseModalWorkerListPrim)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TseModalWorkerList
 
implementation

uses
 l3ImplUses
;

end.
