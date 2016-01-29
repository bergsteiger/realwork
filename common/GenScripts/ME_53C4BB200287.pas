unit ChromeLikeTypes;

interface

uses
 l3IntfUses
 , Types
 , Windows
;

type
 tagTitleBarInfoEx = record
 end;//tagTitleBarInfoEx
 
 TITLEBARINFOEX = tagTitleBarInfoEx;
 
 TTitleBarInfoEx = TITLEBARINFOEX;
 
 PTitleBarInfoEx = ^TTitleBarInfoEx;
 
 TVistaWindowCaptionMetrics = record
 end;//TVistaWindowCaptionMetrics
 
 TGradientDirection = (
  gdVertical
  , gdHorizontal
 );//TGradientDirection
 
 TWindowZOrderInfo = record
 end;//TWindowZOrderInfo
 
implementation

uses
 l3ImplUses
;

end.
