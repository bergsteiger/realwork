{$IfNDef nevAnchorModify_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevAnchorModify.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevAnchorModify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevAnchorModify_imp}
{$If defined(evUseVisibleCursors)}
 _nevAnchorModify_ = {mixin} class(_nevAnchorModify_Parent_)
 public
 // realized methods
   procedure Bottom(const aView: InevView);
   function IncLine(const aView: InevView;
    var theLine: Integer;
    aByLine: Boolean): Integer;
     {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
 protected
 // protected methods
   procedure DoBottom(const aView: InevView); virtual; abstract;
   function DoIncLinePrim(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean): Integer; virtual; abstract;
   procedure LockScroll;
   procedure UnlockScroll;
   procedure SignalScroll;
   procedure DoSignalScroll; virtual;
   procedure DoLockScroll; virtual;
   procedure DoUnlockScroll; virtual;
 end;//_nevAnchorModify_
{$Else}

 _nevAnchorModify_ = _nevAnchorModify_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevAnchorModify_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevAnchorModify_

procedure _nevAnchorModify_.LockScroll;
//#UC START# *4B1D08300007_4B1CFB8E0090_var*
//#UC END# *4B1D08300007_4B1CFB8E0090_var*
begin
//#UC START# *4B1D08300007_4B1CFB8E0090_impl*
 DoLockScroll;
//#UC END# *4B1D08300007_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.LockScroll

procedure _nevAnchorModify_.UnlockScroll;
//#UC START# *4B1D084A0125_4B1CFB8E0090_var*
//#UC END# *4B1D084A0125_4B1CFB8E0090_var*
begin
//#UC START# *4B1D084A0125_4B1CFB8E0090_impl*
 DoUnlockScroll;
//#UC END# *4B1D084A0125_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.UnlockScroll

procedure _nevAnchorModify_.SignalScroll;
//#UC START# *4B1D08680377_4B1CFB8E0090_var*
//#UC END# *4B1D08680377_4B1CFB8E0090_var*
begin
//#UC START# *4B1D08680377_4B1CFB8E0090_impl*
 DoSignalScroll;
//#UC END# *4B1D08680377_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.SignalScroll

procedure _nevAnchorModify_.DoSignalScroll;
//#UC START# *4B1D08980098_4B1CFB8E0090_var*
//#UC END# *4B1D08980098_4B1CFB8E0090_var*
begin
//#UC START# *4B1D08980098_4B1CFB8E0090_impl*
//#UC END# *4B1D08980098_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.DoSignalScroll

procedure _nevAnchorModify_.DoLockScroll;
//#UC START# *4B1D08AA027C_4B1CFB8E0090_var*
//#UC END# *4B1D08AA027C_4B1CFB8E0090_var*
begin
//#UC START# *4B1D08AA027C_4B1CFB8E0090_impl*
//#UC END# *4B1D08AA027C_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.DoLockScroll

procedure _nevAnchorModify_.DoUnlockScroll;
//#UC START# *4B1D08E001CF_4B1CFB8E0090_var*
//#UC END# *4B1D08E001CF_4B1CFB8E0090_var*
begin
//#UC START# *4B1D08E001CF_4B1CFB8E0090_impl*
//#UC END# *4B1D08E001CF_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.DoUnlockScroll

procedure _nevAnchorModify_.Bottom(const aView: InevView);
//#UC START# *47C5C2970095_4B1CFB8E0090_var*
//#UC END# *47C5C2970095_4B1CFB8E0090_var*
begin
//#UC START# *47C5C2970095_4B1CFB8E0090_impl*
 DoBottom(aView);
//#UC END# *47C5C2970095_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.Bottom

function _nevAnchorModify_.IncLine(const aView: InevView;
  var theLine: Integer;
  aByLine: Boolean): Integer;
//#UC START# *47C5C2A40309_4B1CFB8E0090_var*
//#UC END# *47C5C2A40309_4B1CFB8E0090_var*
begin
//#UC START# *47C5C2A40309_4B1CFB8E0090_impl*
 Result := DoIncLinePrim(aView, theLine, aByLine);
//#UC END# *47C5C2A40309_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.IncLine

{$IfEnd} //evUseVisibleCursors

{$EndIf nevAnchorModify_imp}
