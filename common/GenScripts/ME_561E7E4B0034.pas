unit evUnicodeFormulasToUnicodeConverter;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevUnicodeFormulasToUnicodeConverter = class(TevdLeafParaFilter)
 end;//TevUnicodeFormulasToUnicodeConverter
 
implementation

uses
 l3ImplUses
 , TextPara_Const
 , k2Tags
 , Formula_Const
 , evdTypes
 , l3_String
 , evParaTools
 , l3Base
 , l3String
 , ObjectSegment_Const
 , SysUtils
 , StrUtils
;

end.
