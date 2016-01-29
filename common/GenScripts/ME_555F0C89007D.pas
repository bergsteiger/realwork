unit htDataSchemeHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , htInterfaces
 , htDataProviderParams
 , daTypes
;

type
 ThtDataSchemeHelper = class(Tl3ProtoObject, IhtDataSchemeHelper)
  procedure Create(aParams: ThtDataProviderParams);
  function Make(aParams: ThtDataProviderParams): IhtDataSchemeHelper;
  function TableFullPath(aTable: TdaTables): AnsiString;
  function TablePassword(aTable: TdaTables): AnsiString;
  function TableFamily(aTable: TdaTables): TdaFamilyID;
 end;//ThtDataSchemeHelper
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3FileUtils
;

end.
