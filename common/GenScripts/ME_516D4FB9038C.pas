unit myInterfacedObjectTest;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TmyInterfacedObjectTest = class(TTestCase)
  procedure DoIt;
 end;//TmyInterfacedObjectTest
 
implementation

uses
 l3ImplUses
 , myInterfacedObject
 , SysUtils
;

end.
