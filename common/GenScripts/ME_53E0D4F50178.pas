unit csTaskResult;

interface

uses
 l3IntfUses
 , l3Variant
 , TaskResult_Const
 , k2Base
;

type
 TcsTaskResultClass = class of TcsTaskResult;
 
 TcsTaskResult = class(Tl3Tag)
  function GetTaggedDataType: Tk2Type;
 end;//TcsTaskResult
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
