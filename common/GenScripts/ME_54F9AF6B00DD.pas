unit htDataProviderParams;

interface

uses
 l3IntfUses
 , daDataProviderParams
 , HyTechProviderParams_Const
 , dt_Types
 , k2Base
;

type
 ThtDataProviderParams = class(TdaDataProviderParams)
  function MakePathRec: TPathRec;
 end;//ThtDataProviderParams
 
implementation

uses
 l3ImplUses
 , l3FileUtils
 , ddUtils
 , SysUtils
;

end.
