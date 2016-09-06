unit atSortListOperation;
 {* ��������� ������� ������ ���������� }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atSortListOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatSortListOperation" MUID: (4A4CDBBD01E5)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatSortListOperation = class(TatOperationBase)
  {* ��������� ������� ������ ���������� }
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatSortListOperation

implementation

uses
 l3ImplUses
 , DynamicDocListUnit
 , atLogger
 , BaseTypesUnit
 , atListHelper
 //#UC START# *4A4CDBBD01E5impl_uses*
 //#UC END# *4A4CDBBD01E5impl_uses*
;

procedure TatSortListOperation.ExecuteSelf;
//#UC START# *48089F460352_4A4CDBBD01E5_var*
  var
    l_SortOrderName, l_SortTypeName : String;
    l_CurrSortOrder, l_SortOrder : TSortOrder;
    l_CurrSortType, l_SortType : TSortType;
    l_SortParams : TSortParams;
    l_DynList : IDynList;
//#UC END# *48089F460352_4A4CDBBD01E5_var*
begin
//#UC START# *48089F460352_4A4CDBBD01E5_impl*
  inherited;
  l_SortOrderName := Parameters['sort_order'].AsStr;
  l_SortTypeName := Parameters['sort_type'].AsStr;
  //
  if NOT TatListHelper.Str2ST(l_SortTypeName, l_SortType) then
  begin
    Logger.Error('����������� ��� ����������: %s', [l_SortTypeName]);
    Exit;
  end;
  if NOT TatListHelper.Str2SO(l_SortOrderName, l_SortOrder) then
  begin
    Logger.Error('����������� ����������� ����������: %s', [l_SortOrderName]);
    Exit;
  end;
  //
  l_DynList := ExecutionContext.UserWorkContext.CurrList;
  Assert(l_DynList <> nil, 'l_DynList <> nil');
  //
  if NOT TatListHelper.IsCanBeSortedBy(l_DynList, l_SortType) then
  begin
    Logger.Error('� ������ �� ����� ���� �������� ��� ���������� %s', [TatListHelper.ST2Str(l_SortType)]);
    Exit;
  end;
  //
  l_DynList.GetCurrentSortParams(l_SortParams);
  l_CurrSortType := l_SortParams.rSortType;
  l_CurrSortOrder := l_SortParams.rSortOrder;
  Logger.Info('������� ��� ���������� ������: "%s", �����������: "%s"',
    [TatListHelper.ST2Str(l_CurrSortType), TatListHelper.SO2Str(l_CurrSortOrder)]);
  //
  if (l_SortType <> l_CurrSortType) OR (l_SortOrder <> l_CurrSortOrder) then
  begin
    Logger.Info('��������� ������ �� ���� "%s" � ����������� "%s"',
      [TatListHelper.ST2Str(l_SortType), TatListHelper.SO2Str(l_SortOrder)]);
    l_SortParams.rSortOrder := l_SortOrder;
    l_SortParams.rSortType :=  l_SortType;
    l_DynList.Sort(l_SortParams);
    Logger.Info('������ ������������');
  end
  else
    Logger.Info('������ ��� ������������ ������ �������. ������ �� ������');
//#UC END# *48089F460352_4A4CDBBD01E5_impl*
end;//TatSortListOperation.ExecuteSelf

procedure TatSortListOperation.InitParamList;
//#UC START# *48089F3701B4_4A4CDBBD01E5_var*
//#UC END# *48089F3701B4_4A4CDBBD01E5_var*
begin
//#UC START# *48089F3701B4_4A4CDBBD01E5_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('sort_order', '������� ����������') );
    Add( ParamType.Create('sort_type', '��� ����������') );
  end;
//#UC END# *48089F3701B4_4A4CDBBD01E5_impl*
end;//TatSortListOperation.InitParamList

end.
