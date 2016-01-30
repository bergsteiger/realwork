unit nsFilterableTreeStruct;
 {* Фильтруемое дерево }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsFilterableTreeStruct.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsTreeStruct
 , l3TreeInterfaces
 , bsInterfaces
 , DynamicTreeUnit
 , afwInterfaces
 , l3Interfaces
 , IOUnit
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3ContextFilterNotifier;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TIl3ContextFilterNotifierList = class(_l3InterfacePtrList_)
 end;//TIl3ContextFilterNotifierList

 TnsFilterableTreeStruct = class(TnsTreeStruct, Il3FilterableTree, Il3ContextFilterParamsNotifier, Il3ContextFilterTarget, Il3ContextFilterNotifySource, InsInternalFilterableTree)
  {* Фильтруемое дерево }
  private
   f_InParamsChanging: Boolean;
   f_ContextFilterNotifySource: Il3ContextFilterParamsNotifySource;
   f_ContextFilterParams: Il3ContextFilterParams;
   f_Subscribers: TIl3ContextFilterNotifierList;
   f_Filters: Il3TreeFilters;
    {* Поле для свойства Filters }
  private
   function ContextFilterParams: Il3ContextFilterParams;
   procedure ClearContextFilterParams;
  protected
   function pm_GetFilters: Il3TreeFilters;
   constructor CreateFiltered(const aNewRoot: INodeBase;
    aSource: TnsFilterableTreeStruct;
    const aFilters: Il3TreeFilters); reintroduce; virtual;
   function MakeFilters: Il3TreeFilters; virtual;
   function CanFiltrate: Boolean; virtual;
   function GetFilteredRoot(const aRoot: INodeBase;
    const aFilters: Il3TreeFilters;
    const aCurrentNode: INodeBase;
    out aSyncIndex: Integer;
    aAutoOpen: Boolean;
    FullRefilter: Boolean;
    ApplyEmptyFilter: Boolean): INodeBase; virtual;
    {* aSyncIndex     : Integer
                              - Нода для синхронизации. Индекс этой ноды в
                                  фильтрованном вью, будет возвращен в
                                  параметре sync_index.
aAutoOpen     : Boolean
                               - Раскрывать узлы с фильтром автоматически.
                                   Узлы, часть детей которых отфильтрованно,
                                   будут автоматически раскрываться.
FullRefilter: Boolean
                               - Перефильтровывать дерево полностью
                                   иначе - применять фильтр (сужать) aRoot
ApplyEmptyFilter: Boolean
                              - Если список фильтров получился пустым -
                                   все равно пытаться его наложить }
   procedure NotifyRequestReapply;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); virtual;
   function MakeContextFilterParams: Il3ContextFilterParams; virtual;
   function SettingsID: TafwSettingId; virtual;
   function DoMakeFiltered(const aFilters: Il3TreeFilters;
    const aCurrentNode: Il3SimpleNode;
    out aSyncIndex: Integer;
    aAutoOpen: Boolean;
    CalcPartialContext: Boolean): Il3SimpleTree; virtual;
   procedure RequestClearAndTurnOff;
   procedure ReAquireContextFilterParams;
   function CloneFilters: Il3TreeFilters;
   function MakeFiltered(const aFilters: Il3TreeFilters;
    const aCurrentNode: Il3SimpleNode;
    out aSyncIndex: Integer {* Нода для синхронизации. Индекс этой ноды в
                                   фильтрованном вью, будет возвращен в
                                   параметре sync_index. };
    aAutoOpen: Boolean = True {* Раскрывать узлы с фильтром автоматически.
                                   Узлы, часть детей которых отфильтрованно,
                                   будут автоматически раскрываться. };
    CalcPartialContext: Boolean = False {* пытаться вычислить максимальный контекстный фильтр,
                                   который еще вернет данные }): Il3SimpleTree;
   procedure ParamsChanged;
   procedure SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
   procedure UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
   function IsSameContext(const aContext: Il3CString;
    out DiffStart: Cardinal): Boolean;
   procedure SetFilters(const aFilters: Il3TreeFilters);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   class function MakeSearchStr(const aParams: Il3ContextFilterParams;
    const aSource: Il3CString): Il3CString;
   class function MakeSearchStrI(const aParams: Il3ContextFilterParams;
    const aSource: Il3CString): IString;
   class function FillContextFilter(const aFilter: IContextFilter;
    const aParams: Il3ContextFilterParams;
    const aSource: Il3CString): Boolean;
   constructor Create(const aRoot: INodeBase;
    aShowRoot: Boolean;
    aOneLevel: Boolean = False); override;
  protected
   property Filters: Il3TreeFilters
    read pm_GetFilters;
 end;//TnsFilterableTreeStruct

implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , l3TreeFilters
 , nsAdapterFilters
 , l3Chars
 , DataAdapter
 , nsTypes
 , bsConvert
 , nsContextFilterParams
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 RnsFilterableTreeStruct = class of TnsFilterableTreeStruct;

type _Instance_R_ = TIl3ContextFilterNotifierList;

{$Include l3InterfacePtrList.imp.pas}

function TnsFilterableTreeStruct.pm_GetFilters: Il3TreeFilters;
//#UC START# *48FF42E50041_46835BD201D6get_var*
//#UC END# *48FF42E50041_46835BD201D6get_var*
begin
//#UC START# *48FF42E50041_46835BD201D6get_impl*
 if f_Filters = nil then
  f_Filters := MakeFilters;
 Result := f_Filters;
//#UC END# *48FF42E50041_46835BD201D6get_impl*
end;//TnsFilterableTreeStruct.pm_GetFilters

class function TnsFilterableTreeStruct.MakeSearchStr(const aParams: Il3ContextFilterParams;
 const aSource: Il3CString): Il3CString;
//#UC START# *4D4022340233_46835BD201D6_var*
const
 cSimbol = '*';
var
 l_Temp    : Il3CString;
 l_Space   : Boolean;
 l_Index   : Integer;
 l_AddChar : Boolean;
//#UC END# *4D4022340233_46835BD201D6_var*
begin
//#UC START# *4D4022340233_46835BD201D6_impl*
 Result := nil;
 // Фильтрация не включена или контекcт пустой:
 if l3IsNil(aSource) then
  Exit;
 l_Temp := aSource;
 l3Replace(l_Temp, [cSimbol, cc_SoftSpace], cc_HardSpace);
                          // ^^^ [$424385667]
 l_Temp := l3Trim(l_Temp);
 // любое количество символов до текста
 if aParams.WordPosition in [wpAnyPathWord, wpAtBeginWord] then
  Result := l3Cat([l3CStr(cSimbol + ' '), Result]);
 l_Space := False;
 for l_Index := 0 to l3Len(l_Temp) - 1 do
 begin
  if l3IsChar(l_Temp, l_Index, cc_HardSpace) then
  begin
   // в конце всех слов ставим *:
   if not l_Space and not (l_Index = 0) then
    Result := l3Cat(Result, cSimbol + cc_HardSpace);
   l_Space := True;
  end//l3IsChar(l_Temp, l_Index, ' ')
  else
  begin
   l_AddChar := False;
   // в любой части слова, ставим '*' перед словом:
   if ((l_Index = 0) or l_Space) and (aParams.WordPosition = wpAnyPathWord) then
   begin
    Result := l3Cat(Result, cSimbol + l3Char(l_Temp, l_Index));
    l_AddChar := True;
   end;//l_Index = 0
   // звездочка в конце слова, не учитываем несколько пробелов в конце
   // контекста, их мы удалили в начале процедуры:
   if (l_Index = l3Len(l_Temp) - 1)then
    if l_AddChar then
     Result := l3Cat(Result, cSimbol)
    else
    begin
     Result := l3Cat(Result, l3Char(l_Temp, l_Index) + cSimbol);
     l_AddChar := True;
    end;//l_AddChar
   // добавим символ если мы этого ещё не сделали:
   if not l_AddChar then
    Result := l3Cat(Result, l3Char(l_Temp, l_Index));
   l_Space := False;
  end;//l3IsChar..
 end;//for l_Index..
//#UC END# *4D4022340233_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.MakeSearchStr

class function TnsFilterableTreeStruct.MakeSearchStrI(const aParams: Il3ContextFilterParams;
 const aSource: Il3CString): IString;
//#UC START# *4D40228E0064_46835BD201D6_var*
//#UC END# *4D40228E0064_46835BD201D6_var*
begin
//#UC START# *4D40228E0064_46835BD201D6_impl*
 Result := nsIStr(MakeSearchStr(aParams, aSource));
//#UC END# *4D40228E0064_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.MakeSearchStrI

class function TnsFilterableTreeStruct.FillContextFilter(const aFilter: IContextFilter;
 const aParams: Il3ContextFilterParams;
 const aSource: Il3CString): Boolean;
//#UC START# *4D4030B70365_46835BD201D6_var*
//#UC END# *4D4030B70365_46835BD201D6_var*
begin
//#UC START# *4D4030B70365_46835BD201D6_impl*
 if not l3IsNil(aSource) then
 begin
  Result := true;
  aFilter.SetContext(MakeSearchStrI(aParams, aSource));
  aFilter.SetOrder(bsBusinessToAdapter(aParams.WordOrder));
  aFilter.SetArea(bsBusinessToAdapter(aParams.TreeLevelDist));
  // SetPlace не делаем т.к. соотвествтующий SearchPosition на фильтрации
  // дерева никогда не пользовалась а пользовалась исключительно на
  // контекстном поиске в тексте документа/списке.
 end//not l3IsNil(aSource)
 else
  Result := false;
//#UC END# *4D4030B70365_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.FillContextFilter

constructor TnsFilterableTreeStruct.CreateFiltered(const aNewRoot: INodeBase;
 aSource: TnsFilterableTreeStruct;
 const aFilters: Il3TreeFilters);
//#UC START# *48FF458602EC_46835BD201D6_var*
//#UC END# *48FF458602EC_46835BD201D6_var*
begin
//#UC START# *48FF458602EC_46835BD201D6_impl*
 Assert(Assigned(aSource));
 Create(aNewRoot, aSource.Get_ShowRoot);
 f_Filters := aFilters;
//#UC END# *48FF458602EC_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.CreateFiltered

function TnsFilterableTreeStruct.MakeFilters: Il3TreeFilters;
//#UC START# *48FF4C25031E_46835BD201D6_var*
//#UC END# *48FF4C25031E_46835BD201D6_var*
begin
//#UC START# *48FF4C25031E_46835BD201D6_impl*
 Result := Tl3TreeFilters.Make;
//#UC END# *48FF4C25031E_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.MakeFilters

function TnsFilterableTreeStruct.CanFiltrate: Boolean;
//#UC START# *48FF4C3A00C4_46835BD201D6_var*
//#UC END# *48FF4C3A00C4_46835BD201D6_var*
begin
//#UC START# *48FF4C3A00C4_46835BD201D6_impl*
 Result := True;
//#UC END# *48FF4C3A00C4_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.CanFiltrate

function TnsFilterableTreeStruct.GetFilteredRoot(const aRoot: INodeBase;
 const aFilters: Il3TreeFilters;
 const aCurrentNode: INodeBase;
 out aSyncIndex: Integer;
 aAutoOpen: Boolean;
 FullRefilter: Boolean;
 ApplyEmptyFilter: Boolean): INodeBase;
 {* aSyncIndex     : Integer
                              - Нода для синхронизации. Индекс этой ноды в
                                  фильтрованном вью, будет возвращен в
                                  параметре sync_index.
aAutoOpen     : Boolean
                               - Раскрывать узлы с фильтром автоматически.
                                   Узлы, часть детей которых отфильтрованно,
                                   будут автоматически раскрываться.
FullRefilter: Boolean
                               - Перефильтровывать дерево полностью
                                   иначе - применять фильтр (сужать) aRoot
ApplyEmptyFilter: Boolean
                              - Если список фильтров получился пустым -
                                   все равно пытаться его наложить }
//#UC START# *48FF4C4F03CA_46835BD201D6_var*
var
 l_AdapterFilters: InsAdapterFilters;
 l_Root: INodeBase;
 l_PreFilters : IFilterList;
 l_Filters : IFilterList;
//#UC END# *48FF4C4F03CA_46835BD201D6_var*
begin
//#UC START# *48FF4C4F03CA_46835BD201D6_impl*
 if Assigned(aRoot) then
 begin
  l_AdapterFilters := TnsAdapterFilters.Make;
  try
   FillFilters(aFilters, l_AdapterFilters);
   if ApplyEmptyFilter or (l_AdapterFilters.FiltersCount > 0) then
   begin
    if l_AdapterFilters.HasPrefilters then
    begin
     l_Root := nil;
     l_PreFilters := l_AdapterFilters.MakePreFilterList;
     Assert(l_PreFilters <> nil);
     aRoot.CreateViewEx(l_PreFilters,
                        FM_USER_FLAG_MASK,
                        aCurrentNode,
                        aSyncIndex,
                        0,
                        False,
                        aAutoOpen,
                        False,
                        l_Root);
     if (l_Root = nil) then
     begin
      Result := aRoot;
      Exit;
     end;//l_Root = nil
     Assert(l_Root <> nil);
    end//l_AdapterFilters.HasPrefilters
    else
     l_Root := aRoot;
    l_Filters := l_AdapterFilters.MakeFilterList;
    Assert(l_Filters <> nil);
    l_Root.CreateViewEx(l_Filters,
                        FM_USER_FLAG_MASK,
                        aCurrentNode,
                        aSyncIndex,
                        0,
                        False,
                        aAutoOpen,
                        not FullRefilter or l_AdapterFilters.HasPrefilters,
                        Result)
   end
   else
    Result := aRoot;
  finally
   l_AdapterFilters := nil;
  end;
 end
 else
  Result := aRoot; 
//#UC END# *48FF4C4F03CA_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.GetFilteredRoot

procedure TnsFilterableTreeStruct.NotifyRequestReapply;
//#UC START# *48FF4D8202A6_46835BD201D6_var*
var
 l_Index : Integer;
//#UC END# *48FF4D8202A6_46835BD201D6_var*
begin
//#UC START# *48FF4D8202A6_46835BD201D6_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   f_Subscribers[l_Index].RequestReapply;
//#UC END# *48FF4D8202A6_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.NotifyRequestReapply

function TnsFilterableTreeStruct.ContextFilterParams: Il3ContextFilterParams;
//#UC START# *48FF4DB302BD_46835BD201D6_var*
//#UC END# *48FF4DB302BD_46835BD201D6_var*
begin
//#UC START# *48FF4DB302BD_46835BD201D6_impl*
 if f_ContextFilterParams = nil then
 begin
  f_ContextFilterParams := MakeContextFilterParams;
  if Supports(f_ContextFilterParams, Il3ContextFilterParamsNotifySource, f_ContextFilterNotifySource) then
   f_ContextFilterNotifySource.Subscribe(Self);
 end;
 Result := f_ContextFilterParams;
//#UC END# *48FF4DB302BD_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.ContextFilterParams

procedure TnsFilterableTreeStruct.ClearContextFilterParams;
//#UC START# *48FF4DBE0176_46835BD201D6_var*
//#UC END# *48FF4DBE0176_46835BD201D6_var*
begin
//#UC START# *48FF4DBE0176_46835BD201D6_impl*
 if Assigned(f_ContextFilterNotifySource) then
  f_ContextFilterNotifySource.UnSubscribe(Self);
 f_ContextFilterNotifySource := nil;
 f_ContextFilterParams := nil;
//#UC END# *48FF4DBE0176_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.ClearContextFilterParams

procedure TnsFilterableTreeStruct.FillFilters(const aFilters: Il3TreeFilters;
 const anAdapterFilters: InsAdapterFilters);
//#UC START# *48FF520E03A0_46835BD201D6_var*

//#UC END# *48FF520E03A0_46835BD201D6_var*
begin
//#UC START# *48FF520E03A0_46835BD201D6_impl*
 FillContextFilter(anAdapterFilters.Context,
                   ContextFilterParams,
                   aFilters.Context);
//#UC END# *48FF520E03A0_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.FillFilters

function TnsFilterableTreeStruct.MakeContextFilterParams: Il3ContextFilterParams;
//#UC START# *48FF52670038_46835BD201D6_var*
//#UC END# *48FF52670038_46835BD201D6_var*
begin
//#UC START# *48FF52670038_46835BD201D6_impl*
 Result := TnsContextFilterParams.Make(SettingsID);
//#UC END# *48FF52670038_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.MakeContextFilterParams

function TnsFilterableTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_46835BD201D6_var*
//#UC END# *48FF56D003E6_46835BD201D6_var*
begin
//#UC START# *48FF56D003E6_46835BD201D6_impl*
 Result := '';
//#UC END# *48FF56D003E6_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.SettingsID

function TnsFilterableTreeStruct.DoMakeFiltered(const aFilters: Il3TreeFilters;
 const aCurrentNode: Il3SimpleNode;
 out aSyncIndex: Integer;
 aAutoOpen: Boolean;
 CalcPartialContext: Boolean): Il3SimpleTree;
//#UC START# *48FF5A9002CC_46835BD201D6_var*
var
 l_RootNode: INodeBase;
 l_Current: INodeBase;
 l_NewRoot: INodeBase;
 l_NewTree: TnsFilterableTreeStruct;
 l_NewFilters: Il3TreeFilters;
 l_OriginalContext: Il3CString;
 l_VariableContext: Il3CString;
 l_ValidContext: Il3CString;
 l_ContextLength: Integer;
 l_TempRoot: INodeBase;
//#UC END# *48FF5A9002CC_46835BD201D6_var*
begin
//#UC START# *48FF5A9002CC_46835BD201D6_impl*
 Assert(CanFiltrate);
 aSyncIndex := -1;
 l_RootNode := RootNode;
 if Assigned(l_RootNode) then
 begin
  Supports(aCurrentNode, INodeBase, l_Current);
  l_NewFilters := aFilters;
  l_NewRoot := GetFilteredRoot(l_RootNode, l_NewFilters, l_Current, aSyncIndex, aAutoOpen, true, true);

  if (CalcPartialContext or f_InParamsChanging) and
     not l3IsNil(l_NewFilters.Context) and
     not l_NewRoot.HasChildren then
  // Если ничего не нашлось и попросили сверху или поменялись параметры -
  // пытаемся перефильтовать для вычисления
  // наиболее полного контекста
  begin
   l_OriginalContext := l_NewFilters.Context;
   l_ContextLength := 0;
   l_NewFilters := aFilters;
   l_NewFilters.SetContext(nil);
   l_TempRoot := GetFilteredRoot(l_RootNode, l_NewFilters, l_Current, aSyncIndex, aAutoOpen, true, true);
   repeat
    l_VariableContext := l_OriginalContext;
    l3SetLen(l_VariableContext, l_ContextLength);
    l_NewFilters.SetContext(l_VariableContext);
    l_NewRoot := GetFilteredRoot(l_TempRoot, l_NewFilters, l_Current, aSyncIndex, aAutoOpen, True, true);
    if l_NewRoot.HasChildren then
    begin
     l_TempRoot := l_NewRoot;
     l_ValidContext := l_NewFilters.Context;
    end;
    Inc(l_ContextLength);
   until not l_NewRoot.HasChildren or l3Same(l_NewFilters.Context, l_OriginalContext);
   l_NewRoot := l_TempRoot;
   l_NewFilters.SetContext(l_ValidContext);
  end;

  if not Get_ShowRoot then
   Dec(aSyncIndex);
  if Assigned(l_NewRoot) then
  begin
   l_NewTree := RnsFilterableTreeStruct(ClassType).CreateFiltered(l_NewRoot, Self, l_NewFilters);
   try
    Result := l_NewTree;
   finally
    l3Free(l_NewTree);
   end;
  end
  else//Assigned(l_NewRoot)
   Result := nil;
 end
 else//Supports(RootNode, INodeBase, l_RootNode)
  Result := nil;
//#UC END# *48FF5A9002CC_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.DoMakeFiltered

procedure TnsFilterableTreeStruct.RequestClearAndTurnOff;
//#UC START# *48FF5BEC03D6_46835BD201D6_var*
var
 l_Index : Integer;
//#UC END# *48FF5BEC03D6_46835BD201D6_var*
begin
//#UC START# *48FF5BEC03D6_46835BD201D6_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   f_Subscribers[l_Index].RequestClearAndTurnOff;
//#UC END# *48FF5BEC03D6_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.RequestClearAndTurnOff

procedure TnsFilterableTreeStruct.ReAquireContextFilterParams;
//#UC START# *48FF5D34002A_46835BD201D6_var*
//#UC END# *48FF5D34002A_46835BD201D6_var*
begin
//#UC START# *48FF5D34002A_46835BD201D6_impl*
 ClearContextFilterParams;
 ContextFilterParams;
//#UC END# *48FF5D34002A_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.ReAquireContextFilterParams

function TnsFilterableTreeStruct.CloneFilters: Il3TreeFilters;
//#UC START# *47724BB000A5_46835BD201D6_var*
//#UC END# *47724BB000A5_46835BD201D6_var*
begin
//#UC START# *47724BB000A5_46835BD201D6_impl*
 Result := Filters.Clone;
//#UC END# *47724BB000A5_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.CloneFilters

function TnsFilterableTreeStruct.MakeFiltered(const aFilters: Il3TreeFilters;
 const aCurrentNode: Il3SimpleNode;
 out aSyncIndex: Integer {* Нода для синхронизации. Индекс этой ноды в
                                   фильтрованном вью, будет возвращен в
                                   параметре sync_index. };
 aAutoOpen: Boolean = True {* Раскрывать узлы с фильтром автоматически.
                                   Узлы, часть детей которых отфильтрованно,
                                   будут автоматически раскрываться. };
 CalcPartialContext: Boolean = False {* пытаться вычислить максимальный контекстный фильтр,
                                   который еще вернет данные }): Il3SimpleTree;
//#UC START# *47724BE60202_46835BD201D6_var*
//#UC END# *47724BE60202_46835BD201D6_var*
begin
//#UC START# *47724BE60202_46835BD201D6_impl*
 Result := DoMakeFiltered(aFilters, aCurrentNode, aSyncIndex, aAutoOpen, CalcPartialContext);
//#UC END# *47724BE60202_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.MakeFiltered

procedure TnsFilterableTreeStruct.ParamsChanged;
//#UC START# *47724EF80325_46835BD201D6_var*
//#UC END# *47724EF80325_46835BD201D6_var*
begin
//#UC START# *47724EF80325_46835BD201D6_impl*
 f_InParamsChanging := true;
 try
  NotifyRequestReapply;
 finally
  f_InParamsChanging := false;
 end;
//#UC END# *47724EF80325_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.ParamsChanged

procedure TnsFilterableTreeStruct.SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
//#UC START# *477251CC02BD_46835BD201D6_var*
//#UC END# *477251CC02BD_46835BD201D6_var*
begin
//#UC START# *477251CC02BD_46835BD201D6_impl*
 if (f_Subscribers = nil) then
  f_Subscribers := TIl3ContextFilterNotifierList.Make;
 if f_Subscribers.IndexOf(aSubscriber) = -1 then
  f_Subscribers.Add(aSubscriber);
//#UC END# *477251CC02BD_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.SubscribeToContextFilter

procedure TnsFilterableTreeStruct.UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
//#UC START# *477251E203DD_46835BD201D6_var*
//#UC END# *477251E203DD_46835BD201D6_var*
begin
//#UC START# *477251E203DD_46835BD201D6_impl*
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(aSubscriber);
//#UC END# *477251E203DD_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.UnSubscribeFromContextFilter

function TnsFilterableTreeStruct.IsSameContext(const aContext: Il3CString;
 out DiffStart: Cardinal): Boolean;
//#UC START# *4772521703E3_46835BD201D6_var*
//#UC END# *4772521703E3_46835BD201D6_var*
begin
//#UC START# *4772521703E3_46835BD201D6_impl*
 Result := l3Same(aContext, Filters.Context);
 if not Result then
  DiffStart := l3CommonPartLen(aContext, Filters.Context)
 else
  DiffStart := l3Len(aContext);
//#UC END# *4772521703E3_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.IsSameContext

procedure TnsFilterableTreeStruct.SetFilters(const aFilters: Il3TreeFilters);
//#UC START# *48FF42490203_46835BD201D6_var*
//#UC END# *48FF42490203_46835BD201D6_var*
begin
//#UC START# *48FF42490203_46835BD201D6_impl*
 f_Filters := aFilters;
//#UC END# *48FF42490203_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.SetFilters

procedure TnsFilterableTreeStruct.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_46835BD201D6_var*
//#UC END# *479731C50290_46835BD201D6_var*
begin
//#UC START# *479731C50290_46835BD201D6_impl*
 l3Free(f_Subscribers);
 ClearContextFilterParams;
 f_Filters := nil;
 inherited;
//#UC END# *479731C50290_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.Cleanup

constructor TnsFilterableTreeStruct.Create(const aRoot: INodeBase;
 aShowRoot: Boolean;
 aOneLevel: Boolean = False);
//#UC START# *48FDD9270194_46835BD201D6_var*
//#UC END# *48FDD9270194_46835BD201D6_var*
begin
//#UC START# *48FDD9270194_46835BD201D6_impl*
 inherited;
 ContextFilterParams;
//#UC END# *48FDD9270194_46835BD201D6_impl*
end;//TnsFilterableTreeStruct.Create

procedure TnsFilterableTreeStruct.ClearFields;
begin
 f_Filters := nil;
 inherited;
end;//TnsFilterableTreeStruct.ClearFields

end.
