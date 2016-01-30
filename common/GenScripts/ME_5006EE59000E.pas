unit atIterateUserJournalOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atIterateUserJournalOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
 , atQuery
 , atUserJournalHelper
;

type
 TatIterateUserJournalOperation = {abstract} class(TatOperationBase)
  protected
   function OnQuery(const anQuery: TatQuery): Boolean; virtual; abstract;
   function OnBookmark(const aBookmark: TatJournalBookmark): Boolean; virtual; abstract;
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
   procedure ExecuteChilds; override;
 end;//TatIterateUserJournalOperation

implementation

uses
 l3ImplUses
 , Contnrs
 , SysUtils
 , atLogger
;

procedure TatIterateUserJournalOperation.ExecuteSelf;
//#UC START# *48089F460352_5006EE59000E_var*
  var
    l_Entities : TObjectList;
    i : Integer;
    l_Date : System.TDateTime;
    l_StrDate : String;
    l_IsExecuteChilds : Boolean;
//#UC END# *48089F460352_5006EE59000E_var*
begin
//#UC START# *48089F460352_5006EE59000E_impl*
  l_StrDate := Parameters['date'].AsStr;
  if l_StrDate = '' then
    l_Date := 0
  else
    try
      l_Date := StrToDate(l_StrDate);
    except
      on EConvertError do
      begin
        Logger.Error('Неверный формат даты: %s', [l_StrDate]);
        Exit;
      end;
    end;

  //
  l_Entities := TatUserJournalHelper.GetElements(l_Date);
  try
    Logger.Info('Открываем %d сохраненных в журнал работы эелментов', [l_Entities.Count]);
    //
    for i := l_Entities.Count-1 downto 0 do
    begin
      if (l_Entities[i] is TatJournalBookmark) then
        l_IsExecuteChilds := OnBookmark(l_Entities[i] as TatJournalBookmark)
      else if (l_Entities[i] is TatQuery) then
        l_IsExecuteChilds := OnQuery(l_Entities[i] as TatQuery);

      if l_IsExecuteChilds then
        ExecuteChilds;
    end;
  finally
    FreeAndNil(l_Entities);
  end;
//#UC END# *48089F460352_5006EE59000E_impl*
end;//TatIterateUserJournalOperation.ExecuteSelf

procedure TatIterateUserJournalOperation.InitParamList;
//#UC START# *48089F3701B4_5006EE59000E_var*
//#UC END# *48089F3701B4_5006EE59000E_var*
begin
//#UC START# *48089F3701B4_5006EE59000E_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('date', 'Обрабатывать элементы, сохраненные не ранее этой даты', '') );
  end;
//#UC END# *48089F3701B4_5006EE59000E_impl*
end;//TatIterateUserJournalOperation.InitParamList

procedure TatIterateUserJournalOperation.ExecuteChilds;
//#UC START# *48089F660238_5006EE59000E_var*
//#UC END# *48089F660238_5006EE59000E_var*
begin
//#UC START# *48089F660238_5006EE59000E_impl*
  //
//#UC END# *48089F660238_5006EE59000E_impl*
end;//TatIterateUserJournalOperation.ExecuteChilds

end.
