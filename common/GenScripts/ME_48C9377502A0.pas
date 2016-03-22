unit evTablePainter;
 {* Реализация интерфейса IevPainter для таблицы }

// Модуль: "w:\common\components\gui\Garant\Everest\evTablePainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTablePainter" MUID: (48C9377502A0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evFramedParaListPainter
 , nevRealTools
 , evCellsOffsets
 , l3Variant
 , nevTools
;

type
 TevTablePainter = class(TevFramedParaListPainter, IevTablePainter)
  {* Реализация интерфейса IevPainter для таблицы }
  private
   f_CellsOffsets: TevCellsOffsets;
  private
   function CellsOffsets: TevCellsOffsets;
  protected
   procedure CheckCell(aPara: Tl3Tag;
    aCheckType: TnevCheckType = nev_None);
   procedure CalcOffset;
    {* Пересчитать смещение для следующей ячейки }
   function WasPainted(aPara: Tl3Tag;
    anPID: Integer;
    aForLines: Boolean): Boolean;
    {* Проверка была ли отрисована начальная ячейка объединения. }
   {$If Defined(nsTest)}
   function NeedLog: Boolean; override;
    {* Поддерживает ли табличный объект запись в лог для тестов. }
   {$IfEnd} // Defined(nsTest)
   function HasOwnStyle: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoDraw: Boolean; override;
    {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure InitBottom(var theBottom: InevBasePoint;
    var theCellBottom: InevBasePoint); override;
   function BeforeDrawChild(const ChildPainter: IevPainter): Boolean; override;
    {* Вызывается перед рисованием каждого дочернего параграфа. }
   function GetTablePainter: IevTablePainter; override;
   procedure InitInnerBottom(const aChildInfo: TnevShapeInfo); override;
   function NeedsHackK235870994: Boolean; override;
   procedure AfterDrawChild(const aChild: InevPara;
    const aChildPainter: IevPainter;
    const aChildInfo: TnevShapeInfo); override;
 end;//TevTablePainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , SysUtils
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

function TevTablePainter.CellsOffsets: TevCellsOffsets;
//#UC START# *49CB6F2D03C8_48C9377502A0_var*
//#UC END# *49CB6F2D03C8_48C9377502A0_var*
begin
//#UC START# *49CB6F2D03C8_48C9377502A0_impl*
 if f_CellsOffsets = nil then
  f_CellsOffsets := TevCellsOffsets.Create;
 Result := f_CellsOffsets;
//#UC END# *49CB6F2D03C8_48C9377502A0_impl*
end;//TevTablePainter.CellsOffsets

procedure TevTablePainter.CheckCell(aPara: Tl3Tag;
 aCheckType: TnevCheckType = nev_None);
//#UC START# *49CB6BE30032_48C9377502A0_var*
//#UC END# *49CB6BE30032_48C9377502A0_var*
begin
//#UC START# *49CB6BE30032_48C9377502A0_impl*
 f_CellsOffsets.SetWidth(aPara.IntA[k2_tiWidth]);
 case TevMergeStatus(aPara.IntA[k2_tiMergeStatus]) of
  ev_msHead: begin
     f_CellsOffsets.CheckOffset(False);
     f_CellsOffsets.AddCellWidth;
    end; // ev_msHead
  ev_msNone: f_CellsOffsets.CheckOffset(False);
  ev_msContinue: if aCheckType <> nev_None then
   begin
    f_CellsOffsets.CheckOffset(False);
    if aCheckType = nev_NeedAdd then
    f_CellsOffsets.AddCellWidth;
   end;
 end; // case l_MergeStatus of
//#UC END# *49CB6BE30032_48C9377502A0_impl*
end;//TevTablePainter.CheckCell

procedure TevTablePainter.CalcOffset;
 {* Пересчитать смещение для следующей ячейки }
//#UC START# *49CB6C1A02DF_48C9377502A0_var*
//#UC END# *49CB6C1A02DF_48C9377502A0_var*
begin
//#UC START# *49CB6C1A02DF_48C9377502A0_impl*
 CellsOffsets.RecalcOffset;
//#UC END# *49CB6C1A02DF_48C9377502A0_impl*
end;//TevTablePainter.CalcOffset

function TevTablePainter.WasPainted(aPara: Tl3Tag;
 anPID: Integer;
 aForLines: Boolean): Boolean;
 {* Проверка была ли отрисована начальная ячейка объединения. }
//#UC START# *49CB6C2E02E2_48C9377502A0_var*
//#UC END# *49CB6C2E02E2_48C9377502A0_var*
begin
//#UC START# *49CB6C2E02E2_48C9377502A0_impl*
 Result := TevMergeStatus(aPara.IntA[k2_tiMergeStatus]) = ev_msContinue;
 if Result then
  Result := (f_CellsOffsets <> nil) and not f_CellsOffsets.CheckParam;
 if not Result and aForLines then
  if Area.rCanvas.Printing and (TopAnchor.Inner <> nil) and TopAnchor.Inner.HasHeadPart then
   Result := TopAnchor.Inner.InnerHead(anPID) <> nil
//#UC END# *49CB6C2E02E2_48C9377502A0_impl*
end;//TevTablePainter.WasPainted

{$If Defined(nsTest)}
function TevTablePainter.NeedLog: Boolean;
 {* Поддерживает ли табличный объект запись в лог для тестов. }
//#UC START# *4D0203AA016F_48C9377502A0_var*
//#UC END# *4D0203AA016F_48C9377502A0_var*
begin
//#UC START# *4D0203AA016F_48C9377502A0_impl*
 Result := True;
//#UC END# *4D0203AA016F_48C9377502A0_impl*
end;//TevTablePainter.NeedLog
{$IfEnd} // Defined(nsTest)

function TevTablePainter.HasOwnStyle: Boolean;
//#UC START# *52B2EF99032C_48C9377502A0_var*
//#UC END# *52B2EF99032C_48C9377502A0_var*
begin
//#UC START# *52B2EF99032C_48C9377502A0_impl*
 Result := evHasOwnStyle(ParaX);
//#UC END# *52B2EF99032C_48C9377502A0_impl*
end;//TevTablePainter.HasOwnStyle

procedure TevTablePainter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48C9377502A0_var*
//#UC END# *479731C50290_48C9377502A0_var*
begin
//#UC START# *479731C50290_48C9377502A0_impl*
 FreeAndNil(f_CellsOffsets);
 inherited;
//#UC END# *479731C50290_48C9377502A0_impl*
end;//TevTablePainter.Cleanup

function TevTablePainter.DoDraw: Boolean;
 {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
//#UC START# *4804BC2401C2_48C9377502A0_var*
//#UC END# *4804BC2401C2_48C9377502A0_var*
begin
//#UC START# *4804BC2401C2_48C9377502A0_impl*
(* if HackK235870994 then
  Result := true
 else*)
  Result := inherited DoDraw;
//#UC END# *4804BC2401C2_48C9377502A0_impl*
end;//TevTablePainter.DoDraw

procedure TevTablePainter.InitBottom(var theBottom: InevBasePoint;
 var theCellBottom: InevBasePoint);
//#UC START# *4804BC800172_48C9377502A0_var*
var
 l_Inn : InevBasePoint;
//#UC END# *4804BC800172_48C9377502A0_var*
begin
//#UC START# *4804BC800172_48C9377502A0_impl*
 l_Inn := theBottom.Inner;
 inherited InitBottom(theBottom, theCellBottom);
 if (l_Inn <> nil) AND l_Inn.AfterEnd and not theBottom.AfterEnd then
  if l_Inn.HasHeadPart and Area.rCanvas.Printing then
  begin
   theBottom.Inner := theBottom.Inner.Obj^.BaseLine4Print;
   theBottom.Inner.CopyHeadParts(l_Inn);
  end; // if l_Inn.HasHeadPart then
//#UC END# *4804BC800172_48C9377502A0_impl*
end;//TevTablePainter.InitBottom

function TevTablePainter.BeforeDrawChild(const ChildPainter: IevPainter): Boolean;
 {* Вызывается перед рисованием каждого дочернего параграфа. }
//#UC START# *481D6C56033A_48C9377502A0_var*
//#UC END# *481D6C56033A_48C9377502A0_var*
begin
//#UC START# *481D6C56033A_48C9377502A0_impl*
 Result := inherited BeforeDrawChild(ChildPainter);
 CellsOffsets.ClearOffset;    
//#UC END# *481D6C56033A_48C9377502A0_impl*
end;//TevTablePainter.BeforeDrawChild

function TevTablePainter.GetTablePainter: IevTablePainter;
//#UC START# *49DCA7F3011C_48C9377502A0_var*
//#UC END# *49DCA7F3011C_48C9377502A0_var*
begin
//#UC START# *49DCA7F3011C_48C9377502A0_impl*
 Result := Self;
//#UC END# *49DCA7F3011C_48C9377502A0_impl*
end;//TevTablePainter.GetTablePainter

procedure TevTablePainter.InitInnerBottom(const aChildInfo: TnevShapeInfo);
//#UC START# *4C4570AE0113_48C9377502A0_var*
var
 l_Inn : InevBasePoint;
//#UC END# *4C4570AE0113_48C9377502A0_var*
begin
//#UC START# *4C4570AE0113_48C9377502A0_impl*
 if Area.rNeedBottom then
  l_Inn := BottomAnchor.Inner;
 inherited;
 if Area.rNeedBottom and (l_Inn <> nil) then
  if l_Inn.HasHeadPart then
   BottomAnchor.Inner.CopyHeadParts(l_Inn);
//#UC END# *4C4570AE0113_48C9377502A0_impl*
end;//TevTablePainter.InitInnerBottom

function TevTablePainter.NeedsHackK235870994: Boolean;
//#UC START# *4CAF3D530327_48C9377502A0_var*
//#UC END# *4CAF3D530327_48C9377502A0_var*
begin
//#UC START# *4CAF3D530327_48C9377502A0_impl*
 Result := false{true};
              //^ - не нужно это, только всё портит, вызывая полное
              //    форматироание таблицы
//#UC END# *4CAF3D530327_48C9377502A0_impl*
end;//TevTablePainter.NeedsHackK235870994

procedure TevTablePainter.AfterDrawChild(const aChild: InevPara;
 const aChildPainter: IevPainter;
 const aChildInfo: TnevShapeInfo);
//#UC START# *4D63E3490015_48C9377502A0_var*
//#UC END# *4D63E3490015_48C9377502A0_var*
begin
//#UC START# *4D63E3490015_48C9377502A0_impl*
(* if f_WasStyle then
 begin
  Area.rCanvas.PopBC;
  f_WasStyle := False;
 end; // if f_WasStyle then *)
//#UC END# *4D63E3490015_48C9377502A0_impl*
end;//TevTablePainter.AfterDrawChild
{$IfEnd} // Defined(evNeedPainters)

end.
