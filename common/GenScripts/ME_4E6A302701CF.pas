unit nevDocumentFormatInfo;

interface

uses
 l3IntfUses
 , nevListFormatInfo
 , nevFormatInfoList
 , nevFormatInfo
 , nevBase
;

type
 TnevDocumentFormatInfo = class(TnevListFormatInfo)
 end;//TnevDocumentFormatInfo
 
implementation

uses
 l3ImplUses
 , nevFormatInfoFactory
 , SysUtils
 , LeafPara_Const
 , evAACContentUtils
;

end.
