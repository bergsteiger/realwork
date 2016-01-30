unit nsExternalObjectModelPart;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsExternalObjectModelPart.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , ActiveX
 , l3Interfaces
;

type
 TnsGetGenOutputStruct = record
  rStream: IStream;
  rName: Il3CString;
 end;//TnsGetGenOutputStruct

function TnsGetGenOutputStruct_Create(const aStream: IStream): TnsGetGenOutputStruct; overload;
function TnsGetGenOutputStruct_Create(const aName: Il3CString): TnsGetGenOutputStruct; overload;

implementation

uses
 l3ImplUses
;

function TnsGetGenOutputStruct_Create(const aStream: IStream): TnsGetGenOutputStruct;
//#UC START# *512CD7E60330_512CD73E01E6_var*
//#UC END# *512CD7E60330_512CD73E01E6_var*
begin
//#UC START# *512CD7E60330_512CD73E01E6_impl*
 Result.rStream := aStream;
//#UC END# *512CD7E60330_512CD73E01E6_impl*
end;//TnsGetGenOutputStruct_Create

function TnsGetGenOutputStruct_Create(const aName: Il3CString): TnsGetGenOutputStruct;
//#UC START# *512CD80201BC_512CD73E01E6_var*
//#UC END# *512CD80201BC_512CD73E01E6_var*
begin
//#UC START# *512CD80201BC_512CD73E01E6_impl*
 Result.rName := aName;
//#UC END# *512CD80201BC_512CD73E01E6_impl*
end;//TnsGetGenOutputStruct_Create

end.
