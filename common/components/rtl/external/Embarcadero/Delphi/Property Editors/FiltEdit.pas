{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FiltEdit;

interface

uses Windows, Messages, Classes, Graphics, Forms, Controls, Tabs,
  Buttons, DesignIntf, DesignEditors, Grids, StdCtrls, ExtCtrls;

type
  TFilterEditor = class(TForm)
    Bevel1: TBevel;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    procedure SetFilter(Value: string);
    function GetFilter: string;
  end;

  TFilterProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

uses SysUtils, DsnConst, LibHelp;


{$R *.dfm}

const
  NameCol = 0;
  FiltCol = 1;
  FirstRow = 1;

var
  FilterGrid: TStringGrid;

{ TFilterEditor }

procedure TFilterEditor.FormCreate(Sender: TObject);
begin
  HelpContext := hcDFilterEditor;
  FilterGrid := TStringGrid.Create(Self);
  FilterGrid.BoundsRect := Bevel1.BoundsRect;
  with FilterGrid do
  begin
    ColCount := 2;
    FixedCols := 0;
    RowCount := 25;
    ScrollBars := ssVertical;
    Options := [goFixedVertLine, goHorzLine, goVertLine, goEditing, goTabs,
      goAlwaysShowEditor];
    Parent := Self;
    TabOrder := 1;
    ColWidths[NameCol] := ClientWidth div 2;
    ColWidths[FiltCol] := (ClientWidth div 2) - 1;
    DefaultRowHeight := Canvas.TextHeight('W') + 2;
    Cells[NameCol,0] := SFilterName;
    Cells[FiltCol,0] := SFilter;
  end;
  ActiveControl := FilterGrid;
end;

function TFilterEditor.GetFilter: string;
var
  I: Integer;

  function EmptyRow: Boolean;
  begin
    Result := True;
    with FilterGrid do
      if (Cells[NameCol, I] <> '') or (Cells[FiltCol, I] <> '') then
        Result := False;
  end;

begin
  Result := '';
  with FilterGrid do
  begin
    for I := FirstRow to RowCount - 1 do
    begin
      if not EmptyRow then
      begin
        Result := Result+Cells[NameCol, I];
        Result := Result+'|';
        Result := Result+Cells[FiltCol, I];
        Result := Result+'|';
      end;
    end;
  end;
  I := Length(Result);
  if I > 0 then
    while IsDelimiter('|', Result, I) do
    begin
      SetLength(Result, Length(Result) - 1);
      Dec(I);
    end;
end;

procedure TFilterEditor.SetFilter(Value: string);
var
  Index: Byte;
  r, c: Integer;
begin
  if Value <> '' then
  begin
    r := FirstRow;
    c := NameCol;
    Index := AnsiPos('|', Value);
    with FilterGrid do
    begin
      while Index > 0 do
      begin
        Cells[c, r] := Copy(Value, 1, Index - 1);
        if c = FiltCol then
        begin
          c := NameCol;
          if r = RowCount - 1 then
            RowCount := RowCount + 1;
          r := r + 1;
        end
        else c := FiltCol;
        Delete(Value, 1, Index);
        Index := AnsiPos('|', Value);
      end;
      Cells[c, r] := Copy(Value, 1, Length(Value));
    end;
  end;
end;

{ TFilterProperty }

procedure TFilterProperty.Edit;
var
  FilterEditor: TFilterEditor;
begin
  FilterEditor := TFilterEditor.Create(Application);
  try
    FilterEditor.SetFilter(GetValue);
    FilterEditor.ShowModal;
    if FilterEditor.ModalResult = mrOK then
      SetValue(FilterEditor.GetFilter);
  finally
    FilterEditor.Free;
  end;
end;

function TFilterProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end;

procedure TFilterEditor.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.

