unit k2InterfacedTagList;

interface

uses
 l3IntfUses
 , k2SimpleTagList
 , k2InterfacesEx
;

type
 Tk2InterfacedTagList = class(_l3InterfacedList_, Ik2TagList)
  procedure MakeI;
 end;//Tk2InterfacedTagList
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
