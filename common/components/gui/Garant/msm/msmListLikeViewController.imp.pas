{$IfNDef msmListLikeViewController_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmListLikeViewController.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmListLikeViewController" MUID: (57B6BF8A0210)
// Имя типа: "_msmListLikeViewController_"

{$Define msmListLikeViewController_imp}

 _msmListLikeViewController_ = {abstract} class(_msmListLikeViewController_Parent_)
  private
   procedure DoCharToItem(Sender: TObject;
    var SrchStr: AnsiString;
    aFromCurrent: Boolean;
    var Index: LongInt);
   procedure DoGetItemFont(Sender: TObject;
    Index: LongInt;
    const aFont: Il3Font); virtual;
  protected
   procedure DoCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt); virtual;
   procedure DoActionElement(Sender: TObject;
    Index: LongInt); virtual;
   procedure InitOwnView; override;
 end;//_msmListLikeViewController_

{$Else msmListLikeViewController_imp}

{$IfNDef msmListLikeViewController_imp_impl}

{$Define msmListLikeViewController_imp_impl}

procedure _msmListLikeViewController_.DoCharToItem(Sender: TObject;
 var SrchStr: AnsiString;
 aFromCurrent: Boolean;
 var Index: LongInt);
//#UC START# *57B5E02201F7_57B6BF8A0210_var*
var
 I     : LongInt;
 Len   : Word;
 Res   : Integer;
//#UC END# *57B5E02201F7_57B6BF8A0210_var*
begin
//#UC START# *57B5E02201F7_57B6BF8A0210_impl*
 Len := Length(SrchStr);
 Index := -1;
 TmsmWaitCursor.Make;
 for I := 0 to Pred(Self.Model.List.Count) do
 begin
  Res := l3AnsiStrLICompExt(PAnsiChar(SrchStr),
                            l3PCharLen(Self.Model.List.StringsToFind[I]).S,
                            Len);
  if (Res = 0) then
  begin
   Index := I;
   Break;
  end;//Res = 0
  {if Res > 0 then Exit;   --if sorted only}
 end;//for I
//#UC END# *57B5E02201F7_57B6BF8A0210_impl*
end;//_msmListLikeViewController_.DoCharToItem

procedure _msmListLikeViewController_.DoCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *57B3192403D2_57B6BF8A0210_var*
//#UC END# *57B3192403D2_57B6BF8A0210_var*
begin
//#UC START# *57B3192403D2_57B6BF8A0210_impl*
 if (Self.Model.List = nil) then
  Self.Model.CurrentElement := nil
 else
  Self.Model.CurrentElement := Self.Model.List[aNewCurrent];
//#UC END# *57B3192403D2_57B6BF8A0210_impl*
end;//_msmListLikeViewController_.DoCurrentChanged

procedure _msmListLikeViewController_.DoActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *57AB1EAE00C7_57B6BF8A0210_var*
//#UC END# *57AB1EAE00C7_57B6BF8A0210_var*
begin
//#UC START# *57AB1EAE00C7_57B6BF8A0210_impl*
 Self.Model.ElementToAction := Self.Model.List[Index];
//#UC END# *57AB1EAE00C7_57B6BF8A0210_impl*
end;//_msmListLikeViewController_.DoActionElement

procedure _msmListLikeViewController_.DoGetItemFont(Sender: TObject;
 Index: LongInt;
 const aFont: Il3Font);
//#UC START# *57B47A2102DE_57B6BF8A0210_var*
//#UC END# *57B47A2102DE_57B6BF8A0210_var*
begin
//#UC START# *57B47A2102DE_57B6BF8A0210_impl*
//#UC END# *57B47A2102DE_57B6BF8A0210_impl*
end;//_msmListLikeViewController_.DoGetItemFont

procedure _msmListLikeViewController_.InitOwnView;
//#UC START# *57ADFB33027D_57B6BF8A0210_var*
//#UC END# *57ADFB33027D_57B6BF8A0210_var*
begin
//#UC START# *57ADFB33027D_57B6BF8A0210_impl*
 inherited;
 OwnView.OnActionElement := Self.DoActionElement;
 OwnView.OnCurrentChanged := Self.DoCurrentChanged;
 OwnView.OnCharToItem := Self.DoCharToItem;
 OwnView.MultiStrokeItem := InitContext.rMultiStrokeItem;
 OwnView.OnGetItemFont := Self.DoGetItemFont;
//#UC END# *57ADFB33027D_57B6BF8A0210_impl*
end;//_msmListLikeViewController_.InitOwnView

{$EndIf msmListLikeViewController_imp_impl}

{$EndIf msmListLikeViewController_imp}

