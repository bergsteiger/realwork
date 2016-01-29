{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnImgScr
|
| Description: Image scroll box component
|
| History: May 15, 1999. Michel Brazeau, first version
|          Aug 30, 1999. Michel Brazeau allow loading images derived
|                        directly from TGraphic rather than TDibGraphic
|          Oct   , 1999. Michel Brazeau, add MouseMode property and
|                        TMouseHandler classes
|
|---------------------------------------------------------------------------}
unit EnImgScr;

{$I Envision.Inc}

interface

uses
    Windows,  { for LoadCursor, TPoint }
    Messages, { for TWMSize }
    StdCtrls, { for TScrollBar }
    Classes,  { for TComponent }
    Controls, { for TMouseButton }
    EnDiGrph, { for TDibGraphic, NewDibGraphic }
    EnTransf, { for TResizeTransform }
    ExtCtrls, { for TImage }
    Graphics, { for TGraphic }
    Forms;    { for TScrollingWinControl }

type

TImageScrollBox = class;

TZoomChangeEvent = procedure( const Sender  : TImageScrollBox;
                              const Zoom    : Single ) of object;

TBeforeSaveEvent = procedure( const Sender  : TImageScrollBox;
                              const Graphic : TDibGraphic ) of object;

TRedrawEvent = procedure( const Graphic : TDibGraphic ) of object;

TZoomMode = ( zmOriginalSize,
              zmFullPage,
              zmFitWidth,
              zmFitHeight,
              zmPercent );

TMouseMode = ( mmDrag, mmQuickSelect, mmUser );

TQuickSelectEvent = procedure( const Sender  : TImageScrollBox;
                               const Graphic : TDibGraphic ) of object;

TMouseHandler = class;

TImageScrollBox = class(TScrollingWinControl)
protected

    FImage               : TImage;

    FSourceGraphic       : TDibGraphic;
    FResizedBWGraphic    : TDibGraphic;
    FAntiAliasedGraphic  : TDibGraphic;
    FResizeTransform     : TResizeTransform;
    FAntiAliasTransform  : TAntiAliasTransform;

    FMouseHandler        : TMouseHandler;
    FMouseMode           : TMouseMode;
    FOnQuickSelect       : TQuickSelectEvent;

    FZoomMode            : TZoomMode;
    FZoomPercent         : Single;

    FAntiAliased         : Boolean;

    FOnZoomChange        : TZoomChangeEvent;

    FOnBeforeSave        : TBeforeSaveEvent;

    FOnRedraw            : TRedrawEvent;

    FAnimated            : Boolean;

    FAnimationTimer      : TTimer;

    FFileName            : String;

    FCentered            : Boolean;

    procedure AnimateTimer( Sender : TObject );

    procedure OnMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure SetZoomMode( const InZoomMode : TZoomMode );
    procedure SetZoomPercent( const InPercent : Single );

    function GetGraphic : TDibGraphic;
    procedure SetGraphic( const InGraphic : TDibGraphic );

    procedure SetAntiAliased( const InAntiAliased : Boolean );

    { MB Aug 18, 1999. Resize is not virtual in Delphi 3, so the
     a message handler for WM_SIZE is used instead }
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

    function GetFrameCount : LongInt;
    function GetFrame(FrameNo : LongInt) : TDibGraphic;

    function GetCurrentFrame : LongInt;
    procedure SetCurrentFrame( const FrameNo : LongInt );

    function GetAnimated : Boolean;
    procedure SetAnimated( const InAnimated : Boolean );

    procedure SetMouseMode( const InMouseMode : TMouseMode );

    procedure RedrawBW;
    procedure RedrawNotBW;

    procedure CenterImage( const NewWidth  : LongInt;
                           const NewHeight : LongInt );

    { recalcuate FZoomPercent from the current zoom mode }
    procedure RecalcZoom;

    procedure SetFileName( const FileName : String );

    procedure SetCentered( const InCentered : Boolean );

    procedure SetMouseHandler( const MouseHandler : TMouseHandler );

public

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    { returns the number of images in a file. Useful to determinte the
      number of images in multi-image files such as TIFF. For single
      image file formats, 1 is returned. }
    function ImageCountFromFile( const FileName : String ) : LongInt;

    { see ImageCountFromFile }
    function ImageCountFromStream( const Stream    : TStream;
                                   const Extension : String ) : LongInt;

    { Load an image from a file. ImageNo must be 1 for single image file
      formats. For multiple image file formats (such as TIFF), ImageNo
      specifies the image to load. If ImageNo is 0, all images are loaded
      into memory and they are accessed with the CurrentFrame, and
      FrameCount properties. }
    procedure LoadFromFile( const FileName : String;
                            const ImageNo  : LongInt );

    { see LoadFromFile description }
    procedure LoadFromStream( const Stream    : TStream;
                              const Extension : String;
                              const ImageNo   : LongInt );

    { save the currently displayed image to FileName in the format
      specified by the extension of FileName. To save a multi-image file such as
      TIFF, use AppendToFile/AppendToStream }
    procedure SaveToFile( const FileName  : String );

    { see SaveToFile description }
    procedure SaveToStream( const Stream    : TStream;
                            const Extension : String );

    { append the current displayed image to FileName. FileName must be
      a multi-image file format such as TIFF. }
    procedure AppendToFile( const FileName  : String );

    procedure AppendToStream( const Stream    : TStream;
                              const Extension : String );

    { clear the image in the scroll box }
    procedure Clear;

    property Graphic : TDibGraphic read GetGraphic
                                   write SetGraphic;

    procedure Redraw( const GraphicChanged : Boolean ); dynamic;

    property FrameCount : LongInt read GetFrameCount;
    property Frames[FrameNo: LongInt] : TDibGraphic read GetFrame;
    property CurrentFrame : LongInt read GetCurrentFrame
                                    write SetCurrentFrame;

    { if the image was loaded with ImageNo = 0, and the format is a multi-image
      format, setting Animated to True will animate the display of the
      images. }
    property Animated : Boolean read GetAnimated
                                write SetAnimated
                                default False;

    property MouseMode : TMouseMode read FMouseMode
                                    write SetMouseMode;

    { When setting the MouseHandler, the image scroll box becomes the
      owner of the object. The user must not free the object after it
      assigned to the MouseHandler property. This must be assigned a value
      only after setting the mouse mode to mmUser. }
    property MouseHandler : TMouseHandler read FMouseHandler
                                          write SetMouseHandler;

published

    property FileName : String read FFileName
                               write SetFileName;


    property AntiAliased : Boolean read FAntiAliased
                                   write SetAntiAliased
                                   default False;

    property ZoomMode : TZoomMode read FZoomMode
                                  write SetZoomMode
                                  default zmOriginalSize;

    property ZoomPercent : Single read FZoomPercent
                                  write SetZoomPercent;

    { if Centered is True, the image will be drawn in the center of the scroll }
    property Centered : Boolean read FCentered
                                write SetCentered
                                default False;

    property OnZoomChange : TZoomChangeEvent read FOnZoomChange
                                             write FOnZoomChange;

    property OnBeforeSave : TBeforeSaveEvent read FOnBeforeSave
                                             write FOnBeforeSave;

    property OnRedraw : TRedrawEvent read FOnRedraw
                                     write FOnRedraw;

    property OnQuickSelect : TQuickSelectEvent read FOnQuickSelect
                                               write FOnQuickSelect;

    property Align;
    {$ifdef __Delphi4AndAbove}
    property Anchors;
    property DockSite;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$endif}
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color nodefault;
    property Ctl3D;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

end;

{--------------------------------------------------------------------------}

TMouseHandler = class(TObject)
protected
    FImageScrollBox : TImageScrollBox;
    FMouseIsDown    : Boolean;

public
    constructor Create( const InImageScrollBox : TImageScrollBox );
    procedure MouseDown( const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer ); virtual;
    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); virtual;

    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); virtual;

    property ImageScrollBox : TImageScrollBox read FImageScrollBox;
end;

{--------------------------------------------------------------------------}

TDragMouseHandler = class(TMouseHandler)
protected
    FScreenCursor        : TCursor;
    FStartMousePos       : TPoint;
    FStartScrollPos      : TPoint;
public
    constructor Create( const InImageScrollBox : TImageScrollBox );
    procedure MouseDown( const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer ); override;
    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); override;

    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); override;
end;

{--------------------------------------------------------------------------}

TQuickSelectMouseHandler = class(TMouseHandler)
protected
    FX1               : Integer;
    FY1               : Integer;
    FX2               : Integer;
    FY2               : Integer;

    FCanvas           : TCanvas;

    procedure BoundXY( var X, Y : Integer );

    procedure DrawBand;
    procedure RemoveBand;
    procedure DrawXORBand;

public
    constructor Create( const InImageScrollBox : TImageScrollBox );
    destructor Destroy; override;
    procedure MouseDown( const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer ); override;
    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); override;

    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); override;
end;

{--------------------------------------------------------------------------}

implementation

{$R EnImgScr.R32}

uses
    SysUtils, { for fmOpenRead }
    ExtDlgs,  { for TOpenPictureDialog }
    Dialogs,  { for ofPathMustExist, ... }
    EnMsg,    { for msgXXXX }
    EnMisc;   { for BoundInteger }

const

crHandOpened  = 100;
crHandClosed  = 101;

{--------------------------------------------------------------------------}

constructor TImageScrollBox.Create(AOwner : TComponent);
var
    Graphic : TDibGraphic;
begin
    inherited Create(AOwner);

    { MB Sep 08, 1999. Set default size useful when dropped on a form at
      design time } 
    Self.Width  := 100;
    Self.Height := 100;

    Self.AutoScroll := False;

    Self.HorzScrollBar.Tracking := True;
    Self.VertScrollBar.Tracking := True;

    FImage                  := TImage.Create(Self);
    FImage.Parent           := Self;
    FImage.Visible          := False;
    FImage.Left             := 0;
    FImage.Top              := 0;
    FImage.Stretch          := False;

    { MB Sep 25, 1999. Free the assigned graphic as a copy is created. }
    Graphic := TDibGraphic.Create;
    try
        FImage.Picture.Graphic  := Graphic;
    finally
        Graphic.Free;
    end;

    FSourceGraphic          := TDibGraphic.Create;
    FResizedBWGraphic       := TDibGraphic.Create;
    FAntiAliasedGraphic     := TDibGraphic.Create;

    FResizeTransform        := TResizeTransform.Create;
    FAntiAliasTransform     := TAntiAliasTransform.Create;

    FAnimated               := False;
    FAnimationTimer         := TTimer.Create(Self);
    FAnimationTimer.OnTimer := AnimateTimer;
    FAnimationTimer.Enabled := False;

    FMouseMode              := mmUser;
    MouseMode               := mmDrag;

    FImage.OnMouseDown := Self.OnMouseDown;
    FImage.OnMouseMove := Self.OnMouseMove;
    FImage.OnMouseUp   := Self.OnMouseUp;

    FZoomMode          := zmOriginalSize;
    FZoomPercent       := 100;

    FAntiAliased       := False;

    FCentered          := False;
end;

{--------------------------------------------------------------------------}

destructor TImageScrollBox.Destroy;
begin
    FAnimationTimer.Enabled := False;

    FMouseHandler.Free;

    FAntiAliasTransform.Free;
    FResizeTransform.Free;
    FResizedBWGraphic.Free;
    FAntiAliasedGraphic.Free;
    
    { MB Sep 25, 1999. Fix memory leak }
    FSourceGraphic.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.ImageCountFromFile( const FileName : String ) : LongInt;
var
    Stream : TFileStream;
begin
    Stream  := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
        Result := ImageCountFromStream(Stream, FileName);
    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.ImageCountFromStream( const Stream    : TStream;
                                               const Extension : String ) : LongInt;
var
    TempGraphic : TDibGraphic;
begin
    if FindDibGraphicClass(Extension) = nil then
        Result := 1
    else
    begin
        TempGraphic := NewDibGraphic(Extension);
        try
            Result := TempGraphic.GetImageCount(Stream);
        finally
            TempGraphic.Free;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.LoadFromFile( const FileName : String;
                                        const ImageNo  : LongInt );
var
    Stream      : TFileStream;
    WasAnimated : Boolean;
begin
    WasAnimated := Self.Animated;
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
        if WasAnimated then
            Self.Animated := False;

        LoadFromStream(Stream, FileName, ImageNo);
    finally
        Stream.Free;

        if WasAnimated then
            Self.Animated := True;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.LoadFromStream( const Stream    : TStream;
                                          const Extension : String;
                                          const ImageNo   : LongInt );
var
    DibGraphic : TDibGraphic;

    procedure LoadDibGraphic;
    begin
        DibGraphic := NewDibGraphic(Extension);
        try
            if ImageNo = 0 then
                DibGraphic.MultiLoad   := True
            else
                DibGraphic.ImageToLoad := ImageNo;

            DibGraphic.LoadFromStream(Stream);
        except
            DibGraphic.Free;
            raise;
        end;
    end;

    procedure LoadGraphic;
    var
        Picture    : TPicture;
        FileStream : TFileStream;
        FileName   : String;
    begin
        { The VCL does not have any routine to obtain a TGraphicClass from
          a file name (?!) so a TPicture is used to load the graphic from
          a temporary file. }
        Picture := TPicture.Create;
        try
            { Extension may be the actual file when this method is called
              from LoadFromFile. This prevents creating a temporary file. }
            FileName := Extension;
            if not FileExists(FileName) then
            begin
                FileName := GetTempFileName('En', Extension);
                FileStream := TFileStream.Create(FileName, fmCreate);
                try
                    FileStream.CopyFrom(Stream, Stream.Size);
                finally
                    FileStream.Free;
                end;
            end;

            try
                { MB Nov 07, 1999. Under Delphi 3, when testing with Anders
                  Melander's TGifImage, an exception is raised, EFOpenError, unable
                  to open file "...". With Delphi 4 and 5, this works fine.
                  I'm not sure if this is a problem TGifImage or the VCL
                  itself.  }
                Picture.LoadFromFile(FileName);

                DibGraphic := TDibGraphic.Create;
                DibGraphic.Assign(Picture.Graphic);

            finally
                if FileName <> Extension then
                    DeleteFile(FileName);
            end;

        finally
            Picture.Free;
        end;
    end;

begin
    if FindDibGraphicClass(Extension) = nil then
        LoadGraphic
    else
        LoadDibGraphic;

    FSourceGraphic.Free;
    FSourceGraphic := DibGraphic;

    Redraw(True);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SaveToFile( const FileName  : String );
var
    Stream : TFileStream;
begin
    Stream := TFileStream.Create(FileName, fmCreate);
    try
        SaveToStream(Stream, ExtractFileExt(FileName));

        FFileName := FileName;

    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SaveToStream( const Stream    : TStream;
                                        const Extension : String );
var
    TempGraphic    : TDibGraphic;
begin
    TempGraphic := NewDibGraphic(Extension);
    if TempGraphic = nil then
        raise EEnvisionError.Create(Format(msgFileFormatNotSupported, [Extension]));

    BeginHourglass;
    try
        TempGraphic.Assign(FSourceGraphic);

        if Assigned(FOnBeforeSave) then
            FOnBeforeSave(Self, TempGraphic);

        TempGraphic.SaveToStream(Stream);
    finally
        EndHourglass;
        TempGraphic.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AppendToFile( const FileName  : String );
var
    Stream : TFileStream;
begin
    Stream := TFileStream.Create(FileName, fmOpenReadWrite);
    try
        AppendToStream(Stream, ExtractFileExt(FileName));
    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AppendToStream( const Stream    : TStream;
                                          const Extension : String );
var
    TempGraphic    : TDibGraphic;
begin
    TempGraphic := NewDibGraphic(Extension);
    if TempGraphic = nil then
        raise EEnvisionError.Create(Format(msgFileFormatNotSupported, [Extension]));

    BeginHourglass;
    try
        TempGraphic.Assign(FSourceGraphic);

        if Assigned(FOnBeforeSave) then
            FOnBeforeSave(Self, TempGraphic);

        TempGraphic.AppendToStream(Stream);
    finally
        EndHourglass;
        TempGraphic.Free;
    end;
end;


{--------------------------------------------------------------------------}

procedure TImageScrollBox.Clear;
begin
    FSourceGraphic.Clear;
    FFileName := '';

    Redraw(True);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AnimateTimer( Sender : TObject );
begin
    if FrameCount <= 1 then
        Exit;

    FAnimationTimer.Enabled := False;
    try
        if CurrentFrame = FrameCount then
            CurrentFrame := 1
        else
            CurrentFrame := CurrentFrame + 1;
    finally
        FAnimationTimer.Interval := FSourceGraphic.ImageDelay;
        FAnimationTimer.Enabled  := True;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.WMSize(var Message : TWMSize);
begin
    inherited;

    Redraw(False);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetGraphic( const InGraphic : TDibGraphic );
begin
    FSourceGraphic.Assign(InGraphic);

    Redraw(True);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetAntiAliased( const InAntiAliased : Boolean );
begin
    if FAntiAliased = InAntiAliased then
        Exit;

    FAntiAliased := InAntiAliased;

    if FSourceGraphic.ImageFormat = ifBlackWhite then
        Redraw(False);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetFileName( const FileName : String );
begin
    FFileName := FileName;

    if FileName <> '' then
        LoadFromFile(FileName, 1)
    else
    begin
        FSourceGraphic.Clear;
        Redraw(True);
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetCentered( const InCentered : Boolean );
begin
    if InCentered <> FCentered then
    begin
        FCentered := InCentered;
        Redraw(False);
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetMouseMode( const InMouseMode : TMouseMode );
begin
    if FMouseMode = InMouseMode then
        Exit;

    case InMouseMode of

        mmDrag        : SetMouseHandler(TDragMouseHandler.Create(Self));

        mmQuickSelect : SetMouseHandler(TQuickSelectMouseHandler.Create(Self));

        else
        begin
            FMouseHandler.Free;
            FMouseHandler := nil;
            FImage.Cursor := crDefault;
        end;
    end; { case }

    FMouseMode := InMouseMode;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetMouseHandler( const MouseHandler : TMouseHandler );
begin
    FMouseHandler.Free;
    FMouseHandler := MouseHandler;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.OnMouseDown(
         Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseDown(Button, Shift, X, Y);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseMove(Shift, X, Y);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.OnMouseUp(
                 Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseUp(Button, Shift, X, Y);
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetGraphic : TDibGraphic;
begin
    Result := FSourceGraphic;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetZoomMode( const InZoomMode : TZoomMode );
begin
    FZoomMode := InZoomMode;

    Redraw(False);
end;

{--------------------------------------------------------------------------}
procedure TImageScrollBox.SetZoomPercent( const InPercent : Single );
begin
    if FSourceGraphic.IsEmpty or (InPercent <= 0.1) then
        Exit;

    FZoomPercent  := InPercent;
    FZoomMode     := zmPercent;

    Redraw(False);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.RecalcZoom;
var
    XFactor  : Single;
    YFactor  : Single;

begin
    case FZoomMode of
        zmFullPage :
        begin
            Self.VertScrollBar.Visible := False;
            XFactor := Self.ClientWidth / (FSourceGraphic.Width*1.0);

            Self.HorzScrollBar.Visible := False;
            YFactor := Self.ClientHeight / (FSourceGraphic.Height*1.0);

            if XFactor < YFactor then
                FZoomPercent := XFactor * 100
            else
                FZoomPercent := YFactor * 100;
        end;

        zmFitWidth :
        begin
            XFactor := Self.ClientWidth / (FSourceGraphic.Width*1.0);
            FZoomPercent := XFactor * 100
        end;

        zmFitHeight :
        begin
            Self.VertScrollBar.Visible := False;
            Self.HorzScrollBar.Visible := False;

            YFactor := Self.ClientHeight / (FSourceGraphic.Height*1.0);
            FZoomPercent := YFactor * 100
        end;

        zmPercent :
        begin
            { keep current value }
        end;
        else
            { zmOriginal }
            FZoomPercent := 100;
    end; { case }
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.Redraw( const GraphicChanged : Boolean );
begin
    if (Self.Parent = nil) or
       not Self.Visible then
        Exit;

    if FSourceGraphic.IsEmpty then
    begin
        TDibGraphic(FImage.Picture.Graphic).Clear;

        Self.HorzScrollBar.Visible := False;
        Self.VertScrollBar.Visible := False;

        FImage.Visible := False;
        Exit;
    end;

    if GraphicChanged then
    begin
        if FSourceGraphic.ImageFormat = ifBlackWhite then
            FAntiAliasTransform.ApplyOnDest(FSourceGraphic, FAntiAliasedGraphic)
        else
            FAntiAliasedGraphic.Clear;
    end;

    if FSourceGraphic.ImageFormat = ifBlackWhite then
        RedrawBW
    else
        RedrawNotBW;

    if Assigned(FOnRedraw) then
        FOnRedraw(FSourceGraphic);

    if not FImage.Visible  then
        FImage.Visible := True;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.CenterImage( const NewWidth  : LongInt;
                                       const NewHeight : LongInt );
begin
    { Sep 12, 1999. Thanks to Dan Parsons, dan@robonews.com for centering
      code }
    if (Self.Height > NewHeight) then
        FImage.Top := Trunc((Self.Height - NewHeight)/2)
    else
        FImage.Top := 0;

    if (Self.Width > NewWidth) then
        FImage.Left := Trunc((Self.Width - NewWidth)/2)
    else
        FImage.Left := 0;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.RedrawNotBW;
var
    NewWidth         : LongInt;
    NewHeight        : LongInt;
    OldZoom          : LongInt;

    DisplayedGraphic : TDibGraphic;

begin
    DisplayedGraphic := TDibGraphic(FImage.Picture.Graphic);

    OldZoom := Round(FZoomPercent);
    RecalcZoom;
    if (OldZoom <> FZoomPercent) and Assigned(FOnZoomChange) then
        FOnZoomChange(Self, FZoomPercent);

    NewWidth   := Trunc((FSourceGraphic.Width*1.0) * ((FZoomPercent) / 100.0));
    NewHeight  := Trunc((FSourceGraphic.Height*1.0) * ((FZoomPercent) / 100.0));

    Self.HorzScrollBar.Visible := NewWidth > Self.ClientWidth;
    Self.VertScrollBar.Visible := NewHeight > Self.ClientHeight;

    if (FZoomPercent <> 100) then
    begin
        FResizeTransform.Width  := NewWidth;
        FResizeTransform.Height := NewHeight;
        FResizeTransform.ApplyOnDest(FSourceGraphic, DisplayedGraphic);
    end
    else
        DisplayedGraphic.Assign(FSourceGraphic);

    FImage.Width             := NewWidth;
    FImage.Height            := NewHeight;

    Self.HorzScrollBar.Range := NewWidth;
    Self.VertScrollBar.Range := NewHeight;

    Self.HorzScrollBar.Position := 0;
    Self.VertScrollBar.Position := 0;

    if FCentered then
        CenterImage(NewWidth, NewHeight)
    else
    begin
        FImage.Top  := 0;
        FImage.Left := 0;
    end;

    FImage.Invalidate;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.RedrawBW;
var
    NewWidth         : LongInt;
    NewHeight        : LongInt;
    OldZoom          : LongInt;

    DisplayedGraphic : TDibGraphic;

begin
    DisplayedGraphic := TDibGraphic(FImage.Picture.Graphic);

    OldZoom := Round(FZoomPercent);
    RecalcZoom;
    if (OldZoom <> FZoomPercent) and Assigned(FOnZoomChange) then
        FOnZoomChange(Self, FZoomPercent);

    NewWidth   := Trunc((FSourceGraphic.Width*1.0) * ((FZoomPercent) / 100.0));
    NewHeight  := Trunc((FSourceGraphic.Height*1.0) * ((FZoomPercent) / 100.0));

    Self.HorzScrollBar.Visible := NewWidth > Self.ClientWidth;
    Self.VertScrollBar.Visible := NewHeight > Self.ClientHeight;

    FResizeTransform.Width  := NewWidth;
    FResizeTransform.Height := NewHeight;

    if (FZoomPercent <> 100) then
    begin
        if FAntiAliased then
            FResizeTransform.ApplyOnDest(FAntiAliasedGraphic, DisplayedGraphic)
        else
            FResizeTransform.ApplyOnDest(FSourceGraphic, DisplayedGraphic);
    end
    else
    begin
        if FAntiAliased then
            DisplayedGraphic.Assign(FAntiAliasedGraphic)
        else
            DisplayedGraphic.Assign(FSourceGraphic);
    end;

    FImage.Width             := NewWidth;
    FImage.Height            := NewHeight;

    Self.HorzScrollBar.Range := NewWidth;
    Self.VertScrollBar.Range := NewHeight;

    Self.HorzScrollBar.Position := 0;
    Self.VertScrollBar.Position := 0;

    if FCentered then
        CenterImage(NewWidth, NewHeight)
    else
    begin
        FImage.Top  := 0;
        FImage.Left := 0;
    end;

    FImage.Invalidate;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetFrameCount : LongInt;
begin
    Result := FSourceGraphic.FrameCount;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetFrame(FrameNo : LongInt) : TDibGraphic;
begin
    Result := FSourceGraphic.Frames[FrameNo];
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetCurrentFrame : LongInt;
begin
    Result := FSourceGraphic.CurrentFrame;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetCurrentFrame( const FrameNo : LongInt );
begin
    FSourceGraphic.CurrentFrame := FrameNo;
    Redraw(True);
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetAnimated : Boolean;
begin
    Result := FAnimated;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetAnimated( const InAnimated : Boolean );
var
    FrameNo : Integer;
begin
    if InAnimated = FAnimated then
        Exit;

    FAnimated := InAnimated;

    if FAnimated and (FrameCount > 1) then
    begin
        { set the dimensions of Image to the largest frame }
        for FrameNo := 1 to FSourceGraphic.FrameCount do
        begin
            if FSourceGraphic.Frames[FrameNo].Width > FImage.Width then
                FImage.Width := FSourceGraphic.Frames[FrameNo].Width;

            if FSourceGraphic.Frames[FrameNo].Height > FImage.Height then
                FImage.Height := FSourceGraphic.Frames[FrameNo].Height;
        end;

        FAnimationTimer.Interval := FSourceGraphic.ImageDelay;
        FAnimationTimer.Enabled  := True;
    end
    else
    begin
        FAnimationTimer.Enabled  := False;
        FAnimated                := False;
    end;
end;

{--------------------------------------------------------------------------}

constructor TMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create;

    FImageScrollBox := InImageScrollBox;
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseDown(
                         const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer );
begin
    FMouseIsDown := True;
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseUp(
                       const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer );
begin
    FMouseIsDown := False;
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseMove(
                     const Shift : TShiftState;
                     const X, Y  : Integer );
begin
end;

{--------------------------------------------------------------------------}

constructor TDragMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create(InImageScrollBox);

    FImageScrollBox.FImage.Cursor := crHandOpened;
end;

{--------------------------------------------------------------------------}

procedure TDragMouseHandler.MouseDown(
                     const Button : TMouseButton;
                     const Shift  : TShiftState;
                     const X, Y   : Integer );
begin
    FMouseIsDown     := True;

    FStartMousePos.X := X;
    FStartMousePos.Y := Y;

    FScreenCursor                := Screen.Cursor;

    { The cursor of the screen must be changes. Changing the cursor of the
      image not sufficient. }
    if ImageScrollBox.VertScrollBar.Visible or
       ImageScrollBox.HorzScrollBar.Visible then
        Screen.Cursor := crHandClosed;
end;

{--------------------------------------------------------------------------}

procedure TDragMouseHandler.MouseUp(
                       const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer );
begin
    if FMouseIsDown then
    begin
        if Screen.Cursor = crHandClosed then
        begin
            Screen.Cursor                  := FScreenCursor;
        end;

        FMouseIsDown := False;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDragMouseHandler.MouseMove(
                         const Shift : TShiftState;
                         const X, Y  : Integer );
begin
    if FMouseIsDown then
    begin
        ImageScrollBox.HorzScrollBar.Position :=  ImageScrollBox.HorzScrollBar.Position + FStartMousePos.X - X;
        ImageScrollBox.VertScrollBar.Position :=  ImageScrollBox.VertScrollBar.Position + FStartMousePos.Y - Y;
    end;
end;

{--------------------------------------------------------------------------}

constructor TQuickSelectMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create(InImageScrollBox);

    FCanvas           := TCanvas.Create;

    FImageScrollBox.FImage.Cursor := crDefault;
end;

{--------------------------------------------------------------------------}

destructor TQuickSelectMouseHandler.Destroy;
begin
    FCanvas.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.BoundXY( var X, Y : Integer );
var
    Graphic : TDibGraphic;
begin
    Graphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

    if X < FImageScrollBox.FImage.Left then
        X := FImageScrollBox.FImage.Left;

    if Y < FImageScrollBox.FImage.Top then
        Y := FImageScrollBox.FImage.Top;

    if X >= (Graphic.Width + FImageScrollBox.FImage.Left) then
        X := Graphic.Width + FImageScrollBox.FImage.Left - 1;

    if Y >= (Graphic.Height + FImageScrollBox.FImage.Top) then
        Y := Graphic.Height + FImageScrollBox.FImage.Top - 1;
end;

{--------------------------------------------------------------------------}

{ Adjust Rect to Left and Top fields are to the left and top of the
  Right and Bottom fields. }
function AdjustRect(Rect : TRect): TRect;
begin
    with Rect do
    begin
        if Left > Right then
        begin
            if Top > Bottom then
                Result := Classes.Rect(Right,Bottom,Left,Top)
            else
                Result := Classes.Rect(Right,Top,Left,Bottom)
        end
        else
        begin
            if Top > Bottom then
                Result := Classes.Rect(Left,Bottom,Right,Top)
            else
                Result := Classes.Rect(Left,Top,Right,Bottom);
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.DrawXORBand;
begin
    FCanvas.MoveTo(FX1, FY1);

    FCanvas.LineTo(FX2, FY1);
    FCanvas.LineTo(FX2, FY2);
    FCanvas.LineTo(FX1, FY2);
    FCanvas.LineTo(FX1, FY1);
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.DrawBand;
begin
    DrawXORBand;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.RemoveBand;
begin
    DrawXORBand;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.MouseDown(
                     const Button : TMouseButton;
                     const Shift  : TShiftState;
                     const X, Y   : Integer );
begin
    FMouseIsDown     := True;

    { the device context handle is obtained here, because when obtained
      in the constructor, an exception was raised when releasing the
      device context in the destructor. }
    FCanvas.Handle    := GetDC(FImageScrollBox.Handle);
    FCanvas.Pen.Color := clBlack;
    FCanvas.Pen.Mode  := pmXOR;
    FCanvas.Pen.Style := psDot;

    FX1 := X + FImageScrollBox.FImage.Left;
    FY1 := Y + FImageScrollBox.FImage.Top;

    FX2 := FX1;
    FY2 := FY1;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.MouseMove(
                         const Shift : TShiftState;
                         const X, Y  : Integer );
var
    LocalX  : Integer;
    LocalY  : Integer;
begin
    if FMouseIsDown and (ssLeft in Shift) then
    begin
        LocalX  := X + FImageScrollBox.FImage.Left;
        LocalY  := Y + FImageScrollBox.FImage.Top;

        BoundXY(LocalX,LocalY);

        RemoveBand;

        FX2 := LocalX;
        FY2 := LocalY;

        DrawBand;
    end;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.MouseUp(
                       const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer );
var
    Rect             : TRect;
    Graphic          : TDibGraphic;
    CropTransform    : TCropTransform;
    DisplayedGraphic : TDibGraphic;
begin
    if FMouseIsDown then
    begin
        RemoveBand;

        DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

        Rect.Right := X;
        if Rect.Right > DisplayedGraphic.Width then
            Rect.Right := DisplayedGraphic.Width;
        if Rect.Right < 0 then
            Rect.Right := 0;

        Rect.Bottom := Y;
        if Rect.Bottom > DisplayedGraphic.Height then
            Rect.Bottom := DisplayedGraphic.Height;
        if Rect.Bottom < 0 then
            Rect.Bottom := 0;

        Rect.Left := FX1 - FImageScrollBox.FImage.Left;
        Rect.Top  := FY1 - FImageScrollBox.FImage.Top;

        Rect := AdjustRect(Rect);

        if ((Rect.Right - Rect.Left) >= 1) and
           ((Rect.Bottom - Rect.Top) >= 1) then
        begin
            Graphic := TDibGraphic.Create;
            CropTransform := TCropTransform.Create;
            try
                CropTransform.Top    := Rect.Top;
                CropTransform.Left   := Rect.Left;
                CropTransform.Bottom := DisplayedGraphic.Height - Rect.Bottom;
                CropTransform.Right  := DisplayedGraphic.Width - Rect.Right;

                CropTransform.ApplyOnDest(DisplayedGraphic, Graphic);

                if Assigned(FImageScrollBox.FOnQuickSelect) then
                    FImageScrollBox.FOnQuickSelect(FImageScrollBox, Graphic);

            finally
                CropTransform.Free;
                Graphic.Free;
            end;
        end;

        ReleaseDC(FImageScrollBox.Handle, FCanvas.Handle);

        { clear the canvas handle to 0, otherwise the next rubber band was
          not drawn in pmXOR mode. } 
        FCanvas.Handle := 0;

        FMouseIsDown := False;
    end;
end;

{--------------------------------------------------------------------------}

initialization
    Screen.Cursors[crHandOpened] := LoadCursor(hInstance, 'HANDOPENEDCURSOR');
    Screen.Cursors[crHandClosed] := LoadCursor(hInstance, 'HANDCLOSEDCURSOR');
end.


