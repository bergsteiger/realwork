unit evColumnBorderMarker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evColumnBorderMarker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevColumnBorderMarker
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
  l3Interfaces,
  nevTools,
  evInternalInterfaces,
  evMarker,
  l3Variant,
  nevBase,
  k2ToolPrim
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 RevColumnMarkerClass = class of TevColumnBorderMarker;

 _nevParaListTool_Parent_ = TevMarker;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 _RoundMarkerValue_Parent_ = _nevParaListTool_;
 {$Include ..\Everest\RoundMarkerValue.imp.pas}
 TevColumnBorderMarker = class(_RoundMarkerValue_, IevColumnBorderMarker)
 private
 // private fields
   f_ColumnID : Integer;
    {* Поле для свойства ColumnID}
 protected
 // realized methods
   function pm_GetColumnID: Integer;
   procedure pm_SetColumnID(aValue: Integer);
 protected
 // overridden protected methods
   procedure SetClientValue(aValue: Integer;
     const aContext: InevOp); override;
   function DoGetClientValue: Integer; override;
 public
 // overridden public methods
   procedure Assign(Source: Tk2ToolPrim); override;
 public
 // public methods
   constructor Create(const aView: InevView;
     aPara: Tl3Variant;
     aColumnID: Integer;
     const aHint: Il3CString = nil); reintroduce;
 public
 // public properties
   property ColumnID: Integer
     read f_ColumnID
     write f_ColumnID;
 end;//TevColumnBorderMarker
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  l3MinMax,
  nevFacade,
  k2Tags,
  SysUtils
  {$If defined(k2ForEditor)}
  ,
  evTableCellUtils
  {$IfEnd} //k2ForEditor
  
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

{$Include ..\Everest\RoundMarkerValue.imp.pas}

// start class TevColumnBorderMarker

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

{$IfEnd} //evUseVisibleCursors

end.