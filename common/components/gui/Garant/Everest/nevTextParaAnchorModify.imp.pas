{$IfNDef nevTextParaAnchorModify_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevTextParaAnchorModify.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevTextParaAnchorModify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevTextParaAnchorModify_imp}
{$If defined(evUseVisibleCursors)}
 _nevTextParaAnchorModify_ = {mixin} class(_nevTextParaAnchorModify_Parent_)
 protected
 // realized methods
   procedure DoBottom(const aView: InevView); override;
   function DoIncLinePrim(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean): Integer; override;
 protected
 // protected methods
   procedure SetLinePrim(aValue: Integer;
    aMap: TnevFormatInfoPrim); virtual; abstract;
 end;//_nevTextParaAnchorModify_
{$Else}

 _nevTextParaAnchorModify_ = _nevTextParaAnchorModify_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevTextParaAnchorModify_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevTextParaAnchorModify_

procedure _nevTextParaAnchorModify_.DoBottom(const aView: InevView);
//#UC START# *4B1CFD7B0332_4B1CFD19035B_var*
var
 l_FI : TnevFormatInfoPrim;
//#UC END# *4B1CFD7B0332_4B1CFD19035B_var*
begin
//#UC START# *4B1CFD7B0332_4B1CFD19035B_impl*
 LockScroll;
 try
  l_FI := aView.FormatInfoByPara(ParaX);
  // ??? почему тут не l_FI := aView.FormatInfoByPoint(Self);
  SetLinePrim(evTextParaLineCount(l_FI) - 1, l_FI);
  SignalScroll;
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD7B0332_4B1CFD19035B_impl*
end;//_nevTextParaAnchorModify_.DoBottom

function _nevTextParaAnchorModify_.DoIncLinePrim(const aView: InevView;
  var theLine: Integer;
  aSmall: Boolean): Integer;
//#UC START# *4B1CFD9401A2_4B1CFD19035B_var*
var
 l_Pos  : Integer;
 l_Diff : Integer;
 l_SC   : Integer;
 l_FI   : TnevFormatInfoPrim;
 l_Line : Integer;
//#UC END# *4B1CFD9401A2_4B1CFD19035B_var*
begin
//#UC START# *4B1CFD9401A2_4B1CFD19035B_impl*
 Assert(ParaX.IsVertical);
 Result := 0;
 if (theLine = 0) OR not aSmall then
  Exit;
 LockScroll;
 try
  l_FI := aView.FormatInfoByPara(ParaX);
  // ??? почему тут не l_FI := aView.FormatInfoByPoint(Self);
  l_SC := Pred(evTextParaLineCount(l_FI));
  if (l_FI <> nil) then
  // - это может пока случится для встроенных объектов (формул)
   if l_FI.IsHidden(false, true) then
    Exit;
  if (theLine <> 0) then
  begin
   l_Line := VertPosition(aView, l_FI);
   l_Pos := l_Line + theLine;
   l_Pos := Max(l_Pos, nev_piFirst);
   l_Pos := Min(l_Pos, l_SC);
   l_Diff := (l_Pos - l_Line);
   if (l_Diff <> 0) then
   begin
    theLine := theLine - l_Diff;
    SetLinePrim(l_Pos, l_FI);
    SignalScroll;
   end;//l_Diff <> 0
  end;//theLine <> 0
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD9401A2_4B1CFD19035B_impl*
end;//_nevTextParaAnchorModify_.DoIncLinePrim

{$IfEnd} //evUseVisibleCursors

{$EndIf nevTextParaAnchorModify_imp}
