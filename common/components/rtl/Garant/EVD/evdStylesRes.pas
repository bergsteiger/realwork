unit evdStylesRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList, l3Memory;

type
  TevdStyles_Res = class(TDataModule)
    AACImages: TImageList;
    StylesImages: TvtNonFixedPngImageList;
    TreeIconList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
   function StyleID2ImageIndex(aStyleID: Integer): Integer;
   function Style2Stream(aStyleID: Integer): Tl3MemoryStream;
    {* - ¬озвращает поток с картинкой дл€ стил€. }
  end;

function evdStyles_Res: TevdStyles_Res;

implementation

uses
  Forms,
  Graphics,
  evdStyles,
  vtInterfaces,
  vtPngImgListUtils
  ;

var
  g_evdStylesRes: TevdStyles_Res = nil;

function evdStyles_Res: TevdStyles_Res;
begin
 if (g_evdStylesRes = nil) then
  Application.CreateForm(TevdStyles_Res, g_evdStylesRes);
 Result := g_evdStylesRes;
end;

{$R *.dfm}

function TevdStyles_Res.StyleID2ImageIndex(aStyleID: Integer): Integer;
begin
 Result := -1;
 case aStyleID of
  ev_saAttention:
   Result := 0;
  ev_saHLE1:
   Result := 3;
  ev_saHLE2:
   Result := 6;
  ev_saHLE3:
   Result := 2;
  ev_saHLE4:
   Result := 1;
  ev_saHLE5:
   Result := 5;
  ev_saHLE6:
   Result := 4;
 end;
end;

function TevdStyles_Res.Style2Stream(aStyleID: Integer): Tl3MemoryStream;
var
 l_ImageIndex: Integer;
begin
 Result := nil;
 l_ImageIndex := StyleID2ImageIndex(aStyleID);
 if l_ImageIndex > -1 then
 begin
  Result := Tl3MemoryStream.Create;
  IvtFlashImageList(StylesImages).SaveImageToStream(Result, l_ImageIndex, bpp24);
  Result.Seek(0, soBeginning);
 end; // if l_ImageIndex > -1 then
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\EVD\evdStylesRes.pas initialization enter'); {$EndIf}
 AddImageListCreator(@evdStyles_Res);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\EVD\evdStylesRes.pas initialization leave'); {$EndIf}
end.
