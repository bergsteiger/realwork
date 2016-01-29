unit k2SimpleTagList;

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2TagList
;

 {$Define l3Items_NoSort}
 
type
 Tk2SimpleTagList = class(_k2SimpleTagListPrim_)
  procedure JoinWith(anOther: Tk2TagList); overload;
 end;//Tk2SimpleTagList
 
implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
