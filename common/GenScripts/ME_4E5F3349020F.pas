unit nevDocumentPartFormatInfo;

interface

uses
 l3IntfUses
 , nevListFormatInfo
 , nevFormatInfo
 , nevBase
;

type
 TnevDocumentPartFormatInfo = class(TnevListFormatInfo)
 end;//TnevDocumentPartFormatInfo
 
implementation

uses
 l3ImplUses
 , evDocumentPart
 , l3Units
 , k2Tags
 , evParaTools
 , l3String
 , nevTools
;

type
 THackFormatInfo = class(TnevListFormatInfo)
 end;//THackFormatInfo
 
end.
