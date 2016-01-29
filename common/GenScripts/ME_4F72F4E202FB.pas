unit evCustomPrintDataSaver;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
;

type
 TevCustomPrintDataSaver = class(Tl3ProtoObject)
  function GetPanel: IafwPreviewPanel;
  procedure CheckResult;
  function IsWaitingPrint: Boolean;
  procedure SetPrintDataSaver(const aSaver: TevCustomPrintDataSaver);
 end;//TevCustomPrintDataSaver
 
implementation

uses
 l3ImplUses
;

end.
