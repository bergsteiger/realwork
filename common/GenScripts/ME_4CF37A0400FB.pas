unit nsConsultationDocumentContainerNew;
 {* Контейнер документа-консультации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\nsConsultationDocumentContainerNew.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , eeDocumentContainer
 {$IfEnd} // Defined(Nemesis)
 , ConsultingUnit
 , DocumentInterfaces
 , nevTools
 , l3Variant
 , l3Interfaces
 , l3Memory
 , evdNativeReader
 , k2DocumentBuffer
 , k2DocumentGenerator
 , nevPrintableDocumentContainer
 , F1TagDataProviderInterface
 , DocumentUnit
 , afwInterfaces
 , l3IID
 , nevBase
;

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
 {$Include nsDocumentContainer.imp.pas}
 TnsConsultationDocumentContainerNew = class(_nsDocumentContainer_)
  {* Контейнер документа-консультации }
  private
   f_Cons: IConsultation;
   f_DocInfo: IdeDocInfo;
  private
   procedure FillTemplateFields;
    {* Заполняет поля шаблона реальными значениями }
   function HideHyperlinks(aPara: Tl3Tag): Boolean;
   function DoFinishAtom(G: Tk2DocumentGenerator;
    var Atom: Tk2StackAtom): Boolean;
   function DoGetDocument: Tl3Tag;
  protected
   function GetDocument: Tl3Tag; override;
   function HAFPainterClass: RevHAFPainter; override;
   procedure AfterCreate(const aDocInfo: IdeDocInfo); override;
   procedure ClearFields; override;
  public
   constructor Create(const aDocInfo: IdeDocInfo;
    const aCons: IConsultation); reintroduce;
   class function Make(const aDocInfo: IdeDocInfo;
    const aCons: IConsultation): InevDocumentContainer; reintroduce;
 end;//TnsConsultationDocumentContainerNew
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsConsultationHAFPainterImages_Form
 , evTypes
 , DataAdapter
 , k2Tags
 , nsConst
 , l3Types
 , l3SysUtils
 , Document_Const
 , Para_Const
 , SysUtils
 , nsIDocumentDataObject
 , nsDocumentPreview
 , nsHAFPainter
 , LoggingInterfaces
 , nsDocumentPrintEvent
 , deDocInfo
 , evdTypes
 , nsTypes
 , LeafPara_Const
 , nsTagString
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , afwFacade
 , ParaList_Const
 , ControlPara_Const
 , l3String
 , ReqCell_Const
 , IOUnit
 , AdapterFacade
 , nsQuery
 , l3Base
 , evdVer
 , ExternalOperationUnit
;

{$Include nsDocumentContainer.imp.pas}

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
end;//TnsConsultationDocumentContainerNew.Make

procedure TnsConsultationDocumentContainerNew.FillTemplateFields;
 {* Заполняет поля шаблона реальными значениями }
//#UC START# *4CF39F58031E_4CF37A0400FB_var*
var
 l_Obj : InevObject;
//#UC END# *4CF39F58031E_4CF37A0400FB_var*
begin
//#UC START# *4CF39F58031E_4CF37A0400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CF39F58031E_4CF37A0400FB_impl*
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
begin
 f_Cons := nil;
 f_DocInfo := nil;
 inherited;
end;//TnsConsultationDocumentContainerNew.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
