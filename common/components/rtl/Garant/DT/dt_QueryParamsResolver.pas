unit dt_QueryParamsResolver;

{$I DtDefine.inc}

interface

uses
 l3ProtoObject,
 dt_Query;

type
  TdtQueryParamsResolver = class(Tl3ProtoObject)
  private
   f_NeedProcess: Boolean;
   f_Prev: TDateTime;
   f_Now: TDateTime;
   f_Name: String;
   function LoadStartDate: TDateTime;
   procedure SaveStartDate;
  public
   constructor Create(const aQuery: TdtCustomQuery; const aName: String; aNeedProcess: Boolean);
   procedure SaveLastExecParams;
  end;

implementation

uses
 SysUtils,
 l3IniFile,
 l3Date;

const
 c_Section = 'ExecuteDates';

{ TdtQueryParamsResolver }

constructor TdtQueryParamsResolver.Create(const aQuery: TdtCustomQuery;
  const aName: String; aNeedProcess: Boolean);

 function DoChangeDates(const aQuery: TdtCustomQuery): Boolean;
 var
  l_Query: TdtCustomLogQuery;
 begin
  Result := True;
  if aQuery is TdtCustomLogQuery then
  begin
   l_Query := TdtCustomLogQuery(aQuery);
   if f_Prev <> 0 then
    l_Query.FromDate := DateTimeToStDate(f_Prev);
   l_Query.ToDate := DateTimeToStDate(f_Now);
  end;
 end;

begin
 inherited Create;
 f_NeedProcess := aNeedProcess;
 f_Name := aName;
 if f_NeedProcess then
 begin
   f_Prev := LoadStartDate;
   f_Now := Now;
   aQuery.IterateF(dtL2QA(@DoChangeDates));
 end;
end;

function TdtQueryParamsResolver.LoadStartDate: TDateTime;
var
 l_Ini: TCfgList;
 l_DateStr: String;
begin
 l_Ini := TCfgList.Create(ChangeFileExt(ParamStr(0), '.ini'));
 try
  l_Ini.Section := c_Section;
  Result := l_Ini.ReadParamDateTimeDef(f_Name, 0);
 finally
  FreeAndNil(l_Ini);
 end;
end;

procedure TdtQueryParamsResolver.SaveLastExecParams;
begin
 if f_NeedProcess then
   SaveStartDate;
end;

procedure TdtQueryParamsResolver.SaveStartDate;
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create(ChangeFileExt(ParamStr(0), '.ini'));
 try
  l_Ini.Section := c_Section;
  l_Ini.WriteParamDateTime(f_Name, f_Now);
 finally
  FreeAndNil(l_Ini);
 end;
end;

end.
