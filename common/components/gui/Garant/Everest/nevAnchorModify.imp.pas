{$IfNDef nevAnchorModify_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevAnchorModify.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevAnchorModify" MUID: (4B1CFB8E0090)
// Имя типа: "_nevAnchorModify_"

{$Define nevAnchorModify_imp}

{$If Defined(evUseVisibleCursors)}
 _nevAnchorModify_ = class(_nevAnchorModify_Parent_)
  protected
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
  public
   procedure Bottom(const aView: InevView);
   function IncLine(const aView: InevView;
    var theLine: Integer;
    aByLine: Boolean): Integer;
    {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
 end;//_nevAnchorModify_

{$Else Defined(evUseVisibleCursors)}

_nevAnchorModify_ = _nevAnchorModify_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevAnchorModify_imp}

{$IfNDef nevAnchorModify_imp_impl}

{$Define nevAnchorModify_imp_impl}

{$If Defined(evUseVisibleCursors)}
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
 {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
//#UC START# *47C5C2A40309_4B1CFB8E0090_var*
//#UC END# *47C5C2A40309_4B1CFB8E0090_var*
begin
//#UC START# *47C5C2A40309_4B1CFB8E0090_impl*
 Result := DoIncLinePrim(aView, theLine, aByLine);
//#UC END# *47C5C2A40309_4B1CFB8E0090_impl*
end;//_nevAnchorModify_.IncLine
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevAnchorModify_imp_impl}

{$EndIf nevAnchorModify_imp}

