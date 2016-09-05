unit nsExecuteProgressIndicator;

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
 Windows,
 Messages,

 l3Interfaces,

 vcmInterfaces,

 BaseTypesUnit,
 DynamicDocListUnit,
 ProgressIndicatorSupportUnit,
 SearchProgressIndicatorUnit,
 SearchUnit,

 nsThreadNotifier,

 SearchInterfaces
 ;

type
 TnsExecuteProgressIndicator = class (TnsThreadNotifier,
                                      IProgressIndicatorForSearch,
                                      InsProgressIndicator)
 private
  f_MaxCount: Longint;
  f_ProgressIndicator: IvcmEntity;
  f_Result: ISearchEntity;
  f_Cancelled: Boolean;
 protected
  f_CancelLongProcess: ICancelLongProcess;
 protected
  procedure DoStartProcess;
   virtual; abstract;
    {-}
  function DataValid: Boolean;
   virtual; abstract;
    {-}
 public
  constructor Create;
   reintroduce;
    {-}
  procedure Cleanup; override;
    {-}
 //InsProgressIndicator
  function Execute(const aCaption: Il3CString; out aSearchEntity: ISearchEntity): Boolean;
    {-}
  procedure StartProcess(const aProgressIndicator: IvcmEntity);
    {-}
  procedure StopProcess;
    {-}
 //IProgressIndicatorForSearch
  function GetMaxCount: Longint;
   stdcall;
    {-}
  procedure SetCurrent(aCurCount: Longint; aArg: Longint);
   stdcall;
    {-}
  procedure FinishProcess(const aSearchEntity: ISearchEntity);
   stdcall;
    {-}
 end;
{$IfEnd} //not Admin 

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
 l3Base,

 vcmBase,

 StdRes,

 ProgressIndicator_Form,
 PrimProgressIndicator_Form
 , Common_F1CommonServices_Contracts
 ;

function TnsExecuteProgressIndicator.Execute(const aCaption: Il3CString;
  out aSearchEntity: ISearchEntity): Boolean;
var
 l_ProgressIndicator : InsProgressIndicator;
begin
 Result := False;
 if DataValid then
 begin
  l_ProgressIndicator := Self;
  try
   TCommonService.Instance.MakeProgressIndicator(l_ProgressIndicator, aCaption, GetMaxCount);
   aSearchEntity := f_Result;
   Result := not f_Cancelled;
  finally
   l_ProgressIndicator := nil;
  end;//try..finally
 end;//DataValid
end;

constructor TnsExecuteProgressIndicator.Create;
begin
 inherited Create;
//
 f_MaxCount := 100;
end;

procedure TnsExecuteProgressIndicator.Cleanup;
begin
 f_CancelLongProcess := nil;
 f_ProgressIndicator := nil;
 f_Result := nil;
 f_Cancelled := False;
 inherited Cleanup;
end;

function TnsExecuteProgressIndicator.GetMaxCount: Longint;
begin
 Result := f_MaxCount;
end;

procedure TnsExecuteProgressIndicator.StartProcess(const aProgressIndicator: IvcmEntity);
begin
 f_ProgressIndicator := aProgressIndicator;
 DoStartProcess;
end;

procedure TnsExecuteProgressIndicator.StopProcess;
begin
 if Assigned(f_CancelLongProcess) then
 begin
  f_CancelLongProcess.CancelProcess();
  f_Cancelled := True;
 end;
end;

procedure TnsExecuteProgressIndicator.SetCurrent(aCurCount: Longint; aArg: Longint);
begin
 if Assigned(f_ProgressIndicator) then
  PostMessage((f_ProgressIndicator as IvcmEntityForm).VCLWinControl.Handle, WM_USER_SET_CURRENT, aCurCount, aArg);
end;

procedure TnsExecuteProgressIndicator.FinishProcess(const aSearchEntity: ISearchEntity);
begin
 f_Result := aSearchEntity;
 if Assigned(f_ProgressIndicator) then
  PostMessage((f_ProgressIndicator as IvcmEntityForm).VCLWinControl.Handle, WM_USER_FINISH_PROCESS, 0, 0);
 f_CancelLongProcess := nil;
 f_ProgressIndicator := nil;
end;
{$IfEnd} //not Admin

end.