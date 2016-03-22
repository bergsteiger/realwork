unit atQueryExecutor;

// ������: "w:\quality\test\garant6x\AdapterTest\SearchHelpers\atQueryExecutor.pas"
// ���������: "UtilityPack"
// ������� ������: "atQueryExecutor" MUID: (483AD11C02A1)

interface

uses
 l3IntfUses
 , l3_Base
 , SearchUnit
 , BaseTypesUnit
 , DynamicDocListUnit
;

type
 TatQueryExecutor = class(Tl3_Base)
  private
   f_Query: IQuery;
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
   function Execute(const aFiltrateList: IDynList = nil): ISearchEntity; virtual;
 end;//TatQueryExecutor

 IatProgressIndicator = interface
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
 l3ImplUses
 , SearchProgressIndicatorUnit
 , SyncObjs
 , atLogger
 , SysUtils
 , Windows
;

type
 TatProgressIndicator = class(Tl3_Base, IProgressIndicatorForSearch, IatProgressIndicator)
  {* �����, ����������� ��������� IQueryexecuteProgressIndicator. ��� �������� � ����� Query:Execute }
  private
   f_SearchResult: ISearchEntity;
   f_Event: TSimpleEvent;
  protected
   procedure set_current(cur_count: Integer;
    arg: Integer
    {* �������������� ��������. });
    {* ��������� ��������� ����������� ��������.
� �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, ����������� ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %). }
   function Get_max_count: Integer;
   procedure finish_process(const entity: ISearchEntity);
   function Get_SearchResult: ISearchEntity;
   function HasFinished: Boolean;
    {* ���������, ��������� �� ���������� ������� }
   procedure WaitForFinish;
    {* ����� ���������� ���������� ������� }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create; reintroduce; virtual;
   class function Make: IatProgressIndicator; reintroduce;
 end;//TatProgressIndicator

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

{$If NOT Defined(DesignTimeLibrary)}
class function TatQueryExecutor.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_483AD1320001_var*
//#UC END# *47A6FEE600FC_483AD1320001_var*
begin
//#UC START# *47A6FEE600FC_483AD1320001_impl*
  Result := true;
//#UC END# *47A6FEE600FC_483AD1320001_impl*
end;//TatQueryExecutor.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

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
end;//TatProgressIndicator.Make

procedure TatProgressIndicator.set_current(cur_count: Integer;
 arg: Integer
 {* �������������� ��������. });
 {* ��������� ��������� ����������� ��������.
� �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, ����������� ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %). }
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
end;//TatProgressIndicator.set_current

function TatProgressIndicator.Get_max_count: Integer;
//#UC START# *45EEE02703C5_483AD19A008Eget_var*
//#UC END# *45EEE02703C5_483AD19A008Eget_var*
begin
//#UC START# *45EEE02703C5_483AD19A008Eget_impl*
  Result := 100; // ������ ��� �� ����� �������� ��� ���������� � ���������
//#UC END# *45EEE02703C5_483AD19A008Eget_impl*
end;//TatProgressIndicator.Get_max_count

procedure TatProgressIndicator.finish_process(const entity: ISearchEntity);
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
end;//TatProgressIndicator.finish_process

function TatProgressIndicator.Get_SearchResult: ISearchEntity;
//#UC START# *483AD1D1039B_483AD19A008Eget_var*
//#UC END# *483AD1D1039B_483AD19A008Eget_var*
begin
//#UC START# *483AD1D1039B_483AD19A008Eget_impl*
  Result := f_SearchResult;
//#UC END# *483AD1D1039B_483AD19A008Eget_impl*
end;//TatProgressIndicator.Get_SearchResult

function TatProgressIndicator.HasFinished: Boolean;
 {* ���������, ��������� �� ���������� ������� }
//#UC START# *483AD1F1009D_483AD19A008E_var*
//#UC END# *483AD1F1009D_483AD19A008E_var*
begin
//#UC START# *483AD1F1009D_483AD19A008E_impl*
  Result := (f_Event.WaitFor(0) = wrSignaled);
//#UC END# *483AD1F1009D_483AD19A008E_impl*
end;//TatProgressIndicator.HasFinished

procedure TatProgressIndicator.WaitForFinish;
 {* ����� ���������� ���������� ������� }
//#UC START# *483AD202033D_483AD19A008E_var*
//#UC END# *483AD202033D_483AD19A008E_var*
begin
//#UC START# *483AD202033D_483AD19A008E_impl*
  f_Event.WaitFor(INFINITE);
//#UC END# *483AD202033D_483AD19A008E_impl*
end;//TatProgressIndicator.WaitForFinish

{$If NOT Defined(DesignTimeLibrary)}
class function TatProgressIndicator.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_483AD19A008E_var*
//#UC END# *47A6FEE600FC_483AD19A008E_var*
begin
//#UC START# *47A6FEE600FC_483AD19A008E_impl*
  Result := true;
//#UC END# *47A6FEE600FC_483AD19A008E_impl*
end;//TatProgressIndicator.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

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

end.
