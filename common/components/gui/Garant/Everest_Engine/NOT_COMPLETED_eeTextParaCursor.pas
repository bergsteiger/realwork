unit NOT_COMPLETED_eeTextParaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_COMPLETED_eeTextParaCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeTextParaCursor" MUID: (54BE4A4902B9)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(evUseVisibleCursors)}
 , evTextParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 , eeInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , l3Interfaces
;

type
 TeeTextParaCursor = class(TevTextParaCursor)
  private
   function Editor: IeeEditor;
  protected
   function IsReadOnly(const aView: InevView): Boolean;
   function ShowComments(const aView: InevView): Boolean;
   {$If Defined(evUseVisibleCursors)}
   function DoJoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp;
    MoveSubs: Boolean): Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   function DoSplit(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   function DoInsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp;
    InsertMode: Boolean;
    aFlags: TnevInsertStringFlags): Boolean; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   function DoDeleteString(const aView: InevView;
    aCount: Integer;
    const anOp: InevOp;
    aFlags: TnevInsertStringFlags): Boolean; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   function GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
 end;//TeeTextParaCursor

implementation

uses
 l3ImplUses
 , eeCursorTools
 {$If Defined(Nemesis)}
 , eePara
 {$IfEnd} // Defined(Nemesis)
 , evdStyles
 , LeafPara_Const
 , eeInterfacesEx
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2OpMisc
 , CommentPara_Const
 , SysUtils
 , evOp
;

{$If Defined(evUseVisibleCursors)}
function TeeTextParaCursor.Editor: IeeEditor;
//#UC START# *54BE4B260181_54BE4A4902B9_var*
//#UC END# *54BE4B260181_54BE4A4902B9_var*
begin
//#UC START# *54BE4B260181_54BE4A4902B9_impl*
 Result := eeEditorByPara(ParaX);
//#UC END# *54BE4B260181_54BE4A4902B9_impl*
end;//TeeTextParaCursor.Editor

function TeeTextParaCursor.IsReadOnly(const aView: InevView): Boolean;
//#UC START# *54BE4B830300_54BE4A4902B9_var*
//#UC END# *54BE4B830300_54BE4A4902B9_var*
begin
//#UC START# *54BE4B830300_54BE4A4902B9_impl*
 Result := eeIsReadOnlyPara(aView, ParaX);
//#UC END# *54BE4B830300_54BE4A4902B9_impl*
end;//TeeTextParaCursor.IsReadOnly

function TeeTextParaCursor.ShowComments(const aView: InevView): Boolean;
//#UC START# *54BE4BE30128_54BE4A4902B9_var*
//#UC END# *54BE4BE30128_54BE4A4902B9_var*
begin
//#UC START# *54BE4BE30128_54BE4A4902B9_impl*
 if (aView <> nil) then
  Result := not (-ev_saUserComment in aView.Metrics.HiddenStyles)
 else
  Result := true;
//#UC END# *54BE4BE30128_54BE4A4902B9_impl*
end;//TeeTextParaCursor.ShowComments

function TeeTextParaCursor.DoJoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp;
 MoveSubs: Boolean): Integer;
//#UC START# *49DEFB410161_54BE4A4902B9_var*
var
 l_Leaf   : IeeStyledLeafPara;
 l_Editor : IeeEditor;
 l_P      : InevPara;
//#UC END# *49DEFB410161_54BE4A4902B9_var*
begin
//#UC START# *49DEFB410161_54BE4A4902B9_impl*
 l_Editor := Editor;
 if (l_Editor <> nil) then
  try
   if aSecondPara.IsKindOf(k2_typLeafPara) then
   begin
    l_Leaf := TeeStyledLeafPara.Make(aSecondPara.AsObject, l_Editor As IeeDocumentEx);
    try
     if IsReadOnly(aView) then
     begin
      if ShowComments(aView) then
      begin
       if l_Leaf.IsUserComment AND not evHasText(aSecondPara.AsObject) then
        l_Leaf.Delete;
      end;//ShowComments(aView)
      Result := -1
     end//IsReadOnly
     else
     if l_Leaf.IsUserComment then
      Result := inherited DoJoinWith(aView, aSecondPara, anOp, MoveSubs)
     else
     if not evHasText(GetRedirect) then
      Result := -2
     else
     if not aSecondPara.Owner.IsValid then
     // - если вставляем новый параграф, то с ним объединять можно
     // http://mdp.garant.ru/pages/viewpage.action?pageId=108233434
      Result := inherited DoJoinWith(aView, aSecondPara, anOp, MoveSubs)
     else
      Result := -1;
    finally
     l_Leaf := nil;
    end;//try..finally
   end//aPara.IsKindOf(k2_typLeafPara)
   else
   begin
    if not evHasText(GetRedirect) then
     Result := -2
    else
    begin
     if aSecondPara.IsKindOf(k2_typCommentPara) then
     begin
      if (aSecondPara.ChildrenCount = 1) and aSecondPara.Owner.IsValid then      
      begin
       if not evHasText(aSecondPara.Child[0]) then
        if aSecondPara.QT(InevPara, l_P, k2Proc(anOp)) then
         l_P.Edit.Delete(False, anOp)
        else
         Assert(false);
      end;//aPara.ChildrenCount = 1
     end;//aPara.IsKindOf(k2_typCommentPara)
     Result := -1;
    end;//not evHasText(GetRedirect^)
   end;//aPara.IsKindOf(k2_typLeafPara) 
  finally
   l_Editor := nil;
  end//try..finally
 else
 if EvDeleteIfReadOnly(ParaX) then
  Result := 0
 else
  Result := inherited DoJoinWith(aView, aSecondPara, anOp, MoveSubs);
  // - это не специфический редактор - можно объединять параграфы
//#UC END# *49DEFB410161_54BE4A4902B9_impl*
end;//TeeTextParaCursor.DoJoinWith

function TeeTextParaCursor.DoSplit(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *49DEFB770015_54BE4A4902B9_var*
var
 l_Editor   : IeeEditor;
 l_Para     : IeeStyledLeafPara;
 l_NextPara : IeeStyledLeafPara;
//#UC END# *49DEFB770015_54BE4A4902B9_var*
begin
//#UC START# *49DEFB770015_54BE4A4902B9_impl*
 Result := Tl3NullTag.Instance;
 if ShowComments(aView) then
 begin
  if IsReadOnly(aView) then
  begin
   l_Editor := Editor;
   if (l_Editor <> nil) then
    try
     l_Para := TeeTextPara.Make(GetRedirect.Box, l_Editor As IeeDocumentEx);
     try
      if Supports(l_Para.Next, IeeStyledLeafPara, l_NextPara) then
       try
        if l_NextPara.IsUserComment then
        // - следующий за нами - комментарий
        begin
         Self.pm_GetParentPoint.Move(aView, ev_ocNextParaTopLeft{ev_ocParaDown}, anOp);
         // - надо сместиться на следующий параграф
         //Result := k2_typTextPara.New;
         Exit;
        end;//l_NextPara.IsUserComment
       finally
        l_NextPara := nil;
       end;//try..finally
      SetEntryPoint(High(Integer), anOp);
      // Ниже делаем блок для комментария:
      Result := inherited DoSplit(aView, aFlags, anOp);
     finally
      l_Para := nil;
     end;//try..finally
    finally
     l_Editor := nil;
    end//try..finally
   else
    Result := inherited DoSplit(aView, aFlags, anOp);
    // - это неспецифический редактор - умничать не надо
  end//IsReadOnly
  else
   Result := inherited DoSplit(aView, aFlags, anOp);
   // - а здесь просто разрываем параграф внутри комментария
 end;//ShowComments(aView)
//#UC END# *49DEFB770015_54BE4A4902B9_impl*
end;//TeeTextParaCursor.DoSplit

function TeeTextParaCursor.DoInsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp;
 InsertMode: Boolean;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F71601D6_54BE4A4902B9_var*
//#UC END# *4A38F71601D6_54BE4A4902B9_var*
begin
//#UC START# *4A38F71601D6_54BE4A4902B9_impl*
 if IsReadOnly(aView) then
  Result := false
 else
 if evIsInReadOnlyPara(ParaX) then
  Result := false
 else
  Result := inherited DoInsertString(aView, aString, anOp, InsertMode, aFlags);
//#UC END# *4A38F71601D6_54BE4A4902B9_impl*
end;//TeeTextParaCursor.DoInsertString

function TeeTextParaCursor.DoDeleteString(const aView: InevView;
 aCount: Integer;
 const anOp: InevOp;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F748002D_54BE4A4902B9_var*
//#UC END# *4A38F748002D_54BE4A4902B9_var*
begin
//#UC START# *4A38F748002D_54BE4A4902B9_impl*
 if IsReadOnly(aView) then
  Result := true
 else
 if EvDeleteIfReadOnly(ParaX) then
  Result := true  
 else
  Result := inherited DoDeleteString(aView, aCount, anOp, aFlags); 
//#UC END# *4A38F748002D_54BE4A4902B9_impl*
end;//TeeTextParaCursor.DoDeleteString

function TeeTextParaCursor.GetInevDataFormattingModify(const aView: InevView): InevDataFormattingModify;
//#UC START# *4A3A61DC00AB_54BE4A4902B9_var*
//#UC END# *4A3A61DC00AB_54BE4A4902B9_var*
begin
//#UC START# *4A3A61DC00AB_54BE4A4902B9_impl*
 if IsReadOnly(aView) OR evIsInReadOnlyPara(ParaX) then
  Result := nil
 else
  Result := inherited GetInevDataFormattingModify(aView); 
//#UC END# *4A3A61DC00AB_54BE4A4902B9_impl*
end;//TeeTextParaCursor.GetInevDataFormattingModify
{$IfEnd} // Defined(evUseVisibleCursors)

end.
