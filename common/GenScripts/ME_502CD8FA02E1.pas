unit tb97GraphicControl;

interface

uses
 l3IntfUses
 , Controls
;

type
 Ttb97CustomGraphicControl = class(TGraphicControl)
 end;//Ttb97CustomGraphicControl
 
 Ttb97GraphicTextControl = class(Ttb97GraphicControl)
 end;//Ttb97GraphicTextControl
 
 Ttb97GraphicControl = class(Ttb97CustomGraphicControl)
 end;//Ttb97GraphicControl
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
