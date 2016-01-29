unit evTableColumn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTableColumn.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evTableColumn
//
// Реализация интерфейса IedColumn для колонки таблицы.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevBase,
  nevTools,
  evEditorInterfaces,
  evColumnBorderMarker,
  l3Variant
  ;

{$If defined(evNeedEditableCursors) AND defined(evUseVisibleCursors)}
type
 TevColumn = class(TevColumnBorderMarker, IedCellsIterator, IedColumn)
  {* Реализует интерфейс IedColumn для колонки таблицы. }
 private
 // private fields
   f_RowIndex : Integer;
   f_Processor : InevProcessor;
    {* Поле для свойства Processor}
 protected
 // property methods
   function Get_Width: Integer;
   procedure Set_Width(aValue: Integer);
 protected
 // realized methods
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
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aView: InevView;
     aPara: Tl3Variant;
     aColumnID: LongInt;
     const aProcessor: InevProcessor); reintroduce;
   class function Make(const aView: InevView;
     aPara: Tl3Variant;
     aColumnID: LongInt;
     const aProcessor: InevProcessor): IedColumn;
 public
 // public properties
   property Processor: InevProcessor
     read f_Processor
     write f_Processor;
     {* Процессор операций. }
   property Width: Integer
     read Get_Width
     write Set_Width;
     {* Ширина колонки. }
 end;//TevColumn
{$IfEnd} //evNeedEditableCursors AND evUseVisibleCursors
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  l3Base,
  k2Tags,
  k2OpMisc,
  evMsgCode,
  l3InterfacesMisc,
  l3IID
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  
  ;

{$If defined(evNeedEditableCursors) AND defined(evUseVisibleCursors)}

// start class TevColumn

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
//#UC START# *4BBC944C0195_4F4C6B940246_var*
//#UC END# *4BBC944C0195_4F4C6B940246_var*
begin
//#UC START# *4BBC944C0195_4F4C6B940246_impl*
 f_RowIndex := 0;
 Result := Next;
//#UC END# *4BBC944C0195_4F4C6B940246_impl*
end;//TevColumn.First

function TevColumn.Next: IedCell;
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
//#UC START# *479731C50290_4F4C6B940246_var*
//#UC END# *479731C50290_4F4C6B940246_var*
begin
//#UC START# *479731C50290_4F4C6B940246_impl*
 Processor := nil;
 inherited;
//#UC END# *479731C50290_4F4C6B940246_impl*
end;//TevColumn.Cleanup

procedure TevColumn.ClearFields;
 {-}
begin
 {$If defined(evNeedEditableCursors) AND defined(evUseVisibleCursors)}
 Processor := nil;
 {$IfEnd} //evNeedEditableCursors AND evUseVisibleCursors
 inherited;
end;//TevColumn.ClearFields

{$IfEnd} //evNeedEditableCursors AND evUseVisibleCursors
{$IfEnd} //evUseVisibleCursors

end.