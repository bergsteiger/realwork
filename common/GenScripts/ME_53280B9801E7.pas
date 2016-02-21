{$IfNDef k2TagPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2TagPrim.imp.pas"
// Стереотип: "Impurity"

{$Define k2TagPrim_imp}

 {$If Defined(k2TagNoSort)}
 {$Define l3Items_NoSort}
 {$IfEnd} // Defined(k2TagNoSort)

 _k2Int64Holder_Parent_ = _k2TagPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas}
 _k2DoQT_Parent_ = _k2Int64Holder_;
 {$Include w:\common\components\rtl\Garant\K2\k2DoQT.imp.pas}
 _k2TagPrim_ = class(_k2DoQT_)
  protected
   {$If NOT Defined(k2Tag_No_f_TagType)}
   f_TagType: Tk2Type;
   {$IfEnd} // NOT Defined(k2Tag_No_f_TagType)
  private
   procedure ChildAdded(aProp: Tk2ArrayProperty;
    aChild: Tl3Variant;
    anIndex: Integer;
    aTotal: Integer;
    const anOpPack: Il3OpPack);
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function IterateInnerChildrenOnWrite: Boolean; virtual;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   {$If NOT Defined(k2TagIsList)}
   function HackChildren: Tk2TagList;
   {$IfEnd} // NOT Defined(k2TagIsList)
   procedure CheckChildInsert(var anIndex: Integer;
    var aChild: Tl3Variant;
    const anOp: Ik2Op); virtual;
   {$If NOT Defined(k2TagIsAtomic)}
   function DoSetAtom(const aProp: _PropIn_;
    aValue: Tl3Variant): Boolean;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function GetOwnAttrValue(aProp: Tk2Prop;
    out theValue: Tl3Variant): Boolean;
   function GetAttrValue(aProp: Tk2Prop;
    out theValue: Tl3Variant): Boolean;
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; virtual; abstract;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   {$If NOT Defined(k2TagIsAtomic)}
   function GetHasSubAtom(aProp: Tk2Prop): Boolean; virtual;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function GetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; virtual;
   {$If NOT Defined(k2TagIsAtomic)}
   procedure SetSubAtom(const aProp: _PropIn_;
    aValue: Tl3Variant);
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; override;
   function DoMarkModified: Boolean; override;
   procedure DoDoLoad; override;
   function DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
    aHi: Tl3Index;
    aLo: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   procedure DoForceStore; override;
   function DoGetHasSubAtom(anIndex: Integer): Boolean; override;
   function GetTagType: Tl3VariantDef; override;
   procedure SetAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Tl3Variant); override;
   function GetAttr(anIndex: Integer;
    out theValue: Tl3Variant): Boolean; override;
   procedure SetBoolAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Boolean); override;
   procedure SetIntAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Integer); override;
   procedure SetWStrAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    const aValue: Tl3WString); override;
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
   function pm_GetChildrenCount: Integer; override;
   procedure pm_SetChildrenCapacity(aValue: Integer); override;
   function pm_GetChildPrim(anIndex: Integer): Tl3Variant; override;
   function DoAddChild(aChild: Tl3Variant;
    const aContext: Il3OpPack): Integer; override;
   function CheckAttr(const aPath: array of Integer;
    const aContext: Il3OpPack;
    DoCheck: Boolean;
    theIndex: PLongint): Tl3Variant; override;
   function DoCAtom(anIndex: Integer;
    const aContext: Il3OpPack;
    anAtomType: Tl3VariantDef): Tl3Variant; override;
  public
   procedure CheckSort(aProp: Tl3VariantDef); override;
   function AssignTag(Source: Tl3Variant;
    AssignMode: Tk2AssignModes;
    const Context: Il3OpPack): Boolean; override;
   function CloneTag: Il3TagRef; override;
   procedure AssignCloneParams(aSource: Tl3Variant;
    AssignMode: Tk2AssignModes;
    const Context: Il3OpPack); override;
   procedure WriteTag(const G: Ik2TagGenerator;
    Flags: Tk2StorePropertyFlags;
    Exclude: TByteSet); override;
    {* записать тег в генератор. }
   procedure InsertChildTag(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack); override;
    {* вставить ребенка. }
   function IndexOfChild(aChild: Tl3Variant): Integer; override;
   function FindChild(anAtom: Integer;
    aValue: Integer;
    const aContext: Il3OpPack;
    aNeedCreate: Boolean;
    theIndex: PLongint): Tl3Variant; override;
   procedure DeleteChildren(const Context: Il3OpPack); override;
    {* удалить всех детей. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function CompareWithInt(aValue: Integer;
    anIndex: Integer): Integer; override;
    {* Сравнивает тег с целым. }
   function CompareWithTag(aTag: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer; override;
   function rOwnAtom(anIndex: Integer): Tl3Variant; override;
 end;//_k2TagPrim_

{$Else k2TagPrim_imp}

{$IfNDef k2TagPrim_imp_impl}

{$Define k2TagPrim_imp_impl}

{$Include w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas}

{$Include w:\common\components\rtl\Garant\K2\k2DoQT.imp.pas}

{$If NOT Defined(k2TagIsAtomic)}
function _k2TagPrim_.IterateInnerChildrenOnWrite: Boolean;
//#UC START# *5081947501ED_53280B9801E7_var*
//#UC END# *5081947501ED_53280B9801E7_var*
begin
//#UC START# *5081947501ED_53280B9801E7_impl*
 Result := true;
//#UC END# *5081947501ED_53280B9801E7_impl*
end;//_k2TagPrim_.IterateInnerChildrenOnWrite
{$IfEnd} // NOT Defined(k2TagIsAtomic)

{$If NOT Defined(k2TagIsList)}
function _k2TagPrim_.HackChildren: Tk2TagList;
//#UC START# *4A5368DC0050_53280B9801E7_var*
{$IfDef k2TagIsList}
{$Else  k2TagIsList}
var
 l_Prop  : Tk2Prop;
 l_Value : Tl3Variant;
{$EndIf k2TagIsList}
//#UC END# *4A5368DC0050_53280B9801E7_var*
begin
//#UC START# *4A5368DC0050_53280B9801E7_impl*
 {$IfDef k2TagIsList}
 Result := Self;
 {$Else  k2TagIsList}
 l_Prop := Tk2Prop(Tk2Type(Self.TagType).Prop[k2_tiChildren]);
 if (l_Prop <> nil) AND Self.GetAttrValue(l_Prop, l_Value) then
 begin
  Result := l_Value As Tk2TagList;
  //Assert((Result = nil) OR (Result Is Tk2List));
 end//GetAttrValue
 else
  Result := nil;
 {$EndIf k2TagIsList}
//#UC END# *4A5368DC0050_53280B9801E7_impl*
end;//_k2TagPrim_.HackChildren
{$IfEnd} // NOT Defined(k2TagIsList)

procedure _k2TagPrim_.CheckChildInsert(var anIndex: Integer;
 var aChild: Tl3Variant;
 const anOp: Ik2Op);
//#UC START# *4CED66B8005F_53280B9801E7_var*
//#UC END# *4CED66B8005F_53280B9801E7_var*
begin
//#UC START# *4CED66B8005F_53280B9801E7_impl*
 // - ничего не делаем
//#UC END# *4CED66B8005F_53280B9801E7_impl*
end;//_k2TagPrim_.CheckChildInsert

procedure _k2TagPrim_.ChildAdded(aProp: Tk2ArrayProperty;
 aChild: Tl3Variant;
 anIndex: Integer;
 aTotal: Integer;
 const anOpPack: Il3OpPack);
//#UC START# *533D641702ED_53280B9801E7_var*
//#UC END# *533D641702ED_53280B9801E7_var*
begin
//#UC START# *533D641702ED_53280B9801E7_impl*
 aProp.DoAfterChildAdded(Self, aChild, anOpPack, anIndex, aTotal);
//#UC END# *533D641702ED_53280B9801E7_impl*
end;//_k2TagPrim_.ChildAdded

{$If NOT Defined(k2TagIsAtomic)}
function _k2TagPrim_.DoSetAtom(const aProp: _PropIn_;
 aValue: Tl3Variant): Boolean;
//#UC START# *5346C8570369_53280B9801E7_var*
var
 l_V : Tk2Values;
//#UC END# *5346C8570369_53280B9801E7_var*
begin
//#UC START# *5346C8570369_53280B9801E7_impl*
 l_V.Init(aProp, aValue, Self);
 try
  if Tk2CustomProperty(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp).DoBeforeChange(l_V, aProp.rOp) then
  begin
   Result := true;
   l_V.CheckSort;
   if SetAtomPrim(aProp, l_V) then
   begin
    if (aProp.rOp <> nil) AND
        aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.NeedMarkModified
       AND not aProp.rOp.InIOProcess then
     aProp.rOp.MarkModified(Self);
    Tk2CustomProperty(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp).DoAfterChange(l_V, aProp.rOp);
   end;//SetAtomPrim
  end//aProp.DoBeforeChange(l_V, aProp.rOp)
  else
   Result := false;
 finally
  l_V.Free;
 end;//try..finally
//#UC END# *5346C8570369_53280B9801E7_impl*
end;//_k2TagPrim_.DoSetAtom
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function _k2TagPrim_.GetOwnAttrValue(aProp: Tk2Prop;
 out theValue: Tl3Variant): Boolean;
//#UC START# *5346C88F0297_53280B9801E7_var*
//#UC END# *5346C88F0297_53280B9801E7_var*
begin
//#UC START# *5346C88F0297_53280B9801E7_impl*
 Assert(aProp <> nil);
 {$IfDef k2TagIsList}
 if (aProp.TagIndex = k2_tiChildren) then
 begin
  theValue := Self;
  Result := true;
 end//aProp.TagIndex = k2_tiChildren
 else
 {$EndIf k2TagIsList}
  Result := GetSubAtom(aProp, theValue);
//#UC END# *5346C88F0297_53280B9801E7_impl*
end;//_k2TagPrim_.GetOwnAttrValue

function _k2TagPrim_.GetAttrValue(aProp: Tk2Prop;
 out theValue: Tl3Variant): Boolean;
//#UC START# *5346C8C00133_53280B9801E7_var*
{$IfDef k2TagUseMapping}
var
 l_MI       : Integer;
 l_TgO      : Tl3Variant;
{$EndIf k2TagUseMapping}
{$IfDef k2TagUseDefaultValue}
var
 l_PropType : Tk2Type;
 l_VT       : Tk2Dictionary;
{$EndIf k2TagUseDefaultValue}
//#UC END# *5346C8C00133_53280B9801E7_var*
begin
//#UC START# *5346C8C00133_53280B9801E7_impl*
 Result := false;
 if GetOwnAttrValue(aProp, theValue) then
  Result := true
 else
 begin
  {$IfDef k2TagUseMapping}
  l_MI := aProp.EmptyMapping;
  if (l_MI <> k2_tiMask) then
  begin
   Assert(l_MI <> aProp.TagIndex);
   // - защита от зацикливания при кривой схеме документа
   l_TgO := Attr[l_MI];
   if not l_TgO.IsSame(Self) then
   begin
    theValue := l_TgO.Attr[aProp.TagIndex];
    if theValue.IsNull then
     theValue := nil
    else
    begin
     Result := true;
     Exit;
    end//IsNull
   end;//not l_TgO.IsSame(Self)
  end;//l_MI <> k2_tiMask
  {$EndIf k2TagUseMapping}
  {$IfDef k2TagUseDefaultValue}
  l_PropType := Tk2Type(aProp.AtomType);
  //theValue := aProp.DefaultValue;
  theValue := nil;
  if (aProp.DefaultValue <> l3NilLong) then
  begin
   theValue := l_PropType.MakeTag(aProp.DefaultValue).AsObject;
   if theValue.IsNull then
    Result := false
   else
    Result := true;
  end//l_Data <> l3NilLong
  else
  begin
   l_VT := l_PropType.ValueTable;
   if (l_VT <> nil) AND (l_VT.Default <> nil) then
   begin
    Result := true;
    theValue := l_VT.Default.AsObject;
   end;//l_VT <> nil
  end;//l_Data <> l3NilLong
  {$EndIf k2TagUseDefaultValue}
 end;//GetSubAtom(aProp, theValue)
//#UC END# *5346C8C00133_53280B9801E7_impl*
end;//_k2TagPrim_.GetAttrValue

{$If NOT Defined(k2TagIsAtomic)}
function _k2TagPrim_.GetHasSubAtom(aProp: Tk2Prop): Boolean;
//#UC START# *49A544E802B2_53280B9801E7_var*
//#UC END# *49A544E802B2_53280B9801E7_var*
begin
//#UC START# *49A544E802B2_53280B9801E7_impl*
 {$IfDef k2TagIsList}
 Result := (aProp.TagIndex = k2_tiChildren);
 {$Else  k2TagIsList}
 Result := false;
 {$EndIf k2TagIsList}
//#UC END# *49A544E802B2_53280B9801E7_impl*
end;//_k2TagPrim_.GetHasSubAtom
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function _k2TagPrim_.GetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *49A54517029C_53280B9801E7_var*
//#UC END# *49A54517029C_53280B9801E7_var*
begin
//#UC START# *49A54517029C_53280B9801E7_impl*
 Data := nil;
 Result := false;
//#UC END# *49A54517029C_53280B9801E7_impl*
end;//_k2TagPrim_.GetSubAtom

{$If NOT Defined(k2TagIsAtomic)}
procedure _k2TagPrim_.SetSubAtom(const aProp: _PropIn_;
 aValue: Tl3Variant);
//#UC START# *4C6D1C070249_53280B9801E7_var*

 procedure SetAtom(const aProp : _PropIn_;
                   aValue : Tl3Variant);
   {-}

  {$IfDef k2TagUseMapping}
  procedure DeleteMapped;
    {-}
  var
   MT : Integer;

   function DeleteAtom(Prop: Pk2CustomProperty; BitNum: Longint): Boolean;
   begin//DeleteAtom
    Result := true;
    if (BitNum <> aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex) AND
       (Prop^.EmptyMapping = aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex) then
    begin
     if not Prop^.ReadOnly then
      Self.AttrW[Prop^.TagIndex, aProp.rOp] := nil;
     Dec(MT);
     if (MT <= 0) then Result := false;
    end;//BitNum <> _Prop.TagIndex
   end;//DeleteAtom

  begin//DeleteMapped
   if (aProp.rOp <> nil) AND
       not Tk2CustomProperty(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp).IsArray AND
      aProp.rOp.DeleteMapped AND not aProp.rOp.InUndo then
   begin
    MT := aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.MappingTarget;
    if (MT > 0) then
     Tk2Type(Self.TagType).IteratePropertiesF(l3L2IA(@DeleteAtom));
   end;//aDeleteMapped..
  end;//DeleteMapped
  {$EndIf k2TagUseMapping}

  procedure RaiseReadOnly;
  begin//RaiseReadOnly
   raise Ek2ReadOnlyProperty.CreateFmt(k2_errReadOnly,
                                       [aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.AsString, Self.TagType.AsString])
  end;//RaiseReadOnly

 begin//SetAtom
  if aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.ReadOnly then
   RaiseReadOnly
  else
  begin
   if Self.DoSetAtom(aProp, aValue) then
   begin
    {$IfDef k2TagUseMapping}
    if aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped then
     DeleteMapped;
    {$EndIf k2TagUseMapping}
   end;//DoSetAtom..
  end;//aProp.ReadOnly
 end;//SetAtom

 procedure DeleteAtom;
 begin//DeleteAtom
  //__BP('1');
  //aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtTag;
  SetAtom(aProp, nil);
 end;//DeleteAtom

{$IfDef k2TagUseDefaultValue}
var
 l_DefaultValue : Integer;
{$EndIf k2TagUseDefaultValue}
{$IfDef k2TagUseMapping}
var
 l_Mapping      : Integer;
{$EndIf k2TagUseMapping}
var
 l_Result : Tl3Variant;
//#UC END# *4C6D1C070249_53280B9801E7_var*
begin
//#UC START# *4C6D1C070249_53280B9801E7_impl*
 {$IfDef k2TagIsList}
 if (aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex = k2_tiChildren) then
 begin
  //Assert(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT = vtTag);
  if (aValue = nil) then
  begin
   Self.DeleteChildren(aProp.rOp);
   Exit;
  end;//aValue = nil
  Assert(false);
 end;//rProp.TagIndex = k2_tiChildren..
 //Assert(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex <> k2_tiChildren);
 {$EndIf k2TagIsList}
 l_Result := aValue;
 if (l_Result = nil) then
 begin
  DeleteAtom;
  Exit;
 end;//l_Result = nil
 if l_Result.IsNull then
  DeleteAtom
 else
 begin
  {$If Defined(k2TagUseMapping) OR Defined(k2TagUseDefaultValue)}
  //if (aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT in cCheckMapping) then
   if ((aProp.rOp = nil) OR aProp.rOp.Optimize) then
   begin
 //   if aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.AtomType.IsOrd then
    begin
     {$IfDef k2TagUseMapping}
     l_Mapping := aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.EmptyMapping;
     if (l_Mapping <> k2_tiMask) then
     begin
      // - здесь проверяем не совпадает ли новое значение с мапируемым значением
      with Attr[l_Mapping] do
       if IsValid AND not IsSame(Self) then
        with Attr[aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex] do
         if IsValid then
         begin
          if l_Result.IsOrd then
          begin
           if (l_Result.AsLong = AsLong) then
           begin
            DeleteAtom;
            Exit;
           end;//IsValid
          end//l_Result.IsOrd
          else
          begin
           if IsSame(l_Result) then
           begin
            DeleteAtom;
            Exit;
           end;//IsValid
          end;//l_Result.IsOrd
         end;//IsValid
     end//l_Mapping <> k2_tiMask
     else
     {$EndIf k2TagUseMapping}
     {$IfDef k2TagUseDefaultValue}
     begin
      // - здесь проверяем не совпадает ли новое значение со значением по умолчанию
      l_DefaultValue := Tk2Prop(aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp).DefaultValue;
      if (l_DefaultValue <> l3NilLong) AND
         (l_Result.AsLong = l_DefaultValue) then
      begin
       DeleteAtom;
       Exit;
      end;//l_DefaultValue <> l3NilLong..
     end;//l_Mapping <> k2_tiMask
     {$EndIf k2TagUseDefaultValue}
    end;//aProp.AtomType.IsOrd
   end;//Context = nil..
  {$IfEnd}
  //aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtTag;
  SetAtom(aProp, l_Result);
 end;//Result.IsNull
//#UC END# *4C6D1C070249_53280B9801E7_impl*
end;//_k2TagPrim_.SetSubAtom
{$IfEnd} // NOT Defined(k2TagIsAtomic)

procedure _k2TagPrim_.CheckSort(aProp: Tl3VariantDef);
//#UC START# *47612CD10380_53280B9801E7_var*
//#UC END# *47612CD10380_53280B9801E7_var*
begin
//#UC START# *47612CD10380_53280B9801E7_impl*
 {$IfDef k2TagIsList}
 Assert(aProp Is Tk2ArrayProperty);
 if (aProp <> nil) AND (Tk2ArrayProperty(aProp).SortIndex <> k2_tiSelfID) then
 begin
  SortIndex := Tk2ArrayProperty(aProp).SortIndex;
  Duplicates := Tk2ArrayProperty(aProp).Duplicates;
 end;//aProp.SortIndex <> k2_tiSelfID
 {$EndIf k2TagIsList}
//#UC END# *47612CD10380_53280B9801E7_impl*
end;//_k2TagPrim_.CheckSort

function _k2TagPrim_.AssignTag(Source: Tl3Variant;
 AssignMode: Tk2AssignModes;
 const Context: Il3OpPack): Boolean;
//#UC START# *47612DD0012B_53280B9801E7_var*


{$IfDef k2TagComplexAssign}
 function AssignProperty(const aSourceAtom: Tl3Variant; aProp: Tk2CustomPropertyPrim): Boolean;
 var
  l_DstProp : _PropLoc_;

  function AssignChild(aSourceChild: Tl3Variant; Index: Integer): Boolean;
  var
   l_DstChild : Tl3Variant;
  begin//AssignChild
   l_DstChild := aSourceChild.TagType.MakeTag.AsObject;
   try
    l_DstChild.AssignTag(aSourceChild, AssignMode, Context);
    try
     Self.AddChild(l_DstChild, Context);
    except
     on Ek2CannotAddChild do ;
    end;//try..except
   finally
    l_DstChild := nil;
   end;//try..finally
   Result := true;
  end;//AssignChild

 var
  A : Tl3Variant;
  l_IDI : Integer;
 begin//AssignProperty
  Result := true;
  l_DstProp.rOp := Pointer(Context);
  l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := false;
  l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := Tk2Prop(Tk2Type(Self.TagType).Prop[aProp.TagIndex]);
  //l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtTag;
  if (l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp <> nil) AND
      not l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.ReadOnly {AND
      CanAssignParam(_PropIn_(l_DstProp)) }then
  // - если свойство ReadOnly, то его присваивать не надо.
  begin
   if Tk2Prop(aProp).GetStored(Source, aSourceAtom, Context) then
   begin
    if aSourceAtom.IsNull then
    begin
     if (k2_amNull in AssignMode) then
     begin
      Self.SetSubAtom(_PropIn_(l_DstProp), nil);
     end//k2_amNull in AssignMode
     else
      Exit;
    end//aSourceAtom.IsNull
    else
    if (aProp.TagIndex = k2_tiChildren) then
    begin
     {$IfNDef k2TagIsList}
     A := l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.MakeTag.AsObject;
     try
      Self.SetSubAtom(_PropIn_(l_DstProp), A);
     {$EndIf  k2TagIsList}
      aSourceAtom.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@AssignChild));
     {$IfNDef k2TagIsList}
     finally
      A := nil;
     end;//try..finally}
     {$EndIf  k2TagIsList}
    end//SrcProp.TagIndex = k2_tiChildren
    else
    begin
     if aSourceAtom.IsTransparent AND not (k2_amTransparent in AssignMode) then
      Exit;
     if aProp.Shared then
      Self.SetSubAtom(_PropIn_(l_DstProp), aSourceAtom)
     else
     begin
      if l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.AtomType.IsOrd then
       Self.SetSubAtom(_PropIn_(l_DstProp), aSourceAtom)
      else
      begin
       l_IDI := Tk2Type(l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagType).IDIndex;
       if (l_IDI <> k2_tiSelfID) AND (l_IDI <> k2_tiMask) AND
        aSourceAtom.HasSubAtom(l_IDI) then
        Self.SetSubAtom(_PropIn_(l_DstProp), aSourceAtom)
       else
       begin
        A := Self.rOwnAtom(l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex);
        if A.IsValid then
         A.AssignTag(aSourceAtom, AssignMode, Context)
        else
        begin
         A := l_DstProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.MakeTag.AsObject;
         try
          A.AssignTag(aSourceAtom, AssignMode, Context);
          Self.SetSubAtom(_PropIn_(l_DstProp), A);
         finally
          A := nil;
         end;//try..finally
        end;//A.IsValid
       end;//l_IDI <> k2_tiSelfID..
      end;//l_DstProp.AtomType.IsOrd
     end;//SrcProp.Shared
    end;//SrcProp.TagIndex = k2_tiChildren
   end//SrcProp.GetStored(Source, aSourceAtom, Context)
   else
    Self.SetSubAtom(_PropIn_(l_DstProp), nil);
   AssignTag := true;
  end;//not l_DstProp.ReadOnly
  // - хотя бы один атом был присвоен
 end;//AssignProperty

var
 l_All : Boolean;
{$EndIf k2TagComplexAssign}
//#UC END# *47612DD0012B_53280B9801E7_var*
begin
//#UC START# *47612DD0012B_53280B9801E7_impl*
 {$IfDef k2TagComplexAssign}
 Result := false;
 l_All := (AssignMode = k2_amAll) OR (AssignMode = [k2_amNull]);
 Source.IteratePropertiesF(L2Ml3TagHolderIteratePropertiesAction(@AssignProperty), l_All);
 {$Else  k2TagComplexAssign}
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsString}
 AssignString(Source As Tl3PrimString);
 Result := true;
 Exit;
 {$Else  k2TagIsString}
// Assert(not (Self.AsObject Is TPersistent), 'Зачем присваивать тег ' + ClassName + ' как TPersistent?');
 Result := true;
 {$EndIf k2TagIsString}
 {$IfNDef k2TagNoAssign}
 Assign(Source As _Instance_R_);
 {$EndIf  k2TagNoAssign}
 {$Else  k2TagIsAtomic}
 Assert(false, 'Пытаемся присвоить атомарный тип: ' +  TagType.AsString);
 Result := false;
 {$EndIf k2TagIsAtomic}
 {$EndIf k2TagComplexAssign}
//#UC END# *47612DD0012B_53280B9801E7_impl*
end;//_k2TagPrim_.AssignTag

function _k2TagPrim_.CloneTag: Il3TagRef;
//#UC START# *47612DF00301_53280B9801E7_var*
//#UC END# *47612DF00301_53280B9801E7_var*
begin
//#UC START# *47612DF00301_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 Result := Self.TagType.MakeTag;
 Result.AsObject.AssignTag(Self, k2_amAll, Tk2NonOptimizeContext.Instance);
 {$Else  k2TagIsAtomic}
 Result := Self;
 {$EndIf k2TagIsAtomic}
//#UC END# *47612DF00301_53280B9801E7_impl*
end;//_k2TagPrim_.CloneTag

procedure _k2TagPrim_.AssignCloneParams(aSource: Tl3Variant;
 AssignMode: Tk2AssignModes;
 const Context: Il3OpPack);
//#UC START# *47612E530082_53280B9801E7_var*
{$IfNDef k2TagIsAtomic}
var
 i       : Integer;
 l_Prop  : _PropLoc_;
 SrcAtom : Tl3Variant;
 A       : Tl3Variant;
 l_Path  : TLongArray;
 l_DV    : Integer;
 l_P     : Tk2Prop;
{$EndIf  k2TagIsAtomic}
//#UC END# *47612E530082_53280B9801E7_var*
begin
//#UC START# *47612E530082_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 l_Prop.rOp := Pointer(Context);
 l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := false;
 //l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtTag;
 l_Path := Tk2Type(Self.TagType).ParamsForClone;
 for i := Low(l_Path) to High(l_Path) do
 begin
  l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := Tk2Prop(Tk2Type(Self.TagType).Prop[l_Path[i]]);
  if (l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp <> nil) AND
      not l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.ReadOnly then
  // - не пытаемся присваивать ReadOnly свойства.
  begin
   //if CanAssignParam(_PropIn_(l_Prop)) then
   begin
    with aSource do
     SrcAtom := rOwnAtom(l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex);
    if SrcAtom.IsNull then
    begin
     if (k2_amNull in AssignMode) then
     begin
      // begin http://mdp.garant.ru/pages/viewpage.action?pageId=195758030
      // Хотя та конкретная ошибка починена по-другому.
      // Там в Memo был SimpelTextPara а в Edit - TextPara.
      // Теперь они стали одинаковые, так что если этот код будет мешать, то
      // его можно запросто убрать.
      //
      // Особенно учитывая кусок из TevTextParaCursor.DoJoinWith:
      //  if (l_FirstPara.Owner <> nil) and l_FirstPara.Owner.IsKindOf(k2_idTableCell) then
      //   l_Style := l_FirstPara.IntA[k2_tiStyle]
      //  else
      //   l_Style := ev_saEmpty;
      // и последующее восстановление стиля.
      if l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.Shared AND
         not Self.TagType.IsSame(Tk2Type(aSource.TagType)) then
      begin
       l_P := Tk2Prop(Tk2Type(aSource.TagType).Prop[l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex]);
       if (l_P <> nil) then
       begin
        l_DV := l_P.DefaultValue;
        if (l_DV <> High(Integer)) AND
           (Tk2Prop(l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp).DefaultValue <> l_DV) then
         IntW[l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex, Context] := l_DV
        else
         AttrW[l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex, Context] := nil;
       end//l_P <> nil
       else
        AttrW[l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex, Context] := nil;
      end//l_Prop.rProp.Shared
      else
      // end http://mdp.garant.ru/pages/viewpage.action?pageId=195758030
       AttrW[l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex, Context] := nil;
     end;//k2_amNull in AssignMode
    end//SrcAtom.IsNull
    else
    begin
     if (k2_amTransparent in AssignMode) OR not SrcAtom.IsTransparent then
     begin
      if l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.Shared then
       Self.SetSubAtom(_PropIn_(l_Prop), SrcAtom)
      else
      if SrcAtom.IsOrd then
       Self.SetSubAtom(_PropIn_(l_Prop), SrcAtom)
      else
      begin
       A := l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.MakeTag.AsObject;
       try
        A.AssignTag(SrcAtom, AssignMode);
        Self.SetSubAtom(_PropIn_(l_Prop), A);
       finally
        A := nil;
       end;//try..finally
      end;//l_Prop.Shared
     end;//[k2_amTransparent in AssignMode]..
    end;//SrcAtom.IsNull
   end;//CanAssignParam..
  end;//not l_Prop.IsReadOnly
 end;//for i..
 {$EndIf  k2TagIsAtomic}
//#UC END# *47612E530082_53280B9801E7_impl*
end;//_k2TagPrim_.AssignCloneParams

procedure _k2TagPrim_.WriteTag(const G: Ik2TagGenerator;
 Flags: Tk2StorePropertyFlags;
 Exclude: TByteSet);
 {* записать тег в генератор. }
//#UC START# *4761324203B8_53280B9801E7_var*
{$IfNDef k2TagIsAtomic}

 function WriteSubAtom(aSubAtom: Tl3Variant; aProp: Tk2CustomPropertyPrim): Boolean;

  procedure StoreAtom(Atom : Tl3Variant;
                      anID : Integer);
  begin//StoreAtom
   if not Atom.IsNull then
    G.AddAtom(anID, Atom);
  end;//StoreAtom

  function WriteChild(aChild: Tl3Variant; ChildIndex: Integer): Boolean; far;
  var
   l_ValueProp : Tk2CustomPropertyPrim;
  begin//WriteChild
   if Tk2ArrayProperty(aProp).GetStoredChild(Self, aChild, G.Context) then
   begin
    l_ValueProp := Tk2Type(aChild.TagType).Prop[k2_tiValue];
    if (l_ValueProp = nil) then
    begin
     G.StartChild(Tk2Type(aChild.TagType));
     try
      aChild.WriteTag(G, Flags + l3_spfInner);
     finally
      G.Finish;
     end;//try..finally
    end//aChild.TagType.Prop[k2_tiValue] = nil
    else
     StoreAtom(aChild.Attr[k2_tiValue],
               -{$IfDef Nemesis}
               Tk2ArrayProperty(aProp)
               {$Else}
               (aProp As Tk2ArrayProperty)
               {$EndIf}
                .ChildType.ID);
   end;//Tk2ArrayProperty(aProp).GetStoredChild
   Result := true;
  end;//WriteChild

 var
  AT  : Tk2Type;

  procedure StoreProp;
  var
   l_IStream : IStream;
  begin{StoreProp}
   if AT.HasProperties AND
      (AT.Prop[k2_tiValue] = nil) {- это хакерская проверка для строк} then
   begin
    if (l3_spfObjects in Flags) then
    begin
     G.StartTag(aProp.TagIndex);
     try
      aSubAtom.WriteTag(G, Flags + l3_spfInner, []);
     finally
      G.Finish;
     end;{try..finally}
    end;//l3_spfObjects in Flags
   end//AT.HasProperties
   else
   if aSubAtom.IsStream(l_IStream) then
    G.AddAtom(aProp.TagIndex, aSubAtom)
   else
   if (l3_spfScalars in Flags) then
    StoreAtom(aSubAtom, aProp.TagIndex);
  end;//StoreProp

 var
  IDI   : Integer;
  //HProp : Tk2CustomPropertyPrim;
  l_H   : Tl3Variant;
  l_CC  : Integer;
 begin//WriteSubAtom
  if (aProp <> nil) AND not (aProp.TagIndex in Exclude) then
  begin
   AT := Tk2Type(aProp.AtomType);
   if Tk2Prop(aProp).GetStored(Self, aSubAtom, G.Context) then
   begin
    if (aProp.TagIndex = k2_tiChildren) then
    begin
     if (l3_spfChildren in Flags) then
     begin
      if IterateInnerChildrenOnWrite then
      begin
       l_CC := aSubAtom.ChildrenCount;
       if (l_CC > 1) then
        G.AddIntegerAtom(k2_tiChildren, l_CC);
       aSubAtom.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@WriteChild));
      end
      else
      begin
       l_CC := Self.pm_GetChildrenCount;
       if (l_CC > 1) then
        G.AddIntegerAtom(k2_tiChildren, l_CC);
       Self.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@WriteChild));
      end;//IterateInnerChildrenOnWrite
     end;//l3_spfChildren in Flags
    end//l_Prop.TagIndex = k2_tiChildren
    else
    begin
     IDI := AT.IDIndex;
     if (IDI <> k2_tiMask) then
     // - странная проверка на самом деле, выходит если IDI = k2_tiMask, то
     //   ничего и не запишется. Правильно ли это? Если ещё раз наткнусь - надо
     //   будет подумать тщательнее.
     begin
      if (IDI = k2_tiSelfID) then
       StoreProp
      else
      begin
       l_H := aSubAtom.Attr[IDI];
       if l_H.IsValid then
       begin
        //HProp := AT.Prop[IDI];
        try
         //AT := Tk2Type(HProp.AtomType);
         //StoreAtom(l_H, aProp.TagIndex);
         StoreAtom(aSubAtom, aProp.TagIndex);
        except
         on Ek2ConversionError do ;
        end;//try..except
       end//l_H.IsValid
       else
       // - если ключ не задан, то пишем значение
        StoreProp;
      end;//IDI = k2_tiSelfID
     end;//IDI <> k2_tiMask
    end;//l_Prop.TagIndex = k2_tiChildren
   end;//l_Prop.GetStored(A, SubAtom)
  end;//not (aProp.TagIndex in Exclude)
  Result := true;
 end;{WriteSubAtom}

{$EndIf  k2TagIsAtomic}
//#UC END# *4761324203B8_53280B9801E7_var*
begin
//#UC START# *4761324203B8_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 if (G <> nil) then
  IteratePropertiesF(L2Ml3TagHolderIteratePropertiesAction(@WriteSubAtom), false);
 {$Else   k2TagIsAtomic}
 inherited;
 {$EndIf  k2TagIsAtomic}
//#UC END# *4761324203B8_53280B9801E7_impl*
end;//_k2TagPrim_.WriteTag

procedure _k2TagPrim_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53280B9801E7_var*
//#UC END# *479731C50290_53280B9801E7_var*
begin
//#UC START# *479731C50290_53280B9801E7_impl*
 {$If not defined(k2Tag_No_f_TagType)}
 f_TagType := nil;
 {$IfEnd}
 inherited;
//#UC END# *479731C50290_53280B9801E7_impl*
end;//_k2TagPrim_.Cleanup

function _k2TagPrim_.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_53280B9801E7_var*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
  function DoChild(aChild: Pl3Variant; anIndex: Long): Boolean;
  begin//DoChild
   Result := Action(aChild^, anIndex);
  end;//DoChild
 {$Else  k2TagIsList}
 var
  l_List : Tk2List;
 {$EndIf  k2TagIsList}
 {$EndIf  k2TagIsAtomic}
//#UC END# *48CF96D80241_53280B9801E7_var*
begin
//#UC START# *48CF96D80241_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 try
  Result := IterateF(aLo, aHi, l3L2IA(@DoChild));
 finally
  k2FreeTIA(Action);
 end;//try..finally
 {$Else  k2TagIsList}
 l_List := Tk2List(HackChildren);
 if (l_List = nil) then
 begin
  Result := -1;
  k2FreeTIA(Action);
 end//l_List = nil
 else
  Result := l_List.IterateChildrenF(Action, aLo, aHi, aLoadedOnly);
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Result := -1;
 k2FreeTIA(Action);
 {$EndIf  k2TagIsAtomic}
//#UC END# *48CF96D80241_53280B9801E7_impl*
end;//_k2TagPrim_.DoIterateChildrenF

procedure _k2TagPrim_.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_53280B9801E7_var*
//#UC END# *49A545D501F6_53280B9801E7_var*
begin
//#UC START# *49A545D501F6_53280B9801E7_impl*
 inherited;
 {$IfDef k2TagIsList}
 if not All then
  Action(Self, Tk2CustomProperty(Tk2Type(Self.TagType).Prop[k2_tiChildren]));
 {$EndIf k2TagIsList}
//#UC END# *49A545D501F6_53280B9801E7_impl*
end;//_k2TagPrim_.DoIterateProperties

procedure _k2TagPrim_.InsertChildTag(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack);
 {* вставить ребенка. }
//#UC START# *4A42358A00C2_53280B9801E7_var*
var
 l_Prop : Tk2ArrayProperty;

 procedure RaiseNoChildren;
 begin//RaiseNoChildren
  raise Ek2CannotAddChild.CreateFmt(k2_errNoChildren,
                                    [Self.TagType.AsString, aChild.TagType.AsString]);
 end;//RaiseNoChildren

 procedure RaiseBadChild;
 begin//RaiseBadChild
  raise Ek2CannotAddChild.CreateFmt(k2_errBadChild,
                                    [Self.TagType.AsString, aChild.TagType.AsString, l_Prop.ChildType.AsString])
 end;//RaiseBadChild

var
 l_Path : TLongArray;
 {$IfDef k2TagIsList}
 {$Else  k2TagIsList}
 l_List : TObject;
 {$EndIf k2TagIsList}
 l_Child : Tl3Variant;
//#UC END# *4A42358A00C2_53280B9801E7_var*
begin
//#UC START# *4A42358A00C2_53280B9801E7_impl*
 l_Prop := Tk2Type(Self.TagType).ArrayProp[k2_tiChildren];
 if (l_Prop = nil) then
 begin
  l_Path := Tk2Type(Self.TagType).FindChildPath(Tk2Type(aChild.TagType));
  if (l_Path = nil) then
   RaiseNoChildren
  else
   cAtomEx(l_Path, aContext).AddChild(aChild, aContext);
 end//l_Prop = nil
 else
 begin
  l_Child := aChild.Use;
  try
   if not l_Prop.ValidateChild(Self, l_Child, aContext, anIndex) then
   begin
    l_Path := Tk2Type(Self.TagType).FindChildPath(Tk2Type(l_Child.TagType));
    if (l_Path = nil) then
     RaiseBadChild
    else
     cAtomEx(l_Path, aContext).AddChild(l_Child, aContext);
   end//not l_Prop.ValidateChild(Self, l_Child)
   else
   begin
    CheckChildInsert(anIndex, l_Child, aContext);
    //l_Child.Owner := Self;
    // - это вроде не нужно, это в ChildAdded делается
    {$IfDef k2TagIsList}
    {$Else  k2TagIsList}
    l_List := cAtom(k2_tiChildren, aContext);
    Assert(l_List Is Tk2TagList);
    {$EndIf k2TagIsList}
    {$IfNDef k2TagIsList}Tk2TagList(l_List).
    {$EndIf  k2TagIsList}Insert(anIndex, l_Child.Box);
    {$IfDef k2TagIsList}
    ChildAdded(l_Prop, l_Child, anIndex, Count, aContext);
    {$Else  k2TagIsList}
    ChildAdded(l_Prop, l_Child, anIndex, Tk2TagList(l_List).Count, aContext);
    {$EndIf k2TagIsList}
   end;//not l_Prop.ValidateChild(Self, l_Child, aContext, anIndex)
  finally
   FreeAndNil(l_Child);
  end;//try..finally
 end;//l_Prop = nil
//#UC END# *4A42358A00C2_53280B9801E7_impl*
end;//_k2TagPrim_.InsertChildTag

function _k2TagPrim_.IndexOfChild(aChild: Tl3Variant): Integer;
//#UC START# *4A4235B70288_53280B9801E7_var*
 {$IfNDef k2TagIsAtomic}
 {$IfNDef k2TagIsList}
 var
  l_List : Tk2List;
 {$EndIf  k2TagIsList}
 {$EndIf  k2TagIsAtomic}
//#UC END# *4A4235B70288_53280B9801E7_var*
begin
//#UC START# *4A4235B70288_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 Result := IndexOf(aChild);
 {$Else  k2TagIsList}
 l_List := Tk2List(HackChildren);
 if (l_List = nil) then
  Result := -1
 else
  Result := l_List.IndexOfChild(aChild);
//  Result := Attr[k2_tiChildren].IndexOfChild(aChild);
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Result := -1;
 {$EndIf  k2TagIsAtomic}
//#UC END# *4A4235B70288_53280B9801E7_impl*
end;//_k2TagPrim_.IndexOfChild

function _k2TagPrim_.FindChild(anAtom: Integer;
 aValue: Integer;
 const aContext: Il3OpPack;
 aNeedCreate: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *4A42374B0371_53280B9801E7_var*
 {$IfDef k2TagIsList}
 var
  l_FoundIndex : Integer;

  function Seek(aChild: Tl3Variant; Index: Long): Bool;
  begin//Seek
   if (aChild.IntA[anAtom] = aValue) then
   begin
    FindChild := aChild.AsObject;
    l_FoundIndex := Index;
    Result := false;
   end//aChild.IntA[anAtom] = aValue
   else
    Result := true;
  end;//Seek

 var
  l_ArrayProp  : Tk2ArrayProperty;
  l_ChildType  : Tk2Type;
 {$Else  k2TagIsList}
 {$IfNDef k2TagIsAtomic}
 var
  l_List : Tk2List;
 {$EndIf  k2TagIsAtomic}
 {$EndIf k2TagIsList}
//#UC END# *4A42374B0371_53280B9801E7_var*
begin
//#UC START# *4A42374B0371_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 Result := nil;
 // - для порядку
 l_ArrayProp := Tk2Type(Self.TagType).ArrayProp[k2_tiChildren];
 l_ChildType := l_ArrayProp.GetChildTypeForParent(Self);
 if (anAtom = k2_tiByIndex) then
 begin
  l_FoundIndex := High(Integer);
  if (aValue >= 0) AND (aValue < Count) then
  begin
   Result := Child[aValue];
   if (theIndex <> nil) then
    theIndex^ := aValue;
  end;//aValue >= 0
 end//anAtom = k2_tiByIndex
 else
 begin
  if (SortIndex = anAtom) then
  begin
   if _Instance_R_(Self).FindData(aValue, l_FoundIndex, anAtom) then
    Result := Child[l_FoundIndex];
  end//SortIndex = anAtom
  else
  begin
   l_FoundIndex := 0;
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@Seek));
  end;//SortIndex = anAtom
  if (theIndex <> nil) then
   theIndex^ := l_FoundIndex;
 end;//anAtom = k2_tiByIndex
 if aNeedCreate AND
    //(anAtom <> k2_tiByIndex) AND
    // - !!! ни в коем случае НЕЛЬЗЯ это раскомментировать, т.к. есть варианты
    //   использования, когда таким образом создаются дочерние объекты.
    ((Result = nil) OR Result.IsNull) then
 begin
  Result := l_ChildType.MakeTag.AsObject;
  try
   if (anAtom <> k2_tiByIndex) then
    Result.IntW[anAtom, aContext] := aValue;
   if (l_FoundIndex = High(Integer)) then
    l_FoundIndex := AddChild(Result, aContext)
   else 
    InsertChildTag(l_FoundIndex, Result, aContext);
   Result := Child[l_FoundIndex];
   if (theIndex <> nil) then
    theIndex^ := l_FoundIndex;
  except
   Result := nil;
   raise;
  end;//try..finally
 end;//aNeedCreate
 if (Result = nil) then
  Result := Tk2NullTagImpl.Instance;
 {$Else  k2TagIsList}
 l_List := Tk2List(Self.HackChildren);
 if (l_List = nil) then
  Result := Tk2NullTagImpl.Instance
 else
  Result := l_List.FindChild(anAtom, aValue, aContext, aNeedCreate, theIndex);
 //Result := Attr[k2_tiChildren].FindChild(anAtom, aValue, aContext, aNeedCreate, theIndex);
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Result := Tk2NullTagImpl.Instance;
 {$EndIf  k2TagIsAtomic}
//#UC END# *4A42374B0371_53280B9801E7_impl*
end;//_k2TagPrim_.FindChild

procedure _k2TagPrim_.DeleteChildren(const Context: Il3OpPack);
 {* удалить всех детей. }
//#UC START# *4A42378D0030_53280B9801E7_var*
var
 AL         : Tl3Variant;
 l_Prop     : Tk2ArrayProperty;

 function DoChild(aChild: Tl3Variant; anIndex: Integer): Boolean;
 begin//
  Result := true;
  Context.Processor.NotifyDelete(AL, l_Prop, aChild, anIndex, Context);
 end;//DoChild

{$IfNDef k2TagIsList}
var
 l_List : Tk2TagList;
{$EndIf k2TagIsList}
//#UC END# *4A42378D0030_53280B9801E7_var*
begin
//#UC START# *4A42378D0030_53280B9801E7_impl*
 l_Prop := Tk2Type(Self.TagType).ArrayProp[k2_tiChildren];
 if (l_Prop <> nil) then
 begin
  AL := Attr[l_Prop.TagIndex];
  if AL.IsValid then
  begin
   {$IfNDef k2TagIsList}
   l_List := AL As Tk2TagList;
   {$EndIf  k2TagIsList}
   if (Context <> nil) then
   begin
    if not Context.InIOProcess then
     if l_Prop.NeedMarkModified then
      Context.MarkModified(Self);
    if (Context.Processor <> nil) then
     IterateChildrenBackF(L2Mk2ChildrenIterateChildrenBackAction(@DoChild));
   end;//(Context <> nil)..
   {$IfDef k2TagIsList}
   Clear;
   {$Else  k2TagIsList}
   l_List.Clear;
   {$EndIf k2TagIsList}
  end;//AL.IsValid
 end;//l_Prop <> nil
//#UC END# *4A42378D0030_53280B9801E7_impl*
end;//_k2TagPrim_.DeleteChildren

function _k2TagPrim_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_53280B9801E7_var*
//#UC END# *4A60B23E00C3_53280B9801E7_var*
begin
//#UC START# *4A60B23E00C3_53280B9801E7_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(Il3TagRef) then
  begin
   Il3TagRef(Obj) := Self.AsRef;
   Result.SetOk;
  end;//IID.EQ(Il3TagRef)
//#UC END# *4A60B23E00C3_53280B9801E7_impl*
end;//_k2TagPrim_.COMQueryInterface

function _k2TagPrim_.CompareWithInt(aValue: Integer;
 anIndex: Integer): Integer;
 {* Сравнивает тег с целым. }
//#UC START# *4BC8415802B6_53280B9801E7_var*
//#UC END# *4BC8415802B6_53280B9801E7_var*
begin
//#UC START# *4BC8415802B6_53280B9801E7_impl*
 Result := Tk2Type(Self.TagType).CompareTagWithInt(Self, aValue, anIndex);
//#UC END# *4BC8415802B6_53280B9801E7_impl*
end;//_k2TagPrim_.CompareWithInt

function _k2TagPrim_.CompareWithTag(aTag: Tl3Variant;
 aSortIndex: Tl3SortIndex): Integer;
//#UC START# *4BC8415E021A_53280B9801E7_var*
//#UC END# *4BC8415E021A_53280B9801E7_var*
begin
//#UC START# *4BC8415E021A_53280B9801E7_impl*
 Result := Tk2Type(Self.TagType).CompareTags(Self, aTag, aSortIndex);
//#UC END# *4BC8415E021A_53280B9801E7_impl*
end;//_k2TagPrim_.CompareWithTag

function _k2TagPrim_.rOwnAtom(anIndex: Integer): Tl3Variant;
//#UC START# *4BC843C40240_53280B9801E7_var*
var
 l_Value : Tl3Variant;
 l_Prop  : Tk2Prop;
//#UC END# *4BC843C40240_53280B9801E7_var*
begin
//#UC START# *4BC843C40240_53280B9801E7_impl*
 l_Prop := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop <> nil) AND Self.GetOwnAttrValue(l_Prop, l_Value) then
 begin
  if (l_Value = nil) then
   Result := Tk2NullTagImpl.Instance
  else
   Result := l_Value;
 end//(l_Prop <> nil) AND GetOwnAttrValue(l_Prop, l_Value)
 else
  Result := Tk2NullTagImpl.Instance;
//#UC END# *4BC843C40240_53280B9801E7_impl*
end;//_k2TagPrim_.rOwnAtom

function _k2TagPrim_.DeleteChildPrim(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_53280B9801E7_var*
{$IfDef k2TagIsList}
var
 {$IfNDef l3Items_NoSort}
 l_Remove : Bool;
 {$EndIf l3Items_NoSort}
 l_Prop   : Tk2ArrayProperty;
 l_Child  : Tl3Variant;
 {$IfNDef k2Tag_No_f_TagType}
 {$If (Defined(Nemesis) AND (not Defined(nsTest) OR Defined(InsiderTest)))}
 l_Owner  : Tl3Variant;
 // - это для заплатки удаления комментариев - http://mdp.garant.ru/pages/viewpage.action?pageId=157909474
 //   когда переделаю контейнерные ноды документа на Tk2ParentedTypedListTag,
 //   то можно быдет убрать.
 {$IfEnd}
 {$EndIf  k2Tag_No_f_TagType}
{$Else  k2TagIsList}
var
 l_List  : Tl3Variant;
{$EndIf k2TagIsList}
//#UC END# *4C6CE735026E_53280B9801E7_var*
begin
//#UC START# *4C6CE735026E_53280B9801E7_impl*
 {$IfDef k2TagIsList}
 Result := true;
 l_Prop := Tk2Type(Self.TagType).ArrayProp[k2_tiChildren];
 Assert(l_Prop <> nil);
 {$IfNDef l3Items_NoSort}
 l_Remove := not aChild.IsNull;
 if l_Remove then
  l_Child := aChild
 else
  l_Child := ItemSlot(anIndex).AsObject;
 {$Else  l3Items_NoSort}
 if not aChild.IsNull then
  l_Child := aChild
 else
  l_Child := ItemSlot(anIndex).AsObject;
 {$EndIf l3Items_NoSort}
 {$IfNDef k2Tag_No_f_TagType}
 {$If (Defined(Nemesis) AND (not Defined(nsTest) OR Defined(InsiderTest)))}
 l_Owner := nil;
 if (aContext <> nil) AND not aContext.InIOProcess then
 begin
  if Tk2Type(Self.TagType).AtomClass.InheritsFrom(Tk2List) then
   l_Owner := l_Child.Owner
 end;//Context <> nil
 {$IfEnd}
 {$EndIf k2Tag_No_f_TagType}
 l_Child.Owner := nil;
 {$IfNDef l3Items_NoSort}
 if l_Remove then
 begin
  {$IfNDef k2TagNoSort}
  if not Sorted then
   l_Remove := false;
  {$Else   k2TagNoSort}
  l_Remove := false;
  {$EndIf  k2TagNoSort}
 end;//l_Remove
 {$EndIf  l3Items_NoSort}
 k2.SignalEvent(l_Prop, k2_eidChildrenDeleted, Self, aContext, anIndex, 1, Count - 1);
 if (aContext <> nil) AND not aContext.InIOProcess then
 begin
  if not aContext.InIOProcess then
   {$IfNDef k2Tag_No_f_TagType}
   {$If (Defined(Nemesis) AND (not Defined(nsTest) OR Defined(InsiderTest)))}
   if (l_Owner <> nil) AND l_Owner.IsValid then
   begin
    if l_Prop.NeedMarkModified then
     aContext.MarkModified(l_Owner);
    if (aContext.Processor <> nil) then
     aContext.Processor.NotifyDelete(l_Owner, l_Prop, l_Child, anIndex, aContext)
   end//l_Owner <> nil..
   else
   {$IfEnd}
   {$EndIf k2Tag_No_f_TagType}
   begin
    if l_Prop.NeedMarkModified then
     aContext.MarkModified(Self);
    if (aContext.Processor <> nil) then
     aContext.Processor.NotifyDelete(Self, l_Prop, l_Child, anIndex, aContext);
   end;//l_Owner <> nil..
 end;//Context <> nil
 {$IfNDef l3Items_NoSort}
 if l_Remove then
 begin
  if (Remove(aChild) < 0) then
   Assert(false, 'Не удалось удалить дочерний тег');
 end
 else
  Delete(anIndex);
 {$Else  l3Items_NoSort}
 Delete(anIndex);
 {$EndIf l3Items_NoSort}
 {$Else  k2TagIsList}
 l_List := Attr[k2_tiChildren];
 if l_List.IsValid then
 begin
  if (aChild <> nil) AND aChild.IsValid then
   Result := l_List.DeleteChild(aChild, aContext)
  else
   Result := l_List.DeleteChild(anIndex, aContext);
 end//l_List.IsValid
 else
 begin
  Result := false;
  k2ListError(anIndex);
 end;//l_List
 {$EndIf k2TagIsList}
//#UC END# *4C6CE735026E_53280B9801E7_impl*
end;//_k2TagPrim_.DeleteChildPrim

function _k2TagPrim_.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_53280B9801E7_var*
//#UC END# *4C6D1C29031F_53280B9801E7_var*
begin
//#UC START# *4C6D1C29031F_53280B9801E7_impl*
 Result := Tk2Type(Self.TagType).Wrapper.MarkModified(Self);
//#UC END# *4C6D1C29031F_53280B9801E7_impl*
end;//_k2TagPrim_.DoMarkModified

procedure _k2TagPrim_.DoDoLoad;
//#UC START# *4CEFA0BA0233_53280B9801E7_var*
//#UC END# *4CEFA0BA0233_53280B9801E7_var*
begin
//#UC START# *4CEFA0BA0233_53280B9801E7_impl*
 // - ничего не делаем
//#UC END# *4CEFA0BA0233_53280B9801E7_impl*
end;//_k2TagPrim_.DoDoLoad

function _k2TagPrim_.DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
 aHi: Tl3Index;
 aLo: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *5081632303E6_53280B9801E7_var*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}

  function DoChild(aChild: Pl3Variant; anIndex: Long): Boolean;
  begin//DoChild
   Result := Action(aChild^, anIndex);
  end;//DoChild

 {$Else  k2TagIsList}
 var
  l_List : Tk2List;
 {$EndIf k2TagIsList}
 {$EndIf  k2TagIsAtomic}
//#UC END# *5081632303E6_53280B9801E7_var*
begin
//#UC START# *5081632303E6_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 Result := IterateBackF(aHi, aLo, l3L2IA(@DoChild));
 {$Else  k2TagIsList}
 l_List := Tk2List(HackChildren);
 if (l_List = nil) then
  Result := -1
 else
  Result := l_List.IterateChildrenBack(Action, aHi, aLo, aLoadedOnly);
// Result := Attr[k2_tiChildren].IterateChildrenBack(Action, aHi, aLo, aLoadedOnly);
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Result := -1;
 {$EndIf  k2TagIsAtomic}
//#UC END# *5081632303E6_53280B9801E7_impl*
end;//_k2TagPrim_.DoIterateChildrenBack

procedure _k2TagPrim_.DoForceStore;
//#UC START# *5321B9DF011A_53280B9801E7_var*
//#UC END# *5321B9DF011A_53280B9801E7_var*
begin
//#UC START# *5321B9DF011A_53280B9801E7_impl*
 Tk2Type(Self.TagType).Wrapper.ForceStore(Self);
//#UC END# *5321B9DF011A_53280B9801E7_impl*
end;//_k2TagPrim_.DoForceStore

function _k2TagPrim_.DoGetHasSubAtom(anIndex: Integer): Boolean;
//#UC START# *532AD5480329_53280B9801E7_var*
{$IfNDef k2TagIsAtomic}
var
 l_Prop : Tk2Prop;
{$EndIf  k2TagIsAtomic}
//#UC END# *532AD5480329_53280B9801E7_var*
begin
//#UC START# *532AD5480329_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 l_Prop := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop = nil) then
  Result := false
 else
  Result := _Instance_R_(Self).GetHasSubAtom(l_Prop);
 {$Else   k2TagIsAtomic}
 Result := false;
 {$EndIf  k2TagIsAtomic}
//#UC END# *532AD5480329_53280B9801E7_impl*
end;//_k2TagPrim_.DoGetHasSubAtom

function _k2TagPrim_.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_53280B9801E7_var*
//#UC END# *533121AF0203_53280B9801E7_var*
begin
//#UC START# *533121AF0203_53280B9801E7_impl*
 {$IfNDef k2Tag_No_f_TagType}
 Result := Self.f_TagType;
 {$Else   k2Tag_No_f_TagType}
 Result := inherited GetTagType;
 {$EndIf  k2Tag_No_f_TagType}
//#UC END# *533121AF0203_53280B9801E7_impl*
end;//_k2TagPrim_.GetTagType

procedure _k2TagPrim_.SetAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Tl3Variant);
//#UC START# *5331961F0280_53280B9801E7_var*
{$IfNDef k2TagIsAtomic}
var
 l_PropType  : Tk2Type;
 l_Prop      : _PropLoc_;

 procedure SetObj;
 var
  l_Tag : Tl3Variant;
  l_T   : Tk2Type;
 begin//SetObj
  l_T := Tk2Type(aValue.TagType);
  //Assert(Tk2Type(l_PropType).IsSame(aValue.TagType), l_PropType.AsString + ' несовместим с ' + aValue.TagType.AsString);
  if l_PropType.IsSame(l_T) then
   Self.SetSubAtom(_PropIn_(l_Prop), aValue)
  else
  if l_T.IsKindOf(l_PropType) then
   Self.SetSubAtom(_PropIn_(l_Prop), aValue)
  else
  begin
   if l_T.IsOrd then
    l_Tag := l_PropType.MakeTag(aValue.AsLong).AsObject
   else
    l_Tag := l_PropType.ObjToTag(aValue).AsObject;
   Self.SetSubAtom(_PropIn_(l_Prop), l_Tag);
  end;//l_PropType.IsSame(aValue.TagType)
 end;//SetObj

var
 l_inStream  : IStream;

 procedure SetStream;
 var
  l_outStream : IStream;
  l_Read      : Large;
  l_Written   : Large;
  l_Position  : Large;
 begin//SetStream
  if Supports(l_inStream, Ik2RawData) then
   SetObj
  else
  begin
   Assert(false);
   if Supports(cAtom(l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.TagIndex, aContext), IStream, l_outStream) then
   try
    l_inStream.Seek(0, STREAM_SEEK_SET, l_Position);
    l_inStream.CopyTo(l_outStream, High(Large), l_Read, l_Written);
    l_outStream.Seek(0, STREAM_SEEK_CUR, l_Position);
    l_outStream.SetSize(l_Position);
    if (l_Position = 0) then
     Self.SetSubAtom(_PropIn_(l_Prop), nil);
   finally
    l_outStream := nil;
   end//try..finally
   else
    Assert(false);
  end;//Supports(l_inStream, Ik2RawData)
 end;//SetStream

{$EndIf k2TagIsAtomic}
//#UC END# *5331961F0280_53280B9801E7_var*
begin
//#UC START# *5331961F0280_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp = nil) then
  Exit;
 l_Prop.rOp := Pointer(aContext);
 l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := true;
 //l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtTag;
 if (aValue = nil) then
  Self.SetSubAtom(_PropIn_(l_Prop), nil)
 else
 begin
  l_PropType := Tk2Type(l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.AtomType);
  if aValue.IsNull then
   Self.SetSubAtom(_PropIn_(l_Prop), nil)
  else
  if aValue.IsOrd then
  begin
   if l_PropType.IsOrd then
    Self.SetSubAtom(_PropIn_(l_Prop), aValue)
   else
    SetObj;
  end//aValue.IsOrd
  else
  if aValue.IsTransparent then
   Self.SetSubAtom(_PropIn_(l_Prop), aValue)
  else
  if aValue.IsStream(l_inStream) then
  begin
   try
    SetStream;
   finally
    l_inStream := nil;
   end;//try..finally
  end//aValue.IsStream
  else
   SetObj;
 end;//aValue = nil
 {$Else  k2TagIsAtomic}
 inherited;
 {$EndIf k2TagIsAtomic}
//#UC END# *5331961F0280_53280B9801E7_impl*
end;//_k2TagPrim_.SetAttr

function _k2TagPrim_.GetAttr(anIndex: Integer;
 out theValue: Tl3Variant): Boolean;
//#UC START# *53319C270138_53280B9801E7_var*
var
 l_Prop : Tk2Prop;
//#UC END# *53319C270138_53280B9801E7_var*
begin
//#UC START# *53319C270138_53280B9801E7_impl*
 l_Prop := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop <> nil) AND Self.GetAttrValue(l_Prop, theValue) then
  Result := true
 else
 begin
  //Result := false;
  Result := true;
  theValue := Tk2NullTagImpl.Instance;
 end;//(l_Prop <> nil) AND Self.GetAttrValue(l_Prop, theValue)
//#UC END# *53319C270138_53280B9801E7_impl*
end;//_k2TagPrim_.GetAttr

procedure _k2TagPrim_.SetBoolAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Boolean);
//#UC START# *5331B00B02DD_53280B9801E7_var*
var
 l_Prop : _PropLoc_;
 l_Tag  : Tl3Variant;
//#UC END# *5331B00B02DD_53280B9801E7_var*
begin
//#UC START# *5331B00B02DD_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp <> nil) then
 begin
  l_Prop.rOp := Pointer(aContext);
  l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := true;
  if aValue then
   l_Tag := k2_typBool.MakeTag(1).AsObject
  else
   l_Tag := k2_typBool.MakeTag(0).AsObject;
  Self.SetSubAtom(_PropIn_(l_Prop), l_Tag);
 end;//l_Prop <> nil
 {$Else  k2TagIsAtomic}
 inherited;
 {$EndIf k2TagIsAtomic}
//#UC END# *5331B00B02DD_53280B9801E7_impl*
end;//_k2TagPrim_.SetBoolAttr

procedure _k2TagPrim_.SetIntAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Integer);
//#UC START# *5332CD8801A6_53280B9801E7_var*
var
 l_Prop : _PropLoc_;
 l_Tag : Tl3variant;
//#UC END# *5332CD8801A6_53280B9801E7_var*
begin
//#UC START# *5332CD8801A6_53280B9801E7_impl*
 l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp <> nil) then
 begin
  l_Prop.rOp := Pointer(aContext);
  l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := true;
  l_Tag := l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.MakeTag(aValue).AsObject;
  pm_SetAttrW(anIndex, aContext, l_Tag);
 end;//l_Prop.rProp <> nil
//#UC END# *5332CD8801A6_53280B9801E7_impl*
end;//_k2TagPrim_.SetIntAttr

procedure _k2TagPrim_.SetWStrAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 const aValue: Tl3WString);
//#UC START# *5332FB8403B6_53280B9801E7_var*
var
 l_Prop : Tk2Prop;
 l_S : Tk2String;
//#UC END# *5332FB8403B6_53280B9801E7_var*
begin
//#UC START# *5332FB8403B6_53280B9801E7_impl*
 l_Prop := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop <> nil) then
 begin
  if l3IsNil(aValue) then
   AttrW[l_Prop.TagIndex, aContext] := nil
  else
  begin
   l_S := Tk2String.Make(aValue);
   try
    AttrW[l_Prop.TagIndex, aContext] := l_S;
   finally
    FreeAndNil(l_S);
   end;//try..finally
  end;//l3IsNil(aValue)
 end;//l_Prop <> nil
//#UC END# *5332FB8403B6_53280B9801E7_impl*
end;//_k2TagPrim_.SetWStrAttr

function _k2TagPrim_.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_53280B9801E7get_var*
//#UC END# *53343980014A_53280B9801E7get_var*
begin
//#UC START# *53343980014A_53280B9801E7get_impl*
 Result := inherited pm_GetTagOwner;
 if (Result = nil) then
  Result := Tk2NullTagImpl.Instance;
//#UC END# *53343980014A_53280B9801E7get_impl*
end;//_k2TagPrim_.pm_GetTagOwner

procedure _k2TagPrim_.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_53280B9801E7set_var*
//#UC END# *53343980014A_53280B9801E7set_var*
begin
//#UC START# *53343980014A_53280B9801E7set_impl*
 // - ничего не делаем
//#UC END# *53343980014A_53280B9801E7set_impl*
end;//_k2TagPrim_.pm_SetTagOwner

function _k2TagPrim_.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_53280B9801E7get_var*
 {$IfNDef k2TagIsAtomic}
 {$IfNDef k2TagIsList}
 var
  l_List : Tk2TagList;
 {$EndIf  k2TagIsList}
 {$EndIf  k2TagIsAtomic}
//#UC END# *5335815D03DC_53280B9801E7get_var*
begin
//#UC START# *5335815D03DC_53280B9801E7get_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 Result := Count;
 {$Else  k2TagIsList}
 l_List := HackChildren;
 if (l_List = nil) then
  Result := 0
 else
  Result := l_List.Count;
 //Result := Attr[k2_tiChildren].ChildrenCount;
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Result := 0;
 {$EndIf  k2TagIsAtomic}
//#UC END# *5335815D03DC_53280B9801E7get_impl*
end;//_k2TagPrim_.pm_GetChildrenCount

procedure _k2TagPrim_.pm_SetChildrenCapacity(aValue: Integer);
//#UC START# *533581770377_53280B9801E7set_var*
 {$IfNDef k2TagIsAtomic}
 {$IfNDef k2TagIsList}
 var
  l_List : Tk2TagList;
 {$EndIf  k2TagIsList}
 {$EndIf  k2TagIsAtomic}
//#UC END# *533581770377_53280B9801E7set_var*
begin
//#UC START# *533581770377_53280B9801E7set_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 if (Count < aValue) then
  Capacity := aValue;
 {$Else  k2TagIsList}
 l_List := HackChildren;
 if (l_List <> nil) then
  if (l_List.Count < aValue) then
   l_List.Capacity := aValue;
 //Result := Attr[k2_tiChildren].ChildrenCount;
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Assert(false);
 {$EndIf  k2TagIsAtomic}
//#UC END# *533581770377_53280B9801E7set_impl*
end;//_k2TagPrim_.pm_SetChildrenCapacity

function _k2TagPrim_.pm_GetChildPrim(anIndex: Integer): Tl3Variant;
//#UC START# *53358545012C_53280B9801E7get_var*
 {$IfNDef k2TagIsAtomic}
 {$IfNDef k2TagIsList}
 var
  l_List : Tk2List;
 {$EndIf  k2TagIsList}
 {$EndIf  k2TagIsAtomic}
//#UC END# *53358545012C_53280B9801E7get_var*
begin
//#UC START# *53358545012C_53280B9801E7get_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 Result := Items[anIndex];
 {$Else  k2TagIsList}
 l_List := Tk2List(HackChildren);
 if (l_List = nil) then
  Result := Tk2NullTagImpl.Instance
 else
  Result := l_List.Child[anIndex];
 //Result := Attr[k2_tiChildren].Child[anIndex];
 {$EndIf k2TagIsList}
 {$Else   k2TagIsAtomic}
 Result := Tk2NullTagImpl.Instance;
 {$EndIf  k2TagIsAtomic}
//#UC END# *53358545012C_53280B9801E7get_impl*
end;//_k2TagPrim_.pm_GetChildPrim

function _k2TagPrim_.DoAddChild(aChild: Tl3Variant;
 const aContext: Il3OpPack): Integer;
//#UC START# *533D587B0359_53280B9801E7_var*

 procedure RaiseNoChildren;
 begin//RaiseNoChildren
  raise Ek2CannotAddChild.CreateFmt(k2_errNoChildren,
                                    [Self.TagType.AsString, aChild.TagType.AsString])
 end;//RaiseNoChildren

var
 l_Prop  : Tk2ArrayProperty;
 
 procedure RaiseBadChild;
 begin//RaiseBadChild
  raise Ek2CannotAddChild.CreateFmt(k2_errBadChild,
                                    [Self.TagType.AsString, aChild.TagType.AsString, l_Prop.ChildType.AsString]);
 end;//RaiseBadChild
                                    
var
 l_Path  : TLongArray;
 {$IfDef k2TagIsList}
 {$Else  k2TagIsList}
 l_CList : TObject;
 {$EndIf k2TagIsList}
 l_Cnt   : Integer;
 l_Child : Tl3Variant;
//#UC END# *533D587B0359_53280B9801E7_var*
begin
//#UC START# *533D587B0359_53280B9801E7_impl*
 assert(aChild <> nil);
 l_Prop := Tk2Type(Self.TagType).ArrayProp[k2_tiChildren];
 if (l_Prop = nil) then
 begin
  l_Path := Tk2Type(Self.TagType).FindChildPath(Tk2Type(aChild.TagType));
  Result := -1;
  if (l_Path = nil) then
   RaiseNoChildren
  else
   cAtomEx(l_Path, aContext).AddChild(aChild, aContext);
 end//l_Prop = nil
 else
 begin
  l_Child := aChild.Use;
  try
   if not l_Prop.ValidateChild(Self, l_Child, aContext, High(Integer)) then
   begin
    Result := -1;
    l_Path := Tk2Type(Self.TagType).FindChildPath(Tk2Type(l_Child.TagType));
    if (l_Path = nil) then
     RaiseBadChild
    else
     cAtomEx(l_Path, aContext).AddChild(l_Child, aContext);
   end//not l_Prop.ValidateChild(Self, l_Child)
   else
   begin
    {$IfDef k2TagIsList}
    {$Else  k2TagIsList}
    l_CList := cAtom(k2_tiChildren, aContext);
    Assert(l_CList Is Tk2TagList);
    {$EndIf k2TagIsList}
    l_Cnt := {$IfDef k2TagIsList}
             Count
             {$Else  k2TagIsList}
             Tk2TagList(l_CList).Count
             {$EndIf k2TagIsList};
    if (l_Cnt < l_Prop.MaxChildrenCount) then
    begin
     CheckChildInsert(l_Cnt, l_Child, aContext);
     with Tk2Type(l_Child.TagType) do
      if HasProperty[k2_tiChildren] then
       l_Child.Box.CheckSort(ArrayProp[k2_tiChildren]);
     Result := {$IfNDef k2TagIsList}
               Tk2TagList(l_CList).
               {$EndIf  k2TagIsList}Add(l_Child.Box);
     {$IfDef k2TagIsList}
     ChildAdded(l_Prop, l_Child, Result, Count, aContext);
     {$Else  k2TagIsList}
     ChildAdded(l_Prop, l_Child, Result, Tk2TagList(l_CList).Count, aContext);
     {$EndIf k2TagIsList}
    end//Tk2TagList(l_CList).Count < l_Prop.MaxChildrenCount
    else
     Result := -1;
   end;//not l_Prop.ValidateChild(Self, l_Child)
  finally
   FreeAndNil(l_Child);
  end;//try..finally
 end;//l_Prop = nil
//#UC END# *533D587B0359_53280B9801E7_impl*
end;//_k2TagPrim_.DoAddChild

function _k2TagPrim_.CheckAttr(const aPath: array of Integer;
 const aContext: Il3OpPack;
 DoCheck: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *533D6FD80051_53280B9801E7_var*
var
 l_Index      : Integer;
 l_Prop       : Tk2CustomProperty;
 l_SaveResult : Tl3Variant;
//#UC END# *533D6FD80051_53280B9801E7_var*
begin
//#UC START# *533D6FD80051_53280B9801E7_impl*
 Result := Self;
 try
  l_Index := Low(aPath);
  while (l_Index <= High(aPath)) do
  begin
   if (Result = nil) then
    Exit
   else
   if Result.IsNull then
    Exit;
   l_Prop := Tk2CustomProperty(Tk2Type(Result.TagType).Prop[aPath[l_Index]]);
   if (l_Prop = nil) OR l_Prop.IsNull then
   begin
    Result := nil;
    Exit;
   end;//l_Prop = nil
   l_SaveResult := Result;

   Result := nil;
   with l_SaveResult do
   begin
    Result := rOwnAtom(l_Prop.TagIndex);
    if DoCheck AND Result.IsNull then
    begin
     Result := l_Prop.MakeTag.AsObject;
     AttrW[l_Prop.TagIndex, aContext] := Result;
    end;//DoCheck AND Result.IsNull
   end;//with l_SaveResult

   if (l_Index < High(aPath)) then
   begin
    if l_Prop.IsArray AND Result.IsValid then
    begin
     if (l_Index = Pred(High(aPath))) then k2ListError(l_Index);
     Result := Result.FindChild(aPath[l_Index + 1],
                                aPath[l_Index + 2],
                                aContext, DoCheck, theIndex);
     Inc(l_Index, 2);
    end;//l_Prop.IsArray AND Result.IsValid
   end;//l_Index < High(aPath)
   Inc(l_Index);
  end;//while (l_Index <= High(aPath))
 finally
  if (Result = nil) then
   Result := Tk2NullTagImpl.Instance;
 end;//try..finally
//#UC END# *533D6FD80051_53280B9801E7_impl*
end;//_k2TagPrim_.CheckAttr

function _k2TagPrim_.DoCAtom(anIndex: Integer;
 const aContext: Il3OpPack;
 anAtomType: Tl3VariantDef): Tl3Variant;
//#UC START# *533D791300DA_53280B9801E7_var*
{$IfNDef k2TagIsAtomic}
var
 l_Prop  : _PropLoc_;
 l_Value : Tl3Variant;
{$IfNDef k2TagIsList}
 l_Holder : Il3TagRef;
{$EndIf  k2TagIsList}
{$EndIf k2TagIsAtomic}
//#UC END# *533D791300DA_53280B9801E7_var*
begin
//#UC START# *533D791300DA_53280B9801E7_impl*
 {$IfNDef k2TagIsAtomic}
 {$IfDef k2TagIsList}
 if (anIndex = k2_tiChildren) then
 begin
  Result := Self;
  Exit;
 end;//anIndex = k2_tiChildren
 {$EndIf k2TagIsList}
 l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := Tk2Prop(Tk2Type(Self.TagType).Prop[anIndex]);
 if (l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp = nil) then
  Result := Tk2NullTagImpl.Instance
 else
 begin
  if Self.GetOwnAttrValue(Tk2Prop(l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp), l_Value) then
   Result := l_Value
  else
  begin
   if (anAtomType = nil) then
   begin
    {$IfNDef k2TagIsList}
    if (anIndex = k2_tiChildren) AND
       Tk2Type(l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.AtomType).IsAuto then
    // - заплатка для f1
    begin
     l_Holder := Tk2List.Make(k2_typOList);
     Result := l_Holder.AsObject;                                                
    end//anIndex = k2_tiChildren..
    else
    {$EndIf  k2TagIsList}
    begin
     Assert(anIndex <> k2_tiChildren);
     Result := l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp.MakeTag.AsObject;
    end;//anIndex = k2_tiChildren
   end//anAtomType = nil
   else
    Result := anAtomType.MakeTag.AsObject;
   l_Prop.rOp := Pointer(aContext);
   l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := true;
   //l_Prop{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtTag;
   Self.SetSubAtom(_PropIn_(l_Prop), Result);
  end;//Result.IsNull
 end;//l_Prop = nil
 {$Else   k2TagIsAtomic}
 Result := inherited DoCAtom(anIndex, aContext, anAtomType);
 {$EndIf  k2TagIsAtomic}
//#UC END# *533D791300DA_53280B9801E7_impl*
end;//_k2TagPrim_.DoCAtom

{$EndIf k2TagPrim_imp_impl}

{$EndIf k2TagPrim_imp}

