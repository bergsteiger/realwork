unit atSearchHelperBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/SearchHelpers/atSearchHelperBase.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::SearchHelpers::TatSearchHelperBase
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  DynamicDocListUnit,
  SearchUnit,
  l3_Base,
  atQuery
  ;

type
 TatSearchHelperBase = {abstract} class(Tl3_Base)
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 protected
 // protected fields
   f_Query : TatQuery;
   f_Search : ISearch;
 protected
 // protected methods
   constructor Create(const aSearch: ISearch); reintroduce; virtual;
 public
 // public methods
   function Execute(out theList: ISearchDynList): Boolean; virtual;
     {* ��������� �����.
���������� true ���� ��������� ������ �������� ���� �� ���� ��������. }
 end;//TatSearchHelperBase

implementation

uses
  atQueryExecutor,
  SysUtils,
  BaseTypesUnit,
  atUserJournalHelper
  ;

// start class TatSearchHelperBase

constructor TatSearchHelperBase.Create(const aSearch: ISearch);
//#UC START# *4B910130021C_4B90F31A02F5_var*
//#UC END# *4B910130021C_4B90F31A02F5_var*
begin
//#UC START# *4B910130021C_4B90F31A02F5_impl*
  inherited Create;
  //
  Assert(aSearch <> nil, 'aSearch <> nil');
  f_Search := aSearch;
//#UC END# *4B910130021C_4B90F31A02F5_impl*
end;//TatSearchHelperBase.Create

function TatSearchHelperBase.Execute(out theList: ISearchDynList): Boolean;
//#UC START# *4B91013A0057_4B90F31A02F5_var*
  var
    l_SearchResult : ISearchEntity;
    l_QueryForJournal : IQuery;
//#UC END# *4B91013A0057_4B90F31A02F5_var*
begin
//#UC START# *4B91013A0057_4B90F31A02F5_impl*
  // ��������������, ��� ������ ��������� �����������
  // ��������� ������
  with TatQueryExecutor.Create(f_Query.Query) do
  try
    l_SearchResult := Execute;
  finally
    Free;
  end;
  // ���������, ��� ���-�� �����
  Result :=
    (l_SearchResult <> nil)
    AND (l_SearchResult.GetResultType = SRT_DOCUMENT_LIST)
    AND (l_SearchResult.GetDocumentCount > 0);
  if Result then
  begin
    if NOT Supports(l_SearchResult, ISearchDynList, theList) then
      Raise Exception.Create('l_SearchResult �� ������������ ��������� ISearchDynList!');
    //
    f_Query.Query.Clone(l_QueryForJournal);
    TatUserJournalHelper.AddQuery(l_QueryForJournal);
  end;
//#UC END# *4B91013A0057_4B90F31A02F5_impl*
end;//TatSearchHelperBase.Execute

{$If not defined(DesignTimeLibrary)}
class function TatSearchHelperBase.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4B90F31A02F5_var*
//#UC END# *47A6FEE600FC_4B90F31A02F5_var*
begin
//#UC START# *47A6FEE600FC_4B90F31A02F5_impl*
  Result := true;
//#UC END# *47A6FEE600FC_4B90F31A02F5_impl*
end;//TatSearchHelperBase.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure TatSearchHelperBase.ClearFields;
//#UC START# *5000565C019C_4B90F31A02F5_var*
//#UC END# *5000565C019C_4B90F31A02F5_var*
begin
//#UC START# *5000565C019C_4B90F31A02F5_impl*
  FreeAndNil(f_Query);
  f_Search := nil;
  //
  inherited;
//#UC END# *5000565C019C_4B90F31A02F5_impl*
end;//TatSearchHelperBase.ClearFields

end.