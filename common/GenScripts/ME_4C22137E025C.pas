unit evHAFPainterEx;

interface

uses
 l3IntfUses
 , evTypes
 , l3Interfaces
 , evHAFPainter
 , afwInterfaces
 , l3InternalInterfaces
 , l3Variant
;

type
 TevColontituls = array [TevPageColontituls] of Il3CString;
 
 TevReadColontitulsEvent = procedure(var theColontituls: TevColontituls) of object;
 
 TevHAFPainterEx = class(TevHAFPainter)
  function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
  procedure ReadColontitulSettings;
  function GetAppTitle: AnsiString;
  procedure TuneHeader(const aCanvas: Il3Canvas;
   aHeader: Tl3Variant;
   aTop: Boolean);
 end;//TevHAFPainterEx
 
implementation

uses
 l3ImplUses
 , l3String
 , evHAFPainterMacros
 , k2Tags
 , evSBSPar
 , l3Const
 , evdStyles
 , nevInterfaces
 , Forms
 , SysUtils
 , l3Base
 , afwFacade
 , afwSettingsChangePublisher
;

end.
