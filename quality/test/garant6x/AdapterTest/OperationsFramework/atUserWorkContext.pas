unit atUserWorkContext;

// ћодуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atUserWorkContext.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TatUserWorkContext" MUID: (4808672500A0)

interface

uses
 l3IntfUses
 , DocumentUnit
 , DynamicDocListUnit
 , atDocumentHistory
 , atListHistory
 , FoldersUnit
;

type
 TatUserWorkContext = class(TObject)
  private
   f_DocumentHistory: TatDocumentHistory;
   f_ListHistory: TatListHistory;
   f_CurrFolder: IFoldersNode;
    {* “екуща€ папка. Ќапример, операци€ создани€ папки будет ее устанавливать, а операци€ сохранени€ закладки сможет туда сохранить закладку. }
  protected
   function pm_GetDocHistoryLength: Integer;
   procedure pm_SetDocHistoryLength(aValue: Integer);
   function pm_GetListHistoryLength: Integer;
   procedure pm_SetListHistoryLength(aValue: Integer);
   function pm_GetCurrDoc: IDocument;
   function pm_GetCurrList: IDynList;
   procedure pm_SetCurrFolder(const aValue: IFoldersNode); virtual;
  public
   constructor Create; reintroduce;
   procedure AddDocToHistory(const document: IDocument);
   procedure Clear;
   procedure AddListToHistory(const list: IDynList); virtual;
   destructor Destroy; override;
  public
   property DocHistoryLength: Integer
    read pm_GetDocHistoryLength
    write pm_SetDocHistoryLength;
   property ListHistoryLength: Integer
    read pm_GetListHistoryLength
    write pm_SetListHistoryLength;
   property CurrDoc: IDocument
    read pm_GetCurrDoc;
    {* “екущий (последний в истории) документ. Ќапример, операци€ открыти€ документа его устанавливает. —юда мы устанавливаем закладку, добавл€ем комментарии и вообще когда нам понадобитс€ документ мы его берем отсюда. }
   property CurrList: IDynList
    read pm_GetCurrList;
    {* “екущий (последний в истории) список. ≈сли кака€-то операци€ получает список, то она его ложит сюда, чтобы те операции которым нужен список пользовались. }
   property CurrFolder: IFoldersNode
    read f_CurrFolder
    write pm_SetCurrFolder;
    {* “екуща€ папка. Ќапример, операци€ создани€ папки будет ее устанавливать, а операци€ сохранени€ закладки сможет туда сохранить закладку. }
 end;//TatUserWorkContext

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *4808672500A0impl_uses*
 //#UC END# *4808672500A0impl_uses*
;

function TatUserWorkContext.pm_GetDocHistoryLength: Integer;
//#UC START# *4808679100E8_4808672500A0get_var*
//#UC END# *4808679100E8_4808672500A0get_var*
begin
//#UC START# *4808679100E8_4808672500A0get_impl*
  Result := f_DocumentHistory.HistoryLength;
//#UC END# *4808679100E8_4808672500A0get_impl*
end;//TatUserWorkContext.pm_GetDocHistoryLength

procedure TatUserWorkContext.pm_SetDocHistoryLength(aValue: Integer);
//#UC START# *4808679100E8_4808672500A0set_var*
//#UC END# *4808679100E8_4808672500A0set_var*
begin
//#UC START# *4808679100E8_4808672500A0set_impl*
  f_DocumentHistory.HistoryLength := aValue;
//#UC END# *4808679100E8_4808672500A0set_impl*
end;//TatUserWorkContext.pm_SetDocHistoryLength

function TatUserWorkContext.pm_GetListHistoryLength: Integer;
//#UC START# *483A884E0115_4808672500A0get_var*
//#UC END# *483A884E0115_4808672500A0get_var*
begin
//#UC START# *483A884E0115_4808672500A0get_impl*
  Result := f_ListHistory.HistoryLength;
//#UC END# *483A884E0115_4808672500A0get_impl*
end;//TatUserWorkContext.pm_GetListHistoryLength

procedure TatUserWorkContext.pm_SetListHistoryLength(aValue: Integer);
//#UC START# *483A884E0115_4808672500A0set_var*
//#UC END# *483A884E0115_4808672500A0set_var*
begin
//#UC START# *483A884E0115_4808672500A0set_impl*
 f_ListHistory.HistoryLength := aValue
//#UC END# *483A884E0115_4808672500A0set_impl*
end;//TatUserWorkContext.pm_SetListHistoryLength

function TatUserWorkContext.pm_GetCurrDoc: IDocument;
//#UC START# *480867F10278_4808672500A0get_var*
//#UC END# *480867F10278_4808672500A0get_var*
begin
//#UC START# *480867F10278_4808672500A0get_impl*
  Result := f_DocumentHistory.Current;
//#UC END# *480867F10278_4808672500A0get_impl*
end;//TatUserWorkContext.pm_GetCurrDoc

function TatUserWorkContext.pm_GetCurrList: IDynList;
//#UC START# *483A85FB0088_4808672500A0get_var*
//#UC END# *483A85FB0088_4808672500A0get_var*
begin
//#UC START# *483A85FB0088_4808672500A0get_impl*
  Result := f_ListHistory.Current;
//#UC END# *483A85FB0088_4808672500A0get_impl*
end;//TatUserWorkContext.pm_GetCurrList

procedure TatUserWorkContext.pm_SetCurrFolder(const aValue: IFoldersNode);
//#UC START# *484AA281000E_4808672500A0set_var*
//#UC END# *484AA281000E_4808672500A0set_var*
begin
//#UC START# *484AA281000E_4808672500A0set_impl*
  Assert(aValue <> nil, 'aValue <> nil');
  f_CurrFolder := aValue;
//#UC END# *484AA281000E_4808672500A0set_impl*
end;//TatUserWorkContext.pm_SetCurrFolder

constructor TatUserWorkContext.Create;
//#UC START# *4808681E00D9_4808672500A0_var*
//#UC END# *4808681E00D9_4808672500A0_var*
begin
//#UC START# *4808681E00D9_4808672500A0_impl*
  inherited;
  f_DocumentHistory := TatDocumentHistory.Create;
  f_DocumentHistory.HistoryLength := 1;
  f_ListHistory := TatListHistory.Create;
  f_ListHistory.HistoryLength := 1;
//#UC END# *4808681E00D9_4808672500A0_impl*
end;//TatUserWorkContext.Create

procedure TatUserWorkContext.AddDocToHistory(const document: IDocument);
//#UC START# *480868380180_4808672500A0_var*
//#UC END# *480868380180_4808672500A0_var*
begin
//#UC START# *480868380180_4808672500A0_impl*
  f_DocumentHistory.AddToHistory(document);
//#UC END# *480868380180_4808672500A0_impl*
end;//TatUserWorkContext.AddDocToHistory

procedure TatUserWorkContext.Clear;
//#UC START# *4808684A0084_4808672500A0_var*
//#UC END# *4808684A0084_4808672500A0_var*
begin
//#UC START# *4808684A0084_4808672500A0_impl*
  f_DocumentHistory.Clear;
  f_ListHistory.Clear;
//#UC END# *4808684A0084_4808672500A0_impl*
end;//TatUserWorkContext.Clear

procedure TatUserWorkContext.AddListToHistory(const list: IDynList);
//#UC START# *483A88650069_4808672500A0_var*
//#UC END# *483A88650069_4808672500A0_var*
begin
//#UC START# *483A88650069_4808672500A0_impl*
  f_ListHistory.AddToHistory(list);
//#UC END# *483A88650069_4808672500A0_impl*
end;//TatUserWorkContext.AddListToHistory

destructor TatUserWorkContext.Destroy;
//#UC START# *48077504027E_4808672500A0_var*
//#UC END# *48077504027E_4808672500A0_var*
begin
//#UC START# *48077504027E_4808672500A0_impl*
  FreeAndNil(f_DocumentHistory);
  FreeAndNil(f_ListHistory);
  inherited;
//#UC END# *48077504027E_4808672500A0_impl*
end;//TatUserWorkContext.Destroy

end.
