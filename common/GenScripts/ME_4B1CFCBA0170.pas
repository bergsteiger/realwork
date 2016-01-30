{$IfNDef nevParaListAnchorModify_imp}

// ������: "w:\common\components\gui\Garant\Everest\nevParaListAnchorModify.imp.pas"
// ���������: "Impurity"

{$Define nevParaListAnchorModify_imp}

{$If Defined(evUseVisibleCursors)}
 _nevParaListAnchorModify_ = class(_nevParaListAnchorModify_Parent_)
  protected
   procedure SetPID(aValue: Integer); virtual; abstract;
   function Limit: Integer;
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; virtual;
   function GetPID: Integer; virtual; abstract;
   procedure DoBottom(const aView: InevView); override;
   function DoIncLinePrim(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean): Integer; override;
 end;//_nevParaListAnchorModify_

{$Else Defined(evUseVisibleCursors)}

_nevParaListAnchorModify_ = _nevParaListAnchorModify_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevParaListAnchorModify_imp}

{$IfNDef nevParaListAnchorModify_imp_impl}

{$Define nevParaListAnchorModify_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevParaListAnchorModify_.Limit: Integer;
//#UC START# *4B1D167302CD_4B1CFCBA0170_var*
//#UC END# *4B1D167302CD_4B1CFCBA0170_var*
begin
//#UC START# *4B1D167302CD_4B1CFCBA0170_impl*
 Result := ParaX.ToList.Count;
//#UC END# *4B1D167302CD_4B1CFCBA0170_impl*
end;//_nevParaListAnchorModify_.Limit

function _nevParaListAnchorModify_.DoIncLine(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean;
 const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4B1CFCBA0170_var*
var
 l_ChildPoint : InevBasePoint;
//#UC END# *4B1D18650208_4B1CFCBA0170_var*
begin
//#UC START# *4B1D18650208_4B1CFCBA0170_impl*
 Result := 0;
 l_ChildPoint := Self.GetInner; 
 if (l_ChildPoint <> nil) AND l_ChildPoint.AsObject.IsValid then
  if not l_ChildPoint.AsObject.BoolA[k2_tiCollapsed] then
   Inc(Result, l_ChildPoint.IncLine(aView, theLine, aSmall));
  // - ������� ������� - ����� �����������
//#UC END# *4B1D18650208_4B1CFCBA0170_impl*
end;//_nevParaListAnchorModify_.DoIncLine

procedure _nevParaListAnchorModify_.DoBottom(const aView: InevView);
//#UC START# *4B1CFD7B0332_4B1CFCBA0170_var*
var
 l_CA : InevBasePoint;
//#UC END# *4B1CFD7B0332_4B1CFCBA0170_var*
begin
//#UC START# *4B1CFD7B0332_4B1CFCBA0170_impl*
 LockScroll;
 try
  if ParaX.IsVertical then
   SetPID(Pred(Limit));
  l_CA := Self.GetInner;
  if (l_CA <> nil) then
   l_CA.Bottom(aView);
  SignalScroll;
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD7B0332_4B1CFCBA0170_impl*
end;//_nevParaListAnchorModify_.DoBottom

function _nevParaListAnchorModify_.DoIncLinePrim(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean): Integer;
//#UC START# *4B1CFD9401A2_4B1CFCBA0170_var*

 function Sign(aValue: Integer): Integer;
 begin//Sign
  if (aValue < 0) then
   Result := -1
  else
  if (aValue > 0) then
   Result := +1
  else
   Result := 0;
 end;//Sign

var
 l_MoveDistance : Integer;
 l_Mul          : Integer;
 l_Sign         : Integer;
 l_WasLongJump  : Integer;          
 
 procedure IncLine;
 begin//IncLine
  theLine := theLine - l_MoveDistance * l_Mul;
  if (Sign(theLine) <> l_Sign) then
   theLine := 0;
  if (l_Mul > 1) then
   Inc(l_WasLongJump);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=255982818
 end;//IncLine

var
 l_FI           : TnevFormatInfoPrim;
 l_List         : InevObjectList;
 l_ChildPoint   : InevBasePoint;
 l_Pos          : Integer;
 l_Child        : InevObject;
 l_PrevPos      : Integer;
 l_WasMove      : Boolean;
 l_CI           : TnevChildrenInfo;
// l_HalfChildren : Integer;
//#UC END# *4B1CFD9401A2_4B1CFCBA0170_var*
begin
//#UC START# *4B1CFD9401A2_4B1CFCBA0170_impl*
 l_Pos := 0;
 Result := 0;
 if (theLine = 0) then
  Exit;
 l_Sign := Sign(theLine); 
 LockScroll;
 try
  l_List := ParaX.ToList;
  if l_List.AsObject.IsValid then
  begin
   l_CI.rLeafCount := l_List.LeafShapeCount;
   l_CI.rCountMinus1 := Pred(l_List.Count);
   l_CI.rLinear := l_List.AlmostLinear;
   l_WasLongJump := 0;
   while (theLine <> 0) do
   begin
    Inc(Result, DoIncLine(aView, theLine, aSmall, l_CI));
(*    if (l_WasLongJump > 0) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=255982818
    begin
     theLine := 0;
     break;
    end;//l_WasLongJump*)
    if (theLine <> 0) then
    begin
     if not ParaX.IsVertical then
      break;
     l_WasMove := false;
     l_Mul := 1;
     // - ��-��������� ������������ ��������������� �� ������ ������� � �������
     //   ������ �������
     l_MoveDistance := l_Sign;
     if not aSmall then
     begin
      if l_CI.rLinear then
      // - ������ ���������� �������� ��� ����������� �������� - ����� ��������
      //   ����� ��������� �� ���������� ����� �����, � �� �� ������ 
       l_MoveDistance := theLine
      else
      begin
       if (theLine > 0) then
       // - ������������ ����
       begin
        if (theLine > 3) OR (l_CI.rLeafCount > l_CI.rCountMinus1) then
        // http://mdp.garant.ru/pages/viewpage.action?pageId=217685637
        // ����� ����������� �������� l_Anchor.IncLine � TevDocumentPreviewPrim.DoPrint SkipSectionBreak
         if AtStart AND (theLine >= l_CI.rLeafCount) then
         // - ������ ��������� � ������ ����� � ����� ����� ��������� �����
         //   �������� ������ ����������� �����������.
         begin
          if not l_CI.rLinear OR (Abs(theLine) < l_CI.rLeafCount * 4) then
          // - ���� �� ����� ������ �������, �� �� ���� �������������� �� ������
          // http://mdp.garant.ru/pages/viewpage.action?pageId=254353230
           Bottom(aView)
          else
           SetPID(l_CI.rCountMinus1);
          // - ������������ ������ � ����� ����� �����
          l_WasMove := true;
          l_MoveDistance := l_CI.rLeafCount;
          // - �� ����������� ����������� ����� ����� ������� ����� �����
          //   ��������� �����
         end;//AtStart
       end//theLine > 0
       else
       // - ������������ �����
       begin
        if AtEnd(aView) AND (Abs(theLine) >= l_CI.rLeafCount) then
        // - ������ ��������� � ����� ����� � ����� ����� ��������� �����
        //   �������� ������ ����������� �����������.
        begin
         SetPID(0);
         // - ������������ ������ � ����� ������ �����
         l_WasMove := true;
         l_MoveDistance := -l_CI.rLeafCount;
         // - �� ����������� ����������� ����� ����� ������� ����� �����
         //   ��������� �����
        end;//AtEnd
       end;//theLine > 0
       if not l_WasMove then
       // - ��� �� ���������, ����� ������� ��������� ����������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=216072862
       begin
        //if (Abs(theLine) > 200) then
        // - ���������� ������� ������
        begin
         //if (l_CI.rLeafCount div Abs(theLine) > 4) then
         // - ������ ������ ������ ����� ��������� �����
         begin
(*          if l_List.InheritsFrom(k2_idTable) then
          // - ������������ ������ ��� ������
          //   !!! ������� ��-�������� ��� �������� ���� ������� �����������
          begin
           if (l_CI.rCountMinus1 = 0) then
            l_Mul := 1
           else
            l_Mul := Max(1, l_CI.rLeafCount div l_CI.rCountMinus1);
           l_MoveDistance := theLine;
          end//l_List.InheritsFrom(k2_idTable)
          else*)
          if (Abs(theLine) > 500 * (l_WasLongJump + 1)) AND
                              // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=255982818&focusedCommentId=259884433#comment-259884433
                              //   �� ������ �������� �������� ����� �������� ������
             (Abs(theLine) < l_CI.rLeafCount)
             // - ������������ ��� ������� ���������� � ������� ����� http://mdp.garant.ru/pages/viewpage.action?pageId=254353230
             //AND (l_CI.rLeafCount > 2000)
             // - �������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=255982818
             then
          begin
          // - ������ ������� ������
           if (l_CI.rCountMinus1 = 0) then
            l_Mul := 1
           else
            l_Mul := Max(1, l_CI.rLeafCount div l_CI.rCountMinus1);
           //l_Mul := l_Mul div 3;
           // - ���� �������� ��������� �������� ��������
           if (l_Mul = 0) then
            l_Mul := 1; 
           l_MoveDistance := (theLine div l_Mul) div 3;
                                              //^ - �������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=255982818
                                              // ���� ����� � �� ��������, � ����� ������
(*           l_HalfChildren := (l_CI.rCountMinus1 + 1) div 2;
           if (Abs(l_MoveDistance) > l_HalfChildren) then
           begin
            if (theLine < 0) then
             l_MoveDistance := -l_HalfChildren
            else
             l_MoveDistance := +l_HalfChildren;
           end//Abs(l_MoveDistance) > l_HalfChildren
           else*)
           if (l_MoveDistance = 0) then
            l_MoveDistance := l_Sign;
           if (l_MoveDistance = l_Sign) then
            // - ������� ��������� �������� �����������
            l_Mul := 1;
          end//Abs(theLine) > 500
          ;
         end;//l_CI.rLeafCount div Abs(theLine) > ..
        end;//Abs(theLine) >..
       end;//not l_WasMove
      end;//l_CI.rLinear
     end;//not aSmall
     if not l_WasMove then
     // - ���� ��� �� �������� ������, �� ���� ��������� �������, �� �������
     //   ��� ���� �����������
     begin
      l_PrevPos := GetPID;
      l_Pos := l_PrevPos + l_MoveDistance;
      l_Pos := Max(l_Pos, nev_piFirst);
      l_Pos := Min(l_Pos, l_CI.rCountMinus1);
      l_MoveDistance := (l_Pos - l_PrevPos);
     end;//not l_WasMove
     if (l_MoveDistance = 0) then
     // - ������� �� ����� - ����� ������ ������� ��������
      break
     else
     begin
      if l_WasMove then
      // - ������ ��� ����������� - ���������� ��� �� ����, ���� ���� ������
      //   ����� ����� �����
       IncLine
      else
      begin
       if (aSmall OR (Abs(theLine) < l_CI.rLeafCount * 4)) then
       // http://mdp.garant.ru/pages/viewpage.action?pageId=254353230
       begin
        l_ChildPoint := Self.GetInner; // ���������� �����
        l_Child := l_List[l_Pos];
        l_FI := aView.FormatInfoByPara(l_Child);
        if (l_FI <> nil) and not l_FI.IsHidden(false, true) then
         IncLine;
        SetPID(l_Child.PID);
        Assert(GetInner.Obj^.AsObject.IsSame(l_Child.AsObject));
        if (l_MoveDistance > 0) and
           (l_ChildPoint <> nil) and
           l_ChildPoint.AsObject.IsValid and
           l_ChildPoint.HasBaseLine then
         if HasInner then
          GetInner.CompareWithOtherInner(aView);
          // ���������� �������������� ������� �����.
       end//aSmall OR Abs(theLine) < l_CI.rLeafCount
       else
       begin
        // - ����� ���� ������� "������" �� ������ ����� � �� ������� �� �������
        // http://mdp.garant.ru/pages/viewpage.action?pageId=254353230
        IncLine;
        SetPID(l_Pos);
       end;//aSmall OR Abs(theLine) < l_CI.rLeafCount
      end;//l_WasMove
      Inc(Result, l_MoveDistance * l_Mul);
      // - ����������� ����� ���������� ���������, �� ������� ����������� ������
      //   ��� �������� ������������ ��� ������������� ����������� �������,
      //   ������������ � ���������
      if l_WasMove then
      // - ������� �� ����� - ����� ������ ������� ��������, �.�. ���� �����
      //   ����� ��� ����
       Break;
      if (l_MoveDistance < 0) then
      // - ���� ���� �������� �����, �� ���� ������ � ����� ����� ����������
      //   �������
      begin
       l_ChildPoint := Self.GetInner;
       if (l_ChildPoint <> nil) AND l_ChildPoint.AsObject.IsValid and
          not l_ChildPoint.AsObject.BoolA[k2_tiCollapsed] then
        l_ChildPoint.Bottom(aView);
      end;//l_MoveDistance < 0
     end;//l_MoveDistance <> 0
    end;//theLine <> 0
   end;//theLine <> 0
   SignalScroll;
  end;//l_List.IsValid
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD9401A2_4B1CFCBA0170_impl*
end;//_nevParaListAnchorModify_.DoIncLinePrim
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevParaListAnchorModify_imp_impl}

{$EndIf nevParaListAnchorModify_imp}

