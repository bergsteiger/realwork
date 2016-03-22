unit atBaseSearchOperation;

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atBaseSearchOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatBaseSearchOperation" MUID: (483D28C30393)

interface

uses
 l3IntfUses
 , atOperationBase
 , atBaseSearchHelper
 , atStringProvider
;

type
 _atHasStringParamAddOn_Parent_ = TatOperationBase;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atHasStringParamAddOn.imp.pas}
 TatBaseSearchOperation = class(_atHasStringParamAddOn_)
  private
   f_SearchNumber: Integer;
   f_BaseSearchHelper: TatBaseSearchHelper;
  protected
   function OnString(const aString: AnsiString): Boolean; override;
   procedure InitParamList; override;
   procedure ExecuteSelf; override;
   procedure ExecuteChilds; override;
 end;//TatBaseSearchOperation

implementation

uses
 l3ImplUses
 , SysUtils
 , atLogger
 , atSyncedStringFileReader
 , atStringFileReader
 , atConstStringProvider
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atHasStringParamAddOn.imp.pas}

function TatBaseSearchOperation.OnString(const aString: AnsiString): Boolean;
//#UC START# *503648620273_483D28C30393_var*
//#UC END# *503648620273_483D28C30393_var*
begin
//#UC START# *503648620273_483D28C30393_impl*
  Result := true;
  //
  Inc(f_SearchNumber);
  Logger.Info('����� � %d. ��������� �������� "%s" �� ����������.', [f_SearchNumber, aString]);
  // ��������
  f_BaseSearchHelper.Context := aString;

  if (f_BaseSearchHelper.InvalidWords <> '') then
  begin // �������� ������, ��������
    Logger.Error('����� ���������� ��������! ������ ������������ ����: "%s". ����������������� ��������: "%s".',
      [f_BaseSearchHelper.InvalidWords, f_BaseSearchHelper.CorrectedContext]
    );
  end
  else
  begin // �������� �������, ����
    f_BaseSearchHelper.Context := f_BaseSearchHelper.CorrectedContext;
    // ��������� ����� � ������������ ���������
    Logger.Info('�������� ��������. �������� �����. ��������: %s. ��� �������� ����������: %s.', [f_BaseSearchHelper.Context, f_BaseSearchHelper.InfoKind]);
    if f_BaseSearchHelper.ExecuteAndBuildList then
    begin
      ExecutionContext.UserWorkContext.AddListToHistory(f_BaseSearchHelper.List);
      // �������� �����
      inherited ExecuteChilds;
    end;
  end;  
//#UC END# *503648620273_483D28C30393_impl*
end;//TatBaseSearchOperation.OnString

procedure TatBaseSearchOperation.InitParamList;
//#UC START# *48089F3701B4_483D28C30393_var*
//#UC END# *48089F3701B4_483D28C30393_var*
begin
//#UC START# *48089F3701B4_483D28C30393_impl*
  inherited;
  with f_ParamList do
  begin
    AddAlias('str.value', 'query_text'); // ����� �������
    AddAlias('str.file', 'query_text_file_name'); // ���� � �������� �������
    AddAlias('str.max_count', 'from_file_searches_count'); // ������� ������ �������
    AddAlias('str.is_random', 'is_random_context'); // ������������ ��������� �������� �� �����
    //
    Add( ParamType.Create('info_kind', '��� �������� ����������', '��� ���������') );
    Add( ParamType.Create('is_short_list', '�������� �������� ������', 'false') );
  end;
//#UC END# *48089F3701B4_483D28C30393_impl*
end;//TatBaseSearchOperation.InitParamList

procedure TatBaseSearchOperation.ExecuteSelf;
//#UC START# *48089F460352_483D28C30393_var*
  var
    l_InfoKindStr  : String;
    l_IsShortList : Boolean;
//#UC END# *48089F460352_483D28C30393_var*
begin
//#UC START# *48089F460352_483D28C30393_impl*
  l_InfoKindStr := Parameters['info_kind'].AsStr;
  l_IsShortList := Parameters['is_short_list'].AsBool;
  //
  f_BaseSearchHelper := TatBaseSearchHelper.Create();
  try
    // ������������� ��������� ������
    // ��� �������� ����������
    try
      f_BaseSearchHelper.InfoKind := l_InfoKindStr;
    except
      on EUnknownInfoKind do
      begin
        Logger.Error('������ ����������� ��� �������� ����������: "%s"', [l_InfoKindStr]);
        Exit;
      end;
    end;
    // �������� ������
    f_BaseSearchHelper.IsShortList := l_IsShortList;

    f_SearchNumber := 0;

    //
    inherited;
  finally
    FreeAndNil(f_BaseSearchHelper);
  end;
//#UC END# *48089F460352_483D28C30393_impl*
end;//TatBaseSearchOperation.ExecuteSelf

procedure TatBaseSearchOperation.ExecuteChilds;
//#UC START# *48089F660238_483D28C30393_var*
//#UC END# *48089F660238_483D28C30393_var*
begin
//#UC START# *48089F660238_483D28C30393_impl*
  // ���� ���������� ���� � ExecuteSelf
//#UC END# *48089F660238_483D28C30393_impl*
end;//TatBaseSearchOperation.ExecuteChilds

end.
