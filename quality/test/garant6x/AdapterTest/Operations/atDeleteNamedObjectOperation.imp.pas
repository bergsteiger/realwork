{$IfNDef atDeleteNamedObjectOperation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atDeleteNamedObjectOperation.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atDeleteNamedObjectOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atDeleteNamedObjectOperation_imp}
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteObjectOperation.imp.pas}
 _atDeleteNamedObjectOperation_ = {mixin} class(_atDeleteObjectOperation_)
 protected
 // overridden protected methods
   procedure InitParamList; override;
   procedure InitMatcher; override;
 end;//_atDeleteNamedObjectOperation_

{$Else atDeleteNamedObjectOperation_imp}

type _atDeleteObjectOperation_R_ = _atDeleteNamedObjectOperation_;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteObjectOperation.imp.pas}

// start class _atDeleteNamedObjectOperation_

procedure _atDeleteNamedObjectOperation_.InitParamList;
//#UC START# *48089F3701B4_484FA0FD0223_var*
//#UC END# *48089F3701B4_484FA0FD0223_var*
begin
//#UC START# *48089F3701B4_484FA0FD0223_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('name', '��� ���������� �������', '') );
    Add( ParamType.Create('is_regexp', '������ �� ���������� ����� � ���� ����������� ���������', 'false') );
  end;
//#UC END# *48089F3701B4_484FA0FD0223_impl*
end;//_atDeleteNamedObjectOperation_.InitParamList

procedure _atDeleteNamedObjectOperation_.InitMatcher;
//#UC START# *484FDD22003E_484FA0FD0223_var*
  var
    l_Name : String;
    l_IsRegExp : Boolean;
//#UC END# *484FDD22003E_484FA0FD0223_var*
begin
//#UC START# *484FDD22003E_484FA0FD0223_impl*
  inherited;
  // � ����� ������������� ��� � �.�.
  l_Name := Parameters['name'].AsStr;
  l_IsRegExp := Parameters['is_regexp'].AsBool;
  //
  with (f_Matcher as IatNameMatcher) do
  begin
    // ����������, �� ����� ��������, ����� �� ������� �������������� ����
    if l_Name = '' then
      MatchMethod := MM_ALL
    else if l_IsRegExp then
      MatchMethod := MM_REGEXP
    else
      MatchMethod := MM_COMPARE;
    // ������ ���
    Name := l_Name;
  end;
//#UC END# *484FDD22003E_484FA0FD0223_impl*
end;//_atDeleteNamedObjectOperation_.InitMatcher

{$EndIf atDeleteNamedObjectOperation_imp}
