unit nsDictionDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DictionLikeDocumentProcessing"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DictionLikeDocumentProcessing/nsDictionDocumentContainer.pas"
// Начат: 19.11.2010 14:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::DictionLike::DictionLikeDocumentProcessing::DocumentContainers::TnsDictionDocumentContainer
//
// Контейнер документа толкового словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  eeDocumentContainer
  {$IfEnd} //Nemesis
  ,
  DocumentUnit,
  nevTools,
  DocumentInterfaces,
  F1TagDataProviderInterface,
  afwInterfaces,
  l3Interfaces,
  nevBase,
  l3Variant,
  k2Base,
  nevPrintableDocumentContainer,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _nsDocumentContainer_Parent_ = TeeDocumentContainer;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 TnsDictionDocumentContainer = class(_nsDocumentContainer_)
  {* Контейнер документа толкового словаря }
 protected
 // overridden protected methods
   function GetDocument: Tl3Tag; override;
 end;//TnsDictionDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Document_Const,
  Block_Const,
  k2Tags,
  nsF1DocumentTagNode,
  DictEntry_Const,
  BaseTypesUnit,
  SysUtils,
  nsIDocumentDataObject,
  nsDocumentPreview,
  nsHAFPainter,
  LoggingInterfaces,
  nsDocumentPrintEvent,
  deDocInfo,
  DataAdapter,
  evdTypes,
  nsTypes,
  LeafPara_Const,
  nsTagString
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}

// start class TnsDictionDocumentContainer

function TnsDictionDocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4CE662B803DA_var*
var
 l_D : Tl3Tag;
 l_ID : Integer;
 l_Index : Integer;
 l_B : Tl3Variant;
 l_P : IDocumentTextProvider;
//#UC END# *47F27DA80172_4CE662B803DA_var*
begin
//#UC START# *47F27DA80172_4CE662B803DA_impl*
 Result := inherited GetDocument;
 if (Result = nil) then
 begin
  Result := k2_typDictEntry.MakeTag.AsObject;
  //Result := k2_typDocument.MakeTag;
  try
   l_ID := Ord(f_DocumentInfo.Language) + 101;
   //http://mdp.garant.ru/pages/viewpage.action?pageId=285507600
   try
    f_DocumentInfo.Doc.GetTextProvider(false, l_P);
   except
    on ECanNotFindData do
    begin
     Result := nil;
     Exit;
    end;
   end;
   Assert(l_P <> nil);
   l_D := TnsF1DocumentTagNode.Make(l_P).AsObject;
   Assert(l_D <> nil);
   Result.IntA[k2_tiExternalHandle] := l_D.IntA[k2_tiExternalHandle];
   with l_D do
   begin
    Assert(IsValid);
    for l_Index := 0 to Pred(ChildrenCount) do
    begin
     l_B := Child[l_Index];
     if l_B.IsKindOf(k2_typBlock) then
      if (l_B.IntA[k2_tiHandle] = l_ID) then
      begin
       Result.AddChild(l_B);
       Assert(l_B.Owner.IsSame(Result));
       Exit;
      end;//l_B.IntA[k2_tiHandle] = l_ID
    end;//for l_Index
    Assert(false, 'Не найден блок языка - ' + IntToStr(l_ID));
   end;//with l_D
  finally
   Document := Result;
   // - это СПЕЦИАЛЬНО ПОСЛЕ создания оглавления
  end;//try..finally
 end;//Result = nil
//#UC END# *47F27DA80172_4CE662B803DA_impl*
end;//TnsDictionDocumentContainer.GetDocument

{$IfEnd} //not Admin AND not Monitorings

end.