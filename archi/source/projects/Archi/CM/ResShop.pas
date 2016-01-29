unit ResShop;

{ $Id: ResShop.pas,v 1.13 2013/11/05 12:45:16 dinishev Exp $ }

interface

uses
  SysUtils, Classes, ImgList, Controls,
  DT_Types,
  DT_Doc;

type
  TArchiResources = class(TDataModule)
    CommonImageList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 ArchiResources : TArchiResources;

 const
  crHand     = 1;
  crLink     = 2;
  crDragObj  = 3;
  crSubLink  = 4;

  picDir              = 0;
  picText             = 1;
  picPicture          = 2;

  picTextInact        = 5;

  picEditionText      = 6;
  picEditionTextInact = 7;

  picNoDoc            = 50;
  picNoDocInact       = 51;
  picDictEntry        = 53;
  picBook             = 54;


  picDiamond          = 8;
  picTextAnc          = 9;
  picAnchor           = 10;
  picAnchorBlock      = 11;
  picKey              = 12;
  picWarning          = 13;
  picDocSet           = 14;
  picActUser          = 15;
  picUser             = 16;
  picMessage          = 17;
  picReadMessage      = 18;

  picUserGroup        = 19;
  picDocFile          = 20;
  picSrchFile         = 21;
  picUserFile         = 22;
  picMailFile         = 23;

  picStylePara        = 24;
  picStyleInterv      = 25;

  picSrchText         = 26;
  picSrchStyle        = 27;
  picSrchAnchor       = picAnchor;
  picSrchHLink        = 28;

  picPublishSrc       = 29;
  picSrcCheck         = 30;
  picPaperPlace       = 31;

  picOneWay           = 32;
  picTwoWay           = 33;

  picDicWarning       = 34;
  picDicTree          = 35;
  picDicKey           = 36;
  picDicDocType       = 37;
  picDicDocGroup      = 38;
  picDicDocPubSrc     = picPublishSrc;
  picTerritory        = 39;
  picTextInsert       = 40;
  picDicPublisher     = 41;

  picBlueBall         = 43;
  picDiamondWarn      = 44;
  picFolderWarn       = 45;
  picEQDiamond        = 46;
  picGreenDiamond     = 49;

  picUrgentOvr        = 55;
  picToVersionOvr     = 56;
  picLeftBlock        = 57;
  picRightBlock       = 58;

 function GetDocumentImageIndex(aDocRec : TDocReadRec) : Integer; overload;
 function GetDocumentImageIndex(aDocRec : PDocListAccessRec) : Integer; overload;
 function GetDocumentImageIndex(aDocType : TDocType; aUserType : TUserType; aIsActive  : Boolean) : Integer; overload;

implementation

{$R *.DFM}
{$R PIcon.res}

uses
 Windows, Forms;

// var
// lResources : TArchiResources = nil;

{function ArchiCommonResources: TArchiResources;
begin
 if lResources = nil then
  lResources := TArchiResources.Create(Application);
 Result := lResources;
end;
}

function GetDocumentImageIndex(aDocRec : TDocReadRec) : Integer;
begin
 with aDocRec do
  Result := GetDocumentImageIndex(TDocType(Typ), TUserType(Flag), not NoActive);
end;

function GetDocumentImageIndex(aDocRec : PDocListAccessRec) : Integer;
begin
 with aDocRec^ do
  Result := GetDocumentImageIndex(TDocType(rTyp), TUserType(rFlag), rIsActive);
end;

function GetDocumentImageIndex(aDocType : TDocType; aUserType : TUserType; aIsActive  : Boolean) : Integer;
begin
 Result := picText;
 Case aDocType of
  DT_Types.dtText :
  begin
   if aUserType = utEdition then
    Result := picEditionTextInact
   else
   if aUserType = utBook then
    Result := picBook
   else
   if aUserType = utNoDoc then
   begin
    If aIsActive then
     Result := picNoDoc
    else
     Result := picNoDocInact;
   end
   else
    if aIsActive then
     Result := picText
    else
     Result := picTextInact;
  end;

  DT_Types.dtObject :
   Result := picPicture;

  DT_Types.dtDictEntry :
   Result :=  picDictEntry;
  end;
end;

 procedure InitCursors;
  Begin
   Screen.Cursors[crHand]:=LoadCursor(HInstance,'CR_HAND');
   Screen.Cursors[crLink]:=LoadCursor(HInstance,'CR_LINK');
   Screen.Cursors[crDragObj]:=LoadCursor(HInstance,'CR_DRAGOBJ');
   Screen.Cursors[crSubLink]:=LoadCursor(HInstance,'CR_SUBLINK');
  end;

Initialization
 InitCursors;
end.

