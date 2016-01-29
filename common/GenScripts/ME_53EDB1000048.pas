unit csCourtDescription;

interface

uses
 l3IntfUses
 , l3Variant
 , CourtDescription_Const
 , csDecisionPhrasesHelper
 , k2Base
;

type
 TcsCourtDescription = class(Tl3Tag)
  procedure Clear;
  function GetTaggedDataType: Tk2Type;
 end;//TcsCourtDescription
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
