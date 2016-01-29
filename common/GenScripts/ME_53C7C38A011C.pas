unit kwRegisterSchema;

interface

uses
 l3IntfUses
;

type
 TkwRegisterSchema = class
  procedure RegisterSchema(aSender: TObject);
 end;//TkwRegisterSchema
 
implementation

uses
 l3ImplUses
 , k2Facade
 , k2Tags
 , evStyleInterface
 , tfwIntegerConstantRegistrator
 , k2Attributes
 , l3Base
 , k2Base
 , SysUtils
 , l3Variant
 , evdStyles
 , tfwEnumRegistrator
 , TypInfo
 , evdTypes
 , tfwClassRef
;

end.
