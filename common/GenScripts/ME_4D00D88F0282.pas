unit PreviewWithLinesTestBefore235875079;

interface

uses
 l3IntfUses
 , PreviewTestBefore235875079
 , l3FrameLinesSpy
 , l3InternalInterfaces
 , PrimTextLoad_Form
;

type
 TPreviewWithLinesTestBefore235875079 = class(TPreviewTestBefore235875079, Il3FrameLinesLogger)
  {* “ест печати с логом отрисованных линий }
  function OpenLinesLog(const aCanvas: Il3InfoCanvas;
   aObjID: Integer): AnsiString;
  procedure CloseLinesLog(const aLogName: AnsiString);
  function GetPrecision: Integer;
 end;//TPreviewWithLinesTestBefore235875079
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , TestFrameWork
;

end.
