unit csCourtDecisionSabCheckerParams;

interface

uses
 l3IntfUses
 , l3Variant
 , CourtDecisionSabCheckerParams_Const
 , csCourtsListHelper
 , k2Base
;

type
 TcsCourtDecisionSabCheckerParams = class(Tl3Tag)
  function GetTaggedDataType: Tk2Type;
 end;//TcsCourtDecisionSabCheckerParams
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
