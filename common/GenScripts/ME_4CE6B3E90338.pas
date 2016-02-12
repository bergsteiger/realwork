unit nsFindIteratorNewForAutoreferat;
 {* Реализация IFindIterator для нового представления автореферата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNewForAutoreferat.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DynamicTreeUnit
 , nevBase
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TnsFindIteratorDef = object
  public
   rIt: IFindIterator;
   rDoc: InevObjectPrim;
  public
   function EQ(const anOther: TnsFindIteratorDef): Boolean;
 end;//TnsFindIteratorDef

 _ItemType_ = TnsFindIteratorDef;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TnsIFindIteratorList = class(_l3RecordWithEQList_)
  {* Список IFindIterator }
 end;//TnsIFindIteratorList

 //#UC START# *4CE6C58C01DEci*
 //#UC END# *4CE6C58C01DEci*
 //#UC START# *4CE6C58C01DEcit*
 //#UC END# *4CE6C58C01DEcit*
 TnsFindIteratorNewForAutoreferatFindPositionList = class(Tl3ProtoObjectForTie, IFindPositionList)
  private
   f_List: IFindPositionList;
   f_Doc: InevObjectPrim;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aDoc: InevObjectPrim;
    const aList: IFindPositionList); reintroduce;
   class function Make(const aDoc: InevObjectPrim;
    const aList: IFindPositionList): IFindPositionList; reintroduce;
 //#UC START# *4CE6C58C01DEpubl*
 private
   // IFindPositionList
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    procedure  pm_GetItem(anIndex: Integer; out aRet: TFindPosition); stdcall;
      {-}
    procedure pm_SetItem(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {-}
    function  Add(const anItem: TFindPosition): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {* - вставляет элемент Item по индексу Index. }
 //#UC END# *4CE6C58C01DEpubl*
 end;//TnsFindIteratorNewForAutoreferatFindPositionList

 TnsFindIteratorNewForAutoreferat = class(Tl3ProtoObjectForTie, IFindIterator)
  {* Реализация IFindIterator для нового представления автореферата }
  private
   f_List: TnsIFindIteratorList;
   f_Current: Integer;
   f_Count: Integer;
  protected
   procedure next;
    {* Перемещенеи итератора на следующий элемент. }
   procedure prev;
    {* Перемещенеи итератора на предыдущий элемент. }
   function is_good: Boolean;
    {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
   function get_position: IFindPositionList;
   function is_first: Boolean;
    {* возвращает true, если нельзя перейти на предыдущий фрагмент }
   function Get_count: Cardinal;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aList: TnsIFindIteratorList); reintroduce;
   class function Make(aList: TnsIFindIteratorList): IFindIterator; reintroduce;
 end;//TnsFindIteratorNewForAutoreferat

function TnsFindIteratorDef_C(const aDoc: InevObjectPrim;
 const anIt: IFindIterator): TnsFindIteratorDef;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , DataAdapter
 , l3Base
 , l3MinMax
 , RTLConsts
;

function TnsFindIteratorDef_C(const aDoc: InevObjectPrim;
 const anIt: IFindIterator): TnsFindIteratorDef;
//#UC START# *4CE6BD260353_4CE6BCB900E2_var*
//#UC END# *4CE6BD260353_4CE6BCB900E2_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4CE6BD260353_4CE6BCB900E2_impl*
 Result.rDoc := aDoc;
 Result.rIt := anIt;
//#UC END# *4CE6BD260353_4CE6BCB900E2_impl*
end;//TnsFindIteratorDef_C

function TnsFindIteratorDef.EQ(const anOther: TnsFindIteratorDef): Boolean;
//#UC START# *4CE6BEF30100_4CE6BCB900E2_var*
//#UC END# *4CE6BEF30100_4CE6BCB900E2_var*
begin
//#UC START# *4CE6BEF30100_4CE6BCB900E2_impl*
 Assert(false);
 Result := false;
//#UC END# *4CE6BEF30100_4CE6BCB900E2_impl*
end;//TnsFindIteratorDef.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4CE6B4D6016C_var*
//#UC END# *47B2C42A0163_4CE6B4D6016C_var*
begin
//#UC START# *47B2C42A0163_4CE6B4D6016C_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4CE6B4D6016C_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4CE6B4D6016C_var*
//#UC END# *47B99D4503A2_4CE6B4D6016C_var*
begin
//#UC START# *47B99D4503A2_4CE6B4D6016C_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4CE6B4D6016C_impl*
end;//CompareExistingItems

type _Instance_R_ = TnsIFindIteratorList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

constructor TnsFindIteratorNewForAutoreferatFindPositionList.Create(const aDoc: InevObjectPrim;
 const aList: IFindPositionList);
//#UC START# *4CE6C60002B8_4CE6C58C01DE_var*
//#UC END# *4CE6C60002B8_4CE6C58C01DE_var*
begin
//#UC START# *4CE6C60002B8_4CE6C58C01DE_impl*
 inherited Create;
 f_Doc := aDoc;
 f_List := aList;
//#UC END# *4CE6C60002B8_4CE6C58C01DE_impl*
end;//TnsFindIteratorNewForAutoreferatFindPositionList.Create

class function TnsFindIteratorNewForAutoreferatFindPositionList.Make(const aDoc: InevObjectPrim;
 const aList: IFindPositionList): IFindPositionList;
var
 l_Inst : TnsFindIteratorNewForAutoreferatFindPositionList;
begin
 l_Inst := Create(aDoc, aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFindIteratorNewForAutoreferatFindPositionList.Make

procedure TnsFindIteratorNewForAutoreferatFindPositionList.ClearFields;
begin
 Finalize(f_List);
 f_Doc := nil;
 inherited;
end;//TnsFindIteratorNewForAutoreferatFindPositionList.ClearFields

//#UC START# *4CE6C58C01DEimpl*
function TnsFindIteratorNewForAutoreferatFindPositionList.pm_GetCount: Integer;
  {-}
begin
 Result := f_List.Count;
end;

procedure TnsFindIteratorNewForAutoreferatFindPositionList.pm_SetCount(aValue: Integer);
  {-}
begin
 Assert(false);
end;

procedure TnsFindIteratorNewForAutoreferatFindPositionList.Clear;
  {-}
begin
 Assert(false);
end;

procedure TnsFindIteratorNewForAutoreferatFindPositionList.Delete(anIndex: Integer);
  {-}
begin
 Assert(false);
end;

procedure TnsFindIteratorNewForAutoreferatFindPositionList.pm_GetItem(anIndex: Integer; out aRet: TFindPosition);
  {-}
var
 l_Path  : INodeIndexPath;
 l_Index : Integer;
begin
 f_List.pm_GetItem(anIndex, aRet);
 l_Path := DefDataAdapter.NativeAdapter.MakeNodeIndexPath;
 l_Path.Add(f_Doc.PID);
 for l_Index := 0 to Pred(aRet.rNode.Count) do
  l_Path.Add(aRet.rNode[l_Index]);
 aRet.rNode := l_Path;
end;

procedure TnsFindIteratorNewForAutoreferatFindPositionList.pm_SetItem(anIndex: Integer; const anItem: TFindPosition);
  {-}
begin
 Assert(false);
end;

function TnsFindIteratorNewForAutoreferatFindPositionList.Add(const anItem: TFindPosition): Integer;
  {-}
begin
 Assert(false);
 Result := -1;
end;

procedure TnsFindIteratorNewForAutoreferatFindPositionList.Insert(anIndex: Integer; const anItem: TFindPosition);
  {-}
begin
 Assert(false);
end;

//#UC END# *4CE6C58C01DEimpl*

constructor TnsFindIteratorNewForAutoreferat.Create(aList: TnsIFindIteratorList);
//#UC START# *4CE6B761017A_4CE6B3E90338_var*
//#UC END# *4CE6B761017A_4CE6B3E90338_var*
begin
//#UC START# *4CE6B761017A_4CE6B3E90338_impl*
 Assert(aList <> nil);
 inherited Create;
 l3Set(f_List, aList);
 f_Current := -1;
 f_Count := -1;
//#UC END# *4CE6B761017A_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.Create

class function TnsFindIteratorNewForAutoreferat.Make(aList: TnsIFindIteratorList): IFindIterator;
var
 l_Inst : TnsFindIteratorNewForAutoreferat;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFindIteratorNewForAutoreferat.Make

procedure TnsFindIteratorNewForAutoreferat.next;
 {* Перемещенеи итератора на следующий элемент. }
//#UC START# *45EEC28202A0_4CE6B3E90338_var*

 procedure IncCurrent;
 begin//IncCurrent
  Inc(f_Current);
  if (f_Current < f_List.Count) then
   f_List[f_Current].rIt.Next;
 end;//IncCurrent

//#UC END# *45EEC28202A0_4CE6B3E90338_var*
begin
//#UC START# *45EEC28202A0_4CE6B3E90338_impl*
 if (f_Current < 0) then
 begin
  Inc(f_Current);
  f_List[f_Current].rIt.Next;
 end//f_Current < 0
 else
 if (f_Current >= f_List.Count) then
  Assert(false)
 else
 begin
  if f_List[f_Current].rIt.IsGood then
  begin
   f_List[f_Current].rIt.Next;
   if not f_List[f_Current].rIt.IsGood then
   // - текущий итератор закончился, надо попробовать следующий
   // http://mdp.garant.ru/pages/viewpage.action?pageId=290952262
    IncCurrent;
  end//f_List[f_Current].rIt.IsGood
  else
   {Inc(f_Current)}
   IncCurrent; // ??? 
 end;//f_Current >= f_List.Count
//#UC END# *45EEC28202A0_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.next

procedure TnsFindIteratorNewForAutoreferat.prev;
 {* Перемещенеи итератора на предыдущий элемент. }
//#UC START# *45EEC28202A1_4CE6B3E90338_var*
//#UC END# *45EEC28202A1_4CE6B3E90338_var*
begin
//#UC START# *45EEC28202A1_4CE6B3E90338_impl*
 if (f_Current < 0) then
  Assert(false)
 else
 if (f_Current >= f_List.Count) then
 begin
  Dec(f_Current);
  Assert(f_Current >= 0);
  f_List[f_Current].rIt.Prev;
 end//f_Current >= f_List.Count
 else
 begin
  if not f_List[f_Current].rIt.IsFirst then
   f_List[f_Current].rIt.Prev
  else
  begin
   Dec(f_Current);
   if (f_Current >= 0) then
    f_List[f_Current].rIt.Prev;
  end;//not f_List[f_Current].rIt.IsFirst
 end;//f_Current >= f_List.Count
//#UC END# *45EEC28202A1_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.prev

function TnsFindIteratorNewForAutoreferat.is_good: Boolean;
 {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
//#UC START# *45EEC28202A2_4CE6B3E90338_var*
//#UC END# *45EEC28202A2_4CE6B3E90338_var*
begin
//#UC START# *45EEC28202A2_4CE6B3E90338_impl*
 if (f_Current < 0) then
  Result := false
 else
 if (f_Current >= f_List.Count) then
  Result := false
 else
  Result := f_List[f_Current].rIt.IsGood;
//#UC END# *45EEC28202A2_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.is_good

function TnsFindIteratorNewForAutoreferat.get_position: IFindPositionList;
//#UC START# *461D00B9005D_4CE6B3E90338_var*
var
 l_It : TnsFindIteratorDef;
 l_L  : IFindPositionList;
//#UC END# *461D00B9005D_4CE6B3E90338_var*
begin
//#UC START# *461D00B9005D_4CE6B3E90338_impl*
 Assert(IsGood);
 l_It := f_List[f_Current];
 l_It.rIt.GetPosition(l_L);
 IFindPositionList(aRet) := TnsFindIteratorNewForAutoreferatFindPositionList.Make(l_It.rDoc, l_L);
//#UC END# *461D00B9005D_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.get_position

function TnsFindIteratorNewForAutoreferat.is_first: Boolean;
 {* возвращает true, если нельзя перейти на предыдущий фрагмент }
//#UC START# *49FEC51501D8_4CE6B3E90338_var*
//#UC END# *49FEC51501D8_4CE6B3E90338_var*
begin
//#UC START# *49FEC51501D8_4CE6B3E90338_impl*
 if (f_Current < 0) then
  Result := true
 else
 if (f_Current >= f_List.Count) then
  Result := false
 else
 if (f_Current = 0) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290952262&focusedCommentId=290954132#comment-290954132
 // - иначе назад работать не будет, когда перебрали все итераторы вперёд
  Result := f_List[f_Current].rIt.IsFirst
 else
  Result := false;
//#UC END# *49FEC51501D8_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.is_first

function TnsFindIteratorNewForAutoreferat.Get_count: Cardinal;
//#UC START# *49FFDC8B015D_4CE6B3E90338get_var*
var
 l_Index : Integer;
//#UC END# *49FFDC8B015D_4CE6B3E90338get_var*
begin
//#UC START# *49FFDC8B015D_4CE6B3E90338get_impl*
 if (f_Count < 0) then
 begin
  f_Count := 0;
  for l_Index := 0 to Pred(f_List.Count) do
   Inc(f_Count, f_List[l_Index].rIt.GetCount);
 end;//f_Count < 0
 Result := f_Count;
//#UC END# *49FFDC8B015D_4CE6B3E90338get_impl*
end;//TnsFindIteratorNewForAutoreferat.Get_count

procedure TnsFindIteratorNewForAutoreferat.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CE6B3E90338_var*
//#UC END# *479731C50290_4CE6B3E90338_var*
begin
//#UC START# *479731C50290_4CE6B3E90338_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4CE6B3E90338_impl*
end;//TnsFindIteratorNewForAutoreferat.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
