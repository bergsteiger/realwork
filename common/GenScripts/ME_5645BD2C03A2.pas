unit pgFamilyHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TpgFamilyHelper = class(Tl3ProtoObject)
  procedure Create(const aFactory: IdaTableQueryFactory);
  function FamilyPath(aFamily: TdaFamilyID): AnsiString;
 end;//TpgFamilyHelper
 
implementation

uses
 l3ImplUses
 , daScheme
 , SysUtils
;

end.
