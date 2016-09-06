unit atSearchHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\SearchHelpers\atSearchHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSearchHelper" MUID: (4FC8DA4E01A4)

interface

uses
 l3IntfUses
 , atSearchHelperBase
 , DynamicDocListUnit
 , atQuery
;

type
 TatSearchHelper = class(TatSearchHelperBase)
  private
   f_List: IDynList;
  protected
   procedure ClearFields; override;
  public
   constructor Create(aQuery: TatQuery); reintroduce; virtual;
   function ExecuteAndBuildList: Boolean; virtual;
  public
   property List: IDynList
    read f_List;
 end;//TatSearchHelper

implementation

uses
 l3ImplUses
 , atGblAdapterWorker
 , atLogger
 , DynamicTreeUnit
 , SysUtils
 //#UC START# *4FC8DA4E01A4impl_uses*
 //#UC END# *4FC8DA4E01A4impl_uses*
;

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
  Logger.Info('Начинаем поиск');
  if Execute(l_SearchResult) then
  begin
    Logger.Info( 'Найдено %d документов, %d вхождений, %d редакций',
      [l_SearchResult.GetDocumentCount, l_SearchResult.GetEntryCount, l_SearchResult.GetEditionCount] );
    // открываем список
    l_SearchResult.GetDynList(f_List);
    Assert(f_List <> nil, 'f_List <> nil');
    f_List.GetRoot(l_Root);
    l_Root.GetFirstChild(l_Child);
    //
    Result := true;
  end
  else
  begin
    Logger.Info('Ничего не найдено');
    Result := false;
  end;
//#UC END# *4FC8DAD402EF_4FC8DA4E01A4_impl*
end;//TatSearchHelper.ExecuteAndBuildList

procedure TatSearchHelper.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TatSearchHelper.ClearFields

end.
