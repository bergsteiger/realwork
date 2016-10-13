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
   function DoGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer; override;
 end;//_msmMEListLikeViewController_

{$Else msmMEListLikeViewController_imp}

{$IfNDef msmMEListLikeViewController_imp_impl}

{$Define msmMEListLikeViewController_imp_impl}

procedure _msmMEListLikeViewController_.DoGetItemFont(Sender: TObject;
 Index: LongInt;
 const aFont: Il3Font);
//#UC START# *57B47A2102DE_57C977AE0264_var*
var
 l_E : ImsmModelElement;
//#UC END# *57B47A2102DE_57C977AE0264_var*
begin
//#UC START# *57B47A2102DE_57C977AE0264_impl*
 inherited;
 if (Index < 0) then
  Exit;
 l_E := Self.Model.List[Index];
 if (l_E <> nil) then
  with l_E do
  begin
   aFont.Italic := BoolProp['IsSummoned'];
   aFont.Strikeout := not BoolProp['IsFinished'];
   if IsDeleted then
    aFont.Strikeout := true;
   aFont.ForeColor := IntProp['msm:View:ForeColor'];
  end;//with l_E
//#UC END# *57B47A2102DE_57C977AE0264_impl*
end;//_msmMEListLikeViewController_.DoGetItemFont

function _msmMEListLikeViewController_.DoGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *57D9022D0322_57C977AE0264_var*
//#UC END# *57D9022D0322_57C977AE0264_var*
begin
//#UC START# *57D9022D0322_57C977AE0264_impl*
 Result := TmsmMEImages.Instance.GetMEImageByPropName(Self.Model.List[Index], Self.InitContext.rImageNameProp, aImages);
//#UC END# *57D9022D0322_57C977AE0264_impl*
end;//_msmMEListLikeViewController_.DoGetItemImage

{$EndIf msmMEListLikeViewController_imp_impl}

{$EndIf msmMEListLikeViewController_imp}

