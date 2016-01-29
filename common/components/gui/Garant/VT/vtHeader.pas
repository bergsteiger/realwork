unit vtHeader;

{ $Id: vtHeader.pas,v 1.12 2013/04/24 09:35:37 lulin Exp $ }

// $Log: vtHeader.pas,v $
// Revision 1.12  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.11  2013/03/29 11:36:59  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.10  2013/01/22 15:51:48  kostitsin
// [$424399029]
//
// Revision 1.9  2007/08/24 08:11:56  fireton
// - при рассчете высоты учитывается bevel
//
// Revision 1.8  2007/02/27 09:54:58  lulin
// - cleanup.
//
// Revision 1.7  2007/02/13 11:44:32  mmorozov
// - new: заголовок дерева (TvtHeader) использует таблицу стилей (CQ: OIT5-24283);
//
// Revision 1.6  2006/12/28 13:35:59  lulin
// - bug fix: AV при выходе из приложения (CQ OIT5-24042).
//
// Revision 1.5  2006/03/24 11:52:43  lulin
// - cleanup: не пишем пустые коллекции.
//
// Revision 1.4  2005/10/06 09:17:58  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.3  2005/06/18 09:48:45  fireton
// - bug fix: вычисляем ширину последней секции по остаточному принципу
//
// Revision 1.2  2005/05/30 10:27:30  lulin
// - добавлено включение файла с директивами компиляции.
//
// Revision 1.1  2005/05/30 10:25:37  lulin
// - компонент "Заголовок" переехал в модуль с "правильным" названием.
//
// Revision 1.21  2005/05/24 12:48:17  lulin
// - для канвы используем интерфейс, а не объект.
//
// Revision 1.20  2005/04/20 08:56:54  demon
// - new behavior: Свойство OnClickHeader на TCustomEnhHeader (изменение от Василия)
//
// Revision 1.19  2005/02/22 12:58:25  demon
// - new behavior: add publised Color + Это свойство стало использоваться в Paint
//
// Revision 1.18  2004/12/06 12:58:22  demon
// - fix: вместо Cleanup использовался Destroy.
//
// Revision 1.17  2004/10/06 17:15:13  lulin
// - борьба за кошерность.
//
// Revision 1.16  2004/09/16 11:31:05  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//
// Revision 1.15  2004/09/02 13:05:55  law
// - все dynamic методы заменил на virtual.
//
// Revision 1.14  2004/05/05 14:30:56  voba
// no message
//
// Revision 1.13  2004/03/04 16:35:36  law
// - rename unit: VLister -> vtLister.
//
// Revision 1.12  2004/03/04 14:21:43  voba
// no message
//
// Revision 1.11  2004/02/12 13:29:20  fireton
// no message
//
// Revision 1.10  2004/01/27 09:42:14  fireton
// - изменения в связи с доработкой Header'a
//
// Revision 1.9  2004/01/27 08:27:41  fireton
// - add: в Il3TabStops добавлено NeedCutByTab - разрезание по табуляции
// - add: в TevCanvas добавлены и исправлены функции вывода текста с табуляцией
// - change: TEnhHeader теперь наследник от TvtCustomPanel
// - change: TCustomvtLister теперь использует в качестве заголовка TEnhHeader
//
// Revision 1.8  2002/09/11 15:12:25  voba
// -new behavior : published some inherit property
//
// Revision 1.7  2001/09/06 10:39:13  law
// - cleanup.
//
// Revision 1.6  2001/05/18 06:06:57  voba
// no message
//
// Revision 1.5  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.4  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

{$Include vtDefine.inc }

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  Menus,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  ImgList,

  afwInterfaces,

  l3InternalInterfaces,
  l3Base,
  l3Units,

  vtPanel
  ;

type
  TSectionEvent = procedure(Sender: TObject;
    ASection, AWidth: Integer) of object;
  TClickHeaderEvent = procedure(Sender: TObject;
    Index : Integer; Point : TPoint) of object;
  TGetItemImageIndex = function(Sender : TObject;
    Index : Longint) : Integer of object;

 TSectionData = class(TCollectionItem)
 private
   FAlignment: TAlignment;
   FCaption: TCaption;
   FWidth: Integer;
   FAutoResize: Boolean;
   FMinWidth: Integer;
   FMaxWidth: Integer;
   procedure SetAlignment(Value: TAlignment);
   procedure SetCaption(Value: TCaption);
   procedure SetWidth(Value: Integer);
   procedure SetAutoResize(Value: Boolean);
   procedure SetMinWidth(Value: Integer);
   procedure SetMaxWidth(Value: Integer);
 protected
   function GetDisplayName: string; override;
   procedure Constrain;
 public
   constructor Create(Collection: TCollection); override;
 published
   property Alignment: TAlignment read FAlignment write SetAlignment default
       taLeftJustify;
   property Caption: TCaption read FCaption write SetCaption;
   property Width: Integer read FWidth write SetWidth;
   property AutoResize: Boolean read FAutoResize write SetAutoResize;
   property MinWidth: Integer read FMinWidth write SetMinWidth;
   property MaxWidth: Integer read FMaxWidth write SetMaxWidth;
 end;

 TvtCustomHeader = class;

 TEnhHeaderSections = class(TCollection)
 private
   FHeaderControl: TvtCustomHeader;
   function GetItem(Index: Integer): TSectionData;
   procedure SetItem(Index: Integer; Value: TSectionData);
 protected
   function GetOwner: TPersistent; override;
   procedure Update(Item: TCollectionItem); override;
 public
   constructor Create(HeaderControl: TvtCustomHeader);
   function Add: TSectionData;
   property Items[Index: Integer]: TSectionData read GetItem write SetItem;
       default;
 end;

  TvtCustomHeader = class(TvtCustomPanel{$IfNDef DesignTimeLibrary},
                          IafwStyleTableSpy{$EndIf})
  private
    FAllowResize: Boolean;
    FBorderStyle: TBorderStyle;
    FCanResize: Boolean;
    FHitTest: TPoint;
    FMouseOffset: Integer;
    FOnSized: TSectionEvent;
    FOnSizing: TSectionEvent;
    FResizeSection: Integer;
    FSections: TEnhHeaderSections;
    FOnClickHeader : TClickHeaderEvent;
    FImagesChangeLink : TChangeLink;
    FImages : TCustomImageList;
    FOnGetItemImageIndex : TGetItemImageIndex;
  private
  // IafwStyleTableSpy
    procedure StyleTableChanged;
      {* - таблица стилей изменилась. }
  private
  // messages
    procedure CMFontChanged(var Message: TMessage);
      message CM_FONTCHANGED;
      {* - при изменении шрифта откорректируем высоту заголовка. }
    procedure WMNCHitTest(var Msg: TWMNCHitTest);
      message WM_NCHITTEST;
      {-}
    procedure WMSetCursor(var Msg: TWMSetCursor);
      message WM_SETCURSOR;
      {-}
  private
  // methods
    procedure DefineHeight;
      {* - определить высоту заголовка. }
    procedure AutoSizedSectionsResize;
    procedure FreeSections;
    function  GetSectJustification(X: Integer): TAlignment;
    function  GetSectWidth(X: Integer): Integer;
    procedure ResizeSection(Idx: Integer; Delta: Integer);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetSections(ASections: TEnhHeaderSections);
    function  SectionsStored: Boolean;
    procedure SetSectJustification(X: Integer; Value: TAlignment);
    procedure SetSectWidth(X: Integer; Value: Integer);
  protected
    procedure pm_SetBevelInner(Value: TPanelBevel); override;
      {-}
    procedure pm_SetBevelOuter(Value: TPanelBevel); override;
      {-}
    procedure pm_SetBevelWidth(Value: TBevelWidth); override;
      {-}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint(const CN: Il3Canvas); override;
    procedure Sized(ASection, AWidth: Integer); virtual;
    procedure Sizing(ASection, AWidth: Integer); virtual;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure SetImages(Value : TCustomImageList); virtual;
    function  GetImages: TCustomImageList; virtual;
    procedure ImagesChanged(Sender: TObject);
    function DoOnGetItemImageIndex(aItemIndex : Longint): Integer; virtual;
    function  CalcSectionIndex(Point : TPoint) : Integer; virtual;
    procedure DoOnClickHeader(Point : TPoint); virtual;
    property OnGetItemImageIndex : TGetItemImageIndex read FOnGetItemImageIndex write FOnGetItemImageIndex;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    function ImagesStored: Boolean; virtual;
    property SectionJustification[X: Integer]: TAlignment read GetSectJustification write SetSectJustification;
    property SectionWidth[X: Integer]: Integer read GetSectWidth write SetSectWidth;
    property AllowResize: Boolean read FAllowResize write FAllowResize default True;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property OnSized: TSectionEvent read FOnSized write FOnSized;
    property OnSizing: TSectionEvent read FOnSizing write FOnSizing;
    property OnClickHeader : TClickHeaderEvent read FOnClickHeader write FOnClickHeader;
    property Sections: TEnhHeaderSections read FSections write SetSections stored SectionsStored;
    property Images : TCustomImageList read GetImages write SetImages stored ImagesStored;
  end;//TvtCustomHeader

 TvtHeader = class(TvtCustomHeader)
 published
    property Align;
    property AllowResize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property Color;
    property Enabled;
    property Font;
    property OnSized;
    property OnSizing;
    property ParentFont;
    property ParentShowHint;
    property Sections;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
 end;//TvtHeader

Implementation

uses
  afwControl,

  evStyleTableSpy,
  evStyleTableTools,

  l3Canvas,
  l3String,
  l3ScreenIC
  , l3Interfaces;

{ THeaderStrings }

const
  DefaultSectionWidth = 75;
  MinSectWidth = 20;

type
  PHeaderSection = ^THeaderSection;
  THeaderSection = record
    FObject: TObject;
    Width : Integer;
    Just  : TAlignment;
    Title : string;
  end;

type
  THeaderStrings = class(TStrings)
  private
    FHeader: TvtCustomHeader;
    FList: TList;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Clear; override;
  end;

procedure FreeSection(Section: PHeaderSection);
begin
  if Section <> nil then
(*    {$IFDEF WIN32}
    Dispose(Section);
    {SizeOf(Pointer) + SizeOf(Integer) + Length(Section^.Title) + 1);}
    {$ELSE WIN32}
    FreeMem(Section, SizeOf(THeaderSection) - SizeOf(String) + Succ(Length(Section^.Title)));
    {SizeOf(Pointer) + SizeOf(Integer) + Length(Section^.Title) + 1);}
    {$ENDIF WIN32}*)
   l3System.FreeLocalMem(Section);
end;

function NewSection(const ATitle: string; AWidth: Integer; AJust : TAlignment; AObject: TObject): PHeaderSection;
begin
(*  {$IFDEF WIN32}
  New(Result);
  {$ELSE WIN32}*)
  l3System.GetLocalMem(Result, SizeOf(THeaderSection) - SizeOf(String) + Succ(Length(ATitle)));
(*  {$ENDIF WIN32}*)
  with Result^ do
  begin
    Title := ATitle;
    Width := AWidth;
    Just:=AJust;
    FObject := AObject;
  end;
end;

constructor THeaderStrings.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor THeaderStrings.Destroy;
begin
  if FList <> nil then
  begin
    Clear;
    FList.Destroy;
  end;
  inherited Destroy;
end;

procedure THeaderStrings.Assign(Source: TPersistent);
var
  I, J: Integer;
  Strings: TStrings;
  NewList: TList;
  Section: PHeaderSection;
  TempStr: String[80];
  Found: Boolean;
begin
  if Source is TStrings then
  begin
    Strings := TStrings(Source);
    BeginUpdate;
    try
      NewList := TList.Create;
      try
        { Delete any sections not in the new list }
        I := Pred(FList.Count);
        while I >= 0 do
        begin
          TempStr := Get(I);
          Found := False;
          for J := 0 to Pred(Strings.Count) do
          begin
            Found := CompareStr(Strings[J], TempStr) = 0;
            if Found then Break;
          end;
          if not Found then Delete(I);
          Dec(I);
        end;

        { Now iterate over the lists and maintain section widths of sections in
          the new list }
        I := 0;
        for J := 0 to Pred(Strings.Count) do
        begin
          if (I < FList.Count) and (CompareStr(Strings[J], Get(I)) = 0)
           then
            begin
             Section := NewSection(Get(I), PHeaderSection(FList[I])^.Width,
                                   PHeaderSection(FList[I])^.Just,GetObject(I));
             Inc(I);
            end
           else
            Section := NewSection(Strings[J], FHeader.Canvas.Canvas.TextWidth(Strings[J]) + 8,
                                  taLeftJustify, Strings.Objects[J]);
          NewList.Add(Section);
        end;
        Clear;
        FList.Destroy;
        FList := NewList;
        FHeader.Invalidate;
      except
        for I := 0 to Pred(NewList.Count) do
          FreeSection(NewList[I]);
        NewList.Destroy;
        raise;
      end;
    finally
      EndUpdate;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure THeaderStrings.DefineProperties(Filer: TFiler);
begin
  { This will allow the old file image read in }
  if Filer is TReader then inherited DefineProperties(Filer);
  Filer.DefineProperty('Sections', ReadData, WriteData, Count > 0);
end;

procedure THeaderStrings.Clear;
var
  I: Integer;
begin
  for I := 0 to Pred(FList.Count) do
    FreeSection(FList[I]);
  FList.Clear;
end;

procedure THeaderStrings.Delete(Index: Integer);
begin
  FreeSection(FList[Index]);
  FList.Delete(Index);
  if FHeader <> nil then FHeader.Invalidate;
end;

function THeaderStrings.Get(Index: Integer): string;
begin
  Result := PHeaderSection(FList[Index])^.Title;
end;

function THeaderStrings.GetCount: Integer;
begin
  Result := FList.Count;
end;

function THeaderStrings.GetObject(Index: Integer): TObject;
begin
  Result := PHeaderSection(FList[Index])^.FObject;
end;

procedure THeaderStrings.Insert(Index: Integer; const S: string);
var
  Width: Integer;
begin
  if FHeader <> nil then
    Width := FHeader.Canvas.Canvas.TextWidth(S) + 8
  else Width := DefaultSectionWidth;
  FList.Expand.Insert(Index, NewSection(S, Width, taLeftJustify, nil));
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure THeaderStrings.Put(Index: Integer; const S: string);
var
  P: PHeaderSection;
  {Width: Integer;}
begin
  P := FList[Index];
  {if FHeader <> nil then
    Width := FHeader.Canvas.TextWidth(S) + 8
  else Width := DefaultSectionWidth;}
  FList[Index] := NewSection(S, P^.Width, P^.Just, P^.FObject);
  FreeSection(P);
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure THeaderStrings.PutObject(Index: Integer; AObject: TObject);
begin
  PHeaderSection(FList[Index])^.FObject := AObject;
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure THeaderStrings.ReadData(Reader: TReader);
var
  Width, I, NS : Integer;
  Just         : TAlignment;
  Str          : string;
begin
  Reader.ReadListBegin;
  Clear;
  while not Reader.EndOfList do
  begin
    Str := Reader.ReadString;
    Width := DefaultSectionWidth;
    I := 1;
    NS:=3;
    Just:=taLeftJustify;
    if Str[1] = #0 then
    begin
      Case Str[2] of
       'L' : Just:=taLeftJustify;
       'R' : Just:=taRightJustify;
       'C' : Just:=taCenter;
       else NS:=2;
      end;
      Inc(I);
      repeat
        Inc(I);
      until (I > Length(Str)) or (Str[I] = #0);
      Width := StrToIntDef(Copy(Str, NS, I - NS), DefaultSectionWidth);
      System.Delete(Str, 1, I);
    end;
    FList.Expand.Insert(FList.Count, NewSection(Str, Width, Just, nil));
  end;
  Reader.ReadListEnd;
end;

procedure THeaderStrings.SetUpdateState(Updating: Boolean);
begin
  if FHeader <> nil then
  begin
    SendMessage(FHeader.Handle, WM_SETREDRAW, Ord(not Updating), 0);
    if not Updating then FHeader.Refresh;
  end;
end;

procedure THeaderStrings.WriteData(Writer: TWriter);
var
  I: Integer;
  HeaderSection: PHeaderSection;
  JStr         : String[1];
begin
  Writer.WriteListBegin;
  for I := 0 to Pred(Count) do
  begin
    HeaderSection := FList[I];
    with HeaderSection^ do
     Begin
      Case Just of
       taLeftJustify  : JStr:='L';
       taRightJustify : JStr:='R';
       taCenter       : JStr:='C';
      end;
      Writer.WriteString(Format(#0'%s%d'#0'%s', [JStr,Width, Title]));
     end;
  end;
  Writer.WriteListEnd;
end;

// start class TvtCustomHeader 

constructor TvtCustomHeader.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 Caption := ' ';
 ControlStyle := ControlStyle + [csDesignInteractive, csOpaque, csAcceptsControls];
 Width := 250;
 FSections := TEnhHeaderSections.Create(Self);
 FAllowResize := True;
 FBorderStyle := bsNone;
 BevelInner := bvLowered;
 BevelOuter := bvRaised;
 BevelWidth := 2;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self, True);
 {$EndIf}
end;

procedure TvtCustomHeader.Cleanup;
begin
 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf}
 FreeSections;
 l3Free(FSections);
 inherited;
end;

procedure TvtCustomHeader.AutoSizedSectionsResize;
var
 LastStart, I, Summ, NonResSumm, FirstASSect : Integer;
begin
 LastStart := -1;
 repeat
  FirstASSect := -1;
  Summ := 0;
  NonResSumm := 0;
  for I := 0 to Pred(Sections.Count) do
  begin
   if (I > LastStart) and (Sections[I].AutoResize) then
   begin
    if FirstASSect = -1 then
     FirstASSect := I;
    Inc(Summ, Sections[I].Width);
   end
   else
    Inc(NonResSumm, Sections[I].Width);
  end;
  if FirstAsSect <> -1 then
  begin
   if Summ = 0 then
    Summ := 20;
   Sections[FirstASSect].Width := Round(Sections[FirstASSect].Width * ((Width-NonResSumm)/Summ));
   if Sections[FirstASSect].Width < MinSectWidth then
    Sections[FirstASSect].Width := MinSectWidth;
   LastStart := FirstASSect;
  end;
 until FirstASSect = -1;
end;

procedure TvtCustomHeader.CreateParams(var Params: TCreateParams);
{const
  BorderStyles: array[TBorderStyle] of Longint = (0, WS_BORDER);}
begin
  inherited CreateParams(Params);
  If FBorderStyle = bsNone
   then Params.Style := Params.Style and not WS_BORDER
   else Params.Style := Params.Style or WS_BORDER;
    {BorderStyles[FBorderStyle];}
end;

procedure TvtCustomHeader.FreeSections;
begin
  if FSections <> nil then FSections.Clear;
end;

function TvtCustomHeader.GetSectJustification(X: Integer): TAlignment;
 begin
  if (X >= 0) and (X < FSections.Count)
   then Result := FSections[X].Alignment
   else Result := taLeftJustify;
 end;

function TvtCustomHeader.GetSectWidth(X: Integer): Integer;
var
  I, W: Integer;
begin
  if X = Pred(FSections.Count) then
  begin
    W := 0;
    for I := 0 to Pred(X) do
      Inc(W, FSections[I].Width);
    Result := ClientWidth - W;
  end
  else if (X >= 0) and (X < FSections.Count) then
    Result := FSections[X].Width
  else
    Result := 0;
end;

procedure TvtCustomHeader.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if ((csDesigning in ComponentState) and (Button = mbRight)) or (Button = mbLeft) then
    if FCanResize then SetCapture(Handle);
end;

procedure TvtCustomHeader.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 I      : Integer;
 AbsPos : Integer;
 Delta  : Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (GetCapture = Handle) and FCanResize then
  begin
    { absolute position of this item }
    AbsPos := 2;
    for I := 0 to FResizeSection do
      Inc(AbsPos, FSections[I].Width);

    {if FResizeSection > 0 then MinPos := AbsPos - FSections[FResizeSection].Width + 20
    else MinPos := 20;
    MaxPos := ClientWidth - 2;
    if X < MinPos then X := MinPos;
    if X > MaxPos then X := MaxPos;}

    {Dec(FSections[I].Width,
      (AbsPos - X - 2) - FMouseOffset);
    }
    Delta := (FMouseOffset - (AbsPos - X - 2));

    ResizeSection(FResizeSection, Delta);

   { if SectionWidth[FResizeSection+1] - Delta < MinSectWidth then
     Delta := SectionWidth[FResizeSection+1] - MinSectWidth;
    SectionWidth[FResizeSection]:=SectionWidth[FResizeSection] + Delta;

    SectionWidth[FResizeSection+1] := SectionWidth[FResizeSection+1] - Delta;}

    {Refresh;}
    Sizing(FResizeSection, Delta);
{      PHeaderSection(THeaderStrings(FSections).FList[FResizeSection])^.Width);}
    Invalidate;
  end;
end;

procedure TvtCustomHeader.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FCanResize then
  begin
    ReleaseCapture;
    Sized(FResizeSection,FSections[FResizeSection].Width);
    FCanResize := False;
  end else
    if (Button = mbLeft) then
      DoOnClickHeader(Point(X, Y));
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TvtCustomHeader.Paint(const CN: Il3Canvas);
var
  I, Y, W, II: Integer;
  J  : TAlignment;
  JW : Word;
  P  : String;
  R  : TRect;
  R1 : TRect;
begin
  with CN.Canvas do
  begin
    Font := Self.Font;
    Brush.Color := Color;
    R := ClientRect;
    FillRect(R);
    if BevelOuter = bvRaised then
     DrawEdge(Handle, R, BDR_RAISEDOUTER, BF_RECT);
    if BevelOuter = bvLowered then
     DrawEdge(Handle, R, BDR_SUNKENOUTER, BF_RECT);
    I := 0;
    Y := (ClientHeight - TextHeight('T')) div 2;
    R := Rect(0, 0, 0, ClientHeight);
    W := 0;
    J := taLeftJustify;
    P := '';
    II:= -1;
    repeat
      if I < FSections.Count then
      begin
        with FSections[I] do
        begin
          W := Width;
          P := Caption;
          J := Alignment;
        end;
        II:= DoOnGetItemImageIndex(I);
        Inc(I);
      end;
      JW := DT_LEFT;
      Case J of
       {taLeftJustify  : JW := DT_LEFT;}
       taRightJustify : JW := DT_RIGHT;
       taCenter       : JW := DT_CENTER;
      end;
      R.Left := R.Right;
      Inc(R.Right, W);
      if (ClientWidth - R.Right < 2) or (I = FSections.Count) then
        R.Right := ClientWidth;
      if (I > 0) and (I < FSections.Count) then
      begin
       if BevelInner in [bvSpace, bvNone] then
       begin
        if BevelOuter in [bvRaised, bvNone, bvSpace] then
         Pen.Color := clBtnShadow
        else
         Pen.Color := clBtnHighlight;
        MoveTo(Pred(R.Right), R.Bottom-2);
        LineTo(Pred(R.Right), R.Top);

        if BevelOuter in [bvRaised, bvNone, bvSpace] then
         Pen.Color := clBtnHighlight
        else
         Pen.Color := clBtnShadow;
        MoveTo(R.Right, R.Bottom-2);
        LineTo(R.Right, R.Top);
        Pen.Color :=Brush.Color;
       end;
      end;
      R1 := R;
      InflateRect(R1, -BevelWidth, -BevelWidth);
      if BevelWidth > 1 then
      begin
       if R.Left <> 0 then
        Dec(R1.Left, BevelWidth+1);
       if BevelInner = bvRaised then
        DrawEdge(Handle, R1, BDR_RAISEDOUTER, BF_RECT);
       if BevelInner = bvLowered then
        DrawEdge(Handle, R1, BDR_SUNKENOUTER, BF_RECT);
       InflateRect(R1, -1, -1);
       //Inc(R1.Top,Y-2);
      end
      else
      begin
       Inc(R1.Top,Y);
       InflateRect(R1, -3, 0);
      end;

      if (II <> -1) and (FImages <> nil) then
        if J = taRightJustify then begin
          FImages.Draw(CN.Canvas, R1.Left, R1.Top, II, True);
          R1.Left:= R1.Left + FImages.Width;
        end else begin
          R1.Right:= R1.Right - FImages.Width;
          FImages.Draw(CN.Canvas, R1.Right, R1.Top, II, True);
        end;

      If Length(P) > 0
       then DrawText(Handle, @P[1], Length(P), R1, JW or DT_NOPREFIX);
    until R.Right = ClientWidth;
  end;
  //inherited Paint(CN);
end;

procedure TvtCustomHeader.ResizeSection(Idx: Integer; Delta: Integer);
var
 lWidth: Integer;
 RealDelta: Integer;
 I, TmpDelta: Integer;

 function CalcLastSectionWidth: Integer;
 var
  I: Integer;
 begin
  Result := Width;
  for I := 0 to FSections.Count-2 do
   Result := Result - FSections[I].Width;
 end;


begin
 TmpDelta := Delta;
 // сначала считаем, насколько реально можно сдвинуть границы секций
 for I := Idx downto 0 do // слева от разделителя
 begin
  if TmpDelta = 0 then
   break;
  if (TmpDelta > 0) then
  begin
   if (FSections[I].Width + TmpDelta > FSections[I].MaxWidth) then
    Dec(TmpDelta, FSections[I].MaxWidth - FSections[I].Width)
   else
    TmpDelta := 0;
  end
  else
  begin
   if (FSections[I].Width + TmpDelta < FSections[I].MinWidth) then
    Inc(TmpDelta, FSections[I].Width - FSections[I].MinWidth)
   else
    TmpDelta := 0;
  end;
 end;
 TmpDelta := -Delta + TmpDelta;
 if TmpDelta <> 0 then
 begin
  for I := Idx+1 to Pred(FSections.Count) do // справа от разделителя
  begin
   if TmpDelta = 0 then
    break;
   if I = Pred(FSections.Count) then
    lWidth := CalcLastSectionWidth
   else
    lWidth := FSections[I].Width;
   if (TmpDelta > 0) then
   begin
    if lWidth + TmpDelta > FSections[I].MaxWidth then
     Dec(TmpDelta, FSections[I].MaxWidth - FSections[I].Width)
    else
     TmpDelta := 0;
   end
   else
   begin
    if (lWidth + TmpDelta < FSections[I].MinWidth) then
     Inc(TmpDelta, lWidth - FSections[I].MinWidth)
    else
     TmpDelta := 0;
   end;
  end;

  RealDelta := Delta + TmpDelta;

  TmpDelta := RealDelta;
  // а теперь - двигаем!
  for I := Idx downto 0 do // слева от разделителя
  begin
   if TmpDelta = 0 then
    break;
   if (TmpDelta > 0) then
   begin
    if (FSections[I].Width + TmpDelta > FSections[I].MaxWidth) then
    begin
     Dec(TmpDelta, FSections[I].MaxWidth - FSections[I].Width);
     FSections[I].Width := FSections[I].MaxWidth;
    end
    else
    begin
     FSections[I].Width := FSections[I].Width + TmpDelta;
     TmpDelta := 0;
    end;
   end
   else
   begin
    if (FSections[I].Width + TmpDelta < FSections[I].MinWidth) then
    begin
     Inc(TmpDelta, FSections[I].Width - FSections[I].MinWidth);
     FSections[I].Width := FSections[I].MinWidth;
    end
    else
    begin
     FSections[I].Width := FSections[I].Width + TmpDelta;
     TmpDelta := 0;
    end;
   end;
  end;
  TmpDelta := -RealDelta;
  for I := Idx+1 to Pred(FSections.Count) do // справа от разделителя
  begin
   if TmpDelta = 0 then
    break;
   if (TmpDelta > 0) then
   begin
    if (FSections[I].Width + TmpDelta > FSections[I].MaxWidth) then
    begin
     Dec(TmpDelta, FSections[I].MaxWidth - FSections[I].Width);
     FSections[I].Width := FSections[I].MaxWidth;
    end
    else
    begin
     FSections[I].Width := FSections[I].Width + TmpDelta;
     TmpDelta := 0;
    end;
   end
   else
   begin
    if (FSections[I].Width + TmpDelta < FSections[I].MinWidth) then
    begin
     Inc(TmpDelta, FSections[I].Width - FSections[I].MinWidth);
     FSections[I].Width := FSections[I].MinWidth;
    end
    else
    begin
     FSections[I].Width := FSections[I].Width + TmpDelta;
     TmpDelta := 0;
    end;
   end;
  end;
 end;
end;

procedure TvtCustomHeader.SetBorderStyle(Value: TBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TvtCustomHeader.SetSections(ASections: TEnhHeaderSections);
begin
  FSections.Assign(ASections);
end;

function TvtCustomHeader.SectionsStored: Boolean;
begin
 Result := (FSections <> nil) AND (FSections.Count > 0);
end;

procedure TvtCustomHeader.SetSectJustification(X: Integer; Value: TAlignment);
 begin
  if X < 0 then Exit;
  FSections[X].Alignment := Value;
  {
  PHeaderSection(THeaderStrings(FSections).FList[X])^.Just := Value;

  R:= l3RectBnd(l3Point(0,0), l3Point(Width,Height));
  If X > 0 then
   For I := 0 to Pred(X) do
    R.Left := R.Left + SectionWidth[I];
  if HandleAllocated then InvalidateRect(R);}
  {Invalidate;}
 end;

procedure TvtCustomHeader.SetSectWidth(X: Integer; Value: Integer);
begin
  if X < 0 then Exit;
  FSections[X].Width := Value;
  {
  R:= l3RectBnd(l3Point(0,0), l3Point(Width,Height));
  If X > 0 then
   For I:=0 to Pred(X) do
    R.Left := R.Left + SectionWidth[I];
  if HandleAllocated then InvalidateRect(R);
  {Invalidate;}
end;

procedure TvtCustomHeader.Sized(ASection, AWidth: Integer);
var
  {$IFDEF WIN32}
  Form: TCustomForm;
  {$ELSE WIN32}
  Form: TForm;
  {$ENDIF WIN32}
begin
  if Assigned(FOnSized) then FOnSized(Self, ASection, AWidth);
  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Designer.Modified;
  end;
end;

procedure TvtCustomHeader.Sizing(ASection, AWidth: Integer);
begin
  if Assigned(FOnSizing) then FOnSizing(Self, ASection, AWidth);
end;

procedure TvtCustomHeader.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  FHitTest := SmallPointToPoint(Msg.Pos);
end;

procedure TvtCustomHeader.WMSetCursor(var Msg: TWMSetCursor);
var
  Cur: HCURSOR;
  I: Integer;
  X: Integer;
begin
  Cur := 0;
  FResizeSection := 0;
  GetCursorPos(FHitTest); {V}
  FHitTest := ScreenToClient(FHitTest);
  X := 2;
  with Msg do
    if HitTest = HTCLIENT then
      for I := 0 to FSections.Count - 2 do  { don't count last section }
      begin
        Inc(X, FSections[I].Width);
        FMouseOffset := X - (FHitTest.X + 2);
        if Abs(FMouseOffset) < 4 then
        begin
          Cur := LoadCursor(0, IDC_SIZEWE);
          FResizeSection := I;
          Break;
        end;
      end;
  FCanResize := (FAllowResize or (csDesigning in ComponentState)) and (Cur <> 0);
  if FCanResize then SetCursor(Cur)
  else inherited;
end;

procedure TvtCustomHeader.WMSize(var Message: TMessage);
begin
 inherited;
 AutoSizedSectionsResize;
end;

procedure TvtCustomHeader.DoOnClickHeader(Point : TPoint);
begin
  if Assigned(FOnClickHeader) then
    FOnClickHeader(Self, CalcSectionIndex(Point), Point);
end;

function TvtCustomHeader.CalcSectionIndex(Point : TPoint): Integer;
var
  X : Integer;
begin
  Result := 0; X := Left + Sections.Items[Result].Width;
  while (Result < Sections.Count) and (X < Point.X) do
  begin
    Inc(Result);
    Inc(X, Sections.Items[Result].Width);
  end;
end;


function TvtCustomHeader.GetImages : TCustomImageList;
begin
  Result := fImages;
end;

procedure TvtCustomHeader.SetImages(Value : TCustomImageList);
begin
 if (FImages <> Value) then
 begin
  if (FImagesChangeLink <> nil) AND (FImagesChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   fImages := nil;
  if (FImages <> nil) then
   FImages.UnRegisterChanges(FImagesChangeLink);
  FImages := Value;
  if (fImages <> nil) then
  begin
   if (FImagesChangeLink = nil) then
   begin
    FImagesChangeLink := TChangeLink.Create;
    FImagesChangeLink.OnChange := ImagesChanged;
   end;//FImagesChangeLink = nil
   FImages.RegisterChanges(FImagesChangeLink);
  end//fImages <> nil
  else
    l3Free(FImagesChangeLink);
  ImagesChanged(nil);
 end;//FImages <> Value
end;

function TvtCustomHeader.ImagesStored: Boolean;
begin
  Result := (FImages <> nil);
end;

procedure TvtCustomHeader.ImagesChanged(Sender: TObject);
begin
  Invalidate;
end;

function TvtCustomHeader.DoOnGetItemImageIndex(aItemIndex : Longint): Integer;
begin
  Result := -1;
  if Assigned(FOnGetItemImageIndex) then
    Result := FOnGetItemImageIndex(Self, aItemIndex);
end;


{ TCheckGroupBox }

procedure TSectionData.SetAlignment(Value: TAlignment);
begin
 FAlignment := Value;
 Changed(False);
end;

{procedure TSectionData.SetCanResize(Value: Boolean);
begin
 FCanResize := Value;
end;
}

procedure TSectionData.SetCaption(Value: TCaption);
begin
 FCaption := Value;
 Changed(False);
end;

procedure TSectionData.SetWidth(Value: Integer);
begin
 FWidth := Value;
 Constrain;
end;

constructor TSectionData.Create(Collection: TCollection);
begin
 inherited;
 FWidth := DefaultSectionWidth;
 FAlignment := taLeftJustify;
 FMinWidth := MinSectWidth;
 FMaxWidth := MaxLongint;
 FCaption := '';
end;

{ TEnhHeaderSections }

constructor TEnhHeaderSections.Create(HeaderControl: TvtCustomHeader);
begin
 inherited Create(TSectionData);
 FHeaderControl := HeaderControl;
end;

function TEnhHeaderSections.GetItem(Index: Integer): TSectionData;
begin
 Result := TSectionData(inherited GetItem(Index));
end;

function TEnhHeaderSections.GetOwner: TPersistent;
begin
 Result := FHeaderControl;
end;

procedure TEnhHeaderSections.SetItem(Index: Integer; Value: TSectionData);
begin
 inherited SetItem(Index, Value);
end;

procedure TEnhHeaderSections.Update(Item: TCollectionItem);
begin
 FHeaderControl.Invalidate;
end;

function TEnhHeaderSections.Add: TSectionData;
begin
 Result := TSectionData(inherited Add);
end;

function TSectionData.GetDisplayName: string;
begin
 if FCaption = '' then
  Result := inherited GetDisplayName
 else
  Result := FCaption;
end;

procedure TSectionData.SetAutoResize(Value: Boolean);
begin
 FAutoResize := Value;
end;

procedure TSectionData.SetMinWidth(Value: Integer);
begin
 FMinWidth := Value;
 Constrain; 
end;

procedure TSectionData.Constrain;
begin
 if (FWidth < FMinWidth) then
  FWidth := FMinWidth;
 if (FWidth > FMaxWidth) then
  FWidth := FMaxWidth;
 Changed(False);
end;

procedure TSectionData.SetMaxWidth(Value: Integer);
begin
 FMaxWidth := Value;
 Constrain;
end;

procedure TvtCustomHeader.StyleTableChanged;
begin
 evGetDefaultFont(Font);
end;

procedure TvtCustomHeader.DefineHeight;
var
 l_Height: Integer;
begin
 with l3CrtIC do
 begin
  Lock;
  try
   Font.AssignFont(Self.Font);
   l_Height := LP2DP(TextExtent(l3PCharLen('W'))).Y + 2;
   if (BevelInner <> bvNone) and (BevelOuter <> bvNone) then
    l_Height := l_Height + BevelWidth * 2; 
   Self.Height := l_Height;
  finally
   l3CrtIC.UnLock;
  end;{try..finally}
 end;//with l3CrtIC do
end;//DefineHeight

procedure TvtCustomHeader.CMFontChanged(var Message: TMessage);
begin
 inherited;
 DefineHeight;
end;

procedure TvtCustomHeader.pm_SetBevelInner(Value: TPanelBevel);
begin
 inherited;
 DefineHeight;
end;

procedure TvtCustomHeader.pm_SetBevelOuter(Value: TPanelBevel);
begin
 inherited;
 DefineHeight;
end;

procedure TvtCustomHeader.pm_SetBevelWidth(Value: TBevelWidth);
begin
 inherited;
 DefineHeight;
end;

end.


