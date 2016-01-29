unit vcmGlassForm;

interface

uses
 l3IntfUses
 , vcmEntityForm
;

type
 TvcmGlassForm = class(TvcmEntityForm)
 end;//TvcmGlassForm
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , Types
 , vcmGlassFrame
 , l3DwmApi
 , Windows
 , l3Base
 , Controls
 , SysUtils
 , Messages
;

end.
