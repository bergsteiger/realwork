unit PDViewerPreferenceIntf;

interface

uses
  gtObjectIntf;

type

  IgtPDViewerPreference = class(IgtObject)
    function GetHideToolBar: WordBool; virtual; abstract;
    procedure SetHideToolBar(const Value: WordBool); virtual; abstract;
    function GetHideMenuBar: WordBool; virtual; abstract;
    procedure SetHideMenuBar(const Value: WordBool); virtual; abstract;
    function GetHideWindowUI: WordBool; virtual; abstract;
    procedure SetHideWindowUI(const Value: WordBool); virtual; abstract;
    function GetCenterWindow: WordBool; virtual; abstract;
    function GetDisplayDocTitle: WordBool; virtual; abstract;
    function GetFitWindow: WordBool; virtual; abstract;
    procedure SetCenterWindow(const Value: WordBool); virtual; abstract;
    procedure SetDisplayDocTitle(const Value: WordBool); virtual; abstract;
    procedure SetFitWindow(const Value: WordBool); virtual; abstract;
  End;

implementation

end.
