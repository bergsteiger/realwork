unit atGetCRListFromDocumentOperation;
 {* �������� � �������� ��������� ������ ���������������/������������ �������� ��������� }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atGetCRListFromDocumentOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatGetCRListFromDocumentOperation" MUID: (4A4CA0DD02F9)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatGetCRListFromDocumentOperation = class(TatOperationBase)
  {* �������� � �������� ��������� ������ ���������������/������������ �������� ��������� }
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
   procedure ExecuteChilds; override;
 end;//TatGetCRListFromDocumentOperation

implementation

uses
 l3ImplUses
 , DynamicTreeUnit
 , DynamicDocListUnit
 , SysUtils
 , atLogger
 , BaseTypesUnit
 , atListHelper
 , atNodeHelper
;

procedure TatGetCRListFromDocumentOperation.ExecuteSelf;
//#UC START# *48089F460352_4A4CA0DD02F9_var*
  type
    TatListType = (CORRESPONDENT, RESPONDENT);
  var
    l_CRTypeName : String;
    l_CorR : String;
    l_ListTypeName : String;
    l_ListType : TatListType;
    l_CatalogBase : ICatalogBase;
    l_DynList : IDynList;
    l_CategoryNode, l_ListRoot : INodeBase;
    l_HasFound : Boolean;
//#UC END# *48089F460352_4A4CA0DD02F9_var*
begin
//#UC START# *48089F460352_4A4CA0DD02F9_impl*
  inherited;
  l_CRTypeName := Parameters['cr_type_name'].AsStr;
  l_CorR := Parameters['c_or_r'].AsStr;
  // ���� ���� ���� ���
  if AnsiSameText(l_CRTypeName, '��� ���������') then
    l_CategoryNode := nil
  else
  begin
    l_CategoryNode := TatNodeHelper.FindNodeByPath(
      ExecutionContext.GblAdapterWorker.CRTreeRoot,
      l_CRTypeName, '\', true, true);
      if l_CategoryNode = nil then
      begin
        Logger.Error('�� ������� �������� ���� ��� ���� ���������������/������������: %s!', [l_CRTypeName]);
        Exit;
      end;
  end;
  // ������ ��� ������
  if AnsiSameText(l_CorR, 'c') then l_ListType := CORRESPONDENT
  else if AnsiSameText(l_CorR, 'r') then l_ListType := RESPONDENT
  else
  begin
    Logger.Error('����������� ��� �������: %s!', [l_CorR]);
    Exit;
  end;
  case l_ListType of
    CORRESPONDENT : l_ListTypeName := '���������������';
    RESPONDENT    : l_ListTypeName := '������������';
  end;
  // �������� ������
  Assert(ExecutionContext.UserWorkContext.CurrDoc <> nil, 'ExecutionContext.UserWorkContext.CurrDoc <> nil');
  Logger.Info('�������� ������ %s ���� "%s" � ��������� %d', [l_ListTypeName, l_CRTypeName, ExecutionContext.UserWorkContext.CurrDoc.GetInternalId()]);
  //
  l_HasFound := false;
  try
    with ExecutionContext.UserWorkContext.CurrDoc do
      case l_ListType of
        CORRESPONDENT :
          if HasCorrespondents(l_CategoryNode) then
            GetCorrespondents(l_CategoryNode, l_CatalogBase);
        RESPONDENT    :
          if HasRespondents(l_CategoryNode) then
            GetRespondents(l_CategoryNode, l_CatalogBase);
      end;
    l_HasFound := (l_CatalogBase <> nil);
  except
    on ECanNotFindData do
      l_HasFound := false;
  end;
  //
  if l_HasFound then
  begin
    Assert(l_CatalogBase <> nil, 'l_CatalogBase <> nil');
    if Supports(l_CatalogBase, IDynList, l_DynList) then
    begin
      try
        l_DynList.GetRoot(l_ListRoot);
      except
        on ECanNotFindData do
        begin
          Logger.Info('������, � ������������� ��������� ��� ������� ��������� ����������� ��������������/����������� ������� ����');
          Exit;
        end;
      end;
      Assert(l_ListRoot <> nil, 'l_ListRoot <> nil');
      //
      TatListHelper.LoadList(l_DynList, 10);
      //
      Logger.Info('�������� ������ %s. � ��� %d ����������', [l_ListTypeName, l_ListRoot.GetChildCount]);
      ExecutionContext.UserWorkContext.AddListToHistory(l_DynList);
      // �������� �����
      inherited ExecuteChilds;
    end
    else
      Logger.Error('�� ���� �������� IDynList');
  end
  else
    Logger.Info('� ��������� ��� %s ���� %s' , [l_ListTypeName, l_CRTypeName]);
//#UC END# *48089F460352_4A4CA0DD02F9_impl*
end;//TatGetCRListFromDocumentOperation.ExecuteSelf

procedure TatGetCRListFromDocumentOperation.InitParamList;
//#UC START# *48089F3701B4_4A4CA0DD02F9_var*
//#UC END# *48089F3701B4_4A4CA0DD02F9_var*
begin
//#UC START# *48089F3701B4_4A4CA0DD02F9_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('cr_type_name', '��� ���������������/������������', '��� ���������') );
    Add( ParamType.Create('c_or_r', '�������������� ��� �����������') );
  end;
//#UC END# *48089F3701B4_4A4CA0DD02F9_impl*
end;//TatGetCRListFromDocumentOperation.InitParamList

procedure TatGetCRListFromDocumentOperation.ExecuteChilds;
//#UC START# *48089F660238_4A4CA0DD02F9_var*
//#UC END# *48089F660238_4A4CA0DD02F9_var*
begin
//#UC START# *48089F660238_4A4CA0DD02F9_impl*
  // ���� ����������� ���� � ExecuteSelf
//#UC END# *48089F660238_4A4CA0DD02F9_impl*
end;//TatGetCRListFromDocumentOperation.ExecuteChilds

end.
