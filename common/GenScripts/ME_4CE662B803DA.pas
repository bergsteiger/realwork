unit nsDictionDocumentContainer;
 {* Контейнер документа толкового словаря }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DictionLikeDocumentProcessing\nsDictionDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , eeDocumentContainer
 {$IfEnd} // Defined(Nemesis)
 , l3Variant
 , F1TagDataProviderInterface
 , DocumentInterfaces
 , DocumentUnit
 , nevTools
 , afwInterfaces
 , nevPrintableDocumentContainer
 , l3IID
 , nevBase
 , l3Interfaces
;

type
 _nsDocumentContainer_Parent_ = TeeDocumentContainer;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 TnsDictionDocumentContainer = class(_nsDocumentContainer_)
  {* Контейнер документа толкового словаря }
  protected
   function GetDocument: Tl3Tag; override;
 end;//TnsDictionDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Document_Const
 , Block_Const
 , k2Tags
 , nsF1DocumentTagNode
 , DictEntry_Const
 , BaseTypesUnit
 , SysUtils
 , nsIDocumentDataObject
 , nsDocumentPreview
 , nsHAFPainter
 , LoggingInterfaces
 , nsDocumentPrintEvent
 , deDocInfo
 , DataAdapter
 , evdTypes
 , nsTypes
 , LeafPara_Const
 , nsTagString
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , afwFacade
;

{$If Defined(Nemesis)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}

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
{$IfEnd} // Defined(Nemesis)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
