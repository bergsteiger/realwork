unit evdEmptyRowFilter;

// Модуль: "w:\common\components\gui\Garant\Everest\evdEmptyRowFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdEmptyRowFilter" MUID: (4C07BD030266)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
;

type
 TevdEmptyRowFilter = class(TevdBufferedFilter)
  private
   f_Empty: Boolean;
    {* Признак, что строка пустаая. }
   f_MergedFlag: Boolean;
    {* Флаг для определения ситуации, что ни одного атрибута MergeStatus
        не было - это не значит, что строка пустая. }
   f_NeedCache: Boolean;
    {* Признак нужно ли начинать кеширование следующей строки. }
   f_OnlyHead: Boolean;
    {* Только ячейки начала объединения в строке. }
  protected
   procedure StartChild(TypeID: Tl3Type); override;
   procedure CloseStructure(NeedUndo: Boolean); override;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   function NeedStartBuffering(aID: Integer): Boolean; override;
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; override;
 end;//TevdEmptyRowFilter

implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
 , TableRow_Const
 , Table_Const
 , TableCell_Const
;

procedure TevdEmptyRowFilter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4C07BD030266_var*
//#UC END# *4836D4650177_4C07BD030266_var*
begin
//#UC START# *4836D4650177_4C07BD030266_impl*
 if TypeID = k2_typTable then
  f_NeedCache := False;
 if TypeID = k2_typTableRow then
  f_OnlyHead := True; 
 if TypeID = k2_typTableCell then
  f_MergedFlag := False;
 if (SkipLevel = 2) and not f_Empty then
  StopBufferingAndFlush(False, TopObject[0], False);
 inherited;
//#UC END# *4836D4650177_4C07BD030266_impl*
end;//TevdEmptyRowFilter.StartChild

procedure TevdEmptyRowFilter.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_4C07BD030266_var*
//#UC END# *4836D4C20059_4C07BD030266_var*
begin
//#UC START# *4836D4C20059_4C07BD030266_impl*
 if CurrentType.IsKindOf(k2_typTableCell) and not f_MergedFlag then
 begin
  f_Empty := False;
  f_OnlyHead := False;
 end; // if CurrentType.IsKindOf(k2_typTableCell) and not f_MergedFlag then
 if CurrentType.IsKindOf(k2_typTableRow) and not f_OnlyHead then
  f_NeedCache := False;
 inherited;
//#UC END# *4836D4C20059_4C07BD030266_impl*
end;//TevdEmptyRowFilter.CloseStructure

procedure TevdEmptyRowFilter.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_4C07BD030266_var*
var
 l_MS : TevMergeStatus;
//#UC END# *4836D52400D9_4C07BD030266_var*
begin
//#UC START# *4836D52400D9_4C07BD030266_impl*
 if AtomIndex = k2_tiMergeStatus then
 begin
  l_MS := TevMergeStatus(VariantAsInteger(AtomIndex, Value));
  if l_MS <> ev_msContinue then
   f_Empty := False;
  if l_MS = ev_msHead then
   f_NeedCache := True
  else
   if l_MS = ev_msNone then
    f_OnlyHead := False;
  f_MergedFlag := True;
 end;
 inherited;
//#UC END# *4836D52400D9_4C07BD030266_impl*
end;//TevdEmptyRowFilter.AddAtomEx

function TevdEmptyRowFilter.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_4C07BD030266_var*
//#UC END# *4C56D54B002A_4C07BD030266_var*
begin
//#UC START# *4C56D54B002A_4C07BD030266_impl*
 Result := (aID = -k2_idTableRow) and f_NeedCache;
 if Result then
 begin
  f_Empty := True;
  f_NeedCache := False;
 end;
//#UC END# *4C56D54B002A_4C07BD030266_impl*
end;//TevdEmptyRowFilter.NeedStartBuffering

function TevdEmptyRowFilter.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_4C07BD030266_var*
//#UC END# *4CF7BC520161_4C07BD030266_var*
begin
//#UC START# *4CF7BC520161_4C07BD030266_impl*
 Result := not f_Empty;
 if f_Empty then
  f_NeedCache := True;
//#UC END# *4CF7BC520161_4C07BD030266_impl*
end;//TevdEmptyRowFilter.NeedFlushBuffer

end.
