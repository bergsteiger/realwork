unit nsF1DocumentContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsF1DocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsF1DocumentContainerPrim
 , l3TreeInterfaces
 , l3Variant
 , nevBase
 , F1TagDataProviderInterface
 , DocumentInterfaces
 , DocumentUnit
 , nevTools
 , afwInterfaces
 , nevPrintableDocumentContainer
 , l3IID
 , l3Interfaces
;

type
 _nsDocumentContainer_Parent_ = TnsF1DocumentContainerPrim;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 TnsF1DocumentContainer = class(_nsDocumentContainer_)
  private
   f_ContentsTree: Il3SimpleTree;
    {* Дерево оглавления }
  protected
   procedure TransformMadeDocument(var theDocument: Tl3Tag); virtual;
    {* Трансформирует документ к его подмножеству, например как в ААК или Толковом Словаре }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetDocument: Tl3Tag; override;
   function GetContentsTree: InevSimpleTree; override;
   procedure ClearFields; override;
 end;//TnsF1DocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsF1DocumentTagNode
 , nsMedicContentsTree
 , nsContentsTree
 , DynamicTreeUnit
 , nsManagers
 , BaseTypesUnit
 , ComObj
 , evTypes
 , l3Types
 , evdNativeReader
 , evdVer
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
 , k2Tags
 , nsTagString
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , afwFacade
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}

procedure TnsF1DocumentContainer.TransformMadeDocument(var theDocument: Tl3Tag);
 {* Трансформирует документ к его подмножеству, например как в ААК или Толковом Словаре }
//#UC START# *500ED7750045_4C6A9AD101B4_var*
//#UC END# *500ED7750045_4C6A9AD101B4_var*
begin
//#UC START# *500ED7750045_4C6A9AD101B4_impl*
 // - ничего не делаем, оставляем документ как есть
//#UC END# *500ED7750045_4C6A9AD101B4_impl*
end;//TnsF1DocumentContainer.TransformMadeDocument

procedure TnsF1DocumentContainer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C6A9AD101B4_var*
//#UC END# *479731C50290_4C6A9AD101B4_var*
begin
//#UC START# *479731C50290_4C6A9AD101B4_impl*
 if (f_ContentsTree <> nil) then
  f_ContentsTree.Unsubscribe(Il3ItemNotifyRecipient(Self));
 f_ContentsTree := nil;
 inherited;
//#UC END# *479731C50290_4C6A9AD101B4_impl*
end;//TnsF1DocumentContainer.Cleanup

function TnsF1DocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4C6A9AD101B4_var*

 procedure lp_FinishProfile;
 begin
  {$IfDef vcmUseProfilers}
  ProfilersManager.Document.DocumentReceived;
  {$EndIf vcmUseProfilers}
 end;

 procedure GetDocumentStub;
 var
  l_S : IStream;
  l_Res : Int64;
  l_R : TevdNativeReader;
 begin//GetDocumentStub
  f_DocumentInfo.Doc.GetEVDStream(l_S);
  Assert(l_S <> nil);
  try
   OleCheck(l_S.Seek(0, STREAM_SEEK_SET, l_Res));
   l_R := TevdNativeReader.Create;
   try
    l_R.ForceBinary := true;
    l_R.CurrentVersion := evNonPackedVer;
    l_R.Filer.COMStream := l_S;
    try
     //Self.WriteTag(nil, cf_EverestBin, l_S, nil);
     Self.WriteTagEx(nil, l_R);
    finally
     l_R.Filer.COMStream := nil;
    end;//try..finally
    Assert(inherited GetDocument <> nil);
   finally
    FreeAndNil(l_R);
   end;//try..finally
  finally
   l_S := nil;
  end;//try..finally
 end;//GetDocumentStub

var
 l_P : IDocumentTextProvider;
 l_Node : INodeBase;
 l_TmpContents : Il3SimpleTree;
 l_Tree : InsContentsTree;
 l_Result : Tl3Tag;
//#UC END# *47F27DA80172_4C6A9AD101B4_var*
begin
//#UC START# *47F27DA80172_4C6A9AD101B4_impl*
 Result := inherited GetDocument;
 if (Result = nil) then
 begin
  try
   if (f_DocumentInfo.Doc = nil) then
    Exit;
   f_DocumentInfo.Doc.GetTextProvider(false, l_P);
   Assert(l_P <> nil);
   Result := TnsF1DocumentTagNode.Make(l_P).AsObject;
  except
   on ECannotFindData do
   // - документа нету, надо получить заглушку
   begin
    GetDocumentStub;
    Result := inherited GetDocument;
    Exit;
   end;//on ECannotFindData
  end;//try..except
  // Ниже делаем оглавление
  try
   f_DocumentInfo.Doc.GetContentsRoot(l_Node);
  except
   on ECannotFindData do
    l_Node := nil;
  end;//try..except 
  try
   if (l_Node = nil) then
    l_TmpContents := nil
   else  
   if (f_DocumentInfo.Doc.GetDocType = DT_MEDICAL_DOCUMENT) then
    l_TmpContents := TnsMedicContentsTree.Make(l_Node, Result)
   else
    l_TmpContents := TnsContentsTree.Make(l_Node, Result);
   // Если дерево оглавления уже есть
   // пытаемся при необходимости поменить
   // ему рут, делая таким образом отложенный 
   // DataReset и RegetRootNode (cq24170)
   if Assigned(l_TmpContents) and
      Supports(f_ContentsTree, InsContentsTree, l_Tree) and
      l_Tree.NeedResetRoot then
    l_Tree.ResetRoot(Result, l_TmpContents.RootNode)
   else
   begin
    if Assigned(f_ContentsTree) then
     f_ContentsTree.UnSubscribe(Il3ItemNotifyRecipient(Self));
    f_ContentsTree := l_TmpContents;
    if Assigned(f_ContentsTree) then
     f_ContentsTree.Subscribe(Il3ItemNotifyRecipient(Self));
   end;
   {$IfDef vcmUseProfilers}
   if not Assigned(f_ContentsTree) then
    ProfilersManager.Document.ContentsTreeOpened;
     // - дерево оглавления отсутствует или по умолчанию включено не показывать
     //   оглавление;
   {$EndIf vcmUseProfilers}
  finally
   l_Node := nil;
  end;//try..finally
  // - тут закончили создание оглавления
  l_Result := Result.Use;
  try
   TransformMadeDocument(l_Result);
   Document := l_Result;
   Result := l_Result;
  finally
   FreeAndNil(l_Result);
  end;//try..finally
  // - это СПЕЦИАЛЬНО ПОСЛЕ создания оглавления
 end//Result = nil
 else
 begin
  {$IfDef vcmUseProfilers}
  lp_FinishProfile;
  ProfilersManager.Document.ContentsTreeOpened;
  {$EndIf vcmUseProfilers}
 end;//(Result = nil)
//#UC END# *47F27DA80172_4C6A9AD101B4_impl*
end;//TnsF1DocumentContainer.GetDocument

function TnsF1DocumentContainer.GetContentsTree: InevSimpleTree;
//#UC START# *47F2802003C4_4C6A9AD101B4_var*
//#UC END# *47F2802003C4_4C6A9AD101B4_var*
begin
//#UC START# *47F2802003C4_4C6A9AD101B4_impl*
 Result := f_ContentsTree;
//#UC END# *47F2802003C4_4C6A9AD101B4_impl*
end;//TnsF1DocumentContainer.GetContentsTree

procedure TnsF1DocumentContainer.ClearFields;
begin
 f_ContentsTree := nil;
 inherited;
end;//TnsF1DocumentContainer.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
