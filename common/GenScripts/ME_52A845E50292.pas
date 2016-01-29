unit vcmWinControlActionLink;

interface

uses
 l3IntfUses
 , Controls
 , vcmExternalInterfaces
;

 {$Define _UnknownNeedsQI}
 
type
 TvcmWinControlActionLink = class(TWinControlActionLink, IvcmActionLink)
  procedure DoParamsChanged(const anAction: IvcmAction);
  procedure DoParamsChanging(const anAction: IvcmAction);
  procedure ParamsChanged(const anAction: IvcmAction);
  procedure ParamsChanging(const anAction: IvcmAction);
 end;//TvcmWinControlActionLink
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , Graphics
;

type
 THackControl = class(TControl)
 end;//THackControl
 
end.
