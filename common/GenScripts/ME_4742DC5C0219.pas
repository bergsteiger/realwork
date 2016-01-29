unit m3BaseObject;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3DBInterfaces
 , m3PrimDB
;

type
 Tm3BaseObject = class(Tl3CProtoObject, Im3DBObject)
  {* Базовая реализация объекта хранилища. }
  procedure Create(aDB: Tm3PrimDB);
  function DB: Im3DB;
 end;//Tm3BaseObject
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
