unit atSynchroPoint;
 {* "����� �������������". ��� ������������� ���� "����� �� ������������� ����� � ����� ���� ��� �� ��������� ����� �����". }

// ������: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atSynchroPoint.pas"
// ���������: "SimpleClass"
// ������� ������: "TatSynchroPoint" MUID: (491D9DFA0288)

interface

uses
 l3IntfUses
 , l3_Base
 , atNamedMutex
 , atSharedBuffer
 , SyncObjs
;

type
 PSyncData = ^TSyncData;

 TSyncData = record
  Total: Integer;
  Waiting: Integer;
 end;//TSyncData

 TatSynchroPoint = class(Tl3_Base)
  {* "����� �������������". ��� ������������� ���� "����� �� ������������� ����� � ����� ���� ��� �� ��������� ����� �����". }
  private
   f_Mutex: TatNamedMutex;
   f_SharedBuf: TatSharedBuffer;
   f_SyncData: PSyncData;
   f_ContinueEvent: TEvent;
  private
   procedure Register; virtual;
   procedure Unregister; virtual;
   function ContinueIfSynchronized: Boolean; virtual;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(const aName: AnsiString); reintroduce;
   function Synchronize(aTimeOut: LongWord): Boolean; virtual;
    {* ������� ���������� ���������� ���� ����� �������� ������������� (����� ��� ����� �� ������ Synchronize), ���� �� ��������� ��������. � ������ ������ ��������� - true, �� ������ - false. }
 end;//TatSynchroPoint

implementation

uses
 l3ImplUses
 , SysUtils
;

constructor TatSynchroPoint.Create(const aName: AnsiString);
//#UC START# *491DA1A60030_491D9DFA0288_var*
//#UC END# *491DA1A60030_491D9DFA0288_var*
begin
//#UC START# *491DA1A60030_491D9DFA0288_impl*
  inherited Create;
  //
  f_Mutex := TatNamedMutex.Create(aName);
  f_ContinueEvent := TEvent.Create(nil, true, false, '{DE90ACF0-3AB6-4004-B9BF-24A328D271A4}_' +aName);
  // ��������� ��� ������ �������������
  f_SharedBuf := TatSharedBuffer.Create(aName, SizeOf(TSyncData));
  f_SyncData := f_SharedBuf.Value;
  // �������������� � ����� �������������
  Register;
//#UC END# *491DA1A60030_491D9DFA0288_impl*
end;//TatSynchroPoint.Create

function TatSynchroPoint.Synchronize(aTimeOut: LongWord): Boolean;
 {* ������� ���������� ���������� ���� ����� �������� ������������� (����� ��� ����� �� ������ Synchronize), ���� �� ��������� ��������. � ������ ������ ��������� - true, �� ������ - false. }
//#UC START# *491DA82B01A2_491D9DFA0288_var*
//#UC END# *491DA82B01A2_491D9DFA0288_var*
begin
//#UC START# *491DA82B01A2_491D9DFA0288_impl*
  if f_Mutex.Acquire then
    try
      // ����������� ���������� ������ �� ������� (������ ����)
      Assert(f_SyncData.Waiting >= 0, 'invalid f_SyncData.Waiting');
      Inc(f_SyncData.Waiting);
      // ���������, ������������������ ��
      ContinueIfSynchronized;
    finally
      f_Mutex.Release;
    end;
  // ���� ������������
  Result := f_ContinueEvent.WaitFor(aTimeOut) = wrSignaled;
  // ���� �� ��������� �� ������� ���� �� ������ ������
  if NOT Result then
    if f_Mutex.Acquire then
      try
        if (f_SyncData.Waiting > 0) then
          Dec(f_SyncData.Waiting);
      finally
        f_Mutex.Release;
      end;
//#UC END# *491DA82B01A2_491D9DFA0288_impl*
end;//TatSynchroPoint.Synchronize

procedure TatSynchroPoint.Register;
//#UC START# *491DAE930239_491D9DFA0288_var*
//#UC END# *491DAE930239_491D9DFA0288_var*
begin
//#UC START# *491DAE930239_491D9DFA0288_impl*
  if f_Mutex.Acquire then
    try
      Inc(f_SyncData.Total);
    finally
      f_Mutex.Release;
    end;
//#UC END# *491DAE930239_491D9DFA0288_impl*
end;//TatSynchroPoint.Register

procedure TatSynchroPoint.Unregister;
//#UC START# *491DAE9E02BF_491D9DFA0288_var*
//#UC END# *491DAE9E02BF_491D9DFA0288_var*
begin
//#UC START# *491DAE9E02BF_491D9DFA0288_impl*
  if f_Mutex.Acquire then
    try
      Dec(f_SyncData.Total);
      // � ������ ���������, ����� ��� ����� ������ ���, � ���� ������ ���� ��������� ����
      ContinueIfSynchronized;
    finally
      f_Mutex.Release;
    end;
//#UC END# *491DAE9E02BF_491D9DFA0288_impl*
end;//TatSynchroPoint.Unregister

function TatSynchroPoint.ContinueIfSynchronized: Boolean;
//#UC START# *491DB4E001EF_491D9DFA0288_var*
//#UC END# *491DB4E001EF_491D9DFA0288_var*
begin
//#UC START# *491DB4E001EF_491D9DFA0288_impl*
  Assert(f_SyncData.Waiting <= f_SyncData.Total, 'f_SyncData.Waiting > f_SyncData.Total !');
  Result := f_SyncData.Waiting = f_SyncData.Total;
  if Result then
  begin // ���� ������ ������ �����
    f_ContinueEvent.SetEvent; // �� ��������� event
    f_SyncData.Waiting := 0; // � �������� ����� ������
  end
  else if (f_ContinueEvent.WaitFor(0) = wrSignaled) then
    f_ContinueEvent.ResetEvent; // ���� ���� ���� ����� � event �� �������, �� ����������
//#UC END# *491DB4E001EF_491D9DFA0288_impl*
end;//TatSynchroPoint.ContinueIfSynchronized

procedure TatSynchroPoint.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_491D9DFA0288_var*
//#UC END# *479731C50290_491D9DFA0288_var*
begin
//#UC START# *479731C50290_491D9DFA0288_impl*
  Unregister;
  FreeAndNil(f_Mutex);
  FreeAndNil(f_ContinueEvent);
  FreeAndNil(f_SharedBuf);
  inherited;
//#UC END# *479731C50290_491D9DFA0288_impl*
end;//TatSynchroPoint.Cleanup

end.
