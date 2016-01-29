unit m3SimpleDB;

interface

uses
 l3IntfUses
 , m3DB
 , m3DBInterfaces
 , m3StorageInterfaces
;

type
 Tm3SimpleDB = class(Tm3DB)
  function Make(const aBaseName: AnsiString): Im3DB;
 end;//Tm3SimpleDB
 
implementation

uses
 l3ImplUses
 , m3StorageService
;

end.
