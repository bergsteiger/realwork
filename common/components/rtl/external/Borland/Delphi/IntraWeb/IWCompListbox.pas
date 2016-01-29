unit IWCompListbox;
{PUBDIST}

interface

uses
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  Classes, IWLayoutMgr, IWHTMLTag,
  IWControl, IWScriptEvents;

type
  TIWCustomListCombo = class(TIWControl)
  protected
    FItems: TStrings;
    FItemIndex: Integer;
    FItemsHaveValues: Boolean;
    FRequireSelection: Boolean;
    FNoSelectionText: string;
    FOnChange: TNotifyEvent;
    FUseSize: Boolean;
    //
    procedure DoChange;
    function GetSorted: boolean;
    function GetText: string; reintroduce;
    procedure HookEvents(AScriptEvents: TIWScriptEvents); override;
    procedure SetItems(AValue: TStrings);
    procedure SetItemIndex(AIndex: Integer);
    procedure SetRequireSelection(const AValue: Boolean); virtual;
    procedure SetSorted(AValue: boolean);
    procedure SetValue(const AValue: string); override;
    procedure SetUseSize(const AValue: Boolean);
    procedure SetItemsHaveValues(const Value: Boolean);
    //
    //@@ The items to appear in the control.
    //
    //SeeAlso: ItemIndex, Sorted, ItemsHaveValues
    property Items: TStrings read FItems write SetItems;
    //@@ Specifies the currently selected item. A value of -1 specifies that no item is currently
    // selected.
    //
    //SeeAlso: Items
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    // Do not publish sorted. DB controls use this and using it can interfere with their
    // functionality. Such as the lookuplist ones which rely on the sort order remaining the same
    // as fetched from the DB.
    //
    //The items in the TIWCustomListCombo are sorted.
    //
    //
    //@@ Description: Controls the sorting of items. Setting to True causes the items to be sorted
    // alphabetically. If the property is set to false, the items are presented as they are provided
    // in the Items property
    //
    //SeeAlso: Items
    property Sorted: Boolean read GetSorted write SetSorted;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ExtraTagParams;
    property Font;
    //@@ ItemsHaveValues if true expects that items is of the format:
    //Text=Value
    //The Value will be written out as the value portion of the HTML OPTION tag and only the text
    //portion will be displayed. IntraWeb does not use the value tag and has no use in a normal
    //IntraWeb application as this can be accomplished easier using Delphi code in the IntraWeb
    //application. This option is valuable however if you are using ScriptEvents.
    //
    //SeeAlso: Items
    property ItemsHaveValues: Boolean read FItemsHaveValues write SetItemsHaveValues;
    //@@ The HTML specification requires that listboxes and comboboxes have a selected item. Some
    //browsers allow for nonselection to occur, but will return the first item as selected.
    //Because of this when ItemIndex = -1 IntraWeb will dispaly -- No Selection -- and select
    //it. For customization and localization requirements you can use this property to change the
    //text that is dispalayed.
    property NoSelectionText: string read FNoSelectionText write FNoSelectionText;
    //@@ Specifies if a -- No Selection -- option appears. HTML does not allow for the user
    // to unselect a combo or list box by any other method.
    property RequireSelection: Boolean read FRequireSelection write SetRequireSelection;
    property ScriptEvents;
    property Text: string read GetText;
    //@@ OnChange is fired when the user makes a selection in the combobox.
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    //@@ Indicates whether to use the sizes defined at design-time or use the size assigned
    //on generation of the HTML
    property UseSize: Boolean read FUseSize write SetUseSize;
  end;

  TIWCustomComboBox = class(TIWCustomListCombo)
  protected
    procedure Submit(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
    // Needed for PaintHandlers
    property Items;
    property ItemIndex;
  published
    property DoSubmitValidation;
    property Editable;
    property TabOrder;
  end;

  TIWComboBox = class(TIWCustomComboBox)
  published
    property ItemIndex;
    property Items;
    property Sorted;
  end;

  TIWCustomListbox = class(TIWCustomListCombo)
  protected
    FMultiSelect: Boolean;
    FSelectedList: TList;
    //
    function GetSelected(AIndex: integer): boolean;
    procedure SetSelected(AIndex: integer; const AValue: boolean);
    procedure SetMultiSelect(const AValue: Boolean);

    procedure SetValue(const AValue: string); override;
    procedure Submit(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
    // Needed for PaintHandlers
    property Items;
    property ItemIndex;
    //@@ Allows mutliple selection of items.
    //
    //Note: MultiSelect and RequireSelection are mutually exlusive
    property MultiSelect: boolean read FMultiSelect write SetMultiSelect;
    //
    //@@ This clears all listbox selections in the Selected property.
    //
    //SeeAlso: Selected
    procedure ResetSelection;
    //
    //@@ This property indicates if a specific item in a listbox is selected. This indexed property
    // is used in combination with the MultiSelect property to allow the user to select more than
    // one item at a time.
    //
    //SeeAlso: MultiSelect
    property Selected[AIndex: Integer]: Boolean read GetSelected write SetSelected;

  published
    property DoSubmitValidation;
    property Editable;
    property TabOrder;
  end;

  TIWListbox = class(TIWCustomListbox)
  protected
    procedure SetRequireSelection(const AValue: Boolean); override;
  published
    property ItemIndex;
    property Items;
    //@@ Allows mutliple selection of items.
    //
    //Note: MultiSelect and RequireSelection are mutually exlusive
    property MultiSelect: boolean read FMultiSelect write SetMultiSelect;
    property Sorted;
  end;

implementation

uses
  {$IFDEF Linux}
  QForms,
  Types,
  {$ELSE}
  Forms,
  Windows,
  {$ENDIF}
  IWApplication, IWServerControllerBase, IWAppForm, IWCompLabel, IWTypes,
  Math,
  SWStrings, SysUtils, SWSystem;

{ TIWCustomListCombo }

constructor TIWCustomListCombo.Create(AOwner: TComponent);
begin
  inherited;
  FNeedsFormTag := True;
  RequireSelection := True;
  FSupportsSubmit := True;
  FSupportsInput := True;
  FSupportedScriptEvents := 'OnBlur,OnChange,OnFocus';
  FNoSelectionText := '-- No Selection --';
  FItems := TStringList.Create;
  FItemIndex := -1;
end;

destructor TIWCustomListCombo.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TIWCustomListCombo.GetSorted: boolean;
begin
  Result := TStringList(FItems).Sorted;
end;

procedure TIWCustomListCombo.DoChange;
begin
  if Assigned(OnChange) then begin
    OnChange(Self);
  end;
end;

procedure TIWCustomListCombo.HookEvents(AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(AScriptEvents);
  if Editable then begin
    AScriptEvents.HookEvent('OnChange', iif(Assigned(OnChange), SubmitHandler));
  end;
end;

function TIWCustomComboBox.RenderHTML: TIWHTMLTag;
var
  i: Integer;
  LText: string;
  LValue: string;
begin
  Result := nil;
  if Editable then begin
    Result := TIWHTMLTag.CreateTag('SELECT'); try
      Result.AddStringParam('NAME', HTMLName);
      Result.AddIntegerParam('SIZE', 1);
      if FUseSize then begin
        Result.AddIntegerParam('WIDTH', Width);
      end;
      {Result.Add('STYLE', iif(WebApplication.Browser in [brIE, brNetscape6]
        , Font.FontToStringStyle(WebApplication.Browser)){ + 'width: ' + IntToStr(Width) + 'px;');}

      if FItems.Count > 0 then begin
        if ((FItemIndex = -1) or (RequireSelection = False)) then begin
          with Result.Contents.AddTag('OPTION') do begin
            Add('SELECTED');
            AddIntegerParam('VALUE', -1);
            Contents.AddText(FNoSelectionText);
          end;
        end;
        for i := 0 to FItems.Count - 1 do begin
          LText := FItems[i];
          LValue := '';
          if ItemsHaveValues then begin
            LValue := LText;
            LText := Fetch(LValue, '=');
          end else begin
            LValue := IntToStr(i);
          end;
          with Result.Contents.AddTag('OPTION') do begin
            Add(iif(ItemIndex = i, 'SELECTED'));
            AddStringParam('VALUE', LValue);
            Contents.AddText(LText);
          end;
        end;
      end
      else begin
        Result.Contents.AddText('');
      end;
    except FreeAndNil(Result); raise; end;
  end else begin
    with TIWLabel.Create(Self) do try
      Caption := '';
      if (Self.Items.Count > 0) and (Self.ItemIndex > -1) then begin
        Caption := Self.Items[Self.ItemIndex];
      end;
      Result := RenderHTML;
    finally Free; end;
  end;
end;

function TIWCustomListCombo.GetText: string;
begin
  if ItemIndex > -1 then begin
    if ItemsHaveValues then begin
      Result := Items.Values[Items.Names[ItemIndex]];
    end else begin
      Result := Items[ItemIndex];
    end;
  end else begin
    Result := '';
  end;
end;

procedure TIWCustomListCombo.SetItemIndex(AIndex: Integer);
begin
  if csLoading in ComponentState then begin
    // Set no matter what, it might be set (and usually is) before the items are loaded
    FItemIndex := AIndex;
  end else if AIndex < Items.Count then begin
    FItemIndex := AIndex;
    Invalidate;
  end;
end;

procedure TIWCustomListCombo.SetItems(AValue: TStrings);
begin
  FItems.Assign(AValue);
  Invalidate;
end;

procedure TIWCustomListCombo.SetRequireSelection(const AValue: Boolean);
begin
  FRequireSelection := AValue;
end;

procedure TIWCustomListCombo.SetSorted(AValue: boolean);
begin
  TStringList(FItems).Sorted := AValue;
  Invalidate;
end;

procedure TIWcustomListCombo.SetValue(const AValue: string);
var
  s: string;
  i: integer;
begin
  s := AValue;
  if ItemsHaveValues then begin
    for i := 0 to Items.Count - 1 do begin
      if S = Items.Values[Items.Names[i]] then begin
        ItemIndex := i;
        break;
      end;
    end;
  end else begin
    ItemIndex := StrToIntDef(Fetch(s, ','), -1);
  end;
  Invalidate;
end;

procedure TIWCustomListCombo.SetUseSize(const AValue: Boolean);
begin
  FRenderSize := AValue;
  FUseSize := AValue;
end;

procedure TIWCustomListCombo.SetItemsHaveValues(const Value: Boolean);
begin
  FItemsHaveValues := Value;
  Invalidate;
end;

{ TIWCustomListbox }

constructor TIWCustomListbox.Create(AOwner: TComponent);
begin
  inherited;
  FSelectedList := TList.Create;
  Height := 121;
  Width := 121;
end;

destructor TIWCustomListbox.Destroy;
begin
  FreeAndNil(FSelectedList);
  inherited;
end;

function TIWCustomListbox.GetSelected(AIndex: Integer): boolean;
begin
  if FMultiSelect then begin
    Result := FSelectedList.IndexOf(TObject(AIndex)) > -1;
  end else begin
    Result := AIndex = ItemIndex;
  end;
end;

function TIWCustomListbox.RenderHTML: TIWHTMLTag;
var
  i: Integer;
  LText: string;
  LValue: string;
begin
  Result := nil;
  if Editable then begin
    Result := TIWHTMLTag.CreateTag('SELECT'); try
      Result.AddStringParam('NAME', HTMLName);
      Result.AddIntegerParam('SIZE', Height div 16);
      Result.Add(iif(FMultiSelect, 'MULTIPLE'));
      if FUseSize then begin
        Result.AddIntegerParam('WIDTH', Width);
      end;
      {Result.Add('STYLE', iif(WebApplication.Browser in [brIE, brNetscape6]
        , Font.FontToStringStyle(WebApplication.Browser)));}
      if FItems.Count > 0 then begin
        if ((FItemIndex = -1) or (RequireSelection = False))
         and (FMultiSelect = False) then begin
          with Result.Contents.AddTag('OPTION') do begin
            Add('SELECTED');
            AddIntegerParam('VALUE', -1);
            Contents.AddText(FNoSelectionText);
          end;
        end;
        for i := 0 to FItems.Count - 1 do begin
          LText := FItems[i];
          LValue := '';
          if ItemsHaveValues then begin
            LValue := LText;
            LText := Fetch(LValue, '=');
          end else begin
            LValue := IntToStr(i);
          end;
          with Result.Contents.AddTag('OPTION') do begin
            Add(iif((
             (ItemIndex = i) and (FMultiSelect = False))
             or (Selected[i] and FMultiSelect)
             , 'SELECTED'));
            AddStringParam('VALUE', LValue);
            Contents.AddText(LText);
          end;
        end;
      end
      else begin
        Result.Contents.AddText('');
      end;
    except FreeAndNil(Result); raise; end;
  end else begin
    with TIWLabel.Create(Self) do try
      Name := Self.Name;
      Color := Self.Color;
      FFriendlyName := Self.FriendlyName;
      ExtraTagParams.Assign(Self.ExtraTagParams);
      Font.Assign(Self.Font);
      ScriptEvents.Assign(Self.ScriptEvents);
      Width := Self.Width;
      Height := Self.Height;
      Caption := '';
      if Self.ItemIndex > -1 then begin
        Caption := Self.FItems[Self.ItemIndex];
      end;
      Result := RenderHTML;
    finally Free; end;
  end;
end;

procedure TIWCustomListbox.ResetSelection;
begin
  FSelectedList.Clear;
  Invalidate;
end;

procedure TIWCustomListbox.SetSelected(AIndex: integer; const AValue: boolean);
begin
  if AValue then begin
    if not GetSelected(AIndex) then begin
      FSelectedList.Add(TObject(AIndex));
    end;
  end else begin
    FSelectedList.Remove(TObject(AIndex));
  end;
  Invalidate;
end;

procedure TIWCustomListbox.SetMultiSelect(const AValue: boolean);
begin
  if AValue then begin
    FRequireSelection := False;
  end;
  FMultiSelect := AValue;
end;

procedure TIWCustomListbox.SetValue(const AValue: string);
var
  LValue, s: string;
  i: Integer;
begin
  LValue := AValue;
  s := Fetch(LValue, ',');
  if ItemsHaveValues then begin
    for i := 0 to Items.Count - 1 do begin
      if s = Items.Values[Items.Names[i]] then begin
        ItemIndex := i;
        break;
      end;
    end;
  end else begin
    ItemIndex := StrToIntDef(s, -1);
  end;
  // For multiselect, first one is ItemIndex. Will be repeated in selected list
  // ItemIndex := StrToIntDef(Fetch(LValue, ','), -1);
  if FMultiSelect then begin
    ResetSelection;
    Selected[ItemIndex] := true;
    while Length(LValue) > 0 do begin
      s := Fetch(LValue, ',');
      if ItemsHaveValues then begin
        for i := 0 to Items.Count - 1 do begin
          if s = Items.Values[Items.Names[i]] then
            break;
        end;
      end else begin
        i := StrToInt(s);
      end;

      Selected[i] := True;
    end;
  end;
end;

procedure TIWCustomListbox.Submit(const AValue: string);
begin
  DoChange;
end;

{ TIWCustomComboBox }

constructor TIWCustomComboBox.Create(AOwner: TComponent);
begin
  inherited;
  Height := 21;
  Width := 121;
end;

procedure TIWCustomComboBox.Submit(const AValue: string);
begin
  DoChange;
end;

{ TIWListbox }

procedure TIWListbox.SetRequireSelection(const AValue: Boolean);
begin
  if AValue then begin
    FMultiSelect := False;
  end;
  inherited;
end;

end.
