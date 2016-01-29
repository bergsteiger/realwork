{$IfNDef atExecutesQueryAddOn_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atExecutesQueryAddOn.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atExecutesQueryAddOn
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atExecutesQueryAddOn_imp}
 _atExecutesQueryAddOn_ = {mixin} class(_atExecutesQueryAddOn_Parent_)
 protected
 // protected methods
   function ExecuteQuery(const anQuery: TatQuery): Boolean; overload;  virtual;
   function ExecuteQuery(const anQuery: IQuery): Boolean; overload;  virtual;
 end;//_atExecutesQueryAddOn_

{$Else atExecutesQueryAddOn_imp}

// start class _atExecutesQueryAddOn_

function _atExecutesQueryAddOn_.ExecuteQuery(const anQuery: TatQuery): Boolean;
//#UC START# *502A7A0A03E7_502A79B80186_var*
//#UC END# *502A7A0A03E7_502A79B80186_var*
begin
//#UC START# *502A7A0A03E7_502A79B80186_impl*
  Result := false;
  //
  if anQuery.Name <> '' then
    Logger.Info('��������� ������ � ������ "%s"', [anQuery.Name]);
  //  
  with TatSearchHelper.Create(anQuery.Use) do // .Use ������ ��� ��������, ��� TatSearchHelper ���������� owner'�� ������� � ������ ���, � ��� �� �����, �.�. ����� ���������� ��� ������ ������ � ��� ��� ��������� � ��� ������
  try
    if ExecuteAndBuildList then
    begin
      ExecutionContext.UserWorkContext.AddListToHistory(List);
      Result := true;
    end;
  finally
    Free;
  end;
//#UC END# *502A7A0A03E7_502A79B80186_impl*
end;//_atExecutesQueryAddOn_.ExecuteQuery

function _atExecutesQueryAddOn_.ExecuteQuery(const anQuery: IQuery): Boolean;
//#UC START# *502A7A4701EC_502A79B80186_var*
  var
    l_Query : TatQuery;
//#UC END# *502A7A4701EC_502A79B80186_var*
begin
//#UC START# *502A7A4701EC_502A79B80186_impl*
  l_Query := TatQuery.Create(anQuery);
  try
    Result := ExecuteQuery(l_Query);
  finally
    FreeAndNil(l_Query);
  end;
//#UC END# *502A7A4701EC_502A79B80186_impl*
end;//_atExecutesQueryAddOn_.ExecuteQuery

{$EndIf atExecutesQueryAddOn_imp}
