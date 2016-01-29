unit ChatRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

const
 { Image indexes }
 ciiActive         = 0;
 ciiInActive       = 1;

type
  TdmChat = class(TDataModule)
    ilUsers: TvtPngImageList;
  private
  public
  end;

function dmChat: TdmChat;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_dmChat: TdmChat = nil;

function dmChat: TdmChat;
begin
 if (g_dmChat = nil) then
  Application.CreateForm(TdmChat, g_dmChat);
 Result := g_dmChat; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@dmChat);
 
end.
