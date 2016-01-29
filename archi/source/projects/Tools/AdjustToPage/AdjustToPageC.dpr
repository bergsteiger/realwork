program AdjustToPageC;

{$AppType Console}

uses
  evdSchema,
  evAdjustNSRCToPage
  ;

begin
 if (ParamCount = 0) then
  WriteLn('Usage: AdjustToPageC infilename')
 else
  TevAdjustNSRCToPage.ProcessFile(ParamStr(1));
end.
