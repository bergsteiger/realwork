unit csTaskChangeHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 McsTaskChangeHelper = interface
  {* �������� ������� TcsTaskChangeHelper }
  procedure TaskGotErrorStatus;
 end;//McsTaskChangeHelper
 *)
 
type
 IcsTaskChangeHelper = interface
  {* ��������� ������� TcsTaskChangeHelper }
  procedure TaskGotErrorStatus;
 end;//IcsTaskChangeHelper
 
 TcsTaskChangeHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure TaskGotErrorStatus;
 end;//TcsTaskChangeHelper
 
implementation

uses
 l3ImplUses
;

end.
