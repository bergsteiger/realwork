unit evAdjustNSRCToPage;

interface

uses
 l3IntfUses
;

type
 TevAdjustNSRCToPage = class
  {* [RequestLink:241012792] }
  procedure ProcessFile(const aFile: AnsiString);
 end;//TevAdjustNSRCToPage
 
implementation

uses
 l3ImplUses
 , ddSectionWithSub2Para
 , ddSectionRepair
 , ddNSRCGenerator
 , evdNSRCReader
 , l3Filer
 , evCustomTextFormatter
 , evSimpleTextPainter
 , l3Chars
 , k2TagGen
 , l3Base
 , l3Types
 , SysUtils
 , evEmptyTableEliminator
;

end.
