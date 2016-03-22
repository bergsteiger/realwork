unit nsAutoreferatDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/nsAutoreferatDocumentContainer.pas"
// Начат: 19.11.2010 18:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TnsAutoreferatDocumentContainer
//
// Контейнер документа для автореферата
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
 TnsAutoreferatDocumentContainer = class(_nsDocumentContainer_)
  {* Контейнер документа для автореферата }
 protected
 // overridden protected methods
   function GetDocument: Tl3Tag; override;
 end;//TnsAutoreferatDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Document_Const,
  nsF1DocumentTagNode,
  DataAdapter,
  nsConst,
  k2Tags,
  k2DocumentBuffer,
  evdNativeReader,
  ComObj,
  ActiveX,
  evdVer,
  LeafPara_Const,
  ParaList_Const,
  TextPara_Const,
  l3Defaults,
  BaseTypesUnit,
  nsAnnotationHeaderTagNode,
  nsF1AutoreferatDocumentTagNode,
  SysUtils,
  nsIDocumentDataObject,
  nsDocumentPreview,
  nsHAFPainter,
  LoggingInterfaces,
  nsDocumentPrintEvent,
  deDocInfo,
  evdTypes,
  nsTypes,
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

// start class TnsAutoreferatDocumentContainer

function TnsAutoreferatDocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4CE6937D031D_var*

 procedure AddHeader(const aSt : IStream; var theChildrenCount : Integer);
 var
  l_B : Tk2DocumentBuffer;
  l_R : TevdNativeReader;
  l_Tag : Tl3Variant;
  l_Pos : Int64;
 begin//AddHeader
  if (aSt <> nil) then
  begin
   l_R := TevdNativeReader.Create;
   try
    l_R.ForceBinary := true;
    l_R.CurrentVersion := evNonPackedVer;
    l_B := Tk2DocumentBuffer.Create;
    try
     l_R.Generator := l_B;
     OleCheck(aSt.Seek(0, STREAM_SEEK_SET, l_Pos));
     l_R.Filer.COMStream := aSt;
     try
      l_R.Execute;
     finally
      l_R.Filer.COMStream := nil;
     end;//try..finally
     l_Tag := l_B.Root;
     if (l_Tag <> nil) then
     begin
      if l_Tag.IsKindOf(k2_typLeafPara) then
       Inc(theChildrenCount)
      else
      if l_Tag.IsKindOf(k2_typParaList) then
      begin
       Inc(theChildrenCount, l_Tag.ChildrenCount{IntA[k2_tiAllChildrenCount]});
       if l_Tag.IsKindOf(k2_typDocument) then
        l_Tag.IntA[k2_tiExternalHandle] := 0;
      end//l_Tag.IsKindOf(k2_typParaList)
      else
       Assert(false);
      Result.AddChild(l_Tag);
     end;//l_Tag <> nil 
    finally
     FreeAndNil(l_B);
    end;//try..finally
   finally
    FreeAndNil(l_R);
   end;//try..finally
  end;//aSt <> nil
 end;//AddHeader

var
 l_Index  : Integer;
 l_Header : Tl3Tag;
 l_Anno   : Tl3Tag;
 l_Frame  : Tl3Variant;
 l_ACN    : Integer;
 l_S      : IStream;
 l_Ds     : IDocumentTextProviderDescriptorList;
 l_D      : TDocumentTextProviderDescriptor;
//#UC END# *47F27DA80172_4CE6937D031D_var*
begin
//#UC START# *47F27DA80172_4CE6937D031D_impl*
 Result := inherited GetDocument;
 if (Result = nil) then
 begin
  try
   f_DocumentInfo.Doc.GetTextProviderDescList(l_Ds);
   //Assert(l_Ds <> nil);
  except
   on ECannotFindData do
   begin
    l_Ds := nil;
   end;//on ECannotFindData
  end;//try..except
  Result := k2_typDocument.MakeTag.AsObject;
  try
   Result.IntA[k2_tiExternalHandle] := 0;
   // - чтобы работали гиперссылки из синтетических параграфов
   l_ACN := 0;
   f_DocumentInfo.Doc.GetAutoreferatHeaderEvd(l_S);
   try
    AddHeader(l_S, l_ACN);
   finally
    l_S := nil;
   end;//try..finally
   if (l_Ds <> nil) then
    for l_Index := 0 to Pred(l_Ds{l_Ps}.Count) do
    begin
     l_Ds.pm_GetItem(l_index, l_D);
     l_Anno := TnsF1AutoreferatDocumentTagNode.Make(l_D.rHandle,
                                                   f_DocumentInfo.Doc).AsObject;
     l_Header := TnsAnnotationHeaderTagNode.Make(l_Index,
                                                 l_D.rHeaderLeafCount,
                                                 f_DocumentInfo.Doc,
                                                 l_Anno).AsObject;
     Result.AddChild(l_Header);
     Inc(l_ACN, l_D.rHeaderLeafCount);
     l_Anno.IntA[k2_tiAllChildrenCount] := l_D.rAnnoLeafCount;
     Inc(l_ACN, l_D.rAnnoLeafCount);
     Result.AddChild(l_Anno);
     l_Frame := k2_typTextPara.MakeTag.AsObject;
     with l_Frame.cAtom(k2_tiFrame).cAtom(k2_tiFrameDown) do
     begin
      IntA[k2_tiSpaceBefore] := def_FrameWidth * 3;
      IntA[k2_tiWidth] := def_FrameWidth * 3;
      IntA[k2_tiSpaceAfter] := def_FrameWidth * 3;
     end;//with l_Frame.cAtom(k2_tiFrame).cAtom(k2_tiFrameDown)
     Result.AddChild(l_Frame);
     Inc(l_ACN);
    end;//for l_Index
   Result.IntA[k2_tiAllChildrenCount] := l_ACN;
  finally
   Document := Result;
   // - это СПЕЦИАЛЬНО ПОСЛЕ создания оглавления
  end;//try..finally
 end;//Result = nil
//#UC END# *47F27DA80172_4CE6937D031D_impl*
end;//TnsAutoreferatDocumentContainer.GetDocument

{$IfEnd} //not Admin AND not Monitorings

end.