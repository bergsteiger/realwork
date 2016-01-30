unit f1TagDataFromDTP;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataFromDTP.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DocumentUnit
 , F1TagDataProviderInterface
 , k2Base
 , IOUnit
 , l3Interfaces
 , l3Variant
 , nevBase
 , l3CProtoObject
;

type
 DTPLayerID = TLayerID;

 Tf1ListTagDataFromDTPPrim = class;

 {$Include f1TagDataProviderPrim.imp.pas}
 Tf1TagDataFromDTP = {abstract} class(_f1TagDataProviderPrim_, If1TagDataProvider)
  {* Базовый поставщик данных о параграфе }
  protected
   f_f_Provider: IDocumentTextProvider;
  protected
   function pm_Getf_Provider: IDocumentTextProvider; virtual;
   function pm_GetEntryPoint: TEntryPoint;
   function pm_GetChild(anIndex: TChildID): If1TagDataProvider; virtual;
   function pm_GetParentPrim: Tf1ListTagDataFromDTPPrim; virtual;
   function DoGetType: Tk2Type; virtual;
   function GetChildID: TChildID; virtual; abstract;
   function GetParentLayerID: DTPLayerID; virtual; abstract;
   function GetAllParaChildrenCount: Integer; virtual;
   function GetChildrenCount: Integer; virtual;
   function Get_Caption: IString;
   function Get_Style: IStream;
   function Get_ExternalID: Integer;
   function Get_TypeID: Tk2Type;
   procedure Set_wStyle(const aValue: IStream);
   function Get_AllParaChildrenCount: Integer;
   function Get_ChildrenCount: Integer;
   function Get_FirstChild: If1TagDataProvider;
   function Get_SiblingByIndex(anIndex: Integer): If1TagDataProvider;
   function Get_Next: If1TagDataProvider;
   function Get_AsDocumentTextProvider: IDocumentTextProvider;
   function Get_Comment: IStream;
   function Get_TechComment: IString;
   function Get_IsProviderGot: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aProvider: IDocumentTextProvider); reintroduce;
   procedure CreateNewNode(var theIndex: Integer;
    var theNode: Tl3Tag;
    const aMaker: If1ChildMaker;
    const anOp: InevOp);
   procedure BuildSubs(aProp: Tk2CustomProperty;
    const aChecker: If1AtomChecker);
  private
   property ParentPrim: Tf1ListTagDataFromDTPPrim
    read pm_GetParentPrim;
  protected
   property f_Provider: IDocumentTextProvider
    read pm_Getf_Provider;
   property EntryPoint: TEntryPoint
    read pm_GetEntryPoint;
   property Child[anIndex: TChildID]: If1TagDataProvider
    read pm_GetChild;
 end;//Tf1TagDataFromDTP

 Tf1ListTagDataFromDTPPrim = class(Tf1TagDataFromDTP)
  {* Поставщик данных о списке параграфов }
  private
   f_LayerID: DTPLayerID;
    {* Поле для свойства LayerID }
  protected
   function pm_GetLayerID: DTPLayerID;
   procedure InitFields; override;
   function GetAllParaChildrenCount: Integer; override;
   function GetChildrenCount: Integer; override;
   function pm_GetChild(anIndex: TChildID): If1TagDataProvider; override;
  public
   property LayerID: DTPLayerID
    read pm_GetLayerID;
 end;//Tf1ListTagDataFromDTPPrim

implementation

uses
 l3ImplUses
 , LeafParaDecorationsHolder_Const
 , nevTools
 , LeafPara_Const
 , nsNativeCommentPara
 , CommentPara_Const
 , k2Tags
 , nsLeafParaDecorationsHolder
 , nsCommentModifier
 , nsParaModifier
 , k2Facade
 , f1TagDataFromDTPFactory
;

{$Include f1TagDataProviderPrim.imp.pas}

function Tf1TagDataFromDTP.pm_Getf_Provider: IDocumentTextProvider;
//#UC START# *4C727B320016_4C727ADB0312get_var*
//#UC END# *4C727B320016_4C727ADB0312get_var*
begin
//#UC START# *4C727B320016_4C727ADB0312get_impl*
 Result := f_f_Provider;
//#UC END# *4C727B320016_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.pm_Getf_Provider

function Tf1TagDataFromDTP.pm_GetEntryPoint: TEntryPoint;
//#UC START# *4C727F1A00BC_4C727ADB0312get_var*
//#UC END# *4C727F1A00BC_4C727ADB0312get_var*
begin
//#UC START# *4C727F1A00BC_4C727ADB0312get_impl*
 Result.rChild := Self.GetChildID;
 Result.rLayer := Self.GetParentLayerID;
//#UC END# *4C727F1A00BC_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.pm_GetEntryPoint

function Tf1TagDataFromDTP.pm_GetChild(anIndex: TChildID): If1TagDataProvider;
//#UC START# *4C7298A100C9_4C727ADB0312get_var*
//#UC END# *4C7298A100C9_4C727ADB0312get_var*
begin
//#UC START# *4C7298A100C9_4C727ADB0312get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C7298A100C9_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.pm_GetChild

function Tf1TagDataFromDTP.pm_GetParentPrim: Tf1ListTagDataFromDTPPrim;
//#UC START# *4C72A6B5000F_4C727ADB0312get_var*
//#UC END# *4C72A6B5000F_4C727ADB0312get_var*
begin
//#UC START# *4C72A6B5000F_4C727ADB0312get_impl*
 Result := nil;
//#UC END# *4C72A6B5000F_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.pm_GetParentPrim

constructor Tf1TagDataFromDTP.Create(const aProvider: IDocumentTextProvider);
//#UC START# *4C727B5001D1_4C727ADB0312_var*
//#UC END# *4C727B5001D1_4C727ADB0312_var*
begin
//#UC START# *4C727B5001D1_4C727ADB0312_impl*
 inherited Create;
 f_f_Provider := aProvider;
//#UC END# *4C727B5001D1_4C727ADB0312_impl*
end;//Tf1TagDataFromDTP.Create

function Tf1TagDataFromDTP.DoGetType: Tk2Type;
//#UC START# *4D66B40B02C4_4C727ADB0312_var*
//#UC END# *4D66B40B02C4_4C727ADB0312_var*
begin
//#UC START# *4D66B40B02C4_4C727ADB0312_impl*
 Result := k2.TypeTable.TypeByHandle[Ord(f_Provider.GetChildType(Self.EntryPoint))];
//#UC END# *4D66B40B02C4_4C727ADB0312_impl*
end;//Tf1TagDataFromDTP.DoGetType

function Tf1TagDataFromDTP.GetAllParaChildrenCount: Integer;
//#UC START# *4C7294F40339_4C727ADB0312_var*
//#UC END# *4C7294F40339_4C727ADB0312_var*
begin
//#UC START# *4C7294F40339_4C727ADB0312_impl*
 Result := -1;
 Assert(false);
//#UC END# *4C7294F40339_4C727ADB0312_impl*
end;//Tf1TagDataFromDTP.GetAllParaChildrenCount

function Tf1TagDataFromDTP.GetChildrenCount: Integer;
//#UC START# *4C7295160269_4C727ADB0312_var*
//#UC END# *4C7295160269_4C727ADB0312_var*
begin
//#UC START# *4C7295160269_4C727ADB0312_impl*
 Result := -1;
 Assert(false);
//#UC END# *4C7295160269_4C727ADB0312_impl*
end;//Tf1TagDataFromDTP.GetChildrenCount

function Tf1TagDataFromDTP.Get_Caption: IString;
//#UC START# *4C6EA2B000F6_4C727ADB0312get_var*
//#UC END# *4C6EA2B000F6_4C727ADB0312get_var*
begin
//#UC START# *4C6EA2B000F6_4C727ADB0312get_impl*
 f_Provider.GetChildText(Self.EntryPoint, Result);
//#UC END# *4C6EA2B000F6_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_Caption

function Tf1TagDataFromDTP.Get_Style: IStream;
//#UC START# *4C6EA2D1023E_4C727ADB0312get_var*
//#UC END# *4C6EA2D1023E_4C727ADB0312get_var*
begin
//#UC START# *4C6EA2D1023E_4C727ADB0312get_impl*
 f_Provider.GetChildEvdStyle(Self.EntryPoint, Result);
//#UC END# *4C6EA2D1023E_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_Style

function Tf1TagDataFromDTP.Get_ExternalID: Integer;
//#UC START# *4C6EA2F700DA_4C727ADB0312get_var*
//#UC END# *4C6EA2F700DA_4C727ADB0312get_var*
begin
//#UC START# *4C6EA2F700DA_4C727ADB0312get_impl*
 Result := f_Provider.GetChildExternalId(Self.EntryPoint);
//#UC END# *4C6EA2F700DA_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_ExternalID

function Tf1TagDataFromDTP.Get_TypeID: Tk2Type;
//#UC START# *4C6EA8390114_4C727ADB0312get_var*
//#UC END# *4C6EA8390114_4C727ADB0312get_var*
begin
//#UC START# *4C6EA8390114_4C727ADB0312get_impl*
 Result := DoGetType;
//#UC END# *4C6EA8390114_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_TypeID

procedure Tf1TagDataFromDTP.Set_wStyle(const aValue: IStream);
//#UC START# *4C6EAB57003B_4C727ADB0312set_var*
//#UC END# *4C6EAB57003B_4C727ADB0312set_var*
begin
//#UC START# *4C6EAB57003B_4C727ADB0312set_impl*
 DoSetWStyle(aValue);
//#UC END# *4C6EAB57003B_4C727ADB0312set_impl*
end;//Tf1TagDataFromDTP.Set_wStyle

function Tf1TagDataFromDTP.Get_AllParaChildrenCount: Integer;
//#UC START# *4C6EB42D017A_4C727ADB0312get_var*
//#UC END# *4C6EB42D017A_4C727ADB0312get_var*
begin
//#UC START# *4C6EB42D017A_4C727ADB0312get_impl*
 Result := Self.GetAllParaChildrenCount;
//#UC END# *4C6EB42D017A_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_AllParaChildrenCount

function Tf1TagDataFromDTP.Get_ChildrenCount: Integer;
//#UC START# *4C6EB4470246_4C727ADB0312get_var*
//#UC END# *4C6EB4470246_4C727ADB0312get_var*
begin
//#UC START# *4C6EB4470246_4C727ADB0312get_impl*
 Result := Self.GetChildrenCount;
//#UC END# *4C6EB4470246_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_ChildrenCount

procedure Tf1TagDataFromDTP.CreateNewNode(var theIndex: Integer;
 var theNode: Tl3Tag;
 const aMaker: If1ChildMaker;
 const anOp: InevOp);
//#UC START# *4C6EB48D0004_4C727ADB0312_var*
var
 l_Holder  : Tl3Tag;
 l_List    : Tl3Tag;
 l_Leaf    : Tl3Variant;
 l_Comment : Tl3Tag;
 l_ID      : Integer;
 l_Para    : InevPara;
 l_Cont    : InevDocumentContainer;
//#UC END# *4C6EB48D0004_4C727ADB0312_var*
begin
//#UC START# *4C6EB48D0004_4C727ADB0312_impl*
 if theNode.IsKindOf(k2_typLeafParaDecorationsHolder) then
 begin
  Assert(theNode.ChildrenCount > 0, 'http://mdp.garant.ru/pages/viewpage.action?pageId=265391680');
  if (theNode.ChildrenCount > 1) then
   if theNode.Child[1].IsKindOf(k2_typCommentPara) then
    theNode.Child[1].MarkModified;
  Exit;
 end;//theNode.IsKindOf(k2_typLeafParaDecorationsHolder)
 Assert(theNode.IsKindOf(k2_typCommentPara));
 Dec(theIndex);
 Assert(theIndex >= 0);
 l_List := aMaker.Tag;
 Assert(l_List <> nil);
 l_Leaf := l_List.Child[theIndex];
 Assert(l_Leaf.IsKindOf(k2_typLeafPara), 'Тип параграфа: ' + l_Leaf.TagType.AsString);
 Assert(anOp <> nil);
 l_ID := l_Leaf.IntA[k2_tiHandle];
 Assert(l_ID <> 0);
 if not l_Leaf.QT(InevPara, l_Para) then
  Assert(false);
 anOp.CheckOff;
 try
  l_List.DeleteChild(theIndex, anOp);

  l_Holder := TnsLeafParaDecorationsHolder.Make.AsObject;
  l_Holder.AddChild(l_Leaf, anOp);
  l_Comment := TnsNativeCommentPara.Make(theNode).AsObject;
  l_Comment.IntA[k2_tiHandle] := l_ID;
  l_Holder.AddChild(l_Comment);
  l_Holder.SetRef(theNode);
  l_Cont := l_Para.DocumentContainer;
  if (l_Cont <> nil) then
   l_Cont.RealizeSub(l_Comment.IntA[k2_tiLayerID], l_Comment, l_Comment);
 finally
  anOp.CheckOn;
 end;//try..finally
//#UC END# *4C6EB48D0004_4C727ADB0312_impl*
end;//Tf1TagDataFromDTP.CreateNewNode

function Tf1TagDataFromDTP.Get_FirstChild: If1TagDataProvider;
//#UC START# *4C6EB4E70277_4C727ADB0312get_var*
//#UC END# *4C6EB4E70277_4C727ADB0312get_var*
begin
//#UC START# *4C6EB4E70277_4C727ADB0312get_impl*
 Result := Self.Child[0];
//#UC END# *4C6EB4E70277_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_FirstChild

procedure Tf1TagDataFromDTP.BuildSubs(aProp: Tk2CustomProperty;
 const aChecker: If1AtomChecker);
//#UC START# *4C722FCA0397_4C727ADB0312_var*
//#UC END# *4C722FCA0397_4C727ADB0312_var*
begin
//#UC START# *4C722FCA0397_4C727ADB0312_impl*
 DoBuildSubs(aProp, aChecker);
//#UC END# *4C722FCA0397_4C727ADB0312_impl*
end;//Tf1TagDataFromDTP.BuildSubs

function Tf1TagDataFromDTP.Get_SiblingByIndex(anIndex: Integer): If1TagDataProvider;
//#UC START# *4C723CF1024D_4C727ADB0312get_var*
//#UC END# *4C723CF1024D_4C727ADB0312get_var*
begin
//#UC START# *4C723CF1024D_4C727ADB0312get_impl*
 Result := ParentPrim.Child[anIndex];
//#UC END# *4C723CF1024D_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_SiblingByIndex

function Tf1TagDataFromDTP.Get_Next: If1TagDataProvider;
//#UC START# *4C7240410220_4C727ADB0312get_var*
//#UC END# *4C7240410220_4C727ADB0312get_var*
begin
//#UC START# *4C7240410220_4C727ADB0312get_impl*
 Result := ParentPrim.Child[Succ(Self.GetChildID)];
//#UC END# *4C7240410220_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_Next

function Tf1TagDataFromDTP.Get_AsDocumentTextProvider: IDocumentTextProvider;
//#UC START# *4C99D2C600BC_4C727ADB0312get_var*
//#UC END# *4C99D2C600BC_4C727ADB0312get_var*
begin
//#UC START# *4C99D2C600BC_4C727ADB0312get_impl*
 Result := f_Provider;
//#UC END# *4C99D2C600BC_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_AsDocumentTextProvider

function Tf1TagDataFromDTP.Get_Comment: IStream;
//#UC START# *4CEFAFB700D1_4C727ADB0312get_var*
var
 Temp: Int64;
//#UC END# *4CEFAFB700D1_4C727ADB0312get_var*
begin
//#UC START# *4CEFAFB700D1_4C727ADB0312get_impl*
 f_Provider.GetChildComment(Self.EntryPoint, Result);
 if Assigned(Result) then
  Result.Seek(0, 0, Temp); // http://mdp.garant.ru/pages/viewpage.action?pageId=398276218
//#UC END# *4CEFAFB700D1_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_Comment

function Tf1TagDataFromDTP.Get_TechComment: IString;
//#UC START# *4D0F4C9E0379_4C727ADB0312get_var*
//#UC END# *4D0F4C9E0379_4C727ADB0312get_var*
begin
//#UC START# *4D0F4C9E0379_4C727ADB0312get_impl*
 f_Provider.GetChildTechComment(Self.EntryPoint, Result);
//#UC END# *4D0F4C9E0379_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_TechComment

function Tf1TagDataFromDTP.Get_IsProviderGot: Boolean;
//#UC START# *4D6E5C270068_4C727ADB0312get_var*
//#UC END# *4D6E5C270068_4C727ADB0312get_var*
begin
//#UC START# *4D6E5C270068_4C727ADB0312get_impl*
 Result := (f_f_Provider <> nil);
//#UC END# *4D6E5C270068_4C727ADB0312get_impl*
end;//Tf1TagDataFromDTP.Get_IsProviderGot

procedure Tf1TagDataFromDTP.ClearFields;
begin
 f_f_Provider := nil;
 inherited;
end;//Tf1TagDataFromDTP.ClearFields

function Tf1ListTagDataFromDTPPrim.pm_GetLayerID: DTPLayerID;
//#UC START# *4C72897703B9_4C727C5B007Bget_var*
//#UC END# *4C72897703B9_4C727C5B007Bget_var*
begin
//#UC START# *4C72897703B9_4C727C5B007Bget_impl*
 if (f_LayerID = High(f_LayerID)) then
  f_LayerID := f_Provider.GetChildLayerID(Self.EntryPoint);
 Result := f_LayerID; 
//#UC END# *4C72897703B9_4C727C5B007Bget_impl*
end;//Tf1ListTagDataFromDTPPrim.pm_GetLayerID

procedure Tf1ListTagDataFromDTPPrim.InitFields;
//#UC START# *47A042E100E2_4C727C5B007B_var*
//#UC END# *47A042E100E2_4C727C5B007B_var*
begin
//#UC START# *47A042E100E2_4C727C5B007B_impl*
 f_LayerID := High(f_LayerID);
 inherited;
//#UC END# *47A042E100E2_4C727C5B007B_impl*
end;//Tf1ListTagDataFromDTPPrim.InitFields

function Tf1ListTagDataFromDTPPrim.GetAllParaChildrenCount: Integer;
//#UC START# *4C7294F40339_4C727C5B007B_var*
//#UC END# *4C7294F40339_4C727C5B007B_var*
begin
//#UC START# *4C7294F40339_4C727C5B007B_impl*
 Result := f_Provider.AllLeafParaCount(Self.LayerID);
//#UC END# *4C7294F40339_4C727C5B007B_impl*
end;//Tf1ListTagDataFromDTPPrim.GetAllParaChildrenCount

function Tf1ListTagDataFromDTPPrim.GetChildrenCount: Integer;
//#UC START# *4C7295160269_4C727C5B007B_var*
//#UC END# *4C7295160269_4C727C5B007B_var*
begin
//#UC START# *4C7295160269_4C727C5B007B_impl*
 Result := f_Provider.ChildrenCount(Self.LayerID);
//#UC END# *4C7295160269_4C727C5B007B_impl*
end;//Tf1ListTagDataFromDTPPrim.GetChildrenCount

function Tf1ListTagDataFromDTPPrim.pm_GetChild(anIndex: TChildID): If1TagDataProvider;
//#UC START# *4C7298A100C9_4C727C5B007Bget_var*
//#UC END# *4C7298A100C9_4C727C5B007Bget_var*
begin
//#UC START# *4C7298A100C9_4C727C5B007Bget_impl*
 Result := Tf1TagDataFromDTPFactory.MakeProvider(f_Provider, Self, anIndex);
//#UC END# *4C7298A100C9_4C727C5B007Bget_impl*
end;//Tf1ListTagDataFromDTPPrim.pm_GetChild

end.
