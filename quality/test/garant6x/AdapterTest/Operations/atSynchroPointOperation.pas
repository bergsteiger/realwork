unit atSynchroPointOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atSynchroPointOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSynchroPointOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atOperationBase,
  atSynchroPoint
  ;

type
 TatSynchroPointOperation = class(TatOperationBase)
 private
 // private fields
   f_SynchroPoint : TatSynchroPoint;
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitParamList; override;
 public
 // overridden public methods
   procedure AfterFillingParamList; override;
     {* ���������� ����������� �������� ����� ���������� �������� ����������.
���� �������� ���� ���-�� ����������������, � ��� ����� ����� �������� ���������� �� ��������. }
 end;//TatSynchroPointOperation

implementation

uses
  atLogger,
  SysUtils
  ;

// start class TatSynchroPointOperation

procedure TatSynchroPointOperation.ExecuteSelf;
//#UC START# *48089F460352_492154F303D9_var*
  var
    l_TimeOut : LongWord;
//#UC END# *48089F460352_492154F303D9_var*
begin
//#UC START# *48089F460352_492154F303D9_impl*
  if f_ParamList.ParamByName['timeout'].AsInt = -1 then
    l_TimeOut := $FFFFFFFF // ����������
  else
    l_TimeOut := f_ParamList.ParamByName['timeout'].AsInt;
  //
  Logger.Info('�������� ������������� �� ����� "%s"', [f_ParamList.ParamByName['point_name'].AsStr]);
  if f_SynchroPoint.Synchronize(l_TimeOut) then
    Logger.Info('������������� ������ �������')
  else
    Logger.Warning('�� ������� ������������������ �� ���������� ����� (%u)', [l_TimeOut]);
//#UC END# *48089F460352_492154F303D9_impl*
end;//TatSynchroPointOperation.ExecuteSelf

procedure TatSynchroPointOperation.Cleanup;
//#UC START# *479731C50290_492154F303D9_var*
//#UC END# *479731C50290_492154F303D9_var*
begin
//#UC START# *479731C50290_492154F303D9_impl*
  FreeAndNil(f_SynchroPoint);
  inherited;
//#UC END# *479731C50290_492154F303D9_impl*
end;//TatSynchroPointOperation.Cleanup

procedure TatSynchroPointOperation.InitParamList;
//#UC START# *48089F3701B4_492154F303D9_var*
//#UC END# *48089F3701B4_492154F303D9_var*
begin
//#UC START# *48089F3701B4_492154F303D9_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('point_name', '��� ����� �������������') );
    Add( ParamType.Create('timeout', '����� � ������� �������� ���� ���������� �������������') );
  end;
//#UC END# *48089F3701B4_492154F303D9_impl*
end;//TatSynchroPointOperation.InitParamList

procedure TatSynchroPointOperation.AfterFillingParamList;
//#UC START# *492188F70140_492154F303D9_var*
//#UC END# *492188F70140_492154F303D9_var*
begin
//#UC START# *492188F70140_492154F303D9_impl*
  inherited;
  f_SynchroPoint := TatSynchroPoint.Create( f_ParamList.ParamByName['point_name'].AsStr );
//#UC END# *492188F70140_492154F303D9_impl*
end;//TatSynchroPointOperation.AfterFillingParamList

end.