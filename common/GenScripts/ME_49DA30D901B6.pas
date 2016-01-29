unit evTextParaPainterEx;

interface

uses
 l3IntfUses
 , evAACTextPainter
 , evLinePainter
 , l3Variant
 , l3Interfaces
 , nevBase
 , nevTools
 , l3Units
;

type
 TevTextParaPainterEx = class(TevAACTextPainter)
  {* Рисователь текстового параграфа. Для упрощения переноса на модель }
  procedure ValidateParaFont;
 end;//TevTextParaPainterEx
 
implementation

uses
 l3ImplUses
 , l3Const
 , Graphics
 , l3String
 , l3MinMax
 , nevAfterEndPoint
 , l3InternalInterfaces
 , TextPara_Const
 , k2Tags
 , evdTypes
 , l3Chars
 , nevFacade
 , evTextParaTools
 , evTextParaConst
 , l3CustomString
 , evdStyles
 , l3Types
 , nevRealTools
 , l3Base
 , k2InterfacesEx
 , evDef
 , l3LineArray
 , k2Base
 , HyperLink_Const
 , nevActiveHyperlink
 , evdTextStyle_Const
 , nevInterfaces
 , k2Facade
 , evParaTools
 , nevFormatInfoFactory
 , k2Const
 , nevDecorActiveHyperlink
 , l3Region
 , SysUtils
 , Windows
 , Types
 , l3Drawer
 , evAlignBySeparatorUtils
 , l3Math
 , nevSegmentObject
 , BitmapPara_Const
 , evSegLst
 , evCustomStyleManager
 , evAACContentUtils
;

end.
