unit k2Except;

interface

uses
 l3IntfUses
 , l3Except
;

type
 Ek2Error = class(El3Error)
 end;//Ek2Error
 
 Ek2Warning = class(El3Warning)
 end;//Ek2Warning
 
 Ek2NotFound = class(El3NotFound)
 end;//Ek2NotFound
 
 Ek2CannotDefine = class(Ek2Error)
 end;//Ek2CannotDefine
 
 Ek2TypeAlreadyDefined = class(Ek2CannotDefine)
 end;//Ek2TypeAlreadyDefined
 
 Ek2PropertyAlreadyDefined = class(Ek2CannotDefine)
 end;//Ek2PropertyAlreadyDefined
 
 Ek2CannotDefineType = class(Ek2CannotDefine)
 end;//Ek2CannotDefineType
 
 Ek2ConversionError = class(Ek2Error)
 end;//Ek2ConversionError
 
 Ek2CannotAddChild = class(El3Exception)
 end;//Ek2CannotAddChild
 
 Ek2InvalidChildType = class(Ek2CannotAddChild)
 end;//Ek2InvalidChildType
 
 Ek2ReadOnlyProperty = class(Ek2Warning)
 end;//Ek2ReadOnlyProperty
 
 Ek2ReadOnly = class(Ek2Warning)
 end;//Ek2ReadOnly
 
 Ek2LimitReached = class(Ek2Warning)
 end;//Ek2LimitReached
 
implementation

uses
 l3ImplUses
;

end.
