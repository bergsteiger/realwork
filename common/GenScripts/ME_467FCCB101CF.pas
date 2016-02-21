unit nsTagNodePrim;
 {* Реализация тега, представляющего данные из адаптерной ноды }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodePrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsTagNodePrimPrim
 , F1TagDataProviderInterface
 , k2Base
 , l3Variant
 , nsTagString
 , IOUnit
 , l3IID
 , l3Interfaces
;

type
 DocTagNodeType = If1TagDataProvider;

 _StyleParser_Parent_ = TnsTagNodePrimPrim;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\StyleParser.imp.pas}
 TnsTagNodePrim = {abstract} class(_StyleParser_)
  {* Реализация тега, представляющего данные из адаптерной ноды }
  private
   f_TagDataProvider: DocTagNodeType;
    {* Поле для свойства TagDataProvider }
  protected
   f_State: TnsNodeStates;
  protected
   procedure ParseStyle;
   function GetTextAtomFromCaption(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean;
   procedure DoParseStyle; virtual;
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(k2TagIsAtomic)}
   function GetHasSubAtom(aProp: Tk2Prop): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function GetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DoMarkModified: Boolean; override;
   procedure ClearFields; override;
  public
   procedure ResetStyle;
   function CheckAtom(aProp: Tk2Prop): Tl3Tag;
   constructor Create(aType: Tk2Type;
    const aNode: DocTagNodeType;
    aState: TnsNodeStates); reintroduce;
   class function MakeNodeTag(const aNode: DocTagNodeType;
    aState: TnsNodeStates = []): Il3TagRef;
   function HasTagDataProvider: Boolean;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  protected
   property TagDataProvider: DocTagNodeType
    read f_TagDataProvider
    write f_TagDataProvider;
    {* Источник данных тега }
 end;//TnsTagNodePrim

implementation

uses
 l3ImplUses
 , l3Base
 , evdVer
 , DynamicTreeUnit
 , BitmapPara_Const
 , k2Empty_Const
 , nsStyleParser
 , SysUtils
 , l3CustomString
 , k2Tags
 , k2Facade
 , l3BitArr
;

{$If not Declared(_HashType_)}type _HashType_ = Tl3PtrHash;{$IfEnd}

type _Instance_R_ = TnsTagNodePrim;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\StyleParser.imp.pas}

procedure TnsTagNodePrim.ParseStyle;
//#UC START# *4C6D1CE80342_467FCCB101CF_var*
//#UC END# *4C6D1CE80342_467FCCB101CF_var*
begin
//#UC START# *4C6D1CE80342_467FCCB101CF_impl*
 if not (ns_nsStyleParsed in f_State) then
 begin
  Include(f_State, ns_nsStyleParsed);
  DoParseStyle;
 end;//not (ns_nsStyleParsed in f_State)
//#UC END# *4C6D1CE80342_467FCCB101CF_impl*
end;//TnsTagNodePrim.ParseStyle

function TnsTagNodePrim.GetTextAtomFromCaption(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
var l_Text: TnsTagString;
var l_String: IString;
//#UC START# *4C6D1D74024A_467FCCB101CF_var*
//#UC END# *4C6D1D74024A_467FCCB101CF_var*
begin
//#UC START# *4C6D1D74024A_467FCCB101CF_impl*
 Result := false;
 l_String := f_TagDataProvider.Caption;
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
//#UC END# *4C6D1D74024A_467FCCB101CF_impl*
end;//TnsTagNodePrim.GetTextAtomFromCaption

procedure TnsTagNodePrim.ResetStyle;
//#UC START# *4C6D1DCA021E_467FCCB101CF_var*
//#UC END# *4C6D1DCA021E_467FCCB101CF_var*
begin
//#UC START# *4C6D1DCA021E_467FCCB101CF_impl*
 Exclude(f_State, ns_nsStyleParsed);
 AttrW[k2_tiChildren, nil] := nil;
//#UC END# *4C6D1DCA021E_467FCCB101CF_impl*
end;//TnsTagNodePrim.ResetStyle

function TnsTagNodePrim.CheckAtom(aProp: Tk2Prop): Tl3Tag;
//#UC START# *4C6D1DEE0339_467FCCB101CF_var*
//var
// l_Data : Tl3Variant;
//#UC END# *4C6D1DEE0339_467FCCB101CF_var*
begin
//#UC START# *4C6D1DEE0339_467FCCB101CF_impl*
 if BaseGetSubAtom(aProp, Result) AND not Result.IsNull then
 begin
(*  if not l_Data.GetInterface(_Ik2Tag, Result) then
   Assert(false);*)
 end//BaseGetSubAtom(aProp, l_Data)
 else
 begin
  Result := aProp.MakeTag.AsObject;
  StoreTagAtom(aProp, Result);
 end;//BaseGetSubAtom(aProp, l_Data)
//#UC END# *4C6D1DEE0339_467FCCB101CF_impl*
end;//TnsTagNodePrim.CheckAtom

constructor TnsTagNodePrim.Create(aType: Tk2Type;
 const aNode: DocTagNodeType;
 aState: TnsNodeStates);
//#UC START# *4C6D1E5C03C8_467FCCB101CF_var*
//#UC END# *4C6D1E5C03C8_467FCCB101CF_var*
begin
//#UC START# *4C6D1E5C03C8_467FCCB101CF_impl*
 f_TagDataProvider := aNode;
 f_State := aState;
 inherited Create(aType);
//#UC END# *4C6D1E5C03C8_467FCCB101CF_impl*
end;//TnsTagNodePrim.Create

class function TnsTagNodePrim.MakeNodeTag(const aNode: DocTagNodeType;
 aState: TnsNodeStates = []): Il3TagRef;
//#UC START# *4C6D1E950086_467FCCB101CF_var*
var
 l_Tag  : TnsTagNodePrim;
 l_Type : Tk2Type;
//#UC END# *4C6D1E950086_467FCCB101CF_var*
begin
//#UC START# *4C6D1E950086_467FCCB101CF_impl*
 if (aNode = nil) then
  Result := k2NullTag
 else
 begin
  l_Type := aNode.TypeID;
  if (l_Type = nil) OR (l_Type = k2_typEmpty) then
   Result := k2NullTag
  else
  begin
   l_Tag := Create(l_Type, aNode, aState);
   try
    Result := l_Tag.AsRef;
   finally
    FreeAndNil(l_Tag);
   end;//try..finally
  end;//l_Type = nil
 end;//aNode = nil
//#UC END# *4C6D1E950086_467FCCB101CF_impl*
end;//TnsTagNodePrim.MakeNodeTag

function TnsTagNodePrim.HasTagDataProvider: Boolean;
//#UC START# *4C6E885102A4_467FCCB101CF_var*
//#UC END# *4C6E885102A4_467FCCB101CF_var*
begin
//#UC START# *4C6E885102A4_467FCCB101CF_impl*
 Result := (f_TagDataProvider <> nil);
//#UC END# *4C6E885102A4_467FCCB101CF_impl*
end;//TnsTagNodePrim.HasTagDataProvider

procedure TnsTagNodePrim.DoParseStyle;
//#UC START# *4C6D1D01003A_467FCCB101CF_var*
//#UC END# *4C6D1D01003A_467FCCB101CF_var*
begin
//#UC START# *4C6D1D01003A_467FCCB101CF_impl*
 DoDoParseStyle(f_TagDataProvider.Style);
//#UC END# *4C6D1D01003A_467FCCB101CF_impl*
end;//TnsTagNodePrim.DoParseStyle

function TnsTagNodePrim.DoGetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_467FCCB101CF_var*
var
 l_ID : Integer;
//#UC END# *4C6D1D450332_467FCCB101CF_var*
begin
//#UC START# *4C6D1D450332_467FCCB101CF_impl*
 Result := true;
 Case aProp.TagIndex of
  k2_tiHandle :
  begin
   // http://mdp.garant.ru/pages/viewpage.action?pageId=425267808
   if Self.IsKindOf(k2_typBitmapPara) then
    Result := False
   else
   begin
    if (f_TagDataProvider = nil) then
     Result := false
    else
    begin
     l_ID := Integer(f_TagDataProvider.ExternalID);
     if (l_ID <> 0) then
     begin
      StoreIntAtom(aProp, l_ID);
      Result := BaseGetSubAtom(aProp, Data);
//      Data := Attr[k2_tiHandle];
     end//l_ID <> 0
     else
      Data := nil;
    end;//f_TagDataProvider = nil
   end;
   if not Result OR (Data = nil) then
   begin
    ParseStyle;
    Result := BaseGetSubAtom(aProp, Data);
   end;//not Result OR (Data = 0)
  end;//k2_tiHandle
  k2_tiShortName,
  k2_tiText,
  k2_tiReqID :
  begin
   ParseStyle;
   Result := BaseGetSubAtom(aProp, Data);
   if not Result then
    Result := GetTextAtomFromCaption(aProp, Data);
  end;//k2_tiShortName
  k2_tiData :
  begin
   ParseStyle;
   Result := BaseGetSubAtom(aProp, Data);
  end;//k2_tiData
  k2_tiChildren :
   Result := BaseGetSubAtom(aProp, Data);
  else
  begin
   ParseStyle;
   Result := BaseGetSubAtom(aProp, Data);
  end;//else
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_467FCCB101CF_impl*
end;//TnsTagNodePrim.DoGetSubAtom

procedure TnsTagNodePrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_467FCCB101CF_var*
//#UC END# *479731C50290_467FCCB101CF_var*
begin
//#UC START# *479731C50290_467FCCB101CF_impl*
 inherited;
 f_TagDataProvider := nil;
//#UC END# *479731C50290_467FCCB101CF_impl*
end;//TnsTagNodePrim.Cleanup

{$If NOT Defined(k2TagIsAtomic)}
function TnsTagNodePrim.GetHasSubAtom(aProp: Tk2Prop): Boolean;
//#UC START# *49A544E802B2_467FCCB101CF_var*
var
 l_Stream : IStream;
//#UC END# *49A544E802B2_467FCCB101CF_var*
begin
//#UC START# *49A544E802B2_467FCCB101CF_impl*
 if (aProp <> nil) then
 begin
  Case aProp.TagIndex of
   k2_tiExternalHandle,
   k2_tiHandle,
   k2_tiShortName,
   k2_tiText,
   k2_tiAllChildrenCount :
    Result := true;
(*   k2_tiData :
   begin
    l_Stream := f_TagDataProvider.Data;
    Result := (l_Stream <> nil);
   end;//k2_tiData*)
   else
   begin
    ParseStyle;
    Result := inherited GetHasSubAtom(aProp);
   end;//else
  end;//Case aProp.TagIndex
 end//(aProp <> nil)
 else
  Result := inherited GetHasSubAtom(aProp);
//#UC END# *49A544E802B2_467FCCB101CF_impl*
end;//TnsTagNodePrim.GetHasSubAtom
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function TnsTagNodePrim.GetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *49A54517029C_467FCCB101CF_var*
//#UC END# *49A54517029C_467FCCB101CF_var*
begin
//#UC START# *49A54517029C_467FCCB101CF_impl*
 Assert(aProp <> nil);
 Result := DoGetSubAtom(aProp, Data);
//#UC END# *49A54517029C_467FCCB101CF_impl*
end;//TnsTagNodePrim.GetSubAtom

procedure TnsTagNodePrim.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_467FCCB101CF_var*
var
 l_A : Tl3Variant;
//#UC END# *49A545D501F6_467FCCB101CF_var*
begin
//#UC START# *49A545D501F6_467FCCB101CF_impl*
 if not All then
 begin
  ParseStyle;
  // - чтобы вычитать все свойства из стиля
  l_A := Attr[k2_tiHandle];
 // http://mdp.garant.ru/pages/viewpage.action?pageId=356071766&focusedCommentId=469798191#comment-469798191
//  if l_A.IsValid AND (l_A.AsLong <> 0) then
//   Action(l_A, Tk2Prop(TagType.Prop[k2_tiHandle]));
 end;//not All
 inherited;
//#UC END# *49A545D501F6_467FCCB101CF_impl*
end;//TnsTagNodePrim.DoIterateProperties

function TnsTagNodePrim.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_467FCCB101CF_var*
//#UC END# *4A60B23E00C3_467FCCB101CF_var*
begin
//#UC START# *4A60B23E00C3_467FCCB101CF_impl*
 if IID.EQ(DocTagNodeType) then
 begin
  if (f_TagDataProvider = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   DocTagNodeType(Obj) := f_TagDataProvider;
  end;//f_TagDataProvider = nil
 end//IID.EQ(DocTagNodeType)
 else
 if IID.EQ(IDocumentTextProvider) then
 begin
  if (f_TagDataProvider = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   IDocumentTextProvider(Obj) := f_TagDataProvider.AsDocumentTextProvider;
   if (IDocumentTextProvider(Obj) <> nil) then
    Result.SetOk
   else
    Result.SetNoInterface;
  end;//f_TagDataProvider = nil
 end//IID.EQ(DocTagNodeType)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_467FCCB101CF_impl*
end;//TnsTagNodePrim.COMQueryInterface

function TnsTagNodePrim.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_467FCCB101CF_var*
//#UC END# *4C6D1C29031F_467FCCB101CF_var*
begin
//#UC START# *4C6D1C29031F_467FCCB101CF_impl*
 Result := true;
//#UC END# *4C6D1C29031F_467FCCB101CF_impl*
end;//TnsTagNodePrim.DoMarkModified

procedure TnsTagNodePrim.ClearFields;
begin
 TagDataProvider := nil;
 inherited;
end;//TnsTagNodePrim.ClearFields

end.
