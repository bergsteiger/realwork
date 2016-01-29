unit vtLabel;

interface

uses
 l3IntfUses
 , StdCtrls
 , Controls
 , afwInterfaces
 , l3Interfaces
 , evdTypes
 , l3GraphicControlCanvas
 , Messages
 , Classes
 , Types
;

type
 TvtDrawDirection = (
  ddHorizontal
  , ddVertical
 );//TvtDrawDirection
 
 {$Define _UnknownIsComponent}
 
 TvtCustomLabelPrim = class(_l3Unknown_)
 end;//TvtCustomLabelPrim
 
 TvtCustomLabel = class(TvtCustomLabelPrim, IafwTextControl)
  procedure WMGetText(var Msg: TMessage);
  procedure WMGetTextLength(var Msg: TMessage);
  procedure WMSetText(var Msg: TMessage);
  function CheckStamp(const aGUID: TGUID): Boolean;
  function CaptionStored: Boolean;
   {* "‘ункци€ определ€юща€, что свойство Caption сохран€етс€" }
  function CCaption: IafwCString;
 end;//TvtCustomLabel
 
 TvtLabel = class(TvtCustomLabel)
 end;//TvtLabel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
 , l3String
 , afwVCL
 , Graphics
 , l3Types
 , l3MinMax
;

type
 THackLink = class(TControlActionLink)
 end;//THackLink
 
end.
