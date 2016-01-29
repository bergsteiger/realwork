unit nsListExecuteProgressIndicator;

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
 DynamicDocListUnit,
 SearchUnit,

 nsExecuteProgressIndicator,

 SearchInterfaces
 ;

type
 TnsListExecuteProgressIndicator = class (TnsExecuteProgressIndicator)
 private
  f_List: IDynList;
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
  constructor Create(const aList: IDynList);
   reintroduce;
    {-}
  class function Make(const aList: IDynList): InsProgressIndicator;
    {-}
 end;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
 l3Base
 ;

constructor TnsListExecuteProgressIndicator.Create(const aList: IDynList);
begin
 inherited Create;
//
 f_List := aList;
end;

procedure TnsListExecuteProgressIndicator.Cleanup;
begin
 f_List := nil;
 inherited Cleanup;
end;

function TnsListExecuteProgressIndicator.DataValid: Boolean;
begin
 Result := Assigned(f_List);
end;

procedure TnsListExecuteProgressIndicator.DoStartProcess;
begin
 if Assigned(f_List) then
  f_List.GetFullList(Self, f_CancelLongProcess);
end;

class function TnsListExecuteProgressIndicator.Make(const aList: IDynList): InsProgressIndicator;
var
 l_Inst: TnsListExecuteProgressIndicator;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst;
 finally
  l3Free(l_Inst);
 end;
end;
{$IfEnd} //not Admin

end.
