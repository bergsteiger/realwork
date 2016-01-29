unit IWTypes;

{PUBDIST}

interface

uses
  {$IFDEF Linux}QGraphics;{$ELSE}Graphics;{$ENDIF}

type
  TIWBrowser = (brUnknown, brIE, brNetscape6, brOpera);
  TIWBrowsers = set of TIWBrowser;
  TIWServerType = (stApplication, stPage);
  TIWShowMessageType = (smAlert, smNewWindow, smSameWindow, smSameWindowFrame);
  TWarningProc = procedure(const AMsg: string);
  TIWHTTPServerInitProc = procedure;
  TIWLogProcedure = procedure(const AMsg: string; const ADetailedOnly: Boolean = False) of object;
  TIWColor = TColor;

const
  IWAllBrowsers: TIWBrowsers = [brIE, brNetscape6, brOpera];

implementation

end.
