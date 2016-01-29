unit ListRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

type
  TnsListRes = class(TDataModule)
    ListItemsImageList: TvtPngImageList;
    ilDrugListItems: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function nsListRes: TnsListRes;

const
 DocIcon                  = 0;
 SubIcon                  = 1;
 PreActiveOffset          = 2;
 NoActiveOffset           = 4;
 ExObjIcon                = 6;
 WWWIcon                  = 6;
 InfoIcon                 = 7;
 RedactionIcon            = 8;
 RedactionFolder          = 9;
 AACDocumentIcon          = 10;

 DrugAnnuled              = 0;
 DrugNarcotic             = 1;
 DrugNoAnnuledNoNarcoric  = 2;
 FormAnnuled              = 3;
 FormRussianImportant     = 4;
 FormNoRussianImportant   = 5;
 FormRussianNoImportant   = 6;
 FormNoRussianNoImportant = 7;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_nsListRes: TnsListRes = nil;

function nsListRes: TnsListRes;
begin
 if (g_nsListRes = nil) then
  Application.CreateForm(TnsListRes, g_nsListRes);
 Result := g_nsListRes; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@nsListRes);
 
end.
