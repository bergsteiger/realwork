unit frMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vtScrollbar, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sePage: TSpinEdit;
    seMin: TSpinEdit;
    seMax: TSpinEdit;
    sePos: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    seSmallChange: TSpinEdit;
    seLargeChange: TSpinEdit;
    procedure FormClick(Sender: TObject);
    procedure sePageChange(Sender: TObject);
  private
    f_Writing,
    f_Reading: Boolean;
    anSb: TvtScrollBar;
    procedure SbChanged(Sender: TObject);
    procedure SbScroll(aSender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure Read;
    procedure Write;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClick(Sender: TObject);
begin
 if not Assigned(anSb) then
  anSb := TvtScrollBar.Create(Self);
 with anSb do
 begin
  Read;
  Parent := Self;
  OnChange := SbChanged;
  OnScroll := SbScroll;
  Align := TvtScrollBarAlign(Ord(Align) mod 4 + 1);
 end;
end;

procedure TForm1.Read;
begin
 if f_Writing or f_Reading then
  Exit;

 f_Reading := True;
 try
  if Assigned(anSb) then
  begin
   sePage.Value := anSb.PageSize;
   seMin.Value := anSb.Min;
   seMax.Value := anSb.Max;
   sePos.Value := anSb.Position;
   seSmallChange.Value := anSb.SmallChange;
   seLargeChange.Value := anSb.LargeChange;
  end;
 finally
  f_Reading := False;
 end;
end;

procedure TForm1.Write;
begin
 if f_Writing or f_Reading then
  Exit;

 f_Writing := True;
 try
  if Assigned(anSb) then
  begin
   anSb.PageSize := sePage.Value;
   anSb.Min := seMin.Value;
   anSb.Max := seMax.Value;
   anSb.Position := sePos.Value;
   anSb.SmallChange := seSmallChange.Value;
   anSb.LargeChange := seLargeChange.Value;
  end;
 finally
  f_Writing := False;
 end;
end;

procedure TForm1.SbChanged(Sender: TObject);
begin
 Read;
end;

procedure TForm1.SbScroll(aSender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
 Read;
end;

procedure TForm1.sePageChange(Sender: TObject);
begin
 Write;
end;

end.
