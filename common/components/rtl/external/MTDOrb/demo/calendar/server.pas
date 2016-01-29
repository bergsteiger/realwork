unit server;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,orb,orb_int,calendar_int,orbtypes,value_int,calendar;

type

  TForm1 = class(TForm)
    Label1: TLabel;
    Addr: TEdit;
    RunBtn: TButton;
    Memo1: TMemo;
    Label2: TLabel;
    PathEdit: TEdit;
    procedure RunBtnClick(Sender: TObject);
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    dorb: IORB;
    df : Idatetest_init;
  end;

  TORBThread = class(TThread)
  private
    dorb: IORB;
  protected
    procedure Execute; override;
  public
    constructor Create(orb: IORB);
  end;

  Tdate_impl = class(Tdatetest)
  protected
    function equal(const other: Idatetest): boolean; override;
    function compare(const other: Idatetest): smallint; override;
  public
    constructor Create(_day: _ushort; _month: _ushort; _year: _ushort);
  end;

  Tdate_factory = class(Tdatetest_init)
  protected
    function _create(dd: _ushort; mm: _ushort; yyyy: _ushort): Idatetest; override;
    function create_for_umarshal(): IValueBase; override;
  end;

  TCalendar_impl = class(TCalendar_serv)
  private
    FEntries: TStringList;
    FHandle: THandle;
  protected
    procedure insert(const when: Idatetest; const what: AnsiString); override;
    function find_date(const when: Idatetest; out what: AnsiString): boolean; override;
    function find_note(const what: AnsiString; out when: Idatetest): boolean; override;
  public
    constructor Create(hwnd: THandle);
    destructor Destroy(); override;
  end;

const
  CALENDAR_MESSAGE = WM_USER + 100;


var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  utils,poa_impl,poa_int,policy_int;

//***********************************************************
// Tdate_impl
//***********************************************************
constructor Tdate_impl.Create(_day: _ushort; _month: _ushort; _year: _ushort);
begin
  inherited Create();
  Fdatetest_day := _day;
  Fdatetest_month := _month;
  Fdatetest_month := _year;
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

//***********************************************************
// Tdate_factory
//***********************************************************
function Tdate_factory.create_for_umarshal(): IValueBase;
begin
  result := Tdate_impl.Create(0, 0, 0);
end;

function Tdate_factory._create(dd: _ushort; mm: _ushort; yyyy: _ushort): Idatetest;
begin
  result := Tdate_impl.Create(dd, mm, yyyy);
end;

//***********************************************************
// Calendar_impl
//***********************************************************
constructor TCalendar_impl.Create(hwnd: THandle);
begin
  inherited Create();
  FEntries := TStringList.Create;
  FHandle := hwnd;
end;

destructor TCalendar_impl.Destroy();
begin
  FEntries.Free;
end;

procedure TCalendar_impl.insert(const when: Idatetest; const what: AnsiString);
var
  d: longint;
  str: PAnsiChar;
  val: AnsiString;
begin
  d := (when.day shl 24) or (when.month shl 12) or (when.year and $FFF);
  FEntries.addObject(String(what),TObject(d));
  val := AnsiString(DateToStr(EncodeDate(when.Year,when.month,when.day)))+': '+what;
  str := AllocMem(Length(val)+1);
  StrCopy(str,PAnsiChar(val));
  PostMessage(FHandle,CALENDAR_MESSAGE,Integer(PChar(str)),0);
end;

function TCalendar_impl.find_date(const when: Idatetest; out what: AnsiString): boolean;
var
  d: longint;
  i : integer;
begin
  d := (when.day shl 24) or (when.month shl 12) or (when.year and $FFF);
  i := FEntries.IndexOfObject(TObject(d));
  result := i >= 0;
  if result then
    what := AnsiString(FEntries[i]);
end;

function TCalendar_impl.find_note(const what: AnsiString; out when: Idatetest): boolean;
var
  i : integer;
  d,m,y: word;
  dd : longint;
begin
  when := nil;
  result := false;
  for i := 0 to Pred(FEntries.count) do
    if pos(String(what),FEntries[i]) >= 0 then break;
  if i = FEntries.count then exit;
  result := true;
  if result then
    begin
      dd := Longint(FEntries.Objects[i]);
      d := dd shr 24;
      m := dd shr 12 and $3FF;
      y := dd and $FFF;
      when := Tdate_impl.Create(d,m,y);
    end;
end;


procedure TForm1.WndProc(var Message: TMessage);
begin
  if message.Msg = CALENDAR_MESSAGE then
    begin
      Memo1.Lines.Add(PChar(message.WParam));
      FreeMem(PChar(message.WParam));
      message.Result := 1;
    end;
  inherited;
end;

procedure TForm1.RunBtnClick(Sender: TObject);
var
  params: TStrings;
  obj : IORBObject;
  p: IPOA;
  pm : IPOAManager;
  lst: PolicyList;
  id : ObjectID;
  impl : TCalendar_impl;
begin
  params := TStringList.Create;
  try
    params.Add('-ORBIIOPAddr');
    params.Add(addr.Text);
    dorb := ORB_Init(params);
    df := TDate_factory.Create();
    dorb.register_value_factory('IDL:date:1.0',df);
    obj := dorb.resolve_initial_reference('RootPOA');
    p := POA_narrow(obj);
    setlength(lst,0);
    p := p.create_POA('calendar',p.the_POAManager,lst);
    pm := p.the_POAManager();
    impl := TCalendar_impl.Create(self.Handle);
    id := p.activate_object(impl);
    obj := p.id_to_reference(id);
    params.clear;
    params.add(String(dorb.object_to_string(obj)));
    params.SaveToFile(PathEdit.Text);
    pm.activate;
    TORBThread.Create(dorb);
    RunBtn.Enabled := false;
  finally
    params.Free;
  end;
end;

{ TORBThread }

constructor TORBThread.Create(orb: IORB);
begin
  dorb := orb;
  inherited Create(false);
  FreeOnTerminate := true;
end;

procedure TORBThread.Execute;
begin
  dorb.run;
end;

end.
