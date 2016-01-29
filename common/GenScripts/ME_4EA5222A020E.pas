unit AACFiltersTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TAACFiltersTest = class(TBaseTest)
  {* [Requestlink:294595323] }
  procedure DoIt;
 end;//TAACFiltersTest
 
implementation

uses
 l3ImplUses
 , evEvdWriter
 , k2TagGen
 , dd_lcTextFormatter
 , dd_lcSectionEliminator
 , ddSpaceTrimmer
 , dd_lcTableEliminator
 , evEvdReader
 , dd_lcPageNumberEliminator
 , dd_lcVASCodeCorrector
 , dd_lcYearCodeCorrector
 , dd_lcTypeConverter
 , dd_lcSourceConverter
 , TextPara_Const
 , SysUtils
 , dd_lcVASSourceCorrector
 , dd_lcResolutionFormatter
 , dd_lcJudgeFormatter
 , dd_lcDateNumberFormatter
 , dd_lcCityNameFormatter
 , dd_lcTitleFormatter
 , dd_lcStartDocFormatter
 , dd_lcTextStyleCorrector
 , dd_lcTextSplitter
 , TestFrameWork
;

end.
