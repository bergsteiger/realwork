unit evNSRCPlusWriter;
 {* Писатель формата NSRC+. Для решения задачи [$91848978]. }

// Модуль: "w:\common\components\gui\Garant\Everest\evNSRCPlusWriter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevNSRCPlusWriter" MUID: (4836CFF1028E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomNSRCWriter
 , evdTypes
 , l3Variant
 , k2Interfaces
 , l3ProtoIntegerList
 , l3Interfaces
;

type
 TevFramePartIndexes = set of Tl3FramePartIndex;

 _DigitalSeparatorSupport_Parent_ = TevCustomNSRCWriter;
 {$Include w:\common\components\gui\Garant\Everest\DigitalSeparatorSupport.imp.pas}
 _CellsCountStack_Parent_ = _DigitalSeparatorSupport_;
 {$Include w:\common\components\gui\Garant\Everest\CellsCountStack.imp.pas}
 TevNSRCPlusWriter = class(_CellsCountStack_)
  {* Писатель формата NSRC+. Для решения задачи [$91848978]. }
  private
   f_Frame: TevFramePartIndexes;
   f_MergeStatus: TevMergeStatus;
   f_CellWidth: Integer;
   f_VerticalAlignment: TevVerticalAligment;
   f_CellOpened: Boolean;
    {* Ячейка была начата. Сбрасывается сразу после выливки рамки! }
  protected
   procedure OutNewString(const aValue: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure StartChild(TypeID: Tl3Type); override;
   procedure StartTag(TagID: Integer); override;
   procedure CloseStructure(NeedUndo: Boolean); override;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure OutEOL; override;
    {* Выводит конец строки. }
   procedure CheckDigitalSeparatorAlignment; override;
    {* Корректировка стиля на наличие выравнивания по разделителю. }
  public
   function GetCellOpened: Boolean;
 end;//TevNSRCPlusWriter

implementation

uses
 l3ImplUses
 , k2Base
 , k2Tags
 , SysUtils
 , SBS_Const
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , evdFrame_Const
 , TabStop_Const
 , l3String
 //#UC START# *4836CFF1028Eimpl_uses*
 //#UC END# *4836CFF1028Eimpl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\DigitalSeparatorSupport.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\CellsCountStack.imp.pas}

function TevNSRCPlusWriter.GetCellOpened: Boolean;
//#UC START# *52BC39E70137_4836CFF1028E_var*
//#UC END# *52BC39E70137_4836CFF1028E_var*
begin
//#UC START# *52BC39E70137_4836CFF1028E_impl*
 Result := f_CellOpened;
//#UC END# *52BC39E70137_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.GetCellOpened

procedure TevNSRCPlusWriter.OutNewString(const aValue: AnsiString);
//#UC START# *483A65DA031D_4836CFF1028E_var*
//#UC END# *483A65DA031D_4836CFF1028E_var*
begin
//#UC START# *483A65DA031D_4836CFF1028E_impl*
 OutEOL;
 OutString(aValue);
//#UC END# *483A65DA031D_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.OutNewString

procedure TevNSRCPlusWriter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4836CFF1028E_var*
//#UC END# *479731C50290_4836CFF1028E_var*
begin
//#UC START# *479731C50290_4836CFF1028E_impl*
 FreeCellsCountStack;
 inherited;
//#UC END# *479731C50290_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.Cleanup

procedure TevNSRCPlusWriter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4836CFF1028E_var*
var
 CT : Tk2Type;
//#UC END# *4836D4650177_4836CFF1028E_var*
begin
//#UC START# *4836D4650177_4836CFF1028E_impl*
 inherited;
 CT := CurrentType;
 if CT.IsKindOf(k2_typTable) then
 begin
  CellFinished;
  CheckNeed2AddBlock;
  OutNewString('!TABLE ');
  if CT.IsKindOf(k2_typSBS) then
   OutString('1')
  else
   OutString('0');
 end//CT.IsKindOf(k2_typTable)
 else
 if CT.IsKindOf(k2_typTableRow) then
 begin
  PushCellsCount;
 end
 else
 if CT.IsKindOf(k2_typTableCell) then
 begin
  if GetTopValue = 0 then
   OutNewString('!ROW');
  IncTopValue;
  CellStarted;
  f_MergeStatus := ev_msNone;
  f_VerticalAlignment := TevVerticalAligment(Tk2Prop(CT.Prop[k2_tiVerticalAligment]).DefaultValue);
  Case Tk2Prop(CT.Prop[k2_tiFrame]).DefaultValue of
   evd_fvEmpty:
    f_Frame := [];
   evd_fvSolid:
    f_Frame := [Low(Tl3FramePartIndex)..High(Tl3FramePartIndex)];
   else
   begin
    f_Frame := [];
    Assert(false);
   end;//else
  end;//Case CT.Prop[k2_tiFrame].DefaultValue
  f_CellWidth := 0;
  OutNewString('!CELL');
  f_CellOpened := true;
  ClearBothParas;
  // - <K>: 121160433 - чтобы не склеивались стили одинаковых параграфов
 end;//CT.IsKindOf(k2_typTableCell)
//#UC END# *4836D4650177_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.StartChild

procedure TevNSRCPlusWriter.StartTag(TagID: Integer);
//#UC START# *4836D477022A_4836CFF1028E_var*
//#UC END# *4836D477022A_4836CFF1028E_var*
begin
//#UC START# *4836D477022A_4836CFF1028E_impl*
 inherited;
 if (TagID = k2_tiFrame) then
 begin
  if TopType[1].IsKindOf(k2_typTableCell) then
   f_Frame := [];
   // - раз рамка началась - значит она имеет собственные компоненты
 end//TagID = k2_tiFrame
 else
 if (TagID = k2_tiFrameUp) OR (TagID = k2_tiFrameDown) OR
    (TagID = k2_tiFrameLeft) OR (TagID = k2_tiFrameRight) then
 begin
  if TopType[2].IsKindOf(k2_typTableCell) then
  begin
   Assert(f_CellOpened);
   Case TagID of
    k2_tiFrameUp:
     Include(f_Frame, l3_fpiUp);
    k2_tiFrameDown:
     Include(f_Frame, l3_fpiDown);
    k2_tiFrameLeft:
     Include(f_Frame, l3_fpiLeft);
    k2_tiFrameRight:
     Include(f_Frame, l3_fpiRight);
   end;//Case TagID
  end;//TopType[2].IsKindOf(k2_typTableCell)
 end;//TagID = k2_tiFrameUp..
//#UC END# *4836D477022A_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.StartTag

procedure TevNSRCPlusWriter.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_4836CFF1028E_var*
var
 CT : Tk2Type;
 l_CBP : Boolean;
//#UC END# *4836D4C20059_4836CFF1028E_var*
begin
//#UC START# *4836D4C20059_4836CFF1028E_impl*
 CT := CurrentType;
 l_CBP := true;
 if CT.IsKindOf(k2_typTable) then
  OutNewString('!TABLEEND')
 else
 if CT.IsKindOf(k2_typTableRow) then
 begin
  if GetTopValue > 0 then
  begin
   OutNewString('!ROWEND');
   PopCellsCount;
  end;
 end
 else
 if CT.IsKindOf(k2_typTableCell) then
 begin
  OutNewString('!CELLEND');
  CellFinished;
 end
 else
  l_CBP := false;
 if l_CBP then
  ClearBothParas;
 inherited;
//#UC END# *4836D4C20059_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.CloseStructure

procedure TevNSRCPlusWriter.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_4836CFF1028E_var*
var
 CT : Tk2Type;
 l_Frame : Tl3Tag;
 l_V : Integer;
//#UC END# *4836D52400D9_4836CFF1028E_var*
begin
//#UC START# *4836D52400D9_4836CFF1028E_impl*
 CT := CurrentType;
 if (AtomIndex = k2_tiFrame) then
 begin
  l_Frame := Value.AsVariant;
  if (l_Frame <> nil) AND l_Frame.IsValid then
  begin
   StartTag(k2_tiFrame);
   try
    l_Frame.WriteTag(Self);
   finally
    Finish;
   end;//try..finally
  end;//l_Frame <> nil
  Exit;
 end;//AtomIndex = k2_tiFrame
 if CT.IsKindOf(k2_typTable) then
 begin
  Case AtomIndex of
   k2_tiLeftIndent:
    OutNewString(Format('!LEFTINDENT %d', [VariantAsInteger(AtomIndex, Value)]));
   k2_tiZoom:
    OutNewString(Format('!ZOOM %d', [VariantAsInteger(AtomIndex, Value)]));
  end;//Case AtomIndex
 end//CT.IsKindOf(k2_typTable)
 else
 if CT.IsKindOf(k2_typTableCell) then
 begin
  Assert(f_CellOpened);  
  Case AtomIndex of
   k2_tiWidth:
    f_CellWidth := Abs(VariantAsInteger(AtomIndex, Value));
   k2_tiMergeStatus:
   begin
    l_V := VariantAsInteger(AtomIndex, Value);
    if ((l_V >= Ord(Low(TevMergeStatus))) AND
       (l_V <= Ord(High(TevMergeStatus)))) then
     f_MergeStatus := TevMergeStatus(l_V)
    else
     f_MergeStatus := Low(TevMergeStatus)
   end;//k2_tiMergeStatus
   k2_tiVerticalAligment:
   begin
    l_V := VariantAsInteger(AtomIndex, Value);
    if ((l_V >= Ord(Low(TevVerticalAligment))) AND
       (l_V <= Ord(High(TevVerticalAligment)))) then
     f_VerticalAlignment := TevVerticalAligment(l_V)
    else
     f_VerticalAlignment := Low(TevVerticalAligment);
   end;//k2_tiVerticalAligment
   else
    inherited;
  end;//Case AtomIndex
 end//CT.IsKindOf(k2_typTableCell)
 else
 if CT.IsKindOf(k2_typTabStop) then
 begin
  SetDigitalSeparatorParams(AtomIndex, Value);
  inherited;
 end // if CT.IsKindOf(k2_typTabStop) then
 else
  inherited;
//#UC END# *4836D52400D9_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.AddAtomEx

procedure TevNSRCPlusWriter.OutEOL;
 {* Выводит конец строки. }
//#UC START# *483A6DE30208_4836CFF1028E_var*

 procedure OutFramePart(aPart: Tl3FramePartIndex);
 begin//OutFramePart
  if (aPart in f_Frame) then
   OutString('1')
  else
   OutString('0'); 
 end;//OutFramePart

var
 l_WasCellOpened: Boolean;
//#UC END# *483A6DE30208_4836CFF1028E_var*
begin
//#UC START# *483A6DE30208_4836CFF1028E_impl*
 l_WasCellOpened := f_CellOpened;
 if f_CellOpened then
 begin
  f_CellOpened := false;
  OutString(Format(' %d ', [f_CellWidth]));
  // Порядок выливки рамок определен в <K> : 91848978
  OutFramePart(l3_fpiRight);
  OutFramePart(l3_fpiLeft);
  OutFramePart(l3_fpiUp);
  OutFramePart(l3_fpiDown);
  OutString(Format(' %d %d', [Ord(f_MergeStatus), Ord(f_VerticalAlignment)]));
  f_MergeStatus := Low(TevMergeStatus);
  f_VerticalAlignment := Low(TevVerticalAligment);
 end;//f_CellOpened
 inherited;
 if l_WasCellOpened then
  OutStyle4Cell;
//#UC END# *483A6DE30208_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.OutEOL

procedure TevNSRCPlusWriter.CheckDigitalSeparatorAlignment;
 {* Корректировка стиля на наличие выравнивания по разделителю. }
//#UC START# *4E3924CE03A3_4836CFF1028E_var*
//#UC END# *4E3924CE03A3_4836CFF1028E_var*
begin
//#UC START# *4E3924CE03A3_4836CFF1028E_impl*
 if HasDigitalSeparatorAlignment then
  with f_CurParaParas.Style do
  begin
   Letter := 'D';
   ParaLI := Pixel2Char(f_DecimalOffset);
   ParaFI := 0;
   ContinueCell;
  end; // with f_CurParaParas.Style do
//#UC END# *4E3924CE03A3_4836CFF1028E_impl*
end;//TevNSRCPlusWriter.CheckDigitalSeparatorAlignment

end.
