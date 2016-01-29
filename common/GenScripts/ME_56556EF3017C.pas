unit pgFreeIDHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , pgTableModifier
 , pgFunction
 , pgConnection
 , pgFunctionFactory
;

type
 TpgFreeIDHelper = class(Tl3ProtoObject)
  procedure Create(aConnection: TpgConnection;
   const aFactory: IdaTableQueryFactory;
   aFunctionFactory: TpgFunctionFactory;
   aFamilyID: TdaFamilyID);
  function KeyPrefix(const aKey: AnsiString): AnsiString;
  function RepairInterval(const aKey: AnsiString): Boolean;
  function GetFreeFromTable(const aKey: AnsiString;
   out theNumber: TdaDocID): Boolean;
  function GetFreeFromReplica(const aKey: AnsiString;
   out theNumber: TdaDocID): Boolean;
  function GetFree(const aKey: AnsiString): TdaDocID;
  function AnyRangesPresent(const aKey: AnsiString): Boolean;
 end;//TpgFreeIDHelper
 
implementation

uses
 l3ImplUses
 , daScheme
 , daSchemeConsts
 , SysUtils
 , pgInterfaces
;

end.
