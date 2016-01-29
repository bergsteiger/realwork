unit DocumentRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList,
  l3InterfacedComponent, evSubPn, 
  //eeSubDescriptorsExport, 
  Dialogs,
  vtSaveDialog;

type
  TnsDocumentRes = class(TDataModule)
    DocumentItemsImageList: TvtPngImageList;
    SubPanelImageList: TvtNonFixedPngImageList;
    SubDescriptors: TevSubDescriptors;
    LiteSubDescriptors: TevSubDescriptors;
    CommentsImageList: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function nsDocumentRes: TnsDocumentRes;

const
 {DocumentItemsImageList}

 diilDocumentIcon             = 0;
 diilFolderIcon               = 1;
 diilSubAndBlockIcon          = 2;
 diilPictureFolderIcon        = 3;
 diilPictureIcon              = 4;
 diilPictureLinkIcon          = 5;
 diilObjectFolderIcon         = 6;
 diilObjectIcon               = 7;
 diilRTF                      = 7;    
 diilBookmarkIcon             = 8;
 diilUserCommentIcon          = 9;
 diilAttribute                = 10;
 diilActualRedaction          = 11;
 diilActualPreActiveRedaction = 12;
 diilActualNoActiveRedaction  = 13;
 diilPreActiveRedaction       = 14;
 diilNoActiveRedaction        = 15;
 diilMusic                    = 18;
 diilExcel                    = 19;
 diilAcrobat                  = 20;
 diilXMLIcon                  = 21;
 diilUSRIcon                  = 22;

implementation

uses
  Forms
  ;

var
 g_nsDocumentRes: TnsDocumentRes = nil;

function nsDocumentRes: TnsDocumentRes;
begin
 if (g_nsDocumentRes = nil) then
  Application.CreateForm(TnsDocumentRes, g_nsDocumentRes);
 Result := g_nsDocumentRes; 
end;

{$R *.dfm}

end.
