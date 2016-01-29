unit nsQueryExecuteProgressIndicator;

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
 DynamicDocListUnit,
 SearchUnit,

 nsExecuteProgressIndicator,

 SearchInterfaces
 ;

type
 TnsQueryExecuteProgressIndicator = class (TnsExecuteProgressIndicator)
 private
  f_Query: IQuery; // object
  f_FiltrateList: IDynList;
 protected
  procedure DoStartProcess;
   override;
    {-}
  function DataValid: Boolean;
   override;
    {-}
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aQuery: IQuery;
                     const aFiltrateList: IDynList);
   reintroduce;
    {-}
  class function Make(const aQuery: IQuery;
                     const aFiltrateList: IDynList): InsProgressIndicator;
    {-}
 end;
{$IfEnd} //not Admin 

implementation

uses
 l3Base
 ;

{$If not defined(Admin) AND not defined(Monitorings)}
constructor TnsQueryExecuteProgressIndicator.Create(const aQuery: IQuery;
		const aFiltrateList: IDynList
	);
begin
 inherited Create;
//
 f_Query := aQuery;
 f_FiltrateList := aFiltrateList;
end;

procedure TnsQueryExecuteProgressIndicator.Cleanup;
begin
 f_Query := nil;
 f_FiltrateList := nil;
 inherited;
end;

function TnsQueryExecuteProgressIndicator.DataValid: Boolean;
begin
 Result := Assigned(f_Query);
end;

procedure TnsQueryExecuteProgressIndicator.DoStartProcess;
begin
 if Assigned(f_Query) then
  f_Query.Execute(f_FiltrateList, self, f_CancelLongProcess);
end;

class function TnsQueryExecuteProgressIndicator.Make(const aQuery: IQuery;
  const aFiltrateList: IDynList): InsProgressIndicator;
var
 l_Inst: TnsQueryExecuteProgressIndicator;
begin
 l_Inst := Create(aQuery, aFiltrateList);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;
{$IfEnd} //not Admin

end.
