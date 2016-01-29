{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SvrLogColSettingsFrame;

interface

uses 
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SvrLogFrame,
  Vcl.ComCtrls, SvrLog;

type
  TLogColSettingsFrame = class(TFrame)
    lvColumns: TListView;
    procedure FrameResize(Sender: TObject);
  private
    FLogFrame: TLogFrame;
    procedure SetLogFrame(const Value: TLogFrame);
  public
    procedure UpdateColumns;
    property LogFrame: TLogFrame read FLogFrame write SetLogFrame;

  end;

implementation


{$R *.dfm}

{ TLogColumnsFrame }

procedure TLogColSettingsFrame.SetLogFrame(const Value: TLogFrame);
var
  Item: TListItem;
  I: Integer;
  LogColumn: TLogColumn;
  Positions: TLogColumnOrder;
begin
  FLogFrame := Value;
  FLogFrame.SynchColumnInfo;
  FLogFrame.GetColumnOrder(Positions);
  for I := Low(Positions) to High(Positions) do
  begin
    Item := lvColumns.Items.Add;
    LogColumn := Positions[I];
    Item.Caption := LogFrame.ColumnCaption[LogColumn];
    Item.Checked := LogFrame.ColumnVisible[LogColumn];
    Item.Data := Pointer(LogColumn);
  end;
  lvColumns.Columns[0].Width := lvColumns.ClientWidth;
end;

procedure TLogColSettingsFrame.FrameResize(Sender: TObject);
begin
  // The following line causes AV's in some cases the Log tab is clicked.  Code moved
  // into SetLogFrame.

  // lvColumns.Columns[0].Width := lvColumns.ClientWidth;
end;

procedure TLogColSettingsFrame.UpdateColumns;
var
  I: Integer;
  Item: TListItem;
begin
  for I := 0 to lvColumns.Items.Count - 1 do
  begin
    Item := lvColumns.Items[I];
    LogFrame.ColumnVisible[TLogColumn(Item.Data)] := Item.Checked;
  end;
  LogFrame.RefreshColumns;
  LogFrame.RefreshSubItems;
end;

end.
