unit l3InterfacePtrList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
;

type
 Tl3InterfacePtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на интерфейсы. Не владеет ими. }
 end;//Tl3InterfacePtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
