unit nsFindIteratorNewForDiction;
 {* Реализация IFindIterator для нового представления Толькового словаря. [$245760208] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNewForDiction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFindIteratorNewForDiction" MUID: (4D00EA5A02CF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DynamicTreeUnit
 , nsFindPositionListList
 , l3Variant
 //#UC START# *4D00EA5A02CFintf_uses*
 //#UC END# *4D00EA5A02CFintf_uses*
;

const
 cFirstLangOffset = 101;
  {* Смещение первого языка }

type
 //#UC START# *4D00EA5A02CFci*
 //#UC END# *4D00EA5A02CFci*
 //#UC START# *4D00EA5A02CFcit*
 //#UC END# *4D00EA5A02CFcit*
 TnsFindIteratorNewForDiction = class(Tl3ProtoObjectForTie, IFindIterator, IFindPositionList)
  {* Реализация IFindIterator для нового представления Толькового словаря. [$245760208] }
  private
   f_AdapterFindPositionList: IFindPositionList;
   f_Current: Integer;
   f_List: TnsFindPositionListList;
  protected
   procedure Next; stdcall;
    {* Перемещенеи итератора на следующий элемент. }
   procedure Prev; stdcall;
    {* Перемещенеи итератора на предыдущий элемент. }
   function IsGood: ByteBool; stdcall;
    {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
   function GetPosition: IFindPositionList; stdcall;
   function IsFirst: ByteBool; stdcall;
    {* возвращает true, если нельзя перейти на предыдущий фрагмент }
   function GetCount: Cardinal; stdcall;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const anAdapterIterator: IFindIterator;
    aBlock: Tl3Tag); reintroduce;
   class function Make(const anAdapterIterator: IFindIterator;
    aBlock: Tl3Tag): IFindIterator; reintroduce;
 //#UC START# *4D00EA5A02CFpubl*
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
 //#UC END# *4D00EA5A02CFpubl*
 end;//TnsFindIteratorNewForDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , k2Tags
 , SysUtils
 , DictEntry_Const
 //#UC START# *4D00EA5A02CFimpl_uses*
 //#UC END# *4D00EA5A02CFimpl_uses*
;

constructor TnsFindIteratorNewForDiction.Create(const anAdapterIterator: IFindIterator;
 aBlock: Tl3Tag);
//#UC START# *4D00EB96015B_4D00EA5A02CF_var*
var
 l_AdapterFindPositionList : IFindPositionList;
 l_Pos : TFindPosition;
 l_Index : Integer;
 l_NeedAdd : Boolean;
 l_Offset : Integer;
 l_Tag    : Integer;
//#UC END# *4D00EB96015B_4D00EA5A02CF_var*
begin
//#UC START# *4D00EB96015B_4D00EA5A02CF_impl*
 Assert(anAdapterIterator <> nil);
 Assert(aBlock <> nil);
 inherited Create;
 f_List := TnsFindPositionListList.Create;
 while true do
 begin
  anAdapterIterator.Next;
  if not anAdapterIterator.IsGood then
   break;
  anAdapterIterator.GetPosition(l_AdapterFindPositionList);
  if (l_AdapterFindPositionList = nil) then
   continue;
  if (l_AdapterFindPositionList.Count <= 0) then
   continue;
  l_NeedAdd := true;
  if aBlock.Owner.IsKindOf(k2_typDictEntry) then
  begin
   l_Offset := cFirstLangOffset;
   l_Tag := k2_tiHandle;
  end//aBlock.Owner.IsKindOf(k2_typDictEntry)
  else
  begin
   l_Offset := 0;
   l_Tag := k2_tiExternalHandle;
  end;//aBlock.Owner.IsKindOf(k2_typDictEntry)
  for l_Index := 0 to Pred(l_AdapterFindPositionList.Count) do
  begin
   l_AdapterFindPositionList.pm_GetItem(l_Index, l_Pos);
   Assert(l_Pos.rNode.Count > 0);
   if (l_Pos.rNode[0] <> aBlock.IntA[l_Tag] - l_Offset) then
   // - это не наш блок
   begin
    l_NeedAdd := false;
    break;
   end;//l_Pos.rNode[0] <> aBlock.IntA[k2_tiHandle] - cFirstLangOffset
  end;//for l_Index
  if l_NeedAdd then
   f_List.Add(l_AdapterFindPositionList);
 end;//while true
 f_Current := -1;
//#UC END# *4D00EB96015B_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.Create

class function TnsFindIteratorNewForDiction.Make(const anAdapterIterator: IFindIterator;
 aBlock: Tl3Tag): IFindIterator;
var
 l_Inst : TnsFindIteratorNewForDiction;
begin
 l_Inst := Create(anAdapterIterator, aBlock);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFindIteratorNewForDiction.Make

procedure TnsFindIteratorNewForDiction.Next;
 {* Перемещенеи итератора на следующий элемент. }
//#UC START# *45EEC28202A0_4D00EA5A02CF_var*
//#UC END# *45EEC28202A0_4D00EA5A02CF_var*
begin
//#UC START# *45EEC28202A0_4D00EA5A02CF_impl*
// Assert(f_Current <= Pred(GetCount));
 //Assert(GetCount > 0);
 Assert(f_Current < GetCount);

 Inc(f_Current);
//#UC END# *45EEC28202A0_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.Next

procedure TnsFindIteratorNewForDiction.Prev;
 {* Перемещенеи итератора на предыдущий элемент. }
//#UC START# *45EEC28202A1_4D00EA5A02CF_var*
//#UC END# *45EEC28202A1_4D00EA5A02CF_var*
begin
//#UC START# *45EEC28202A1_4D00EA5A02CF_impl*
 Assert(f_Current >= 0);
 Dec(f_Current);
//#UC END# *45EEC28202A1_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.Prev

function TnsFindIteratorNewForDiction.IsGood: ByteBool;
 {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
//#UC START# *45EEC28202A2_4D00EA5A02CF_var*
//#UC END# *45EEC28202A2_4D00EA5A02CF_var*
begin
//#UC START# *45EEC28202A2_4D00EA5A02CF_impl*
 Result := (GetCount > 0) AND
           (f_Current >= 0) AND (f_Current <= Pred(GetCount));
//#UC END# *45EEC28202A2_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.IsGood

function TnsFindIteratorNewForDiction.GetPosition: IFindPositionList;
//#UC START# *461D00B9005D_4D00EA5A02CF_var*
//#UC END# *461D00B9005D_4D00EA5A02CF_var*
begin
//#UC START# *461D00B9005D_4D00EA5A02CF_impl*
 Assert(IsGood);
 f_AdapterFindPositionList := f_List[f_Current];
 IFindPositionList(aRet) := Self;
//#UC END# *461D00B9005D_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.GetPosition

function TnsFindIteratorNewForDiction.IsFirst: ByteBool;
 {* возвращает true, если нельзя перейти на предыдущий фрагмент }
//#UC START# *49FEC51501D8_4D00EA5A02CF_var*
//#UC END# *49FEC51501D8_4D00EA5A02CF_var*
begin
//#UC START# *49FEC51501D8_4D00EA5A02CF_impl*
 Result := (f_Current <= 0);
//#UC END# *49FEC51501D8_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.IsFirst

function TnsFindIteratorNewForDiction.GetCount: Cardinal;
//#UC START# *49FFDC8B015D_4D00EA5A02CFget_var*
//#UC END# *49FFDC8B015D_4D00EA5A02CFget_var*
begin
//#UC START# *49FFDC8B015D_4D00EA5A02CFget_impl*
 Assert(f_List <> nil);
 if (f_List = nil) then
  Result := 0
 else
  Result := f_List.Count;
//#UC END# *49FFDC8B015D_4D00EA5A02CFget_impl*
end;//TnsFindIteratorNewForDiction.GetCount

procedure TnsFindIteratorNewForDiction.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D00EA5A02CF_var*
//#UC END# *479731C50290_4D00EA5A02CF_var*
begin
//#UC START# *479731C50290_4D00EA5A02CF_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4D00EA5A02CF_impl*
end;//TnsFindIteratorNewForDiction.Cleanup

procedure TnsFindIteratorNewForDiction.ClearFields;
begin
 Finalize(f_AdapterFindPositionList);
 inherited;
end;//TnsFindIteratorNewForDiction.ClearFields

//#UC START# *4D00EA5A02CFimpl*
function TnsFindIteratorNewForDiction.pm_GetCount: Integer;
begin
 Result := f_AdapterFindPositionList.Count;
end;

procedure TnsFindIteratorNewForDiction.pm_SetCount(aValue: Integer);
begin
 Assert(false);
end;

procedure TnsFindIteratorNewForDiction.Clear;
begin
 Assert(false);
end;

procedure TnsFindIteratorNewForDiction.Delete(anIndex: Integer);
begin
 Assert(false);
end;

procedure TnsFindIteratorNewForDiction.pm_GetItem(anIndex: Integer; out aRet: TFindPosition);
var
 l_Path  : INodeIndexPath;
 l_Index : Integer;
begin
 Assert(f_AdapterFindPositionList <> nil);
 f_AdapterFindPositionList.pm_GetItem(anIndex, aRet);
 Assert(aRet.rNode.Count > 0);
 l_Path := DefDataAdapter.NativeAdapter.MakeNodeIndexPath;
 l_Path.Add(0);
 // - наш блок всегда нулевой
 for l_Index := 1 to Pred(aRet.rNode.Count) do
  l_Path.Add(aRet.rNode[l_Index]);
 aRet.rNode := l_Path;
end;

procedure TnsFindIteratorNewForDiction.pm_SetItem(anIndex: Integer; const anItem: TFindPosition);
begin
 Assert(false);
end;

function TnsFindIteratorNewForDiction.Add(const anItem: TFindPosition): Integer;
begin
 Result := -1;
 Assert(false);
end;

procedure TnsFindIteratorNewForDiction.Insert(anIndex: Integer; const anItem: TFindPosition);
begin
 Assert(false);
end;
//#UC END# *4D00EA5A02CFimpl*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
