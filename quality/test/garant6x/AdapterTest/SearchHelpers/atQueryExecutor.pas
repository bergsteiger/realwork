unit atQueryExecutor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/SearchHelpers/atQueryExecutor.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x_test::AdapterTest::SearchHelpers::atQueryExecutor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  BaseTypesUnit,
  DynamicDocListUnit,
  SearchUnit,
  l3_Base,
  SyncObjs,
  SearchProgressIndicatorUnit
  ;

type
 TatQueryExecutor = class(Tl3_Base)
 private
 // private fields
   f_Query : IQuery;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aQuery: IQuery); reintroduce;
   function Execute(const aFiltrateList: IDynList = nil): ISearchEntity; virtual;
 end;//TatQueryExecutor

 IatProgressIndicator = interface(IUnknown)
   ['{59BF112D-CDE3-4018-8B4E-20DC822248E9}']
   function Get_SearchResult: ISearchEntity;
   function HasFinished: Boolean;
     {* ���������, ��������� �� ���������� ������� }
   procedure WaitForFinish;
     {* ����� ���������� ���������� ������� }
   property SearchResult: ISearchEntity
     read Get_SearchResult;
     {* ��������� ������ }
 end;//IatProgressIndicator

implementation

uses
  atLogger,
  SysUtils,
  Windows
  ;

type
 TatProgressIndicator = class(Tl3_Base, IProgressIndicatorForSearch, IatProgressIndicator)
  {* �����, ����������� ��������� IQueryexecuteProgressIndicator. ��� �������� � ����� Query:Execute }
 private
 // private fields
   f_SearchResult : ISearchEntity;
   f_Event : TSimpleEvent;
 protected
 // realized methods
   procedure SetCurrent(aCurCount: Integer;
    aArg: Integer
    {* �������������� ��������.}); stdcall;
     {* ��������� ��������� ����������� ��������.
� �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, ����������� ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %). }
   function GetMaxCount: Integer; stdcall;
   procedure FinishProcess(const aEntity: ISearchEntity); stdcall;
   function Get_SearchResult: ISearchEntity;
   function HasFinished: Boolean;
     {* ���������, ��������� �� ���������� ������� }
   procedure WaitForFinish;
     {* ����� ���������� ���������� ������� }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create; reintroduce; virtual;
   class function Make: IatProgressIndicator; reintroduce;
 end;//TatProgressIndicator

// start class TatProgressIndicator

constructor TatProgressIndicator.Create;
//#UC START# *483AD6A203E0_483AD19A008E_var*
//#UC END# *483AD6A203E0_483AD19A008E_var*
begin
//#UC START# *483AD6A203E0_483AD19A008E_impl*
  inherited Create;
  //
  f_Event := TSimpleEvent.Create;
  f_Event.ResetEvent;
//#UC END# *483AD6A203E0_483AD19A008E_impl*
end;//TatProgressIndicator.Create

class function TatProgressIndicator.Make: IatProgressIndicator;
var
 l_Inst : TatProgressIndicator;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TatProgressIndicator.SetCurrent(aCurCount: Integer;
  aArg: Integer
  {* �������������� ��������.});
//#UC START# *45EEE00A025D_483AD19A008E_var*
//#UC END# *45EEE00A025D_483AD19A008E_var*
begin
//#UC START# *45EEE00A025D_483AD19A008E_impl*
  try
    Logger.Info( '���� �����... ��������� %d%%', [aCurCount] );
  except
    on ex : Exception do
    begin
      Logger.Exception(ex, 'TatProgressIndicator.SetCurrent');
      Raise;
    end;
  end;
//#UC END# *45EEE00A025D_483AD19A008E_impl*
end;//TatProgressIndicator.SetCurrent

function TatProgressIndicator.GetMaxCount: Integer;
//#UC START# *45EEE02703C5_483AD19A008Eget_var*
//#UC END# *45EEE02703C5_483AD19A008Eget_var*
begin
//#UC START# *45EEE02703C5_483AD19A008Eget_impl*
  Result := 100; // ������ ��� �� ����� �������� ��� ���������� � ���������
//#UC END# *45EEE02703C5_483AD19A008Eget_impl*
end;//TatProgressIndicator.GetMaxCount

procedure TatProgressIndicator.FinishProcess(const aEntity: ISearchEntity);
//#UC START# *462741D0012E_483AD19A008E_var*
//#UC END# *462741D0012E_483AD19A008E_var*
begin
//#UC START# *462741D0012E_483AD19A008E_impl*
  try
    f_SearchResult := aEntity;
    f_Event.SetEvent;
  except
    on ex : Exception do
    begin
      Logger.Exception(ex, 'TatProgressIndicator.FinishProcess');
      Raise;
    end;
    else
      Raise;
  end;
//#UC END# *462741D0012E_483AD19A008E_impl*
end;//TatProgressIndicator.FinishProcess

function TatProgressIndicator.Get_SearchResult: ISearchEntity;
//#UC START# *483AD1D1039B_483AD19A008Eget_var*
//#UC END# *483AD1D1039B_483AD19A008Eget_var*
begin
//#UC START# *483AD1D1039B_483AD19A008Eget_impl*
  Result := f_SearchResult;
//#UC END# *483AD1D1039B_483AD19A008Eget_impl*
end;//TatProgressIndicator.Get_SearchResult

function TatProgressIndicator.HasFinished: Boolean;
//#UC START# *483AD1F1009D_483AD19A008E_var*
//#UC END# *483AD1F1009D_483AD19A008E_var*
begin
//#UC START# *483AD1F1009D_483AD19A008E_impl*
  Result := (f_Event.WaitFor(0) = wrSignaled);
//#UC END# *483AD1F1009D_483AD19A008E_impl*
end;//TatProgressIndicator.HasFinished

procedure TatProgressIndicator.WaitForFinish;
//#UC START# *483AD202033D_483AD19A008E_var*
//#UC END# *483AD202033D_483AD19A008E_var*
begin
//#UC START# *483AD202033D_483AD19A008E_impl*
  f_Event.WaitFor(INFINITE);
//#UC END# *483AD202033D_483AD19A008E_impl*
end;//TatProgressIndicator.WaitForFinish

{$If not defined(DesignTimeLibrary)}
class function TatProgressIndicator.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_483AD19A008E_var*
//#UC END# *47A6FEE600FC_483AD19A008E_var*
begin
//#UC START# *47A6FEE600FC_483AD19A008E_impl*
  Result := true;
//#UC END# *47A6FEE600FC_483AD19A008E_impl*
end;//TatProgressIndicator.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure TatProgressIndicator.ClearFields;
//#UC START# *5000565C019C_483AD19A008E_var*
//#UC END# *5000565C019C_483AD19A008E_var*
begin
//#UC START# *5000565C019C_483AD19A008E_impl*
  f_SearchResult := nil;
  FreeAndNil(f_Event);
  //
  inherited;
//#UC END# *5000565C019C_483AD19A008E_impl*
end;//TatProgressIndicator.ClearFields
// start class TatQueryExecutor

constructor TatQueryExecutor.Create(const aQuery: IQuery);
//#UC START# *483AD15D03AA_483AD1320001_var*
//#UC END# *483AD15D03AA_483AD1320001_var*
begin
//#UC START# *483AD15D03AA_483AD1320001_impl*
  inherited Create;
  //
  Assert(aQuery <> nil, 'aQuery <> nil');
  f_Query := aQuery;
//#UC END# *483AD15D03AA_483AD1320001_impl*
end;//TatQueryExecutor.Create

function TatQueryExecutor.Execute(const aFiltrateList: IDynList = nil): ISearchEntity;
//#UC START# *483AD178007E_483AD1320001_var*
  var
    l_ProgressIndicator : IatProgressIndicator;
    l_CancelSearch : ICancelSearch;
//#UC END# *483AD178007E_483AD1320001_var*
begin
//#UC START# *483AD178007E_483AD1320001_impl*
  l_ProgressIndicator := TatProgressIndicator.Make;
  // ��������� ���������� �������
  try
    f_Query.Execute(aFiltrateList, l_ProgressIndicator as IProgressIndicatorForSearch, l_CancelSearch);
  except
    on ex : Exception do
    begin
      Logger.Exception(ex, '���������� �� ����� ���������� Query.Execute');
      Raise;
    end;
    else
      Raise;
  end;
  if NOT Assigned(l_CancelSearch) then
    Logger.Warning('l_CancelSearch �� �������� ����� ������ Query.Execute');
  // ���� ��������� ����������
  l_ProgressIndicator.WaitForFinish;
  // � ���������� ���������
  Result := l_ProgressIndicator.SearchResult;
//#UC END# *483AD178007E_483AD1320001_impl*
end;//TatQueryExecutor.Execute

{$If not defined(DesignTimeLibrary)}
class function TatQueryExecutor.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_483AD1320001_var*
//#UC END# *47A6FEE600FC_483AD1320001_var*
begin
//#UC START# *47A6FEE600FC_483AD1320001_impl*
  Result := true;
//#UC END# *47A6FEE600FC_483AD1320001_impl*
end;//TatQueryExecutor.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure TatQueryExecutor.ClearFields;
//#UC START# *5000565C019C_483AD1320001_var*
//#UC END# *5000565C019C_483AD1320001_var*
begin
//#UC START# *5000565C019C_483AD1320001_impl*
  f_Query := nil;
  //
  inherited;
//#UC END# *5000565C019C_483AD1320001_impl*
end;//TatQueryExecutor.ClearFields

end.