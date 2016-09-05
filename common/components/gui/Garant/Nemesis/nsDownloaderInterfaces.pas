unit nsDownloaderInterfaces;

interface
uses
  Windows;

type
 TnsDownloadFileAction = (dfaOpen, dfaSave, dfaSaveAs);

 InsDownloadParams = Interface;

 TnsDownloaderState = record
  rTotal: Integer;
  rCurrent: Integer;
  rParams: InsDownloadParams;
 end;

 InsDownloader = Interface(IUnknown)
 ['{F8B04111-636A-43E5-9864-3C5516F3A891}']
  function MakeState: TnsDownloaderState;
  function GetParams: InsDownloadParams;
  function GetFinished: Boolean;
  procedure Start;
  procedure Cancel;
  property Finished: Boolean read GetFinished;
 end;

 InsDownloaderEventSink = interface(IUnknown)
 ['{60468DE9-1B3D-42A1-9285-005A54D02823}']
  procedure OnStartDownload(const AParams: InsDownloadParams;
   const ADownloaderState: TnsDownloaderState);
  procedure OnDownloadFinished(const AParams: InsDownloadParams;
   const ADownloaderState: TnsDownloaderState);
  procedure OnProgress(const AParams: InsDownloadParams;
   const ADownloaderState: TnsDownloaderState);
 end;

 InsDownloadParams = interface(IUnknown)
 ['{B837B660-81A0-4FFE-8871-56B318825629}']
  function GetFileAction: TnsDownloadFileAction;
  procedure SetFileAction(AFileAction: TnsDownloadFileAction);
  function GetURL: string;
  procedure SetURL(const AURL: String);
  function GetFileName: string;
  procedure SetFileName(const AFileName: String);
  function GetFileTypeString: string;
  procedure SetFileTypeString(const AFileTypeString: String);
  function GetFileIcon: HICON;
  property FileAction: TnsDownloadFileAction read GetFileAction write SetFileAction;
  property URL: string read GetURL write SetURL;
  property FileName: String read GetFileName write SetFileName;
  property FileTypeString: string read GetFileTypeString write SetFileTypeString;
  property FileIcon: HICON read GetFileIcon;
 end;

 function TnsDownloaderState_C(ATotal: Integer; ACurrent: Integer;
  const AParams: InsDownloadParams): TnsDownloaderState;

implementation
uses
 l3Base;

function TnsDownloaderState_C(ATotal: Integer; ACurrent: Integer;
 const AParams: InsDownloadParams): TnsDownloaderState;
begin
 Finalize(Result);
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rTotal := ATotal;
 Result.rCurrent := ACurrent;
 Result.rParams := AParams;
end;

end.
