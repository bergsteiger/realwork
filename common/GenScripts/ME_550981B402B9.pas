unit htInterfaces;

interface

uses
 l3IntfUses
 , daInterfaces
 , ddAppConfig
 , daTypes
 , HT_Const
 , l3Date
;

type
 IhtParamsStorage = interface(IdaParamsStorage)
  function StationErrorMessage: AnsiString;
  function TablePathErrorMessage: AnsiString;
  function LockPathErrorMessage: AnsiString;
 end;//IhtParamsStorage
 
 IhtDataSchemeHelper = interface
  function TableFullPath(aTable: TdaTables): AnsiString;
  function TablePassword(aTable: TdaTables): AnsiString;
  function TableFamily(aTable: TdaTables): TdaFamilyID;
 end;//IhtDataSchemeHelper
 
 IhtFromTable = interface(IdaFromTable)
  procedure Prepare(const aHelper: IhtDataSchemeHelper;
   RequireNewHandle: Boolean);
  procedure Unprepare(const aHelper: IhtDataSchemeHelper);
 end;//IhtFromTable
 
 IhtDataConverter = interface(IdaDataConverter)
  function ToLargeInt(aData: Pointer;
   const aDesc: OPEL): LargeInt;
  function ToInteger(aData: Pointer;
   const aDesc: OPEL): Integer;
  function ToStDate(aData: Pointer;
   const aDesc: OPEL): TStDate;
  function ToStTime(aData: Pointer;
   const aDesc: OPEL): TStTime;
  function ToString(aData: Pointer;
   const aDesc: OPEL): AnsiString;
  function ToByte(aData: Pointer;
   const aDesc: OPEL): Byte;
 end;//IhtDataConverter
 
 ThtSubItemDescriptionArray = array of OPEL;
 
implementation

uses
 l3ImplUses
;

end.
