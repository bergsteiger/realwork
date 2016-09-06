unit atBaseSearchHelper;
 {*  ласс, дл€ проведени€ базового поиска }

// ћодуль: "w:\quality\test\garant6x\AdapterTest\SearchHelpers\atBaseSearchHelper.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TatBaseSearchHelper" MUID: (483C01430224)

interface

uses
 l3IntfUses
 , atSearchHelper
;

type
 EUnknownInfoKind = class
 end;//EUnknownInfoKind

 TatBaseSearchHelper = class(TatSearchHelper)
  {*  ласс, дл€ проведени€ базового поиска }
  private
   f_Context: AnsiString;
    {*  онтекст, который будем искать }
   f_InfoKind: AnsiString;
    {* “ип информации, которую будем искать }
   f_InvalidWords: AnsiString;
    {* —трока со словами из запроса, которые нельз€ использовать }
   f_CorrectedContext: AnsiString;
    {* —корректированный контекст }
   f_IsShortList: Boolean;
  private
   procedure CheckContext; virtual;
    {* провер€ет контекст на валидность }
  protected
   procedure pm_SetContext(const aValue: AnsiString);
   procedure pm_SetInfoKind(const aValue: AnsiString);
   procedure pm_SetIsShortList(aValue: Boolean);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce; virtual;
  public
   property Context: AnsiString
    read f_Context
    write pm_SetContext;
    {*  онтекст, который будем искать }
   property InfoKind: AnsiString
    read f_InfoKind
    write pm_SetInfoKind;
    {* “ип информации, которую будем искать }
   property InvalidWords: AnsiString
    read f_InvalidWords;
    {* —трока со словами из запроса, которые нельз€ использовать }
   property CorrectedContext: AnsiString
    read f_CorrectedContext;
    {* —корректированный контекст }
   property IsShortList: Boolean
    read f_IsShortList
    write pm_SetIsShortList;
 end;//TatBaseSearchHelper

implementation

uses
 l3ImplUses
 , IOUnit
 , StrUtils
 , DynamicTreeUnit
 , SysUtils
 , atGblAdapterWorker
 , atQuery
 , atStringHelper
 , SearchUnit
 , atNodeHelper
 //#UC START# *483C01430224impl_uses*
 //#UC END# *483C01430224impl_uses*
;

procedure TatBaseSearchHelper.pm_SetContext(const aValue: AnsiString);
//#UC START# *483C06250290_483C01430224set_var*
  const
    TAG = 'AT_TEXT_BODY';
//#UC END# *483C06250290_483C01430224set_var*
begin
//#UC START# *483C06250290_483C01430224set_impl*
  if (aValue <> f_Context) then
  begin
    f_Context := aValue;
    //
    f_Query.ClearAttribute(TAG);
    //
    if (f_Context <> '') then
    begin
      f_Query.SaveContextAttribute(TAG, QLO_AND, f_Context);
      // выполн€ем проверку контекста на валидность
      if (f_Context <> f_CorrectedContext) then
        CheckContext;
    end;
  end;  
//#UC END# *483C06250290_483C01430224set_impl*
end;//TatBaseSearchHelper.pm_SetContext

procedure TatBaseSearchHelper.pm_SetInfoKind(const aValue: AnsiString);
//#UC START# *483C064C02DE_483C01430224set_var*
  const
    TAG = AT_BASE_SEARCH_PANES;
  var
    l_Node, l_Root : INodeBase;
    l_Iter : INodeIterator;
//#UC END# *483C064C02DE_483C01430224set_var*
begin
//#UC START# *483C064C02DE_483C01430224set_impl*
  if (aValue <> f_InfoKind) then
  begin
    // ищем нужную ноду
    TatGblAdapterWorker.Instance.GblAdapterDll.MakeMainMenu.GetBaseSearchPanes(l_Root);

    l_Root.IterateNodes(FM_SHARED_NONE, l_Iter);
    repeat
      l_Iter.GetNext(l_Node);
    until (l_Node = nil) OR (AnsiCompareText(TatNodeHelper.GetCaption(l_Node), aValue) = 0);
    //
    if l_Node = nil then
      Raise EUnknownInfoKind.Create();

    // нашли ноду, пихаем ее в запрос
    f_Query.ClearAttribute(TAG);
    f_InfoKind := aValue;
    f_Query.SaveNodeAttribute(TAG, QLO_OR, l_Node);
  end;
//#UC END# *483C064C02DE_483C01430224set_impl*
end;//TatBaseSearchHelper.pm_SetInfoKind

procedure TatBaseSearchHelper.pm_SetIsShortList(aValue: Boolean);
//#UC START# *4B57077C01F1_483C01430224set_var*
  const
    TAG = 'AT_SHORT_LIST';
  var
    l_AttrInfo : IAttributeInfo;
    l_Attr: IQueryAttribute;
    l_Context: IQueryContextAttribute;
    l_List: IContextValueList;
    l_Value: TContextValue;
//#UC END# *4B57077C01F1_483C01430224set_var*
begin
//#UC START# *4B57077C01F1_483C01430224set_impl*
  if (aValue <> f_IsShortList) then
  begin
    f_IsShortList := aValue;
    //
    f_Query.ClearAttribute(TAG);
    // делаем что-то только если надо установить признак
    if (f_IsShortList) then
    begin
      f_Search.GetAttributeInfo(TAG, l_AttrInfo);
      l_AttrInfo.GetDefaultValue(l_Attr);
      if Supports(l_Attr, IQueryContextAttribute, l_Context) then
      begin
        l_Context.GetValues(l_List);
        if (l_List.Count > 0) then
        begin
          l_List.pm_GetItem(0, l_Value);
          //
          f_Query.SaveContextAttribute(TAG, l_Value.rOperation, l_Value.rContext.GetData);
        end;
      end;
    end;
  end;
//#UC END# *4B57077C01F1_483C01430224set_impl*
end;//TatBaseSearchHelper.pm_SetIsShortList

procedure TatBaseSearchHelper.CheckContext;
 {* провер€ет контекст на валидность }
//#UC START# *48A448300134_483C01430224_var*
  const
    DELIMITER = ', ';
  var
    l_IncorrectWordList, l_ContextWL, l_CorrectedContextWL : IContextWordList;
    i : Integer;
    l_Word : IString;
//#UC END# *48A448300134_483C01430224_var*
begin
//#UC START# *48A448300134_483C01430224_impl*
  f_CorrectedContext := '';
  f_InvalidWords := '';
  if (Context = '') then Exit;
  //
  l_ContextWL := TatGblAdapterWorker.Instance.GblAdapterDll.MakeContextWordList;
  l_ContextWL.Add( TatStringHelper.DStr2AStr(f_Context) );
  //
  f_Search.CorrectContext(l_ContextWL, false, l_CorrectedContextWL, l_IncorrectWordList);
  // составл€ем список неправильных слов
  if Assigned(l_IncorrectWordList) AND (l_IncorrectWordList.Count > 0) then
  begin
    for i := 0 to l_IncorrectWordList.Count-1 do
    begin
      l_IncorrectWordList.pm_GetItem(i, l_Word);
      f_InvalidWords := f_InvalidWords + l_Word.GetData + DELIMITER;
    end;
    f_InvalidWords := LeftStr(f_InvalidWords, Length(f_InvalidWords) - Length(DELIMITER));
  end;
  // скорректированный контекст
  if Assigned(l_CorrectedContextWL) then
  begin
    f_CorrectedContext := '';
    for i := 0 to l_CorrectedContextWL.Count-1 do
    begin
      l_CorrectedContextWL.pm_GetItem(i, l_Word);
      f_CorrectedContext := f_CorrectedContext + l_Word.GetData;
    end;
  end
  else
    f_CorrectedContext := '';
//#UC END# *48A448300134_483C01430224_impl*
end;//TatBaseSearchHelper.CheckContext

constructor TatBaseSearchHelper.Create;
//#UC START# *4FC8D877000A_483C01430224_var*
//#UC END# *4FC8D877000A_483C01430224_var*
begin
//#UC START# *4FC8D877000A_483C01430224_impl*
  inherited Create(TatQuery.CreateByType(QT_BASE_SEARCH));
  //
  InfoKind := '¬се документы';
  Context := '';
  IsShortList := false;
//#UC END# *4FC8D877000A_483C01430224_impl*
end;//TatBaseSearchHelper.Create

procedure TatBaseSearchHelper.ClearFields;
begin
 Context := '';
 InfoKind := '';
 f_InvalidWords := '';
 f_CorrectedContext := '';
 inherited;
end;//TatBaseSearchHelper.ClearFields

end.
