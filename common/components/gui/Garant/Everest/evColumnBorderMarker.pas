unit evColumnBorderMarker;

// Модуль: "w:\common\components\gui\Garant\Everest\evColumnBorderMarker.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevColumnBorderMarker" MUID: (4E3A539401D7)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evMarker
 , evInternalInterfaces
 , nevTools
 , l3Variant
 , l3Interfaces
 , nevBase
 , k2ToolPrim
;

type
 RevColumnMarkerClass = class of TevColumnBorderMarker;

 _nevParaListTool_Parent_ = TevMarker;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 _RoundMarkerValue_Parent_ = _nevParaListTool_;
 {$Include w:\common\components\gui\Garant\Everest\RoundMarkerValue.imp.pas}
 TevColumnBorderMarker = class(_RoundMarkerValue_, IevColumnBorderMarker)
  private
   f_ColumnID: Integer;
  protected
   function pm_GetColumnID: Integer;
   procedure pm_SetColumnID(aValue: Integer);
   procedure SetClientValue(aValue: Integer;
    const aContext: InevOp); override;
   function DoGetClientValue: Integer; override;
  public
   constructor Create(const aView: InevView;
    aPara: Tl3Variant;
    aColumnID: Integer;
    const aHint: Il3CString = nil); reintroduce;
   procedure Assign(Source: Tk2ToolPrim); override;
  public
   property ColumnID: Integer
    read f_ColumnID
    write f_ColumnID;
 end;//TevColumnBorderMarker
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , l3MinMax
 , nevFacade
 , k2Tags
 , SysUtils
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
 //#UC START# *4E3A539401D7impl_uses*
 //#UC END# *4E3A539401D7impl_uses*
;

type _Instance_R_ = TevColumnBorderMarker;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\RoundMarkerValue.imp.pas}

constructor TevColumnBorderMarker.Create(const aView: InevView;
 aPara: Tl3Variant;
 aColumnID: Integer;
 const aHint: Il3CString = nil);
//#UC START# *4E3A54F80016_4E3A539401D7_var*
//#UC END# *4E3A54F80016_4E3A539401D7_var*
begin
//#UC START# *4E3A54F80016_4E3A539401D7_impl*
 f_ColumnID := aColumnID;
 inherited Create(aView, aPara, k2_tiWidth, ev_pmsColumnBorder, aHint);
//#UC END# *4E3A54F80016_4E3A539401D7_impl*
end;//TevColumnBorderMarker.Create

function TevColumnBorderMarker.pm_GetColumnID: Integer;
//#UC START# *4A2625D4012E_4E3A539401D7get_var*
//#UC END# *4A2625D4012E_4E3A539401D7get_var*
begin
//#UC START# *4A2625D4012E_4E3A539401D7get_impl*
 Result := f_ColumnID;
//#UC END# *4A2625D4012E_4E3A539401D7get_impl*
end;//TevColumnBorderMarker.pm_GetColumnID

procedure TevColumnBorderMarker.pm_SetColumnID(aValue: Integer);
//#UC START# *4A2625D4012E_4E3A539401D7set_var*
//#UC END# *4A2625D4012E_4E3A539401D7set_var*
begin
//#UC START# *4A2625D4012E_4E3A539401D7set_impl*
 f_ColumnID := aValue;
//#UC END# *4A2625D4012E_4E3A539401D7set_impl*
end;//TevColumnBorderMarker.pm_SetColumnID

procedure TevColumnBorderMarker.SetClientValue(aValue: Integer;
 const aContext: InevOp);
//#UC START# *4E3A3F0D0388_4E3A539401D7_var*
var
 l_Delta : Integer;
 l_Width : Integer;
//#UC END# *4E3A3F0D0388_4E3A539401D7_var*
begin
//#UC START# *4E3A3F0D0388_4E3A539401D7_impl*
 l_Delta := CalcDelta(aValue, ClientValue);
 if (l_Delta <> 0) then
 begin
(*  CheckProcessor(aContext);
  SetTagQT(TagInst); // <- <K> : 142614141*)
  with ParaX[f_ColumnID - 1] do
  begin
   l_Width := IntA[k2_tiWidth];
   Inc(l_Delta, l_Width);
   if (l_Delta <= 100) then
    Exit
   else
    IntW[k2_tiWidth, aContext] := l_Delta;
  end;//with ParaX..
 end;//l_Delta <> 0
//#UC END# *4E3A3F0D0388_4E3A539401D7_impl*
end;//TevColumnBorderMarker.SetClientValue

function TevColumnBorderMarker.DoGetClientValue: Integer;
//#UC START# *4E3A4C4B03A0_4E3A539401D7_var*
var
 i : Integer;
//#UC END# *4E3A4C4B03A0_4E3A539401D7_var*
begin
//#UC START# *4E3A4C4B03A0_4E3A539401D7_impl*
 with ParaX do
 begin
  Result := IntA[k2_tiLeftIndent];
  for i := 1 to Min(ParaCount, f_ColumnID) do
   Inc(Result, Para[i - 1].AsObject.IntA[k2_tiWidth]); 
 end;//with ParaX
//#UC END# *4E3A4C4B03A0_4E3A539401D7_impl*
end;//TevColumnBorderMarker.DoGetClientValue

procedure TevColumnBorderMarker.Assign(Source: Tk2ToolPrim);
//#UC START# *52BC1DD60298_4E3A539401D7_var*
//#UC END# *52BC1DD60298_4E3A539401D7_var*
begin
//#UC START# *52BC1DD60298_4E3A539401D7_impl*
 inherited;
 if (Source Is TevColumnBorderMarker) then
  f_ColumnID := TevColumnBorderMarker(Source).f_ColumnID;
//#UC END# *52BC1DD60298_4E3A539401D7_impl*
end;//TevColumnBorderMarker.Assign
{$IfEnd} // Defined(evUseVisibleCursors)

end.
