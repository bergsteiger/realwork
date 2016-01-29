unit l3InterfacedList.imp;

interface

uses
 l3IntfUses
 , l3PureMixIns
;

type
 _l3InterfacedList_ = class(_l3ListAssign_, _ListType_)
  procedure MakeI;
  function Count: Integer;
   {* Число элементов. }
 end;//_l3InterfacedList_
 
implementation

uses
 l3ImplUses
;

end.
