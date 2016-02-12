unit f1TagDataFromDTPFactory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataFromDTPFactory.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , k2Base
 , f1TagDataFromDTP
 , F1TagDataProviderInterface
 , DocumentUnit
;

type
 _f1TagDataProviderFactory_Parent_ = TObject;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataProviderFactory.imp.pas}
 Tf1TagDataFromDTPFactory = class(_f1TagDataProviderFactory_)
  public
   class function MakeProvider(const aProvider: IDocumentTextProvider;
    aParent: Tf1ListTagDataFromDTPPrim;
    aChildID: TChildID): If1TagDataProvider;
 end;//Tf1TagDataFromDTPFactory

implementation

uses
 l3ImplUses
 , k2Facade
 , ParaList_Const
 , LeafPara_Const
 , CommentPara_Const
 , Document_Const
 , Block_Const
 , SysUtils
 , f1LeafTagDataFromDTP
 , f1ListTagDataFromDTP
 , nevBase
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataProviderFactory.imp.pas}

class function Tf1TagDataFromDTPFactory.MakeProvider(const aProvider: IDocumentTextProvider;
 aParent: Tf1ListTagDataFromDTPPrim;
 aChildID: TChildID): If1TagDataProvider;
var l_T: Tk2Type;
var l_P: Tf1TagDataFromDTP;
//#UC START# *4C727B6A0242_4C7286FE0291_var*
var
 l_EP : TEntryPoint;
//#UC END# *4C727B6A0242_4C7286FE0291_var*
begin
//#UC START# *4C727B6A0242_4C7286FE0291_impl*
 Assert(aProvider <> nil);
 l_EP.rChild := aChildID;
 l_EP.rLayer := aParent.LayerID;
 try
  l_T := k2.TypeTable.TypeByHandle[Ord(aProvider.GetChildType(l_EP))];
 except
  on EInvalidEntryPoint do
   raise EnevMaybeBaseSwitched.Create('Наверное переключили базы. <K>: 344135940');
 end;//try..except
 Assert(l_T <> nil);
 l_P := nil;
 try
  if l_T.IsKindOf(k2_typLeafPara) then
   l_P := Tf1LeafTagDataFromDTP.Create(aProvider, aParent, aChildID)
  else
(*  if l_T.IsKindOf(k2_typCommentPara) then
   l_P := Tf1CommentTagDataFromDTP.Create(aProvider, aParent, aChildID)
  else*)
  if l_T.IsKindOf(k2_typParaList) then
   l_P := Tf1ListTagDataFromDTP.Create(aProvider, aParent, aChildID)
  else
  begin
   Assert(false, 'Неверный тип тега - ' + l_T.AsString);
   // - т.к. нельзя создавать экземпляры Tf1TagDataFromDTP, т.к. он - абстрактный
   l_P := Tf1TagDataFromDTP.Create(aProvider);
  end;//l_T.IsKindOf(k2_typParaList)
  Result := l_P;
 finally
  FreeAndNil(l_P);
 end;//try..finally
//#UC END# *4C727B6A0242_4C7286FE0291_impl*
end;//Tf1TagDataFromDTPFactory.MakeProvider

end.
