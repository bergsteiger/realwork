unit evCustomTextFormatterModelPart;

interface

uses
 l3IntfUses
 , evdDocumentFilter
 , l3Variant
;

type
 TevCustomTextFormatterModelPart = class(TevdDocumentFilter)
  procedure ValidateStyles;
 end;//TevCustomTextFormatterModelPart
 
implementation

uses
 l3ImplUses
 , evdTextStyle_Const
 , k2Tags
 , Formula_Const
 , evdTypes
 , ObjectSegment_Const
;

end.
