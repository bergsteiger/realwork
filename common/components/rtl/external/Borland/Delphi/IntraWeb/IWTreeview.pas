unit IWTreeview;
{PUBDIST}

interface

uses
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux}QForms,{$ELSE}Forms,{$ENDIF}
  Classes, SysUtils,
  IWControl, IWHTMLTag, IWFileReference;

Type
  TIWTreeViewItems = class;

  IIWTreeViewDesigner = interface
    procedure RefreshItems; 
  end;

  TIWTreeViewItem = class(TCollectionItem)
  protected
    FCaption: String;
    FExpanded: Boolean;
    FItems: TIWTreeViewItems;
    FName: String;
    FOnClick: TNotifyEvent;
    //
    procedure DefineProperties(AFiler: TFiler); override;
    function GetDisplayName: string; override;
    procedure ReadData(AReader: TReader);
    procedure SetDisplayName(const AValue: string); override;
    procedure SetItems(const Value: TIWTreeViewItems);
    procedure SetCaption(const Value: string);
    procedure WriteData(AWriter: TWriter);
  public
    property SubItems: TIWTreeViewItems read FItems write SetItems;
    //
    procedure AssignTo(ADest: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    function GetNamePath: string; override;
    destructor Destroy; override;
    procedure DoClick;
  published
    property Caption: string read FCaption write SetCaption;
    property Expanded: Boolean read FExpanded write FExpanded;
    property Name: string read FName write FName;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TIWTreeViewItems = class(TOwnedCollection)
  protected
    FDesigner: IIWTreeViewDesigner;
    function GetItem(AIndex: Integer): TIWTreeViewItem;
    procedure SetItem(AIndex: Integer; const AValue: TIWTreeViewItem);
  public
    function Add: TIWTreeViewItem;
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure SetDesigner(ADesigner: IIWTreeViewDesigner);
    //
    property Items[AIndex: Integer]: TIWTreeViewItem read GetItem write SetItem; default;
  end;

  TIWTreeViewImages = class(TPersistent)
  protected
    FClosedFolderImage: TIWFileReference;
    FOpenFolderImage: TIWFileReference;
    FDocumentImage: TIWFileReference;
    FPlusImage: TIWFileReference;
    FMinusImage: TIWFileReference;
    //
    procedure SetClosedFolderImage(const Value: TIWFileReference);
    procedure SetDocumentImage(const Value: TIWFileReference);
    procedure SetMinusImage(const Value: TIWFileReference);
    procedure SetOpenFolderImage(const Value: TIWFileReference);
    procedure SetPlusImage(const Value: TIWFileReference);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property OpenFolderImage: TIWFileReference read FOpenFolderImage write SetOpenFolderImage;
    property ClosedFolderImage: TIWFileReference read FClosedFolderImage write SetClosedFolderImage;
    property DocumentImage: TIWFileReference read FDocumentImage write SetDocumentImage;
    property PlusImage: TIWFileReference read FPlusImage write SetPlusImage;
    property MinusImage: TIWFileReference read FMinusImage write SetMinusImage;
  end;

  //@@ TIWTreeView implements a tree control in your application that allows for consolidation
  //of hierarchical data. Nodes can be assigned OnClick events.
  //
  //Note: TIWTreeView does work in Netscape 4 however when it is used in Netscape 4 and templates
  //are used there are some special considerations. Netscape 4 does not support DHTML on inline
  //HTML sections. It only supports DHTML on absolutely positioned sections. Because of this
  //the TIWTreeView will be output in a DIV aligned to the coordinates on the form even when
  //in a template. The name of the div will be the treeview name + Div. You can use javascript
  //or other methods to modify the DIV in your HTML.
  //
  //This only applies to Netscape 4. For other browsers the treeview is renderd in an inline SPAN
  //tag which other HTML will properly flow around when used with a template. You may wish to use
  //a different template or Netscape 4 by using the browser specific template features of
  //TIWTemplateProcessorHTML.
  TIWTreeView = class(TIWControl)
  protected
    FTreeViewItems: TIWTreeViewItems;
    FTreeViewImages: TIWTreeViewImages;
    FVertScrollBarVisible: Boolean;
    FHorScrollBarVisible: Boolean;
    //
    procedure SetTreeViewItems(const AValue: TIWTreeViewItems);
    procedure Submit(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    property Font;
    property Items: TIWTreeViewItems read FTreeViewItems write SetTreeViewItems;
    property TreeViewImages: TIWTreeViewImages read FTreeViewImages write FTreeViewImages;
    property VertScrollBarVisible: Boolean read FVertScrollBarVisible write FVertScrollBarVisible;
    property HorScrollBarVisible: Boolean read FHorScrollBarVisible write FHorScrollBarVisible;
  end;

implementation

uses
  IWApplication, IWAppForm, IWTypes, IWForm, IWServer, 
  SWSystem;

{ TIWTreeView }

constructor TIWTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSupportsSubmit := True;
  FClip := True;
  Width := 200;
  Height := 200;
  FTreeViewItems := TIWTreeViewItems.Create(self);
  FTreeViewImages := TIWTreeViewImages.Create;
  FRenderSize := true;
  FVertScrollBarVisible := false;
  FHorScrollBarVisible := false;

  if not FDesignMode then begin
    GIWServer.AddInternalFile('IW_JS_IWTreeView');
  end;
end;

destructor TIWTreeView.Destroy;
begin
  FreeAndNil(FTreeViewItems);
  FreeAndNil(FTreeViewImages);
  inherited Destroy;
end;

function TIWTreeView.RenderHTML: TIWHTMLTag;
var
  LScript: string;

  function BuildAddition(AItems: TIWTreeViewItems; AIdent : Integer = 1): String;
  var
    i: Integer;
    LItem: TIWTreeViewItem;
  begin
    result := '';
    for i := 0 to AItems.Count - 1 do begin
      LItem := AItems.Items[i];
      Result := Result
       + StringOfChar(' ', AIdent - 1)
       + 'new AddTVItem('
       + HTMLName + 'IWCL'
       + ', "' + LItem.Caption + '"'
       + ', ' + iif(Assigned(LItem.OnClick), IntToStr(Integer(LItem)), '0')
       + ', "' + LItem.Name + '"'
       + ', ' + iif(LItem.Expanded, 'true', 'false')
       + ', ';

      if AItems.Items[i].SubItems.Count > 0 then begin
        result := result + EOL + BuildAddition(AItems.Items[i].SubItems, AIdent + 1) + ', ';
      end else begin
        result := result + 'null, ';
      end;

      if i = AItems.Count - 1 then begin
        result := result + 'null';
      end else begin
        result := result + EOL;
      end;
    end;
    Result := Result + StringOfChar(')', AItems.Count);
  end;

Var
  LOpenImg, LCloseImg, LDocImg, LPlusImg, LMinusImg: String;
  LStyle: String;
begin
  if Items.Count = 0 then begin
    Result := nil;
  end else begin
    AddScriptFile('/js/IWTreeView.js');

    LOpenImg := iif(FTreeViewImages.OpenFolderImage.Location(WebApplication.URLBase),
              FTreeViewImages.OpenFolderImage.Location(WebApplication.URLBase),
              WebApplication.URLBase + '/gfx/TIWTreeview_open.gif');
    LCloseImg := iif(FTreeViewImages.ClosedFolderImage.Location(WebApplication.URLBase),
              FTreeViewImages.ClosedFolderImage.Location(WebApplication.URLBase),
              WebApplication.URLBase + '/gfx/TIWTreeview_closed.gif');
    LDocImg := iif(FTreeViewImages.DocumentImage.Location(WebApplication.URLBase),
              FTreeViewImages.DocumentImage.Location(WebApplication.URLBase),
              WebApplication.URLBase + '/gfx/TIWTreeview_document.gif');
    LPlusImg := iif(FTreeViewImages.PlusImage.Location(WebApplication.URLBase),
              FTreeViewImages.PlusImage.Location(WebApplication.URLBase),
              WebApplication.URLBase + '/gfx/TIWTreeview_plus.gif');
    LMinusImg := iif(FTreeViewImages.MinusImage.Location(WebApplication.URLBase),
              FTreeViewImages.MinusImage.Location(WebApplication.URLBase),
              WebApplication.URLBase + '/gfx/TIWTreeview_minus.gif');

    LScript :=
      HTMLName + 'IWCL.ImgOpen = "'+ LOpenImg + '";' + EOL
      + HTMLName + 'IWCL.ImgClosed = "' + LCloseImg + '";' + EOL
      + HTMLName + 'IWCL.ImgDocument = "' + LDocImg + '";' + EOL
      + HTMLName + 'IWCL.ImgPlus = "' + LPlusImg + '";' + EOL
      + HTMLName + 'IWCL.ImgMinus = "' + LMinusImg + '";' + EOL
      + HTMLName + 'IWCL.ImgBlank = "' + WebApplication.URLBase + '/gfx/Tp.gif";' + EOL
      + HTMLName + 'IWCL.Items = ' + EOL + BuildAddition(FTreeViewItems) + ';' + EOL
      + 'showTreeView(' + HTMLName + 'IWCL);' + EOL;
    with TIWAppForm(Form) do begin
      CacheImage(Self.HTMLName + '_Open', LOpenImg);
      CacheImage(Self.HTMLName + '_Closed', LCloseImg);
      CacheImage(Self.HTMLName + '_Document', LDocImg);
      CacheImage(Self.HTMLName + '_Plus', LPlusImg);
      CacheImage(Self.HTMLName + '_Minus', LMinusImg);
      CacheImage(Self.HTMLName + '_Blank', WebApplication.URLBase + '/gfx/Tp.gif');
    end;
    AddToInitProc(LScript);
    Result := TIWHTMLTag.CreateTag('DIV'); try
      Result.Contents.AddText('&nbsp;');
      LStyle := '';
      if VertScrollBarVisible then begin
        LStyle := LStyle + 'overflow-y:scroll;';
      end;

      if HorScrollBarVisible then begin
        LStyle := LStyle + 'overflow-x:scroll;';
      end;

      if LStyle <> '' then begin
        Result.AddStringParam('STYLE', LStyle);
      end;
    except FreeAndNil(Result); raise; end;
  end;
end;

procedure TIWTreeView.SetTreeViewItems(const AValue: TIWTreeViewItems);
begin
  FTreeViewItems.Assign(AValue);
end;

procedure TIWTreeView.Submit(const AValue: string);
begin
  TIWTreeViewItem(StrToInt(AValue)).DoClick;
end;

{ TIWTreeViewItem }

procedure TIWTreeViewItem.AssignTo(ADest: TPersistent);
begin
  if ADest is TIWTreeViewItem then begin
    with TIWTreeViewItem(ADest) do begin
      Caption := Self.Caption;
      Expanded := Self.Expanded;
      SubItems := Self.SubItems;
      Name := Self.Name;
      OnClick := Self.OnClick;
    end;
  end else begin
    inherited;
  end;
end;

constructor TIWTreeViewItem.Create(ACollection: TCollection);
var
  i: Integer;
  LItem: TIWTreeViewItem;
  LName: string;
  LTree: TIWTreeView;
  LOwner: TPersistent;

  function NameIsUsed(const AName: string; AItems: TIWTreeViewItems): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to AItems.Count - 1 do begin
      Result := AnsiSameText(AName, AItems.Items[i].Name)
       or NameIsUsed(AName, AItems.Items[i].SubItems);
      if Result then begin
        Break;
      end;
    end;
  end;

begin
  inherited Create(ACollection);
  // Must be before Find Name as it uses Items
  FItems := TIWTreeViewItems.Create(self);
  // Find a unique name
  //
  // Travel up to find the tree itself
  LTree := nil;
  LItem := Self;
  while LTree = nil do begin
    LOwner := LItem.GetOwner;
    if LOwner is TIWTreeView then begin
      LTree := TIWTreeView(LOwner);
    end else begin
      LItem := TIWTreeViewItem(LOwner);
    end;
  end;
  // Find a unique name
  for i := 0 to MaxInt do begin
    // Dont assign to FName otherwise NameIsUsed will find this item and return true every time.
    LName := LTree.Name + 'Item' + IntToStr(i);
    if not NameIsUsed(LName, LTree.Items) then begin
      Break;
    end;
  end;
  //
  FName := LName;
  // Remove the below since at run-time it renames the caption back to the default
  if FCaption = '' then begin
    FCaption := LName;
  end;
  FExpanded := True;
end;

procedure TIWTreeViewItem.DefineProperties(AFiler: TFiler);
begin
  inherited;
  AFiler.DefineProperty('SubItems', ReadData, WriteData, True);
end;

destructor TIWTreeViewItem.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TIWTreeViewItem.DoClick;
begin
  if Assigned(FOnClick) then begin
    FOnClick(self);
  end;
end;

function TIWTreeViewItem.GetDisplayName: string;
begin
  Result := FName;
end;

function TIWTreeViewItem.GetNamePath: string;
begin
  if Collection <> nil then begin
    Result := TIWTreeViewItems(Collection).GetOwner.GetNamePath + '.' + GetDisplayName;
  end else begin
    Result := inherited GetNamePath;
  end;
end;

procedure TIWTreeViewItem.ReadData(AReader: TReader);
begin
  AReader.CheckValue(vaCollection);
  AReader.ReadCollection(SubItems);
end;

procedure TIWTreeViewItem.SetCaption(const Value: string);
Var
  LDesigner: IDesignerNotify;
  LCollection: TCollection;
begin
  FCaption := Value;
  LDesigner := FindRootDesigner(self);
  if LDesigner <> nil then begin
    LDesigner.Modified;
  end;

  LCollection := TCollection(GetOwner);
  if (LCollection <> nil) and (LCollection is TIWTreeViewItems) then begin
    if TIWTreeViewItems(LCollection).FDesigner <> nil then begin
      TIWTreeViewItems(LCollection).FDesigner.RefreshItems;
    end;
  end;
end;

procedure TIWTreeViewItem.SetDisplayName(const AValue: string);
begin
  FName := AValue;
  inherited SetDisplayName(AValue);
end;

procedure TIWTreeViewItem.SetItems(const Value: TIWTreeViewItems);
begin
  FItems.Assign(Value);
end;

procedure TIWTreeViewItem.WriteData(AWriter: TWriter);
begin
  AWriter.WriteCollection(SubItems);
end;

{ TIWTreeViewItems }

constructor TIWTreeViewItems.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIWTreeViewItem);
end;

function TIWTreeViewItems.Add: TIWTreeViewItem;
begin
  result := TIWTreeViewItem(inherited Add);
end;

function TIWTreeViewItems.GetItem(AIndex: Integer): TIWTreeViewItem;
begin
  result := TIWTreeViewItem(inherited Items[AIndex]);
end;

procedure TIWTreeViewItems.SetItem(AIndex: Integer; const AValue: TIWTreeViewItem);
begin
  TIWTreeViewItem(inherited Items[AIndex]).Assign(AValue);
end;

procedure TIWTreeViewItems.SetDesigner(ADesigner: IIWTreeViewDesigner);
Var
  i: Integer;
begin
  FDesigner := ADesigner;
  for i := 0 to Count -1 do begin
    Items[i].SubItems.SetDesigner(ADesigner);
  end;
end;

destructor TIWTreeViewItems.Destroy;
begin
  FDesigner := nil;
  inherited Destroy;
end;

{ TIWTreeViewImages }

constructor TIWTreeViewImages.Create;
begin
  inherited Create;

  FClosedFolderImage := TIWFileReference.Create;
  FOpenFolderImage := TIWFileReference.Create;
  FDocumentImage := TIWFileReference.Create;
  FPlusImage := TIWFileReference.Create;
  FMinusImage := TIWFileReference.Create;
end;

destructor TIWTreeViewImages.Destroy;
begin
  FreeAndNil(FClosedFolderImage);
  FreeAndNil(FOpenFolderImage);
  FreeAndNil(FDocumentImage);
  FreeAndNil(FPlusImage);
  FreeAndNil(FMinusImage);

  inherited Destroy;
end;

procedure TIWTreeViewImages.SetClosedFolderImage(
  const Value: TIWFileReference);
begin
  FClosedFolderImage.Assign(Value);
end;

procedure TIWTreeViewImages.SetDocumentImage(
  const Value: TIWFileReference);
begin
  FDocumentImage.Assign(Value);
end;

procedure TIWTreeViewImages.SetMinusImage(const Value: TIWFileReference);
begin
  FMinusImage.Assign(Value);
end;

procedure TIWTreeViewImages.SetOpenFolderImage(
  const Value: TIWFileReference);
begin
  FOpenFolderImage.Assign(Value);
end;

procedure TIWTreeViewImages.SetPlusImage(const Value: TIWFileReference);
begin
  FPlusImage.Assign(Value);
end;

end.
