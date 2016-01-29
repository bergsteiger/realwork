unit client;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls,orb_int,calendar,calendar_int,orbtypes;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    BindAddr: TEdit;
    BindBtn: TButton;
    Bevel1: TBevel;
    AppDate: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    AppNote: TMemo;
    InsertBtn: TButton;
    FindNoteBtn: TButton;
    FindDateBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BindBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure FindDateBtnClick(Sender: TObject);
    procedure FindNoteBtnClick(Sender: TObject);
  private
    dorb: IORB;
    cal : ICalendar;
  public
    { Public declarations }
  end;

  Tdate_impl = class(Tdatetest)
  protected
    function equal(const other: Idatetest): boolean; override;
    function compare(const other: Idatetest): smallint; override;
  public
    constructor Create(_day: _ushort; _month: _ushort; _year: _ushort);
  end;

var
  Form1: TForm1;

implementation
uses
  orb;

{$R *.DFM}

//***********************************************************
// Tdate_impl
//***********************************************************
constructor Tdate_impl.Create(_day: _ushort; _month: _ushort; _year: _ushort);
begin
  inherited Create();
  Fdatetest_day := _day;
  Fdatetest_month := _month;
  Fdatetest_year := _year;
end;

function Tdate_impl.equal(const other: Idatetest): boolean;
begin
  result := compare(other) = 0;
end;

function Tdate_impl.compare(const other: Idatetest): smallint;
begin
  result := 0;
  if Fdatetest_year <> other.year then
    result := Fdatetest_year - other.year;
  if result <> 0 then exit;
  if Fdatetest_month <> other.month then
    result := Fdatetest_month - other.month;
  if result <> 0 then exit;
  if Fdatetest_day <> other.day then
    result := Fdatetest_day - other.day;
  if result <> 0 then exit;
  result := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  params: TStrings;
begin
  params := TStringList.Create;
  try
    //df := TDate_Factory.Create();
    dorb := ORB_Init(params);
    //dorb.register_value_factory('IDL:date:1.0',df);
  finally
    params.Free;
  end;
end;

procedure TForm1.BindBtnClick(Sender: TObject);
var
  obj : IORBObject;
begin
  obj := dorb.bind('IDL:Calendar:1.0',PAnsiChar(AnsiString(BindAddr.text)));
  if obj = nil then exit;
  cal := TCalendar_stub._narrow(obj);
  BindBtn.Enabled := cal = nil;
  InsertBtn.Enabled := cal <> nil;
  FindDateBtn.Enabled := cal <> nil;
  FindNoteBtn.Enabled := cal <> nil;
end;

procedure TForm1.InsertBtnClick(Sender: TObject);
var
  newdate: IDatetest;
  d,m,y : word;
begin
  if appnote.Text = '' then
    begin
      ShowMessage('Note not defined');
      appnote.SetFocus;
      exit;
    end;
  Decodedate(AppDate.DateTime,y,m,d);
  newdate := Tdate_impl.Create(d,m,y);
  cal.insert(newdate,AnsiString(appnote.Text));
  appnote.Text := '';
end;

procedure TForm1.FindDateBtnClick(Sender: TObject);
var
  newdate: IDatetest;
  d,m,y : word;
  val : AnsiString;
begin
  Decodedate(AppDate.DateTime,y,m,d);
  newdate := Tdate_impl.Create(d,m,y);
  if cal.find_date(newdate,val) then
    appnote.Text := String(val)
  else
    appnote.Text := 'Nothing to do';
end;

procedure TForm1.FindNoteBtnClick(Sender: TObject);
var
  newdate: IDatetest;
begin
  if appnote.Text = '' then
    begin
      ShowMessage('Note not defined');
      appnote.SetFocus;
      exit;
    end;
  if cal.find_note(AnsiString(appnote.Text),newdate) then
    AppDate.DateTime := EncodeDate(newdate.year,newdate.month,newdate.day)
  else
    appnote.Text := 'Date unknown';
end;

end.

