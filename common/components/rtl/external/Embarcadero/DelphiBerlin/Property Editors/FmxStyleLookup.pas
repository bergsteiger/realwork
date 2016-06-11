{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FmxStyleLookup;

interface

uses
  TypInfo, Windows, System.SysUtils, System.Classes, System.Actions, System.UITypes, System.Types, System.Math,
  System.RTLConsts, System.UIConsts, Vcl.Controls, Vcl.Graphics, Vcl.Dialogs, FMX.Controls, FMX.Styles, DesignIntf,
  DesignEditors, ComponentDesigner, VCLEditors;

type

  TStyleLookupPropertyValues = class(TStringProperty)
  private
    procedure GetStyledControl(out AStyledControl: TStyledControl; out AStyleName: string;
      out AScene: IScene); virtual;
    function GetCurrentStyleDescriptor: TStyleDescription;
  protected
    function SkipStyle(const ControlStyleName, StyleName: string): Boolean; virtual;
    function SkipSceneStyle(StyleName: string): Boolean; virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TStyleLookupProperty = class(TStyleLookupPropertyValues, ICustomPropertyListDrawing)
  private
    { ICustomPropertyDrawing }
    procedure ListMeasureWidth(const Value: string; ACanvas: VCL.Graphics.TCanvas; var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: VCL.Graphics.TCanvas; var AHeight: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: VCL.Graphics.TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  TStyleLookupPropertyListView = class(TStyleLookupPropertyValues)   // not owner draw
  end;

  TStyleLookupPropertyButton = class(TStyleLookupProperty)
  protected
    function SkipStyle(const ControlStyleName, StyleName: string): Boolean; override;
  end;

  TStyleLookupPropertyEdit = class(TStyleLookupProperty)
  protected
    function SkipStyle(const ControlStyleName, StyleName: string): Boolean; override;
  end;

  TStyleLookupPropertyCalendar = class(TStyleLookupProperty)
  protected
    function SkipStyle(const ControlStyleName, StyleName: string): Boolean; override;
  end;

  TStyleLookupPropertyListBox = class(TStyleLookupProperty)
  protected
    function SkipStyle(const ControlStyleName, StyleName: string): Boolean; override;
  end;

  TListBoxDefaultsProperty = class(TStyleLookupProperty)
  protected
    function GetItemClassName: string; virtual; abstract;
    procedure GetStyledControl(out AStyledControl: TStyledControl; out AStyleName: string;
      out AScene: IScene); override;
  end;

  TDefaultListBoxItemStyleProperty = class(TListBoxDefaultsProperty)
    function GetItemClassName: string; override;
  end;

  TDefaultListBoxGroupHeaderStyleProperty = class(TListBoxDefaultsProperty)
    function GetItemClassName: string; override;
  end;

  TDefaultListBoxGroupFooterStyleProperty = class(TListBoxDefaultsProperty)
    function GetItemClassName: string; override;
  end;

procedure RegisterStyleLookupEditors;

implementation

uses
  FMX.Types, FMX.BehaviorManager, FMX.Graphics, FMX.ListBox, FMX.Layers3D, FMX.Forms, FMX.ListView,
  FMX.Objects, FMX.Utils, FMX.Edit, FMX.StdCtrls, FMX.Calendar;

type
  TOpenStyledControl = class(TStyledControl);

procedure RegisterStyleLookupEditors;
begin
  RegisterPropertyEditor(TypeInfo(string), TStyledControl, 'StyleLookup', TStyleLookupProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomListBox, 'StyleLookup', TStyleLookupPropertyListBox);
  RegisterPropertyEditor(TypeInfo(string), TCustomLayer3D, 'StyleLookup', TStyleLookupProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomForm, 'StyleLookup', TStyleLookupProperty);
  RegisterPropertyEditor(TypeInfo(string), TListBoxItemStyleDefaults, 'ItemStyle', TDefaultListBoxItemStyleProperty);
  RegisterPropertyEditor(TypeInfo(string), TListBoxItemStyleDefaults, 'GroupHeaderStyle', TDefaultListBoxGroupHeaderStyleProperty);
  RegisterPropertyEditor(TypeInfo(string), TListBoxItemStyleDefaults, 'GroupFooterStyle', TDefaultListBoxGroupFooterStyleProperty);
  RegisterPropertyEditor(TypeInfo(String), TCustomListView, 'StyleLookup', TStyleLookupPropertyListView);
  RegisterPropertyEditor(TypeInfo(string), TEdit, 'StyleLookup', TStyleLookupPropertyEdit);
  RegisterPropertyEditor(TypeInfo(string), TCalendar, 'StyleLookup', TStyleLookupPropertyCalendar);
  RegisterPropertyEditor(TypeInfo(string), TCustomButton, 'StyleLookup', TStyleLookupPropertyButton);
end;

function TStyleLookupPropertyValues.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable, paMultiSelect];
end;

procedure TStyleLookupPropertyValues.GetStyledControl(out AStyledControl: TStyledControl; out AStyleName: string; out AScene: IScene);
const
  StyleSuffix = 'style';
begin
  AStyledControl := nil;
  if GetComponent(0) is TStyledControl then
  begin
    AStyledControl := TStyledControl(GetComponent(0));
    AStyleName := AStyledControl.DefaultStyleLookupName.ToLower;
    if AStyleName.Contains(StyleSuffix) then
      AStyleName := AStyleName.Remove(AStyleName.Length - StyleSuffix.Length);
    AScene := AStyledControl.Scene;
  end
  else
    Supports(GetComponent(0), IScene, AScene);
end;

function TStyleLookupPropertyValues.GetCurrentStyleDescriptor: TStyleDescription;
var
  StyleBehavior: IInterface;
  CurrentStyle: TFmxObject;
  Persistent: TPersistent;
  Context: TFmxObject;
begin
  Result := nil;
  Context := nil;
  Persistent := GetComponent(0);
  if Persistent is TFmxObject then
    Context := TFmxObject(Persistent)
  else if Persistent is TListBoxItemStyleDefaults then
    Context := TListBoxItemStyleDefaults(Persistent).ListBox;
  StyleBehavior := TBehaviorServices.Current.GetBehaviorService(IStyleBehavior, Context);
  if StyleBehavior <> nil then
  begin
    (StyleBehavior as IStyleBehavior).GetSystemStyle(Context, CurrentStyle);
    if CurrentStyle <> nil then
      Result := TStyleManager.FindStyleDescriptor(CurrentStyle);
  end;
end;

function TStyleLookupPropertyValues.SkipStyle(const ControlStyleName, StyleName: string): Boolean;
const
  Scrollbar = 'scrollbar';
  Thumb = 'thumb';
  Track = 'track';
  Expander = 'expander';
  Button = 'button';
  Segment = 'segment';
  Bordered = 'bordered';
var
  StyleDesc: TStyleDescription;
begin
  Result := True;
  // Do not localize all string consts
  if TBitmapCodecManager.CodecExists(StyleName) or StyleName.Contains(Scrollbar) or StyleName.Contains(Thumb) or
     StyleName.Contains(Track) or StyleName.Contains(Expander) or ((Pos(Button, ControlStyleName) = 1) and
     (Pos(Segment, StyleName) > 0)) then
    Exit;

  StyleDesc := GetCurrentStyleDescriptor;
  if (StyleDesc <> nil) and StyleDesc.PlatformTarget.Contains('[ANDROID]') and ControlStyleName.Contains(Button) and
    StyleName.Contains(Bordered) then
    Exit;

  Result := False;
end;

function TStyleLookupPropertyValues.SkipSceneStyle(StyleName: string): Boolean;
const
  BackgroundStyle = 'backgroundstyle';
  Toolbar = 'toolbar';
  Statusbar = 'statusbar';
  Panel = 'panel';
begin
  Result := not (StyleName.Contains(BackgroundStyle) or StyleName.Contains(Toolbar) or StyleName.Contains(Panel) or
    StyleName.Contains(Statusbar));
end;

procedure TStyleLookupPropertyValues.GetValues(Proc: TGetStrProc);
var
  Styles: TStringList;
  StyleName: string;

  function CompletedStyle(const StyleObject: TFmxObject): Boolean;
  begin
    if StyleObject <> nil then
      Result := TStyleManager.FindStyleDescriptor(StyleObject) <> nil
    else
      Result := False;
  end;

  procedure AddStylesForControl(const StyleObject: TFmxObject);
  var
    I: Integer;
  begin
    if StyleObject <> nil then
      for I := 0 to StyleObject.ChildrenCount - 1 do
      begin
        if SkipStyle(StyleName, LowerCase(StyleObject.Children[I].StyleName)) then Continue;
        if Pos(StyleName, LowerCase(StyleObject.Children[I].StyleName)) > 0 then
        begin
          if Styles.IndexOf(StyleObject.Children[I].StyleName) < 0 then
            Styles.Add(StyleObject.Children[I].StyleName);
        end else if Pos('speedbutton', LowerCase(StyleName)) = 1 then
        begin
          if Pos('button', LowerCase(StyleObject.Children[I].StyleName)) > 0 then
            if Styles.IndexOf(StyleObject.Children[I].StyleName) < 0 then
              Styles.Add(StyleObject.Children[I].StyleName);
        end;
      end;
  end;

  procedure AddStylesForScene(const StyleObject: TFmxObject);
  var
    I: Integer;
  begin
    if StyleObject <> nil then
      for I := 0 to StyleObject.ChildrenCount - 1 do
      begin
        if SkipStyle(StyleName, LowerCase(StyleObject.Children[I].StyleName)) then
          Continue;
        if not SkipSceneStyle(StyleObject.Children[I].StyleName.ToLower) then
          if Styles.IndexOf(StyleObject.Children[I].StyleName) < 0 then
            Styles.Add(StyleObject.Children[I].StyleName);
      end;
  end;

var
  UseDefaultStyle: Boolean;
  StyledControl: TStyledControl;
  Scene: IScene;
  I: Integer;
begin
  try
    GetStyledControl(StyledControl, StyleName, Scene);
    if StyleName <> '' then // Selection is TStyledControl
    begin
      Styles := TStringList.Create;
      Styles.CaseSensitive := False;
      try
        // First check StyleBook
        UseDefaultStyle := True;
        if (Scene <> nil) and (Scene.StyleBook <> nil) then
        begin
          AddStylesForControl(Scene.StyleBook.Style);
          UseDefaultStyle := not CompletedStyle(Scene.StyleBook.Style);
        end;
        // Check default style
        if UseDefaultStyle then
          AddStylesForControl(TStyleManager.ActiveStyleForScene(Scene));

        Styles.Sort;
        for I := 0 to Styles.Count - 1 do
          Proc(Styles[I]);
      finally
        Styles.Free;
      end;
    end
    else
    if Scene <> nil then
    begin
      Styles := TStringList.Create;
      Styles.CaseSensitive := False;
      try
        // First check StyleBook
        UseDefaultStyle := True;
        if (Scene <> nil) and (Scene.StyleBook <> nil) then
        begin
          AddStylesForScene(Scene.StyleBook.Style);
          UseDefaultStyle := not CompletedStyle(Scene.StyleBook.Style);
        end;
        // Check default style
        if UseDefaultStyle then
          AddStylesForScene(TStyleManager.ActiveStyleForScene(Scene));

        Styles.Sort;
        for I := 0 to Styles.Count - 1 do
          Proc(Styles[I]);
      finally
        Styles.Free;
      end;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStyleLookupProperty.ListDrawValue(const Value: string; ACanvas: VCL.Graphics.TCanvas; const ARect: TRect; ASelected: Boolean);
var
  R: TRect;
  B: VCL.Graphics.TBitmap;
  FB: FMX.Graphics.TBitmap;
  Clone: FMX.Controls.TControl;
  Scene: IScene;
  StyledControl: FMX.Controls.TStyledControl;
  Style: TFmxObject;
  M: FMX.Graphics.TBitmapData;
  I: Integer;
  BaseRect: TRectF;
  FittingRect: TRectF;
  Tile: FMX.Graphics.TBitmap;
  T: TFmxObject;
  StyleName: string;
begin
  try
    R := ARect;
    if (Value <> '') then
    begin
      ACanvas.FillRect(ARect);
      Scene := nil;
      Style := nil;
      GetStyledControl(StyledControl, StyleName, Scene);
      if StyledControl <> nil then
      begin
        // check
        if Assigned(StyledControl.Scene) and Assigned(StyledControl.Scene.StyleBook) then
          Style := StyledControl.Scene.StyleBook.Style
        else
          Style := nil;
        Scene := StyledControl.Scene;

        if StyledControl.Width > StyledControl.Height then
          BaseRect := RectF(0, 0, 90, 50)
        else
          BaseRect := RectF(0, 0, 50, 90);
      end
      else if Scene <> nil then
      begin
        if Scene.StyleBook <> nil then
          Style := Scene.StyleBook.Style;
        if Scene.Canvas <> nil then
        begin
          if Scene.Canvas.Width > Scene.Canvas.Height then
            BaseRect := RectF(0, 0, 90, 50)
          else
            BaseRect := RectF(0, 0, 50, 90);
        end
        else
          BaseRect := RectF(0, 0, 90, 50)
      end;

      if (Style = nil) or (Style.FindStyleResource(Value) = nil) then
        Style := TStyleManager.ActiveStyleForScene(Scene);

      // create clone
      if Style <> nil then
      begin
        Clone := FMX.Controls.TControl(Style.FindStyleResource(Value));
        if Clone <> nil then
        begin
          Tile := FMX.Graphics.TBitmap.Create(50, 38);

          Clone := FMX.Controls.TControl(Clone.Clone(nil));
          T := Clone.FindStyleResource('text');
          if (T <> nil) and (T is TText) then
          begin
            if Pos('label', Style.StyleName) = 0 then
              TText(T).Text := 'Label'
            else
              TText(T).Text := '';
          end;

          FittingRect := BaseRect;
          if not SameValue(TOpenStyledControl(Clone).FixedSize.Height, 0) then
            FittingRect.Height := TOpenStyledControl(Clone).FixedSize.Height;
          if not SameValue(TOpenStyledControl(Clone).FixedSize.Width, 0) then
            FittingRect.Width := TOpenStyledControl(Clone).FixedSize.Width;

          Clone.SetBounds(0, 0, FittingRect.Width, FittingRect.Height);
          Clone.SetNewScene(Scene);
          FB := Clone.MakeScreenshot;
          Clone.SetNewScene(nil);
          Clone.Free;

          FittingRect.Fit(RectF(0, 0, Tile.Width, Tile.Height));
          if Tile.Canvas.BeginScene then
          try
            // background
            Clone := FMX.Controls.TControl(Style.FindStyleResource('backgroundstyle'));
            if Assigned(Clone) then
            begin
              Clone := FMX.Controls.TControl(Clone.Clone(nil));
              Clone.SetBounds(0, 0, 400, 400);
              Clone.SetNewScene(Scene);
              Clone.PaintTo(Tile.Canvas, Clone.LocalRect);
              Clone.SetNewScene(nil);
              Clone.Free;
            end
            else
              Tile.Canvas.Clear($FFBaBaBa);
            //
            Tile.Canvas.DrawBitmap(FB, RectF(0, 0, FB.Width, FB.Height), FittingRect, 1);
          finally
            Tile.Canvas.EndScene;
          end;
          try
            B := VCL.Graphics.TBitmap.Create;
            try
              B.HandleType := bmDIB;
              B.PixelFormat := pf32Bit;
              B.SetSize(Tile.Width, Tile.Height);
              if Tile.Map(TMapAccess.Read, M) then
              try
                for I := 0 to Tile.Height - 1 do
                  Move(PAlphaColorArray(M.Data)[I * (M.Pitch div 4)], B.ScanLine[I]^, B.Width * 4);
              finally
                Tile.Unmap(M);
              end;
              ACanvas.Draw(R.Left, R.Top, B);
              Inc(R.Left, B.Width + 4);
            finally
              B.Free;
            end;
          finally
            FB.Free;
            Tile.Free;
          end;
        end;
      end;
    end;
  finally
    DefaultPropertyListDrawValue(Value, ACanvas, R, ASelected);
  end;
end;

procedure TStyleLookupProperty.ListMeasureHeight(const Value: string; ACanvas: VCL.Graphics.TCanvas; var AHeight: Integer);
begin
  AHeight := 38;
end;

procedure TStyleLookupProperty.ListMeasureWidth(const Value: string; ACanvas: VCL.Graphics.TCanvas; var AWidth: Integer);
begin
end;

function TStyleLookupPropertyValues.GetValue: string;
begin
  try
    Result := GetStrValue;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStyleLookupPropertyValues.SetValue(const Value: string);
begin
  try
    SetStrValue(Value);
    Modified;
    Designer.NoSelection;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

{ TDefaultListBoxItemStyleProperty }

procedure TListBoxDefaultsProperty.GetStyledControl(out AStyledControl: TStyledControl;
  out AStyleName: string; out AScene: IScene);
var
  ListBox: TCustomListBox;
begin
  AStyledControl := nil;
  if GetComponent(0) is TListBoxItemStyleDefaults then
  begin
    ListBox := (GetComponent(0) as TListBoxItemStyleDefaults).ListBox;
    AStyleName := Lowercase(Copy(GetItemClassName, 2, MaxInt));
    AScene := ListBox.Scene;
  end
  else
    Assert(False);
end;

function TDefaultListBoxItemStyleProperty.GetItemClassName: string;
begin
  Result := TListBoxItem.ClassName;
end;

function TDefaultListBoxGroupHeaderStyleProperty.GetItemClassName: string;
begin
  Result := TListBoxGroupHeader.ClassName;
end;

function TDefaultListBoxGroupFooterStyleProperty.GetItemClassName: string;
begin
  Result := TListBoxGroupFooter.ClassName;
end;

{ TStyleLookupPropertyListBox }

function TStyleLookupPropertyListBox.SkipStyle(const ControlStyleName, StyleName: string): Boolean;
const
  ListBoxItem = 'listboxitem';
  Footer = 'footer';
  Header = 'header';
begin
  Result := StyleName.Contains(ListBoxItem) or StyleName.Contains(Header) or StyleName.Contains(Footer) or
    inherited SkipStyle(ControlStyleName, StyleName);
end;

{ TStyleLookupPropertyEdit }

function TStyleLookupPropertyEdit.SkipStyle(const ControlStyleName, StyleName: string): Boolean;
const
  EditButtonStyle = 'editbutton';
  TimeEditStyle = 'timeedit';
  DateEditStyle = 'dateedit';
begin
  Result := StyleName.Contains(EditButtonStyle) or StyleName.Contains(DateEditStyle) or
    StyleName.Contains(TimeEditStyle) or inherited SkipStyle(ControlStyleName, StyleName);
end;

{ TStyleLookupPropertyCalendar }

function TStyleLookupPropertyCalendar.SkipStyle(const ControlStyleName, StyleName: string): Boolean;
const
  LabelStyle = 'label';
begin
  Result := StyleName.Contains(LabelStyle) or inherited SkipStyle(ControlStyleName, StyleName);
end;

{ TStyleLookupPropertyButton }

function TStyleLookupPropertyButton.SkipStyle(const ControlStyleName, StyleName: string): Boolean;
const
  LabelStyle = 'label';
begin
  Result := StyleName.Contains(LabelStyle) or inherited SkipStyle(ControlStyleName, StyleName);
end;

end.
