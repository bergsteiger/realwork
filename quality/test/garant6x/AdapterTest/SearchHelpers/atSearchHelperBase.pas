unit atSearchHelperBase;

// Модуль: "w:\quality\test\garant6x\AdapterTest\SearchHelpers\atSearchHelperBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSearchHelperBase" MUID: (4B90F31A02F5)

interface

uses
 l3IntfUses
 , l3_Base
 , atQuery
 , SearchUnit
 , DynamicDocListUnit
;

type
 TatSearchHelperBase = {abstract} class(Tl3_Base)
  protected
   f_Query: TatQuery;
   f_Search: ISearch;
  protected
   constructor Create(const aSearch: ISearch); reintroduce; virtual;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   function Execute(out theList: ISearchDynList): Boolean; virtual;
    {* Выполняет поиск.
Возвращает true если результат поиска содержит хотя бы один документ. }
 end;//TatSearchHelperBase

implementation

uses
 l3ImplUses
 , atQueryExecutor
 , SysUtils
 , BaseTypesUnit
 , atUserJournalHelper
;

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
 {* Выполняет поиск.
Возвращает true если результат поиска содержит хотя бы один документ. }
//#UC START# *4B91013A0057_4B90F31A02F5_var*
  var
    l_SearchResult : ISearchEntity;
    l_QueryForJournal : IQuery;
//#UC END# *4B91013A0057_4B90F31A02F5_var*
begin
//#UC START# *4B91013A0057_4B90F31A02F5_impl*
  // предполагается, что запрос корректно сформирован
  // выполняем запрос
  with TatQueryExecutor.Create(f_Query.Query) do
  try
    l_SearchResult := Execute;
  finally
    Free;
  end;
  // проверяем, что что-то нашли
  Result :=
    (l_SearchResult <> nil)
    AND (l_SearchResult.GetResultType = SRT_DOCUMENT_LIST)
    AND (l_SearchResult.GetDocumentCount > 0);
  if Result then
  begin
    if NOT Supports(l_SearchResult, ISearchDynList, theList) then
      Raise Exception.Create('l_SearchResult не поддерживает интерфейс ISearchDynList!');
    //
    f_Query.Query.Clone(l_QueryForJournal);
    TatUserJournalHelper.AddQuery(l_QueryForJournal);
  end;
//#UC END# *4B91013A0057_4B90F31A02F5_impl*
end;//TatSearchHelperBase.Execute

{$If NOT Defined(DesignTimeLibrary)}
class function TatSearchHelperBase.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4B90F31A02F5_var*
//#UC END# *47A6FEE600FC_4B90F31A02F5_var*
begin
//#UC START# *47A6FEE600FC_4B90F31A02F5_impl*
  Result := true;
//#UC END# *47A6FEE600FC_4B90F31A02F5_impl*
end;//TatSearchHelperBase.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

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
