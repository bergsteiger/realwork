unit EditionsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editions"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/EditionsInterfaces.pas"
// �����: 27.07.2009 11:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 ���������������� �������::CompareEditions::Editions::EditionsInterfaces
//
// ������ � ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  DynamicTreeUnit,
  l3Interfaces,
  afwInterfaces,
  l3Tree_TLB,
  nevTools,
  eeInterfaces,
  DocumentAndListInterfaces,
  DocumentInterfaces,
  evCustomEditorWindowModelPart,
  bsTypesNew,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

(*
 MnsRedactionCurrentPara = PureMixIn
  {* �������� ��������� }
   function Get_RedactionCurrentPara: IeeLeafPara;
   property RedactionCurrentPara: IeeLeafPara
     read Get_RedactionCurrentPara;
     {* �������� ��� �������������� }
 end;//MnsRedactionCurrentPara
*)

type
 TnsParaCoord = {$IfDef XE4}record{$Else}object{$EndIf}
  {* ���������� ��������� }
 public
   rParaID : Integer; // ��������
   rBlock : IevDocumentPart; // ����
   rLine : Integer; // ������ ������ ���������
   rEditor : TevCustomEditorWindowModelPart;
   rPara : IeePara;
 end;//TnsParaCoord

(*
 VScroll = PureMixIn
   procedure Sync(const aPara: TnsParaCoord);
     {* ���������������� ������� }
   procedure CurrentChangedFragmentChanged(aParaID: Integer);
     {* ���������� ��������� �������� ���������� ���������. ĸ����� � ��������� ������ ��� ��������. aParaID == GetParaForPositionning }
 end;//VScroll
*)

 InsVScrollListener = interface(Il3Notify)
  {* ��������� ������������� ��������� }
   ['{372B1D0A-5EBD-4770-B425-E693289C5345}']
  // VScroll
   procedure Sync(const aPara: TnsParaCoord);
     {* ���������������� ������� }
   procedure CurrentChangedFragmentChanged(aParaID: Integer);
     {* ���������� ��������� �������� ���������� ���������. ĸ����� � ��������� ������ ��� ��������. aParaID == GetParaForPositionning }
 end;//InsVScrollListener

  TnsDocumentForReturnInfo = {$IfDef XE4}record{$Else}object{$EndIf}
  public
     rDoc : IDocument;
     rPara : IeeLeafPara;
  end;//TnsDocumentForReturnInfo

(*
 MnsDocument = PureMixIn
  {* �������� ��������� }
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   property Document: IDocument
     read Get_Document;
     {* ��������, � ������� ��� ������ }
   property DocumentForReturn: TnsDocumentForReturnInfo
     read Get_DocumentForReturn;
 end;//MnsDocument
*)

(*
 MnsCompareEditionsInfo = PureMixIn(MnsRedactionCurrentPara)
 end;//MnsCompareEditionsInfo
*)

 InsEditionListener = interface(Il3Notify)
  {* ��������� ��������� �������� }
   ['{61D72366-1A15-4A00-B4B3-78DCA20B6CA8}']
   procedure EditionChanged;
 end;//InsEditionListener

 InsVScrollController = interface
  {* ���������� ������������� ��������� }
   ['{B205A94F-1322-445F-B7B8-3194F3F86F77}']
  // VScroll
   procedure Sync(const aPara: TnsParaCoord);
     {* ���������������� ������� }
   procedure CurrentChangedFragmentChanged(aParaID: Integer);
     {* ���������� ��������� �������� ���������� ���������. ĸ����� � ��������� ������ ��� ��������. aParaID == GetParaForPositionning }
 end;//InsVScrollController

 IdsEdition = interface(IvcmViewAreaController{, InsVScrollListener})
   ['{C666C0D5-6FE4-4D49-80A7-685C2E352687}']
  // ������ �������������� � ����������� �����������
   function As_InsVScrollListener: InsVScrollListener;
 end;//IdsEdition

 IdsEditionDiff = interface(IdsEdition{, InsEditionListener, IucpHAFMacroReplacerFactory, IucpFilterInfoFactory})
  {* ��������� ��������� �������� }
   ['{30C7415C-8EE4-4E0E-8C65-35231741EEEE}']
   function Get_DocumentContainer: InevDocumentContainer;
   function Get_RedactionName: Il3CString;
   property DocumentContainer: InevDocumentContainer
     read Get_DocumentContainer;
     {* ��������� ��������� }
   property RedactionName: Il3CString
     read Get_RedactionName;
     {* ��� �������� }
  // ������ �������������� � ����������� �����������
   function As_InsEditionListener: InsEditionListener;
   function As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
   function As_IucpFilterInfoFactory: IucpFilterInfoFactory;
  // MnsCompareEditionsInfo
  // MnsRedactionCurrentPara
   function Get_RedactionCurrentPara: IeeLeafPara;
   property RedactionCurrentPara: IeeLeafPara
     read Get_RedactionCurrentPara;
     {* �������� ��� �������������� }
  // MnsDocument
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   property Document: IDocument
     read Get_Document;
     {* ��������, � ������� ��� ������ }
   property DocumentForReturn: TnsDocumentForReturnInfo
     read Get_DocumentForReturn;
  // MdeDocInfoProvider
   function pm_GetDocInfo: IdeDocInfo;
   property DocInfo: IdeDocInfo
     read pm_GetDocInfo;
 end;//IdsEditionDiff

 IdsRightEdition = interface(IdsEditionDiff)
  {* ������� �������� }
   ['{83FE08C5-A8AC-426A-AEDF-307031215F06}']
   function Get_NextEditions: Il3Node;
   property NextEditions: Il3Node
     read Get_NextEditions;
 end;//IdsRightEdition

(*
 MnsEditionForCompare = PureMixIn
   function Get_EditionForCompare: TRedactionID;
   procedure Set_EditionForCompare(aValue: TRedactionID);
   property EditionForCompare: TRedactionID
     read Get_EditionForCompare
     write Set_EditionForCompare;
     {* �������� ��� ��������� }
 end;//MnsEditionForCompare
*)

 IdsLeftEdition = interface(IdsEditionDiff)
  {* ���������� �������� }
   ['{972B151D-0C3F-427F-8D58-A1E718CF17A8}']
   function Get_PrevEditions: Il3Node;
   property PrevEditions: Il3Node
     read Get_PrevEditions;
     {* ���������� �������� (������� ������) }
 end;//IdsLeftEdition

 InsEditionDiffData = interface(IUnknown)
  {* ������ ��� dsEditionDiff }
   ['{01E26F79-EB4C-487E-9A15-3C0EFDC2749A}']
  // MnsCompareEditionsInfo
  // MnsRedactionCurrentPara
   function Get_RedactionCurrentPara: IeeLeafPara;
   property RedactionCurrentPara: IeeLeafPara
     read Get_RedactionCurrentPara;
     {* �������� ��� �������������� }
  // MnsDocument
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   property Document: IDocument
     read Get_Document;
     {* ��������, � ������� ��� ������ }
   property DocumentForReturn: TnsDocumentForReturnInfo
     read Get_DocumentForReturn;
 end;//InsEditionDiffData

(*
 MnsChangedParas = PureMixIn
  {* ��������� ��������� }
   function Get_ChangedParas: IDiffIterator;
   property ChangedParas: IDiffIterator
     read Get_ChangedParas;
 end;//MnsChangedParas
*)

 InsEditionsContainerData = interface(IUnknown)
  {* ������ ��� ���������� ��������� �������� }
   ['{DA8A9520-2900-43C2-8659-30A9832BD28C}']
  // MnsDocument
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   property Document: IDocument
     read Get_Document;
     {* ��������, � ������� ��� ������ }
   property DocumentForReturn: TnsDocumentForReturnInfo
     read Get_DocumentForReturn;
 end;//InsEditionsContainerData

 IdsEditionsContainerData = interface(IdsEdition)
  {* ������ ��� ���������� �������� }
   ['{186ED124-5A6C-44DB-9FF6-9FE001D6F71C}']
   function Get_DocumentNameForCaption: Il3CString;
   function Get_Right: IdsRightEdition;
   function Get_Left: IdsLeftEdition;
   function Get_DocumentFullNameForCaption: Il3CString;
   property DocumentNameForCaption: Il3CString
     read Get_DocumentNameForCaption;
     {* �������� ��������� ��� ��������� ���� }
   property Right: IdsRightEdition
     read Get_Right;
   property Left: IdsLeftEdition
     read Get_Left;
   property DocumentFullNameForCaption: Il3CString
     read Get_DocumentFullNameForCaption;
  // MnsChangedParas
   function Get_ChangedParas: IDiffIterator;
   property ChangedParas: IDiffIterator
     read Get_ChangedParas;
 end;//IdsEditionsContainerData

  TDocumentRoot = DocumentUnit.IDocumentTextProvider;

 InsDocumentTextProviderFactory = interface(IUnknown)
   ['{E7AC6D0F-5B6C-40D7-BAFD-38FDA06053FF}']
   function Get_Node(aIsLeft: Boolean): TDocumentRoot;
   property Node[aIsLeft: Boolean]: TDocumentRoot
     read Get_Node;
 end;//InsDocumentTextProviderFactory

 InsCompareEditionsInfo = interface(IUnknown)
  {* ���������� ��� ��������� �������� }
   ['{8DC30895-2365-4448-B81D-85AA2E933782}']
   function Get_State: IDocumentState;
   function Get_Position: TbsDocPos;
   property State: IDocumentState
     read Get_State;
     {* ��������� ��������� }
   property Position: TbsDocPos
     read Get_Position;
  // MnsCompareEditionsInfo
  // MnsRedactionCurrentPara
   function Get_RedactionCurrentPara: IeeLeafPara;
   property RedactionCurrentPara: IeeLeafPara
     read Get_RedactionCurrentPara;
     {* �������� ��� �������������� }
  // MnsDocument
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   property Document: IDocument
     read Get_Document;
     {* ��������, � ������� ��� ������ }
   property DocumentForReturn: TnsDocumentForReturnInfo
     read Get_DocumentForReturn;
  // MnsEditionForCompare
   function Get_EditionForCompare: TRedactionID;
   procedure Set_EditionForCompare(aValue: TRedactionID);
   property EditionForCompare: TRedactionID
     read Get_EditionForCompare
     write Set_EditionForCompare;
     {* �������� ��� ��������� }
 end;//InsCompareEditionsInfo

 IsdsCompareEditions = interface(IvcmUseCaseController{, InsVScrollController, InsDocumentTextProviderFactory, IsdsPrimDocument, IsdsEditionsHolder})
  {* ��������� ���� �������� �������� }
   ['{7129759B-164B-4172-8EA3-65D05286CF8D}']
   function pm_GetLeft: IdsLeftEdition;
   function pm_GetRight: IdsRightEdition;
   function pm_GetEditionsContainerData: IdsEditionsContainerData;
   function Get_Position: TbsDocPos;
   property Left: IdsLeftEdition
     read pm_GetLeft;
     {* ���������� �������� }
   property Right: IdsRightEdition
     read pm_GetRight;
     {* ������� �������� }
   property EditionsContainerData: IdsEditionsContainerData
     read pm_GetEditionsContainerData;
   property Position: TbsDocPos
     read Get_Position;
  // ������ �������������� � ����������� �����������
   function As_InsVScrollController: InsVScrollController;
   function As_InsDocumentTextProviderFactory: InsDocumentTextProviderFactory;
   function As_IsdsPrimDocument: IsdsPrimDocument;
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
  // MnsChangedParas
   function Get_ChangedParas: IDiffIterator;
   property ChangedParas: IDiffIterator
     read Get_ChangedParas;
  // MnsEditionForCompare
   function Get_EditionForCompare: TRedactionID;
   procedure Set_EditionForCompare(aValue: TRedactionID);
   property EditionForCompare: TRedactionID
     read Get_EditionForCompare
     write Set_EditionForCompare;
     {* �������� ��� ��������� }
 end;//IsdsCompareEditions


function TnsParaCoord_C(const aPara: IeePara;
    const aBlock: IevDocumentPart;
    aLine: Integer;
    anEditor: TevCustomEditorWindowModelPart): TnsParaCoord;
  {* ������ ���������� }

function TnsDocumentForReturnInfo_C(const aDoc: IDocument;
     const aPara: IeeLeafPara): TnsDocumentForReturnInfo;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

function TnsParaCoord_C(const aPara: IeePara;
       const aBlock: IevDocumentPart;
       aLine: Integer;
       anEditor: TevCustomEditorWindowModelPart): TnsParaCoord;
  {* ������ ���������� }
//#UC START# *4A79BB650298_4A79BB0800E4_var*
//#UC END# *4A79BB650298_4A79BB0800E4_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A79BB650298_4A79BB0800E4_impl*
 if (aPara = nil) then
  Result.rParaID := 0
 else
  Result.rParaID := aPara.ID;
 Result.rPara := aPara;
 Result.rBlock := aBlock;
 Result.rLine := aLine;
 Result.rEditor := anEditor;
//#UC END# *4A79BB650298_4A79BB0800E4_impl*
end;//TnsParaCoord.C


function TnsDocumentForReturnInfo_C(const aDoc: IDocument;
        const aPara: IeeLeafPara): TnsDocumentForReturnInfo;
//#UC START# *4B6074C60325_4B60748400F9_var*
//#UC END# *4B6074C60325_4B60748400F9_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B6074C60325_4B60748400F9_impl*
 Result.rDoc := aDoc;
 Result.rPara := aPara;
//#UC END# *4B6074C60325_4B60748400F9_impl*
end;//TnsDocumentForReturnInfo.C

{$IfEnd} //not Admin AND not Monitorings

end.