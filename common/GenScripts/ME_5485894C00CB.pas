unit m3TempEnumStatStg;

interface

uses
 l3IntfUses
 , m3BaseEnumStatStg
 , ActiveX
;

type
 Tm3TempEnumStatStg = class(Tm3BaseEnumStatStg)
  procedure Create(const aStream: IStream;
   aCount: Integer);
  function Make(const aStream: IStream;
   aCount: Integer): IEnumStatStg;
 end;//Tm3TempEnumStatStg
 
implementation

uses
 l3ImplUses
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , ComObj
;

end.
