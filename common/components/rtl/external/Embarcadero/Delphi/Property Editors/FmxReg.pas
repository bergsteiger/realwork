{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FmxReg;

interface

procedure Register;

implementation

uses Vcl.Graphics, System.SysUtils, System.Classes, System.Actions, System.UITypes, System.Types, System.Math,
  DesignIntf, DesignEditors, System.RTLConsts, DsnConst, DesignConst, FMX.Ani,
  FMX.StdCtrls,
  FMX.Controls, FMX.Forms, FMX.ExtCtrls, ColnEdit, FMX.Header, FMX.Grid, FMX.Dialogs, Dialogs,
  MaskUtils, TreeIntf, DesignMenus, FMX.Types, FMX.Types3D, FMX.Colors, FMX.Effects,
  FMX.Filter, FMX.Filter.Effects, FMX.Layers3D, FMX.Objects, FMX.Objects3D, FMX.Layouts,
  FMX.ListBox, FMX.Memo, FMX.TabControl, FMX.Media, FMX.Edit, FMX.TreeView, FMX.ListView, FMX.Menus,
  FMX.Platform, FMX.Platform.Win, FMX.Materials, FMX.Styles, FMX.Sensors, FmxDsnConst,
  FMX.Viewport3D, FMX.Controls3D, FMX.MaterialSources, FMX.MagnifierGlass, FMX.MediaLibrary.Actions,
  FmxEditors, FMX.WebBrowser, FMX.Gestures, Generics.Collections, Generics.Defaults,
  // Designers
  FMX.Design.Brush, FMX.Design.Bitmap, FMX.Design.Style, FMX.Design.Items,FMX.Design.Path, FMX.Design.Lang,
  ActnEdit, FMX.ActnList, FMX.StdActns, FMX.ActnRes, ActionEditors, ComponentDesigner, FMX.Design.TabIcon,
  VCLEditors, FmxAnimationEditors, FMX.Design.Import,
  {$IFDEF MSWINDOWS}
  StringsEdit,
  StrEdit,
  {$ENDIF}
  {$IFDEF LINUX}
  FmxStrEdit,
  {$ENDIF}
  TypInfo,
  Windows,
  Vcl.Controls, FMX.Editor.Items, FmxSprigs;

{ FireMonkey Editors }

{ TBrushProperty }

type

  TBrushProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

procedure TBrushProperty.Edit;
var
  BrushDesigner: TBrushDesigner;
begin
  BrushDesigner := TBrushDesigner.Create(nil);
  with BrushDesigner do
  try
    Designer := Self.Designer;
    Component := Self.GetComponent(0);
    CurrentBrush := TBrush(Self.GetOrdValue);
    ShowModal;
  finally
    FreeAndNil(BrushDesigner);
  end;
end;

function TBrushProperty.GetValue: string;
begin
  Result := '(Brush)';
end;

function TBrushProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end;

type

  TResourceProperty = class(TClassProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
    procedure Edit; override;
  end;

  TStyleBookEditor = class(TComponentEditor)
  private
  public
    procedure Edit; override;
  end;

{ TResourceProperty }

function DesignStyleBook(AStyleBook: TStyleBook; ADesigner: IDesigner; Current: string): boolean;
var
  IdeHost: TWinControl;

begin
  Result := false;
  if AStyleBook <> nil then
  begin
    if StyleDesigner <> nil then
    begin
      // Clean up if we are already running
      StyleDesigner.Close;
      Application.ProcessMessages; // Let the design get destroyed
    end;

    if StyleDesigner <> nil then
    begin
      // Previous was not closed (user cancelled save),  so show it
      StyleDesigner.Designer.Activate;
      StyleDesigner.Show;
      StyleDesigner.BringToFront;
    end
    else
    begin
      StyleDesigner := TStyleDesigner.Create(Application);

      StyleDesigner.Designer := ADesigner;
      StyleDesigner.FStyleBook := AStyleBook;

      (AStyleBook as IDesignStyleBook).FillStrings;
      StyleDesigner.LoadFromStrings(AStyleBook.Resource);

      if ((AStyleBook as IDesignStyleBook).DesignResource <> '') then
        StyleDesigner.SelectByName((AStyleBook as IDesignStyleBook).DesignResource);

      if (ADesigner.Root is TForm) then
      begin
        IdeHost := FindControl(Windows.GetParent(Windows.GetParent(Windows.GetParent(WindowHandleToPlatform(TForm(ADesigner.Root).Handle).Wnd))));
        StyleDesigner.BorderStyle := TFmxFormBorderStyle.bsNone;
        StyleDesigner.Show;
        Windows.SetParent(WindowHandleToPlatform(StyleDesigner.Handle).Wnd, IdeHost.Handle);
        StyleDesigner.SetVclHost(IdeHost);
      end
      else
        StyleDesigner.Show;
    end;
  end;
end;

procedure TResourceProperty.Edit;
begin
  if DesignStyleBook(TStyleBook(GetComponent(0)), Designer, '') then
    Modified;
end;

function TResourceProperty.GetValue: String;
begin
  Result := '(Resource)';
end;

function TResourceProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ TStyleBookEditor }

procedure TStyleBookEditor.Edit;
begin
  if DesignStyleBook(TStyleBook(Component), Designer, '') then
    Designer.Modified;
end;

type
  TFontProperty = class (VCLEditors.TFontProperty)
  protected
    procedure FmxToVclFont(const SourceValue: TFont; const DestValue: Vcl.Graphics.TFont);
    procedure VclToFmxFont(const SourceValue: Vcl.Graphics.TFont; const DestValue: TFont);
  public
    procedure Edit; override;
  end;

  TPathDataProperty = class(TClassProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
    procedure Edit; override;
  end;

  TTriggerProperty = class(TStringProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;


{ TTriggerProperty }

function TTriggerProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

procedure TTriggerProperty.GetValues(Proc: TGetStrProc);
begin
  try
    Proc('IsChecked=true');
    Proc('IsChecked=false');
    Proc('IsDragOver=true');
    Proc('IsDragOver=false');
    Proc('IsFocused=true');
    Proc('IsFocused=false');
    Proc('IsMouseOver=true');
    Proc('IsMouseOver=false');
    Proc('IsOpen=true');
    Proc('IsOpen=false');
    Proc('IsPressed=true');
    Proc('IsPressed=false');
    Proc('IsSelected=true');
    Proc('IsSelected=false');
    Proc('IsVisible=true');
    Proc('IsVisible=false');
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

function TTriggerProperty.GetValue: string;
begin
  try
    Result := GetStrValue;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TTriggerProperty.SetValue(const Value: string);
begin
  try
    SetStrValue(Value);
    Modified;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

type

  TMeshDataProperty = class(TClassProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
    procedure Edit; override;
  end;

  TStringOfFloatTripletsProperty = class(TStringProperty)
  protected
    procedure ValidateInput(const Value: string);
  public
    procedure SetValue(const Value: string); override;
  end;

  TStringOfFloatDoublesProperty = class(TStringProperty)
  protected
    procedure ValidateInput(const Value: string);
  public
    procedure SetValue(const Value: string); override;
  end;

  TStringOfIntegersProperty = class(TStringProperty)
  protected
    procedure ValidateInput(const Value: string);
  public
    procedure SetValue(const Value: string); override;
  end;

procedure TStringOfFloatTripletsProperty.SetValue(const Value: string);
begin
  try
    ValidateInput(Value);
    try
      SetStrValue(Value);
      Modified;
    except
      raise;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStringOfFloatTripletsProperty.ValidateInput(const Value: string);
var
  Pos: Integer;
  S1, S2, S3: String;
begin
  Pos := 1;
  while Pos < Length(Value) do
  begin
      S1 := WideGetToken(Pos, Value, ' ,');
      if Length(S1) = 0 then
        raise Exception.Create(sThreeFloatsException);
      try
        StrToFloat(S1, USFormatSettings);
      except
        raise Exception.Create(sThreeFloatsException);
      end;

      S2 := WideGetToken(Pos, Value, ' ,');
      if Length(S2) = 0 then
        raise Exception.Create(sThreeFloatsException);
      try
        StrToFloat(S2, USFormatSettings);
      except
        raise Exception.Create(sThreeFloatsException);
      end;

      S3 := WideGetToken(Pos, Value, ' ,');
      if Length(S3) = 0 then
        raise Exception.Create(sThreeFloatsException);
      try
        StrToFloat(S3, USFormatSettings);
      except
        raise Exception.Create(sThreeFloatsException);
      end;
  end;
end;

procedure TStringOfFloatDoublesProperty.SetValue(const Value: string);
begin
  try
    ValidateInput(Value);
    try
      SetStrValue(Value);
      Modified;
    except
      raise;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStringOfFloatDoublesProperty.ValidateInput(const Value: string);
var
  Pos: Integer;
  S1, S2: String;
begin
  Pos := 1;
  while Pos < Length(Value) do
  begin
      S1 := WideGetToken(Pos, Value, ' ,');
      if Length(S1) = 0 then
        raise Exception.Create(sTwoFloatsException);
      try
        StrToFloat(S1, USFormatSettings);
      except
        raise Exception.Create(sTwoFloatsException);
      end;

      S2 := WideGetToken(Pos, Value, ' ,');
      if Length(S2) = 0 then
        raise Exception.Create(sTwoFloatsException);
      try
        StrToFloat(S2, USFormatSettings);
      except
        raise Exception.Create(sTwoFloatsException);
      end;
  end;
end;

procedure TStringOfIntegersProperty.SetValue(const Value: string);
begin
  try
    ValidateInput(Value);
    try
      SetStrValue(Value);
      Modified;
    except
      raise;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TStringOfIntegersProperty.ValidateInput(const Value: string);
var
  Pos: Integer;
  S1: String;
begin
  Pos := 1;
  while Pos < Length(Value) do
  begin
      S1 := WideGetToken(Pos, Value, ' ');
      if Length(S1) = 0 then
        raise Exception.Create(sIntegersSetException);
      try
        StrToInt(S1);
      except
        raise Exception.Create(sIntegersSetException);
      end;
  end;
end;

{ TStyleLookupProperty }

type

  TOpenStyledControl = class(TStyledControl);

  TStyleLookupPropertyValues = class(TStringProperty)
  private
    procedure GetStyledControl(out AStyledControl: TStyledControl; out AStyleName: string;
      out AScene: IScene); virtual;
    function SkipStyle(ControlStyleName, StyleName: string): Boolean; virtual;
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

  TStyleLookupPropertyListBox = class(TStyleLookupProperty)
  protected
    function SkipStyle(ControlStyleName, StyleName: string): Boolean; override;
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


function TStyleLookupPropertyValues.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable, paMultiSelect];
end;

procedure TStyleLookupPropertyValues.GetStyledControl(out AStyledControl: TStyledControl; out AStyleName: string; out AScene: IScene);
begin
  AStyledControl := nil;
  if GetComponent(0) is TStyledControl then
  begin
    AStyledControl := TStyledControl(GetComponent(0));
    AStyleName := LowerCase(AStyledControl.ClassName);
    Delete(AStyleName, 1, 1);
    AScene := AStyledControl.Scene;
  end
  else
    Supports(GetComponent(0), IScene, AScene);
end;

function TStyleLookupPropertyValues.SkipStyle(ControlStyleName, StyleName: string): Boolean;
begin
  Result := True;
  // skip internal styles
  if Pos('scrollbar', StyleName) > 0 then Exit;
  if Pos('thumb', StyleName) > 0 then Exit;
  if Pos('track', StyleName) > 0 then Exit;
  if Pos('expander', StyleName) > 0 then Exit;
  if (Pos('button', ControlStyleName) = 1) and (Pos('segment', StyleName) > 0) then Exit;

  Result := False;
end;


procedure TStyleLookupPropertyValues.GetValues(Proc: TGetStrProc);
  function ForSceneStyle(StyleName: string): Boolean;
  begin
    Result := True;
    if Pos('backgroundstyle', StyleName) > 0 then Exit;
    if Pos('toolbar', StyleName) > 0 then Exit;
    if Pos('panel', StyleName) > 0 then Exit;
    if Pos('statusbar', StyleName) > 0 then Exit;
    Result := False;
  end;

var
  StyledControl: TStyledControl;
  Style: TFmxObject;
  StyleName: string;
  Styles: TStringList;
  Scene: IScene;
  I: Integer;
begin
  try
    GetStyledControl(StyledControl, StyleName, Scene);
    if StyleName <> '' then // GetComponent(0) is TStyledControl then
    begin
      Styles := TStringList.Create;
      Styles.CaseSensitive := False;
      try
        // check StyleBook
        if Assigned(Scene) and Assigned(Scene.StyleBook) then
        begin
          Style := Scene.StyleBook.Style;
          if Style <> nil then
            for I := 0 to Style.ChildrenCount - 1 do
            begin
              if SkipStyle(StyleName, LowerCase(Style.Children[I].StyleName)) then Continue;
              if Pos(StyleName, LowerCase(Style.Children[I].StyleName)) > 0 then
              begin
                if Styles.IndexOf(Style.Children[I].StyleName) < 0 then
                  Styles.Add(Style.Children[I].StyleName);
              end else if Pos('speedbutton', LowerCase(StyleName)) = 1 then
              begin
                if Pos('button', LowerCase(Style.Children[I].StyleName)) > 0 then
                  if Styles.IndexOf(Style.Children[I].StyleName) < 0 then
                    Styles.Add(Style.Children[I].StyleName);
              end;
            end;
        end else begin
          // check default
          Style := TStyleManager.ActiveStyleForScene(Scene);
          if (Style <> nil) then
            for I := 0 to Style.ChildrenCount - 1 do
            begin
              if SkipStyle(StyleName, LowerCase(Style.Children[I].StyleName)) then Continue;
              if Pos(StyleName, LowerCase(Style.Children[I].StyleName)) > 0 then
              begin
                if Styles.IndexOf(Style.Children[I].StyleName) < 0 then
                  Styles.Add(Style.Children[I].StyleName);
              end else if Pos('speedbutton', LowerCase(StyleName)) = 1 then
              begin
                if Pos('button', LowerCase(Style.Children[I].StyleName)) > 0 then
                  if Styles.IndexOf(Style.Children[I].StyleName) < 0 then
                    Styles.Add(Style.Children[I].StyleName);
              end;
            end;
        end;
        //
        Styles.Sort;
        // add
        for I := 0 to Styles.Count - 1 do
          Proc(Styles[I]);
      finally
        Styles.Free;
      end;
    end
    else if Scene <> nil then 
    begin
      Styles := TStringList.Create;
      Styles.CaseSensitive := False;
      try
        // check StyleBook
        if Assigned(Scene.StyleBook) then
        begin
          Style := Scene.StyleBook.Style;
          if Style <> nil then
            for I := 0 to Style.ChildrenCount - 1 do
            begin
              if SkipStyle(StyleName, LowerCase(Style.Children[I].StyleName)) then Continue;
              if ForSceneStyle(LowerCase(Style.Children[I].StyleName)) then
                if Styles.IndexOf(Style.Children[I].StyleName) < 0 then
                  Styles.Add(Style.Children[I].StyleName);
            end;
        end else begin
          // check default
          Style := TStyleManager.ActiveStyleForScene(Scene);
          if (Style <> nil) then
            for I := 0 to Style.ChildrenCount - 1 do
            begin
              if SkipStyle(StyleName, LowerCase(Style.Children[I].StyleName)) then Continue;
              if ForSceneStyle(LowerCase(Style.Children[I].StyleName)) then
                if Styles.IndexOf(Style.Children[I].StyleName) < 0 then
                  Styles.Add(Style.Children[I].StyleName);
            end;
        end;
        //
        Styles.Sort;
        // add
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
  FB: FMX.Types.TBitmap;
  Clone: FMX.Controls.TControl;
  Scene: IScene;
  StyledControl: FMX.Controls.TStyledControl;
  Style: TFmxObject;
  M: FMX.Types.TBitmapData;
  I: Integer;
  BaseRect: TRectF;
  FittingRect: TRectF;
  Tile: FMX.Types.TBitmap;
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
        if Assigned(Scene.StyleBook) then
          Style := Scene.StyleBook.Style;
        if Assigned(Scene.Canvas) then
        begin
          if Scene.Canvas.Width > Scene.Canvas.Height then
            BaseRect := RectF(0, 0, 90, 50)
          else
            BaseRect := RectF(0, 0, 50, 90);
        end
        else
          BaseRect := RectF(0, 0, 90, 50)
      end;
      if not Assigned(Style) then
        Style := TStyleManager.ActiveStyleForScene(Scene);
      // create clone
      if Assigned(Style) then
      begin
        Clone := FMX.Controls.TControl(Style.FindStyleResource(Value));
        if Assigned(Clone) then
        begin
          Tile := FMX.Types.TBitmap.Create(50, 38);

          Clone := FMX.Controls.TControl(Clone.Clone(nil));
          T := Clone.FindStyleResource('text');
          if (T <> nil) and (T is TText) then
          begin
            if (Pos('label', Style.StyleName) = 0) then
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
              if Tile.Map(TMapAccess.maRead, M) then
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
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

{ Items Editor Base Classes ===================================================}

{TShorCutProperty}

type
  TShortCutProperty = class(VCLEditors.TShortCutProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

function TShortCutProperty.GetValue: string;
var
  CurValue: TShortCut;
  MenuService: IFMXMenuService;
  S: string;
begin
  CurValue := GetOrdValue;
  if CurValue = scNone then
    Result := srNone
  else
  begin
    S := '';
    if TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(MenuService)) then
      S := MenuService.ShortCutToText(CurValue);
    if S = '' then
      Result := '(' + IntToStr(CurValue) + ')'
    else
      Result := S;
  end;
end;

procedure TShortCutProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  MenuService: IFMXMenuService;
  S: string;
begin
  Proc(srNone);
  TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(MenuService));
  for I := 0 to RegisteredShortCutCount - 1 do
  begin
    S := '';
    if Assigned(MenuService) then
      S := MenuService.ShortCutToText(RegisteredShortCut(I));
    if S = '' then
      S := '(' + IntToStr(RegisteredShortCut(I)) + ')';
    Proc(S);
  end;
end;

procedure TShortCutProperty.SetValue(const Value: string);
var
  NewValue: TShortCut;
  S: string;
  I, Code: integer;
begin
  S := Trim(Value);
  NewValue := 0;
  if (S <> '') and (AnsiCompareText(Value, srNone) <> 0) then
  begin
    NewValue := FMX.ActnList.TextToShortCut(S);
    if NewValue = 0 then
    begin
      if (S[1] = '(') and (S[Length(S)] = ')') then
      begin
        S := Copy(S, 2, Length(S) - 2);
        Val(S, I, Code);
        if Code = 0 then
          NewValue := I;
      end;
      if NewValue = 0 then
        raise EDesignPropertyError.Create(SInvalidPropertyValue);
    end;
  end;
  SetOrdValue(NewValue);
end;

type

{ TLangProperty }

  TLangProperty = class(TStringProperty)
  private
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

function TLangProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;

procedure TLangProperty.Edit;
begin
  vgLangDesigner := TLangDesigner.Create(Application);
  vgLangDesigner.Designer := Designer;
  with vgLangDesigner do
  begin
    FLang := TLang(GetComponent(0));
    langList.Items.Assign(FLang.Resources);
    if langList.Items.Count > 0 then
      langList.ItemIndex := FLang.Resources.IndexOf(FLang.Lang);

    layoutAdd.Visible := langList.Items.Count = 0;
    layoutSelect.Visible := langList.Items.Count > 0;

    RebuildOriginalList;
    if ShowModal = mrOk then
    begin
      FLang.Lang := langList.Text;
      Designer.Modified;
    end;
  end;
  vgLangDesigner.Free;
end;

type

{ TLangEditor }

  TLangEditor = class(TComponentEditor)
  private
  public
    procedure Edit; override;
  end;

procedure TLangEditor.Edit;
begin
  ShowDsgnLang(TLang(Component), Designer);
end;


{ TMeshCollectionProperty }
type

  TMeshCollectionProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

function TMeshCollectionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TMeshCollectionProperty.GetValue: string;
begin
  Result := '(MeshCollection)';
end;

procedure TMeshCollectionProperty.Edit;
var
  LMeshCollectionDesigner: TMeshCollectionDesigner;
  I: Integer;
  BtnEnable: Boolean;
begin
  LMeshCollectionDesigner := TMeshCollectionDesigner.Create(nil);
  LMeshCollectionDesigner.CloneMeshCollection(TModel3D(GetComponent(0)));
  LMeshCollectionDesigner.Scale := TModel3D(GetComponent(0)).Scale.X;

  {enable/disable some buttons from the editor}
  BtnEnable:= LMeshCollectionDesigner.Model3D1.ChildrenCount > 0;
  LMeshCollectionDesigner.btnClear.Enabled:=BtnEnable;
  LMeshCollectionDesigner.btnUp.Enabled:= BtnEnable;
  LMeshCollectionDesigner.btnDown.Enabled:= BtnEnable;
  LMeshCollectionDesigner.btnLeft.Enabled:= BtnEnable;
  LMeshCollectionDesigner.btnRight.Enabled:= BtnEnable;

  if LMeshCollectionDesigner.ShowModal = mrOk then
  begin
//    Modified;

    if LMeshCollectionDesigner.Command = cClear then
      for i := 0 to PropCount - 1 do
        TModel3D(GetComponent(i)).Clear
    else
    if LMeshCollectionDesigner.Command = cOpen then
      for i := 0 to PropCount - 1 do
        TModel3D(GetComponent(i)).LoadFromFile(LMeshCollectionDesigner.FileName);

    for i := 0 to PropCount - 1 do
    begin
      TModel3D(GetComponent(i)).Scale.X := LMeshCollectionDesigner.Scale;
      TModel3D(GetComponent(i)).Scale.Y := LMeshCollectionDesigner.Scale;
      TModel3D(GetComponent(i)).Scale.Z := LMeshCollectionDesigner.Scale;
    end;

    Modified;

  end;
  LMeshCollectionDesigner.Free;
end;

{ TTabIconProperty }

type

  TTabIconProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

procedure TTabIconProperty.Edit;
var
  TabIconDesigner: TTabIconDesigner;
begin
  TabIconDesigner := TTabIconDesigner.Create(nil);
  try
    TabIconDesigner.Designer := Self.Designer;
    TabIconDesigner.Component := TTabItem(Self.GetComponent(0));
    TabIconDesigner.Execute;
  finally
    FreeAndNil(TabIconDesigner);
  end;
end;

function TTabIconProperty.GetValue: string;
begin
  Result := '(Icon)';
end;

function TTabIconProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end;

{ TActionListEditor }

type
  TActionListEditor = class(TComponentEditor {$IFDEF LINUX}, IDesignerThreadAffinity{$ENDIF})
  protected
    {$IFDEF LINUX}
    function GetThreadAffinity: TThreadAffinity;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TActionListEditor.ExecuteVerb(Index: Integer);
begin
  ShowActionListDesigner(Designer, Component as TActionList);
end;

{$IFDEF LINUX}
function TActionListEditor.GetThreadAffinity: TThreadAffinity;
begin
  Result := taQt;
end;
{$ENDIF}

function TActionListEditor.GetVerb(Index: Integer): string;
begin
  Result := SActionListEdit;
end;

function TActionListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


{ TGestureIDProperty }

type
  TGestureIDProperty = class(TIntegerProperty)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TGestureIDProperty.GetValue: string;
begin
  GestureToIdent(GetOrdValue, Result);
end;

procedure TGestureIDProperty.SetValue(const Value: string);
var
  NewValue: integer;
begin
  if IdentToGesture(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;


{ TTouchManagerProperty }

type
  TTouchManagerProperty = class(TClassProperty)
  protected
    function GetIsDefault: boolean; override;
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

function TTouchManagerProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paVolatileSubProperties, paReadOnly];
end;

type
  THackTouchManager = class(TTouchManager);

function TTouchManagerProperty.GetIsDefault: boolean;
begin
  if TPersistent(GetOrdValue) is TTouchManager then
    Result := THackTouchManager(GetOrdValue).IsDefault
  else
    Result := inherited;
end;

type
 TCustomSyntheticProperty = class(TBasePropertyEditor, IProperty, IPropertyKind)
  private
    FDesigner: IDesigner;
  protected
    { IProperty }
    procedure Initialize; override;
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent;
      APropInfo: PPropInfo); override;
    procedure Activate;
    function AllEqual: Boolean;
    function AutoFill: Boolean;
    procedure Edit; virtual;
    function HasInstance(Instance: TPersistent): Boolean;
    function GetAttributes: TPropertyAttributes; virtual;
    function GetEditLimit: Integer;
    function GetEditValue(out Value: string): Boolean;
    function GetName: string; virtual;
    function GetValue: string; virtual;
    procedure SetValue(const Value: string); virtual;
    procedure GetProperties(Proc: TGetPropProc); virtual;
    function GetPropInfo: PPropInfo; virtual;
    function GetPropType: PTypeInfo; virtual;
    procedure GetValues(Proc: TGetStrProc); virtual;
    procedure Revert;
    function ValueAvailable: Boolean;
    { IPropertyKind }
    function GetKind: TTypeKind; virtual;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    property Designer: IDesigner read FDesigner;
  end;

  TGesturesProperty = class(TCustomSyntheticProperty)
  private type
    TGestureComparer = class(TComparer<FMX.Types.TCustomGestureCollectionItem>)
    public
      function Compare(const Left, Right: FMX.Types.TCustomGestureCollectionItem): Integer; override;
    end;
  private
    FControl: TFmxObject;
    FTouchManager: FMX.Types.TTouchManager;
    FStandardGestureList: TGestureCollection;
  protected
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer;
      ATouchManager: FMX.Types.TTouchManager); reintroduce; virtual;
  end;

  TGestureListProperty = class(TCustomSyntheticProperty)
  private
    FControl: TFmxObject;
    FGestureList: TGestureCollection;
    FGestureTypes: FMX.Types.TGestureTypes;
    FPropName: string;
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer;
      const APropName: string; AGestureList: TGestureList; AControl: TFmxObject;
      AGestureTypes: FMX.Types.TGestureTypes); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TGestureProperty = class(TCustomSyntheticProperty, ICustomPropertyDrawing,
    ICustomPropertyDrawing80, ICustomPropertyMessage, IProperty80)
  private
    FActionListView: TActionListView;
    FControl: TFmxObject;
    FGesture: FMX.Types.TCustomGestureCollectionItem;
    FHost: IPropertyHost;
    FPreviewPoints: FMX.Types.TGesturePointArray;
    FPreviewSize: Integer;
    FFrameworkType: string;
    FIDEActions: TIDEActionsClass;
    function CheckRect(const ItemRect: TRect) : TRect;
    procedure DoNewAction(Sender: TObject; const Category: string;
      ActionClass: TContainedActionClass; ActionList: TContainedActionList);
    procedure DoSelectAction(Sender: TObject; Action: TContainedAction);
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetKind: TTypeKind; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure SetAction(const Value: TContainedAction);
    procedure SetValue(const Value: string); override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer;
      AGesture: FMX.Types.TCustomGestureCollectionItem; AControl: TFmxObject); reintroduce; virtual;
    destructor Destroy; override;
    // IProperty80
    procedure Edit(const Host: IPropertyHost; DblClick: Boolean); reintroduce; overload;
    // ICustomPropertyDrawing
    procedure PropDrawName(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure PropDrawValue(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
      ASelected: Boolean);
    // ICustomPropertyDrawing80
    function PropDrawNameRect(const ARect: TRect): TRect;
    function PropDrawValueRect(const ARect: TRect): TRect;
    // ICustomPropertyMessage
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer; InNameRect: Boolean;
      const ItemRect: TRect; var Handled: Boolean);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
    procedure HintShow(var HintInfo: THintInfo; InNameRect: Boolean;
      const ItemRect: TRect; var Handled: Boolean);

    property Checked: Boolean read GetChecked write SetChecked;
    property Gesture: FMX.Types.TCustomGestureCollectionItem read FGesture write FGesture;
    property IDEActions: TIDEActionsClass read FIDEActions;
  end;

  TGestureSelectionEditor = class(TSelectionEditor)
  private
    class var FGestureUnits: TStrings;
    class var FGestureUnitMap: TDictionary<string, string>;
    class constructor Create;
    class destructor Destroy;
  public
    class procedure AddGesture(AGesture: FMX.Types.TCustomGestureCollectionItem);
    class procedure SelectGesture(const AGestureName: string);
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TTouchManagerPropertyFilter = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionProperties: IInterfaceList);
  end;

  TGestureManagerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  THackGestureManager = class(TGestureManager)
  end;

  TMobileFormFilter = class(TSelectionEditor, ISelectionpropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionproperties: IInterfaceList);
  end;

  TTabItemFilter = class(TSelectionEditor, ISelectionpropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionproperties: IInterfaceList);
  end;

  TListViewObjectsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  TListViewAppearanceNamePropertyEditor = class(TStringProperty)
  private
    procedure Synch1SetValue(const Value: string; AGetValue,
      AGetSynchValue: TFunc<string>; ASetSynchValue: TProc<string>);
    procedure Synch2SetValue(const Value: string; AGetValue,
      AGetSynchValue: TFunc<string>;
      AGetPrefix: TFunc<string, string>;
      ASetSynchValue: TProc<string>);
  protected
    function GetFilter: TCustomListView.TRegisterAppearanceOptions; virtual;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetAttributes: TPropertyAttributes; override;
    procedure SetValue(const Value: string); override;
  end;

  TListViewHeaderAppearanceNamePropertyEditor = class(TListViewAppearanceNamePropertyEditor)
  protected
    function GetFilter: TCustomListView.TRegisterAppearanceOptions; override;
  end;

  TListViewFooterAppearanceNamePropertyEditor = class(TListViewAppearanceNamePropertyEditor)
  protected
    function GetFilter: TCustomListView.TRegisterAppearanceOptions; override;
  end;

  TListViewItemEditAppearanceNamePropertyEditor = class(TListViewAppearanceNamePropertyEditor)
  protected
    function GetFilter: TCustomListView.TRegisterAppearanceOptions; override;
  end;

  TListViewSelectionEditor = class(TSelectionEditor)
  private
    procedure AppearanceRequiresUnits(Proc: TGetStrProc);
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TListViewItemAppearancePropertiesEditor = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections;
      const ASelectionProperties: IInterfaceList);
  end;

  TLinkViewEditModeSelectionEditor = class(TSelectionEditor)
  private
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer; const List: IDesignerSelections); override;
    constructor Create(const ADesigner: IDesigner); override;
  end;


  TListViewSprig = class(FmxSprigs.TControlSprig)
  private
  public
    procedure FigureChildren; override;
  end;

  TListViewAppearanceSprig = class(TPersistentSprig)
  private
    FListView: TCustomListView;
  public
    constructor Create(const AListView: TCustomListView);
    function Ghosted: Boolean; override;
    function UniqueName: string; override;
    procedure FigureParent; override;
    procedure FigureChildren; override;
    function Caption: string; override;
  end;

  TListViewObjectsProperties = class(TPersistent)
  private type
    TOpenItemAppearanceProperties = class(TItemAppearanceProperties);
  private
    FAppearance: TItemAppearanceProperties;
    function GetHeight: Integer;
    function GetName: string;
    procedure SetHeight(const Value: Integer);
    procedure SetName(const Value: string);
    function IsHeightStored: Boolean;
  public
    constructor Create(const AAppearance: TItemAppearanceProperties);
  published
    property Appearance: string read GetName write SetName stored False;
    property Height: Integer read GetHeight write SetHeight stored IsHeightStored nodefault;
  end;

  TListViewObjectsSprig = class(TPersistentSprig)
  var
    FAppearance: TItemAppearanceProperties;
    FClassName: string;
    FPersistent: TPersistent;
  public
    constructor Create(AListView: TCustomListView; AAppearance: TItemAppearanceProperties);
    destructor Destroy; override;
    procedure FigureChildren; override;
    function UniqueName: string; override;
    function Ghosted: Boolean; override;
    procedure FigureParent; override;
    function Caption: string; override;
  end;

  TObjectAppearanceSprig = class(TPersistentSprig)
  private
    FOwner: TItemAppearanceProperties;
    FName: string;
  public
    constructor Create(const AOwner: TItemAppearanceProperties; const AName: string; const AObjectAppearance: TObjectAppearance);
    function Ghosted: Boolean; override;
    function UniqueName: string; override;
    procedure FigureParent; override;
    function Caption: string; override;
  end;

{ Registration }

procedure Register;
begin
  RegisterComponents(srStandard, [TMainMenu, TPopupMenu]);
  RegisterComponents(srStandard, [FMX.ActnList.TActionList]);
  RegisterComponents(srStandard, [TLang]);
  RegisterComponents(srStandard, [TStyleBook]);
  RegisterComponents(srStandard, [TButton]);
  RegisterComponents(srStandard, [TCheckBox, TRadioButton, TGroupBox, TPopupBox]);
  RegisterComponents(srStandard, [TPanel, TCalloutPanel, TLabel, TImageControl, TPathLabel, TProgressBar, TScrollBar, TSmallScrollBar,
    TExpander, TTrackBar, TSwitch, TSplitter]);
  RegisterComponents(srStandard, [TMenuBar, TStatusBar, TToolBar]);
  RegisterComponents(srStandard, [TSizeGrip]);
  RegisterComponents(srStandard, [TListBox, TComboBox, TMemo, TEdit, TTreeView, TListView]);
  RegisterComponents(srStandard, [TPopup]);

//  GroupDescendentsWith(TMenuItem, TControl);
//  GroupDescendentsWith(TMenu, TControl);
//  RegisterClass(TMenuItem);


  RegisterComponents(srAdditional, [TSpeedButton, TCornerButton, TArcDial,
    TAniIndicator, TMediaPlayer, TMediaPlayerControl, TCameraComponent]);

  {$WARNINGS OFF}
  RegisterNoIcon([TCalendarBox]); // Deprecated
  {$WARNINGS ON}
  RegisterComponents(srAdditional, [TCalendar, TCalendarEdit,
    TDropTarget, TImageViewer, TNumberBox, TSpinBox, TComboEdit, TComboTrackBar,
    TClearingEdit, TPlotGrid, TMagnifierGlass]);


  RegisterComponents(srGridsColumns, [TGrid, TStringGrid, THeader]);
//  RegisterComponents(srGridsColumns, [T_Grid, T_ValueGrid, T_Header]);
//  RegisterPropertyEditor(TypeInfo(string),
//                         TBaseAbstractGridSettings,
//                         'CustomOptionsName',
//                         TCustomOptionsNameProperty);
//  RegisterPropertyEditor(TypeInfo(TBaseAbstractGridSettings),
//                         nil,
//                         '',
//                         TSettingsProperty);
//  RegisterPropertyEditor(TypeInfo(TAbstractGridCustomOptions),
//                         nil,
//                         '',
//                         TCustomOptionsProperty);


  RegisterComponents(srCommonControls, [TTabControl]);

  RegisterComponents(srAnimations, [TColorAnimation, TGradientAnimation,
    TFloatAnimation, TRectAnimation, TBitmapAnimation, TBitmapListAnimation,
    TColorKeyAnimation, TFloatKeyAnimation, TPathAnimation]);

  RegisterComponents(srColors, [THueTrackBar, TAlphaTrackBar, TBWTrackBar,
    TColorQuad, TColorPicker, TGradientEdit, TColorBox, TColorPanel,
    TComboColorBox, TColorButton, TColorComboBox, TColorListBox]);

  RegisterComponentEditor(TColorButton, TForceOnClickEditor);
  RegisterComponentEditor(TSwitch, TForceOnSwitchEditor);

  RegisterComponents(srEffects, [TShadowEffect, TBlurEffect, TGlowEffect,
    TInnerGlowEffect, TBevelEffect, TReflectionEffect, TRippleEffect,
    TSwirlEffect, TMagnifyEffect, TSmoothMagnifyEffect, TBandsEffect,
    TWaveEffect, TWrapEffect, TBandedSwirlEffect, TPinchEffect, TTilerEffect,
    TPixelateEffect, TEmbossEffect, TSharpenEffect, TToonEffect, TSepiaEffect,
    TPaperSketchEffect, TPencilStrokeEffect, TFillEffect, TFillRGBEffect,
    TNormalBlendEffect, THueAdjustEffect, TContrastEffect, TBloomEffect,
    TGloomEffect, TInvertEffect, TMonochromeEffect, TColorKeyAlphaEffect,
    TMaskToAlphaEffect, TBandedSwirlTransitionEffect, TBlindTransitionEffect,
    TBloodTransitionEffect, TCircleTransitionEffect, TMagnifyTransitionEffect,
    TCrumpleTransitionEffect,  TDissolveTransitionEffect, TDropTransitionEffect,
    TFadeTransitionEffect, TBrightTransitionEffect, TPixelateTransitionEffect,
    TBlurTransitionEffect, TWiggleTransitionEffect, TShapeTransitionEffect,
    TRippleTransitionEffect, TRotateCrumpleTransitionEffect, TSaturateTransitionEffect,
    TSlideTransitionEffect, TSwirlTransitionEffect, TWaterTransitionEffect,
    TWaveTransitionEffect, TLineTransitionEffect, TAffineTransformEffect,
    TPerspectiveTransformEffect, TCropEffect, TGaussianBlurEffect, TBoxBlurEffect,
    TDirectionalBlurEffect, TRadialBlurEffect, TSwipeTransitionEffect]);

  RegisterComponents(srViewports, [TViewport3D]);

  RegisterComponents(srDialogs, [FMX.Dialogs.TOpenDialog, FMX.Dialogs.TSaveDialog,
    FMX.Dialogs.TPrintDialog, FMX.Dialogs.TPageSetupDialog, FMX.Dialogs.TPrinterSetupDialog]);

  RegisterComponents(srGestures, [FMX.Gestures.TGesturemanager]);

  RegisterComponents(srShapes, [TLine, TRectangle, TRoundRect, TEllipse, TCircle,
    TArc, TPie, TText, TPath, TImage, TPaintBox, TCalloutRectangle,
    TSelection, TSelectionPoint]);

  RegisterComponents(srScene3D, [TCamera, TLight, TDummy, TProxyObject]);
  RegisterComponents(srShapes3D, [TPlane, TDisk, TCube, TMesh, TSphere, TCylinder,
    TRoundCube, TCone, TGrid3D, TStrokeCube, TText3D, TPath3D, TRectangle3D, TEllipse3D,
    TModel3D]);

  RegisterComponents(srLayers3D, [TLayout3D, TBufferLayer3D, TSplitter3D, TSolidLayer3D, TImage3D, TLayer3D, TTextLayer3D]);


  RegisterNoIcon([TMaterialBook]);
  RegisterComponents(srMaterials, [TColorMaterialSource, TTextureMaterialSource, TLightMaterialSource]);

  RegisterComponents(srShapes3D, [TPlane, TCube, TMesh, TSphere, TCylinder,
    TRoundCube, TCone, TGrid3D, TStrokeCube, TText3D, TPath3D, TRectangle3D, TEllipse3D]);

  RegisterComponents(srLayouts, [TLayout, TScaledLayout, TGridLayout, TFlowLayoutBreak, TFlowLayout,
    TScrollBox, TVertScrollBox, THorzScrollBox, TFramedScrollBox,
    TFramedVertScrollBox]);

  RegisterComponents(srInternet, [TWebBrowser]);

  RegisterComponents(srSystem, [TTimer]);

  // Register components from Sensors category
  RegisterComponents(srSensors, [TLocationSensor, TMotionSensor, TOrientationSensor]);  

  RegisterComponentEditor(FMX.ActnList.TActionList, TActionListEditor);
  RegisterComponentEditor(TStyleBook, TStyleBookEditor);
  RegisterComponentEditor(TMainMenu, TMenuEditor);
  RegisterComponentEditor(TEdit, TEditEditor);
  RegisterComponentEditor(TPopupMenu, TMenuEditor);
  RegisterComponentEditor(TMenuBar, TMenuEditor);
  RegisterComponentEditor(TListBox, TListBoxEditor);
  RegisterComponentEditor(TComboBox, TListBoxEditor);
  RegisterComponentEditor(TTreeView, TTreeViewEditor);
  RegisterComponentEditor(THeader, THeaderEditor);
  RegisterComponentEditor(TTabControl, TTabControlEditor);
  RegisterComponentEditor(TGrid, TGridEditor);
  RegisterComponentEditor(TStringGrid, TStringGridEditor);

                                           
  RegisterPropertyEditor(TypeInfo(TTrigger), nil, '', TTriggerProperty);
  RegisterPropertyEditor(TypeInfo(TBrush), nil, '', TBrushProperty);
  RegisterPropertyEditor(TypeInfo(TPathData), nil, '', TPathDataProperty);
  RegisterPropertyEditor(TypeInfo(TFont), nil, '', TFontProperty);
  RegisterPropertyEditor(TypeInfo(TFontName), nil, '', TFontNameProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TStyleBook, 'Resource', TResourceProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), nil, '', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(String), TStyledControl, 'StyleLookup', TStyleLookupProperty);
  RegisterPropertyEditor(TypeInfo(String), TCustomListBox, 'StyleLookup', TStyleLookupPropertyListBox);
  RegisterPropertyEditor(TypeInfo(String), TCustomLayer3D, 'StyleLookup', TStyleLookupProperty);
  RegisterPropertyEditor(TypeInfo(String), TCustomForm, 'StyleLookup', TStyleLookupProperty);
  RegisterPropertyEditor(TypeInfo(String), TListBoxItemStyleDefaults, 'ItemStyle', TDefaultListBoxItemStyleProperty);
  RegisterPropertyEditor(TypeInfo(String), TListBoxItemStyleDefaults, 'GroupHeaderStyle', TDefaultListBoxGroupHeaderStyleProperty);
  RegisterPropertyEditor(TypeInfo(String), TListBoxItemStyleDefaults, 'GroupFooterStyle', TDefaultListBoxGroupFooterStyleProperty);

  // meshdata related editors
  RegisterPropertyEditor(TypeInfo(TMeshData),nil, '', TMeshDataProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'Normals', TStringOfFloatTripletsProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'Points', TStringOfFloatTripletsProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'TexCoordinates', TStringOfFloatDoublesProperty);
  RegisterPropertyEditor(TypeInfo(string), TMeshData, 'TriangleIndices', TStringOfIntegersProperty);

  RegisterPropertyEditor(TypeInfo(TStrings), nil, '', TStringListProperty);

  RegisterComponentEditor(TLang, TLangEditor);
  RegisterPropertyEditor(TypeInfo(string), TLang, 'Lang', TLangProperty);

  // Float animation support
  RegisterPropertyEditor(TypeInfo(string), TFloatAnimation, 'PropertyName', TFloatAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(string), TFloatKeyAnimation, 'PropertyName', TFloatAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(single), TFmxObject, '', TFmxFloatProperty);
  RegisterPropertyEditor(TypeInfo(single), TPosition, '', TFmxFloatProperty);

  // Rect animation support
  RegisterPropertyEditor(TypeInfo(string), TRectAnimation, 'PropertyName', TRectAnimationPropertyName);
  // Disabled - because impossible to edit sub-propertities
//  RegisterPropertyEditor(TypeInfo(TBounds), TFmxObject, '', TRectAnimationProperty);

  // Color animation support
  RegisterPropertyEditor(TypeInfo(string), TColorAnimation, 'PropertyName', TColorAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(string), TColorKeyAnimation, 'PropertyName', TColorAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFmxObject, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TPersistent, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TGrid3D, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFillEffect, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TFillRGBEffect, '', TAlphaColorProperty);
  RegisterPropertyEditor(TypeInfo(TAlphaColor), TColorKey, '', TAlphaColorProperty);

  // Gradient animation support
  RegisterPropertyEditor(TypeInfo(string), TGradientAnimation, 'PropertyName', TGradientAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(TGradient), nil, '', TGradientProperty);

  // Bitmap animation support
  RegisterPropertyEditor(TypeInfo(string), TBitmapAnimation, 'PropertyName', TBitmapAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(string), TBitmapListAnimation, 'PropertyName', TBitmapListAnimationPropertyName);
  RegisterPropertyEditor(TypeInfo(FMX.Types.TBitmap), nil, '', TBitmapProperty);

  RegisterPropertyEditor(TypeInfo(TMeshCollection), nil, '', TMeshCollectionProperty);

  //Gestures
  RegisterPropertyEditor(TypeInfo(TGestureID), nil, '', TGestureIDProperty);
  RegisterPropertyEditor(TypeInfo(TTouchManager), nil, '', TTouchManagerProperty);
  RegisterSelectionEditor(TGestureManager, TGestureSelectionEditor);
  RegisterComponentEditor(TGestureManager, TGestureManagerEditor);
  RegisterSelectionEditor(TFmxObject, TTouchManagerPropertyFilter);
  THackGestureManager(TGestureManager).FDesignerHook := TGestureSelectionEditor.AddGesture;

  // TabItem
  RegisterPropertyEditor(TypeInfo(TImageData), TTabItem, 'CustomIcon', TTabIconProperty);
  RegisterSelectionEditor(TTabItem, TTabItemFilter);

  // Mobile Form Designer
  RegisterSelectionEditor(TCommonCustomForm, TMobileFormFilter);

  // TListView
  RegisterPropertyEditor(TypeInfo(String), TListView.TPublishedAppearance, 'ItemAppearance', TListViewAppearanceNamePropertyEditor); // drop down list
  RegisterPropertyEditor(TypeInfo(String), TListView.TPublishedAppearance, 'HeaderAppearance', TListViewHeaderAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(String), TListView.TPublishedAppearance, 'FooterAppearance', TListViewFooterAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(String), TListView.TPublishedAppearance, 'ItemEditAppearance', TListViewItemEditAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(String), TListViewObjectsProperties, 'Appearance', TListViewAppearanceNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TListView.TPublishedObjects, 'ItemObjects', TListViewObjectsProperty); // volatile properties
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TListView.TPublishedObjects, 'HeaderObjects', TListViewObjectsProperty);
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TListView.TPublishedObjects, 'FooterObjects', TListViewObjectsProperty);
  RegisterPropertyEditor(TypeInfo(TItemAppearanceObjects), TListView.TPublishedObjects, 'ItemEditObjects', TListViewObjectsProperty);
  RegisterSelectionEditor(TCustomListView, TListViewSelectionEditor);  // Add units
  RegisterSelectionEditor(TListView, TListViewItemAppearancePropertiesEditor);  // filter properties
  RegisterSprigType(TListView, TListViewSprig);  // structure view
  RegisterSelectionEditor(TListView, TLinkViewEditModeSelectionEditor);
  RegisterSelectionEditor(TListViewObjectsProperties, TLinkViewEditModeSelectionEditor);
  RegisterSelectionEditor(TListView.TPublishedAppearance, TLinkViewEditModeSelectionEditor);
  RegisterPropertyEditor(TypeInfo(String), TCustomListView, 'StyleLookup', TStyleLookupPropertyListView);

  { all properties and events that are managed by actions }
  RegisterPropertiesInCategory(sActionCategoryName,
    ['Action', 'Caption', 'Checked', 'Enabled', 'HelpContext', 'Hint', { do not localize }
     'ImageIndex', 'ShortCut', 'Visible']); { do not localize }

  { properties and events that manage the data shown by a component }
  {RegisterPropertiesInCategory(TDataCategory,
    ['Text', 'Tag', 'EditMask', TypeInfo(TPersistent)]);}

  { all drag-n-drop or docking related properties and events }
  RegisterPropertiesInCategory(sDragNDropCategoryName,
    ['Drag*', 'Dock*', 'UseDockManager', 'OnDockOver', 'OnGetSiteInfo', { do not localize }
     'OnDragOver', 'On*Drop', 'On*Drag', 'On*Dock']); { do not localize }

  { all help, hint or assistance related properties and events }
  RegisterPropertiesInCategory(sHelpCategoryName,
    ['Help*', '*Help', 'Hint*', '*Hint']); { do not localize }

  { all layout related properties or events }
  RegisterPropertiesInCategory(sLayoutCategoryName,
    ['Left', 'Top', 'Width', 'Height', 'TabOrder', 'TabStop', 'Align', { do not localize }
     'Anchors', 'Constraints', 'AutoSize', 'AutoScroll', 'Scaled', 'OnResize', { do not localize }
     'OnConstrained', 'OnCanResize']); { do not localize }

  // all legacy related properties or events and
  //   make sure the category defaults to not visible
  RegisterPropertiesInCategory(sLegacyCategoryName,
    ['Ctl3d', 'ParentCtl3d', 'OldCreateOrder']); //.Visible := False; { do not localize }
                                           

  { all linkage references between components }
  RegisterPropertyInCategory(sLinkageCategoryName, TypeInfo(TComponent));

  { all OS locale related properties and events }
  RegisterPropertiesInCategory(sLocaleCategoryName,
    ['Ime*', 'BiDi*', 'ParentBiDi*']); { do not localize }

  { any visual related properties and events }
  RegisterPropertiesInCategory(sVisualCategoryName,
    ['Left', 'Top', 'Width', 'Height', 'Visible', 'Enabled', 'Caption', { do not localize }
     'Align', 'Alignment', 'ParentColor', 'ParentFont', 'Bevel*', 'Border*', { do not localize }
     'ClientHeight', 'ClientWidth', 'Scaled', 'AutoSize', 'EditMask', { do not localize }

     'OnShow', 'OnPaint', 'OnClose', 'OnCloseQuery', 'OnResize', { do not localize }
     'OnConstrained', 'OnActivate', 'OnDeactivate', 'OnCanResize', 'OnHide', { do not localize }

     TypeInfo(TFont), TypeInfo(TAlphaColor), TypeInfo(TBrush), {TypeInfo(TPen),}
     TypeInfo(TCursor){, TypeInfo(TGraphic)}]);

  { input property events }
  RegisterPropertiesInCategory(sInputCategoryName,
    ['AutoScroll', 'KeyPreview', 'ReadOnly', 'Enabled', 'OnClick', { do not localize }
     'OnDblClick', 'OnShortCut', 'OnKey*', 'OnMouse*']); { do not localize }

  { All localizable properties:
      See also:
        WCompReg, InetReg, ISP, ISP3, VCSPELL3, VCF1,
        Win31Reg, DBReg, QRTeeReg, QRTee, SysReg
  }
  RegisterPropertiesInCategory(sLocalizableCategoryName, { for all controls }
    ['BiDiMode', { do not localize }
     'Caption', 'Constraints', { do not localize }
     'EditMask', { do not localize }
     'Glyph', { do not localize }
     'Height', 'Hint', { do not localize }
     'Icon', 'ImeMode', 'ImeName', { do not localize }
     'Left', { do not localize }
     'ParentBiDiMode', 'ParentFont', 'Picture', { do not localize }
     'Text', 'Top', { do not localize }
     'Width']); { do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, TCommonCustomForm,
    ['ClientHeight', 'ClientWidth', 'HelpFile']); { do not localize }

  RegisterPropertiesInCategory(sLocalizableCategoryName, { by TypeInfo }
    [TypeInfo(FMX.Types.TFont)]);          { Graphics }

  { Standard action registration }

  RegisterActions('', [FMX.ActnList.TAction, FMX.Controls.TControlAction, FMX.StdActns.TValueRangeAction], nil);
  RegisterActions(SFileCategory, [FMX.StdActns.TFileExit,
                                  FMX.StdActns.TFileHideApp,
                                  FMX.StdActns.TFileHideAppOthers],
                  TStandardActions);
  RegisterActions(SWindowCategory, [FMX.StdActns.TWindowClose],
                  TStandardActions);
  RegisterActions(SViewCategory, [FMX.StdActns.TViewAction], TStandardActions);
  RegisterActions(SEditCategory, [FMX.StdActns.TVirtualKeyboard], TStandardActions);

  RegisterActions(STabCategory, [TChangeTabAction], nil);

  RegisterActions(SMediaLibraryCategory, [TTakePhotoFromLibraryAction, TTakePhotoFromCameraAction, TShowShareSheetAction], nil);
end;


{ TFontProperty }

procedure TFontProperty.Edit;
var
  FontDialog: TFontDialog;
  FmxFont: FMX.Types.TFont;
  TmpVclFont: Vcl.Graphics.TFont;
begin
  FontDialog := TFontDialog.Create(Application);
  try
    FmxFont := FMX.Types.TFont(GetOrdValue);
    TmpVclFont := Vcl.Graphics.TFont.Create;
    try
      FmxToVclFont(FmxFont, TmpVclFont);
      FontDialog.Font.Assign(TmpVclFont);
      FontDialog.Options := FontDialog.Options + [fdShowHelp, fdForceFontExist];
      if FontDialog.Execute then
      begin
        VclToFmxFont(FontDialog.Font, FmxFont);
        SetOrdValue(Longint(FmxFont));
        //FontDialog.Font := nil;
      end;
    finally
      TmpVclFont.Free;
    end;
  finally
    FontDialog.Free;
  end;

end;

procedure TFontProperty.FmxToVclFont(const SourceValue: TFont; const DestValue: Vcl.Graphics.TFont);
begin
  DestValue.Style:= [];
  DestValue.Name:= SourceValue.Family;
  DestValue.Size:= Round(SourceValue.Size);
  if TFontStyle.fsBold in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [fsBold];
  if TFontStyle.fsItalic in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [fsItalic];
  if TFontStyle.fsUnderline in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [fsUnderline];
  if TFontStyle.fsStrikeOut in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [fsStrikeout];
end;

procedure TFontProperty.VclToFmxFont(const SourceValue: Vcl.Graphics.TFont;
  const DestValue: TFont);
begin
  DestValue.Style:= [];
  DestValue.Family:= SourceValue.Name;
  DestValue.Size:= SourceValue.Size;
  if fsBold in SourceValue.Style then
    DestValue.Style := DestValue.Style + [TFontStyle.fsBold];
  if fsItalic in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [TFontStyle.fsItalic];
  if fsUnderline in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [TFontStyle.fsUnderline];
  if fsStrikeout in SourceValue.Style then
    DestValue.Style:= DestValue.Style + [TFontStyle.fsStrikeOut];
end;

{ TPathDataProperty }

procedure TPathDataProperty.Edit;
var
  EditDlg: TPathDataDesigner;
begin
  EditDlg := TPathDataDesigner.Create(Application);
  EditDlg.PathData.Lines.Text := String(TPathData(GetOrdValue).Data);
  EditDlg.PathData.WordWrap := true;
  if EditDlg.ShowModal = mrOk then
  begin
    TPathData(GetOrdValue).Data := EditDlg.PathData.Lines.Text;
    if GetComponent(0) is TControl then
      TControl(GetComponent(0)).Repaint;
    Modified;
  end;
  EditDlg.Free;
end;

function TPathDataProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end;

function TPathDataProperty.GetValue: String;
begin
  Result := '(PathData)';
end;

{ TMeshDataProperty }

procedure TMeshDataProperty.Edit;
//var
//  M: TMeshData;
begin
//  M := TMeshData(GetOrdValue);
  GetOrdValue;
end;

function TMeshDataProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paReadOnly];
end;

function TMeshDataProperty.GetValue: String;
begin
  Result := '(Mesh)';
end;

{ TCustomSyntheticProperty }

procedure TCustomSyntheticProperty.Activate;
begin
end;

function TCustomSyntheticProperty.AllEqual: Boolean;
begin
  Result := True;
end;

function TCustomSyntheticProperty.AutoFill: Boolean;
begin
  Result := True;
end;

constructor TCustomSyntheticProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer);
begin
  inherited;
  FDesigner := ADesigner;
end;

procedure TCustomSyntheticProperty.Edit;
begin
  inherited;
end;

function TCustomSyntheticProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paNotNestable, paReadOnly];
end;

function TCustomSyntheticProperty.GetEditLimit: Integer;
begin
  Result := -1;
end;

function TCustomSyntheticProperty.GetEditValue(out Value: string): Boolean;
begin
  Result := True;
  Value := GetValue;
end;

function TCustomSyntheticProperty.GetKind: TTypeKind;
begin
  Result := tkInteger;
end;

function TCustomSyntheticProperty.GetName: string;
begin
  Result := '';
end;

procedure TCustomSyntheticProperty.GetProperties(Proc: TGetPropProc);
begin
end;

function TCustomSyntheticProperty.GetPropInfo: PPropInfo;
begin
  Result := nil;
end;

function TCustomSyntheticProperty.GetPropType: PTypeInfo;
begin
  Result := nil;
end;

function TCustomSyntheticProperty.GetValue: string;
begin
  Result := ''
end;

procedure TCustomSyntheticProperty.GetValues(Proc: TGetStrProc);
begin
end;

function TCustomSyntheticProperty.HasInstance(Instance: TPersistent): Boolean;
begin
  Result := False;
end;

procedure TCustomSyntheticProperty.Initialize;
begin
  inherited;
end;

procedure TCustomSyntheticProperty.Revert;
begin
end;

procedure TCustomSyntheticProperty.SetPropEntry(Index: Integer;
  AInstance: TPersistent; APropInfo: PPropInfo);
begin
  inherited;
end;

procedure TCustomSyntheticProperty.SetValue(const Value: string);
begin
end;

function TCustomSyntheticProperty.ValueAvailable: Boolean;
begin
  Result := True;
end;

{ TGesturesProperty.TGestureComparer }

function TGesturesProperty.TGestureComparer.Compare(const Left,
  Right: FMX.Types.TCustomGestureCollectionItem): Integer;
begin
  Result := Right.GestureID - Left.GestureID;
end;

{ TGesturesProperty }

constructor TGesturesProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer; ATouchManager: FMX.Types.TTouchManager);
var
  List: IDesignerSelections;
  LGesture: FMX.Types.TStandardGesture;
begin
  inherited Create(ADesigner, APropCount);
  FTouchManager := ATouchManager;

  // Find the control we're editing
  List := TDesignerSelections.Create;
  Designer.GetSelections(List);
  if (List <> nil) and (List.Count > 0) and (List.Items[0] is TFmxObject) then
    FControl := TFmxObject(List.Items[0])
  else
    raise Exception.Create(SNoSelectedControl);

  // Create shadow list for standard gestures
  FStandardGestureList := TGestureCollection.Create;
  for LGesture := Low(FMX.Types.TStandardGesture) to High(FMX.Types.TStandardGesture) do
    FStandardGestureList.Add.GestureID := TGestureID(LGesture);
end;

procedure TGesturesProperty.Edit;
begin
  //if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
  //  ShowGestureSelector(FControl, FDesigner);
end;

function TGesturesProperty.GetAttributes: TPropertyAttributes;
begin
  if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
    Result := [paNotNestable, paVolatileSubProperties, paDialog, paSubProperties, paReadOnly]
  else
    Result := [paNotNestable, paVolatileSubProperties, paReadOnly];
end;

function TGesturesProperty.GetName: string;
begin
  Result := 'Gestures';  // Do not localize
end;

procedure TGesturesProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
  LList: TGestureList;
  LComparer: TGestureComparer;
  LGestureManager: TGestureManager;
  Item: FMX.Types.TCustomGestureCollectionItem;
begin
  if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
  begin
    LList := TGestureList.Create;
    try
      LGestureManager := TGestureManager(FTouchManager.GestureManager);
      // Add custom & registered gestures
      if (LGestureManager.RecordedGestureCount > 0) or
         (TGestureManager.RegisteredGestureCount > 0) then
      begin
        LList.Clear;
        for Item in LGestureManager.RecordedGestures do
          LList.Add(Item);
        for Item in TGestureManager.RegisteredGestures do
          LList.Add(Item);

        LComparer := TGestureComparer.Create;
        try
          // Sort list by ID in descending order
          LList.Sort(LComparer);
        finally
          LComparer.Free;
        end;

        Proc(TGestureListProperty.Create(FDesigner, 1,
          'Custom', LList, FControl, [FMX.Types.TGestureType.gtRecorded, FMX.Types.TGestureType.gtRegistered]) as IProperty); // do not localize
      end;

      // Add standard gestures
      LList.Clear;
      for I := 0 to FStandardGestureList.Count - 1 do
        LList.Add(FStandardGestureList[I]);
      Proc(TGestureListProperty.Create(FDesigner, 1,
        'Standard', LList, FControl, [FMX.Types.TGestureType.gtStandard]) as IProperty); // do not localize
    finally
      LList.Free;
    end;
  end;
end;

function TGesturesProperty.GetValue: string;
begin
  if Assigned(FTouchManager) and Assigned(FTouchManager.GestureManager) then
    Result := ''
  else
    Result := '(Assign GestureManager)';
end;

{ TGestureListProperty }

constructor TGestureListProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer; const APropName: string; AGestureList: TGestureList;
  AControl: TFmxObject; AGestureTypes: FMX.Types.TGestureTypes);
var
  I: Integer;
begin
  inherited Create(ADesigner, APropCount);
  FControl := AControl;
  FGestureList := TGestureCollection.Create;
  FGestureTypes := AGestureTypes;
  for I := 0 to AGestureList.Count - 1 do
    FGestureList.Add.Assign(AGestureList[I]);
  FPropName := APropName;
end;

destructor TGestureListProperty.Destroy;
begin
  FreeAndNil(FGestureList);
  inherited;
end;

function TGestureListProperty.GetAttributes: TPropertyAttributes;
begin
  if (FGestureList <> nil) and (FGestureList.Count > 0) then
    Result := [paSubProperties, paReadOnly]
  else
    Result := [paReadOnly];
end;

function TGestureListProperty.GetName: string;
begin
  Result := FPropName;
end;

procedure TGestureListProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
begin
  for I := 0 to FGestureList.Count - 1 do
    Proc(TGestureProperty.Create(FDesigner, 1,
      FMX.Types.TCustomGestureCollectionItem(FGestureList[I]), FControl) as IProperty);
end;

function TGestureListProperty.GetValue: string;
var
  LItem: FMX.Types.TCustomGestureCollectionItem;
begin
  Result := '';
  for LItem in FControl.Touch.GestureList do
    if LItem.GestureType in FGestureTypes then
      Result := Format('%s%s,', [Result, LItem.DisplayName]);
  Delete(Result, Length(Result), 1);
  Result := Format('[%s]', [Result]);
end;

{ TGestureProperty }
  procedure DrawCheckbox(ACanvas: Vcl.Graphics.TCanvas; ARect: TRect;
  ASelected, AEnabled, AAllEqual, AValue: Boolean);
const
//  ThemeStyles : array[TCheckBoxState] of array[Boolean] of TThemedButton =
//    ((tbCheckBoxUncheckedDisabled, tbCheckBoxUnCheckedNormal),
//     (tbCheckBoxCheckedDisabled, tbCheckBoxCheckedNormal),
//     (tbCheckBoxMixedDisabled, tbCheckBoxMixedNormal));
  UnThemedStyles : array[0..2] of array[Boolean] of Cardinal =
    ((DFCS_BUTTONCHECK or DFCS_INACTIVE, DFCS_BUTTONCHECK),
     (DFCS_CHECKED or DFCS_INACTIVE, DFCS_CHECKED),
     (DFCS_BUTTON3STATE or DFCS_INACTIVE, DFCS_BUTTON3STATE));
var
  State: Integer;
begin
  if not AAllEqual then
    State := 0
  else if AValue then
    State := 1
  else
    State := 2;

//  if ThemeServices.ThemesEnabled then
//    ThemeServices.DrawElement(ACanvas.Handle,
//      ThemeServices.GetElementDetails(ThemeStyles[State][AEnabled]), ARect)
//  else
    DrawFrameControl(ACanvas.Handle, ARect, DFC_BUTTON, UnThemedStyles[State][AEnabled]);
end;

function ScaleGesturePoints(const Points: array of TPointF; Size: Integer): FMX.Types.TGesturePointArray;
var
  LPoint: TPointF;
  LScale: Double;
  I, MaxX, MaxY: Integer;
  OffsetX, OffsetY: Integer;
begin
  MaxX := 0;
  MaxY := 0;

  for I := 0 to Length(Points) - 1 do
  begin
    if Points[I].X > MaxX then
      MaxX := Round(Points[I].X);
    if Points[I].Y > MaxY then
      MaxY := Round(Points[I].Y);
  end;

  if (MaxX = 0) and (MaxY = 0) then
  begin
    LScale := 1;
    OffsetX := 0;
    OffsetY := 0;
  end
  else
  begin
    if MaxX > MaxY then
      LScale := (Size / MaxX)
    else
      LScale := (Size / MaxY);
    OffsetX := (Size - Round(MaxX * LScale)) div 2;
    OffsetY := (Size - Round(MaxY * LScale)) div 2;
  end;

  SetLength(Result, Length(Points));
  for I := 0 to Length(Result) - 1 do
  begin
    LPoint := Points[I];
    Result[I] := PointF(Round(LPoint.X * LScale) + OffsetX,
      Round(LPoint.Y * LScale) + OffsetY);
  end;
end;


function TGestureProperty.CheckRect(const ItemRect: TRect): TRect;
begin
  Result := Rect(ItemRect.Right + 2, ItemRect.Top,
    ItemRect.Right + ItemRect.Bottom - ItemRect.Top + 2, ItemRect.Bottom);
end;

constructor TGestureProperty.Create(const ADesigner: IDesigner;
  APropCount: Integer; AGesture: FMX.Types.TCustomGestureCollectionItem;
  AControl: TFmxObject);
var
  LData: TStandardGestureData;
  LItem: FMX.Types.TCustomGestureCollectionItem;
begin
  inherited Create(ADesigner, APropCount);
  //FFrameworkType := GetFrameworkType;
  //FIDEActions := GetIDEActions(FFrameworkType);
  FControl := AControl;
  FGesture := AGesture;
  if (FGesture.GestureType = FMX.Types.TGestureType.gtStandard) and
     FindStandardGesture(FGesture.GestureID, LData) then
    FPreviewPoints := LData.Points
  else
    FPreviewPoints := FGesture.Points;
  FPreviewSize := 20;

  LItem := FControl.Touch.FindGesture(FGesture.GestureID);
  if Assigned(LItem) then
    FGesture.Action := LItem.Action;
end;

destructor TGestureProperty.Destroy;
begin
   if FActionListView <> nil then
    FreeAndNil(FActionListView);
  inherited;
end;

procedure TGestureProperty.DoNewAction(Sender: TObject; const Category: string;
  ActionClass: TContainedActionClass; ActionList: TContainedActionList);
var
  LRoot: IRoot;
  LCategory, LName: string;
  NewAction: TContainedAction;
  LIDEActions: TIDEActionsClass;
begin
  LCategory := Category;
  if AnsiCompareText(LCategory, SActionCategoryNone) = 0 then
    LCategory := '';

  // Create new action
  LIDEActions := GetIDEActions(FFrameworkType);

  // Create new action
  NewAction := CreateAction(ActionList.Owner,
                            ActionClass,
                            FFrameworkType) as TContainedAction;
  try
    LName := GetNewActionName(NewAction, FFrameworkType);
    if ActionList.Owner = Designer.Root then
      NewAction.Name := Designer.UniqueName(LName)
    else
    begin
      LRoot := ActiveDesigner.FindRoot(ActionList.Owner);
      if LRoot <> nil then
        NewAction.Name := LRoot.GetDesigner.UniqueName(LName)
      else
        raise Exception.CreateResFmt(@SUnableToFindComponent, [ActionList.Owner.Name]);
    end;
    NewAction.Category := LCategory;
    NewAction.ActionList := ActionList;
    if (LIDEActions <> nil) then
      LIDEActions.CopyImageIfAvailable(NewAction, ActionList);

    // Update gesture
    DoSelectAction(Sender, NewAction);
  except
    NewAction.Free;
    raise;
  end;
end;


procedure TGestureProperty.DoSelectAction(Sender: TObject; Action: TContainedAction);
begin
  FHost.CloseDropDown;
  SetAction(Action);
end;

procedure TGestureProperty.Edit(const Host: IPropertyHost; DblClick: Boolean);
var
  LHost20: IPropertyHost20;
begin
  FHost := Host;
  if FActionListView <> nil then
    FActionListView.Free;

  FActionListView := TActionListView.Create(nil);
  if Supports(FHost, IPropertyHost20, LHost20) then
    FActionListView.Width := LHost20.GetDropDownWidth;
  FActionListView.OnNewAction := DoNewAction;
  FActionListView.OnSelectAction := DoSelectAction;
  FActionListView.Designer := Designer;
  FActionListView.Visible := True;
  FHost.DropDownControl(FActionListView);
end;

function TGestureProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paCustomDropDown];
end;

function TGestureProperty.GetChecked: Boolean;
begin
Result := Assigned(FControl.Touch.FindGesture(FGesture.GestureID));
end;

function TGestureProperty.GetKind: TTypeKind;
begin
  Result := tkEnumeration;
end;

function TGestureProperty.GetName: string;
begin
  Result := FGesture.DisplayName;
end;

function TGestureProperty.GetValue: string;
var
  LAction: TContainedAction;
begin
  LAction := FGesture.Action;
  if LAction <> nil then
  begin
    if LAction.Owner <> Designer.Root then
      Result := LAction.Owner.Name + DotSep + LAction.Name
    else
      Result := LAction.Name;
  end
  else
    Result := '';
end;

procedure TGestureProperty.HintShow(var HintInfo: THintInfo;
  InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
var
  S: string;
begin
  if not GestureToIdent(FGesture.GestureID, S) then
    S := IntToStr(FGesture.GestureID);
  HintInfo.HintStr := Format('Name: %s  ID: %s', [FGesture.DisplayName, S]); // Do not localize
  Handled := True;
end;

procedure TGestureProperty.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer; InNameRect: Boolean; const ItemRect: TRect;
  var Handled: Boolean);
begin
  Handled := False;
end;

procedure TGestureProperty.MouseMove(Shift: TShiftState; X, Y: Integer;
  InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
end;

procedure TGestureProperty.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
  if PtInRect(CheckRect(ItemRect), Point(X, Y)) then
  begin
    Checked := not Checked;
    Handled := True;
    Designer.Modified;
  end;
end;

procedure TGestureProperty.PropDrawName(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  ACanvas.TextRect(ARect, ARect.Left + 2, ARect.Top + 1, GetName);
end;

function TGestureProperty.PropDrawNameRect(const ARect: TRect): TRect;
begin
  Result := ARect;
end;

procedure TGestureProperty.PropDrawValue(ACanvas: Vcl.Graphics.TCanvas; const ARect: TRect;
  ASelected: Boolean);
var
  I: Integer;
  LRect: TRect;
  LPoints: FMX.Types.TGesturePointArray;
begin
  LRect := ARect;
  LRect.Right := LRect.Left + FPreviewSize + 4;
  DrawCheckbox(ACanvas, LRect, ASelected, True, AllEqual, Checked);

  OffsetRect(LRect, FPreviewSize + 4, 0);
  Inc(LRect.Right, 4);

  LPoints := ScaleGesturePoints(FPreviewPoints, FPreviewSize - 1);
  if Length(LPoints) > 0 then
  begin
    ACanvas.Pen.Color := clDkGray;
    ACanvas.Pen.Style := psSolid;
    ACanvas.MoveTo(Round(LPoints[0].X + 2 + LRect.Left), Round(LPoints[0].Y + 1 + LRect.Top));

    for I := 1 to Length(LPoints) - 1 do
      ACanvas.LineTo(Round(LPoints[I].X + 2 + LRect.Left), Round(LPoints[I].Y + 1 + LRect.Top));

    ACanvas.Pixels[Round(LPoints[Length(LPoints) - 1].X + 2 + LRect.Left),
      Round(LPoints[Length(LPoints) - 1].Y + 1 + LRect.Top)] := clDkGray;
  end;
end;

function TGestureProperty.PropDrawValueRect(const ARect: TRect): TRect;
begin
  FPreviewSize := ARect.Bottom - ARect.Top - 2;
  Result := Rect(ARect.Left, ARect.Top,
    FPreviewSize + FPreviewSize + 8 + ARect.Left,
    ARect.Bottom);
end;

procedure TGestureProperty.SetAction(const Value: TContainedAction);
var
  LItem: FMX.Types.TCustomGestureCollectionItem;
begin
  if FGesture <> nil then
  begin
    // If an Action is set for a gesture that isn't selected, select the gesture
    if (Value <> nil) and not Checked then
      Checked := True;

    FGesture.Action := FMX.ActnList.TCustomAction(Value);
    LItem := FControl.Touch.FindGesture(FGesture.GestureID);
    if LItem <> nil then
      LItem.Action := FMX.ActnList.TCustomAction(FGesture.Action);
    Designer.Modified;
  end;
end;

procedure TGestureProperty.SetChecked(const Value: Boolean);
var
  LItem: FMX.Types.TCustomGestureCollectionItem;
begin
  if Value then
  begin
    LItem := FControl.Touch.FindGesture(FGesture.GestureID);
    if LItem = nil then
      FControl.Touch.SelectGesture(FGesture.GestureID)
    else
      LItem.Action := FGesture.Action;

    if FGesture.GestureType = FMX.Types.TGestureType.gtRegistered then
      TGestureSelectionEditor.SelectGesture(FGesture.Name);
  end
  else
    FControl.Touch.UnselectGesture(FGesture.GestureID);
end;

procedure TGestureProperty.SetValue(const Value: string);
var
  LComponent: TComponent;
begin
  if Value <> '' then
  begin
    LComponent := Designer.GetComponent(Value);
    if LComponent is TBasicAction then
      SetAction(TContainedAction(LComponent));
  end
  else
    SetAction(nil);
end;

{ TGestureSelectionEditor }

class procedure TGestureSelectionEditor.AddGesture(
  AGesture: FMX.Types.TCustomGestureCollectionItem);
begin
  if FGestureUnitMap.ContainsKey(AGesture.Name) then
    FGestureUnitMap.Remove(AGesture.Name);
  FGestureUnitMap.Add(AGesture.Name, AGesture.UnitName);
end;

class constructor TGestureSelectionEditor.Create;
begin
  FGestureUnits := TStringList.Create;
  FGestureUnitMap := TDictionary<string, string>.Create;
end;

class destructor TGestureSelectionEditor.Destroy;
begin
  FGestureUnits.Free;
  FGestureUnitMap.Free;
end;

procedure TGestureSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  S: string;
begin
  inherited;
  for S in FGestureUnits do
    Proc(S);
end;

class procedure TGestureSelectionEditor.SelectGesture(
  const AGestureName: string);
begin
  if FGestureUnitMap.ContainsKey(AGestureName) then
    if FGestureUnits.IndexOf(FGestureUnitMap.Items[AGestureName]) = -1 then
      FGestureUnits.Add(FGestureUnitMap.Items[AGestureName]);
end;

{ TTouchManagerPropertyFilter }

procedure TTouchManagerPropertyFilter.FilterProperties(
  const ASelection: IDesignerSelections;
  const ASelectionProperties: IInterfaceList);
var
  I: Integer;
  LSelectedItem: TPersistent;
  LGestureListProp: TGesturesProperty;
begin
  for I := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[I];
    if (LSelectedItem.ClassName = 'TTouchManager') then
    begin
        LGestureListProp := TGesturesProperty.Create(Designer, 1,
          FMX.Types.TTouchManager(LSelectedItem));
        ASelectionProperties.Insert(1, LGestureListProp as IProperty);
    end;
  end;
end;

{ TGestureManagerEditor }

procedure TGestureManagerEditor.ExecuteVerb(Index: Integer);
begin
  inherited;

end;

function TGestureManagerEditor.GetVerb(Index: Integer): string;
begin
  Result := SCustomGestures;
end;

function TGestureManagerEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TMobileFormFilter }

procedure TMobileFormFilter.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionproperties: IInterfaceList);
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LPropertyName: string;
begin
  for i := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[i];
    if (LSelectedItem is TCommonCustomForm) and
      (TCommonCustomForm(LSelectedItem).Designer.IsMobile) then
    begin
      for J := ASelectionProperties.Count - 1 downto 0 do
      begin
        LPropertyName := (ASelectionProperties[J] as IProperty).GetName;
        if SameText(LPropertyName, 'Width') or
          SameText(LPropertyName, 'Height') or
          SameText(LPropertyName, 'ClientWidth') or
          SameText(LPropertyName, 'ClientHeight') or
          SameText(LPropertyName, 'Left') or
          SameText(LPropertyName, 'Top') or
          SameText(LPropertyName, 'WindowState') or
          SameText(LPropertyName, 'Position') or
          SameText(LPropertyName, 'BorderIcons') or
          SameText(LPropertyName, 'TopMost') then // do not localize
          ASelectionProperties.Delete(J);
      end;
    end;
  end;
end;

{ TTabItemFilter }

procedure TTabItemFilter.FilterProperties(const ASelection: IDesignerSelections;
  const ASelectionproperties: IInterfaceList);
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LPropertyName: string;
  Style: TFmxObject;
begin
  for i := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[i];

    Style := nil;
    if (LSelectedItem is TTabItem) and Assigned(TTabItem(LSelectedItem).Scene) then
    begin
      if Assigned(TTabItem(LSelectedItem).Scene.StyleBook) then
        Style := TTabItem(LSelectedItem).Scene.StyleBook;
      if not Assigned(Style) then
        Style := TStyleManager.ActiveStyleForScene(TTabItem(LSelectedItem).Scene);
    end;

    if Assigned(Style) then
      for J := 0 to Style.ChildrenCount - 1 do
        if Pos('tabitemcustom', LowerCase(Style.Children[J].StyleName)) > 0 then Exit;

    for J := ASelectionProperties.Count - 1 downto 0 do
    begin
      LPropertyName := (ASelectionProperties[J] as IProperty).GetName;
      if SameText(LPropertyName, 'CustomIcon') then // do not localize
        ASelectionProperties.Delete(J);
    end;
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

function TStyleLookupPropertyListBox.SkipStyle(ControlStyleName, StyleName: string): Boolean;
begin
  Exit(StyleName.Contains('listboxitem') or
    StyleName.Contains('header') or
    StyleName.Contains('footer') or
    inherited SkipStyle(ControlStyleName, StyleName));
end;

{ TListViewItemAppearancePropertiesNamePropertyEditor }

function TListViewAppearanceNamePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

function TListViewAppearanceNamePropertyEditor.GetFilter: TCustomListView.TRegisterAppearanceOptions;
var
  LProperties: TItemAppearanceProperties;
begin
  Result := [TCustomListView.TRegisterAppearanceOption.Item];
  if GetComponent(0) is TListViewObjectsProperties then
  begin
    LProperties :=
      TListViewObjectsProperties(GetComponent(0)).FAppearance;
    case LProperties.AppearanceType of
      TCustomListView.TAppearanceType.Item:
        Result := [TCustomListView.TRegisterAppearanceOption.Item];
      TCustomListView.TAppearanceType.ItemEdit:
        Result := [TCustomListView.TRegisterAppearanceOption.ItemEdit];
      TCustomListView.TAppearanceType.Header:
        Result := [TCustomListView.TRegisterAppearanceOption.Header];
      TCustomListView.TAppearanceType.Footer:
        Result := [TCustomListView.TRegisterAppearanceOption.Footer];
    else
      Assert(False);
    end;
  end;

end;

procedure TListViewAppearanceNamePropertyEditor.GetValues(Proc: TGetStrProc);
var
  LFilter: TCustomListView.TRegisterAppearanceOptions;
  LAppearance: TCustomListView.TRegisteredAppearance;
begin
  LFilter := GetFilter;
  for LAppearance in TCustomListView.GetRegisteredAppearances(LFilter) do
  begin
    Proc(LAppearance.Name);  // Display name
  end;
end;

//  Synch when item value is changed, and item value is exact prefix
procedure TListViewAppearanceNamePropertyEditor.Synch1SetValue(const Value: string;
  AGetValue, AGetSynchValue: TFunc<string>;
  ASetSynchValue: TProc<string>);
var
  LValue, LSynchValue: string;
  LNewValue, LNewSynchValue: string;
begin
  LValue := AGetValue;
  LSynchValue := AGetSynchValue;
  inherited SetValue(Value);
  LNewValue := AGetValue;
  if LValue <> '' then
    if LSynchValue.StartsWith(LValue, True) then
    begin
      LNewSynchValue := LNewValue +
        LSynchValue.Substring(LValue.Length);
      ASetSynchValue(LNewSynchValue);
    end;
end;

//  Synch when item value is changed, and item value is exact prefix
procedure TListViewAppearanceNamePropertyEditor.Synch2SetValue(const Value: string;
  AGetValue, AGetSynchValue: TFunc<string>;
  AGetPrefix: TFunc<string, string>;
  ASetSynchValue: TProc<string>);
var
  LValue, LSynchValue: string;
  LNewValue: string;
  LPrefix: string;
begin
  LValue := AGetValue;
  LSynchValue := AGetSynchValue;
  inherited SetValue(Value);
  LNewValue := AGetValue;
  LPrefix := AGetPrefix(LNewValue);
  if LPrefix <> '' then
    ASetSynchValue(LPrefix);
end;


{ TListViewSelectionEditor }

procedure TListViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('FMX.ListView.Types');
  AppearanceRequiresUnits(Proc);
end;

type
  TOpenListView = class(TCustomListView);

procedure TListViewSelectionEditor.AppearanceRequiresUnits(Proc: TGetStrProc);
var
  I: Integer;
  LComponent: TComponent;
  LAppearance: TCustomListView.TRegisteredAppearance;
  LList: TList<string>;
begin
  LList := TList<string>.Create;
  try
    for I := 0 to Designer.Root.ComponentCount - 1 do   // Ignore components in frames
    begin
      LComponent := Designer.Root.Components[I];
      if LComponent is TCustomListView then
      begin
        LList.Add(TOpenListView(LComponent).ItemAppearanceClassName);
        LList.Add(TOpenListView(LComponent).ItemEditAppearanceClassName);
        LList.Add(TOpenListView(LComponent).HeaderAppearanceClassName);
        LList.Add(TOpenListView(LComponent).FooterAppearanceClassName);
      end;
    end;
    for LAppearance in TCustomListView.GetRegisteredAppearances([]) do
    begin
      // Check for custom installed appearances
      if (LAppearance.UnitName <> '') and
        LList.Contains(LAppearance.Value.ClassName) then
        Proc(LAppearance.UnitName);
    end;
  finally
    LList.Free;
  end;
end;


{ TListViewItemAppearancePropertiesEditor }

procedure TListViewItemAppearancePropertiesEditor.FilterProperties(
  const ASelection: IDesignerSelections;
  const ASelectionProperties: IInterfaceList);
const
  sHeaderClassName = 'HeaderAppearanceClassName';
  sFooterClassName = 'FooterAppearanceClassName';
  sItemClassName = 'ItemAppearanceClassName';
  sItemEditClassName = 'ItemEditAppearanceClassName';
var
  I, J: Integer;
  LSelectedItem: TPersistent;
  LItem: IProperty;
  LName: string;
begin
  for I := 0 to ASelection.Count - 1 do
  begin
    LSelectedItem := ASelection[I];
    if (LSelectedItem <> nil) and (LSelectedItem is TCustomListView) then
    begin
      for J := ASelectionProperties.Count - 1 downto 0 do
      begin
        LItem := ASelectionProperties.Items[J] as IProperty;
        if LItem <> nil then
        begin
          LName := LItem.GetName;
          if (LName = sItemClassName) or
            (LName = sHeaderClassName) or
            (LName = sItemEditClassName) or
            (LName = sFooterClassName) then
          begin
            LItem := nil;
            ASelectionProperties.Delete(J);
          end;
        end;
      end;
    end;
  end;
end;


{ TListViewSprig }


function AppearanceProperty(const AAppearance: TItemAppearanceProperties): string;
const
  sItemAppearance = 'Item';
  sHeaderAppearance = 'Header';
  sFooterAppearance = 'Footer';
  sItemEditAppearance = 'ItemEdit';
begin
  case AAppearance.AppearanceType of
    TCustomListView.TAppearanceType.Item:
      Result := sItemAppearance;
    TCustomListView.TAppearanceType.ItemEdit:
      Result := sItemEditAppearance;
    TCustomListView.TAppearanceType.Header:
      Result := sHeaderAppearance;
    TCustomListView.TAppearanceType.Footer:
      Result := sFooterAppearance;
  else
    Assert(False);
  end;
end;

function AppearanceObjectsSprigName(const AAppearance: TItemAppearanceProperties): string;
begin
  Result := AAppearance.Owner.Name + '.' + AppearanceProperty(AAppearance);
end;

function AppearanceSprigName(const AListView: TCustomListView): string;
begin
  Result := AListView.Name + '.' + TOpenListView(AListView).ItemAppearanceObjects.ClassName;
end;

function AppearanceObjectsSprigDisplayName(const AAppearance: TItemAppearanceProperties): string;
begin
  Result := AppearanceProperty(AAppearance);
end;

function ObjectAppearanceSprigName(const AOwner: TItemAppearanceProperties; const AName: string): string;
begin
  Result := AppearanceObjectsSprigName(AOwner) + '.' + AName;
end;

function ObjectAppearanceSprigDisplayName(const AOwner: TItemAppearanceProperties; const AName: string): string;
begin
  Result := AName;
end;


procedure TListViewSprig.FigureChildren;

  procedure AddAppearanceSprig(const AListView: TCustomListView);
  var
    LSprig: TSprig;
  begin
    LSprig := Find(AppearanceSprigName(AListView), False);
    if LSprig = nil then
      // if not then make it
      Add(TListViewAppearanceSprig.Create(AListView));
  end;

var
  LListView: TCustomListView;
begin
  //inherited;

  LListView := Item as TCustomListView;
  AddAppearanceSprig(LListView);
end;

{ TListViewAppearanceSprig }

function TListViewObjectsSprig.Caption: string;
begin
  Result := AppearanceObjectsSprigDisplayName(FAppearance);
end;

procedure TListViewObjectsSprig.FigureParent;
begin
end;

function TListViewObjectsSprig.Ghosted: Boolean;
begin
  Result := not FAppearance.Active;
end;

function TListViewObjectsSprig.UniqueName: string;
begin
  Result := AppearanceObjectsSprigName(FAppearance as TItemAppearanceProperties);
end;

constructor TListViewObjectsSprig.Create(AListView: TCustomListView;
  AAppearance: TItemAppearanceProperties);
begin
  FPersistent := TListViewObjectsProperties.Create(AAppearance);
  inherited Create(FPersistent); // Select list view when click this sprig item
  ImageIndex := CCollectionSprigImage;
  FAppearance := AAppearance;
end;

destructor TListViewObjectsSprig.Destroy;
begin
  FPersistent.Free;
  inherited;
end;

procedure TListViewObjectsSprig.FigureChildren;

  procedure AddObjectAppearanceSprig(const AOwner: TItemAppearanceProperties; const AName: string; const AObjectAppearance: TObjectAppearance);
  var
    LSprig: TSprig;
  begin
    LSprig := Find(ObjectAppearanceSprigName(AOwner, AName), False);
    if LSprig = nil then
      // if not then make it
      Add(TObjectAppearanceSprig.Create(AOwner, AName, AObjectAppearance));
  end;

var
  LAppearance: TItemAppearanceProperties;
  LProperties: TItemAppearanceObjects;
  I: Integer;
  LPropCount: Integer;
  LProp: TObject;
  LProps: TPropList;
begin
  inherited;
  LAppearance := FAppearance;
  if FClassName <> LAppearance.AppearanceClassName then
  begin
    for I := Count - 1 downto 0 do
      Items[I].Free;
  end;

  LProperties := LAppearance.Objects;
  if LProperties <> nil then
  begin
    LPropCount := GetPropList(LProperties.ClassInfo, [tkClass], @LProps);
    for I := 0 to LPropCount - 1 do
    begin
      LProp := TObject(GetOrdProp(LProperties, LProps[I]));
      if LProp is TObjectAppearance then
        AddObjectAppearanceSprig(LAppearance, GetPropName(LProps[I]), TObjectAppearance(LProp));
    end;
  end;
  FClassName := LAppearance.AppearanceClassName;
end;


{ TListViewAppearanceSprig }


function TListViewAppearanceSprig.Caption: string;
begin
  Result := 'ItemAppearance'; // Do not localize
end;

function TListViewAppearanceSprig.Ghosted: Boolean;
begin
  Result := False;
end;

constructor TListViewAppearanceSprig.Create(const AListView: TCustomListView);
begin
  FListView := AListView;
  inherited Create(TOpenListView(AListView).ItemAppearance);
end;

procedure TListViewAppearanceSprig.FigureChildren;

  procedure AddObjectsSprig(const AListView: TCustomListView; const AAppearance: TItemAppearanceProperties);
  var
    LSprig: TSprig;
  begin
    LSprig := Find(AppearanceObjectsSprigName(AAppearance), False);
    if LSprig = nil then
      // if not then make it
      Add(TListViewObjectsSprig.Create(AListView, AAppearance));
  end;

var
  LAppearanceProperties: TItemAppearanceProperties;
begin
  for LAppearanceProperties in  TOpenListView(FListView).GetAppearanceProperties do
    AddObjectsSprig(FListView, LAppearanceProperties);
end;

procedure TListViewAppearanceSprig.FigureParent;
begin
  //SeekParent(FListView).Add(Self)
end;

function TListViewAppearanceSprig.UniqueName: string;
begin
  Result := AppearanceSprigName(FListView);
end;

{ TObjectAppearanceSprig }

function TObjectAppearanceSprig.Caption: string;
begin
  Result := ObjectAppearanceSprigDisplayName(FOwner, FName);
end;

constructor TObjectAppearanceSprig.Create(const AOwner: TItemAppearanceProperties;
  const AName: string; const AObjectAppearance: TObjectAppearance);
begin
  FOwner := AOwner;
  FName := AName;
  inherited Create(AObjectAppearance);
  ImageIndex := CUIControlSprigImage;
end;

procedure TObjectAppearanceSprig.FigureParent;
begin
  // SeekParent(FOwner.Owner)
end;

function TObjectAppearanceSprig.Ghosted: Boolean;
begin
  if not Invalid then
    Result := not (Item as TObjectAppearance).Visible
  else
    Result := True;
end;

function TObjectAppearanceSprig.UniqueName: string;
begin
  Result := ObjectAppearanceSprigName(FOwner, FName);
end;

{ TListViewItemAppearancePropertiesProperty }

function TListViewObjectsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited + [paVolatileSubProperties];
end;

{ TListViewHeaderAppearanceNamePropertyEditor }

function TListViewHeaderAppearanceNamePropertyEditor.GetFilter: TCustomListView.TRegisterAppearanceOptions;
begin
  Result := [TCustomListView.TRegisterAppearanceOption.Header]
end;

{ TListViewFooterAppearanceName }

function TListViewFooterAppearanceNamePropertyEditor.GetFilter: TCustomListView.TRegisterAppearanceOptions;
begin
  Result := [TCustomListView.TRegisterAppearanceOption.Footer]

end;

{ TListViewItemEditAppearanceNamePropertyEditor }

function TListViewItemEditAppearanceNamePropertyEditor.GetFilter: TCustomListView.TRegisterAppearanceOptions;
begin
  Result := [TCustomListView.TRegisterAppearanceOption.ItemEdit]

end;

{ TLinkViewEditModeSelectionEditor }

constructor TLinkViewEditModeSelectionEditor.Create(const ADesigner: IDesigner);
begin
  inherited;

end;

procedure TLinkViewEditModeSelectionEditor.ExecuteVerb(Index: Integer;
  const List: IDesignerSelections);
var
  LListView: TCustomListView;
begin
  LListView := nil;
  if List.Count > 0 then
  begin
    if (List[0] is TCustomListView) then
      LListView := TCustomListView(List[0])
    else if List[0] is TCustomListView.TPublishedAppearance then
      LListView := TCustomListView.TPublishedAppearance(List[0]).Owner
    else if List[0] is TListViewObjectsProperties then
      LListView := TListViewObjectsProperties(List[0]).FAppearance.Owner;
  end;
  if LListView <> nil then
  begin
    TOpenListView(LListView).EditMode := not  TOpenListView(LListView).EditMode;
    Designer.Modified;
  end;
end;

resourcestring
  SToggleEditMode = 'Toggle EditMode';

function TLinkViewEditModeSelectionEditor.GetVerb(Index: Integer): string;
begin
  Result := SToggleEditMode;
end;

function TLinkViewEditModeSelectionEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TListViewAppearanceNamePropertyEditor.SetValue(const Value: string);
var
  LAppearance: TCustomListView.TPublishedAppearance;
  LFilter: TCustomListView.TRegisterAppearanceOptions;
  LProperties: TItemAppearanceProperties;
begin
  if GetComponent(0) is TCustomListView.TPublishedAppearance and (Value <> '') then
  begin
    LAppearance := TCustomListView.TPublishedAppearance(GetComponent(0));
  end
  else if GetComponent(0) is TListViewObjectsProperties then
  begin
    LProperties :=
      TListViewObjectsProperties(GetComponent(0)).FAppearance;
    LAppearance :=
      TOpenListView(LProperties.Owner).ItemAppearance;
  end;
  LFilter := GetFilter;

  if LAppearance <> nil then
  begin
    if LFilter = [TCustomListView.TRegisterAppearanceOption.Item] then
      // Synch itemedit with item
      Synch1SetValue(Value,
       function: string
       begin
         Result := LAppearance.ItemAppearance;
       end,
       function: string
       begin
         Result := LAppearance.ItemEditAppearance;
       end,
       procedure(AValue: string)
       var
         LPair: TCustomListView.TRegisteredAppearance;
       begin
         for LPair in TCustomListView.GetRegisteredAppearances([TCustomListView.TRegisterAppearanceOption.ItemEdit]) do
           if SameText(AValue, LPair.Name) then
             LAppearance.ItemEditAppearance := AValue;
       end)
    else if LFilter = [TCustomListView.TRegisterAppearanceOption.ItemEdit] then
      // Synch item with itemedit
      Synch2SetValue(Value,
       function: string
       begin
         Result := LAppearance.ItemEditAppearance;
       end,
       function: string
       begin
         Result := LAppearance.ItemAppearance;
       end,
       function(AValue: string): string  // Get prefix of itemedit
       var
         LPair: TCustomListView.TRegisteredAppearance;
       begin
         Result := '';
         for LPair in TCustomListView.GetRegisteredAppearances([TCustomListView.TRegisterAppearanceOption.Item]) do
           if (LPair.Name <> '') and AValue.StartsWith(LPair.Name) then
             Exit(LPair.Name);
       end,
       procedure(AValue: string)
       var
         LPair: TCustomListView.TRegisteredAppearance;
       begin
         for LPair in TCustomListView.GetRegisteredAppearances([TCustomListView.TRegisterAppearanceOption.Item]) do
           if SameText(AValue, LPair.Name) then
             LAppearance.ItemAppearance := AValue;
       end)
    else
      inherited;
  end
  else
    inherited;
end;

{ TListViewObjectsProperties }

constructor TListViewObjectsProperties.Create(
  const AAppearance: TItemAppearanceProperties);
begin
  inherited Create;
  FAppearance := AAppearance;
end;

function TListViewObjectsProperties.GetHeight: Integer;
begin
  Result := FAppearance.Height;
end;

function TListViewObjectsProperties.GetName: string;
begin
  Result := FAppearance.Name;
end;

function TListViewObjectsProperties.IsHeightStored: Boolean;
begin
  Result := TOpenItemAppearanceProperties(FAppearance).IsHeightStored;
end;

procedure TListViewObjectsProperties.SetHeight(const Value: Integer);
begin
  FAppearance.Height := Value;
end;

procedure TListViewObjectsProperties.SetName(const Value: string);
begin
  FAppearance.Name := Value;
end;

end.
