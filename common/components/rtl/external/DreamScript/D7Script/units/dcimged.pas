{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DcimgEd;

interface
{$I dc.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dcsystem,
  ComCtrls, Buttons, ExtCtrls, StdCtrls, {$IFDEF D3}ExtDlgs,{$ENDIF}

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcpedit,dcgen, dccommon, dcdreamlib, dcedit,commctrl,dcconsts,consts,
  DcTree, dctsrc,{$IFDEF D4}imglist,{$ENDIF}
  Menus, dctslite, dcdtree;

type
  TFrmImageEdit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GrpSel: TGroupBox;
    LblFill: TLabel;
    LblTran: TLabel;
    PropTranspCl: TDCPropEditor;
    PropFillCl: TDCPropEditor;
    GrpOption: TGroupBox;
    PropStrech: TDCPropRadioButton;
    PropCenter: TDCPropRadioButton;
    PropCrop: TDCPropRadioButton;
    PropImage: TDCPropEditor;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    BtnApply: TBitBtn;
    BtnHelp: TBitBtn;
    ButtonAdd: TBitBtn;
    ButtonDelete: TBitBtn;
    ClearButton: TBitBtn;
    ImageView: TDCListView;
    PopupMenu1: TPopupMenu;
    Save1: TMenuItem;
    ImageSource: TDCImgListSource;
    SaveBut: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure PropImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnOkClick(Sender: TObject);
    procedure PropCropChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImageViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ImageViewDblClick(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure ImageViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ImageList : TCustomImageList;
    EditedList:TCustomImageList;
    OpenDlg   : TOpenDialog;
    SaveDlg   : TOpenDialog;
    ImageInfo : TDCImageInfo;
    FSelectedImage:integer;
    procedure FillList(Images:TCustomImageList);
    procedure SetModified(value:boolean);
  end;

  TTreeImageIndexEdit = class(TIntegerProperty)
  public
    function  GetImage:TCustomImageList;virtual;
    function  GetTreeView:TCustomTreeView;
    function  GetListView:TCustomListView;
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TTreeImageStateEdit = class(TTreeImageIndexEdit)
  public
    function  GetImage:TCustomImageList;override;
  end;

  TListImageIndexEdit = class(TTreeImageIndexEdit)
  public
    function  GetImage:TCustomImageList;override;
  end;

  TListImageStateEdit = class(TTreeImageIndexEdit)
  public
    function  GetImage:TCustomImageList;override;
  end;

 TImageListEdit = class(TComponentEditor)
 public
   procedure ExecuteVerb(Index: Integer); override;
   function GetVerb(Index: Integer): string; override;
   function GetVerbCount: Integer; override;
 end;
 TMTreeView = class(TCustomTreeView);
 TMListView = class(TCustomListView);

function EdiTCustomImageList(Images:TCustomImageList; var SelImage:Integer):boolean;
var
  FrmImageEdit: TFrmImageEdit;

implementation
{$R *.DFM}

const
  SDCImageRegName = 'DcImageEdit'; //don't resource

{----------------------TFrmImageEdit----------------------------------}

procedure TFrmImageEdit.SetModified(value:boolean);
begin
  BtnApply.Enabled:=value;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.FillList(Images:TCustomImageList);
begin
   EditedList:=Images;
   ImageList.Assign(Images);
   ImageSource.ImageList:=ImageList;
   ImageView.SmallImages:=TImageList(ImageList);
   ImageView.LargeImages:=TImageList(ImageList);
   ImageInfo:=TDCImageInfo.CreateInfo(ImageList,-1);
   ImageInfo.disabledormant := true;
   SetEnabledControls([ClearButton,ButtonDelete,SaveBut],ImageList.Count>0);
   ImageViewClick(self);
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
 {$IFDEF D3}
  OpenDlg :=TOpenPictureDialog.Create(Self);
  SaveDlg :=TSavePictureDialog.Create(Self);
 {$ELSE}
  OpenDlg:=TOpenDialog.Create(self);
  OpenDlg.Filter:=SPictFilter;
  SaveDlg:=TSaveDialog.Create(self);
  SaveDlg.Filter:=SPictFilter;
  {$ENDIF}
  OpenDlg.Options:=OpenDlg.Options+[ofAllowMultiSelect];
  SaveDlg.Options := SaveDlg.Options + [ofHideReadOnly];
  ImageList:=TCustomImageList.Create(Self);
  with TImageList(ImageList) do
    begin
      ImageType:=itImage;
      Masked:=True;
    end;
  ReadWinPosFromReg(Self,SDCImageRegName);

  Caption := RemoveCharSet(['.','&'],SVerbImageListEditor);
  GrpSel.Caption := SSelImage;
  LblTran.Caption := STransColor;
  LblFill.Caption := SFillColor;
  GrpOption.Caption := SOptions;
  PropCrop.Caption :=  SCrop;
  PropStrech.Caption  := SStretch;
  PropCenter.Caption  := SCenter;
  BtnOk.Caption := ResStr(SOKButton);
  BtnCancel.Caption := ResStr(SCancelButton);
  BtnHelp.Caption := ResStr(SHelpButton);
  BtnHelp.Visible := boolShowHelpButton;
  BtnApply.Caption := SApply;
  ButtonAdd.Caption := SAddImage;
  ButtonDelete.Caption  := SDelete;
  ClearButton.Caption := SClear ;
  SaveBut.Caption := SVerbSave;
  Save1.Caption := SVerbSave;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.FormDestroy(Sender: TObject);
begin
  WriteWinPosToReg(Self,SDCImageRegName);
  ImageInfo.Free;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.FormShow(Sender: TObject);
begin
  PropImage.Component := nil;
  ImageViewClick(Self);
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_Insert : ButtonAddClick(self);
    vk_delete : if ButtonDelete.Enabled then
                   ButtonDeleteClick(self);
  end;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.ClearButtonClick(Sender: TObject);
begin
  ImageView.Clear;
  SetEnabledControls([ClearButton,ButtonDelete,SaveBut],false);
  ImageViewClick(self);
  SetModified(true);
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.ButtonAddClick(Sender: TObject);
begin
  OpenDlg.FileName:='';
  if OpenDlg.Execute then
  begin
    with ImageView,Items  do
    begin
      Screen.Cursor:=crHourGlass;
      try
        Selected:=nil;
        AddCaption(OpenDlg.Files.Text);
      finally
        Screen.Cursor:=CrDefault;
      end;
      SetFocus;
    end;
    SetModified(true);
    ImageViewClick(self);
    SetEnabledControls([ClearButton,ButtonDelete,SaveBut],(ImageView.Items.Count>0));
  end;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.ButtonDeleteClick(Sender: TObject);
begin
  with ImageView do
    if Assigned(Selected) then
    begin
      ImageView.DeleteSelectedItems;
      SetModified(true);
      SetEnabledControls([ClearButton,ButtonDelete,SaveBut],ImageView.Items.Count<>0);
      ImageViewClick(Self);
    end;
  ImageView.SetFocus;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.ImageViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if (Change = ctState) and (ImageView.Selected <> nil) then
    ImageViewClick(Self);
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.ImageViewClick(Sender: TObject);
var
  Lst:TList;
  B:TBitmap;
begin
  if csDestroying in  ComponentState then
    exit;
  with ImageView do
  begin
    Lst := ImageView.InspectorControls;
    if Lst.Count <> 0 then
    begin
      PropImage.ComponentList:=Lst;
      SetEnabledControls([GrpOption,GrpSel,PropImage,LblFill,LblTran,PropFillCl,PropTranspCl,PropCrop,PropStrech,PropCenter],true);
    end
    else
    begin
      if Assigned(Selected) and Assigned(ImageInfo) then
      begin
        B:=TBitmap.Create;
        try
          ImageList.GetBitmap(Selected.Index,B);
          ImageInfo.AddBitmap(B,false);
          PropImage.Component:=ImageInfo;
        finally
          B.Free;
        end;
      end
      else
        PropImage.Component:=nil;
      SetEnabledControls([GrpOption,GrpSel,PropImage,LblFill,LblTran,PropFillCl,PropTranspCl,PropCrop,PropStrech,PropCenter],false);
    end;
    PropImage.UpdateEditorState;
    PropImage.Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.PropImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (PropImage.Component is TDCImageInfo ) and (PropImage.Edit is TGraphicEdit) then
     with TBitmap.Create do
     try
       Height:=PropImage.Height;
       Width:=PropImage.Width;
       with TDCImageInfo(PropImage.Component) do
       begin
         Canvas.StretchDraw(Rect(0,0,Width,Height),Bitmap);
         TransparentColor:=Canvas.Pixels[X,Y];
         PropTranspCl.UpdateEditorState;
       end;
     finally
       Free;
     end;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.BtnOkClick(Sender: TObject);
begin
  EditedList.Assign(ImageList);
  Setmodified(false);
  DesignerModified(ImageList);
  Close;
  ModalResult:=mrOk;
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.BtnApplyClick(Sender: TObject);
begin
  EditedList.Assign(ImageList);
  Setmodified(false);
  DesignerModified(ImageList);
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.ImageViewDblClick(Sender: TObject);
begin
  if FSelectedImage > -1 then
    BtnOkClick(Self);
end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.Save1Click(Sender: TObject);
var
  B:TBitmap;
begin
  if ImageView.ItemFocused <> nil then
    with SaveDlg do
      if Execute then
      begin
        B:=TBitmap.Create;
        try
          ImageList.GetBitmap(ImageView.ItemFocused.Index,B);
          B.SaveToFile(SaveDlg.FileName);
        finally
          B.Free;
        end;
      end;
 end;

{------------------------------------------------------------------}

procedure TFrmImageEdit.PropCropChange(Sender: TObject);
begin
   SetModified(true);
   ImageView.InvalidateSelection;
   PropImage.UpdateEditorState;
   PropImage.Invalidate;
end;

{-------------------TImageListEdit-----------------------------------}

procedure TImageListEdit.ExecuteVerb(Index: Integer);
var
   sel:integer;
begin
  sel:=-2;
  EdiTCustomImageList(TCustomImageList(Component),sel);
end;

{------------------------------------------------------------------}

function TImageListEdit.GetVerb(Index: Integer): string;
begin
  result := SVerbImageListEditor;
end;

{------------------------------------------------------------------}

function TImageListEdit.GetVerbCount: Integer;
begin
  result := 1;
end;

{------------------------------------------------------------------}

function EdiTCustomImageList(Images:TCustomImageList; var SelImage:Integer):boolean;
begin
   result:=false;
   with TFrmImageEdit.Create(Application) do
   try
     Caption := SCapEditing + Images.Name;
     FillList(Images);
     FSelectedImage:=SelImage;
     with ImageView do
     begin
       if (SelImage>=0) and (SelImage<Items.Count) then
         Items[SelImage].Selected:=true;
       if (Showmodal=mrOk) then
       begin
         result:=true;
         if Selected <> nil then
           SelImage:=Selected.ImageIndex
         else
           SelImage:=0;
       end;
     end;
   finally
     Free;
   end;
end;

{---------TTreeImageIndexEdit------------------------------------------}

function  TTreeImageIndexEdit.GetAttributes : TPropertyAttributes;
begin
  result:=Inherited  GetAttributes;
  if GetImage <> nil then
    include(result,paDialog);
end;

{------------------------------------------------------------------}

procedure TTreeImageIndexEdit.Edit;
var
  Res:integer;
  ImageLst:TCustomImageList;
begin
  ImageLst:=GetImage;
  if  Assigned(ImageLst) then
  begin
    res:=StrToInt(Value);
    if EdiTCustomImageList(ImageLst,res) then
    begin
      Value:=IntToStr(res);
      DesignerModified(GetComponent(0));
    end;
  end;
end;

{------------------------------------------------------------------}

function  TTreeImageIndexEdit.GetTreeView:TCustomTreeView;
var
  Cmp:TPersistent;
begin
  result:=nil;
  Cmp:=GetComponent(0);
  if (Cmp is TDCTreeData) and Assigned(TDCTreeData(Cmp).Link) then
    result:= TTreeNode(TDCTreeData(Cmp).Link).TreeView
  else
  if Cmp is TTreeNode then
    result := TTreeNode(Cmp).TreeView;

end;

{------------------------------------------------------------------}

function  TTreeImageIndexEdit.GetListView:TCustomListView;
var
  Cmp:TPersistent;
begin
  result:=nil;
  Cmp:=GetComponent(0);
  if (Cmp is TDCTreeData) and Assigned(TDCTreeData(Cmp).Link) then
    result:= TListItem(TDCTreeData(Cmp).Link).ListView
  else
  if (Cmp is TListItem) then
    result := TListItem(Cmp).ListView;
end;

{------------------------------------------------------------------}

function TTreeImageIndexEdit.GetImage:TCustomImageList;
var
  Tree:TCustomTreeView;
begin
  Tree:=GetTreeView;
  if Assigned(Tree) then
    result:=TMTreeView(Tree).Images
  else
    result:=nil;
end;

{--------------TTreeImageStateEdit------------------------------------------}

function TTreeImageStateEdit.GetImage:TCustomImageList;
var
  Tree:TCustomTreeView;
begin
  result:=nil;
  Tree:=GetTreeView;
  if Assigned(Tree) then
    result:=TMTreeView(Tree).StateImages;
end;

{--------------TListImageIndexEdit------------------------------------------}

function TListImageIndexEdit.GetImage:TCustomImageList;
var
  List:TCustomListView;
begin
  result:=nil;
  List:=GetListView;
  if Assigned(List) then
    with TMListView(List) do
      if Assigned(LargeImages) and (ViewStyle= vsIcon) then
        result:= LargeImages
      else if Assigned(SmallImages) and (ViewStyle <> vsIcon) then
        result:=SmallImages;
end;

{---------TListImageStateEdit------------------------------------------}

function TListImageStateEdit.GetImage:TCustomImageList;
var
  List:TCustomListView;
begin
  List:=GetListView;
  if Assigned(List) then
    result:=TMListView(List).StateImages
  else
    result:=nil;
end;

{------------------------------------------------------------------}
//BeginSkipConst
procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(integer),TTreeNodeData,'ImageIndex',TTreeImageIndexEdit);
  RegisterPropertyEditor(TypeInfo(integer),TTreeNodeData,'SelectedIndex',TTreeImageIndexEdit);
  RegisterPropertyEditor(TypeInfo(integer),TTreeNodeData,'StateIndex',TTreeImageStateEdit);
  RegisterPropertyEditor(TypeInfo(integer),TListData,'ImageIndex',TListImageIndexEdit);
  RegisterPropertyEditor(TypeInfo(integer),TListData,'SelectedIndex',TListImageIndexEdit);
  RegisterPropertyEditor(TypeInfo(integer),TListData,'StateIndex',TListImageStateEdit);
  RegisterComponentEditor(TCustomImageList,TImageListEdit);
end;
//EndSkipConst

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
end;

initialization
  RunRegister;
end.
