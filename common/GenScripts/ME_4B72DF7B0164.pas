unit eeRenderFormula;

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , l3Variant
 , ActiveX
 , nevDocumentContainer
;

type
 TeeRenderTarget = (
  ee_rtPNG
  , ee_rtBMP
  , ee_rtRawBMP
 );//TeeRenderTarget
 
implementation

uses
 l3ImplUses
 , evdSchema
 , l3StringIDEx
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , jclDebug
 , l3Memory
 , Classes
 , k2DocumentBuffer
 , evdNativeReader
 , l3BitmapContainer
 , imageenio
 , k2Tags
 , evdTypes
 , SysUtils
 , l3Stream
 , l3Base
 , l3Math
 , l3Interfaces
 , evdVer
 , TextPara_Const
 , l3Units
 , nevTools
 , nevBase
 , Document_Const
 , nevVirtualDrawView
 , l3ScreenIC
 , Formula_Const
 , Graphics
 , l3ImageUtils
;

type
 TnevDocumentContainerHack = class(TnevDocumentContainer)
 end;//TnevDocumentContainerHack
 
end.
