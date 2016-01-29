unit nevViewList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevViewList = class(_l3InterfaceRefList_)
  {* Список InevView. }
 end;//TnevViewList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
