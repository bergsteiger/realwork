unit SearchRes;

//$Id: SearchRes.pas,v 1.2 2012/06/08 16:43:27 kostitsin Exp $
//$Log: SearchRes.pas,v $
//Revision 1.2  2012/06/08 16:43:27  kostitsin
//[$370385808]
//
//Revision 1.1  2011/12/15 16:24:25  lulin
//{RequestLink:320734796}
//
//Revision 1.1  2011/11/16 12:30:33  lulin
//{RequestLink:232098711}
//
//Revision 1.23  2011/11/15 11:04:46  lulin
//- выливаем все возможные списки картинок.
//
//Revision 1.22  2008/07/09 12:42:57  mmorozov
//- change: изменена иконка календаря (K<96484685>);
//
//Revision 1.21  2008/01/15 14:41:22  oman
//- new: Новый дизайн окна логина (cq13279)
//
//Revision 1.20  2008/01/15 12:15:20  oman
//- new: Новый дизайн окна авторегистрации - большие шрифты (cq13279)
//
//Revision 1.19  2008/01/15 11:32:40  oman
//- new: Новый дизайн окна авторегистрации (cq13279)
//
//Revision 1.18  2007/06/26 12:07:41  demon
//- new icon for Help
//
//Revision 1.17  2007/05/03 10:03:17  oman
//- new: Заготовка полномасштабного интерфейса (cq25149)
//
//Revision 1.16  2006/12/15 15:28:57  mmorozov
//- new: иконки выбора реквизитов (CQ: OIT5-23317);
//

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

type
  TnsSearchRes = class(TDataModule)
    SearchItemsImageList: TvtPngImageList;
    OldFiltersImageList: TvtPngImageList;
    ImageList: TvtPngImageList;
    ilSelectAttribute: TvtNonFixedPngImageList;
    ImageList16x16: TvtFixedSizeProxyPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function nsSearchRes: TnsSearchRes;

const
 { OldFiltersImageList }
 ofilSelect   = 0;
 ofilDeselect = 1;
 { SearchItemsImageList }
 siilDeselected             = 0;
 siilSelected               = 1;
 siilFolderStart            = 2;
 siilSelectedRoot           = 6;
 siilSelectedElement        = 7;
 siilNewsLineTheme          = 8;
 siilNewsLineThemeForCreate = 9;
 { ilSelectAttribute }
 c_saElementStart                        = 0;
 c_saFolderStart                         = 4;
 c_saFolderHasSelectChild                = 8;
 c_saChildInSelectFolderEnable           = 9;
 c_saChildInSelectFolderDisable          = 10;
 c_saFolderInSelectFolderEnable          = 11;
 c_saFolderInSelectFolderDisable         = 12;
 c_saFilteredFolderStart                 = 13;
 c_saFilteredFolderHasSelectChild        = 17;
 c_saFilteredFolderInSelectFolderEnable  = 18;
 c_saFilteredFolderInSelectFolderDisable = 18;

 { imageList}
 c_srchInfo = 0;
 c_srchCalendar = 1;
 c_srchHelp = 2;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_nsSearchRes: TnsSearchRes = nil;

function nsSearchRes: TnsSearchRes;
begin
 if (g_nsSearchRes = nil) then
  Application.CreateForm(TnsSearchRes, g_nsSearchRes);
 Result := g_nsSearchRes; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@nsSearchRes);
 
end.
