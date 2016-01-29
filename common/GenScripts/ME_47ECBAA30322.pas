unit evHiddenFilter;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , evdStyles
 , k2TagGen
 , l3Variant
 , k2Base
;

type
 TevHiddenFilter = class(TevdLeafParaFilter)
  function SetTo(aHiddenStyles: TevStandardStyles;
   aTreatCollapsedAsHidden: Boolean;
   var theGenerator: Tk2TagGenerator): Tk2TagGenerator;
  procedure Create(aHiddenStyles: TevStandardStyles;
   aTreatCollapsedAsHidden: Boolean);
  function MakePrim(aHiddenStyles: TevStandardStyles;
   aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator;
  function Make(aHiddenStyles: TevStandardStyles;
   aTreatCollapsedAsHidden: Boolean): Ik2TagGenerator;
 end;//TevHiddenFilter
 
implementation

uses
 l3ImplUses
 , StyledLeafPara_Const
 , TextPara_Const
 , nevTextParaRenderInfo
 , nevLeafRenderInfo
 , nevTools
 , SysUtils
 , evCommentsEliminator
 , nevFormatInfo
 , nevFormatInfoFactory
 , k2Tags
;

end.
