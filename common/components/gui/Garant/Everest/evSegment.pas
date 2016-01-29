unit evSegment;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evSegment.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ParaUtils::evSegment
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevBase,
  l3Variant
  ;

function EvSegmentHasSomeFormat(aSegment: Tl3Variant): Boolean;
   {* ���������� - ����� �� ������� ���� �����-�� ����������, �������� �� ������������. }
procedure EvSegmentSetFontParam(aSegment: Tl3Variant;
  anAtom: LongInt;
  aValue: Tl3Variant;
  const aContext: InevOp = nil);
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  Segment_Const,
  k2Tags,
  evResultFont,
  k2Prim,
  k2Except,
  k2BaseTypes,
  k2Base,
  l3Types
  ;

// unit methods

{$If defined(k2ForEditor) AND not defined(Nemesis)}
function CheckApply2Para(anAtom: Tl3Variant): Boolean;
//#UC START# *502206170304_4A3919200142_var*
//#UC END# *502206170304_4A3919200142_var*
begin
//#UC START# *502206170304_4A3919200142_impl*
 Result := anAtom.Attr[k2_tiApply2Para].IsValid;
 if Result then
  Result := anAtom.BoolA[k2_tiApply2Para];
//#UC END# *502206170304_4A3919200142_impl*
end;//CheckApply2Para
{$IfEnd} //k2ForEditor AND not Nemesis

procedure EvSegmentAssignSegment(aDestSegment: Tl3Variant;
  aSegment: Tl3Variant;
  const anOpPack: InevOp);
//#UC START# *502206D80305_4A3919200142_var*

  function AssignToFont(aFont: Tl3Variant): Boolean;
  var
   l_Font : TevResultFont;
  begin//AssignToFont
   with l_Font do
   begin
    Init;                       
    try
     if aSegment.HasSubAtom(k2_tiStyle) then
      AddStyledTag(aSegment)
     else
      AddTag(aSegment);
     Result := AssignToAtom(aFont);
    finally
     Clear;
    end;//try..finally
   end;//l_Font
  end;//AssignToFont

 procedure _Assign(anAtom : Tl3Variant;
                   const aProp  : Tk2CustomPropertyPrim);

 var
  l_New : Tl3Variant;
  l_I   : Integer;
  l_C   : Tl3Variant;
 begin//_Assign
  with aDestSegment do
  begin
   if (aProp.TagIndex = k2_tiChildren) then
   begin
    for l_I := 0 to Pred(anAtom.ChildrenCount) do
    begin
     l_C := anAtom.Child[l_I].CloneTag.AsObject;
     try
      try
       aDestSegment.AddChild(l_C, anOpPack);
      except
       on Ek2CannotAddChild do ;
      end;//try..except
     finally
      l_C := nil;
     end;//try..finally
    end;//for l_I
   end//aProp.TagIndex = k2_tiChildren
   else
   if aProp.Shared then
   begin
    if not aProp.ReadOnly then
     AttrW[aProp.TagIndex, anOpPack] := anAtom{nil}{?}
     // - ���� nil �������� �� anAtom - ��� �� ����� ��������
   end//aProp.Shared
   else
   begin
    if HasSubAtom(aProp.TagIndex) then
    begin
     if (aProp.TagIndex = k2_tiFont) then
      // - ����� ���� ������������ ������ �������
      AssignToFont(Attr[aProp.TagIndex])
     else
      with Attr[aProp.TagIndex] do
       if IsOrd then
        aDestSegment.AttrW[aProp.TagIndex, anOpPack] := anAtom
       else
        AssignTag(anAtom, [k2_amNull], anOpPack);
    end//HasSubAtom(aProp.TagIndex)
    else
    begin
     l_New := Attr[aProp.TagIndex];
     if anAtom.IsOrd then
      l_New := anAtom
     else
     if l_New.IsValid then
      l_New := l_New.CloneTag.AsObject
     else
      l_New := aProp.MakeTag.AsObject;
     try
      if (aProp.TagIndex = k2_tiFont) then
      begin
       // - ����� ���� ������������ ������ �������
       if AssignToFont(l_New) then
        AttrW[aProp.TagIndex, anOpPack] := l_New;
      end//aProp.TagIndex = k2_tiFont
      else
{$IFNDEF Nemesis}                                
      if (aProp.TagIndex = k2_tiVisible) then 
      begin
       if (l_New = anAtom) then
        // - ������� ��������� �������� ������������ ���� ������ �������:
        // ���� �������� ����������, �� ����� ��� �����������, � ���� ��� - 
        // �� � ����� ���������, �.�. �� ����� ��������� ���������.
         AttrW[aProp.TagIndex, anOpPack] := l_New
       else
       if CheckApply2Para(aDestSegment) {and l_New.AssignTag(anAtom, [k2_amNull]) }then
        AttrW[aProp.TagIndex, anOpPack] := l_New;
      end//if (aProp.TagIndex = k2_tiVisible) then
      else
{$ENDIF Nemesis}
      if (l_New = anAtom) OR l_New.AssignTag(anAtom, [k2_amNull]) then
       AttrW[aProp.TagIndex, anOpPack] := l_New;
     finally
      l_New := nil;
     end;//try..finally
    end;//if HasSubAtom(aProp)
   end;//l_Prop.Shared
  end;//with aDestSegment
 end;//_Assign

var
 l_Index     : LongInt;
 l_Prop      : Tk2CustomPropertyPrim;
 l_AlienAtom : Tl3Variant;
 l_Paras     : TLongArray;
//#UC END# *502206D80305_4A3919200142_var*
begin
//#UC START# *502206D80305_4A3919200142_impl*
 with aDestSegment do
 begin
  l_Paras := Tk2Type(TagType).ParamsForClone;
  for l_Index := Low(l_Paras) to High(l_Paras) do
  begin
   l_Prop := Tk2Type(TagType).Prop[l_Paras[l_Index]];
   if (l_Prop <> nil) then
   begin
    l_AlienAtom := aSegment.rOwnAtom(l_Prop.TagIndex);
    if l_AlienAtom.IsTransparent then
    begin
     // - ���� ���������� ���� ��� ��� � �������� � ������� ��������
     ;
    end
    else
    if not l_AlienAtom.IsNull then
    begin
     // - � ������ �������� ���� ����� ����������� ���� - ���� ��� ��������� � ���� � ������
     _Assign(l_AlienAtom, l_Prop)
    end//not l_AlienAtom.IsNull
    else
    begin
     { TODO -o����� �. �. -c��������� : ���� ��� ������ ����������� ������������ ���������� ������. }
     l_AlienAtom := aSegment.Attr[l_Prop.TagIndex];
     if l_AlienAtom.IsTransparent then
     begin
      // - ���� ���������� ���� ��� ��� � �������� � ������� ��������
      ;
     end
     else
     if not l_AlienAtom.IsNull then
     begin
      _Assign(l_AlienAtom, l_Prop);
     end//not l_AlienAtom.IsNull
     else
      AttrW[l_Prop.TagIndex, anOpPack] := nil;
    end;//l_AlienOwnAtom.IsTransparent
   end;//l_Prop <> nil
  end;//for l_Index
 end;//with aDestSegment
// ���� �� ��� ���� ������ - ��� ����� ������������
(* AssignSubAtomEx(aSegment,
                 evSegmentParas,
                 k2_amAll - [k2_amTransparent],
                 anOpPack);*)
//#UC END# *502206D80305_4A3919200142_impl*
end;//EvSegmentAssignSegment

function EvSegmentHasSomeFormat(aSegment: Tl3Variant): Boolean;
//#UC START# *502205210291_4A3919200142_var*
var
 l_Index : LongInt;
 l_Paras : TLongArray;
//#UC END# *502205210291_4A3919200142_var*
begin
//#UC START# *502205210291_4A3919200142_impl*
 Result := false;
 l_Paras := Tk2Type(aSegment.TagType).ParamsForClone;
 for l_Index := Low(l_Paras) to High(l_Paras) do
  with aSegment do
   if rOwnAtom(l_Paras[l_Index]).IsValid then
   begin
    Result := true;
    break;
   end;//rOwnAtom(TagType.Prop[l_Paras[l_Index]]).IsValid
//#UC END# *502205210291_4A3919200142_impl*
end;//EvSegmentHasSomeFormat

procedure EvSegmentSetFontParam(aSegment: Tl3Variant;
  anAtom: LongInt;
  aValue: Tl3Variant;
  const aContext: InevOp = nil);
//#UC START# *502205480080_4A3919200142_var*
var
 l_Prop : Tk2CustomPropertyPrim;
//#UC END# *502205480080_4A3919200142_var*
begin
//#UC START# *502205480080_4A3919200142_impl*
 if (anAtom = -k2_typSegment.ID) then
 begin
  EvSegmentAssignSegment(aSegment, aValue, aContext);
 end//anAtom = -k2_idSegment
 else
  with aSegment do
  begin
   l_Prop := Tk2Type(TagType).Prop[anAtom];
   if (l_Prop <> nil) then
    AttrW[l_Prop.TagIndex, aContext] := aValue
   else
    cAtom(k2_tiFont, aContext).AttrW[anAtom, aContext] := aValue;
  end;//with aSegment
//#UC END# *502205480080_4A3919200142_impl*
end;//EvSegmentSetFontParam
{$IfEnd} //k2ForEditor

end.