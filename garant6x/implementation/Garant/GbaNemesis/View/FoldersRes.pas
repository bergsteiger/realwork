unit FoldersRes;

// $Id: FoldersRes.pas,v 1.1 2010/07/15 17:27:54 lulin Exp $

// $Log: FoldersRes.pas,v $
// Revision 1.1  2010/07/15 17:27:54  lulin
// {RequestLink:197496539}.
//
// Revision 1.18  2010/04/22 08:26:13  oman
// - new: {RequestLink:204933350}
//
// Revision 1.17  2009/09/09 12:13:54  lulin
// - рисуем внутренние опеации формы рубрикатора на модели.
//
// Revision 1.16  2008/06/04 12:13:16  mmorozov
// - new: иконка для постоянных фильтров (CQ: OIT5-29200);
//
// Revision 1.15  2006/09/11 14:50:06  mmorozov
// - новые иконки;
//
// Revision 1.14  2006/05/05 13:11:17  mmorozov
// - работа над консультацией;
//
// Revision 1.13  2006/05/02 12:15:05  demon
// - new: добавлены иконки для объектов консультации в папках
//
// Revision 1.12  2005/03/03 16:52:44  demon
// - new icon
//
// Revision 1.11  2005/01/17 10:54:06  fireton
// - добавлены новые иконки
//
// Revision 1.10  2004/12/08 11:11:18  demon
// - new behavior: Заготовка для отображения глобальных фильтров + D'n'D
//
// Revision 1.9  2004/09/15 16:38:43  demon
// - new icon const
//
// Revision 1.8  2004/08/24 08:52:15  fireton
// - change: переводим на новые ImgeList'ы
//
// Revision 1.7  2004/05/24 11:02:14  demon
// - new: новая иконка для статуса на контроле - "удален"
//
// Revision 1.6  2004/02/13 17:09:46  demon
// - new: Иконка для расшаренной папки
//
// Revision 1.5  2004/02/05 07:06:36  demon
// - syntax fix
//
// Revision 1.4  2004/02/03 10:11:53  demon
// - new icons для отображения статусов "На контроле" и закладки в папках
//
// Revision 1.3  2003/08/21 11:18:21  demon
// - new icon
//
// Revision 1.2  2003/08/06 15:19:45  demon
// - new: константы для иконок
//
// Revision 1.1  2003/08/06 08:29:51  demon
// - new: ресурс для хранения иконок отображения папок
//

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

type
  TnsFoldersRes = class(TDataModule)
    FoldersItemImages: TvtPngImageList;
   private
    { Private declarations }
   public
    { Public declarations }
  end;

function nsFoldersRes: TnsFoldersRes;

const
 FolderIcon                  = 0;
 BookmarkIcon                = 1;
 ListIcon                    = 2;
 QueryIcon                   = 3;
 FilterIcon                  = 4;
 DeletedFilterIcon           = 5;
 BookmarkUnderControlIcon    = 6;
 GlobalFilterIcon            = 17;
 JournalFolderIcon           = 18;
 UserCommentsSearchIcon      = 19;
 PermanentFilter             = 25;

 UCStatus_ActiveIcon         = 7;
 UCStatus_ChangedIcon        = 8;
 UCStatus_AbolishedIcon      = 9;
 UCStatus_RegistredMUIcon    = 10;
 UCStatus_NotRegistredMUIcon = 11;
 UCStatus_NoneIcon           = 12;
 UCStatus_DeletedIcon        = 16;

 InfoIcon = 14;

 SharedFolderIcon            = 15;

 ConsultingFolderIcon        = 20;
 ConsultationUnreadIcon      = 21;
 ConsultationReadIcon        = 22;
 ConsultationSending         = 23;
 ConsultationDecline         = 24;

 UCDocument_Unknown          = 12;
 UCDocument_Active           = UCDocument_Unknown;
 UCDocument_Abolished        = 26;
 UCDocument_Preactive        = 27;

implementation

{$R *.dfm}

uses
  Forms
  ;

var
 g_FoldersRes: TnsFoldersRes = nil;

function nsFoldersRes: TnsFoldersRes;
begin
 if (g_FoldersRes = nil) then
  g_FoldersRes := TnsFoldersRes.Create(Application);
 Result := g_FoldersRes;
end;

end.
