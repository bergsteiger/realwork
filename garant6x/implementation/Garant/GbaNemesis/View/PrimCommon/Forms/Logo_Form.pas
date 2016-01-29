unit Logo_Form;

// $Id: Logo_Form.pas,v 1.4 2013/01/22 15:59:41 kostitsin Exp $

// $Log: Logo_Form.pas,v $
// Revision 1.4  2013/01/22 15:59:41  kostitsin
// [$424399029]
//
// Revision 1.3  2010/03/31 11:54:24  oman
// - new: {RequestLink:200083417}
//
// Revision 1.2  2010/03/30 12:14:36  oman
// - new: Заготовка {RequestLink:200083417}
//
// Revision 1.1  2009/09/14 16:13:44  lulin
// - незаконченные формы также пишем в проект.
//
// Revision 1.1  2009/09/14 11:28:52  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.25  2009/07/31 17:29:48  lulin
// - убираем мусор.
//
// Revision 1.24  2009/05/29 06:20:03  oman
// - new: Меняем картику - [$148015791]
//
// Revision 1.23  2008/02/08 14:02:13  migel
// - fix: падало при запуске.
//
// Revision 1.22  2008/02/08 11:17:13  migel
// - add: формированию номера версии автоматом (если доступно - версия формируется на основе параметров сборки, если нет - то по структуре VersionInfo).
//
// Revision 1.21  2007/04/25 11:16:53  lulin
// - cleanup.
//
// Revision 1.20  2007/03/15 15:19:04  lulin
// - заменяем на свою функцию форматирования строки.
//
// Revision 1.19  2006/12/08 10:20:09  lulin
// - удалены ссылки на ненужные модули.
//
// Revision 1.18  2006/12/07 12:56:52  lulin
// - cleanup.
//
// Revision 1.17  2006/12/07 12:40:29  lulin
// - повторный переход на "правильные" панели.
//
// Revision 1.16  2006/12/06 08:00:29  lulin
// - везде используем одни и те же метки.
//
// Revision 1.15  2006/12/05 14:15:30  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.14  2006/04/17 12:49:26  oman
// - change: Избавляем бизнес-объекты (слой модели) от обязательств
//  контроллера (хинты, imageindex)
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.13  2006/03/21 10:18:05  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.12  2005/10/06 10:49:26  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.11  2005/10/06 09:16:59  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.10  2005/05/27 14:46:15  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.9  2004/10/19 09:31:11  fireton
// - change: в отладочной версии сплеш прозрачный и показывается версия, в неотладочной - нет.
//
// Revision 1.8  2004/10/19 09:15:12  fireton
// - change: поменяна картинка на сплеше
//
// Revision 1.7  2004/09/16 11:34:20  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//
// Revision 1.6  2004/06/29 10:56:15  migel
// - fix: совместимость с win95 при показе этого диалога + бордюр вокруг сплеша.
//
// Revision 1.5  2003/12/24 14:50:19  demon
// - new: закрытие формы по Single Click
//
// Revision 1.4  2003/12/18 17:22:36  law
// - change: заменил TvtPanel -> TvtPanel.
//
// Revision 1.3  2003/12/15 09:34:01  migel
// - fix: не показываем заголовок окна в таскбаре, пока не загрузиться основная форма.
//
// Revision 1.2  2003/10/17 10:46:06  migel
// - change: `Гарант 6` на `Гарант`
//
// Revision 1.1  2003/05/23 14:19:14  demon
// - new behavior: добавлены коментарии и полностью реализовано
// "начало/завершение работы с системой".
//

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
     StdCtrls, ExtCtrls, vtVerInf, OvcBase, vtPanel, afwControl,
  vtLabel, vcmEntityForm, l3Interfaces, afwControlPrim, afwBaseControl,
  afwTextControlPrim, afwTextControl
  ;

type
  TLogoForm = class(TvcmEntityForm)
   {* Форма, выводимая в момент запуска программы.}
   VerInfo: TvtLabel;
    Panel1: TvtPanel;
    Image1: TImage;
    LoadLabel: TvtLabel;
   procedure FormCreate(Sender: TObject);
  protected
   procedure CreateParams(var aParams: TCreateParams); override;
  public
 {$IFDEF DEBUG}
   procedure UpdateVerInfo(const aVerInfoPattern: Il3CString);
 {$ENDIF}
   procedure UpdateLoadString(const aString: Il3CString);
    overload;
   procedure UpdateLoadString(const aString: string);
    overload;
  end;

implementation

{$R *.DFM}

uses
  SysUtils,

  l3String
  ;

procedure TLogoForm.FormCreate(Sender: TObject);
begin
 {$IFDEF DEBUG}
 AlphaBlend := True;
 {$ENDIF}
end;

procedure TLogoForm.CreateParams(var aParams: TCreateParams);
begin
 inherited;
 with aParams do
 begin
  Style := Style and not (WS_CAPTION) or WS_BORDER;
  ExStyle := ExStyle and not(WS_EX_APPWINDOW) or WS_EX_TOOLWINDOW;
 end;
end;

{$IFDEF DEBUG}
procedure TLogoForm.UpdateVerInfo(const aVerInfoPattern: Il3CString);
 {$I nsBuildVersion.inc}
begin
 VerInfo.Visible := True;
 //
 if (c_BuildVersion <> 'X.XX.X.XXX') then
 begin
  VerInfo.CCaption := l3Fmt(aVerInfoPattern, [c_BuildVersion]);
 end
 else
  with TVersionInfo.Create, FileLongVersion do
  try
   VerInfo.CCaption := l3Fmt(aVerInfoPattern, [l3Fmt('%d.%d.%d.%d', [All[2], All[1], All[4], All[3]])]);
  finally
   Free;
  end;
end;
{$ENDIF}

procedure TLogoForm.UpdateLoadString(const aString: Il3CString);
begin
 LoadLabel.Visible := True;
 LoadLabel.CCaption := aString;
end;

procedure TLogoForm.UpdateLoadString(const aString: string);
begin
 LoadLabel.Visible := True;
 LoadLabel.Caption := aString;
end;

end.