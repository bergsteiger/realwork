{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FileHistoryAPI;

interface

uses Winapi.Windows, Winapi.CommCtrl, System.SysUtils, System.Classes, Vcl.Menus, Winapi.ActiveX, ToolsAPI;

type
  {$MINENUMSIZE 4}
  TOTAHistoryStyle = (hsBuffer, hsFile, hsLocalFile, hsRemoteRevision, hsActiveRevision);
  {$MINENUMSIZE 1}
  TOTAFileNameArray = array of WideString;
  IOTAFileHistoryProvider = interface;
  IOTAFileHistory = interface;
  IOTAFileHistoryNotifier = interface;

  IOTAFileHistoryManager = interface
    ['{55A2BEE4-A64C-4749-8388-070CAEFDEFA5}']
    function AddNotifier(const ANotifier: IOTAFileHistoryNotifier): Integer;
    procedure AddTemporaryLabel(const ALabelName: WideString; const AFiles: TOTAFileNameArray);
    function Get_Count: Integer;
    function GetFileHistoryProvider(Index: Integer): IOTAFileHistoryProvider;
    function RegisterHistoryProvider(const HistoryProvider: IOTAFileHistoryProvider): Integer;
    procedure RemoveNotifier(Index: Integer);
    procedure RevertTemporaryLabel(const ALabelName: WideString);
    procedure UnregisterHistoryProvider(Index: Integer);
    procedure UpdateProviders;

    property Count: Integer read Get_Count;
    property FileHistoryProvider[Index: Integer]: IOTAFileHistoryProvider read GetFileHistoryProvider;
  end;

  IOTAFileHistoryNotifier = interface(IOTANotifier)
    ['{286AC9E5-875A-4402-AF70-8ACDD6757EC8}']
    procedure ProvidersUpdated;
  end;

  IOTAAsynchronousHistoryUpdater = interface
    ['{62711089-2DB3-4C39-B493-CABF73B22174}']
    procedure Completed;
    function UpdateHistoryItems(FileHistory: IOTAFileHistory; FirstNewIndex, LastNewIndex: Integer): Boolean;
  end;

  IOTAFileHistoryProvider = interface(IDispatch)
    ['{B8CDB02D-93D8-4088-AE03-A28052AD0FAD}']
    function Get_Ident: WideString; safecall;
    function Get_Name: WideString; safecall;
    function GetFileHistory(const AFileName: WideString): IOTAFileHistory; safecall;

    property Ident: WideString read Get_Ident;
    property Name: WideString read Get_Name;
  end;

  IOTAAsynchronousHistoryProvider = interface
    ['{BE67C423-C2BC-42D2-BDAF-F859B04A369E}']
    procedure StartAsynchronousUpdate(const AFileName: WideString;
      const AsynchronousHistoryUpdater: IOTAAsynchronousHistoryUpdater);
  end;

  IOTAAsynchronousHistoryProvider150 = interface
    ['{EF5F011A-413C-4B09-92D5-16BC8A8F7C08}']
    // This function is called when the history view is hidden or when the
    // user hits refresh.  It is possible for this function to be called even
    // if the asynchronous update is completed.
    procedure TerminateAsynchronousUpdate(const AFileName: WideString; WaitForTerminate: Boolean);
  end;

  IOTAFileHistory = interface(IDispatch)
    ['{92E624D2-A7CD-4C89-9B4E-71170955E96C}']
    function Get_Count: Integer; safecall;
    function GetAuthor(Index: Integer): WideString; safecall;
    function GetComment(Index: Integer): WideString; safecall;
    function GetContent(Index: Integer): IStream; safecall;
    function GetDate(Index: Integer): TDateTime; safecall;
    function GetIdent(Index: Integer): WideString; safecall;
    function GetHistoryStyle(Index: Integer): TOTAHistoryStyle; safecall;
    function GetLabelCount(Index: Integer): Integer; safecall;
    function GetLabels(Index, LabelIndex: Integer): WideString; safecall;

    property Author[Index: Integer]: WideString read GetAuthor;
    property Count: Integer read Get_Count;
    property Comment[Index: Integer]: WideString read GetComment;
    property Content[Index: Integer]: IStream read GetContent;
    property Date[Index: Integer]: TDateTime read GetDate;
    property HistoryStyle[Index: Integer]: TOTAHistoryStyle read GetHistoryStyle;
    property Ident[Index: Integer]: WideString read GetIdent;
    property LabelCount[Index: Integer]: Integer read GetLabelCount;
    property Labels[Index, LabelIndex: Integer]: WideString read GetLabels;
  end;

  { This is used whenever the mouse hovers over an entry in the Contents or
    Diff sub view of the history view. This should be implemented by the same
    object as IOTAFileHistory. }
  IOTAFileHistoryHint = interface
    ['{93437601-728C-4397-83AE-DAA64A9BA3D1}']
    function GetHintStr(Index: Integer): string;

    property HintStr[Index: Integer]: string read GetHintStr;
  end;

  IOTAAnnotationLineProvider = interface
    ['{4443660D-A0D7-4F25-8842-C576E341F2A8}']
    function GetCount: Integer;
    function GetGutterInfo(Index: Integer): string;
    { Used to show the age of the line.  The valid range is 0 - 1000.  The oldest
      code should have a value of 0 with the newest having a value of 1000.  Use
      -1 if you wish to use the default color. }
    function GetIntensity(Index: Integer): Integer;
  { Return the maximum number of characters of all the gutter strings.  Used
    to set the fixed gutter width. }
    function GetMaxGutterWidth: Integer;
    function GetHintStr(Index: Integer): string;

    property Count: Integer read GetCount;
    property GutterInfo[Index: Integer]: string read GetGutterInfo;
    property MaxGutterWidth: Integer read GetMaxGutterWidth;
    property HintStr[Index: Integer]: string read GetHintStr;
    property Intensity[Index: Integer]: Integer read GetIntensity;
  end;

  IOTAAnnotationCompletion = interface
    ['{1888C1E9-CB2F-4889-84F6-0BA01A25EF1F}']
    procedure AnnotationComplete(const AnnotationLineProvider: IOTAAnnotationLineProvider);
  end;

  { This should be implemented in the same object that implements
    IOTAFileHistory. }
  IOTAAsynchronousAnnotationProvider = interface
    ['{29769D00-295C-43D9-9D7C-4FF0184B850B}']
    function CanAnnotateFile(const FileName: string): Boolean;
    procedure StartAsynchronousUpdate(const FileName: string;
      FileHistoryIndex: Integer; const AnnotationCompletion: IOTAAnnotationCompletion);
  end;

implementation

end.
