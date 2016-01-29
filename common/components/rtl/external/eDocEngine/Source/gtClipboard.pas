{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtClipboard;

interface
uses
  Windows, Classes, Graphics, gtCstDocEng, gtclasses3, gtTXTEng,
  gtSLKEng, gtDIFEng, gtBMPEng, gtEMFEng, gtDocResStrs, gtUtils3;

type
  TgtOutputFormat = (ofText, ofSYLK, ofDIF, ofBMP, ofMetafile);

  TgtClipboard = class(TgtCustomDocumentEngine)
  private
    FEngine: TgtCustomDocumentEngine;
    FEngineStream: TMemoryStream;
    FOutputFormat: TgtOutputFormat;

    procedure SetToClipboard;
    procedure SetOutputFormat(const Value: TgtOutputFormat);
    procedure SetOnBeforeBeginDoc(const Value: TgtNotifyEvent);
    procedure SetOnBeforeBeginPage(const Value: TgtNotifyEvent);
    procedure SetOnBeforeEndDoc(const Value: TgtNotifyEvent);
    procedure SetOnAfterEndPage(const Value: TgtNotifyEvent);
    procedure EndPageEvent(Sender: TgtCustomDocumentEngine);
    procedure SetFont(const Value: TFont);
    procedure SetPen(const Value: TPen);
    procedure SetBrush(const Value: TBrush);
    procedure SetPreferences(const Value: TgtPreferences);
    procedure IntiResource;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure NewPage; override;

    procedure TextOut(X, Y: Double; Text: WideString); override;
    procedure TextOut(ColumnNo: Integer; Text: WideString); override;
    function TextOut(Text: WideString): Double; override;
    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment); override;
    procedure SetTextRotation(Angle: Integer); override;

    procedure DrawImage(X, Y: Double; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; Index: Integer); override;
    procedure DrawImage(ColumnNo: Integer; Width, Height: Double;
      AGraphic: TGraphic); override;
    function AddImageAsResource(AGraphic: TGraphic): Integer; override;


    procedure Line(X1, Y1, X2, Y2: Double); override;
    procedure Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure RoundRect(X1, Y1, X2, y2, X3, Y3: Double;
      IsFill: Boolean); override;

    procedure Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure Polygon(Points: array of TgtPoint; IsFill: Boolean); override;
    procedure PolyLine(Points: array of TgtPoint); override;

    procedure Arc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double); override;
    procedure Pie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure Chord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure PolyBezier(Points: array of TgtPoint); override;


    procedure BeginPara; override;
    procedure EndPara; override;

    function BeginTable(X, Y: Double; NoColumns: Integer): TList; override;
    function NewRow(Height: Double): Double; override;
    function NewRow: Double; override;
    procedure EndTable; override;

    procedure PlayMetafile(Metafile: TMetafile); override;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile); override;

    procedure BeginHeader; override;
    procedure EndHeader; override;
    procedure ClearHeader; override;

    procedure BeginFooter; override;
    procedure EndFooter; override;
    procedure ClearFooter; override;

    procedure BeginWaterMark; override;
    procedure EndWaterMark; override;
    procedure ClearWaterMark; override;

    procedure BeginStamp; override;
    procedure EndStamp; override;
    procedure ClearStamp; override;
    
    function SaveEngineState: Integer; override;
    procedure RestoreEngineState(Index: Integer); override;
    procedure ClearEngineStates; override;

    procedure SetWorkingPage(PageNo: Integer); override;

    property TextFormatting;
    property ImageSettings;
    property TableSettings;
    
  published
    property Font write SetFont;
    property Brush write SetBrush;
    property Pen write SetPen;
    property Preferences write SetPreferences;
    property OutputFormat: TgtOutputFormat read FOutputFormat
      write SetOutputFormat default ofText;

		property OnBeforeBeginDoc write SetOnBeforeBeginDoc;
		property OnBeforeEndDoc write SetOnBeforeEndDoc;
		property OnBeforeBeginPage write SetOnBeforeBeginPage;
		property OnAfterEndPage write SetOnAfterEndPage;

  end;

implementation

uses SysUtils, gtDocConsts;

{ TgtClipboard }

function TgtClipboard.AddImageAsResource(AGraphic: TGraphic): Integer;
begin
  Result :=   IgtDocumentEngine(FEngine).AddImageAsResource(AGraphic);
end;

procedure TgtClipboard.Arc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure TgtClipboard.BeginDoc;
begin
  (* Initialize Local Engine Properties. *)
  FEngine.OnBeforeBeginDoc := OnBeforeBeginDoc;
  FEngine.OnBeforeBeginPage := OnBeforeBeginPage;
  FEngine.OnAfterEndPage := EndPageEvent;
  FEngine.OnBeforeEndDoc := OnBeforeEndDoc;
  FEngine.ItemsToRender := ItemsToRender;
  FEngine.SetupDialog := SetupDialog;
  IgtDocumentEngine(FEngine).Preferences.ShowSetupDialog :=
    Preferences.ShowSetupDialog;

  FEngineStream := TMemoryStream.Create;

  IgtDocumentEngine(FEngine).Preferences.OutputToUserStream := True;
  FEngine.UserStream := FEngineStream;
  
  IgtDocumentEngine(FEngine).BeginDoc;
end;

procedure TgtClipboard.BeginFooter;
begin
  IgtDocumentEngine(FEngine).BeginFooter;
end;

procedure TgtClipboard.BeginHeader;
begin
  IgtDocumentEngine(FEngine).BeginHeader;
end;

procedure TgtClipboard.BeginPara;
begin
  IgtDocumentEngine(FEngine).TextFormatting := TextFormatting;
  IgtDocumentEngine(FEngine).BeginPara;
end;

function TgtClipboard.BeginTable(X, Y: Double; NoColumns: Integer): TList;
begin
  IntiResource;
  IgtDocumentEngine(FEngine).TableSettings := TableSettings;
  Result := IgtDocumentEngine(FEngine).BeginTable(X, Y, NoColumns);
end;

procedure TgtClipboard.BeginWaterMark;
begin
  IgtDocumentEngine(FEngine).BeginWaterMark;
end;

procedure TgtClipboard.BeginStamp;
begin
  IgtDocumentEngine(FEngine).BeginStamp;
end;

procedure TgtClipboard.Chord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  IsFill: Boolean);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4, IsFill);
end;

procedure TgtClipboard.ClearEngineStates;
begin
  inherited;
//  IgtDocumentEngine(FEngine).ClearEngineStates;
end;

constructor TgtClipboard.Create(AOwner: TComponent);
begin
  inherited;
  FileDescription := SClipboardDescription;
  FEngine := TgtTextEngine.Create(Self);  
  FEngineStream := nil;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 119);
{$ENDIF}
end;

destructor TgtClipboard.Destroy;
begin
  FreeAndNil(FEngine);
  FreeAndNil(FEngineStream);
  inherited;
end;

procedure TgtClipboard.DrawImage(ColumnNo: Integer; Width, Height: Double;
  AGraphic: TGraphic);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).ImageSettings := ImageSettings;
  IgtDocumentEngine(FEngine).DrawImage(ColumnNo, Width, Height, AGraphic);
end;

procedure TgtClipboard.DrawImage(X, Y: Double; AGraphic: TGraphic);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).ImageSettings := ImageSettings;
  IgtDocumentEngine(FEngine).DrawImage(X, Y, AGraphic);
end;

procedure TgtClipboard.DrawImage(ImageRect: TgtRect; AGraphic: TGraphic);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).ImageSettings := ImageSettings;
  IgtDocumentEngine(FEngine).DrawImage(ImageRect, AGraphic);
end;

procedure TgtClipboard.DrawImage(ImageRect: TgtRect; Index: Integer);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).ImageSettings := ImageSettings;
  IgtDocumentEngine(FEngine).DrawImage(ImageRect, Index);
end;

procedure TgtClipboard.Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Ellipse(X1, Y1, X2, Y2, IsFill);
end;

procedure TgtClipboard.EndDoc;
begin
  IgtDocumentEngine(FEngine).EndDoc;
  case OutputFormat of
    ofText, ofSYLK, ofDIF:
      SetToClipboard;
  end;
end;

procedure TgtClipboard.EndFooter;
begin
  IgtDocumentEngine(FEngine).EndFooter;
end;

procedure TgtClipboard.EndHeader;
begin
  IgtDocumentEngine(FEngine).EndHeader;
end;

procedure TgtClipboard.EndPageEvent(Sender: TgtCustomDocumentEngine);
begin
  case OutputFormat of
    ofBMP, ofMetafile:
    begin
      SetToClipboard;
      TMemoryStream(FEngine.UserStream).Clear;
    end;
  end;
  if Assigned(OnAfterEndPage) then
    OnAfterEndPage(Self);
end;

procedure TgtClipboard.EndPara;
begin
  IgtDocumentEngine(FEngine).EndPara;
end;

procedure TgtClipboard.EndTable;
begin
  IgtDocumentEngine(FEngine).EndTable;
end;

procedure TgtClipboard.EndWaterMark;
begin
  IgtDocumentEngine(FEngine).EndWaterMark;
end;

procedure TgtClipboard.EndStamp;
begin
  IgtDocumentEngine(FEngine).EndStamp;
end;

procedure TgtClipboard.Line(X1, Y1, X2, Y2: Double);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Line(X1, Y1, X2, Y2);
end;

procedure TgtClipboard.NewPage;
begin
  IgtDocumentEngine(FEngine).Page := Page;
  IgtDocumentEngine(FEngine).NewPage;
end;

function TgtClipboard.NewRow(Height: Double): Double;
begin
  Result := IgtDocumentEngine(FEngine).NewRow(Height);
end;

function TgtClipboard.NewRow: Double;
begin
  Result := IgtDocumentEngine(FEngine).NewRow;
end;

procedure TgtClipboard.Pie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  IsFill: Boolean);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4, IsFill);
end;

procedure TgtClipboard.PlayMetafile(X, Y: Double; Metafile: TMetafile);
begin
  IgtDocumentEngine(FEngine).PlayMetafile(X, Y, Metafile);
end;

procedure TgtClipboard.PlayMetafile(Metafile: TMetafile);
begin
  IgtDocumentEngine(FEngine).PlayMetafile(Metafile);
end;

procedure TgtClipboard.PolyBezier(Points: array of TgtPoint);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).PolyBezier(Points);
end;

procedure TgtClipboard.Polygon(Points: array of TgtPoint; IsFill: Boolean);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Polygon(Points, IsFill);
end;

procedure TgtClipboard.PolyLine(Points: array of TgtPoint);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).PolyLine(Points);
end;

procedure TgtClipboard.Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).Rectangle(X1, Y1, X2, Y2, IsFill);
end;

procedure TgtClipboard.RestoreEngineState(Index: Integer);
begin
  inherited RestoreEngineState(Index);
//  IgtDocumentEngine(FEngine).RestoreEngineState(Index);
end;

procedure TgtClipboard.RoundRect(X1, Y1, X2, y2, X3, Y3: Double;
  IsFill: Boolean);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).RoundRect(X1, Y1, X2, Y2, X3, Y3, IsFill);
end;

function TgtClipboard.SaveEngineState: Integer;
begin
  Result := inherited SaveEngineState;
//  Result := IgtDocumentEngine(FEngine).SaveEngineState;
end;

procedure TgtClipboard.SetOutputFormat(const Value: TgtOutputFormat);
begin
  FOutputFormat := Value;
  FreeAndNil(FEngine);
  case OutputFormat of
    ofText:
      FEngine := TgtTextEngine.Create(Self);
    ofSYLK:
      FEngine := TgtSYLKEngine.Create(Self);
    ofDIF:
      FEngine := TgtDIFEngine.Create(Self);
    ofBMP:
      FEngine := TgtBMPEngine.Create(Self);
    ofMetafile:
      FEngine := TgtEMFEngine.Create(Self);
  end;
end;

procedure TgtClipboard.SetOnBeforeBeginDoc(const Value: TgtNotifyEvent);
begin
  FEngine.OnBeforeBeginDoc := Value;
end;

procedure TgtClipboard.SetOnBeforeBeginPage(const Value: TgtNotifyEvent);
begin
  FEngine.OnBeforeBeginPage := Value;
end;

procedure TgtClipboard.SetOnBeforeEndDoc(const Value: TgtNotifyEvent);
begin
  FEngine.OnBeforeEndDoc := Value;
end;

procedure TgtClipboard.SetOnAfterEndPage(const Value: TgtNotifyEvent);
begin
  FEngine.OnAfterEndPage := Value;
end;

procedure TgtClipboard.SetTextRotation(Angle: Integer);
begin
  IgtDocumentEngine(FEngine).SetTextRotation(Angle);
end;

procedure TgtClipboard.SetToClipboard;
var
  Data: THandle;
  DataPtr: Pointer;
  Format: Word;  
  Palette: HPALETTE;  

  LMetafile: TMetafile;
  LBitmap: TBitmap;

  Size: Cardinal;

begin
  OpenClipboard(0);
  EmptyClipboard;

  case OutputFormat of
    ofText:
    begin
      with FEngine do
      begin
        Size := UserStream.Size + 1;
        UserStream.Position := 0;
        Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
        DataPtr := GlobalLock(Data);
        Move(TMemoryStream(UserStream).Memory^, DataPtr^, Size);
        
        SetClipboardData(CF_TEXT, Data);
      end;
    end;
    ofSYLK:
    begin
      with FEngine do
      begin
        UserStream.Position := 0;
        Size := UserStream.Size + 1;
        UserStream.Position := 0;
        Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
        DataPtr := GlobalLock(Data);
        Move(TMemoryStream(UserStream).Memory^, DataPtr^, Size);

        SetClipboardData(CF_SYLK, Data);
      end;
    end;
    ofDIF:
    begin
      with FEngine do
      begin
        UserStream.Position := 0;
        Size := UserStream.Size + 1;
        UserStream.Position := 0;
        Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
        DataPtr := GlobalLock(Data);
        Move(TMemoryStream(UserStream).Memory^, DataPtr^, Size);

        SetClipboardData(CF_DIF, Data);
      end;
    end;
    ofBMP:
    begin
      with FEngine do
      begin
        LBitmap := TBitmap.Create;
        UserStream.Position := 0;
        LBitmap.LoadFromStream(UserStream);
        Palette := 0;
        LBitmap.SaveToClipboardFormat(Format, Data, Palette);

        SetClipboardData(Format, Data);
      end;
    end;
    ofMetafile:
    begin
      with FEngine do
      begin
        LMetafile := TMetafile.Create;
        UserStream.Position := 0;
        LMetafile.LoadFromStream(UserStream);
        Palette := 0;
        LMetafile.SaveToClipboardFormat(Format, Data, Palette);

        SetClipboardData(Format, Data);
      end;
    end;
  end;
  CloseClipboard;
end;

procedure TgtClipboard.SetWorkingPage(PageNo: Integer);
begin
  IgtDocumentEngine(FEngine).SetWorkingPage(PageNo);
end;

procedure TgtClipboard.TextBox(TextRect: TgtRect; Text: WideString;
  HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).TextBox(TextRect, Text, HAlignment, VAlignment);
end;

function TgtClipboard.TextOut(Text: WideString): Double;
begin
  IntiResource;
  Result := IgtDocumentEngine(FEngine).TextOut(Text);
end;

procedure TgtClipboard.TextOut(ColumnNo: Integer; Text: WideString);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).TextOut(ColumnNo, Text);
end;

procedure TgtClipboard.TextOut(X, Y: Double; Text: WideString);
begin
  IntiResource;
  IgtDocumentEngine(FEngine).TextOut(X, Y, Text);
end;

procedure TgtClipboard.SetBrush(const Value: TBrush);
begin
  IgtDocumentEngine(FEngine).Brush := Value;
end;

procedure TgtClipboard.SetFont(const Value: TFont);
begin
  IgtDocumentEngine(FEngine).Font := Value; 
end;

procedure TgtClipboard.SetPen(const Value: TPen);
begin
  IgtDocumentEngine(FEngine).Pen := Value;
end;

procedure TgtClipboard.SetPreferences(const Value: TgtPreferences);
begin
  IgtDocumentEngine(FEngine).Preferences := Value;
end;

procedure TgtClipboard.IntiResource;
begin
  IgtDocumentEngine(FEngine).Font := Font;
  IgtDocumentEngine(FEngine).Pen := Pen;
  IgtDocumentEngine(FEngine).Brush := Brush;
end;

procedure TgtClipboard.ClearFooter;
begin
  inherited;

end;

procedure TgtClipboard.ClearHeader;
begin
  inherited;

end;

procedure TgtClipboard.ClearStamp;
begin
  inherited;

end;

procedure TgtClipboard.ClearWaterMark;
begin
  inherited;

end;

end.
