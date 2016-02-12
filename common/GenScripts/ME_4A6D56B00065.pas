unit EditionsInterfaces;
 {* Работа с редакциями }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\EditionsInterfaces.pas"
// Стереотип: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , eeInterfaces
 , nevTools
 , evCustomEditorWindowModelPart
 , l3Interfaces
 , DocumentUnit
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , afwInterfaces
 , FoldersDomainInterfaces
 , l3Tree_TLB
 , bsTypesNew
;

 (*
 MnsRedactionCurrentPara = interface
  {* Источник параграфа }
  function Get_RedactionCurrentPara: IeeLeafPara;
  property RedactionCurrentPara: IeeLeafPara
   read Get_RedactionCurrentPara;
   {* Параграф для синхрнонизации }
 end;//MnsRedactionCurrentPara
 *)

type
 TnsParaCoord = object
  {* Координаты параграфа }
  public
   rParaID: Integer;
    {* Параграф }
   rBlock: IevDocumentPart;
    {* Блок }
   rLine: Integer;
    {* Строка внутри параграфа }
   rEditor: TevCustomEditorWindowModelPart;
   rPara: IeePara;
 end;//TnsParaCoord

 (*
 VScroll = interface
  procedure Sync(const aPara: TnsParaCoord);
   {* Синхронизировать позицию }
  procedure CurrentChangedFragmentChanged(aParaID: Integer);
   {* Изменилось положение текущего изменённого фрагмента. Дёрнули у редактора курсор или скроллер. aParaID == GetParaForPositionning }
 end;//VScroll
 *)

 InsVScrollListener = interface(Il3Notify)
  {* Слушатель вертикального скроллера }
  ['{372B1D0A-5EBD-4770-B425-E693289C5345}']
  procedure Sync(const aPara: TnsParaCoord);
   {* Синхронизировать позицию }
  procedure CurrentChangedFragmentChanged(aParaID: Integer);
   {* Изменилось положение текущего изменённого фрагмента. Дёрнули у редактора курсор или скроллер. aParaID == GetParaForPositionning }
 end;//InsVScrollListener

 TnsDocumentForReturnInfo = object
  public
   rDoc: IDocument;
   rPara: IeeLeafPara;
 end;//TnsDocumentForReturnInfo

 (*
 MnsDocument = interface
  {* Источник документа }
  function Get_Document: IDocument;
  function Get_DocumentForReturn: TnsDocumentForReturnInfo;
  property Document: IDocument
   read Get_Document;
   {* Документ, с которым идёт работа }
  property DocumentForReturn: TnsDocumentForReturnInfo
   read Get_DocumentForReturn;
 end;//MnsDocument
 *)

 (*
 MnsCompareEditionsInfo = interface(MnsRedactionCurrentPara)
 end;//MnsCompareEditionsInfo
 *)

 InsEditionListener = interface(Il3Notify)
  {* Слушатель изменения редакции }
  ['{61D72366-1A15-4A00-B4B3-78DCA20B6CA8}']
  procedure EditionChanged;
 end;//InsEditionListener

 InsVScrollController = interface
  {* Контроллер вертикального скроллера }
  ['{B205A94F-1322-445F-B7B8-3194F3F86F77}']
  procedure Sync(const aPara: TnsParaCoord);
   {* Синхронизировать позицию }
  procedure CurrentChangedFragmentChanged(aParaID: Integer);
   {* Изменилось положение текущего изменённого фрагмента. Дёрнули у редактора курсор или скроллер. aParaID == GetParaForPositionning }
 end;//InsVScrollController

 IdsEdition = interface
  ['{C666C0D5-6FE4-4D49-80A7-685C2E352687}']
  function As_InsVScrollListener: InsVScrollListener;
   {* Метод приведения нашего интерфейса к InsVScrollListener }
 end;//IdsEdition

 IdsEditionDiff = interface(IdsEdition)
  {* Результат сравнения редакций }
  ['{30C7415C-8EE4-4E0E-8C65-35231741EEEE}']
  function Get_DocumentContainer: InevDocumentContainer;
  function Get_RedactionName: Il3CString;
  function Get_RedactionCurrentPara: IeeLeafPara;
  function Get_Document: IDocument;
  function Get_DocumentForReturn: TnsDocumentForReturnInfo;
  function pm_GetDocInfo: IdeDocInfo;
  function As_InsEditionListener: InsEditionListener;
   {* Метод приведения нашего интерфейса к InsEditionListener }
  function As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
   {* Метод приведения нашего интерфейса к IucpHAFMacroReplacerFactory }
  function As_IucpFilterInfoFactory: IucpFilterInfoFactory;
   {* Метод приведения нашего интерфейса к IucpFilterInfoFactory }
  property DocumentContainer: InevDocumentContainer
   read Get_DocumentContainer;
   {* Контейнер документа }
  property RedactionName: Il3CString
   read Get_RedactionName;
   {* Имя редакции }
  property RedactionCurrentPara: IeeLeafPara
   read Get_RedactionCurrentPara;
   {* Параграф для синхрнонизации }
  property Document: IDocument
   read Get_Document;
   {* Документ, с которым идёт работа }
  property DocumentForReturn: TnsDocumentForReturnInfo
   read Get_DocumentForReturn;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//IdsEditionDiff

 IdsRightEdition = interface(IdsEditionDiff)
  {* Текущая редакция }
  ['{83FE08C5-A8AC-426A-AEDF-307031215F06}']
  function Get_NextEditions: Il3Node;
  property NextEditions: Il3Node
   read Get_NextEditions;
 end;//IdsRightEdition

 (*
 MnsEditionForCompare = interface
  function Get_EditionForCompare: TRedactionID;
  procedure Set_EditionForCompare(aValue: TRedactionID);
  property EditionForCompare: TRedactionID
   read Get_EditionForCompare
   write Set_EditionForCompare;
   {* Редакция для сравнения }
 end;//MnsEditionForCompare
 *)

 IdsLeftEdition = interface(IdsEditionDiff)
  {* Предыдущая редакция }
  ['{972B151D-0C3F-427F-8D58-A1E718CF17A8}']
  function Get_PrevEditions: Il3Node;
  property PrevEditions: Il3Node
   read Get_PrevEditions;
   {* Предыдущие редакции (включая данную) }
 end;//IdsLeftEdition

 InsEditionDiffData = interface
  {* Данные для dsEditionDiff }
  ['{01E26F79-EB4C-487E-9A15-3C0EFDC2749A}']
  function Get_RedactionCurrentPara: IeeLeafPara;
  function Get_Document: IDocument;
  function Get_DocumentForReturn: TnsDocumentForReturnInfo;
  property RedactionCurrentPara: IeeLeafPara
   read Get_RedactionCurrentPara;
   {* Параграф для синхрнонизации }
  property Document: IDocument
   read Get_Document;
   {* Документ, с которым идёт работа }
  property DocumentForReturn: TnsDocumentForReturnInfo
   read Get_DocumentForReturn;
 end;//InsEditionDiffData

 (*
 MnsChangedParas = interface
  {* Изменённые параграфы }
  function Get_ChangedParas: IDiffIterator;
  property ChangedParas: IDiffIterator
   read Get_ChangedParas;
 end;//MnsChangedParas
 *)

 InsEditionsContainerData = interface
  {* Данные для контейнера сравнения редакций }
  ['{DA8A9520-2900-43C2-8659-30A9832BD28C}']
  function Get_Document: IDocument;
  function Get_DocumentForReturn: TnsDocumentForReturnInfo;
  property Document: IDocument
   read Get_Document;
   {* Документ, с которым идёт работа }
  property DocumentForReturn: TnsDocumentForReturnInfo
   read Get_DocumentForReturn;
 end;//InsEditionsContainerData

 IdsEditionsContainerData = interface(IdsEdition)
  {* Данные для контейнера редакций }
  ['{186ED124-5A6C-44DB-9FF6-9FE001D6F71C}']
  function Get_DocumentNameForCaption: Il3CString;
  function Get_Right: IdsRightEdition;
  function Get_Left: IdsLeftEdition;
  function Get_DocumentFullNameForCaption: Il3CString;
  function Get_ChangedParas: IDiffIterator;
  property DocumentNameForCaption: Il3CString
   read Get_DocumentNameForCaption;
   {* Название документа для заголовка окна }
  property Right: IdsRightEdition
   read Get_Right;
  property Left: IdsLeftEdition
   read Get_Left;
  property DocumentFullNameForCaption: Il3CString
   read Get_DocumentFullNameForCaption;
  property ChangedParas: IDiffIterator
   read Get_ChangedParas;
 end;//IdsEditionsContainerData

 InsDocumentTextProviderFactory = interface;

 TDocumentRoot = IDocumentTextProvider;

 InsDocumentTextProviderFactory = interface
  ['{E7AC6D0F-5B6C-40D7-BAFD-38FDA06053FF}']
  function Get_Node(aIsLeft: Boolean): TDocumentRoot;
  property Node[aIsLeft: Boolean]: TDocumentRoot
   read Get_Node;
 end;//InsDocumentTextProviderFactory

 InsCompareEditionsInfo = interface
  {* Информация для сравнения редакций }
  ['{8DC30895-2365-4448-B81D-85AA2E933782}']
  function Get_State: IDocumentState;
  function Get_Position: TbsDocPos;
  function Get_RedactionCurrentPara: IeeLeafPara;
  function Get_Document: IDocument;
  function Get_DocumentForReturn: TnsDocumentForReturnInfo;
  function Get_EditionForCompare: TRedactionID;
  procedure Set_EditionForCompare(aValue: TRedactionID);
  property State: IDocumentState
   read Get_State;
   {* Состояние документа }
  property Position: TbsDocPos
   read Get_Position;
  property RedactionCurrentPara: IeeLeafPara
   read Get_RedactionCurrentPara;
   {* Параграф для синхрнонизации }
  property Document: IDocument
   read Get_Document;
   {* Документ, с которым идёт работа }
  property DocumentForReturn: TnsDocumentForReturnInfo
   read Get_DocumentForReturn;
  property EditionForCompare: TRedactionID
   read Get_EditionForCompare
   write Set_EditionForCompare;
   {* Редакция для сравнения }
 end;//InsCompareEditionsInfo

 IsdsCompareEditions = interface
  {* Сравнение двух соседний редакций }
  ['{7129759B-164B-4172-8EA3-65D05286CF8D}']
  function pm_GetLeft: IdsLeftEdition;
  function pm_GetRight: IdsRightEdition;
  function pm_GetEditionsContainerData: IdsEditionsContainerData;
  function Get_Position: TbsDocPos;
  function Get_ChangedParas: IDiffIterator;
  function Get_EditionForCompare: TRedactionID;
  procedure Set_EditionForCompare(aValue: TRedactionID);
  function As_InsVScrollController: InsVScrollController;
   {* Метод приведения нашего интерфейса к InsVScrollController }
  function As_InsDocumentTextProviderFactory: InsDocumentTextProviderFactory;
   {* Метод приведения нашего интерфейса к InsDocumentTextProviderFactory }
  function As_IsdsPrimDocument: IsdsPrimDocument;
   {* Метод приведения нашего интерфейса к IsdsPrimDocument }
  function As_IsdsEditionsHolder: IsdsEditionsHolder;
   {* Метод приведения нашего интерфейса к IsdsEditionsHolder }
  property Left: IdsLeftEdition
   read pm_GetLeft;
   {* Предыдущая редакция }
  property Right: IdsRightEdition
   read pm_GetRight;
   {* Текущая редакция }
  property EditionsContainerData: IdsEditionsContainerData
   read pm_GetEditionsContainerData;
  property Position: TbsDocPos
   read Get_Position;
  property ChangedParas: IDiffIterator
   read Get_ChangedParas;
  property EditionForCompare: TRedactionID
   read Get_EditionForCompare
   write Set_EditionForCompare;
   {* Редакция для сравнения }
 end;//IsdsCompareEditions

function TnsParaCoord_C(const aPara: IeePara;
 const aBlock: IevDocumentPart;
 aLine: Integer;
 anEditor: TevCustomEditorWindowModelPart): TnsParaCoord;
 {* Создаёт координату }
function TnsDocumentForReturnInfo_C(const aDoc: IDocument;
 const aPara: IeeLeafPara): TnsDocumentForReturnInfo;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TnsParaCoord_C(const aPara: IeePara;
 const aBlock: IevDocumentPart;
 aLine: Integer;
 anEditor: TevCustomEditorWindowModelPart): TnsParaCoord;
 {* Создаёт координату }
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
end;//TnsParaCoord_C

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
end;//TnsDocumentForReturnInfo_C
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
