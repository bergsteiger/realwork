unit l3SimpleNodeList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3TreeInterfaces
;

type
 Tl3SimpleNodeList = class(_l3InterfaceRefList_)
 end;//Tl3SimpleNodeList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
