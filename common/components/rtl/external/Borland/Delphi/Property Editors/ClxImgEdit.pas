{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Visual Component Library               }
{ Component and Property Editor Source                                   }
{                                                                        }
{ Copyright (C) 2000, 2001 Borland Software Corporation                  }
{                                                                        }
{ All Rights Reserved.                                                   }
{                                                                        }
{ ********************************************************************** }


unit ClxImgEdit;

interface

uses
  SysUtils, QGraphics, QForms, QStdCtrls, QExtCtrls,
  QControls, Classes, QDialogs, QComCtrls, QImgList, Qt, Types, QTypes;

type
  TClxImageListEditor = class;

  TImageOperation = (ioCrop, ioStretch, ioCenter);

  TImageInfo = class(TObject)
  private
    FAutoOp: Boolean;
    FOperation: TImageOperation;
    FOwner: TList;
    FOwnerForm: TClxImageListEditor;
    FCanChangeTransparent: Boolean;
    FCanChangeFill: Boolean;
    FBitmap: TBitmap;
    FMask: TBitmap;
    FNew: Boolean;
    FTransparentColor: TColor;
    FFillColor: TColor;
    procedure Center;
    procedure Crop;
    function GetIndex: Integer;
    procedure SetOperation(Value: TImageOperation);
    procedure SetFillColor(Value: TColor);
    procedure SetTransparentColor(Value: TColor);
    procedure Stretch;
  public
    constructor Create(AOwner: TList; AOwnerForm: TClxImageListEditor);
    destructor Destroy; override;
    procedure Change;
    procedure SelectImage;
    property Bitmap: TBitmap read FBitmap;
    property Mask: TBitmap read FMask;
    property New: Boolean read FNew;
    property CanChangeFill: Boolean read FCanChangeFill;
    property CanChangeTransparent: Boolean read FCanChangeTransparent;
    property FillColor: TColor read FFillColor write SetFillColor;
    property Index: Integer read GetIndex;
    property Operation: TImageOperation read FOperation write SetOperation;
    property Owner: TList read FOwner;
    property OwnerForm: TClxImageListEditor read FOwnerForm;
    property TransparentColor: TColor read FTransparentColor write SetTransparentColor;
  end;

  TClxImageListEditor = class(TForm)
    OK: TButton;
    Cancel: TButton;
    ImageGroup: TGroupBox;
    MainPanel: TPanel;
    MainImage: TImage;
    OpenDialog: TOpenDialog;
    OptionsGroup: TRadioGroup;
    Apply: TButton;
    TransparentColor: TComboBox;
    TransparentLabel: TLabel;
    FillLabel: TLabel;
    FillColor: TComboBox;
    Help: TButton;
    GroupBox1: TGroupBox;
    ImageView: TIconView;
    Add: TButton;
    Delete: TButton;
    Clear: TButton;
    ExportBtn: TButton;
    SaveDialog: TSaveDialog;
    procedure AddClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OptionsGroupClick(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure TransparentColorChange(Sender: TObject);
    procedure TransparentColorExit(Sender: TObject);
    procedure ImageViewChange(Sender: TObject; Item: TIconViewItem;
      Change: TItemChange);
    procedure ImageViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpClick(Sender: TObject);
    procedure MainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ExportBtnClick(Sender: TObject);
    procedure ImageViewSelectItem(Sender: TObject; Item: TIconViewItem;
      Selected: Boolean);
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageViewEdited(Sender: TObject; Item: TIconViewItem;
      var NewName: WideString);
  private
    FChanging, FSelecting: Boolean;
    FComponentList: TImageList;
    FInfoList: TList;
    FImageList, FImageListView: TImageList;
    FImageBitmap: TBitmap;
    FDragImageList: TImageList;
    FImageXDivOffset: Integer;
    FImageYDivOffset: Integer;
    procedure AddColor(const S: string);
    procedure ClearBitmap(Value: TBitmap; Color: TColor);
    procedure ClearAllImages;
    procedure ClearWithFill(Bitmap: TBitmap; Index: Integer);
    procedure DeleteSelectedImages;
    procedure FocusImage(Index, Count: Integer);
    function GetImageInfo(Index: Integer): TImageInfo;
    function GetIndex: Integer;
    procedure MoveImage(FromIndex, ToIndex: Integer);
    procedure Replace(Index: Integer; Image, Mask: TBitmap);
    procedure ReplaceMasked(Index: Integer; NewImage: TBitmap; MaskColor: TColor);
    procedure SetImageOperation(Operation: TImageOperation);
    procedure SetImageColor(Color: TColor; Fill: Boolean);
    function SetStates: Boolean;
    procedure StretchImageList(SrcList, DstList: TImageList; Width, Height: Integer);
    procedure CenterImageList(SrcList, DstList: TImageList; Width, Height: Integer);
    procedure UpdateImageView;
    procedure StretchReplace(List: TImageList; Index: Integer; Image, Mask: TBitmap);
    procedure StretchReplaceMasked(List: TImageList; Index: Integer; Image: TBitmap; MaskColor: TColor);
    procedure CenterReplace(List: TImageList; Index: Integer; Image, Mask: TBitmap);
    procedure CenterReplaceMasked(List: TImageList; Index: Integer; Image: TBitmap; MaskColor: TColor);
    procedure DoImageListViewChange(Sender: TObject);
    procedure UpdatePickColor(X, Y: Integer);
  public
    constructor CreateImgListEditor(AOwner: TComponent; AImgList: TImageList);
    procedure AddBitmap;
    procedure Center(Index: Integer);
    procedure Crop(Index: Integer);
    procedure SelectImage(Index: Integer);
    procedure Stretch(Index: Integer);
    property DragImageList: TImageList read FDragImageList write FDragImageList;
    property ImageBitmap: TBitmap read FImageBitmap;
    property Index: Integer read GetIndex;
    property InfoList: TList read FInfoList;
    property ImageList: TImageList read FImageList;
    property ImageListView: TImageList read FImageListView;
    property Items[Index: Integer]: TImageInfo read GetImageInfo;
    property ComponentList: TImageList read FComponentList;
  end;

function EditImageList(AImageList: TImageList): Boolean;

implementation

{$R *.xfm}

{$R *.res}

uses
  TypInfo, DsnConst, LibHelp;

procedure GetImages(ImageList: TImageList; Index: Integer; Image, Mask: TBitmap);
var
  R: TRect;
begin
  with ImageList do
  begin
    R := Rect(0, 0, Width, Height);
    Image.Width := Width;
    Image.Height := Height;
    Mask.Width := Width;
    Mask.Height := Height;
  end;
  with Image.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(R);
    ImageList.Draw(Image.Canvas, 0, 0, Index);
  end;
  with Mask.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(R);
    ImageList.Draw(Mask.Canvas, 0, 0, Index, itMask);
  end;
end;

function EditImageList(AImageList: TImageList): Boolean;
var
  I: Integer;
  ListItems: TClxImageListEditor;
begin
  ListItems := TClxImageListEditor.CreateImgListEditor(Application, AImageList);
  with ListItems do
    try
      Screen.Cursor := crHourglass;
      try
        if AImageList.Width = 0 then
          FImageXDivOffset := 1
        else
          FImageXDivOffset := MainImage.Width div AImageList.Width;
        if AImageList.Height = 0 then
          FImageYDivOffset := 1
        else
          FImageYDivOffset := MainImage.Height div AImageList.Height;
        if FImageXDivOffset = 0 then
          FImageXDivOffset := 1;
        if FImageYDivOffset = 0 then
          FImageYDivOffset := 1;
        FComponentList := AImageList;
        FImageList.Assign(ComponentList);
        with FImageListView do
        begin
          Assign(FImageList);
          if (Width > 24) or (Height > 24) then StretchImageList(FImageList,
            FImageListView, 24, 24)
          else if (Width < 24) and (Height < 24) then CenterImageList(FImageList,
            FImageListView, 24, 24);
        end;
        ImageList.Clear;
        with ImageBitmap do
        begin
          Height := ImageList.Height;
          Width := ImageList.Width;
        end;
        for I := 0 to ComponentList.Count - 1 do
          with TImageInfo.Create(InfoList, ListItems) do
          begin
            FNew := False;
            FAutoOp := False;
            GetImages(ComponentList, I, FBitmap, FMask);
            TransparentColor := clDefault;
            Change;
          end;
        if SetStates then
          ActiveControl := ImageView
        else
          ActiveControl := Add;
        UpdateImageView;
        SelectImage(0);
        FocusImage(0, 0);
        Apply.Enabled := False;
      finally
        Screen.Cursor := crDefault;
      end;
      Caption := Format(SImageListEditorCaption, [AImageList.Owner.Name, DotSep,
        AImageList.Name]);
      Result := ShowModal = mrOk;
      if Result and Apply.Enabled then
        ApplyClick(nil);
    finally
      Free;
    end;
end;

{ TImageInfo }

constructor TImageInfo.Create(AOwner: TList; AOwnerForm: TClxImageListEditor);
begin
  inherited Create;
  FOwner := AOwner;
  FOwnerForm := AOwnerForm;
  Owner.Add(Self);
  FBitmap := TBitmap.Create;
  FMask := TBitmap.Create;
  FNew := True;
  FAutoOp := True;
  OwnerForm.AddBitmap;
  FTransparentColor := clNone;
  FFillColor := clBtnFace;
end;

destructor TImageInfo.Destroy;
begin
  Owner.Remove(Self);
  FOwner := nil;
  FMask.Free;
  FBitmap.Free;
  inherited Destroy;
end;

function TImageInfo.GetIndex: Integer;
begin
  Result := Owner.IndexOf(Self);
end;

procedure TImageInfo.Crop;
begin
  OwnerForm.Crop(Index);
end;

procedure TImageInfo.Stretch;
begin
  OwnerForm.Stretch(Index);
end;

procedure TImageInfo.Center;
begin
  OwnerForm.Center(Index);
end;

procedure TImageInfo.SelectImage;
begin
  OwnerForm.SelectImage(Index);
end;

procedure TImageInfo.SetOperation(Value: TImageOperation);
begin
  if Value <> Operation then
  begin
    FOperation := Value;
    Change;
  end;
end;

procedure TImageInfo.SetTransparentColor(Value: TColor);
begin
  if Value <> TransparentColor then
  begin
    FTransparentColor := Value;
    Change;
  end;
end;

procedure TImageInfo.SetFillColor(Value: TColor);
begin
  if Value <> FillColor then
  begin
    FFillColor := Value;
    Change;
  end;
end;

procedure TImageInfo.Change;
begin
  if not FOwnerForm.FChanging then
  begin
    FOwnerForm.FChanging := True;
    try
      if FAutoOp then
      begin
        if (Bitmap.Width < FOwnerForm.ImageBitmap.Width) and
        (Bitmap.Height < FOwnerForm.ImageBitmap.Height) then
          FOperation := ioCenter
        else if (Bitmap.Width > FOwnerForm.ImageBitmap.Width) or
        (Bitmap.Height > FOwnerForm.ImageBitmap.Height) then
          FOperation := ioStretch
        else
          FOperation := ioCrop;
        FFillColor := FTransparentColor;
        FAutoOp := False;
      end;
      case Operation of
        ioCrop: Crop;
        ioStretch: Stretch;
        ioCenter: Center;
      end;
    finally
      FOwnerForm.FChanging := False;
    end;
  end;
end;

{ TClxImageListEditor }

constructor TClxImageListEditor.CreateImgListEditor(AOwner: TComponent; AImgList: TImageList);
begin
  inherited Create(AOwner);
  FComponentList := AImgList;
end;

function TClxImageListEditor.SetStates: Boolean;
begin
  Result := InfoList.Count > 0;
  Delete.Enabled := Result;
  Clear.Enabled := Result;
  ExportBtn.Enabled := Result;
  OptionsGroup.Enabled := Result;
  TransparentColor.Enabled := Result;
  TransparentLabel.Enabled := Result;
  FillColor.Enabled := Result;
  FillLabel.Enabled := Result;
end;

procedure TClxImageListEditor.UpdateImageView;
const
  NewState: array[Boolean] of Integer = (-1, 0);
var
  I: Integer;
  S: string;
  Items: TIconViewItems;
begin
  if not FSelecting then
  begin
    FSelecting := True;
    try
      Items := ImageView.Items;
      Items.BeginUpdate;
      try
        for I := 0 to FInfoList.Count - 1 do
        begin
          S := IntToStr(I);
          if Items.Count <= I then
          begin
            { Add }
            with Items.Add do
            begin
              Caption := S;
              ImageIndex := I;
            end;
          end
          else
          begin
            { Update }
            Items[I].Caption := S;
            Items[I].ImageIndex := I;
          end;
        end;
        while Items.Count > FInfoList.Count do
          Items[Items.Count - 1].Free;
      finally
        Items.EndUpdate;
      end;
    finally
      FSelecting := False;
    end;
  end;
end;

procedure TClxImageListEditor.AddBitmap;
begin
  ImageList.Add(nil, nil);
  ImageListView.Add(nil, nil);
end;

procedure TClxImageListEditor.AddClick(Sender: TObject);
var
  Modified: Boolean;
  Picture: TPicture;
  I, X, Y: Integer;
  IWidth, IHeight: Integer;
  NewBitmaps: TList;
  NewBitmap, NewBitmap1: TBitmap;
  SubDivideX, SubDivideY: Boolean;
  DivideX, DivideY: Integer;
  DialogResult: TModalResult;
  AddCount: Integer;
begin
  with OpenDialog do
  begin
    Title := SAddImagesTitle;
    HelpContext := hcDLoadPicture;
    HelpType := htContext;
    Width := Self.Width;
    Filter := Filter + GraphicFilter(TIcon, True);
    if Execute then
    begin
      Modified := False;
      Picture := TPicture.Create;
      NewBitmaps := TList.Create;
      NewBitmap := TBitmap.Create;
      { Add at least one bitmap and mask }
      NewBitmaps.Add(NewBitmap);
      AddCount := 0;
      Screen.Cursor := crHourglass;
      try
        DialogResult := mrYes;
        ImageView.Selected := nil;
        for I := 0 to Files.Count - 1 do
        begin
          Picture.LoadFromFile(Files[I]);
          if Picture.Graphic is TIcon then
          begin
            NewBitmap1 := TBitmap.Create;
            try
              NewBitmap1.Assign(Picture.Graphic);
              Picture.Bitmap.Assign(NewBitmap1);
            finally
              FreeAndNil(NewBitmap1);
            end;
          end;
          IWidth := ImageBitmap.Width;
          IHeight := ImageBitmap.Height;
          if Picture.Graphic is TBitmap then
          begin
            { Find out if the new image is a list of bitmaps to be extracted }
            SubDivideX := (Picture.Graphic.Width > IWidth) and
              (Picture.Graphic.Width mod IWidth = 0);
            SubDivideY := (Picture.Graphic.Height > IHeight) and
              (Picture.Graphic.Height mod IHeight = 0);
            if SubDivideX then
              DivideX := Picture.Graphic.Width div IWidth
            else
              DivideX := 1;
            if SubDivideY then
              DivideY := Picture.Graphic.Height div IHeight
            else
              DivideY := 1;

            if SubDivideX or SubDivideY then
            begin
              if not (DialogResult in [mrNoToAll, mrYesToAll]) then
                DialogResult := MessageDlg(Format(SImageListDivide,
                  [ExtractFileName(Files[I]), DivideX * DivideY]), mtInformation,
                  [mbYes, mbNo], 0);
            end
            else
              if DialogResult = mrYes then DialogResult := mrNo;

            if DialogResult in [mrNo, mrNoToAll] then
            begin
              DivideX := 1;
              DivideY := 1;
              IWidth := Picture.Bitmap.Width;
              IHeight := Picture.Bitmap.Height;
            end;

            if DivideX * DivideY > NewBitmaps.Capacity then
              NewBitmaps.Capacity := DivideX * DivideY;
            for Y := 0 to DivideY - 1 do
              for X := 0 to DivideX - 1 do
              begin
                { Add new bitmap if necessary }
                if NewBitmaps.Count <= (Y * DivideX + X) then
                begin
                  NewBitmap := TBitmap.Create;
                  NewBitmaps.Add(NewBitmap);
                end
                else
                  NewBitmap := TBitmap(NewBitmaps[Y * DivideX + X]);
                NewBitmap.Assign(Nil);
                NewBitmap.Height := IHeight;
                NewBitmap.Width := IWidth;
                NewBitmap.Canvas.CopyRect(Rect(0, 0, NewBitmap.Width,
                  NewBitmap.Height), Picture.Bitmap.Canvas,
                  Rect(X * IWidth, Y * IHeight, (X + 1) * IWidth,
                  (Y + 1) * IHeight));
              end;
            for X := 0 to DivideX * DivideY - 1 do
              with TImageInfo.Create(InfoList, Self) do
              try
                NewBitmap := TBitmap(NewBitmaps[X]);
                FChanging := True;
                try
                  FCanChangeTransparent := True;
                  FCanChangeFill := (NewBitmap.Height < ImageList.Height) or
                    (NewBitmap.Width < ImageList.Width);
                  TransparentColor := NewBitmap.TransparentColor;
                  Bitmap.Assign(NewBitmap);
                  Mask.Assign(nil);
                finally
                  FChanging := False;
                  Change;
                end;
                Inc(AddCount);
              except
                Free;
                raise;
              end;
          end
          else
            raise EInvalidGraphic.Create(SImageListGraphicUnsupported);
          Modified := True;
        end;
      finally
        Screen.Cursor := crDefault;
        for I := 0 to NewBitmaps.Count - 1 do TBitmap(NewBitmaps[I]).Free;
        NewBitmaps.Free;
        Picture.Free;
        if Modified then
        begin
          SetStates;
          UpdateImageView;
          SelectImage(InfoList.Count - 1);
          FocusImage(InfoList.Count - 1, AddCount);
          QIconView_arrangeItemsInGrid(ImageView.Handle, True);
          Apply.Enabled := True;
        end;
      end;
    end;
  end;
end;

procedure TClxImageListEditor.DeleteClick(Sender: TObject);
begin
  DeleteSelectedImages;
  SelectImage(Index);
  if not SetStates then
    Add.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxImageListEditor.ClearClick(Sender: TObject);
begin
  ClearAllImages;
  SelectImage(-1);
  if not SetStates then
    Add.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxImageListEditor.FormCreate(Sender: TObject);
begin
  FImageBitmap := TBitmap.Create;
  FInfoList := TList.Create;
  FImageList := TImageList.CreateSize(FComponentList.Width, FComponentList.Height);
  FImageListView := TImageList.CreateSize(24, 24);
  GetColorValues(AddColor);
  TransparentColor.ItemIndex := -1;
  FillColor.ItemIndex := -1;
  ClearBitmap(ImageBitmap, clBtnHighlight);
  ImageView.Images := FImageListView;
  FImageListView.OnChange := DoImageListViewChange;
  Self.HelpContext := hcDImageListEditor;
  HelpType := htContext;
end;

procedure TClxImageListEditor.AddColor(const S: string);
begin
  TransparentColor.Items.Add(S);
  FillColor.Items.Add(S);
end;

procedure TClxImageListEditor.FormDestroy(Sender: TObject);
begin
  while FInfoList.Count > 0 do
    TImageInfo(FInfoList.Last).Free;
  FImageList.Free;
  FImageListView.Free;
  FImageBitmap.Free;
end;

procedure TClxImageListEditor.SelectImage(Index: Integer);
var
  S: string;
begin
  if not FSelecting then
  begin
    FSelecting := True;
    try
      if (Index >= 0) and (InfoList.Count > 0) and (Index < InfoList.Count) then
      begin
        OptionsGroup.ItemIndex := Ord(Items[Index].Operation);
        if not Items[Index].New then
        begin
          S := ColorToString(clNone);
          TransparentColor.Text := S;
          FillColor.Text := S;
          FillColor.Enabled := False;
          FillLabel.Enabled := False;
          OptionsGroup.Enabled := False;
          TransparentColor.Enabled := False;
          TransparentLabel.Enabled := False;
          MainImage.Cursor := crDefault;
        end
        else
        begin
          TransparentColor.Text := ColorToString(Items[Index].TransparentColor);
          FillColor.Text := ColorToString(Items[Index].FillColor);
          FillColor.Enabled := Items[Index].CanChangeFill;
          FillLabel.Enabled := FillColor.Enabled;
          OptionsGroup.Enabled := Items[Index].CanChangeTransparent;
          TransparentColor.Enabled := OptionsGroup.Enabled;
          TransparentLabel.Enabled := OptionsGroup.Enabled;
        end;

        FImageBitmap.Assign(nil);
        ImageList.GetBitmap(Index, FImageBitmap);
        MainImage.Picture.Assign(nil);
        ImageList.GetBitmap(Index, MainImage.Picture.Bitmap);
      end
      else
      begin
        OptionsGroup.ItemIndex := 0;
        ClearWithFill(ImageBitmap, -1);
        MainImage.Picture.Assign(nil);
        MainImage.Cursor := crDefault;
      end;
    finally
      FSelecting := False;
    end;
  end;
end;

procedure TClxImageListEditor.ClearWithFill(Bitmap: TBitmap; Index: Integer);
begin
  if (Index >= 0) and (InfoList.Count > 0) and (Index < InfoList.Count) then
    ClearBitmap(Bitmap, Items[Index].FillColor) else
  ClearBitmap(Bitmap, clBtnHighlight);
end;

function TClxImageListEditor.GetIndex: Integer;
var
  ListItem: TIconViewItem;
begin
  ListItem := ImageView.Selected;
  if ListItem <> nil then
    Result := ListItem.Index else
    Result := -1;
end;

function TClxImageListEditor.GetImageInfo(Index: Integer): TImageInfo;
begin
  Result := FInfoList[Index];
end;

procedure TClxImageListEditor.Crop(Index: Integer);
var
  MaxX, MaxY: Integer;
  R: TRect;
begin
  MaxX := ImageBitmap.Width;
  MaxY := ImageBitmap.Height;
  with Items[Index].Bitmap do
  begin
    if Width < MaxX then MaxX := Width;
    if Height < MaxY then MaxY := Height;
    R := Rect(0, 0, MaxX, MaxY);
    ClearWithFill(ImageBitmap, Index);
    MainImage.Picture.Assign(nil);
    ImageBitmap.Canvas.CopyRect(R, Canvas, R);
    if Items[Index].New and Items[Index].Mask.Empty then
      if Items[Index].TransparentColor = clNone then
        Replace(Index, ImageBitmap, nil)
      else
        ReplaceMasked(Index, ImageBitmap, ColorToRGB(Items[Index].TransparentColor))
    else
      Replace(Index, ImageBitmap, Items[Index].Mask);
  end;
  Apply.Enabled := True;
end;

procedure TClxImageListEditor.Stretch(Index: Integer);
var
  ImageMask: TBitmap;
begin
  MainImage.Picture.Assign(nil);

  with ImageBitmap, Items[Index] do
  begin
    ClearBitmap(ImageBitmap, FillColor);
    Canvas.StretchDraw(Rect(0, 0, Width, Height), Bitmap);
    if Items[Index].New and Items[Index].Mask.Empty then
      if Items[Index].TransparentColor = clNone then
        Replace(Index, ImageBitmap, nil)
      else
        ReplaceMasked(Index, ImageBitmap, ColorToRGB(Items[Index].TransparentColor))
    else
    begin
      ImageMask := TBitmap.Create;
      ImageMask.Width := Width;
      ImageMask.Height := Height;
      ImageMask.Canvas.StretchDraw(Rect(0, 0, Width, Height), Mask);
      Replace(Index, ImageBitmap, ImageMask);
      ImageMask.Free;
    end;
  end;
  Apply.Enabled := True;
end;

procedure TClxImageListEditor.Center(Index: Integer);
var
  R: TRect;
  ImageMask: TBitmap;
begin
  MainImage.Picture.Assign(nil);

  with Items[Index] do
  begin
    R := Bounds((ImageBitmap.Width - Bitmap.Width) div 2,
      (ImageBitmap.Height - Bitmap.Height) div 2, Bitmap.Width, Bitmap.Height);
    ClearBitmap(ImageBitmap, Items[Index].FillColor);
    ImageBitmap.Canvas.StretchDraw(R, Bitmap);
    if New and Mask.Empty then
      if Items[Index].TransparentColor = clNone then
        Replace(Index, ImageBitmap, nil)
      else
        ReplaceMasked(Index, ImageBitmap, ColorToRGB(TransparentColor))
    else
    begin
      ImageMask := TBitmap.Create;
      ImageMask.Width := Width;
      ImageMask.Height := Height;
      ImageMask.Canvas.StretchDraw(Rect(0, 0, Width, Height), Mask);
      Replace(Index, ImageBitmap, ImageMask);
      ImageMask.Free;
    end;
  end;
  Apply.Enabled := True;
end;

procedure TClxImageListEditor.OptionsGroupClick(Sender: TObject);
begin
  if not (FChanging or FSelecting) then
    SetImageOperation(TImageOperation(OptionsGroup.ItemIndex));
end;

procedure TClxImageListEditor.ApplyClick(Sender: TObject);
var
  TempImageList: TImageList;
begin
  Screen.Cursor := crHourglass;
  try
    TempImageList := TImageList.Create(Application);
    TempImageList.Assign(ImageList);
    ComponentList.Assign(TempImageList);
    TempImageList.Free;
    Apply.Enabled := False;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TClxImageListEditor.TransparentColorChange(Sender: TObject);
begin
  if not (FChanging or FSelecting) and (Sender is TComboBox) then
    if TComboBox(Sender).Items.IndexOf(TComboBox(Sender).Text) <> -1 then
      SetImageColor(StringToColor(TComboBox(Sender).Text), Sender = FillColor);
end;

procedure TClxImageListEditor.ClearBitmap(Value: TBitmap; Color: TColor);
begin
  if (Value.Width > 0) and (Value.Height > 0) then
  begin
    Value.Canvas.Brush.Color := Color;
    Value.Canvas.Brush.Style := bsSolid;
    Value.Canvas.FillRect(Rect(0, 0, Value.Width, Value.Height));
  end;
end;

procedure TClxImageListEditor.TransparentColorExit(Sender: TObject);
var
  Color: TColor;
begin
  if Sender is TComboBox then
  begin
    Color := StringToColor(TComboBox(Sender).Text);
    SetImageColor(Color, Sender = FillColor);
  end;
end;

procedure TClxImageListEditor.Replace(Index: Integer; Image, Mask: TBitmap);
begin
  ImageList.Replace(Index, Image, Mask);
  // adjust if necessary
  with FImageListView do
    if (Image.Width > Width) or (Image.Height > Height) then
      StretchReplace(FImageListView, Index, Image, Mask)
    else if (Image.Width < Width) and (Image.Height < Height) then
      CenterReplace(FImageListView, Index, Image, Mask)
    else FImageListView.Replace(Index, Image, Mask);
end;

procedure TClxImageListEditor.ReplaceMasked(Index: Integer; NewImage: TBitmap;
  MaskColor: TColor);
begin
  ImageList.ReplaceMasked(Index, NewImage, MaskColor);
  // adjust if necessary
  with FImageListView do
    if (NewImage.Width > Width) or (NewImage.Height > Height) then
      StretchReplaceMasked(FImageListView, Index, NewImage, MaskColor)
    else if (NewImage.Width < Width) and (NewImage.Height < Height) then
      CenterReplaceMasked(FImageListView, Index, NewImage, MaskColor)
    else FImageListView.ReplaceMasked(Index, NewImage, MaskColor);
end;

procedure TClxImageListEditor.DeleteSelectedImages;
var
  Item: TIconViewItem;
  I: Integer;
begin
  Screen.Cursor := crHourglass;
  try
    Item := ImageView.Selected;
    if Item <> nil then
    begin
      ImageList.Delete(Item.Index);
      ImageListView.Delete(Item.Index);
      TImageInfo(InfoList[Item.Index]).Free;
      Item.Free;
    end;
    I := 0;
    while I < ImageView.Items.Count do
    begin
      Item := ImageView.Items[I]; 
      if Item.Selected then
      begin
        ImageList.Delete(Item.Index);
        ImageListView.Delete(Item.Index);
        TImageInfo(InfoList[Item.Index]).Free;
        Item.Free;
      end
      else
        Inc(I);
    end;
{
    while ImageView.SelCount > 0 do
    begin
      Item := ImageView.Selected;
      if Item <> nil then
      begin
        ImageList.Delete(Item.Index);
        ImageListView.Delete(Item.Index);
        TImageInfo(InfoList[Item.Index]).Free;
        Item.Free;
      end;
    end;
}
    UpdateImageView;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TClxImageListEditor.ClearAllImages;
begin
  Screen.Cursor := crHourglass;
  try
    //ImageView.Items.BeginUpdate;
    try
      ImageView.Items.Clear;
    finally
      //ImageView.Items.EndUpdate;
    end;
    ImageList.Clear;
    ImageListView.Clear;
    while InfoList.Count > 0 do TImageInfo(InfoList[0]).Free;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TClxImageListEditor.ImageViewChange(Sender: TObject;
  Item: TIconViewItem; Change: TItemChange);
begin
{
  case Change of
    ctState: if not (csDestroying in ComponentState) then SelectImage(Item.Index);
  end;
}
end;

procedure TClxImageListEditor.FocusImage(Index, Count: Integer);
var
  Item: TIconViewItem;
  I: Integer;
begin
  with ImageView do
  begin
    Selected := nil;
    Item := nil;
    for I := Items.Count - 1 downto Items.Count - Count do
      Items[I].Selected := True;
    if Items.Count > 0 then
      Item := Items[Index];
    Selected := Item;
    if Assigned(Item) then
      Item.MakeVisible;
  end;
end;

procedure TClxImageListEditor.ImageViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Key_Delete) and Delete.Enabled and (not ImageView.IsEditing) then
    Delete.Click            ;
end;

procedure TClxImageListEditor.MoveImage(FromIndex, ToIndex: Integer);
begin
  InfoList.Move(FromIndex, ToIndex);
  ImageList.Move(FromIndex, ToIndex);
  ImageListView.Move(FromIndex, ToIndex);
  ImageView.Items[FromIndex].ImageIndex := -1;
  ImageView.Items[ToIndex].ImageIndex := -1;
  UpdateImageView;
  Apply.Enabled := True;
end;

procedure TClxImageListEditor.SetImageOperation(Operation: TImageOperation);
var
  Item: TIconViewItem;
begin
  Screen.Cursor := crHourglass;
  try
    Item := ImageView.Selected;
    if Item <> nil then
    begin
      Items[Item.Index].Operation := Operation;
    end;
    Item := ImageView.Selected;
    while Item <> nil do
    begin
      Items[Item.Index].Operation := Operation;
      Item := ImageView.GetNextItem(Item, sdAll, [isSelected]);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TClxImageListEditor.SetImageColor(Color: TColor; Fill: Boolean);
var
  Item: TIconViewItem;
  OldCur: TCursor;
begin
  OldCur := Screen.Cursor;
  try
    Screen.Cursor := crHourglass;
    Item := ImageView.Selected;
    if Assigned(Item) then
      if Fill then
        Items[Item.Index].FillColor := Color
      else
        Items[Item.Index].TransparentColor := Color;
    Item := ImageView.GetNextItem(Item, sdAll, [isSelected]);
    while Item <> nil do
    begin
      Items[Item.Index].TransparentColor := Color;
      Item := ImageView.GetNextItem(Item, sdAll, [isSelected]);
    end;
  finally
    Screen.Cursor := OldCur;
  end;
end;

procedure TClxImageListEditor.StretchImageList(SrcList, DstList: TImageList; Width,
  Height: Integer);
var
  I: Integer;
  Image, Mask: TBitmap;
begin
  DstList.Width := Width;
  DstList.Height := Height;
  Image := TBitmap.Create;
  Mask := TBitmap.Create;
  try
    for I := 0 to SrcList.Count - 1 do
    begin
      GetImages(SrcList, I, Image, Mask);
      DstList.Add(nil, nil);
      StretchReplace(DstList, I, Image, Mask);
    end;
  finally
    Mask.Free;
    Image.Free;
  end;
end;

procedure TClxImageListEditor.CenterImageList(SrcList, DstList: TImageList; Width,
  Height: Integer);
var
  I: Integer;
  Image, Mask: TBitmap;
begin
  DstList.Width := Width;
  DstList.Height := Height;
  Image := TBitmap.Create;
  Mask := TBitmap.Create;
  try
    for I := 0 to SrcList.Count - 1 do
    begin
      GetImages(SrcList, I, Image, Mask);
      DstList.Add(nil, nil);
      CenterReplace(DstList, I, Image, Mask);
    end;
  finally
    Mask.Free;
    Image.Free;
  end;
end;

const
  MaskBackground: array[Boolean] of TColor = (clWhite, clBlack);

procedure TClxImageListEditor.StretchReplace(List: TImageList; Index: Integer;
  Image, Mask: TBitmap);
var
  NewImage, NewMask: TBitmap;
begin
  NewImage := TBitmap.Create;
  NewMask := TBitmap.Create;
  try
    NewImage.Width := List.Width;
    NewImage.Height := List.Height;
    NewImage.Canvas.StretchDraw(Rect(0, 0, List.Width, List.Height), Image);
    NewMask.Width := List.Width;
    NewMask.Height := List.Height;
    NewMask.Canvas.Brush.Color := MaskBackground[Mask = nil];
    NewMask.Canvas.FillRect(Rect(0,0,List.Width,List.Height));
    if Mask <> nil then
      NewMask.Canvas.StretchDraw(Rect(0, 0, List.Width, List.Height), Mask);
    List.Replace(Index, NewImage, NewMask);
  finally
    NewImage.Free;
    NewMask.Free;
  end;
end;

procedure TClxImageListEditor.StretchReplaceMasked(List: TImageList; Index: Integer;
  Image: TBitmap; MaskColor: TColor);
var
  NewImage: TBitmap;
begin
  NewImage := TBitmap.Create;
  try
    NewImage.Width := List.Width;
    NewImage.Height := List.Height;
    NewImage.Canvas.StretchDraw(Rect(0, 0, List.Width, List.Height), Image);
    List.ReplaceMasked(Index, NewImage, MaskColor);
  finally
    NewImage.Free;
  end;
end;

procedure TClxImageListEditor.CenterReplace(List: TImageList; Index: Integer;
  Image, Mask: TBitmap);
var
  R: TRect;
  NewImage, NewMask: TBitmap;
begin
  R := Bounds((List.Width - Image.Width) div 2,
    (List.Height - Image.Height) div 2, Image.Width, Image.Height);
  NewImage := TBitmap.Create;
  NewMask := TBitmap.Create;
  try
    NewImage.Width := List.Width;
    NewImage.Height := List.Height;
    NewImage.Canvas.Brush.Color := List.BkColor;
    NewImage.Canvas.FillRect(Rect(0,0,List.Width,List.Height));
    NewImage.Canvas.StretchDraw(R, Image);
    NewMask.Width := List.Width;
    NewMask.Height := List.Height;
    NewMask.Canvas.Brush.Color := MaskBackground[Mask = nil];
    NewMask.Canvas.FillRect(Rect(0,0,List.Width,List.Height));
    if Mask <> nil then
      NewMask.Canvas.StretchDraw(R, Mask);
    List.Replace(Index, NewImage, NewMask);
  finally
    NewImage.Free;
    NewMask.Free;
  end;
end;

procedure TClxImageListEditor.CenterReplaceMasked(List: TImageList; Index: Integer;
  Image: TBitmap; MaskColor: TColor);
var
  R: TRect;
  NewImage: TBitmap;
begin
  R := Bounds((List.Width - Image.Width) div 2,
    (List.Height - Image.Height) div 2, Image.Width, Image.Height);
  NewImage := TBitmap.Create;
  try
    NewImage.Width := List.Width;
    NewImage.Height := List.Height;
    NewImage.Canvas.Brush.Color := MaskColor;
    NewImage.Canvas.FillRect(Rect(0,0,List.Width,List.Height));
    NewImage.Canvas.StretchDraw(R, Image);
    List.ReplaceMasked(Index, NewImage, MaskColor);
  finally
    NewImage.Free;
  end;
end;

procedure TClxImageListEditor.DoImageListViewChange(Sender: TObject);
var
  Item: TIconViewItem;
begin
  if not (csDestroying in ComponentState) then
  begin
    Item := ImageView.Selected;
    if Assigned(Item) then SelectImage(Item.Index);
  end;
end;

procedure TClxImageListEditor.HelpClick(Sender: TObject);
begin
  InvokeHelp;
end;

procedure TClxImageListEditor.UpdatePickColor(X, Y: Integer);
var
  Item: TIconViewItem;
  TransColor: TColor;
  TempColor: QColorH;
  ImageX, ImageY: Integer;
  Temp: QImageH;
begin
  if not MainImage.Picture.Bitmap.Empty then
  begin
    ImageX := X div FImageXDivOffset;
    ImageY := Y div FImageYDivOffset;
    if (ImageX > MainImage.Picture.Bitmap.Width - 1) or (ImageX < 0) or
    (ImageY > MainImage.Picture.Bitmap.Height - 1) or (ImageY < 0) then
      Exit;
    Item := ImageView.Selected;
    if Assigned(Item) and Items[Item.Index].CanChangeTransparent then
    begin
      if MainImage.Picture.Bitmap.PixelFormat > pf8bit then
      begin
        Temp := QImage_create;
        try
          QPixmap_convertToImage(MainImage.Picture.Bitmap.Handle, Temp);
          QImage_pixel(Temp, @TransColor, ImageX, ImageY);
          TempColor := QColor_create;
          try
            QColor_setRgb(TempColor, QRgbH(@TransColor));
            TransColor := QColorColor(TempColor);
          finally
            QColor_destroy(TempColor);
          end;
          Items[Item.Index].TransparentColor := TransColor;
        finally
          QImage_destroy(Temp);
        end;
      end;
    end;
  end;
end;

procedure TClxImageListEditor.MainImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    UpdatePickColor(X, Y);
end;

type
  THackImageList = class(TIconView);

procedure TClxImageListEditor.ExportBtnClick(Sender: TObject);
var
  ImageStrip: TBitmap;
  ImageCount: Integer;

  procedure CreateImageStrip(var Strip: TBitmap; ImageList: TImageList;
    BkColor: TColor);
  var
    I, DestIndex: Integer;
  begin
    with Strip do
    begin
      Canvas.Brush.Color := BkColor;
      Canvas.FillRect(Rect(0, 0, Strip.Width, Strip.Height));
      DestIndex := 0;
      for I := 0 to ImageList.Count - 1 do
        if ImageView.Items[I].Selected then
        begin
          ImageList.Draw(Canvas, DestIndex * ImageList.Width, 0, I);
          Inc(DestIndex);
        end;
    end;
  end;

begin
  if ImageView.Items.Count = 0 then
    ImageCount := ImageList.Count
  else
    ImageCount := ImageView.SelCount;
  if ImageCount = 0 then  // If nothing is selected...
  begin
    ImageView.SelectAll(True);
    ImageCount := ImageView.SelCount;
  end;
  { Build image strip }
  ImageStrip := TBitmap.Create;
  try
    ImageStrip.Width := ImageList.Width * ImageCount;
    ImageStrip.Height := ImageList.Height;
    CreateImageStrip(ImageStrip, ImageList, clFuchsia);
    { Save image strip }
    with SaveDialog do
    begin
      Width := Self.Width;
      if Execute then
        ImageStrip.SaveToFile(FileName);
    end;
  finally
    ImageStrip.Free;
  end;
end;

procedure TClxImageListEditor.ImageViewSelectItem(Sender: TObject;
  Item: TIconViewItem; Selected: Boolean);
begin
  if Selected then
    SelectImage(Item.Index);
end;

procedure TClxImageListEditor.MainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  UpdatePickColor(X, Y);
end;

procedure TClxImageListEditor.ImageViewEdited(Sender: TObject;
  Item: TIconViewItem; var NewName: WideString);
var
  I : Integer;
  Old: WideString;
begin
  Old := Item.Caption;
  I := StrToInt(NewName);
  if I < 0 then
    I := 0
  else
    if I > InfoList.Count - 1 then
      I := InfoList.Count - 1;
  if Item.Index <> I then
  begin
    MoveImage(Item.Index, I);
    NewName := Item.Caption;
  end
  else
    Item.Caption := Old;
  SelectImage(Item.Index);
end;

end.

