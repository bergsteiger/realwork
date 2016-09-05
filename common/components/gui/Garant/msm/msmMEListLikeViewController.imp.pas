{$IfNDef msmMEListLikeViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmMEListLikeViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmMEListLikeViewController" MUID: (57C977AE0264)
// Имя типа: "_msmMEListLikeViewController_"

{$Define msmMEListLikeViewController_imp}

 _msmMEListLikeViewController_ = {abstract} class(_msmMEListLikeViewController_Parent_)
  protected
   procedure DoGetItemFont(Sender: TObject;
    Index: LongInt;
    const aFont: Il3Font); override;
 end;//_msmMEListLikeViewController_

{$Else msmMEListLikeViewController_imp}

{$IfNDef msmMEListLikeViewController_imp_impl}

{$Define msmMEListLikeViewController_imp_impl}

procedure _msmMEListLikeViewController_.DoGetItemFont(Sender: TObject;
 Index: LongInt;
 const aFont: Il3Font);
//#UC START# *57B47A2102DE_57C977AE0264_var*
//#UC END# *57B47A2102DE_57C977AE0264_var*
begin
//#UC START# *57B47A2102DE_57C977AE0264_impl*
 if Self.Model.List[Index].BoolProp['IsSummoned'] then
  aFont.ForeColor := clRed
 else
 if not Self.Model.List[Index].BoolProp['IsFinished'] then
  aFont.ForeColor := clGreen;
//#UC END# *57B47A2102DE_57C977AE0264_impl*
end;//_msmMEListLikeViewController_.DoGetItemFont

{$EndIf msmMEListLikeViewController_imp_impl}

{$EndIf msmMEListLikeViewController_imp}

