unit evCustomTxtReader;

interface

uses
 l3IntfUses
 , k2CustomFileReader
 , l3Base
;

type
 TevCustomTxtReader = class(Tk2CustomFileReader)
  procedure DoText(aText: Tl3String);
  function NeedOpenDefaultChild(aText: Tl3String): Boolean;
 end;//TevCustomTxtReader
 
implementation

uses
 l3ImplUses
;

end.
