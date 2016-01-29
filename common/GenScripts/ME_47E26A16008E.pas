unit nevRangeList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevRangeList = class(_l3InterfaceRefList_)
  {* Список выделенных элементов документа. }
  function Clone: TnevRangeList;
 end;//TnevRangeList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
