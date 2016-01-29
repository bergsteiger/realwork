unit vtStdRes;

{ $Id: vtStdRes.pas,v 1.23 2015/02/25 13:18:08 lulin Exp $ }

// $Log: vtStdRes.pas,v $
// Revision 1.23  2015/02/25 13:18:08  lulin
// - перегенерация.
//
// Revision 1.22  2012/11/01 09:42:28  lulin
// - забыл точку с запятой.
//
// Revision 1.21  2012/11/01 07:44:16  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.20  2012/06/08 16:41:56  kostitsin
// [$370385808]
//
// Revision 1.19  2011/11/15 11:04:30  lulin
// - выливаем все возможные списки картинок.
//
// Revision 1.18  2011/07/06 14:11:03  lulin
// {RequestLink:254944102}.
//
// Revision 1.17  2007/01/17 13:50:40  oman
// - new: Локализация библиотек - vt (cq24078)
//
// Revision 1.16  2005/07/07 13:46:32  mmorozov
// new: consts;
//
// Revision 1.15  2005/06/28 13:37:32  mmorozov
// - merge с веткой BNEMESIS_6_2;
//
// Revision 1.14.2.1  2005/06/28 13:12:16  mmorozov
// bugfix: наличие не благополучной иконки в ImageList-е приводило к невозможности загрузки из потока ImageList-а на WIN95;
//
// Revision 1.14  2005/05/12 14:33:51  lulin
// - new method: _Tafw.IsObjectLocked.
//
// Revision 1.13  2004/08/17 14:11:21  fireton
// - добавлена иконка для календарика с темой
//
// Revision 1.12  2004/07/30 13:17:03  am
// new: вкрутил лок для vt
//
// Revision 1.11  2004/01/16 08:40:37  fireton
// - исправлены строковые константы для кнопок календаря ("месяц" вместо "год")
//
// Revision 1.10  2003/12/10 10:32:20  fireton
// added feature: добавлены кнопки "сегодня" и "отмена"
//
// Revision 1.9  2003/04/19 11:24:49  law
// - new file: vtDefine.inc.
//
// Revision 1.8  2002/02/05 15:17:02  voba
// no message
//
// Revision 1.7  2001/04/02 11:32:42  law
// - убраны ненужные AutoCreat формы.
//
// Revision 1.6  2000/12/15 15:36:29  law
// - вставлены директивы Log.
//

{$I vtDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, vtPngImgList;

type
  TvtStdResources = class(TDataModule)
    Images: TImageList;
    EditorImages : TvtPngImageList;
  end;

 function vtResources: TvtStdResources;

const
 vt_PickIconCnt = 4;  
  {* - количество иконок в комплекте для picked листов}
 vt_imgCalendar       = 0;

 vt_imgListUnCheck    = 1;
 vt_imgListCheck      = 2;
 vt_imgListDenyCheck  = 3;
 vt_imgChildCheck     = 4;

 vt_imgListUnCheckW   = 5;
 vt_imgListCheckW     = 6;
 vt_imgListDenyCheckW = 7;
 vt_imgChildCheckW    = 8;

 vt_imgOtlClose       = 9;
 vt_imgOtlOpen        = 10;
 vt_imgOtlPlus        = 11;
 vt_imgOtlMinus       = 12;
 vt_imgOtlLeaf        = 13;

 vt_imgDeviceFont     = 15;
 vt_imgTTFFont        = 16;
 vt_imgCancel         = 17;
 vt_imgOk             = 18;

 //vt_imgThemedCalendar = 18;
   {* - иконка удалена из списка, т.к. ее наличие приводило к невозможности
        загрузки ImageList-а из потока на WIN95, при загрузке imagelist из
        потока используется функция CommCtrls ImageList_Read. }

var
 vtStdResources : TvtStdResources = nil;

implementation

uses
  l3Base,
  vtPngImgListUtils
  ;

{$R *.DFM}

function vtResources: TvtStdResources;
begin
 if vtStdResources = nil then
  vtStdResources := TvtStdResources.Create(Application);
 Result := vtStdResources;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtStdRes.pas initialization enter'); {$EndIf}
 AddImageListCreator(@vtResources);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtStdRes.pas initialization leave'); {$EndIf}
end.
