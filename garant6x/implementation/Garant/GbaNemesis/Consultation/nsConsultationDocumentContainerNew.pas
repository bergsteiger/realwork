unit nsConsultationDocumentContainerNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/nsConsultationDocumentContainerNew.pas"
// Начат: 29.11.2010 13:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TnsConsultationDocumentContainerNew
//
// Контейнер документа-консультации
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
  ConsultingUnit,
  l3Interfaces
  {$If defined(Nemesis)}
  ,
  eeDocumentContainer
  {$IfEnd} //Nemesis
  ,
  l3Memory,
  nevTools,
  k2DocumentBuffer,
  k2DocumentGenerator,
  evdNativeReader,
  DocumentInterfaces,
  l3Variant,
  DocumentUnit,
  F1TagDataProviderInterface,
  afwInterfaces,
  nevBase,
  k2Base,
  nevPrintableDocumentContainer,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsTemplateFieldType = (
   ns_ftQuery
 , ns_ftUser
 , ns_ftDate
 , ns_ftCost
 , ns_ftAnswer
 , ns_ftAuther
 , ns_ftDealerInf
 , ns_ftQueryByParas
 );//TnsTemplateFieldType

 _nsDocumentContainer_Parent_ = TeeDocumentContainer;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 TnsConsultationDocumentContainerNew = class(_nsDocumentContainer_)
  {* Контейнер документа-консультации }
 private
 // private fields
   f_Cons : IConsultation;
   f_DocInfo : IdeDocInfo;
 private
 // private methods
   procedure FillTemplateFields(aTag: Tl3Tag;
     const anInfo: IConsultingTemplateInfo);
     {* Заполняет поля шаблона реальными значениями }
   function HideHyperlinks(aPara: Tl3Tag): Boolean;
   function DoFinishAtom(G: Tk2DocumentGenerator;
     var Atom: Tk2StackAtom): Boolean;
   function DoGetDocument: Tl3Tag;
 protected
 // overridden protected methods
   function GetDocument: Tl3Tag; override;
   function HAFPainterClass: RevHAFPainter; override;
   procedure AfterCreate(const aDocInfo: IdeDocInfo); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aDocInfo: IdeDocInfo;
     const aCons: IConsultation); reintroduce;
   class function Make(const aDocInfo: IdeDocInfo;
     const aCons: IConsultation): InevDocumentContainer; reintroduce;
     {* Сигнатура фабрики TnsConsultationDocumentContainerNew.Make }
 end;//TnsConsultationDocumentContainerNew
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  evdVer,
  IOUnit,
  nsTypes,
  AdapterFacade,
  nsQuery,
  ParaList_Const,
  LeafPara_Const,
  ControlPara_Const,
  evdTypes,
  k2Tags,
  l3String,
  ReqCell_Const,
  ExternalOperationUnit,
  nsConsultationHAFPainterImages_Form,
  evTypes,
  DataAdapter,
  nsConst,
  l3Types,
  l3SysUtils,
  Document_Const,
  Para_Const,
  SysUtils,
  nsIDocumentDataObject,
  nsDocumentPreview,
  nsHAFPainter,
  LoggingInterfaces,
  nsDocumentPrintEvent,
  deDocInfo,
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

// start class TnsConsultationDocumentContainerNew

procedure TnsConsultationDocumentContainerNew.FillTemplateFields(aTag: Tl3Tag;
  const anInfo: IConsultingTemplateInfo);
var
 l_WasSomeHyperlinkHidden : Boolean;

 function DoIt(anItem: Tl3Variant;
   anIndex: Integer): Boolean;

  procedure FillText(const aText: Tl3WString);
  //#UC START# *4CF3B096018E__var*
  //#UC END# *4CF3B096018E__var*
  begin
  //#UC START# *4CF3B096018E__impl*
   anItem.PCharLenA[k2_tiText] := Tl3PCharLen(l3RTrim(aText, [#10, #13]));
  //#UC END# *4CF3B096018E__impl*
  end;//FillText

  procedure FillTextS(const aText: AnsiString);
  //#UC START# *4CF3B62D02CE__var*
  //#UC END# *4CF3B62D02CE__var*
  begin
  //#UC START# *4CF3B62D02CE__impl*
   FillText(l3PCharLen(aText));
  //#UC END# *4CF3B62D02CE__impl*
  end;//FillTextS

  procedure FillTextL(const aText: IParasList);
  //#UC START# *4CF3B85B002B__var*
  var
   l_S : IString;
   l_Index : Integer;
   l_T     : Tl3Variant;
  //#UC END# *4CF3B85B002B__var*
  begin
  //#UC START# *4CF3B85B002B__impl*
   if (aText <> nil) then
    if (aText.Count > 0) then
    begin
     aText.pm_GetItem(0, l_S);
     FillText(nsWStr(l_S));
     for l_Index := 1 to Pred(aText.Count) do
     begin
      aText.pm_GetItem(l_Index, l_S);
      l_T := anItem.CloneTag.AsObject;
      l_T.StrA[k2_tiName] := '';
      l_T.PCharLenA[k2_tiText] := Tl3PCharLen(l3RTrim(nsWStr(l_S), [#10, #13]));
      anItem.Owner.InsertChildTag(anIndex + l_Index, l_T);
     end;//for l_Index
    end;//aText.Count > 0
  //#UC END# *4CF3B85B002B__impl*
  end;//FillTextL

  procedure FillTextEVD(const aText: IParasList);
  //#UC START# *4DECEBC00327__var*
  var
   l_St  : IString;
   l_Tag : Tl3Variant;
   l_Ow  : Tl3Variant;
  //#UC END# *4DECEBC00327__var*
  var
   l_S : Tl3ConstMemoryStream;
   l_R : TevdNativeReader;
   l_B : Tk2DocumentBuffer;
  begin
  //#UC START# *4DECEBC00327__impl*
   if (aText <> nil) then
    if (aText.Count > 0) then
    begin
     Assert(aText.Count = 1);
     aText.pm_GetItem(0, l_St);
     if (l_St <> nil) then
     begin
      l_R := TevdNativeReader.Create;
      try
       //l_R.ForceBinary := true;
       //l_R.CurrentVersion := evNonPackedVer;
       l_B := Tk2DocumentBuffer.Create;
       try
        l_B.OnFinishAtom := Self.DoFinishAtom;
        l_R.Generator := l_B;
        l_S := Tl3ConstMemoryStream.Create(l_St.GetData, l_St.GetLength);
        try
         l_R.Filer.Stream := l_S;
         try
          l_R.Execute;
         finally
          l_R.Filer.Stream := nil;
         end;//try..finally
        finally
         FreeAndNil(l_S);
        end;//try..finally
        l_Tag := l_B.Root;
        if (l_Tag <> nil) then
        begin
         if l_Tag.IsKindOf(k2_typDocument) then
         begin
          if not l_Tag.HasSubAtom(k2_tiExternalHandle) then
          begin
           if (f_DocumentInfo <> nil) AND (f_DocumentInfo.Doc <> nil) then
            l_Tag.IntA[k2_tiExternalHandle] := f_DocumentInfo.Doc.GetInternalID
           else
            l_Tag.IntA[k2_tiExternalHandle] := 0;
          end;//not l_Tag.HasSubAtom(k2_tiExternalHandle)
          l_Tag.IntA[k2_tiRightIndent] := 0;
         end;//l_Tag.IsKindOf(k2_typDocument)
         l_Ow := anItem. Owner. Owner. Owner;
         //      Контрол Ячейка Строка Таблица
         l_Ow.Owner.InsertChildTag(l_Ow.Owner.IndexOfChild(l_Ow.AsObject), l_Tag);
         l_Ow.Owner.DeleteChild(l_Ow.AsObject);
         InevProcessor(Processor).NotifyCompleted(l_Ow.Owner, l_Tag);
        end;//l_Tag <> nil
       finally
        FreeAndNil(l_B);
       end;//try..finally
      finally
       FreeAndNil(l_R);
      end;//try..finally
     end;//l_St <> nil
    end;//aText.Count > 0
  //#UC END# *4DECEBC00327__impl*
  end;//FillTextEVD

 //#UC START# *4CF3B26A011E__var*
 const
  cNames : array [TnsTemplateFieldType] of AnsiString = (
   'Query',
   'User',
   'Date',
   'Cost',
   'Answer',
   'Auther',
   'DealerInf',
   'QueryByParas'
  );//cNames
 var
  l_Name  : String;
  l_S     : IString;
  l_Date  : AdapterDate;
  l_L     : IParasList;
  l_IsEvd : Bytebool;
 //#UC END# *4CF3B26A011E__var*
 begin
 //#UC START# *4CF3B26A011E__impl*
  Result := true;
  if anItem.IsKindOf(k2_typParaList) then
   FillTemplateFields(anItem.AsObject, anInfo)
  else
  if anItem.IsKindOf(k2_typLeafPara) then
  begin
   if anItem.IsKindOf(k2_typControlPara) then
   begin
    if HideHyperlinks(anItem) then
     l_WasSomeHyperlinkHidden := true
    else
     if (TevControlType(anItem.IntA[k2_tiType]) in
         [ev_ctLabel, ev_ctTextParaLabel]) then
     begin
      l_Name := anItem.StrA[k2_tiName];
      if (l_Name <> '') then
      begin
       Case l3StringCase(l_Name, cNames, l3_siCaseUnsensitive) of
        -1:
         Assert(false);
        Ord(ns_ftQuery):
        begin
         f_Cons.GetQueryData(l_S);
         FillText(nsWStr(l_S));
        end;//ns_ftQuery
        Ord(ns_ftUser):
        begin
         f_Cons.GetUserName(l_S);
         FillText(nsWStr(l_S));
        end;//ns_ftUser
        Ord(ns_ftDate):
        begin
         f_Cons.GetReplyDate(l_Date);
         FillTextS(DateToStr(GblAdapterDateToDateTime(l_Date)));
        end;//ns_ftDate
        Ord(ns_ftCost):
        begin
         f_Cons.GetExpertInfo(l_L);
         if (l_L = nil) then
          l_WasSomeHyperlinkHidden := true
         else
          FillTextL(l_L);
        end;//ns_ftCost
        Ord(ns_ftAnswer):
        begin
         f_Cons.GetAnswerData(l_IsEvd, l_L);
         if l_IsEvd then
          FillTextEVD(l_L)
         else
          FillTextL(l_L);
        end;//ns_ftAnswer
        Ord(ns_ftAuther):
        begin
         f_Cons.GetExpertName(l_S);
         FillText(nsWStr(l_S));
        end;//ns_ftAuther
        Ord(ns_ftDealerInf):
        begin
         anInfo.GetDealerInfo(l_S);
         FillText(nsWStr(l_S));
        end;//ns_ftDealerInf
        Ord(ns_ftQueryByParas):
        begin
         f_Cons.GetQueryByParas(l_L);
         FillTextL(l_L);
        end;//ns_ftQueryByParas
        else
         Assert(false);
       end;//Case l3StringCase
      end;//l_Name <> ''
     end;//anItem.IntA[k2_tiType] = Ord(ev_ctTextParaLabel
    end;//anItem.IsKindOf(k2_typControlPara)
  end;//anItem.IsKindOf(k2_typLeafPara)
 //#UC END# *4CF3B26A011E__impl*
 end;//DoIt

//#UC START# *4CF39F58031E_4CF37A0400FB_var*
var
 l_Obj : InevObject;
//#UC END# *4CF39F58031E_4CF37A0400FB_var*
begin
 //#UC START# *4CF39F58031Eiter*
 l_WasSomeHyperlinkHidden := false;
 aTag.
 //#UC END# *4CF39F58031Eiter*
  IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DoIt))
 //#UC START# *4CF39F58031Eafteriter*
 ;
 if l_WasSomeHyperlinkHidden then
  if aTag.IsKindOf(k2_typReqCell) then
  begin
   if not aTag.QT(InevObject, l_Obj) then
    Assert(false);
   l_Obj.Edit.Delete(false); 
  end;//aTag.InheritsForm(k2_typReqCell)
 //#UC END# *4CF39F58031Eafteriter*
end;//TnsConsultationDocumentContainerNew.FillTemplateFields

function TnsConsultationDocumentContainerNew.HideHyperlinks(aPara: Tl3Tag): Boolean;
//#UC START# *4CF3C730039D_4CF37A0400FB_var*
var
 l_H : Integer;
 l_A : Integer;
//#UC END# *4CF3C730039D_4CF37A0400FB_var*
begin
//#UC START# *4CF3C730039D_4CF37A0400FB_impl*
 Result := false;
 with aPara.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)]) do
  if IsValid then
   for l_H := 0 to Pred(ChildrenCount) do
    with Child[l_H] do
     if IsValid then
      for l_A := 0 to Pred(ChildrenCount) do
       with Child[l_A] do
        if IsValid then
        begin
         if (IntA[k2_tiType] = CI_ExternalOperation) then
         begin
          Case IntA[k2_tiDocID] of
           EOI_ESTIMATION:
            Result := f_Cons.HasEstimation;
           EOI_SHOW_CONSULTATION_LIST:
            Result := not f_Cons.HasList;
           EOI_PAYMENT_CONFIRM,
           EOI_PAYMENT_REFUSAL:
            Result := f_Cons.HasPaymentInformation;
           else
            ; 
          end;//Case IntA[k2_tiDocID]
         end;//IntA[k2_tiType] = Ord(LO_EXTERNAL_OPERATION)
         if Result then
         begin
          aPara.BoolA[k2_tiVisible] := false;
          Exit;
         end;//Result
        end;//IsValid
//#UC END# *4CF3C730039D_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.HideHyperlinks

function TnsConsultationDocumentContainerNew.DoFinishAtom(G: Tk2DocumentGenerator;
  var Atom: Tk2StackAtom): Boolean;
//#UC START# *4EAA71CA009F_4CF37A0400FB_var*
//#UC END# *4EAA71CA009F_4CF37A0400FB_var*
begin
//#UC START# *4EAA71CA009F_4CF37A0400FB_impl*
 Result := true;
 if Atom.Box.IsKindOf(k2_typPara) then
  if (Atom.Parent <> nil) then
   InevProcessor(Processor).NotifyCompleted(Atom.Parent.Box, Atom.Box);
//#UC END# *4EAA71CA009F_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.DoFinishAtom

function TnsConsultationDocumentContainerNew.DoGetDocument: Tl3Tag;
//#UC START# *51E676440200_4CF37A0400FB_var*
var
 l_Info : IConsultingTemplateInfo;
 l_S    : IStream;
 l_D    : Tl3Tag;
 l_Res  : Int64;
//#UC END# *51E676440200_4CF37A0400FB_var*
begin
//#UC START# *51E676440200_4CF37A0400FB_impl*
 Assert(f_DocInfo <> nil);
 l_Info := DefDataAdapter.NativeAdapter.MakeConsultingTemplateInfo;
 Assert(l_Info <> nil);
 try
  Case l_Info.GetTemplateType(f_Cons) of
   PREANSWER_TEMPLATE:
    l_Info.GetPreAnswerTemplate(l_S);
   ANSWER_TEMPLATE:
    l_Info.GetAnswerTemplate(l_S);
   QUERY_TEMPLATE:
    l_Info.GetQueryTemplate(l_S);
   else
    Assert(false);
  end;//Case l_Info.GetTemplateType(f_Cons)
  Assert(l_S <> nil);
  try
   OleCheck(l_S.Seek(0, STREAM_SEEK_SET, l_Res));
   Self.WriteTag(nil, cf_EverestBin, l_S, nil);
  finally
   l_S := nil;
  end;//try..finally
  l_D := Self.GetDocument;
  Assert((l_D <> nil) AND l_D.IsValid);
  l_D.IntA[k2_tiExternalHandle] := f_DocInfo.Doc.GetInternalID;
  FillTemplateFields(l_D, l_Info);
 finally
  l_Info := nil;
 end;//try..finally
 Assert(l_D <> nil);
 Result := l_D;
//#UC END# *51E676440200_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.DoGetDocument

constructor TnsConsultationDocumentContainerNew.Create(const aDocInfo: IdeDocInfo;
  const aCons: IConsultation);
//#UC START# *4CF3965400E5_4CF37A0400FB_var*
//#UC END# *4CF3965400E5_4CF37A0400FB_var*
begin
//#UC START# *4CF3965400E5_4CF37A0400FB_impl*
 f_Cons := aCons;
 inherited Create(aDocInfo);
//#UC END# *4CF3965400E5_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.Create

class function TnsConsultationDocumentContainerNew.Make(const aDocInfo: IdeDocInfo;
  const aCons: IConsultation): InevDocumentContainer;
var
 l_Inst : TnsConsultationDocumentContainerNew;
begin
 l_Inst := Create(aDocInfo, aCons);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsConsultationDocumentContainerNew.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4CF37A0400FB_var*
//#UC END# *47F27DA80172_4CF37A0400FB_var*
begin
//#UC START# *47F27DA80172_4CF37A0400FB_impl*
 if Self.HasDocument then
  Result := inherited GetDocument
 else
  Result := DoGetDocument;
//#UC END# *47F27DA80172_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.GetDocument

function TnsConsultationDocumentContainerNew.HAFPainterClass: RevHAFPainter;
//#UC START# *47F35CAC00E4_4CF37A0400FB_var*
//#UC END# *47F35CAC00E4_4CF37A0400FB_var*
begin
//#UC START# *47F35CAC00E4_4CF37A0400FB_impl*
 Result := TnsConsultationHAFPainter;
//#UC END# *47F35CAC00E4_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.HAFPainterClass

procedure TnsConsultationDocumentContainerNew.AfterCreate(const aDocInfo: IdeDocInfo);
//#UC START# *4B1FBF87020C_4CF37A0400FB_var*
//#UC END# *4B1FBF87020C_4CF37A0400FB_var*
begin
//#UC START# *4B1FBF87020C_4CF37A0400FB_impl*
 inherited;
 Assert(aDocInfo <> nil);
 Assert(aDocInfo.Doc <> nil);
 Assert(f_Cons <> nil);
 f_DocInfo := aDocInfo;
 DoGetDocument;
//#UC END# *4B1FBF87020C_4CF37A0400FB_impl*
end;//TnsConsultationDocumentContainerNew.AfterCreate

procedure TnsConsultationDocumentContainerNew.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Cons := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_DocInfo := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsConsultationDocumentContainerNew.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.