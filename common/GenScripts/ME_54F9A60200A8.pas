unit daDataProviderParams;

interface

uses
 l3IntfUses
 , l3Variant
 , DataProviderParams_Const
 , daTypes
 , Classes
 , l3IniFile
 , k2Base
;

type
 TdaDataProviderParamsClass = class of TdaDataProviderParams;
 
 TdaDataProviderParams = class(Tl3Tag)
  procedure CorrectAfterSet;
  procedure ChangeBasePath(const aPath: AnsiString);
  procedure AssignParams(aParams: TdaDataProviderParams);
  function MakeBaseIni: TCfgList;
  function ParamsKey: AnsiString;
  function GetTaggedDataType: Tk2Type;
 end;//TdaDataProviderParams
 
implementation

uses
 l3ImplUses
 , l3FileUtils
 , daUtils
 , SysUtils
;

end.
