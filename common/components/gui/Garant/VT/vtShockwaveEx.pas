unit vtShockwaveEx;

////////////////////////////////////////////////////////////////////////////////
// Библиотека : VT.
// Назначение : Компонент для показа flash-ролика.
// Версия     : $Id: vtShockwaveEx.pas,v 1.50 2015/07/02 13:42:26 dinishev Exp $
////////////////////////////////////////////////////////////////////////////////

(*-------------------------------------------------------------------------------
  $Log: vtShockwaveEx.pas,v $
  Revision 1.50  2015/07/02 13:42:26  dinishev
  {Requestlink:602949503}

  Revision 1.49  2015/06/05 14:17:43  migel
  - change: работа с флешом, когда он не установлен в системе.

  Revision 1.48  2015/04/24 14:28:21  lulin
  - правильный include.

  Revision 1.47  2015/04/16 14:03:55  lulin
  - перерисовываем.

  Revision 1.46  2014/02/05 17:29:48  lulin
  - запускаем тесты сервера автоматизации.

  Revision 1.45  2013/10/02 11:38:09  morozov
  {RequestLink: 426675069}

  Revision 1.44  2012/11/01 09:42:28  lulin
  - забыл точку с запятой.

  Revision 1.43  2012/11/01 07:44:16  lulin
  - делаем возможность логирования процесса загрузки модулей.

  Revision 1.42  2012/02/07 10:49:46  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=335151860

  Revision 1.41  2012/01/30 09:47:22  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=331613120

  Revision 1.40  2012/01/18 09:15:58  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=266409753

  Revision 1.39  2012/01/17 12:28:35  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=266409753

  Revision 1.38  2012/01/13 11:35:39  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=266409753

  Revision 1.37  2012/01/12 08:48:52  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=266409753

  Revision 1.36  2012/01/11 13:08:22  gensnet
  http://mdp.garant.ru/pages/viewpage.action?pageId=266409753
  для проверки на молебоксенной оболочке

  Revision 1.35  2011/10/11 09:11:07  lulin
  {RequestLink:272666285}.

  Revision 1.34  2011/09/29 13:06:43  lulin
  {RequestLink:278854662}.

  Revision 1.33  2011/07/05 14:38:59  lulin
  {RequestLink:272666656}.

  Revision 1.32  2011/06/17 10:16:27  lulin
  {RequestLink:259892691}.

  Revision 1.31  2011/05/06 14:28:10  lulin
  - правим IfDef'ы.

  Revision 1.30  2010/07/05 10:50:38  oman
  - fix: {RequestLink:222758113}

  Revision 1.29  2010/07/05 10:00:29  oman
  - fix: {RequestLink:222758113}

  Revision 1.28  2009/11/16 13:00:48  migel
  - change: отключили фикс (не всегда работает как нужно).

  Revision 1.27  2009/11/12 13:44:33  migel
  - fix: избавляемся от проблемы черных квадратов (К: 146900520).

  Revision 1.26  2009/04/22 16:38:41  lulin
  [$145098206].

  Revision 1.25  2009/04/21 08:35:00  lulin
  [$124453728].

  Revision 1.24  2009/04/20 11:18:45  lulin
  [$142610585]. Читаем флеш не через кишочки, а через временный файл.

  Revision 1.23  2009/02/19 06:30:54  oman
  - fix: Сообщаем об ошибках отрисовки (К-136254180)

  Revision 1.22  2009/02/05 14:14:17  lulin
  - <K>: 136261219.

  Revision 1.21  2009/02/05 09:49:18  lulin
  - <K>: 128289358.

  Revision 1.20  2009/02/04 09:08:46  oman
  - fix: Порядок деинициализации (К-136258579)

  Revision 1.19  2009/02/02 13:52:04  oman
  Комментарий

  Revision 1.18  2009/02/02 12:20:36  oman
  - fix: Пытаемся цеплять самостийный ocx (К-136255443)

  Revision 1.17  2009/01/29 14:55:08  lulin
  - <K>: 136253229. Заготовка приложения. Меряем время.

  Revision 1.16  2009/01/29 12:26:34  lulin
  - для тестового приложения не подправляем данные.

  Revision 1.15  2009/01/29 12:14:37  lulin
  http://mdp.garant.ru/pages/viewpage.action?pageId=136253229&focusedCommentId=136254375#comment-136254375

  Revision 1.14  2009/01/29 11:59:44  lulin
  http://mdp.garant.ru/pages/viewpage.action?pageId=136253229&focusedCommentId=136254311#comment-136254311

  Revision 1.13  2009/01/28 16:23:33  lulin
  - не читаем размеры лишний раз.

  Revision 1.12  2008/12/17 14:53:42  lulin
  - <K>: 127767427.

  Revision 1.11  2008/12/15 12:26:53  lulin
  - <K>: 127771001.

  Revision 1.10  2008/10/06 13:31:07  lulin
  - чистка кода.

  Revision 1.9  2008/09/30 12:42:27  lulin
  - если ролик не масштабируется, то подгоняем под него размеры компонента <K>: 119472469.

  Revision 1.8  2008/09/25 08:26:10  oman
  - fix: Артефакты после загрузки (К-119472687)

  Revision 1.7  2008/09/12 07:46:40  oman
  - fix: Обрабатываем шорткаты до ActiveX (К-115344251)

  Revision 1.6  2008/08/21 09:32:10  mmorozov
  - new behaviour: проверяем результат при работе с методами потока, плюс свойство IsLoadFromStreamSupported (<K> - 108626065);

  Revision 1.5  2008/08/13 11:43:59  mmorozov
  - new: загрузка ролика по требованию (K<104432737>);

  Revision 1.4  2008/07/25 04:32:57  mmorozov
  - new: опубликован компонент для показа flash;

  Revision 1.3  2008/07/03 09:00:25  mmorozov
  - change: компонент flash переехал в библиотеку VT.

  Revision 1.2  2008/07/03 05:51:02  mmorozov
  - new: горячие клавиши во flash (K<97846208>).

  Revision 1.1  2008/07/03 05:21:05  mmorozov
  - new: местный компонента для работы с flash-роликом.

-------------------------------------------------------------------------------*)

{$Include vtDefine.inc}

interface

{$If not defined(NoFlash)}
uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  OleCtrls,
  ExtCtrls,  
  Forms,
  ActiveX
  {$IFNDEF VER130}
  , Types
  {$ENDIF},

  ShockwaveFlashObjects_TLB
  ;

type
 _afwShortcutsHandler_Parent_ = TShockwaveFlash;
 {$Include afwShortcutsHandler.imp.pas}
  TvtShockwaveFlashEx = class(_afwShortcutsHandler_)
  private
  // fields
    f_WasDown        : boolean;
    f_OleObject      : IOleObject;
    f_PaintCount     : Integer;
    f_IsLoadByRequest  : Boolean;
    f_NeedDropAlignOnLoad : Boolean;
    f_ReCreateWndTimer : TTimer;
    procedure pm_SetNeedDropAlignOnLoad(const Value: Boolean);
  private
  // events
    f_OnMouseDown          : TMouseEvent;
    f_OnMouseUp            : TMouseEvent;
    f_OnMouseMove          : TMouseMoveEvent;
    f_OnClick              : TNotifyEvent;
    f_OnLoadFlash          : TNotifyEvent;
    f_OnError              : TNotifyEvent;
    f_OnChangeFrameInFlash : TNotifyEvent;
  public
    LoadedWidth  : Integer;
    LoadedHeight : Integer;
  private
    f_Width  : Integer;
    f_Height : Integer;
    f_ParentResizeSet : Boolean;
  private
  // methods
    procedure DoOnChangeFrameInFlash;
     {* - Обработчик изменения фрейма из-за нажатия ссылки. }
    procedure DoOnLoadFlash;
      {* - вызвать событие загрузки ролика. }
    procedure CreateReCreateWndTimer;
      {* - создает и запускает таймер для вызова ReCreateWnd. }
    procedure DestroyReCreateWndTimer;
    procedure ReCreateWndWithTimer;
    procedure OnReCreateWndTimer(Sender: TObject);
    procedure ParentResize(aSender : TObject);
    procedure FitToParent;
    procedure CheckDimensions;
    procedure SetParent(AParent: TWinControl); override;
  private
  // messages
    procedure WMPaint(var Message: TWMPaint);
      message WM_Paint;
      {-}
  private
  // property methods
    function pm_GetIsLoadFromStreamSupported: Boolean;
      {* - определяет доступна ли загрузка из потока для установленной версии
           flash-а. }
  private
  // properties
    property IsLoadByRequest: Boolean
      read f_IsLoadByRequest
      write f_IsLoadByRequest;
      {* - определяет необходимость загрузки ролика по требованию. }
  protected
  // methods
    procedure WndProc(var Message:TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Click; override;
    procedure InitControlInterface(const Obj: IUnknown); override;
    procedure Resize; override;
  public
  // methods
    destructor Destroy; override;
    procedure LoadMovieFromStream(Src: TStream);
    procedure LoadByRequest;
     {* - загрузить ролик по требованию. }
  public
  // properties
    property IsLoadFromStreamSupported: Boolean
      read pm_GetIsLoadFromStreamSupported;
      {* - определяет доступна ли загрузка из потока для установленной версии
           flash-а. }
    property NeedDropAlignOnLoad: Boolean
      read f_NeedDropAlignOnLoad
      write pm_SetNeedDropAlignOnLoad;
  published
  // properties
    property OnMouseDown: TMouseEvent read f_OnMouseDown write f_OnMouseDown;
    property OnMouseUp: TMouseEvent read f_OnMouseUp write f_OnMouseUp;
    property OnMouseMove: TMouseMoveEvent read f_OnMouseMove write f_OnMouseMove;
    property OnClick: TNotifyEvent read f_OnClick write f_OnClick;
    property OnLoadFlash: TNotifyEvent read f_OnLoadFlash write f_OnLoadFlash;
      {* - событие загрузки flash, для загрузки по требованию. }
    property OnError: TNotifyEvent read f_OnError write f_OnError;
    property OnChangeFrameInFlash: TNotifyEvent read f_OnChangeFrameInFlash write f_OnChangeFrameInFlash;
  end;
{$IfEnd}

implementation

{$If not defined(NoFlash)}
uses
  ComObj,

  l3Base,
  l3MinMax,
  l3Stream,
  l3Types,
  l3FileUtils,

  // vtShockwaveFix,

  OvcConst,
  OvcBase,

  ZLib
  
  {$If not defined(NoScripts)}
  ,
  vtFlashWordsPack
  {$IfEnd} //not NoScripts
  ;

{$Include afwShortcutsHandler.imp.pas}  

var
 g_Handle: THandle = 0;
 g_Factory: IClassFactory = nil;

type
 TDLLGetClassObject = function (const CLSID, IID: TGUID; var Obj): HResult; stdcall;

 THackOleControl = class(TWinControl)
 private
    FControlData: PControlData;
    FRefCount: Longint;
    FEventDispatch: TEventDispatch;
    FObjectData: HGlobal;
    FOleObject: IOleObject;
 end;

procedure FreeFlash;
begin
 g_Factory := nil;
 if g_Handle <> 0 then
  FreeLibrary(g_Handle);
 g_Handle := 0;
end;

function GetFlashFactory: IClassFactory;
var
 l_Name: String;
 l_Proc: TDLLGetClassObject;
begin
 if g_Factory = nil then
 begin
  l_Name := ExtractFilePath(ParamStr(0))+'flash.ocx';
  if FileExists(l_Name) then
  begin
   g_Handle := LoadLibrary(PChar(l_Name));
   l_Proc := TDLLGetClassObject(GetProcAddress(g_Handle, 'DllGetClassObject'));
   if not Succeeded(l_Proc(CLASS_ShockwaveFlash, IClassFactory, g_Factory)) then
    g_Factory := nil;
  end;
 end;
 Result := g_Factory;
end;

procedure TvtShockwaveFlashEx.InitControlInterface(const Obj: IUnknown);
var
 l_Obj: IShockwaveFlash;
 l_OLE: IOLEObject;
 l_Factory: IClassFactory;
begin
  f_OleObject := Obj as IOleObject;
// ПРИ СМЕНЕ ВЕРСИИ ФЛЕША В ОБОЛОЧКЕ ПРОВЕРИТЬ СРАВНЕНИЕ FlashVersion
  if (Obj = nil) or (Supports(Obj, IShockwaveFlash, l_Obj) and (l_Obj.FlashVersion <> $90000)) then
  begin
// Если версия не устраивает
   l_Obj := nil;
   l_Factory := GetFlashFactory;
   if Assigned(l_Factory) then
   begin
    if Succeeded(l_Factory.CreateInstance(nil, IOLEObject, l_OLE)) then
    begin
// всхачили
     f_OleObject := l_OLE;
     THackOleControl(Self).FOleObject := l_OLE;
    end;
   end;
  end; 
end;

procedure TvtShockwaveFlashEx.LoadMovieFromStream(Src: TStream);
var
 l_F : Tl3FileStream;
 l_N : String;   
begin
 l_N := l3GetTempFileName('fl');
 l_F := Tl3FileStream.Create(l_N, l3_fmWrite);
 try
  l3CopyStream(Src, l_F);
 finally
  FreeAndNil(l_F);
 end;//try..finally
 LoadMovie(0, l_N);
 DeleteFile(l_N);
end;
(* var
   unCompress: TStream;
   Mem, Mem2: TMemoryStream;
   SRCSize: longint;
   PersistStream: IPersistStreamInit;
   SAdapt: TStreamAdapter;
   ISize: int64;
   B: byte;
   ASign: array [0..2] of char;
   isCompress: boolean;
   ZStream: TDeCompressionStream;

begin
  // prepare src movie
  Src.Read(ASign, 3);
  isCompress := ASign = 'CWS';
  if isCompress then
    begin
      unCompress := TMemoryStream.Create;
      ASign := 'FWS';
      unCompress.Write(ASign, 3);
      unCompress.CopyFrom(Src, 1); // version
      SRC.Read(SRCSize, 4);
      unCompress.Write(SRCSize, 4);
      ZStream := TDeCompressionStream.Create(Src);
      try
        unCompress.CopyFrom(ZStream, SRCSize - 8);
      finally
        ZStream.free;
      end;
      unCompress.Position := 0;
    end else
    begin
      Src.Position := Src.Position - 3;
      SRCSize := Src.Size - Src.Position;
      unCompress := Src;
    end;

  // store "template"
  EmbedMovie := false;
  f_OleObject.QueryInterface(IPersistStreamInit, PersistStream);
  OleCheck(PersistStream.GetSizeMax(ISize));
  Mem := TMemoryStream.Create;
  Mem.SetSize(ISize);
  SAdapt := TStreamAdapter.Create(Mem);
  OleCheck(PersistStream.Save(SAdapt, true));
  SAdapt.Free;

  // insetr movie to "template"
  Mem.Position := 1;
  Mem2 := TMemoryStream.Create;
  B := $66; // magic flag: "f" - embed swf; "g" - without swf;
  Mem2.Write(B, 1);
  Mem2.CopyFrom(Mem, 3);
  Mem2.Write(SRCSize, 4);
  Mem2.CopyFrom(unCompress, SRCSize);
  Mem2.CopyFrom(Mem, Mem.Size - Mem.Position);

  // load activeX data
  Mem2.Position := 0;
  SAdapt := TStreamAdapter.Create(Mem2);
  OleCheck(PersistStream.Load(SAdapt));
  SAdapt.Free;

  // free all
  Mem2.Free;
  Mem.Free;
  PersistStream := nil;
  if isCompress then
   unCompress.Free;
end;*)

procedure TvtShockwaveFlashEx.WMPaint(var Message: TWMPaint);
  //message WM_Paint;
  {-}
var
 PS: TPaintStruct;
begin
 if IsLoadByRequest then
 begin
(*  BeginPaint(Handle, PS);
  EndPaint(Handle, PS);*)
  inherited;
  DoOnLoadFlash;
  Invalidate;
 end
 else
 try
  Inc(f_PaintCount);
  try
   if (f_PaintCount > 1) then
    Exit;
   Assert(f_PaintCount = 1);
   inherited;
  finally
   Dec(f_PaintCount);
  end;//try..finally
 except
   // - ловим все исключения
  if Assigned(f_OnError) then
   f_OnError(Self);
 end;//try..except
end;

procedure TvtShockwaveFlashEx.WndProc(var Message: TMessage);
var
 x,y        : Integer;
 xy         : TPoint;
 ShiftState : TShiftState;//cga
 l_CF       : Integer;
begin
  if (Message.Msg >= WM_MOUSEFIRST) and (Message.Msg <= WM_MOUSELAST) then
  begin
   if (Message.Msg <> WM_MOUSEWHEEL) then
   begin
    if not (csDesigning in ComponentState) then
    begin
     l_CF := CurrentFrame;
     try
      ShiftState:=KeysToShiftState(TWMMouse(Message).Keys);//cga
      x:=TSmallPoint(Message.LParam).x;
      y:=TSmallPoint(Message.LParam).y;
      case Message.Msg of
        CM_MOUSELEAVE: f_WasDown:=false;
        WM_LBUTTONDOWN:
        begin
          MouseDown(mbLeft,ShiftState,x,y);
          f_WasDown:=true;
        end;
        WM_RBUTTONDOWN: f_WasDown:=true;
        WM_RBUTTONUP:
        if (PopupMenu<>nil) and (f_WasDown) then begin
          f_WasDown:=false;
          xy.X:=x;
          xy.Y:=y;
          xy:=ClientToScreen(xy);
          PopupMenu.Popup(xy.X,xy.Y);
        end;
        WM_LBUTTONUP:
        begin
          MouseUp(mbLeft,ShiftState,x,y);
          f_WasDown:=false;
        end;
        WM_MOUSEMOVE: MouseMove(ShiftState,x,y);
      end;
      //
      if (((Message.Msg=WM_RBUTTONDOWN) or
           (Message.Msg=WM_RBUTTONUP)) and not Menu) then
        Message.Result := 0
      else
        inherited WndProc(Message);
      Exit;
     finally
      if (l_CF <> CurrentFrame) then
      begin
       CheckDimensions;
       DoOnChangeFrameInFlash;
      end;
     end;//try..finally
    end;//not (csDesigning in ComponentState)
   end//Message.Msg <> WM_MOUSEWHEEL
   else
   begin
    if not (csDesigning in ComponentState) then
    begin
     if (Parent <> nil) then
     begin
      // Транслировать событие родителю - не получается, поэтому приравниваем
      // его к скроллированию
      if (TWMMouseWheel(Message).WheelDelta < 0) then
      begin
       Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
       Parent.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      end//TWMMouseWheel(Message).WheelDelta < 0
      else
      if (TWMMouseWheel(Message).WheelDelta > 0) then
      begin
       Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
       Parent.Perform(WM_VSCROLL, SB_LINEUP, 0);
      end;//TWMMouseWheel(Message).WheelDelta > 0
      Exit;
     end;//Parent <> nil
    end;//not (csDesigning in ComponentState)
   end;//Message.Msg <> WM_MOUSEWHEEL
  end;//Message.Msg >= WM_MOUSEFIRST
  inherited WndProc(Message);
end;

procedure TvtShockwaveFlashEx.MouseDown(Button: TMouseButton; Shift:
TShiftState; X, Y: Integer);
begin
  if Assigned(f_OnMouseDown) then
    begin
      f_OnMouseDown(Self, Button, Shift, X, Y);
    end;
end;

procedure TvtShockwaveFlashEx.MouseUp(Button: TMouseButton; Shift:
TShiftState; X, Y: Integer);
begin
  if Assigned(f_OnMouseUp) then
    begin
      f_OnMouseUp(Self, Button, Shift, X, Y);
    end;
  if f_WasDown Then Click;
end;

procedure TvtShockwaveFlashEx.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(f_OnMouseMove) then f_OnMouseMove(Self, Shift, X, Y);
end;

procedure TvtShockwaveFlashEx.Click;
begin
  if Assigned(f_OnClick) then f_OnClick(Self);
end;

procedure TvtShockwaveFlashEx.Resize;
begin
 inherited;

 // http://mdp.garant.ru/pages/viewpage.action?pageId=266409753
 // not IsLoadByRequest - т.к. на х64 может падать при Resize, который происходит еще до DoOnLoadFlash
 if not IsLoadByRequest then ReCreateWndWithTimer;
end;

procedure TvtShockwaveFlashEx.ReCreateWndWithTimer;
begin
 DestroyReCreateWndTimer;
 try
  ReCreateWnd;
 except
  // может случиться на x64 системе - http://mdp.garant.ru/pages/viewpage.action?pageId=266409753
  on EOleError do CreateReCreateWndTimer;
 end;
end;

procedure TvtShockwaveFlashEx.CreateReCreateWndTimer;
begin
 f_ReCreateWndTimer := TTimer.Create(nil);
 f_ReCreateWndTimer.Enabled := false;
 try
  f_ReCreateWndTimer.OnTimer := OnReCreateWndTimer;
  f_ReCreateWndTimer.Interval := 200;
 finally
  f_ReCreateWndTimer.Enabled := true;
 end;//try..finally
end;

procedure TvtShockwaveFlashEx.OnReCreateWndTimer(Sender: TObject);
begin
 ReCreateWndWithTimer;
end;

procedure TvtShockwaveFlashEx.DestroyReCreateWndTimer;
begin
 if f_ReCreateWndTimer <> nil then
 begin
  l3Free(f_ReCreateWndTimer);
  f_ReCreateWndTimer := nil;
 end;
end;

destructor TvtShockwaveFlashEx.Destroy;
begin
 DestroyReCreateWndTimer;
 inherited Destroy;
end;

procedure TvtShockwaveFlashEx.DoOnLoadFlash;
begin
 IsLoadByRequest := False;
 ReCreateWndWithTimer; // http://mdp.garant.ru/pages/viewpage.action?pageId=331613120
 if Assigned(f_OnLoadFlash) then
 begin
  f_Height := 0;      // http://mdp.garant.ru/pages/viewpage.action?pageId=335151860
  f_OnLoadFlash(Self);
  CheckDimensions;
 end;//Assigned(f_OnLoadFlash)
end;

procedure TvtShockwaveFlashEx.ParentResize(aSender : TObject);
begin
 FitToParent;
end;

type
  THackWinControl = class(TWinControl)
  end;//THackWinControl

procedure TvtShockwaveFlashEx.FitToParent;
begin
 Assert(Parent <> nil);
 if (Parent = nil) then
  Exit;
(*    if (f_Width > Parent.Width) OR (f_Height > Parent.Height) then*)
 begin
  Align := alNone;
  if (f_Width > Parent.Width) then
  begin
   Left := 0;
   Width := f_Width;
  end//f_Width > Parent.Width
  else
  begin
   Left := (Parent.Width - f_Width) div 2;
   //Width := Parent.Width;
   Width := f_Width;
  end;//f_Width > Parent.Width
  if true
  // http://mdp.garant.ru/pages/viewpage.action?pageId=272666285
     {(f_Height > Parent.Height)}
     then
  begin
   Top := 0;
   //http://mdp.garant.ru/pages/viewpage.action?pageId=426675069
   if (f_Height > Parent.Height) or (f_Height > Height) then
    Height := f_Height;
  end//f_Height > Parent.Height
  else
  begin
   Top := (Parent.Height - f_Height) div 2;
   //Height := Parent.Height;
   Height := f_Height
  end;//f_Height > Parent.Height
 end//f_Width > Parent.Width
(*    else
  Align := alClient*);
end;

procedure TvtShockwaveFlashEx.CheckDimensions;
var
 l_LoadedOrParentHeight: Integer;
begin
 if (ScaleMode = 3) AND ((Align <> alClient) or NeedDropAlignOnLoad) then
 begin
(*   Width := Trunc(TGetPropertyAsNumber('_root', 8));
  Height := Trunc(TGetPropertyAsNumber('_root', 9));*)
(*   Width := Max(1024, Trunc(TGetPropertyAsNumber('/', 8)));
  Height := Max(768, Trunc(TGetPropertyAsNumber('/', 9)));*)
  LoadedWidth := Trunc(TGetPropertyAsNumber('/', 8));
  LoadedHeight := Trunc(TGetPropertyAsNumber('/', 9));
  {$If Defined(nsTest) AND not Defined(InsiderTest)}
  f_Width := LoadedWidth;
  f_Height := LoadedHeight;
  {$Else}
  f_Width := Min(5000, LoadedWidth);

  // Может так получиться, что LoadedHeight посчитана неправильно и схема
  // не влезет по высоте
  // http://mdp.garant.ru/pages/viewpage.action?pageId=426675069
  l_LoadedOrParentHeight := Max(Parent.Height, LoadedHeight);
  // используем максимальную высоту из всех открытых фреймов, чтобы не было
  // http://mdp.garant.ru/pages/viewpage.action?pageId=335151860
  f_Height := Max(f_Height, Min(5000, (*LoadedHeight*)l_LoadedOrParentHeight));
  {$IfEnd}
  if (AlignMode = 5) then
   AlignMode := 15;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=278854662&focusedCommentId=288788048#comment-288788048
  if NeedDropAlignOnLoad then
  begin
   NeedDropAlignOnLoad := false;
   if (AlignMode <> 15) then
    Align := alNone;
  end;//NeedDropAlignOnLoad
  if (f_Width <> Width) OR (f_Height <> Height) then
  begin
   if (AlignMode = 15) then
   begin
    if (Parent = nil) then
     Exit;
    f_ParentResizeSet := true;
    THackWinControl(Parent).OnResize := ParentResize;
    FitToParent;
   end//AlignMode = 15
   else
   begin
    if (Parent <> nil) then
    begin
     Parent.Perform(WM_VSCROLL, SB_TOP, 0);
     Parent.Perform(WM_HSCROLL, SB_TOP, 0);
    end;//Parent <> nil
    Width := f_Width;
    Height := f_Height;
   end;//AlignMode = 15
  end;//f_Width <> Width
 end;//ScaleMode = 3..
end;

procedure TvtShockwaveFlashEx.SetParent(AParent: TWinControl);
begin
 if f_ParentResizeSet then
 begin
  if (Parent <> nil) then
   THackWinControl(Parent).OnResize := nil;
  f_ParentResizeSet := false; 
  inherited;
  if (Parent <> nil) then
  begin
   THackWinControl(Parent).OnResize := ParentResize;
   f_ParentResizeSet := true;
  end;//Parent <> nil
 end//AlignMode = 15
 else
  inherited;
end;

procedure TvtShockwaveFlashEx.LoadByRequest;
begin
 IsLoadByRequest := True;
 Invalidate;
end;

function TvtShockwaveFlashEx.pm_GetIsLoadFromStreamSupported: Boolean;
(*var
 l_Stream : IPersistStreamInit;
 l_Size   : Int64;
 l_Error  : HResult;*)
begin
 Result := true;
(* if Supports(f_OleObject, IPersistStreamInit, l_Stream) then
 begin
  l_Error := l_Stream.GetSizeMax(l_Size);
  Result := l_Error = S_OK;
  // Загрузка из потока может не поддерживаться установленной версией ActiveX,
  // про другие ошибки сообщим:
  if not Result and (l_Error <> E_NOTIMPL) then
   OleCheck(l_Error);
 end
 else
  Result := False;*)
end;

procedure TvtShockwaveFlashEx.pm_SetNeedDropAlignOnLoad(
  const Value: Boolean);
begin
 if (f_NeedDropAlignOnLoad <> Value) then
 begin
  f_NeedDropAlignOnLoad := Value;
  if NeedDropAlignOnLoad then
   ParentColor := True;
 end;//f_NeedDropAlignOnLoad <> Value
end;

type
  PCoCreateInstance = ^TCoCreateInstance;
  TCoCreateInstance = function(const clsid: TCLSID; unkOuter: IUnknown; dwClsContext: Longint; const iid: TIID; out pv): HResult; stdcall;
var
  g_CoCreateInstance: TCoCreateInstance = nil;

function CoCreateInstanceHook(const clsid: TCLSID; unkOuter: IUnknown; dwClsContext: Longint; const iid: TIID; out pv): HResult; stdcall;
var
  l_FlashFactory: IClassFactory;
  l_OLEObject: IOLEObject;
begin
  Result := g_CoCreateInstance(clsid, unkOuter, dwClsContext, iid, pv);
  if ((Result <> S_OK) and IsEqualCLSID(clsid, CLASS_ShockwaveFlash)) then
  begin
    l_FlashFactory := GetFlashFactory;
    if (Assigned(l_FlashFactory) and Succeeded(l_FlashFactory.CreateInstance(nil, IOLEObject, l_OLEObject))) then
    begin
      IOLEObject(pv) := l_OLEObject;
      Result := S_OK;
    end;
  end;
end;

procedure SetCoCreateInstanceHook;
var
  l_Pointer: PAnsiChar;
  l_Protect: DWORD;
begin
  l_Pointer := @CoCreateInstance;
  if (l_Pointer^ = AnsiChar($FF)) then
  begin
    Inc(l_Pointer);
    if (l_Pointer^ = AnsiChar($25)) then
    begin
      l_Pointer := PPointer(l_Pointer+1)^;
      g_CoCreateInstance := PCoCreateInstance (l_Pointer)^;
      VirtualProtect(l_Pointer, Sizeof(l_Pointer), PAGE_READWRITE, l_Protect);
      try
        PCoCreateInstance(l_Pointer)^ := @CoCreateInstanceHook;
      finally
        VirtualProtect(l_Pointer, Sizeof(l_Pointer), l_Protect, l_Protect);
      end;
    end;
  end;
end;

procedure TvtShockwaveFlashEx.DoOnChangeFrameInFlash;
begin
 if Assigned(f_OnChangeFrameInFlash) then
  f_OnChangeFrameInFlash(Self);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtShockwaveEx.pas initialization enter'); {$EndIf}
  SetCoCreateInstanceHook; // поддерживаем загрузку для "flash.ocx" напрямую
  l3System.AddExitProc(FreeFlash);
  RegisterClass(TvtShockwaveFlashEx);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtShockwaveEx.pas initialization leave'); {$EndIf}
finalization
  UnRegisterClass(TvtShockwaveFlashEx);
{$IfEnd}

end.
