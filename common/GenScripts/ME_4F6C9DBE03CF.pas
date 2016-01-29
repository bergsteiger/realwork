unit afwSettingsImplPersistent;

interface

uses
 l3IntfUses
 , afwSettingsImpl
;

type
 TafwSettingsImplPersistent = class(TafwSettingsImpl)
  procedure Load;
  procedure Save;
  function FileName: AnsiString;
 end;//TafwSettingsImplPersistent
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Filer
 , l3Types
 , l3Base
 , l3String
 , l3InterfacedString
 , l3Interfaces
 , afwSettingsImplPrimPrim
;

end.
