{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

unit frmImgListEdit;

{$include elpack2.inc}

{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

{$UNDEF DEBUG_THIS}

{$IFDEF RUCOMMENTS}
{
 todo:
   - Загрузка списка(*.eli) картинок другого размера ... stretch, crop ...
   - Fill Color: курсор для выбора цвета (crHandPoint)
   - Fill Color: (если размер битмапа меьше текущего размера (crop))
   - ??? Скролирование при drag drop по таймеру, а не по движению мышки, ка к сейчас
}

{.$DEFINE DEBUG_THIS} // - для отладки
{$ENDIF IFDEF RUCOMMENTS}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  {$IFDEF D_3}commctrl,{$ENDIF}
  {$IFDEF D_4_UP}ImgList,{$ENDIF}
  ComCtrls,
  Menus,
  ExtDlgs,
  Clipbrd,

  {$ifndef DEBUG_THIS}
  {$IFDEF VCL_6_USED}
  DesignIntf,
  DesignEditors,
  DesignWindows,
  DsnConst,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  Typinfo,
  {$endif ifndef DEBUG_THIS}

  {.$IFNDEF CLX_USED}{
  ElSBCtrl,
  {$ENDIF}
  ElXPThemedControl,
  ElBtnCtl,
  ElPopBtn,
  ExtCtrls,
  ElPanel,
  ElScrollBox,
  ElFlatCtl,
  ElImgLst, ElStatBar, ElSplit, ElCheckCtl, ElEdits, ElBtnEdit, ElCombos,
  ElClrCmb, StdCtrls
  ;

const
  WM_CHANGETRANSPARENT = WM_USER+$100;

type

  {$IFDEF D_3}
  TLVSelectItemEvent = procedure(Sender: TObject; Item: TListItem;
    Selected: Boolean) of object;
  {$ENDIF IFDEF D_3}

  TForEachSelectedHandler = procedure (Item: TListItem; ItemIndex: Integer; UserData:Pointer) of object;

  TListView = class(comctrls.TListView)
  private
    {$IFDEF D_3}
    FOnSelectItem: TLVSelectItemEvent;
    {$ENDIF IFDEF D_3}
    {$IFDEF RUCOMMENTS}
    {.$IFNDEF CLX_USED}{
    fSBCtrl :TElSBController; // ??? - связка не работает.
    {$ENDIF}
    {$ENDIF}
  protected
    {$IFDEF D_3}
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    {$ENDIF IFDEF D_3}
  {$IFDEF RUCOMMENTS}
  {.$IFNDEF CLX_USED}{
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
  public
    constructor Create(AComponent:TComponent); override;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF D_3}
  published
    property OnSelectItem: TLVSelectItemEvent read FOnSelectItem write FOnSelectItem;
  {$ENDIF IFDEF D_3}
  end;

  TElImageListEditForm = class(TForm)
    Panel1: TElPanel;
    OkButton: TElPopupButton;
    CancelButton: TElPopupButton;
    ElPanel1: TElPanel;
    ElFlatController1: TElFlatController;
    WorkImageList: TElImageList;
    popupLoad: TPopupMenu;
    itemImageList: TMenuItem;
    itemBitmaps: TMenuItem;
    itemBmpToIL: TMenuItem;
    popupSave: TPopupMenu;
    itemSaveToIL: TMenuItem;
    itemILToBitmap: TMenuItem;
    itemILSelToBitmap: TMenuItem;
    ApplyButton: TElPopupButton;
    SD: TSaveDialog;
    OD: TOpenDialog;
    popupSel: TPopupMenu;
    popupSel_Delete: TMenuItem;
    popupSel_L1: TMenuItem;
    popupSel_Copy: TMenuItem;
    popupSel_Paste: TMenuItem;
    ElPanel2: TElPanel;
    btnLoad: TElPopupButton;
    btnSave: TElPopupButton;
    btnClear: TElPopupButton;
    btnMono: TElPopupButton;
    btnCopy: TElPopupButton;
    btnPaste: TElPopupButton;
    ElStatusBar1: TElStatusBar;
    ElPanel3: TElPanel;
    WorkListView: TListView;
    ElSplitter1: TElSplitter;
    btnDelete: TElPopupButton;
    btnMove: TElPopupButton;
    popupSel_Move: TMenuItem;
    popupSel_Mono: TMenuItem;
    pTop: TPanel;
    pColor: TPanel;
    ScrollBox: TElScrollBox;
    Image: TImage;
    ccTrans: TElColorCombo;
    lbTrans: TLabel;
    popupSel_TransCol: TMenuItem;
    btnTrans: TElPopupButton;
    btnSelectAll: TElPopupButton;
    procedure FormCreate(Sender: TObject);
    procedure itemImageListClick(Sender: TObject);
    procedure itemBmpToILClick(Sender: TObject);
    procedure itemBitmapsClick(Sender: TObject);
    procedure itemSaveToILClick(Sender: TObject);
    procedure itemILToBitmapClick(Sender: TObject);
    procedure itemILSelToBitmapClick(Sender: TObject);
    procedure WorkListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WorkListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure WorkListViewStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure WorkListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure WorkListViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure btnClearClick(Sender: TObject);
    procedure btnMonoClick(Sender: TObject);
    procedure popupSelPopup(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure WorkImageListChange(Sender: TObject);
    procedure popupSavePopup(Sender: TObject);
    procedure ElSplitter1PositionChanged(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnMoveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure WorkListViewDeletion(Sender: TObject; Item: TListItem);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popupSel_TransColClick(Sender: TObject);
    procedure ImageDblClick(Sender: TObject);
    procedure btnTransClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure WorkListViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    // Open Dialog Component:
    fOD:
      {$IFNDEF D_6_UP}
      TOpenDialog;
      {$ELSE}
      TOpenPictureDialog;
      {$ENDIF}
    fEditImageList : TElImageList;
    fModified :Boolean;
    fMoveIndex :Integer;
  protected
    procedure SetImageSize(Width, Height:Integer);
    procedure SetImageList(IL:TElImageList);
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure CheckEnabledPaste;
    procedure UpdateSelected;
    procedure WMChangeTrans(var Msg:TMessage); message WM_CHANGETRANSPARENT;
    procedure ForEachSelected(Handler: TForEachSelectedHandler; UserData:Pointer);
    procedure DeleteHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
    procedure SaveImageHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
    procedure MoveImagesToPos(Sender: TObject; NewPos, OldPos: Integer);
    procedure MonoImageHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
    procedure TransHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
  public
    { Public declarations }
    procedure SetEditImageList(IL:TElImageList);
    property Modified :Boolean read fModified;
  end;

{$ifndef DEBUG_THIS}
procedure IDERegisterModule;
{$endif ifndef DEBUG_THIS}

implementation
{$B-}

uses
  frmStyleImageSelect, frmImgListEditDlg, ElVCLUtils;

{$R *.DFM}

resourcestring
  rsCaption = 'Image List Editor';

{ TListView }

{$IFDEF RUCOMMENTS}
{.$IFNDEF CLX_USED}{
constructor TListView.Create(AComponent:TComponent);
begin
  inherited;
  fSBCtrl := TElSBController.Create(Self);
end;

procedure TListView.CreateWnd;
begin
  inherited;
  fSBCtrl.Control := nil;
  fSBCtrl.Control := Self;
end;

procedure TListView.DestroyWnd;
begin
  inherited;
  fSBCtrl.Control := nil;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF D_3}
procedure TListView.CNNotify(var Message: TWMNotify);
var
  Item: TListItem;
begin
  with Message do
  begin
    if NMHdr^.code = LVN_ITEMCHANGED then
    with PNMListView(NMHdr)^ do
    begin
      Item := Items[iItem];
      Change(Item, uChanged);
      if Assigned(FOnSelectItem) and (uChanged = LVIF_STATE) then
      begin
        if (uOldState and LVIS_SELECTED <> 0) and
          (uNewState and LVIS_SELECTED = 0) then
          FOnSelectItem(Self, Item, False)
        else if (uOldState and LVIS_SELECTED = 0) and
          (uNewState and LVIS_SELECTED <> 0) then
          FOnSelectItem(Self, Item, True);
      end;
    end
    else
      inherited;
  end;
end;
{$ENDIF IFDEF D_3}

{ TListDragObject }

type

  TListDragObject = class(TDragObject)
    public
      fImageIndex :Integer;
  end;

{ TElImageListEditForm }

procedure TElImageListEditForm.FormCreate(Sender: TObject);
begin
  Caption := rsCaption;
  {$IFDEF D_4_UP}
  ElFlatController1.Active := True;
  {$ELSE}
  ScrollBox.BorderStyle := bsNone;
  {$ENDIF}
 {$IFNDEF D_6_UP}
  fOD := OD;
 {$ELSE}
  fOD := TOpenPictureDialog.Create(Self);
  with fOD do
  begin
    InitialDir := '.';
    Options := Options - [ofHideReadOnly] + [ofAllowMultiSelect];
    Filter  := 'Bitmap Files(*.bmp|*.bmp';
    Title   := 'Open Image';
    DefaultExt  := 'bmp';
    FilterIndex := 1;
  end;
  {$ENDIF}
  Image.Left := 0;
  Image.Top  := 0;
  fMoveIndex := 1;
  with WorkImageList do
    SetImageSize(Width, Height);
  // add onSelect Event
  WorkListView.OnSelectItem := WorkListViewSelectItem;

  {$IFDEF D_5_UP}
  Position := poOwnerFormCenter;
  {$ENDIF}
end;

procedure TElImageListEditForm.WMActivate(var Msg: TWMActivate);
begin
  if Msg.Active <> WA_INACTIVE then
    CheckEnabledPaste;
  inherited;
end;

procedure TElImageListEditForm.CheckEnabledPaste;
begin
  btnPaste.Enabled :=
    Clipboard.HasFormat(CF_BITMAP) or Clipboard.HasFormat(CF_METAFILEPICT) or
    Clipboard.HasFormat(CF_PICTURE);
end;

procedure TElImageListEditForm.itemImageListClick(Sender: TObject);
 var FS :TFileStream;
     IL :TElImageList;
     i  :integer;
     k  :integer;
begin
  OD.Filter  := 'ElImageList data files (*.eil)|*.eil';
  OD.DefaultExt := 'eil';
  if not OD.Execute then
    exit;
  IL := nil;
  FS := nil;
  Screen.Cursor := crHourGlass;
  try
    IL := TElImageList.Create(nil);
    for k:=0 to OD.Files.Count-1 do
    begin
      FS := TFileStream.Create(OD.Files[k], fmOpenRead);
      IL.ReadImg(FS);
      FreeAndNil(FS);
      if (IL.Width<>WorkImageList.Width) or (IL.Height<>WorkImageList.Height) then
      begin
        MessageBox(
          Handle,
          PChar('The chosen file does not coincide with the current sizes of pictures ! '#10#13+
            'The sizes of pictures in a file: (' +
            IntToStr(IL.Width) +' x '+IntToStr(IL.Height) + ')'),
          PChar('Warning of loading ElImageList'),
          MB_OK + MB_ICONWARNING
        );
        exit;
      end;
      WorkImageList.AddImages(IL);
      for i:=0 to IL.Count-1 do
      begin
        with WorkListView.Items.Add do
        begin
          Caption := IntToStr(WorkListView.Items.Count-1);
          ImageIndex := WorkListView.Items.Count-1;
        end;
      end;
      IL.Clear;
    end;
  finally
    FS.Free;
    IL.Free;
    if (WorkListView.Items.Count>0) and (WorkListView.Selected=nil) then
      WorkListView.Selected := WorkListView.Items[0];
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.itemBmpToILClick(Sender: TObject);
 var
   Bitmap  :TBitmap;
   PartBmp :TBitmap;
   CX, CY  :Integer;
   i, j    :Integer;
   k       :Integer;
begin
  fOD.Filter  := 'Bitmap (*.bmp)|*.bmp';
  if not fOD.Execute then
    exit;
  PartBmp := nil;
  Bitmap  := TBitmap.Create;
  try
    Screen.Cursor := crHourGlass;
    WorkListView.Items.BeginUpdate;
    PartBmp := TBitmap.Create;
    PartBmp.Width := WorkImageList.Width;
    PartBmp.Height := WorkImageList.Height;
    for k:=0 to fOD.Files.Count-1 do
    begin
      Bitmap.LoadFromFile(fOD.Files[k]);
      CX := Bitmap.Width div WorkImageList.Width;
      CY := Bitmap.Height div WorkImageList.Height;
      if (CX=0)or(CY=0) then
        exit;
      try
        PartBmp.PixelFormat := Bitmap.PixelFormat;
      except
        PartBmp.PixelFormat := pf24bit;
      end;
      for i:=0 to CX-1 do
        for j:=0 to CY-1 do
        begin
          // Dest Canvas:
          PartBmp.Canvas.CopyRect(
            // Dest Rect:
            Rect(0, 0, PartBmp.Width, PartBmp.Height),
            // Source Canvas:
            Bitmap.Canvas,
            // Source Rect:
            Rect(
              i * WorkImageList.Width,
              j * WorkImageList.Height,
              (i+1) * WorkImageList.Width,
              (j+1) * WorkImageList.Height
            )
          );
          WorkImageList.Add(PartBmp, nil);
          with WorkListView.Items.Add do
          begin
            Caption := IntToStr(WorkImageList.Count-1);
            ImageIndex := WorkImageList.Count-1;
          end;
        end;
    end;//of: for k
  finally
    WorkListView.Items.EndUpdate;
    Bitmap.Free;
    PartBmp.Free;
    if (WorkListView.Items.Count>0) and (WorkListView.Selected=nil) then
      WorkListView.Selected := WorkListView.Items[0];
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.itemBitmapsClick(Sender: TObject);
  var
    Bitmap :TBitmap;
    Bmp    :TBitmap;
    Img    :TImage;
    pData  :TBitmap;
    R      :TRect;
    i      :Integer;
    vCenterX, vCenterY :Integer;
    ImageOperation: TImageOperation;
    ImageOperations: TImageOperations;
    CX, CY, iX, iY :Integer;
    ST :TStream;
    IconRec :TIconRec;
    iW, iH :Integer;
begin
  if not (Sender is TImage) then
  begin
   fOD.Filter  := 'Bitmap and Icon (*.bmp;*.ico)|*.bmp;*.ico|Bitmap (*.bmp)|*.bmp|Icon (*.ico)|*.ico';
   fOD.FilterIndex := 1;
   if not fOD.Execute then
     exit;
  end;
  Img := nil;
  Bmp := nil;
  Bitmap := nil;
  WorkListView.Items.BeginUpdate;
  try
    Screen.Cursor := crHourGlass;
    Bitmap := TBitmap.Create;
    if not (Sender is TImage) then
      CX := fOD.Files.Count-1
    else
      CX := 0;
    for i:=0 to CX do
    begin

      if not (Sender is TImage) then
      begin
        Img  := TImage.Create(nil);
        Img.Picture.LoadFromFile(fOD.Files[i]);
        iW := Img.Picture.Graphic.Width;
        iH := Img.Picture.Graphic.Height;
        if Img.Picture.Graphic is TIcon then
        begin // fix icon size
          ST := TFileStream.Create(fOD.Files[i], fmOpenRead);
          try
            if (ST.Size > SizeOf(TCursorOrIcon) + SizeOf(TIconRec)) then
            begin
              ST.Position := SizeOf(TCursorOrIcon);
              ST.Read(IconRec, SizeOf(TIconRec));
              iW := IconRec.Width;
              iH := IconRec.Height;
            end;
          finally
            ST.Free;
          end;
        end;
      end
      else
      begin
        Img  := TImage(Sender);
        iW := Img.Picture.Graphic.Width;
        iH := Img.Picture.Graphic.Height;
      end;

      if (iW<=0)or(iH<=0) then
        Continue;

      Bitmap.Width := WorkImageList.Width;
      Bitmap.Height := WorkImageList.Height;

      if Img.Picture.Graphic is TBitmap then
      begin
        try
          Bitmap.PixelFormat := Img.Picture.Bitmap.PixelFormat;
        except
          Bitmap.PixelFormat := pf24bit;
        end;
      end
      else
      begin
        Bitmap.PixelFormat := pf24bit;
      end;

      if (iW{Img.Picture.Graphic.Width}=WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}=WorkImageList.Height) then
        ImageOperation := ioCrop
      else
      begin
        ImageOperation  := ioStretch;
        ImageOperations := [ioCrop, ioStretch];
        if (iW{Img.Picture.Graphic.Width}<WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}<WorkImageList.Height) then
          Include(ImageOperations, ioCenter);
        if ( (iW{Img.Picture.Graphic.Width}>WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}<WorkImageList.Height) )
           or
           ( (iW{Img.Picture.Graphic.Width}<WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}>WorkImageList.Height) )
        then
        begin
          Include(ImageOperations, ioCenterStretch);
          Include(ImageOperations, ioCenterCrop);
        end;
        if ( ((iW{Img.Picture.Graphic.Width} div WorkImageList.Width)>1) or ((iH{Img.Picture.Graphic.Height} div WorkImageList.Height)>1) ) then
          Include(ImageOperations, ioDivideIntoFragment);

        if not GetProccesingImageOperation( ImageOperations, Img.Picture.Graphic, iW, iH, WorkImageList.Width, WorkImageList.Height, ImageOperation ) then
          Continue;
      end;

      Bitmap.Width := WorkImageList.Width;
      Bitmap.Height := WorkImageList.Height;

      case ImageOperation of
        ioCrop, ioCenter, ioCenterCrop:
          begin
            vCenterX := 0;
            vCenterY := 0;
            case ImageOperation of
              ioCenter:
                begin
                  vCenterX := (WorkImageList.Width - iW{Img.Picture.Graphic.Width}) div 2;
                  vCenterY := (WorkImageList.Height - iH{Img.Picture.Graphic.Height}) div 2;
                end;
              ioCenterCrop:
                begin
                  if (iW{Img.Picture.Graphic.Width}>WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}<WorkImageList.Height) then
                    vCenterY := (WorkImageList.Height - iH{Img.Picture.Graphic.Height}) div 2
                  else
                  if (iW{Img.Picture.Graphic.Width}<WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}>WorkImageList.Height) then
                    vCenterX := (WorkImageList.Width - iW{Img.Picture.Graphic.Width}) div 2;
                end;
              end;
            Bitmap.Canvas.Draw(vCenterX, vCenterY, Img.Picture.Graphic);
          end;
        ioStretch, ioCenterStretch:
          begin
            if ImageOperation = ioCenterStretch then
            begin
              if (iW{Img.Picture.Graphic.Width}>WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}<WorkImageList.Height) then
              begin
                vCenterY := (WorkImageList.Height - iH{Img.Picture.Graphic.Height}) div 2;
                R := Rect(0, vCenterY, WorkImageList.Width, vCenterY+iH{Img.Picture.Graphic.Height});
              end
              else
              if (iW{Img.Picture.Graphic.Width}<WorkImageList.Width) and (iH{Img.Picture.Graphic.Height}>WorkImageList.Height) then
              begin
                vCenterX := (WorkImageList.Width - iW{Img.Picture.Graphic.Width}) div 2;
                R := Rect(vCenterX, 0, vCenterX+iW{Img.Picture.Graphic.Width}, WorkImageList.Height);
              end
              else
                R := Rect(0, 0, Bitmap.Width, Bitmap.Height);
            end
            else
              R := Rect(0, 0, Bitmap.Width, Bitmap.Height);
            {$ifndef CLX_USED}
            Bmp   := TBitmap.Create;
            Bmp.PixelFormat := Bitmap.PixelFormat;
            Bmp.Width := iW{Img.Picture.Graphic.Width};
            Bmp.Height := iH{Img.Picture.Graphic.Height};
            Bmp.Canvas.Draw(0, 0, Img.Picture.Graphic);
            SetStretchBltMode(Bitmap.Canvas.Handle, COLORONCOLOR);
            StretchBlt(Bitmap.Canvas.Handle, R.Left, R.Top, R.Right-R.Left+1, R.Bottom-R.Top+1,
                         Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SRCCOPY);
            FreeAndNil(Bmp);
            {$else}
            Bitmap.Canvas.StretchDraw(R, Img.Picture.Graphic);
            {$endif}
          end;
        ioDivideIntoFragment: // To divide a picture into fragments
          begin
            Bmp   := TBitmap.Create;
            Bmp.PixelFormat := Bitmap.PixelFormat;
            Bmp.Width := iW{Img.Picture.Graphic.Width};
            Bmp.Height := iH{Img.Picture.Graphic.Height};
            Bmp.Canvas.Draw(0, 0, Img.Picture.Graphic);

            CX := Bmp.Width div WorkImageList.Width;
            CY := Bmp.Height div WorkImageList.Height;
            if (CX=0)or(CY=0) then
              exit;
            for iX:=0 to CX-1 do
              for iY:=0 to CY-1 do
              begin
                // Dest Canvas:
                Bitmap.Canvas.CopyRect(
                  // Dest Rect:
                  Rect(0, 0, Bitmap.Width, Bitmap.Height),
                  // Source Canvas:
                  Bmp.Canvas,
                  // Source Rect:
                  Rect(
                    iX * WorkImageList.Width,
                    iY * WorkImageList.Height,
                    (iX+1) * WorkImageList.Width,
                    (iY+1) * WorkImageList.Height
                  )
                );
                WorkImageList.Add(Bitmap, nil);
                with WorkListView.Items.Add do
                begin
                  Caption := IntToStr(WorkImageList.Count-1);
                  ImageIndex := WorkImageList.Count-1;
                  pData := TBitmap.Create;
                  Data := pData;
                  pData.Assign(Bitmap);
                end;
              end;
            FreeAndNil(Bmp);
          end;
        else
          Continue;
      end;
      if not (Sender is TImage) then
        FreeAndNil(Img);
      WorkImageList.Add(Bitmap, nil);
      with WorkListView.Items.Add do
      begin
        Caption := IntToStr(WorkImageList.Count-1);
        ImageIndex := WorkImageList.Count-1;
        pData := TBitmap.Create;
        Data := pData;
        pData.Assign(Bitmap);
      end;
    end;//of: for i
    WorkListView.Selected := WorkListView.Items[WorkImageList.Count-1];
    WorkListView.ItemFocused := WorkListView.Selected;
    if (WS_HSCROLL and GetWindowLong(WorkListView.Handle, GWL_STYLE))<>0 then
      WorkListView.Perform(WM_HSCROLL, SB_BOTTOM, 0);
  finally
    WorkListView.Items.EndUpdate;
    Bitmap.Free;
    if not (Sender is TImage) then
      Img.Free;
    Bmp.Free;
    if (WorkListView.Items.Count>0) and (WorkListView.Selected=nil) then
      WorkListView.Selected := WorkListView.Items[0];
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.itemSaveToILClick(Sender: TObject);
 var FS :TFileStream;
begin
  SD.Filter  := 'ElImageList data files (*.eil)|*.eil';
  if not SD.Execute then
    exit;
  FS := TFileStream.Create(SD.FileName, fmCreate);
  try
    Screen.Cursor := crHourGlass;
    WorkImageList.WriteImg(FS);
  finally
    FS.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.itemILToBitmapClick(Sender: TObject);
 var
   Bitmap  :TBitmap;
   i       :Integer;
   X, Y    :Integer;
begin
  SD.Filter  := 'Bitmap (*.bmp)|*.bmp';
  SD.DefaultExt := 'bmp';
  if not SD.Execute then
    exit;
  Bitmap  := TBitmap.Create;
  try
    Screen.Cursor := crHourGlass;
    //???
    Bitmap.PixelFormat := pf24bit;
    X := 0;
    if WorkImageList.Width<640 then
      Y := 640
    else
    if WorkImageList.Width<800 then
      Y := 800
    else
    if WorkImageList.Width<1024 then
      Y := 1024
    else
    if WorkImageList.Width<1152 then
      Y := 1024
    else
    if WorkImageList.Width<1280 then
      Y := 1024
    else
    if WorkImageList.Width<1600 then
      Y := 1024
    else
    if WorkImageList.Width<2048 then
      Y := 1024
    else
      Y := WorkImageList.Width * WorkImageList.Count +1;
    if (WorkImageList.Count*WorkImageList.Width)>Y then
    begin
      for i := 640 div WorkImageList.Width downto 2 do
      begin
        if (WorkImageList.Count mod i)=0 then
        begin
          X := i;
          break;
        end;
      end;
    end;
    if X>0 then
    begin
      Bitmap.Width := X*WorkImageList.Width;
      if (WorkImageList.Count mod X) = 0 then
        Bitmap.Height := WorkImageList.Height * (WorkImageList.Count div X)
      else
        Bitmap.Height := WorkImageList.Height * Round(WorkImageList.Count / X + 0.5);
    end
    else
    begin
      Bitmap.Width := WorkImageList.Width * WorkImageList.Count;
      Bitmap.Height := WorkImageList.Height;
    end;
    X := 0;
    Y := 0;
    for i := 0 to WorkImageList.Count-1 do
    begin
      WorkImageList.Draw(Bitmap.Canvas, X, Y, i);
      inc(X, WorkImageList.Width);
      if (X>=Bitmap.Width) then
      begin
        X := 0;
        inc(Y, WorkImageList.Height);
      end;
    end;
    Bitmap.SaveToFile(SD.FileName);
  finally
    Bitmap.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.SaveImageHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
var
  Bitmap  :TBitmap;
begin
  Bitmap  := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf24bit;
    Bitmap.Width := WorkImageList.Width;
    Bitmap.Height := WorkImageList.Height;
    WorkImageList.Draw(Bitmap.Canvas, 0, 0, ItemIndex);
    if WorkListView.SelCount<2 then
      Bitmap.SaveToFile(SD.FileName)
    else
      Bitmap.SaveToFile(
        ChangeFileExt(SD.FileName, '')+'-'+IntToStr(ItemIndex)+
        ExtractFileExt(SD.FileName)
      );
  finally
    Bitmap.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.itemILSelToBitmapClick(Sender: TObject);
begin
  if (WorkListView.SelCount=0)and(WorkListView.ItemFocused=nil) then
    exit;
  SD.Filter  := 'Bitmap (*.bmp)|*.bmp';
  SD.DefaultExt := 'bmp';
  if not SD.Execute then
    exit;
  if (WorkListView.SelCount>0) then
    ForEachSelected(SaveImageHandler, nil)
  else
    SaveImageHandler(WorkListView.ItemFocused, WorkListView.ItemFocused.ImageIndex, nil);
end;

procedure TElImageListEditForm.WorkListViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key =VK_DELETE)and( (WorkListView.SelCount>0) or Assigned(WorkListView.ItemFocused) ) then
    btnDeleteClick(Sender)
  else
    inherited;
end;

procedure TElImageListEditForm.WorkListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
  var
    bColor:Boolean;
begin
  if Selected then
  begin
    Image.Hint := Item.Caption;
    Image.Picture.Bitmap.Canvas.Pen.Color := clWhite;
    Image.Picture.Bitmap.Canvas.Brush.Color := clWhite;
    Image.Picture.Bitmap.Canvas.FillRect(Rect(0,0,Image.Picture.Bitmap.Width, Image.Picture.Bitmap.Height));
    bColor := Item.Data<>nil;
    {if bColor then
      Image.Picture.Bitmap.Assign(TPersistent(Item.Data))
    else
      WorkImageList.Draw(Image.Picture.Bitmap.Canvas, 0, 0, Item.ImageIndex);
    {}
    WorkImageList.GetBitmap(Item.ImageIndex, Image.Picture.Bitmap);
  end
  else
    bColor := Assigned(WorkListView.ItemFocused) and (Item<>nil) and (Item.Data<>nil);

  if (not Selected) and Assigned(WorkListView.ItemFocused) then
    Selected := True;

  popupSel_TransCol.Checked := bColor;

  if (Sender<>nil) and (bColor<>lbTrans.Enabled) then
  begin
    lbTrans.Enabled := bColor;
    ccTrans.Enabled := bColor;
    ccTrans.SelectedColor := clNone;
    if bColor then
    begin
      Image.Cursor := crCross;
    end
    else
    begin
      Image.Cursor := crDefault;
    end;
  end;

  if bColor then
  begin
    btnTrans.Enabled := True;
  end
  else
  begin
    btnTrans.Enabled := (WorkListView.SelCount>0);
  end;
  if lbTrans.Enabled then
    btnTrans.Caption := 'Apply'
  else
    btnTrans.Caption := 'Enable';

  Image.ShowHint := Selected;
  if Selected then
  begin
    if not Image.Visible then
      Image.Visible := True
    else
      Image.Invalidate;
  end
  else
    Image.Visible := False;

  btnCopy.Enabled := Selected and (WorkListView.SelCount=1);
  btnSelectAll.Enabled := Selected;
  btnMono.Enabled := Selected;
  btnDelete.Enabled := Selected;
  btnMove.Enabled := Selected and (WorkImageList.Count>1);

  if Selected then
    Caption := rsCaption + Format(' [%d]', [Item.ImageIndex])
  else
    Caption := rsCaption;
end;

procedure TElImageListEditForm.SetImageSize(Width, Height: Integer);
  var bmp:TBitmap;
  var
    KX, KY :Double;
    SBR:TRect;
    SBCW, SBCH:Integer;
begin
  if (Width<1)or(Height<1) then
    exit;
  bmp := TBitmap.Create;
  try
    bmp.Width := Width;
    bmp.Height := Height;
    Image.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  SBR := ScrollBox.ClientRect;
  SBCW := SBR.Right - SBR.Left;
  SBCH := SBR.Bottom - SBR.Top;
  if (Width<SBCW) and (Height<SBCH) then
  begin
    Image.Stretch := True;
    // calc scale factor:
    KX := SBCW/Width;
    KY := SBCH/Height;
    if KY<KX then
      KX := KY;
    Width := Trunc(Width * KX);
    if Width>SBCW then
      Width := SBCW;
    Height := Trunc(Height * KX);
    if Height>SBCH then
      Height := SBCH;
  end
  else
  begin
    Image.Stretch := False;
    Width := Width;
    Height := Height;
  end;
  Image.Width := Width;
  Image.Height := Height;
end;

procedure TElImageListEditForm.SetImageList(IL:TElImageList);
  var
    i: Integer;
begin
  btnClearClick(Self);
  if IL=nil then
    exit;
  SetImageSize(IL.Width, IL.Height);
  WorkImageList.Assign(IL);
  for i:=0 to WorkImageList.Count-1 do
  begin
    with WorkListView.Items.Add do
    begin
      Caption := IntToStr(i);
      ImageIndex := i;
    end;
  end;
  if WorkImageList.Count>0 then
  begin
    WorkListView.Selected := WorkListView.Items[0];
    WorkListView.ItemFocused := WorkListView.Selected;
  end;
end;

procedure TElImageListEditForm.SetEditImageList(IL:TElImageList);
begin
  fEditImageList := IL;
  SetImageList(IL);
  fModified := False;
  ActiveControl := WorkListView;
  if fMoveIndex >= WorkImageList.Count then
    fMoveIndex := 1;
end;

procedure TElImageListEditForm.WorkListViewStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if (WorkListView.SelCount>0)and(WorkListView.Items.Count>1) then
  begin
    DragObject := TListDragObject.Create;
    TListDragObject(DragObject).fImageIndex := WorkListView.Selected.ImageIndex;
  end;
end;

procedure TElImageListEditForm.WorkListViewDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  Item: TListItem;
begin
  Item := WorkListView.GetItemAt(X, Y);
  if Item<>nil then
    MoveImagesToPos(Self, Item.ImageIndex, TListDragObject(Source).fImageIndex);
end;

procedure TElImageListEditForm.WorkListViewDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
  var
    Item :TListItem;
    fISHSB :Boolean;
    CR :TRect;
begin
  Accept := (Source is TListDragObject);
  if Accept then
  begin
    Item := WorkListView.GetItemAt(X, Y);
    Accept := Assigned(Item) and
       (Item.ImageIndex<>TListDragObject(Source).fImageIndex);
    if not Accept then
    begin
      // Scrolling when dragdrop:
      fISHSB := (WS_HSCROLL and GetWindowLong(WorkListView.Handle, GWL_STYLE))<>0;
      if fISHSB then
      begin
        CR := WorkListView.ClientRect;
        if Y>CR.Bottom then
        begin
          if fISHSB then
          begin
            if X<((CR.Right-CR.Left) div 2) then
              WorkListView.Perform(
                WM_HSCROLL,
                SB_LINEUP,
                0)
            else
              WorkListView.Perform(
                WM_HSCROLL,
                SB_LINEDOWN,
                0);
          end;
        end;
      end;
    end;
  end;
end;

procedure TElImageListEditForm.btnClearClick(Sender: TObject);
begin
  WorkImageList.OnChange := nil;
  WorkListView.OnSelectItem := nil;
  try
    WorkListView.Items.BeginUpdate;
    try
      WorkListView.Items.Clear;
      WorkImageList.Clear;
    finally
      WorkListView.Items.EndUpdate;
    end;
    WorkListViewSelectItem(Sender, nil, False);
    btnCopy.Enabled := False;
    btnSelectAll.Enabled := False;
    btnMono.Enabled := False;
    btnDelete.Enabled := False;
    btnMove.Enabled := False;
  finally
    WorkListView.OnSelectItem := WorkListViewSelectItem;
    WorkImageList.OnChange := WorkImageListChange;
    WorkImageListChange(Sender);
  end;
end;

procedure TElImageListEditForm.MonoImageHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
  procedure ConvertColoredCanvasToMono(C: TCanvas);
  var
    X, Y: Integer;
    Color: LongInt;
    R, G, B,
      ConvertedColor: Byte;
  begin
    with C do
      for X := Cliprect.Left to ClipRect.Right do
        for Y := Cliprect.Top to ClipRect.Bottom do
        begin
          Color := ColorToRGB(Pixels[X, Y]);
          B := (Color and $FF0000) shr 16;
          G := (Color and $FF00) shr 8;
          R := (Color and $FF);
          ConvertedColor := HiByte(R * 77 + G * 151 + B * 28);
          Pixels[X, Y] := RGB(ConvertedColor, ConvertedColor, ConvertedColor);
        end;
  end;
  var
    Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.Width := WorkImageList.Width;
    Bmp.Height := WorkImageList.Height;
    WorkImageList.Draw(Bmp.Canvas, 0, 0, ItemIndex);
    ConvertColoredCanvasToMono(Bmp.Canvas);
    WorkImageList.Insert(ItemIndex, Bmp, nil);
    WorkImageList.Delete(ItemIndex+1);
  finally
    Bmp.Free;
  end;
end;

procedure TElImageListEditForm.btnMonoClick(Sender: TObject);
var
  idx :integer;
begin
  if (WorkListView.SelCount=0)and(WorkListView.ItemFocused=nil) then
    exit;

  if WorkListView.ItemFocused<>nil then
    idx := WorkListView.ItemFocused.ImageIndex
  else
    idx := WorkListView.Selected.ImageIndex;

  if (WorkListView.SelCount>1)and(not ((Sender is TMenuItem)and(popupSel.Tag = 1))) then
    ForEachSelected(MonoImageHandler, nil)
  else
    MonoImageHandler(WorkListView.Items[idx], idx, nil);

  WorkListView.Selected := nil;
  if WorkImageList.Count>0 then
  begin
    if idx<WorkListView.Items.Count then
      WorkListView.Selected := WorkListView.Items[idx]
    else
      WorkListView.Selected := WorkListView.Items[0];
    WorkListView.ItemFocused := WorkListView.Selected;
  end
  else
    UpdateSelected;
end;

procedure TElImageListEditForm.DeleteHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
var
  i :integer;
begin
  WorkImageList.Delete(ItemIndex);
  WorkListView.Items[ItemIndex].Delete;
  for i:=ItemIndex to WorkListView.Items.Count-1 do
  begin
    WorkListView.Items[i].Caption := IntToStr(i);
    WorkListView.Items[i].ImageIndex := i;
  end;
end;

procedure TElImageListEditForm.btnDeleteClick(Sender: TObject);
var
  idx :integer;
begin
  if (WorkListView.SelCount=0)and(WorkListView.ItemFocused=nil) then
    exit;

  if WorkListView.ItemFocused<>nil then
    idx := WorkListView.ItemFocused.ImageIndex
  else
    idx := WorkListView.Selected.ImageIndex;

  if (WorkListView.SelCount>0)and(not ((Sender is TMenuItem)and(popupSel.Tag = 1))) then
    ForEachSelected(DeleteHandler, nil)
  else
    DeleteHandler(WorkListView.Items[idx], idx, nil);

  if (not ((Sender is TMenuItem)and(popupSel.Tag = 1))) then
  begin
    if WorkListView.Items.Count=0 then
      WorkListViewSelectItem(WorkListView, nil, False);
  end
  else
  begin
    WorkListView.Selected := nil;
    if WorkImageList.Count>0 then
    begin
      if idx<WorkListView.Items.Count then
        WorkListView.Selected := WorkListView.Items[idx]
      else
        WorkListView.Selected := WorkListView.Items[0];
      WorkListView.ItemFocused := WorkListView.Selected;
    end
    else
      UpdateSelected;
  end;
end;

procedure TElImageListEditForm.popupSelPopup(Sender: TObject);
begin
  popupSel_Delete.Enabled := btnDelete.Enabled;
  popupSel_TransCol.Enabled  := btnDelete.Enabled;
  popupSel_Move.Enabled   := btnMove.Enabled;
  popupSel_Mono.Enabled   := btnMono.Enabled;
  popupSel_Copy.Enabled   := btnCopy.Enabled;
  popupSel_Paste.Enabled  := btnPaste.Enabled;
end;

procedure TElImageListEditForm.ApplyButtonClick(Sender: TObject);
begin
  if Assigned(fEditImageList) then
  begin
    fEditImageList.Assign(WorkImageList);
    fModified := True;
  end;
end;

procedure TElImageListEditForm.OkButtonClick(Sender: TObject);
begin
  ApplyButtonClick(Sender);
end;

procedure TElImageListEditForm.btnCopyClick(Sender: TObject);
begin
  if WorkListView.SelCount<>1 then
     exit;
  Screen.Cursor := crHourGlass;
  try
    Clipboard.Assign(Image.Picture);
  finally
    Screen.Cursor := crDefault;
  end;
  CheckEnabledPaste;
end;

procedure TElImageListEditForm.btnPasteClick(Sender: TObject);
  var
    Palette : HPALETTE;
    Img     :TImage;
begin
  Img := nil;
  Screen.Cursor := crHourGlass;
  try
    Img  := TImage.Create(nil);
    if Clipboard.HasFormat(CF_BITMAP) then
      Palette := CF_BITMAP
    else
      if Clipboard.HasFormat(CF_PICTURE) then
      Palette := CF_PICTURE
    else
      if Clipboard.HasFormat(CF_METAFILEPICT) then
      Palette := CF_METAFILEPICT
    else
      Palette := 0;
    if Palette <> 0 then
      Img.Picture.LoadFromClipboardFormat(cf_BitMap,
        ClipBoard.GetAsHandle(cf_Bitmap), 0)
    else
      Img.Picture.Assign(Clipboard);
    itemBitmapsClick(Img);
  finally
    Img.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TElImageListEditForm.WorkImageListChange(Sender: TObject);
begin
  if csDestroying in ComponentState then
    exit;
  btnClear.Enabled := WorkImageList.Count>0;
  btnSave.Enabled := WorkImageList.Count>0;
end;

procedure TElImageListEditForm.popupSavePopup(Sender: TObject);
begin
  itemILSelToBitmap.Enabled := Assigned(WorkListView.ItemFocused);
end;

procedure TElImageListEditForm.ElSplitter1PositionChanged(Sender: TObject);
begin
  with WorkImageList do
    SetImageSize(Width, Height);
  UpdateSelected;
end;

procedure TElImageListEditForm.MoveImagesToPos(Sender: TObject; NewPos, OldPos: Integer);
var
  fNewIndex :Integer;
  Idx :Integer;
  i,k,c: Integer;
begin
  if (WorkListView.SelCount=0)and(WorkListView.ItemFocused=nil) then
    exit;
  fNewIndex := NewPos;
  Idx := OldPos;
  if (fNewIndex>=0)and(fNewIndex<WorkImageList.Count) and
     (Idx>=0) and (Idx<WorkImageList.Count) and
     (fNewIndex <> Idx) then
  begin
    if (not ((Sender is TMenuItem)and(popupSel.Tag = 1))) and (WorkListView.SelCount>1) then
    begin
      fMoveIndex := fNewIndex;
      WorkListView.Items.BeginUpdate;
      try
       Screen.Cursor := crHourGlass;
       i := 0;
       c := fMoveIndex;
       Idx := 0;
       while i<WorkListView.Items.Count do
       begin
         if WorkListView.Items[i].Selected then
         begin
           if (idx=-1)and(i>fNewIndex) and (fNewIndex<WorkListView.Items.Count-1) then
             inc(fNewIndex);
           WorkListView.Items[i].Selected := False;
           WorkImageList.Move(i, fNewIndex);
           WorkListView.Items[fNewIndex].Selected := False;

           if i<fNewIndex then
           begin
             if idx=-1 then
               dec(c);
             idx:=-1;
             for k:=i+1 to fNewIndex-1 do
             begin
               if WorkListView.Items[k].Selected then
               begin
                 WorkListView.Items[k-1].Selected := True;
                 WorkListView.Items[k].Selected := False;;
               end;
             end;
           end
           else
           begin
             idx:=-1;
           end;
         end
         else
          inc(i);
       end;
       WorkListView.Selected := WorkListView.Items[c];
       WorkListView.ItemFocused := WorkListView.Selected;
      finally
       WorkListView.Items.EndUpdate;
       Screen.Cursor := crDefault;
      end;
      UpdateSelected;
    end
    else
    begin
      fMoveIndex := fNewIndex;
      Screen.Cursor := crHourGlass;
      try
        WorkImageList.Move(Idx, fNewIndex);
        WorkListView.Items[Idx].Selected := False;
        WorkListView.Selected := WorkListView.Items[fNewIndex];
        WorkListView.ItemFocused := WorkListView.Selected;
      finally
        Screen.Cursor := crDefault;
      end;
      UpdateSelected;
    end;
  end;
end;

procedure TElImageListEditForm.btnMoveClick(Sender: TObject);
var
  Value: String;
  Idx, i: Integer;
begin
  if (WorkListView.SelCount=0)and(WorkListView.ItemFocused=nil) then
    exit;

  if (not ((Sender is TMenuItem)and(popupSel.Tag = 1))) and (WorkListView.SelCount>1) then
  begin
    Idx := 0;
    // search fist index for dialog caption
    for i:=0 to WorkListView.Items.Count-1 do
    begin
      if WorkListView.Items[i].Selected then
      begin
        Idx := i;
        Break;
      end;
    end;
  end
  else
  if WorkListView.ItemFocused<>nil then
    Idx := WorkListView.ItemFocused.ImageIndex
  else
    Idx := WorkListView.Selected.ImageIndex;

  Value := IntToStr(fMoveIndex);
  if InputQuery(
    'Move selected image position '+IntToStr(Idx),
    'Enter new position in diapasone (0,'+IntToStr(WorkImageList.Count-1)+')',
    Value)
  then
    MoveImagesToPos(Sender, StrToIntDef(Value,0), Idx);
end;

procedure TElImageListEditForm.UpdateSelected;
  var
    Item: TListItem;
begin
  Item := WorkListView.ItemFocused;
  if Item=nil then
    Item := WorkListView.Selected;
  if Assigned(Item) then
  begin
    WorkListView.Selected := nil;
    WorkListView.Selected := Item;
    WorkListView.ItemFocused := WorkListView.Selected;
  end
  else
  if WorkListView.Items.Count=0 then
  begin
    WorkListView.Selected := nil;
    WorkListView.ItemFocused := nil;
    WorkListViewSelectItem(WorkListView, nil, False);
  end;
end;

procedure TElImageListEditForm.FormResize(Sender: TObject);
begin
  if Width < 360 then
    Width := 360;
  if Height < 310 then
    Height := 310;
end;

{$ifndef DEBUG_THIS}

type
  TElImageListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

var
  ElImageListEditForm: TElImageListEditForm;

{ TElImageListEditor }
procedure TElImageListEditor.ExecuteVerb(Index: Integer);
  var
    Form :TCustomForm;
begin
  case Index of
    0: begin
         //with TElImageListEditForm.Create(Application) do
         if ElImageListEditForm = nil then
           ElImageListEditForm := TElImageListEditForm.Create(Application);
         with ElImageListEditForm do
         begin
         //try
           SetEditImageList(Component as TElImageList);
           ShowModal;
           if Modified then
           begin
             Form := TElImageList(Component).Owner as TCustomForm;
             if (Form <> nil) and (Form.Designer <> nil) then
               Form.Designer.Modified;
           end;
           btnClearClick(nil); // - if not free
         //finally
           //Free;
           //ElImageListEditForm := nil;
         //end;
         end;
       end;
  end;
end;

function TElImageListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'ElImageList Editor...';
  end;
end;

function TElImageListEditor.GetVerbCount: Integer;
begin
  Result := 1
end;

procedure IDERegisterModule;
begin
  RegisterComponentEditor(TElImageList, TElImageListEditor);
end;

{$endif ifndef DEBUG_THIS}

procedure TElImageListEditForm.WorkListViewDeletion(Sender: TObject;
  Item: TListItem);
  var O:TObject;
begin
  if (Item.Data<>nil) then
  begin
    O := TObject(Item.Data);
    Item.Data := nil;
    O.Free;
  end;
end;

procedure TElImageListEditForm.TransHandler(Item: TListItem; ItemIndex: Integer; UserData:Pointer);
var
  B:TBitmap;
begin
  if WorkListView.Items[ItemIndex].Data<>nil then
    WorkImageList.ReplaceMasked(ItemIndex, TBitmap(WorkListView.Items[ItemIndex].Data), ccTrans.SelectedColor)
  else
  begin
    B := TBitmap.Create;
    try
      WorkImageList.GetBitmap(ItemIndex, B);
      WorkImageList.ReplaceMasked(ItemIndex, B, ccTrans.SelectedColor)
    finally
      B.Free;
    end;
  end;
end;

procedure TElImageListEditForm.btnTransClick(Sender: TObject);
var
  Idx :Integer;
begin
  if ((WorkListView.Selected=nil)and(WorkListView.ItemFocused=nil)) or (WorkListView.Items.Count=0) then
    exit;

  if not lbTrans.Enabled then
  begin
    PostMessage(Handle, WM_CHANGETRANSPARENT,0,0);
    exit;
  end;

  if WorkListView.SelCount>0 then
    idx := WorkListView.Selected.ImageIndex
  else
    idx := WorkListView.ItemFocused.ImageIndex;

  if (WorkListView.SelCount>0) then
    ForEachSelected(TransHandler, nil)
  else
    TransHandler(WorkListView.ItemFocused, WorkListView.ItemFocused.ImageIndex, nil);
  WorkListViewSelectItem(nil,  WorkListView.Items[Idx], True);
end;

procedure TElImageListEditForm.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    C:TColor;
begin
  popupSel.Tag := 1;
  if (not lbTrans.Enabled) or ((WorkListView.Selected=nil)and(WorkListView.ItemFocused=nil)) then
    exit;
  X := Round(X * Image.Picture.Bitmap.Width /Image.Width);
  Y := Round(Y * Image.Picture.Bitmap.Height / Image.Height);
  C := Image.Picture.Bitmap.Canvas.Pixels[X, Y];
  try // <- D3: excepton for custom color
    ccTrans.SelectedColor := C;
  except
  end;
end;

procedure TElImageListEditForm.popupSel_TransColClick(Sender: TObject);
begin
  popupSel_TransCol.Checked := not popupSel_TransCol.Checked;
  lbTrans.Enabled := popupSel_TransCol.Checked;
  ccTrans.Enabled := lbTrans.Enabled;

  if lbTrans.Enabled then
  begin
    btnTrans.Enabled := True;
  end
  else
  begin
    btnTrans.Enabled := (WorkListView.SelCount>0);
  end;
  btnTrans.Caption := 'Apply';

  if lbTrans.Enabled then
    Image.Cursor := crCross
  else
    Image.Cursor := crDefault;
end;

procedure TElImageListEditForm.ImageDblClick(Sender: TObject);
begin
  if not popupSel_TransCol.Checked then
    PostMessage(Handle, WM_CHANGETRANSPARENT,0,0);
end;

procedure TElImageListEditForm.WMChangeTrans(var Msg:TMessage);
begin
  popupSel_TransColClick(Self);
end;

procedure TElImageListEditForm.ForEachSelected(Handler: TForEachSelectedHandler; UserData:Pointer);
var
  i, Cnt: Integer;
begin
  if (not Assigned(Handler)) or (WorkListView.Items.Count=0) then
    exit;
  WorkListView.Items.BeginUpdate;
  try
   Screen.Cursor := crHourGlass;
   i := 0;
   while i<WorkListView.Items.Count do
   begin
     if WorkListView.Items[i].Selected then
     begin
       Cnt := WorkListView.Items.Count;
       Handler(WorkListView.Items[i], i, UserData);
       if Cnt=WorkListView.Items.Count then
         inc(i);
     end
     else
       inc(i);
   end;
  finally
    Screen.Cursor := crDefault;
    WorkListView.Items.EndUpdate;
  end;
end;

procedure TElImageListEditForm.btnSelectAllClick(Sender: TObject);
begin
  //btnSelectAll
end;

procedure TElImageListEditForm.WorkListViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  popupSel.Tag := 0;
end;

procedure TElImageListEditForm.ScrollBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  popupSel.Tag := 1;
end;

end.
