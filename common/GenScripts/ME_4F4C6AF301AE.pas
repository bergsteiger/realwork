unit evTableColumn;
 {* Реализация интерфейса IedColumn для колонки таблицы. }

// Модуль: "w:\common\components\gui\Garant\Everest\evTableColumn.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evTableColumn" MUID: (4F4C6AF301AE)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evColumnBorderMarker
 , evEditorInterfaces
 , nevBase
 , nevTools
 , l3Variant
;

{$If Defined(evNeedEditableCursors)}
type
 TevColumn = class(TevColumnBorderMarker, IedCellsIterator, IedColumn)
  {* Реализует интерфейс IedColumn для колонки таблицы. }
  private
   f_RowIndex: Integer;
   f_Processor: InevProcessor;
    {* Поле для свойства Processor }
  protected
   function Get_Width: Integer;
   procedure Set_Width(aValue: Integer);
   function pm_GetBackIterator: IedBackCellsIterator;
   function First(aNeedNeighbours: Boolean): IedCell;
    {* возвращает первую ячейку и начинает перебор }
   function Next: IedCell;
    {* возвращает следующую ячейку или nil, если перебор закончен }
   function CellsCount: Integer;
    {* Количество ячеек }
   function pm_GetCellsIterator: IedCellsIterator;
   function pm_GetWidth: Integer;
   procedure pm_SetWidth(aValue: Integer);
   function pm_GetID: Integer;
   function Get_Processor: Ik2Processor;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aView: InevView;
    aPara: Tl3Variant;
    aColumnID: LongInt;
    const aProcessor: InevProcessor); reintroduce;
   class function Make(const aView: InevView;
    aPara: Tl3Variant;
    aColumnID: LongInt;
    const aProcessor: InevProcessor): IedColumn;
  public
   property Processor: InevProcessor
    read f_Processor
    write f_Processor;
    {* Процессор операций. }
   property Width: Integer
    read Get_Width
    write Set_Width;
    {* Ширина колонки. }
 end;//TevColumn
{$IfEnd} // Defined(evNeedEditableCursors)

{$IfEnd} // Defined(evUseVisibleCursors)
implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , l3Base
 , k2Tags
 , k2OpMisc
 , evMsgCode
 , l3InterfacesMisc
 , l3IID
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

{$If Defined(evNeedEditableCursors)}
function TevColumn.Get_Width: Integer;
//#UC START# *4F4C6F8902DF_4F4C6B940246get_var*
//#UC END# *4F4C6F8902DF_4F4C6B940246get_var*
begin
//#UC START# *4F4C6F8902DF_4F4C6B940246get_impl*
 Result := Para.AsObject.Child[ColumnID - 1].IntA[k2_tiWidth];
//#UC END# *4F4C6F8902DF_4F4C6B940246get_impl*
end;//TevColumn.Get_Width

procedure TevColumn.Set_Width(aValue: Integer);
//#UC START# *4F4C6F8902DF_4F4C6B940246set_var*
//#UC END# *4F4C6F8902DF_4F4C6B940246set_var*
begin
//#UC START# *4F4C6F8902DF_4F4C6B940246set_impl*
 ParaInst.OwnerPara.MakePoint.
  Formatting.Modify(View).ChangeParam(View, Self, Value + (aValue - Width),
                                k2StartOp(Processor, ev_msgChangeParam));
//#UC END# *4F4C6F8902DF_4F4C6B940246set_impl*
end;//TevColumn.Set_Width

constructor TevColumn.Create(const aView: InevView;
 aPara: Tl3Variant;
 aColumnID: LongInt;
 const aProcessor: InevProcessor);
//#UC START# *4F4C72360323_4F4C6B940246_var*
//#UC END# *4F4C72360323_4F4C6B940246_var*
begin
//#UC START# *4F4C72360323_4F4C6B940246_impl*
 inherited Create(aView, aPara, aColumnID + 1);
 Processor := aProcessor;
//#UC END# *4F4C72360323_4F4C6B940246_impl*
end;//TevColumn.Create

class function TevColumn.Make(const aView: InevView;
 aPara: Tl3Variant;
 aColumnID: LongInt;
 const aProcessor: InevProcessor): IedColumn;
//#UC START# *4F4C728500F4_4F4C6B940246_var*
var
 l_Column : TevColumn;
//#UC END# *4F4C728500F4_4F4C6B940246_var*
begin
//#UC START# *4F4C728500F4_4F4C6B940246_impl*
 l_Column := Create(aView, aPara, aColumnID, aProcessor);
 try
  Result := l_Column;
 finally
  l3Free(l_Column);
 end;//try..finally
//#UC END# *4F4C728500F4_4F4C6B940246_impl*
end;//TevColumn.Make

function TevColumn.pm_GetBackIterator: IedBackCellsIterator;
//#UC START# *4BBC9430038B_4F4C6B940246get_var*
//#UC END# *4BBC9430038B_4F4C6B940246get_var*
begin
//#UC START# *4BBC9430038B_4F4C6B940246get_impl*
 Assert(False);
 Result := nil;
//#UC END# *4BBC9430038B_4F4C6B940246get_impl*
end;//TevColumn.pm_GetBackIterator

function TevColumn.First(aNeedNeighbours: Boolean): IedCell;
 {* возвращает первую ячейку и начинает перебор }
//#UC START# *4BBC944C0195_4F4C6B940246_var*
//#UC END# *4BBC944C0195_4F4C6B940246_var*
begin
//#UC START# *4BBC944C0195_4F4C6B940246_impl*
 f_RowIndex := 0;
 Result := Next;
//#UC END# *4BBC944C0195_4F4C6B940246_impl*
end;//TevColumn.First

function TevColumn.Next: IedCell;
 {* возвращает следующую ячейку или nil, если перебор закончен }
//#UC START# *4BBC94640082_4F4C6B940246_var*
var
 l_Row  : InevPara;
 l_Cell : InevPara;
//#UC END# *4BBC94640082_4F4C6B940246_var*
begin
//#UC START# *4BBC94640082_4F4C6B940246_impl*
 Result := nil;
 with ParaInst.OwnerPara do
 begin
  if IsValid then 
  begin
   while (f_RowIndex < ParaCount) do
   begin
    l_Row := Para[f_RowIndex];
    with l_Row.AsList do
    begin
     Inc(f_RowIndex);
     if (ColumnID <= ChildrenCount) then
     begin
      l_Cell := Para[ColumnID - 1];
      if l3IOk(evQueryParaInterface(View,
                                    f_Processor,
                                    l_Cell,
                                    Tl3GUID_C(IedCell),
                                    Result)) then
       Break;
     end;//ColumnID <= ChildrenCount
    end;//with Child[f_Index]
   end;//while (f_RowIndex < ChildrenCount)
  end;//IsValid
 end;//with ParaInst.OwnerPara
//#UC END# *4BBC94640082_4F4C6B940246_impl*
end;//TevColumn.Next

function TevColumn.CellsCount: Integer;
 {* Количество ячеек }
//#UC START# *4BBC947B0399_4F4C6B940246_var*
//#UC END# *4BBC947B0399_4F4C6B940246_var*
begin
//#UC START# *4BBC947B0399_4F4C6B940246_impl*
 Result := ParaInst.OwnerPara.AsObject.ChildrenCount;
//#UC END# *4BBC947B0399_4F4C6B940246_impl*
end;//TevColumn.CellsCount

function TevColumn.pm_GetCellsIterator: IedCellsIterator;
//#UC START# *4BBCAEC2034D_4F4C6B940246get_var*
//#UC END# *4BBCAEC2034D_4F4C6B940246get_var*
begin
//#UC START# *4BBCAEC2034D_4F4C6B940246get_impl*
 Result := Self;
//#UC END# *4BBCAEC2034D_4F4C6B940246get_impl*
end;//TevColumn.pm_GetCellsIterator

function TevColumn.pm_GetWidth: Integer;
//#UC START# *4BBCAEF3001D_4F4C6B940246get_var*
//#UC END# *4BBCAEF3001D_4F4C6B940246get_var*
begin
//#UC START# *4BBCAEF3001D_4F4C6B940246get_impl*
 Result := Get_Width;
//#UC END# *4BBCAEF3001D_4F4C6B940246get_impl*
end;//TevColumn.pm_GetWidth

procedure TevColumn.pm_SetWidth(aValue: Integer);
//#UC START# *4BBCAEF3001D_4F4C6B940246set_var*
//#UC END# *4BBCAEF3001D_4F4C6B940246set_var*
begin
//#UC START# *4BBCAEF3001D_4F4C6B940246set_impl*
 Set_Width(aValue);
//#UC END# *4BBCAEF3001D_4F4C6B940246set_impl*
end;//TevColumn.pm_SetWidth

function TevColumn.pm_GetID: Integer;
//#UC START# *4BBCAF08019B_4F4C6B940246get_var*
//#UC END# *4BBCAF08019B_4F4C6B940246get_var*
begin
//#UC START# *4BBCAF08019B_4F4C6B940246get_impl*
 Result := ColumnID - 1;
//#UC END# *4BBCAF08019B_4F4C6B940246get_impl*
end;//TevColumn.pm_GetID

function TevColumn.Get_Processor: Ik2Processor;
//#UC START# *4BBF42BF004D_4F4C6B940246get_var*
//#UC END# *4BBF42BF004D_4F4C6B940246get_var*
begin
//#UC START# *4BBF42BF004D_4F4C6B940246get_impl*
 Result := f_Processor;
//#UC END# *4BBF42BF004D_4F4C6B940246get_impl*
end;//TevColumn.Get_Processor

procedure TevColumn.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F4C6B940246_var*
//#UC END# *479731C50290_4F4C6B940246_var*
begin
//#UC START# *479731C50290_4F4C6B940246_impl*
 Processor := nil;
 inherited;
//#UC END# *479731C50290_4F4C6B940246_impl*
end;//TevColumn.Cleanup

procedure TevColumn.ClearFields;
begin
 Processor := nil;
 inherited;
end;//TevColumn.ClearFields
{$IfEnd} // Defined(evNeedEditableCursors)

{$IfEnd} // Defined(evUseVisibleCursors)
end.
