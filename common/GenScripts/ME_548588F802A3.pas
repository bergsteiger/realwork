unit m3BaseEnumStatStg;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , ActiveX
;

type
 Tm3BaseEnumStatStg = class(Tl3CProtoObject, IEnumStatStg)
  {* Базовый класс для реализации IEnumStatStg }
 end;//Tm3BaseEnumStatStg
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , ComObj
 , l3Base
 , m2MemLib
;

end.
