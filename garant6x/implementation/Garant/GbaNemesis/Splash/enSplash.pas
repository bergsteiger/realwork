unit enSplash;

// $Id: enSplash.pas,v 1.15 2014/08/21 12:12:33 kostitsin Exp $

// $Log: enSplash.pas,v $
// Revision 1.15  2014/08/21 12:12:33  kostitsin
// {requestlink: 511787350 }
//
// Revision 1.14  2013/01/22 16:25:37  kostitsin
// [$424399029]
//
// Revision 1.13  2009/12/03 08:58:16  oman
// - fix: {RequestLink:172986721}
//
// Revision 1.12  2009/03/05 12:48:42  oman
// - fix: Гонки на закрытии (К-138544506)
//
// Revision 1.11  2009/03/05 09:55:23  oman
// - fix: Шаманим (К-138544506)
//
// Revision 1.10  2009/03/03 07:38:21  oman
// - fix: Глотался Close (К-137469137)
//
// Revision 1.9  2009/02/20 10:51:29  oman
// - fix: Передаем лого (К-136254180)
//
// Revision 1.8  2009/02/20 10:21:36  oman
// Cleanup
//
// Revision 1.7  2009/02/20 09:58:00  oman
// - fix: Принимаем строки (К-136254180)
//
// Revision 1.6  2009/02/19 13:23:10  oman
// - fix: Боремся за чистоту расы (К-136254180)
//
// Revision 1.5  2009/02/19 12:43:04  oman
// - fix: Убираем лишние пути (К-136254180)
//
// Revision 1.4  2009/02/19 11:35:42  oman
// - fix: Рисуем сервер (К-136254180)
//
// Revision 1.3  2009/02/19 09:10:58  oman
// - fix: Документация (К-136254180)
//
// Revision 1.2  2009/02/19 08:33:38  oman
// - fix: Рисуем интерфесы (К-136254180)
//
// Revision 1.1  2009/02/18 13:42:22  oman
// - fix: Заготовки показывательщика (К-136254180)
//
// Revision 1.1  2009/02/18 12:15:46  oman
// - fix: Отцепляем сплеш в отдельный процесс (К-136254180)
//
//

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  ComCtrls,
  StdCtrls,
  ImgList,

  l3Interfaces,

  afwControl,

  OvcBase,

  vtPngImgList,
  vtPanel,
  vtGradientWaitbar,
  vtLabel,

  ieview,
  imageenview,
  imageen,

  SplashServerInterfaces,

  vtShockwaveEx, afwControlPrim, afwBaseControl, afwTextControlPrim,
  afwTextControl
  ;

type
  Ten_SplashForm = class(TForm, InsSplashWaiter)
    BackgroundPanel: TvtPanel;
    UserPanel: TvtPanel;
    PicturePanel: TvtPanel;
    Image: TImageEn;
    ProgressPanel: TvtPanel;
    WaitBar: TvtGradientWaitbar;
    ImagePanel: TvtPanel;
    TextPanel: TvtPanel;
    UserInfoLabel: TvtLabel;
    lblRight: TvtLabel;
    ilInfo: TvtNonFixedPngImageList;
    pbInfo: TPaintBox;
    pbLogo: TPaintBox;
    SplashTimer: TTimer;
    Bevel1: TBevel;
    procedure vcmEntityFormCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure pbInfoPaint(Sender: TObject);
    procedure pbLogoPaint(Sender: TObject);
    procedure SplashTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FlashError(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_Finished: Boolean;
    f_MinimalShowTimeEllapsed: Boolean;
    f_MinimalShowTime: Cardinal;
    f_Estimated: Cardinal;
    f_Flash   : TvtShockwaveFlashEx;
    f_Info: InsSplashInfo;
    f_FlashPlayed: Boolean;
    f_Frame: Integer;
    f_PrevFrame: Integer;
    f_LastChanged: Cardinal;
    f_TotalFrames: Integer;
    f_ilLogo: TvtNonFixedPngImageList;
    f_LastTryToClose: Cardinal;
  protected
    procedure CanCloseSplash;
  public
  // public methods
    procedure InitSplash(const aSplash: InsSplashInfo);
    destructor Destroy;
     override;
  end;

var
 en_SplashForm: Ten_SplashForm;

implementation

{$R *.dfm}

uses
  Math,
  DateUtils,

  l3Base,
  l3String,
  l3Stream,

  afwFacade,

  hyieutils,

  ShockwaveFlashObjects_TLB,

  FlashUtils
  ;

procedure Ten_SplashForm.vcmEntityFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose := f_Finished and f_MinimalShowTimeEllapsed and f_FlashPlayed;
 if CanClose and Assigned(f_Flash) then
  f_Flash.Stop;
 if CanClose and Assigned(f_Info) then
  f_Info.SwitchToParent;
 f_LastTryToClose := GetTickCount + 500; 
end;

procedure nsPaintImage(aImageList : TvtNonFixedPngImageList;
                       aPaintBox  : TPaintBox);
  {* - вывести иконку на канвку. }

  function lp_CalcOffset(const aParent, aChild: Integer): Integer;
  begin
   Result := 0;
   if aChild < aParent then
    Result := (aParent - aChild) div 2;
  end;//function lp_CalcOffsetY: Integer;

begin
 with aImageList do
  Draw(aPaintBox.Canvas,
       lp_CalcOffset(aPaintBox.Width, Width),
       lp_CalcOffset(aPaintBox.Height, Height),
       0);
end;

procedure Ten_SplashForm.pbInfoPaint(Sender: TObject);
begin
 nsPaintImage(ilInfo, pbInfo);
end;

procedure Ten_SplashForm.pbLogoPaint(Sender: TObject);
begin
 if Assigned(f_ilLogo) then
  nsPaintImage(f_ilLogo, pbLogo);
end;

procedure Ten_SplashForm.CanCloseSplash;
begin
 f_Finished := True;
 if Assigned(f_Info) then
  f_Info.Waiter := nil;
 Close;
end;

procedure Ten_SplashForm.InitSplash(const aSplash: InsSplashInfo);
var
 l_dX: Integer;
 l_dY: Integer;
 l_Stream: TStream;
 l_Delta: Integer;
 l_LogoHeight: Integer;
 l_UserTop: Integer;
 l_Comp: TComponent;
begin
 f_FlashPlayed := True;
 f_Finished := False;
 f_MinimalShowTimeEllapsed := False;
 Assert(Assigned(aSplash));
 f_Info := aSplash;
 f_Info.Waiter := Self;
 f_MinimalShowTime := f_Info.MinimalShowTime;
 f_Estimated := 0;
 f_Frame := -1;
 f_PrevFrame := -1;
 f_LastChanged := 0;

 if l3IsNil(f_Info.UserInfo) then
 begin
  PicturePanel.Height := UserPanel.Top + UserPanel.Height - PicturePanel.Top;
  UserPanel.Visible := false;
 end//if l3IsNil(l_String) then
 else
  UserInfoLabel.CCaption := f_Info.UserInfo;

 lblRight.CCaption := f_Info.Warning;

 l3IStream2Stream(f_Info.MakeLogoStream, l_Stream);
 try
  l_Comp := l_Stream.ReadComponent(nil);
  f_ilLogo := l_Comp as TvtNonFixedPngImageList;
 finally
  FreeAndNil(l_Stream);
 end;

 f_Flash := nil;
 l3IStream2Stream(f_Info.MakeSplashDataStream, l_Stream);
 try
  Image.LoadFromStream(l_Stream);
  if Image.IO.Aborting then
  // попытаемся прочитать SWF
  begin
   if nsMakeFlashActiveX(PicturePanel, True, f_Flash) then
   begin
    f_FlashPlayed := False;
    Image.Visible := false;
    l_Stream.Seek(0, soBeginning);
    f_Flash.LoadMovieFromStream(l_Stream);
    f_Flash.Loop := True;
    f_Flash.Stop;
    f_Flash.GotoFrame(0);
    f_Flash.OnError := FlashError;
    l_dX := Trunc(f_Flash.TGetPropertyAsNumber('/', 8)) - PicturePanel.ClientWidth;
    l_dY := Trunc(f_Flash.TGetPropertyAsNumber('/', 9)) - PicturePanel.ClientHeight;
    f_TotalFrames := f_Flash.TotalFrames;
    ActiveControl := f_Flash;
    f_Info.SwitchToParent;
    SetForegroundWindow(f_Flash.Handle);
   end
   else
   begin
    l_dX := 0;
    l_dY := -PicturePanel.ClientHeight;
   end;//if f_Flash <> nil then
  end//Image.IO.Aborting
  else
  begin
   l_dX := Image.IEBitmap.Width - PicturePanel.ClientWidth;
   l_dY := Image.IEBitmap.Height - PicturePanel.ClientHeight;
  end;//Image.IO.Aborting
 finally
  FreeAndNil(l_Stream);
 end;

 Left := Left - (l_dX div 2);
 Top := Top - (l_dY div 2);
 Width := Width + l_dX;
 Height := Height + l_dY;

 // Подправим высоту чтобы помещалась информация о пользователе
 if UserPanel.Visible and not l3IsNil(UserInfoLabel.CCaption) then
 begin
  // Дернуть TextPanel.ClientRect надо - иначе не совсем правильно определяется
  // высота текста...
  TextPanel.ClientRect;
  UserInfoLabel.AutoSize := True;
  l_Delta := UserInfoLabel.Height - TextPanel.Height;
  if l_Delta > 0 then
  begin
   l_LogoHeight := PicturePanel.Height;
   l_UserTop := UserPanel.Top;
   Height := Height + l_Delta;
   PicturePanel.Height := l_LogoHeight;
   UserPanel.Top := l_UserTop;
   UserPanel.Height := UserPanel.Height + l_Delta;
   TextPanel.Height := UserPanel.Height;
  end;
  UserInfoLabel.AutoSize := False;
  UserInfoLabel.SetBounds(0,0,TextPanel.Width,TextPanel.Height);
 end;

 Show;
end;

destructor Ten_SplashForm.Destroy;
begin
 FreeAndNil(f_ilLogo);
 if Assigned(f_Info) then
  f_Info.Waiter := nil;
 f_Info := nil;
 inherited Destroy;
end;

procedure Ten_SplashForm.SplashTimerTimer(Sender: TObject);
begin
 if (GetTickCount > f_Estimated) and not f_MinimalShowTimeEllapsed then
 begin
  f_MinimalShowTimeEllapsed := True;
  Close;
 end;
 if Assigned(f_Flash) and not f_FlashPlayed then
 begin
  f_Frame := f_Flash.CurrentFrame;
  if (f_Frame < f_PrevFrame) or (f_Frame = f_TotalFrames) or
     ((f_LastChanged <> 0) and (GetTickCount > f_LastChanged + 1000)) then
  begin
   f_FlashPlayed := True;
   Close;
  end;
  if f_PrevFrame <> f_Frame then
  begin
   f_LastChanged := GetTickCount;
  end;
  f_PrevFrame := f_Frame;
 end;
 if f_Finished and f_MinimalShowTimeEllapsed and f_FlashPlayed and (GetTickCount > f_LastTryToClose) then
  Close;
end;

procedure Ten_SplashForm.FormShow(Sender: TObject);
begin
 if f_MinimalShowTime = 0 then
  f_MinimalShowTimeEllapsed := True;
 f_Estimated := GetTickCount + f_MinimalShowTime;
 if Assigned(f_Flash) then
  f_Flash.Play;
 SplashTimer.Enabled := True;
end;

procedure Ten_SplashForm.FlashError(Sender: TObject);
begin
 f_Finished := True;
 f_MinimalShowTimeEllapsed := True;
 f_FlashPlayed := True;
 Close;
end;

procedure Ten_SplashForm.FormCreate(Sender: TObject);
begin
 Image.MouseWheelParams.Action := iemwNone;
end;

initialization
 RegisterClass(TvtNonFixedPngImageList);

end.