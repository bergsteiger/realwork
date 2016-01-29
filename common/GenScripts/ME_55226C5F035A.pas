unit l3GetCaptureHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

 (*
 Ml3GetCaptureHelper = interface
  {* Контракт сервиса Tl3GetCaptureHelper }
  function GetCapture: TComponent;
 end;//Ml3GetCaptureHelper
 *)
 
type
 Il3GetCaptureHelper = interface
  {* Интерфейс сервиса Tl3GetCaptureHelper }
  function GetCapture: TComponent;
 end;//Il3GetCaptureHelper
 
 Tl3GetCaptureHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetCapture: TComponent;
 end;//Tl3GetCaptureHelper
 
implementation

uses
 l3ImplUses
 , Controls
;

end.
