unit evControlPara_Wrap;

// ћодуль: "w:\common\components\gui\Garant\Everest\evControlPara_Wrap.pas"
// —тереотип: "Wrapper"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTextPara_Wrap
 , ControlPara_Const
 , l3Variant
 , k2Base
;

type
 WevControlPara = class(WevTextPara)
  protected
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
   function PreGetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevControlPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , evdTypes
 , nevTools
 , k2Tags
 , evControlParaConst
 , l3Const
 , evQueryCardInt
 , ReqRow_Const
 , l3TreeInterfaces
 , evParaTools
 , SysUtils
 , ReqGroup_Const
;

function WevControlPara.GetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_4857FECB0092_var*
var
 l_Container : InevDocumentContainer;
 l_Data      : IUnknown;
 l_Control   : IevControl;
var
 l_Req : Tl3Variant;
 l_Def : Tl3Variant;
 l_C   : IevEditorFieldWithTree;
 l_Mod : Boolean;
 l_RP  : IqaReqPrim;
 l_N : Il3SimpleNode;
//#UC END# *4857A995029E_4857FECB0092_var*
begin
//#UC START# *4857A995029E_4857FECB0092_impl*
 Result := inherited GetAtomData(AE, aProp, Data);
 if not Result then
  case aProp.TagIndex of
(*   k2_tiObject:
   begin
    // - дерева пока нету - можно здесь дернуть CallBack и спросить у пользовател€
    //   где же его вз€ть.
    if AE.Box.QT(IevControl, l_Control) then
    begin
     l_Container := l_Control.DocumentContainer;
     if (l_Container = nil) OR (l_Container.TextSource = nil) then
      l_Data := nil
     else
      l_Data := l_Container.TextSource.GetControlData(l_Control)
    end//AE.Box.QT(IevControl, l_Control)
    else
     l_Data := nil;
    if (l_Data <> nil) then
    begin
     Result := True;
     AE.Attr[aProp.TagIndex] := Tk2Type(aProp.AtomType).IUnknownToTag(l_Data);
     Data := Integer(l_Data);
    end;//l_Data <> nil
   end;//k2_tiObject*)
   k2_tiText:
   begin
    if (TevControlType(AE.IntA[k2_tiType]) in evEditControls) then
    begin
     if AE.QT(IevEditorFieldWithTree, l_C) then
      try
       if evInPara(AE.AsObject, k2_typReqRow, l_Req) then
       begin
        l_Def := l_Req.Attr[k2_tiDefaultNode];
        if l_Def.IsValid then
        begin
         Supports(l_C.Req.ModelListener, IqaReqPrim, l_RP);
         if (l_RP <> nil) then
          l_Mod := l_RP.Modified
         else
          l_Mod := False;
         try
          if not l_Def.QI(Il3SimpleNode, l_N) then
           Assert(false);
          l_C.ShowNode(l_N);
         finally
          if (l_RP <> nil) then
           l_RP.Modified := l_Mod;
         end;//try..finally
         Result := AE.HasSubAtom(k2_tiText);
         if Result then
          Data := AE.Attr[k2_tiText]
         else
          Data := nil; 
        end;//l_Def.IsValid
       end;//evInPara(Self, k2_idReqRow)
      finally
       l_C := nil;
      end;//try..finally
     if not Result then
     begin
      if evInPara(AE.AsObject, k2_typReqRow, l_Req) then
      begin
       l_Def := l_Req.Attr[k2_tiDefaultText];
       if l_Def.IsValid then
       begin
        l_Def := l_Def.AsObject.CloneTag.AsObject;
        // - чтобы редактирование не испортило значение по-умолчанию
        AE.AttrW[k2_tiText, nil] := l_Def;
        Result := AE.HasSubAtom(k2_tiText);
        if Result then
         Data := l_Def
        else
         Data := nil;
 (*       if Result then
         Exclude(f_State, ns_nsDefaultsWasGot);
         // - чтобы вместо пустой строки подставл€лось значение по-умолчанию*)
       end;//l_Def.IsValid
      end;//evInPara(Self, k2_idReqRow)
     end;//not Result
    end;//TevControlType(AE.IntA[k2_tiType]) in evEditControls
   end;//k2_tiText
  end;//case aProp.TagIndex of
//#UC END# *4857A995029E_4857FECB0092_impl*
end;//WevControlPara.GetAtomData

function WevControlPara.PreGetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *48DD0CE60313_4857FECB0092_var*
var  
 l_Type : TevControlType;
 l_AlternateText: Tl3Variant;
 l_ReqGroup : Tl3Variant;
//#UC END# *48DD0CE60313_4857FECB0092_var*
begin
//#UC START# *48DD0CE60313_4857FECB0092_impl*
 Result := true;
 case aProp.TagIndex of
  k2_tiFirstLineIndent:
   Data := aProp.MakeTag(0).AsObject;
  k2_tiFirstIndent,
  k2_tiLeftIndent:
  begin
   l_Type := TevControlType(AE.IntA[k2_tiType]);
   if (l_Type = ev_ctPictureLabel) then
    Data := aProp.MakeTag(BefPictureLabel).AsObject
   else
   if (l_Type in evFlatBTNControls) then
    Data := aProp.MakeTag(BefBtbSpase).AsObject
   else
   if (l_Type = ev_ctMemoEdit) then
    Data := aProp.MakeTag((BefUpSpase * 2) * 4).AsObject
   else
   if (l_Type in evEditControls) then
    Data := aProp.MakeTag(BefUpSpase).AsObject
   else
    Data := aProp.MakeTag(BefSpace).AsObject;
  end;//k2_tiFirstIndent
  k2_tiRightIndent:
  begin
   l_Type := TevControlType(AE.IntA[k2_tiType]);
   if l_Type in evFlatBTNControls then
    Data := aProp.MakeTag(BefBtbSpase).AsObject
   else
   if (l_Type = ev_ctCalEdit) then
    Data := aProp.MakeTag(BtnWidth).AsObject
   else
   if (l_Type = ev_ctCombo) or (l_Type = ev_ctEllipsesEdit)
     or (l_Type = ev_ctSpinedit) then
    Data := aProp.MakeTag(ComboBtnWidth + l3Epsilon * 6).AsObject
   else
   if (l_Type = ev_ctPictureLabel) then
    Data := aProp.MakeTag(AfterPictureLabel).AsObject
   else
   if (l_Type = ev_ctMemoEdit) then
    Data := aProp.MakeTag(RightMemoSpase).AsObject
   else
    Data := aProp.MakeTag(BefSpace).AsObject;
  end;//k2_tiRightIndent
  k2_tiSpaceAfter,
  k2_tiSpaceBefore:
  begin
   l_Type := TevControlType(AE.IntA[k2_tiType]);
   if l_Type in (evFlatBTNControls + [ev_ctPictureLabel]) then
    Data := aProp.MakeTag(BefUpSpase).AsObject
   else
   if l_Type = ev_ctCollapsedPanel then
    Data := aProp.MakeTag(HalfBefSpace).AsObject
   else
    Data := aProp.MakeTag(BefUpSpase).AsObject;
  end;//k2_tiSpaceAfter
  k2_tiText, k2_tiSegments:
   if AE.BoolA[k2_tiCollapsed] then
   begin
    l_AlternateText := AE.Attr[k2_tiAlternateText];
    if not l_AlternateText.IsValid then
    begin
     Data := nil;
     Result := false;
     // - это ќЅя«ј“≈Ћ№Ќќ, иначе в _k2Tag_.cAtom "залипнет" null
     //   см. http://mdp.garant.ru/pages/viewpage.action?pageId=159351322
    end//not l_AlternateText
    else
    begin
     l_AlternateText := l_AlternateText.Attr[aProp.TagIndex];
     Result := l_AlternateText.IsValid;
     if Result then
      Data := l_AlternateText
     else
     begin
      Data := nil{Result := inherited PreGetAtomData(AE, aProp, Data)};
      Result := true;
     end;//Result
    end;//not l_AlternateText
   end//AE.BoolA[k2_tiCollapsed]
   else
    Result := inherited PreGetAtomData(AE, aProp, Data);
  k2_tiEnabled :
  begin
   {$IfDef evReqGroupNeedsRadio}
   if evInPara(AE, k2_idReqGroup, l_ReqGroup) then
   begin
    if not l_ReqGroup.BoolA[k2_tiChecked] then
    begin
     Data := Ord(false);
     Result := true;
     Exit;
    end;//not l_ReqGroup.BoolA[k2_tiChecked]
   end;//evInPara(AE, k2_idReqGroup, l_ReqGroup)
   {$EndIf evReqGroupNeedsRadio}
   Result := inherited PreGetAtomData(AE, aProp, Data);
  end;//k2_tiEnabled
  else
   Result := inherited PreGetAtomData(AE, aProp, Data);
 end;//case aProp.TagIndex of
//#UC END# *48DD0CE60313_4857FECB0092_impl*
end;//WevControlPara.PreGetAtomData
{$IfEnd} // Defined(k2ForEditor)

end.
