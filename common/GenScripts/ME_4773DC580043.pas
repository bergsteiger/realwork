unit l3InterfaceList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
;

type
 Tl3InterfaceList = class(_l3InterfaceRefList_)
  {* Список интерфейсов. }
 end;//Tl3InterfaceList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
