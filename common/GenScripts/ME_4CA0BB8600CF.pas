unit KBridge;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , orb_int
 , SecuritySrv_int
 , CosNaming_int
 , Contents_int
 , l3Filer
;

type
 TKBridge = class(Tl3ProtoObject)
  {* Мост к К }
  procedure Logout;
  function Exists: Boolean;
  procedure AttachFile(aPage: Integer;
   const aFile: AnsiString);
 end;//TKBridge
 
implementation

uses
 l3ImplUses
 , GarORBInitializerImpl
 , Classes
 , CosNaming
 , SysUtils
 , orb
 , SecuritySrv
 , GarClientSecurity
 , Contents
 , tfwKConst
 , l3FileUtils
 , l3Types
;

end.
