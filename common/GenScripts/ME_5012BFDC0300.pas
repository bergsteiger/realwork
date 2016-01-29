unit l3RTTI;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 TRTTIInfoObjectPropertyFoundCallBack = procedure(anObject: TObject;
  var aValue: AnsiString) of object;
 
 ERTTIInfoSkipProperty = class(Exception)
 end;//ERTTIInfoSkipProperty
 
implementation

uses
 l3ImplUses
 , TypInfo
 , l3StringList
 , l3Base
 , Controls
 , Graphics
;

end.
