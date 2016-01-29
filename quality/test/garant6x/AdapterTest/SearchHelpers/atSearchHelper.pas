unit atSearchHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/SearchHelpers/atSearchHelper.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::SearchHelpers::TatSearchHelper
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  DynamicDocListUnit,
  atQuery,
  atSearchHelperBase
  ;

type
 TatSearchHelper = class(TatSearchHelperBase)
 private
 // private fields
   f_List : IDynList;
    {* ���� ��� �������� List}
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(aQuery: TatQuery); reintroduce; virtual;
   function ExecuteAndBuildList: Boolean; virtual;
 public
 // public properties
   property List: IDynList
     read f_List;
 end;//TatSearchHelper

implementation

uses
  atGblAdapterWorker,
  atLogger,
  DynamicTreeUnit,
  SysUtils
  ;

// start class TatSearchHelper

constructor TatSearchHelper.Create(aQuery: TatQuery);
//#UC START# *4FC8DA650160_4FC8DA4E01A4_var*
//#UC END# *4FC8DA650160_4FC8DA4E01A4_var*
begin
//#UC START# *4FC8DA650160_4FC8DA4E01A4_impl*
  inherited Create(TatGblAdapterWorker.Instance.GblAdapterDll.MakeSearch);
  f_Query := aQuery;
//#UC END# *4FC8DA650160_4FC8DA4E01A4_impl*
end;//TatSearchHelper.Create

function TatSearchHelper.ExecuteAndBuildList: Boolean;
//#UC START# *4FC8DAD402EF_4FC8DA4E01A4_var*
  var
    l_SearchResult : ISearchDynList;
    l_Root, l_Child : INodeBase;
//#UC END# *4FC8DAD402EF_4FC8DA4E01A4_var*
begin
//#UC START# *4FC8DAD402EF_4FC8DA4E01A4_impl*
  Logger.Info('�������� �����');
  if Execute(l_SearchResult) then
  begin
    Logger.Info( '������� %d ����������, %d ���������, %d ��������',
      [l_SearchResult.GetDocumentCount, l_SearchResult.GetEntryCount, l_SearchResult.GetEditionCount] );
    // ��������� ������
    l_SearchResult.GetDynList(f_List);
    Assert(f_List <> nil, 'f_List <> nil');
    f_List.GetRoot(l_Root);
    l_Root.GetFirstChild(l_Child);
    //
    Result := true;
  end
  else
  begin
    Logger.Info('������ �� �������');
    Result := false;
  end;
//#UC END# *4FC8DAD402EF_4FC8DA4E01A4_impl*
end;//TatSearchHelper.ExecuteAndBuildList

procedure TatSearchHelper.ClearFields;
 {-}
begin
 f_List := nil;
 inherited;
end;//TatSearchHelper.ClearFields

end.