unit nsDocumentTagNodePrim;
 {* Базовая нода документа. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsDocumentTagNodePrim.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsBlockNodePrim
 , k2Base
 , l3Variant
;

type
 TnsDocumentTagNodePrim = class(TnsBlockNodePrim)
  {* Базовая нода документа. }
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function GetHasSubAtom(aProp: Tk2Prop): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
 end;//TnsDocumentTagNodePrim

implementation

uses
 l3ImplUses
 , nsTagString
 , DataAdapter
 , k2Tags
 , IOUnit
 , DocumentUnit
 , l3CustomString
 , SysUtils
 , k2Const
 , evTextStyle_Const
 , evdTextStyle_Const
 , evdStyles
;

{$If NOT Defined(k2TagIsAtomic)}
function TnsDocumentTagNodePrim.GetHasSubAtom(aProp: Tk2Prop): Boolean;
//#UC START# *49A544E802B2_467FCF9300AE_var*
//#UC END# *49A544E802B2_467FCF9300AE_var*
begin
//#UC START# *49A544E802B2_467FCF9300AE_impl*
 if (aProp <> nil) then
 begin
  Case aProp.TagIndex of
   k2_tiName :
    Result := true;
   else
    Result := inherited GetHasSubAtom(aProp);
  end;//Case aProp.TagIndex
 end//(aProp <> nil)
 else
  Result := inherited GetHasSubAtom(aProp);
//#UC END# *49A544E802B2_467FCF9300AE_impl*
end;//TnsDocumentTagNodePrim.GetHasSubAtom
{$IfEnd} // NOT Defined(k2TagIsAtomic)

procedure TnsDocumentTagNodePrim.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_467FCF9300AE_var*
//#UC END# *49A545D501F6_467FCF9300AE_var*
begin
//#UC START# *49A545D501F6_467FCF9300AE_impl*
 Attr[k2_tiLineSpacing];
 Attr[k2_tiStyle];
 if not All then
 begin
  Action(Attr[k2_tiExternalHandle], Tk2Prop(Tk2Type(TagType).Prop[k2_tiExternalHandle]));
  //Action(rAtom(k2_tiName), TagType.Prop[k2_tiName]);
  Attr[k2_tiName];
  Attr[k2_tiShortName];
 end//not All
 else
  Attr[k2_tiExternalHandle];
 inherited;
//#UC END# *49A545D501F6_467FCF9300AE_impl*
end;//TnsDocumentTagNodePrim.DoIterateProperties

function TnsDocumentTagNodePrim.DoGetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_467FCF9300AE_var*

 function HasInternetImage : Boolean;
 var
  l_Doc : IDocument;
  l_MI  : IMissingInfo;
 begin//HasInternetImage
  Result := false;
  if DefDataAdapter.CommonInterfaces.GetDocumentOnNumber(TagDataProvider.ExternalID, l_Doc, l_MI) then
   Result := l_Doc.HasInternetImage
  else
   Result := false;
 end;//HasInternetImage

 function GetNameFromDocument(const aProp : Tk2Prop;
                                 out Data    : Tl3Variant): Boolean;
 var
  l_Text   : TnsTagString;
  l_String : IString;
  l_Doc    : IDocument;
  l_MI     : IMissingInfo;
 begin//GetNameFromDocument
  Result := false;
  if DefDataAdapter.CommonInterfaces.GetDocumentOnNumber(TagDataProvider.ExternalID, l_Doc, l_MI) then
  //if Supports(Node, IDocument, l_Doc) then
   try
    l_Doc.GetName(l_String);
    if (l_String <> nil) then
    begin
     l_Text := TnsTagString.Create(l_String);
     try
      StoreTagAtom(aProp, l_Text);
      Result := true;
      Data := l_Text;
     finally
      FreeAndNil(l_Text);
     end;//try..finally
    end;//l_String <> nil
   finally
    l_Doc := nil;
   end;//try..finally
 end;//GetNameFromDocument

var
 l_Style : Integer;
//#UC END# *4C6D1D450332_467FCF9300AE_var*
begin
//#UC START# *4C6D1D450332_467FCF9300AE_impl*
 Result := true;
 Case aProp.TagIndex of
  k2_tiExternalHandle:
   Data := aProp.MakeTag(TagDataProvider.ExternalID).AsObject;
  k2_tiHandle :
   Result := BaseGetSubAtom(aProp, Data);
  k2_tiLineSpacing:
  begin
   Result := BaseGetSubAtom(aProp, Data);
   if not Result {OR (Data = k2_TransparentValue)} then
   begin
    Result := true;
    //Data := 125;
    //Data := 100;
    StoreIntAtom(aProp, 100);
    Result := BaseGetSubAtom(aProp, Data);
    //Data := Attr[aProp.TagIndex];
   end;//not Result
  end;//k2_tiLineSpacing
  k2_tiStyle:
  begin
   Result := BaseGetSubAtom(aProp, Data);
   if not Result then
   begin
    if HasInternetImage then
     l_Style := ev_saLinkToPublication
    else
     l_Style := ev_saTxtNormalANSI;
    StoreTagAtom(aProp, k2_typTextStyle.ValueTable.DRByID[l_Style]);
    Result := BaseGetSubAtom(aProp, Data);
   end;//not Result
  end;//k2_tiStyle
  k2_tiName:
  begin
   ParseStyle;
   Result := BaseGetSubAtom(aProp, Data);
   if not Result then
    Result := GetNameFromDocument(aProp, Data);
  end;//k2_tiName
  else
   Result := inherited DoGetSubAtom(aProp, Data);
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_467FCF9300AE_impl*
end;//TnsDocumentTagNodePrim.DoGetSubAtom

end.
