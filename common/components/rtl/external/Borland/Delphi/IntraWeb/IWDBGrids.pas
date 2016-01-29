unit IWDBGrids;
{PUBDIST}

{$I IWCompilerDefines.inc}

// Credits:
//
// Thanks goes out to David Mustard and Huw Reddick
// for their contributions to the IWDBGrid and
// their continued support of IntraWeb and IntraWeb users
//
// Thanks Guys!!!

interface

uses
{$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
  Classes,
  DB,
  IWControl, IWGrids, IWHTMLTag, IWTypes;

type
  THighlightCompare = (hcNone, hcEqualTo, hcNotEqualTo, hcContains,
    hcDoesNotContain, hcGreaterThan, hcLessThan);

  TIWDBGridColumn = class(TIWGridCell)
  protected
    FBlobCharLimit: Integer;
    FCompareValue: string;
    FCompareHighlight: THighlightCompare;
    FDataField: string;
    FLinkField: string;
    FOnClick: TIWOnClickWithValue;
    FOnTitleClick: TNotifyEvent;
    FTitle: TIWGridCell;
    //
    procedure SetDataField(const AValue: string);
    procedure SetTitle(const AValue: TIWGridCell);
    function GetDisplayName: string; override;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    procedure AssignTo(ADest: TPersistent); override;
  published
    //@@ BlobCharLimit sets the maximum number of characters to be displayed in a grid from a blob
    //or memo field. 0 disables this feature. Setting it to a value >0 will cause the output for the
    //field to be truncated at that length if it is a blob or memo field. If the output is truncated
    //... will be appended to the end of the output to let the user know that the display is
    //truncated.
    property BlobCharLimit: Integer read FBlobCharLimit write FBlobCharLimit;
    //@@
    property CompareValue: string read FCompareValue write FCompareValue;
    //@@
    property CompareHighlight: THighlightCompare read FCompareHighlight write FCompareHighlight;
    //@@ Specifies the field to obtain data to display.
    property DataField: string read FDataField write SetDataField;
    //@@ If LinkField is set the column will be clickable. LinkField specifies the field to extract
    //data from and pass as a parameter to pass to the OnClick event.
    //
    //SeeAlso: OnClick
    property LinkField: string read FLinkField write FLinkField;
    //@@ Occurs when the user clicks on a column that is clickable. To make a column clikable
    //set the LinkField property.
    //
    //SeeAlso: LinkField
    property OnClick: TIWOnClickWithValue read FOnClick write FOnClick;
    //@@ Occurs when the user clicks on a title header. Title headres become clickable when their
    //OnTitleClick property is set.
    property OnTitleClick: TNotifyEvent read FOnTitleClick write FOnTitleClick;
    //@@ Column title. Column definition - the columns had to be redefined and are inherited from
    // the originals.  Of course there also had to be a redfined Collection class for these new
    // columns (at least I think there had to be, it works better this way!)
    property Title: TIWGridCell read FTitle write SetTitle;
  end;

  TIWDBGridColumns = class(TOwnedCollection)
  end;

  TIWDBGrid = class;
  TIWDBGridOption = (dgIndicator, dgShowTitles);
  TIWDBGridOptions = set of TIWDBGridOption;
  TIWDBGridRefreshMode = (rmAutomatic, rmAlways, rmManual);

  //@@ Put a TIWDBGrid control on a form to display records from a dataset in a grid fashion.
  TIWDBGrid = class(TIWCustomGrid)
  protected
    FColumns: TIWDBGridColumns;
    FCurrentField: TField;
    FDataSource: TDataSource;
    FFooterRowCount: Integer;
    FFromStart: Boolean;
    FHighlightRows: Boolean;
    FHighlightColor: TIWColor;
    FOptions: TIWDBGridOptions;
    FRecordCount: Integer;
    FRenderBuffer: TIWHTMLTagCollection;
    FRowIsCurrent: Boolean;
    FRowLimit: integer;
    FRowClick: Boolean;
    FRollOver: Boolean;
    FRollOverColor: TIWColor;
    FRowHeaderColor: TIWColor;
    FRowAlternateColor: TIWColor;
    FRowCurrentColor: TIWColor;
    FRefreshMode: TIWDBGridRefreshMode;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure RenderCells(AGridTag: TIWHTMLTag); override;
    procedure SetColumns(AValue: TIWDBGridColumns);
    procedure Submit(const AValue: string); override;
    function IsValidCell(ACell: TIWGridCell): Boolean; override;

    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateImplicitColumns;
    destructor Destroy; override;
    //@@ RefreshData forces the grid to reload its cells from the dataset.
    procedure RefreshData(AGridTag: TIWHTMLTag);
    //
    //@@ CurrentField contains the current TField for the current cell. This is useful during the
    //OnRenderCell event.
    property CurrentField: TField read FCurrentField;
    //@@ RecordCount contains the number of records rendered into the grid.
    property RecordCount: Integer read FRecordCount;
    //@@ RowIsCurrent is true if the current row is the current one in the dataset. This is useful
    //during the OnRenderCell event.
    property RowIsCurrent: Boolean read FRowIsCurrent;
  published
    //@@ Contains a list of columns to display.
    property Columns: TIWDBGridColumns read FColumns write SetColumns;
    //@@ Datasource to obtain data from.
    property DataSource: TDataSource read FDataSource write FDataSource;
    //@@ FooterRowCount can be used to add additional rows at the bottom of the grid. After
    //the data has been rendered into the cells the DB Grid will begin rendering the footer
    //rows by starting with a negative row count to signify a footer row. It will then incremememt
    //and repeat for each footer row with the last row being -1.
    //As an example, if FooterRowCount is 3 the footer rows will begin with -3 and count to -1.
    property FooterRowCount: Integer read FFooterRowCount write FFooterRowCount;
    //@@ If FromStart is True, the dataset will be moved to the first record before rendering.
    property FromStart: Boolean read FFromStart write FFromStart;
    //@@
    property HighlightColor: TIWColor read FHighlightColor write FHighlightColor;
    //@@ HighlightRows will highlight a row where certain criteria has been satisfied against
    // each column of the row. It uses a compare feature on each column to see if it
    // compares with the desired value. This compare set is defined as follows: ThlCompare =
    // (hcNone, hcEqualTo, hcNotEqualTo, hcContains, hcDoesNotContain, hcGreaterThan, hcLessThan);
    property HighlightRows: Boolean read FHighlightRows write FHighlightRows;
    //@@ Options to control the appearance of the DBGrid.
    property Options: TIWDBGridOptions read FOptions write FOptions;
    //@@ Because of different needs than a standard GUI application TIWDBGrid cannot efficiently
    //retrieve data from the dataset in the same fashion as Delphi's standard TDBGrid. RefreshMode
    //allows you to control how the data is refreshed from the dataset.
    //
    //+ rmAutomatic - Data will be refreshed on each render request unless the dataset is in edit
    //or insert mode.
    //+ rmAlways - Data will be refreshed on every render request. If the dataset is in edit or
    //insert mode an exception will be raised.
    //+ rmManual - Data will be refreshed only when the RefreshData method is explicitly called.
    //
    //Note: This will never refresh the rows of the dataset itself.
    property RefreshMode: TIWDBGridRefreshMode read FRefreshMode write FRefreshMode;
    //@@ RowLimit can be used to limit the number of rows displayed in the grid. Combined with
    //from start and controlled positioning of the dataset custom paging can be implemented.
    property RowLimit: integer read FRowLimit write FRowLimit;
    //@@ RollOver indicates whether to distinguish the row where the mouse is over with a certain color indicated
    //by the value of RollOverColor
    property RollOver: Boolean read FRollOver write FRollOver;
    //@@ RowClick allows you to click anywhere on the row and initiate the link field
    // related to one of the columns in the row. Must be enabled AND at least one of the columns
    // is linked to a datafield AND the grid frame is disabled AND FromStart is False
    property RowClick: Boolean read FRowClick write FRowClick;
    //@@ RollOverColor indicates the color of the current row if RollOver is set to True
    property RollOverColor: TIWColor read FRollOverColor write FRollOverColor;
    //@@ RowHeaderColor indicates whether the headers should use the Color property
    property RowHeaderColor: TIWColor read FRowHeaderColor write FRowHeaderColor;
    //@@ RowAlternateColor can be specified to give alternate rows different colors
    property RowAlternateColor: TIWColor read FRowAlternateColor write FRowAlternateColor;
    //@@ RowCurrentColor specifies the color of the current selected row
    property RowCurrentColor: TIWColor read FRowCurrentColor write FRowCurrentColor;
  end;

implementation

uses
  IWDBStdCtrls, IWServerControllerBase, IWResourceStrings,
  SWSystem, SWStrings, SysUtils;

{ TIWDBGrid }

constructor TIWDBGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSupportsSubmit := True;
  FFromStart := True;
  FOptions := [dgShowTitles];
  FUseFrame := True;
  FRollOverColor := clNone;
  FHighlightColor := clNone;
  FRowHeaderColor := clNone;
  FRowAlternateColor := clNone;
  FRowCurrentColor := clNone;
  FColumns := TIWDBGridColumns.Create(Self, TIWDBGridColumn);
  FRenderBuffer := nil;
end;

destructor TIWDBGrid.Destroy;
begin
  FreeAndNil(FRenderBuffer);
  FreeAndNil(FColumns);
  inherited;
end;

procedure TIWDBGrid.CreateImplicitColumns;
var
  i: integer;
  LField: TField;
begin
  if Columns.Count = 0 then begin
    for i := 0 to Datasource.Dataset.FieldList.Count - 1 do begin
      LField := Datasource.Dataset.Fields[i];
      if LField.Visible then begin
        with TIWDBGridColumn(Columns.Add) do begin
          DataField := LField.DisplayName;
        end;
      end;
    end;
  end;
end;

procedure TIWDBGrid.Notification(AComponent: TComponent; AOperation: TOperation);
Var
  i: Integer;
begin
  inherited;
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;

    if Assigned(FColumns) then begin
      for i := 0 to FColumns.Count - 1 do begin
        if AComponent = TIWDBGridColumn(FColumns.Items[i]).Control then begin
          TIWDBGridColumn(FColumns.Items[i]).Control := nil;
        end;
      end;
    end;
  end;
end;

procedure TIWDBGrid.RenderCells(AGridTag: TIWHTMLTag);
var
  LJScript: TStrings;
begin
  LJScript := TStringList.Create;
  try
    with LJScript do begin
      Add('function rollon(row,where){ ');
      Add('var tablecolor;');
      Add('if (where == ''over''){');
      Add(' currentcolor=document.getElementById(row).style.getAttribute("backgroundColor")');
      Add(' document.getElementById(row).style.backgroundColor=''' + ColorToRGBString(FRollOverColor) + ''' ');
      Add(' }else{ ');
      Add(' document.getElementById(row).style.setAttribute("backgroundColor",currentcolor) }');
      Add('}');
    end;
    AddToJavaScriptOnce(LJScript.Text);
  finally
    FreeAndNil(LJSCript);
  end;

  case RefreshMode of
    rmAutomatic: begin
        if CheckDataSource(DataSource) then begin
          if not InEditMode(DataSource.Dataset) then begin
            RefreshData(AGridTag);
          end;
        end;
      end;
    rmAlways: begin
        RefreshData(AGridTag);
      end
  end;
  AGridTag.Contents.AddTagCollection(FRenderBuffer);
end;

procedure TIWDBGrid.SetColumns(AValue: TIWDBGridColumns);
begin
  Columns.Assign(AValue);
end;

procedure TIWDBGrid.Submit(const AValue: string);
var
  LColumn: TIWDBGridColumn;
  LValue: string;
begin
  LValue := AValue;
  if Copy(LValue, 1, 1) = 'C' then begin
    LColumn := TIWDBGridColumn(Columns.Items[StrToInt(Copy(LValue, 2, MaxInt))]);
    if Assigned(LColumn.OnTitleClick) then begin
      LColumn.OnTitleClick(LColumn);
    end;
  end else begin
    LColumn := TIWDBGridColumn(Columns.Items[StrToInt(Fetch(LValue, '_'))]);
    if Assigned(LColumn.OnClick) then begin
      LColumn.OnClick(LColumn, LValue);
    end;
  end;
end;

procedure TIWDBGrid.RefreshData(AGridTag: TIWHTMLTag);

  function CheckForHighlighting(ADataSet: TDataSet): Boolean;
  var
    LVariant: array of Boolean;
    i: Integer;
    j: Integer;
    k: Integer;
  begin
    Result := False;
    //j := 0;
    k := 0;
    SetLength(LVariant, Columns.Count);
    for i := 0 to High(LVariant) do begin
      with TIWDBGridColumn(Columns.Items[i]) do begin
        if (Visible) and (Length(DataField) > 0) then begin
          LVariant[i] := false;
          if CompareHighlight <> hcNone then begin
            Inc(k);
          end;
          FCurrentField := ADataSet.FieldByName(DataField);
          j := CompareText(FCurrentField.Text, CompareValue);
          Case CompareHighlight of
            hcEqualTo: LVariant[i]:=(j=0);
            hcNotEqualTo: LVariant[i]:=FCurrentField.Text <> CompareValue;
            hcContains: LVariant[i]:=(Pos(CompareValue, FCurrentField.Text) <> 0);
            hcDoesNotContain: LVariant[i]:=(Pos(CompareValue, CurrentField.Text) = 0);
            hcGreaterThan: LVariant[i]:=(j>0);
            hcLessThan: LVariant[i]:=(j<0);
          end;
        end;
      end;
    end;
    j := 0;
    if k=0 then begin
      Exit;
    end;
    for i := 0 to High(LVariant) do begin
      if (LVariant[i]=True) then begin
        Inc(j);
      end;
    end;
    SetLength(LVariant, 0);
    Result := j=k;
  end;

var
  i: Integer;
  s: string;
  LActualColNo: Integer;
  LBookmark: string;
  LCell: TIWGridCell;
  LColNo: Integer;
  LData: TDataset;
  LRecNo: Integer;
  LRowLimit: integer;
  LAfterNext: Boolean;
  LHighlightRow: Boolean;
  LAlternateRow: Boolean;
  LTmpTag: TIWHTMLTag;
begin
  if Assigned(FRenderBuffer) then
    FRenderBuffer.Clear
  else
    FRenderBuffer := TIWHTMLTagCollection.Create;

  FRowIsCurrent := False;
  FCurrentField := nil;
  LAfterNext := false;
  if CheckDataSource(DataSource) then begin
    if InEditMode(DataSource.Dataset) then begin
      raise Exception.Create(RSNoRefereshWhileInEdit);
    end;
    CreateImplicitColumns;
    // Title Row
    if dgShowTitles in Options then begin
      with FRenderBuffer.AddTag('tr') do begin
        if dgIndicator in Options then begin
          with Contents.AddTag('th') do begin
            Contents.AddText('&nbsp');
            if RowHeaderColor <> clNone then begin
              AddColor('BGCOLOR', RowHeaderColor);
            end;
          end;
        end;
        LActualColNo := 0;
        for LColNo := 0 to Columns.Count - 1 do begin
          with TIWDBGridColumn(Columns.Items[LColNo]) do begin
            if Visible then begin
              LCell := TIWGridCell.Create(nil); try
                LCell.Assign(Title);
                if Assigned(OnTitleClick) then begin
                  DoSubmitValidation := LCell.DoSubmitValidation;
                  LTmpTag := SubmitLink(LCell.Text, 'C' + IntToStr(LColNo)); try
                    LCell.Text := LTmpTag.Render;
                  finally FreeAndNil(LTmpTag); end;
                end;
                with Contents.AddTagAsObject(LCell.RenderSelf(Self, 0, LActualColNo)) do begin;
                  if RowHeaderColor <> clNone then begin
                    AddColor('BGCOLOR', RowHeaderColor);
                  end;
                end;
                Inc(LActualColNo);
              finally FreeAndNil(LCell); end;
            end;
          end;
        end;
      end;
    end;
    // Data Rows
    LData := DataSource.Dataset;
    LData.DisableControls;
    LBookmark := LData.Bookmark; try
      // First or Refresh MUST be called otherwise Calc Fields may not be updated.
      if FromStart then begin
        LData.First;
      end;
      if RowLimit = 0 then begin
        LRowLimit := MaxInt;
      end else begin
        LRowLimit := RowLimit;
        // This causes the top row to be on a rowlimit boundary and not to move with the record
        // itself.
        if LData.RecNo > -1 then begin
          LData.MoveBy(-((LData.RecNo - 1) mod LRowLimit));
        end;
      end;
      for LRecNo := 1 to LRowLimit do begin
        if LAfterNext then begin
          Break;
        end;
        FRowIsCurrent := LBookmark = LData.Bookmark;

        with FRenderBuffer.AddTag('TR') do begin
          AddIntegerParam('ID', LRecNo);
          if FRollover then begin
            AddStringParam('OnMouseOut', 'rollon(' + IntToStr(LRecNo)+ ','''')');
            AddStringParam('OnMouseOver', 'rollon(' + IntToStr(LRecNo) + ',''over'')');
          end;

          FRowIsCurrent := (LBookmark = LData.Bookmark);


          LHighlightRow := False;
          if FHighlightRows then
            LHighlightRow := CheckForHighlighting(DataSource.DataSet);

          LAlternateRow := False;
          if (FRowAlternateColor <> clNone) and (LRecNo mod 2 = 0)
            and (not LHighlightRow) then
              LAlternateRow := True;

          if FRowIsCurrent then
            AddColor('BGCOLOR', FrowCurrentColor)
          else begin
            If LAlternateRow then
              AddColor('BGCOLOR', FRowAlternateColor);
            If LHighlightRow then
              AddColor('BGCOLOR', FHighlightColor);
          end;

          if dgIndicator in Options then begin
            if RowIsCurrent then begin
              with Contents.AddTag('TD') do
                Contents.AddText('*');
            end else begin
              with Contents.AddTag('TD') do
                Contents.AddText('&nbsp ');
            end;
          end;
          LActualColNo := 0;
          for LColNo := 0 to Columns.Count - 1 do begin
            with TIWDBGridColumn(Columns.Items[LColNo]) do begin
              if Visible then begin
                //TODO: Cache fields in an array
                FCurrentField := nil;
                if Length(DataField) > 0 then begin
                  FCurrentField := LData.FieldByName(DataField);
                end;
                LCell := TIWGridCell.Create(nil); try
                  AssignTo(LCell);
                  // Will be nil if user created extra columns for custom use in events or for
                  // controls
                  if FCurrentField <> nil then begin
                    // Retrieve data to display
                    if CurrentField.DataType in [ftBlob, ftMemo] then begin
                      s := CurrentField.DisplayText;
                      if (BlobCharLimit > 0) and (Length(s) > BlobCharLimit) then begin
                        s := Copy(s, 1, BlobCharLimit) + '...';
                      end;
                      LCell.Text := TextToHTML(s);
                    end else if CurrentField.DataType = ftGraphic then begin
                      LCell.Text := '';
                    end else begin
                      LCell.Text := TextToHTML(CurrentField.DisplayText);
                    end;
                    // Linked fields
                    if Length(LinkField) > 0 then begin
                      DoSubmitValidation := LCell.DoSubmitValidation;
                      if not RowClick then begin
                        LTmpTag := SubmitLink(LCell.Text
                          , IntToStr(LColNo) + '_' + LData.FieldByName(LinkField).AsString);
                        LCell.Text := LTmpTag.Render;
                        LTmpTag.Free;
                      end else begin
                        LCell.Text := TextToHTML(CurrentField.DisplayText);
                        AddStringParam('OnClick', 'SubmitClickConfirm(''' + Name + ''','''
                          + IntToStr(LColNo) + '_'
                          + LData.FieldByName(LinkField).AsString + ''', true, '''')');
                        AddStringParam('STYLE', 'cursor:hand;');
                      end;
                    end;
                  end;
                  //
                  Contents.AddTagAsObject(LCell.RenderSelf(Self, LRecNo, LActualColNo));
                  Inc(LActualColNo);
                finally FreeAndNil(LCell); end;
              end;
            end;
          end;
        end;
        LData.Next;
        LAfterNext := LData.EOF;
        FRecordCount := LRecNo;
      end;
    finally
      FRenderSize := (RowLimit = 0) or (FRecordCount = RowLimit);
      LData.Bookmark := LBookmark;
      LData.EnableControls;
    end;
    // Footer Rows
    FRowIsCurrent := False;
    if FooterRowCount > 0 then begin
      with FRenderBuffer.AddTag('TR') do begin
        for i := -FooterRowCount to -1 do begin
          if dgIndicator in Options then begin
            with Contents.AddTag('th') do begin
              Contents.AddText('&nbsp');
            end;
          end;
          LActualColNo := 0;
          for LColNo := 0 to Columns.Count - 1 do begin
            with TIWDBGridColumn(Columns.Items[LColNo]) do begin
              if Visible then begin
                LCell := TIWGridCell.Create(nil);
                AssignTo(LCell);
                Contents.AddTagAsObject(LCell.RenderSelf(Self, i, LActualColNo));
                Inc(LActualColNo);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TIWDBGrid.Loaded;
var
  i: Integer;
begin
  inherited Loaded;

  // Update Column titles with field.DisplayName 
  for i := 0 to Columns.Count - 1 do begin
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
      if (DataSource.DataSet.FindField(TIWDBGridColumn(Columns.Items[i]).DataField) <> nil) and
        (TIWDBGridColumn(Columns.Items[i]).Title.Text = '') then
        TIWDBGridColumn(Columns.Items[i]).Title.Text := DataSource.DataSet.FieldByName(TIWDBGridColumn(Columns.Items[i]).DataField).DisplayName;
  end;
end;

function TIWDBGrid.IsValidCell(ACell: TIWGridCell): Boolean;
Var
  LCell: TCollectionItem;
begin
  LCell := FColumns.FindItemID(ACell.ID);
  result := LCell = ACell;
end;

{ TIWDBGridColumn }

procedure TIWDBGridColumn.AssignTo(ADest: TPersistent);
begin
  if ADest is TIWDBGridColumn then begin
    with ADest as TIWDBGridColumn do begin
      OnClick := Self.OnClick;
      BlobCharLimit := Self.BlobCharLimit;
      CompareValue := Self.CompareValue;
      CompareHighlight := Self.CompareHighlight;
      DataField := Self.DataField;
      LinkField := Self.LinkField;
      OnTitleClick := Self.OnTitleClick;
      Title := Self.Title;
    end;
  end;
  inherited AssignTo(ADest);
end;

constructor TIWDBGridColumn.Create(ACollection: TCollection);
begin
  inherited;
  FBGColor := clNone;
  // DONT make headers. It forces center and bolding which gets wierd with font overrides
  FTitle := TIWGridCell.Create(nil);
  FTitle.Alignment := taCenter;
  FCompareHighlight := hcNone;
end;

destructor TIWDBGridColumn.Destroy;
begin
  FreeAndNil(FTitle);
  inherited;
end;

function TIWDBGridColumn.GetDisplayName: string;
begin
  if Length(FDataField) > 0 then begin
    Result := FDataField
  end else begin
    Result := inherited GetDisplayName;
  end;
end;

procedure TIWDBGridColumn.SetDataField(const AValue: string);
begin
  FDataField := AValue;
  // Only set caption if its empty, or is the same as the field name
  if (Length(Title.Text) = 0) or (Title.Text = AValue) then begin
    Title.Text := AValue;
  end;
end;

procedure TIWDBGridColumn.SetTitle(const AValue: TIWGridCell);
begin
  FTitle.Assign(AValue);
end;

end.

