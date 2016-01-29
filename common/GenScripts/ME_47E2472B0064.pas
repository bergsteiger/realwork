unit l3NodeList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Tree_TLB
;

type
 Tl3NodeList = class(_l3InterfaceRefList_)
  {* Список узлов дерева. }
 end;//Tl3NodeList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
