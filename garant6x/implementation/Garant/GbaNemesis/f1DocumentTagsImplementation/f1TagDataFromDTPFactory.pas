unit f1TagDataFromDTPFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1TagDataFromDTPFactory.pas"
// Начат: 23.08.2010 18:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::Tf1TagDataFromDTPFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DocumentUnit,
  k2Base,
  F1TagDataProviderInterface,
  f1TagDataFromDTP
  ;

type
 _f1TagDataProviderFactory_Parent_ = TObject;
 {$Include ..\f1DocumentTagsImplementation\f1TagDataProviderFactory.imp.pas}
 Tf1TagDataFromDTPFactory = class(_f1TagDataProviderFactory_)
 public
 // public methods
   class function MakeProvider(const aProvider: IDocumentTextProvider;
     aParent: Tf1ListTagDataFromDTPPrim;
     aChildID: TChildID): If1TagDataProvider;
 end;//Tf1TagDataFromDTPFactory

implementation

uses
  f1LeafTagDataFromDTP,
  f1ListTagDataFromDTP,
  nevBase,
  k2Facade,
  ParaList_Const,
  LeafPara_Const,
  CommentPara_Const,
  Document_Const,
  Block_Const,
  SysUtils
  ;

{$Include ..\f1DocumentTagsImplementation\f1TagDataProviderFactory.imp.pas}

// start class Tf1TagDataFromDTPFactory

class function Tf1TagDataFromDTPFactory.MakeProvider(const aProvider: IDocumentTextProvider;
  aParent: Tf1ListTagDataFromDTPPrim;
  aChildID: TChildID): If1TagDataProvider;
//#UC START# *4C727B6A0242_4C7286FE0291_var*
var
 l_EP : TEntryPoint;
//#UC END# *4C727B6A0242_4C7286FE0291_var*
var
 l_T : Tk2Type;
 l_P : Tf1TagDataFromDTP;
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