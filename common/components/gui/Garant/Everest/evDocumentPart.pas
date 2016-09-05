unit evDocumentPart;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentPart.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evDocumentPart" MUID: (4857B15A000E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , l3CustomString
 , l3Variant
 , nevBase
 , evConst
;

const
 evDocumentPartMargin = evConst.evInchMul div 8;
 evDocumentPartLineSpace = evDocumentPartMargin div 2;

function evGetBlockName(const aPara: Tl3Variant): Tl3CustomString;
procedure evDocumentPartSetShowLevel(const aDocument: Tl3Variant;
 aLevel: LongInt;
 const aProcessor: InevProcessor);
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , TextPara_Const
 , Block_Const
 , Document_Const
 , ParaList_Const
 //#UC START# *4857B15A000Eimpl_uses*
 //#UC END# *4857B15A000Eimpl_uses*
;

procedure evParaListSetLevel(const aList: Tl3Variant;
 aLevel: LongInt;
 aCurrentLevel: LongInt;
 const anOpPack: InevOp);
//#UC START# *4F7D72CD0155_4857B15A000E_var*

 function lp_SetChildLevel(aChild: Tl3Variant; anIndex: LongInt): Boolean; far;
 begin
  if aChild.IsKindOf(k2_typParaList) then
   evParaListSetLevel(aChild, aLevel, aCurrentLevel, anOpPack);
  Result := true;
 end;

//#UC END# *4F7D72CD0155_4857B15A000E_var*
begin
//#UC START# *4F7D72CD0155_4857B15A000E_impl*
 with aList do begin
  if IsKindOf(k2_typBlock) then begin
   if not IsKindOf(k2_typDocument) then 
    BoolW[k2_tiCollapsed, anOpPack] := (aCurrentLevel >= aLevel);
   Inc(aCurrentLevel);
  end;//k2_idBlock
  if (aCurrentLevel <= aLevel) then
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_SetChildLevel));
 end;//with aList
//#UC END# *4F7D72CD0155_4857B15A000E_impl*
end;//evParaListSetLevel

function evGetBlockName(const aPara: Tl3Variant): Tl3CustomString;
//#UC START# *4DFF31800349_4857B15A000E_var*
var
 l_Child  : Tl3Variant;
 l_Parent : Tl3Variant;
//#UC END# *4DFF31800349_4857B15A000E_var*
begin
//#UC START# *4DFF31800349_4857B15A000E_impl*
 with aPara.Attr[k2_tiShortName] do
  if IsValid then
  begin
   if (AsObject Is Tl3CustomString) then
    // - хакерская проверка для словарных статей
    Result := AsObject As Tl3CustomString
   else
   if (ChildrenCount > 0) then
   begin
    with Child[0] do
     if IsValid then
      Result := AsObject As Tl3CustomString
     else
      Result := nil;
   end//ChildrenCount > 0
   else
    Result := nil;
   if not Result.Empty then Exit;
  end//IsValid
  else
   Result := nil;
 if aPara.IsKindOf(k2_typParaList) then
 begin
  l_Parent := aPara.AsObject;
  while (l_Parent.ChildrenCount > 0) do
  begin
   l_Child := l_Parent.Child[0];
   with l_Child.Attr[k2_tiText] do
    if IsValid then
     Result := AsObject As Tl3CustomString
    else
     Result := nil;
   if not Result.Empty then
    Break;
   if not l_Child.IsKindOf(k2_typParaList) then
    Break;
   l_Parent := l_Child;
  end;//while true
 end// k2_idParaList ..
 else
 if aPara.IsKindOf(k2_typTextPara) then
 begin
  with aPara.Attr[k2_tiText] do
   if IsValid then
    Result := AsObject As Tl3CustomString;
 end;//aPara.IsKindOf(k2_typTextPara)
//#UC END# *4DFF31800349_4857B15A000E_impl*
end;//evGetBlockName

procedure evDocumentPartSetShowLevel(const aDocument: Tl3Variant;
 aLevel: LongInt;
 const aProcessor: InevProcessor);
//#UC START# *4F7D70BC039D_4857B15A000E_var*
var
 l_OpPack : InevOp;
//#UC END# *4F7D70BC039D_4857B15A000E_var*
begin
//#UC START# *4F7D70BC039D_4857B15A000E_impl*
 if (aProcessor = nil) then
  l_OpPack := nil
 else
  l_OpPack := aProcessor.StartOp;
 try
  evParaListSetLevel(aDocument, aLevel, 0, l_OpPack);
 finally
  l_OpPack := nil;
 end;//try..finally
//#UC END# *4F7D70BC039D_4857B15A000E_impl*
end;//evDocumentPartSetShowLevel
{$IfEnd} // Defined(k2ForEditor)

end.
