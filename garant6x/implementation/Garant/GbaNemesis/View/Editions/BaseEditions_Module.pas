unit BaseEditions_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/BaseEditions_Module.pas"
// Начат: 27.07.2009 12:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::BaseEditions
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
  DocumentUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  eeInterfaces
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  EditionsInterfaces,
  PrimLeftEdition_Form,
  PrimRightEdition_Form,
  LeftEdition_Form,
  RightEdition_Form,
  EditionsContainer_Form,
  PrimEditionsContainer_Form,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  vtFocusLabel,
  l3StringIDEx,
  bsTypesNew,
  PrimLeftEdition_utLeftEdition_UserType,
  PrimRightEdition_utRightEdition_UserType,
  PrimEditionsContainer_utEditionsContainer_UserType
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  CompareEditions_FormDefinitions_Controls
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  fsCompareEditions
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  LeftEditionKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RightEditionKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  EditionsContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TBaseEditionsModule = {abstract formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure MakeCompareEditions(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     aEditionForCompare: Integer;
     const aDocumentForReturn: TnsDocumentForReturnInfo;
     const aContainer: IvcmContainer = nil); overload; 
     {* Создаёт представление прецедента "Сравнение редакций" }
   class procedure MakeCompareEditions(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload; 
   class procedure MakeCompareEditions(const aLeft: IDocument;
     const aRight: IDocument;
     const aPara: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload; 
   class procedure MakeCompareEditions(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     aEditionForCompare: Integer;
     const aContainer: IvcmContainer = nil); overload; 
   class procedure MakeCompareEditions(const aLeft: IDocument;
     const aRight: IDocument;
     const aParaForPositionning: IeeLeafPara;
     const aDocumentForReturn: IDocument;
     const aParaForReturn: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload; 
   class procedure MakeCompareEditions(const aLeft: IDocument;
     const aRight: IDocument;
     const aPosition: TbsDocPos;
     const aDocumentForReturn: IDocument;
     const aParaForReturn: IeeLeafPara;
     const aContainer: IvcmContainer = nil); overload; 
 end;//TBaseEditionsModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  Base_Operations_View_Controls,
  DocumentRes,
  vtUtils,
  evdStyles,
  k2Tags,
  BitmapPara_Const,
  BaseSearchInterfaces,
  SysUtils,
  l3Base,
  l3InterfacesMisc,
  nsBaseSearchService,
  evdBlockNameAdder,
  l3Variant,
  nsDocumentTools,
  Windows,
  PresentationInterfaces,
  nsExternalObjectPrim,
  bsUtils,
  l3Stream,
  l3Types,
  nsToMSWordOp,
  l3String,
  nsTrialSupport,
  FoldersDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  Printers,
  nsExportToFileEvent,
  nsExportToWordEvent,
  nsSendDocumentByEMailEvent,
  nsDocumentPrintPreviewEvent,
  nsBaseTextOperationsConst,
  f1MultilinkResolver,
  l3Interfaces,
  evTypes,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsConst,
  nsQuestions,
  nsExternalObjectModelPart,
  bsDocumentContextSearcher,
  nsSearchInDocumentEvent,
  BaseTypesUnit,
  nsSearchInDocumentDoneEvent,
  nsSearchInDocumentNextEvent,
  nsSearchInDocumentPrevEvent,
  nsSearchWindowManager,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  Common_FormDefinitions_Controls,
  evOp
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const
  {$IfEnd} //Nemesis
  ,
  TextSegment_Const,
  StyledLeafPara_Const,
  evCustomEditorWindow
  {$If defined(k2ForEditor)}
  ,
  evSegLst
  {$IfEnd} //k2ForEditor
  ,
  evdTypes,
  nevNavigation,
  nevTools,
  evCustomEditor,
  evEditorWithOperations,
  sdsCompareEditions,
  nsCompareEditionsInfo,
  l3MessageID,
  vtComboBoxQS
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Local }
  str_NoPrevEdition : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NoPrevEdition'; rValue : 'Нет редакции для сравнения. У изучаемого Вами документа нет более ранних действовавших когда-либо редакций.');
   { 'Нет редакции для сравнения. У изучаемого Вами документа нет более ранних действовавших когда-либо редакций.' }

// start class TBaseEditionsModule

class procedure TBaseEditionsModule.MakeCompareEditions(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  aEditionForCompare: Integer;
  const aDocumentForReturn: TnsDocumentForReturnInfo;
  const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4A71ADFC00B4_4A6D5F3D03A9_var*
 l_Container: IvcmContainer;
//#UC END# *4A71ADFC00B4_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A71ADFC00B4_4A6D5F3D03A9_impl*
  try
   if Assigned(aContainer)
    then l_Container := aContainer
    else l_Container := DefaultContainer;
   Tfs_CompareEditions.Make(
    TsdsCompareEditions.Make(TnsCompareEditionsInfo.Make(aDoc, aPara, aEditionForCompare, aDocumentForReturn)),
    l_Container);
  except
   on ERedactionNotFound do
    vcmSay(inf_AnyInformation, [str_NoPrevEdition.AsCStr]);
  end;//try..except
//#UC END# *4A71ADFC00B4_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseEditionsModule.MakeCompareEditions

class procedure TBaseEditionsModule.MakeCompareEditions(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4B60761E0096_4A6D5F3D03A9_var*
//#UC END# *4B60761E0096_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4B60761E0096_4A6D5F3D03A9_impl*
 MakeCompareEditions(aDoc, aPara, -1, TnsDocumentForReturnInfo_C(aDoc, aPara));
//#UC END# *4B60761E0096_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseEditionsModule.MakeCompareEditions

class procedure TBaseEditionsModule.MakeCompareEditions(const aLeft: IDocument;
  const aRight: IDocument;
  const aPara: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4EC4FB3002FF_4A6D5F3D03A9_var*
var
 l_LeftState : IDocumentState;
//#UC END# *4EC4FB3002FF_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4EC4FB3002FF_4A6D5F3D03A9_impl*
  aLeft.GetCurrentState(l_LeftState);
  TdmStdRes.MakeCompareEditions(aRight,
                                aPara,
                                l_LeftState.Redaction,
                                TnsDocumentForReturnInfo_C(aRight, aPara));
//#UC END# *4EC4FB3002FF_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseEditionsModule.MakeCompareEditions

class procedure TBaseEditionsModule.MakeCompareEditions(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  aEditionForCompare: Integer;
  const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *4F2BEE7302EB_4A6D5F3D03A9_var*
//#UC END# *4F2BEE7302EB_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F2BEE7302EB_4A6D5F3D03A9_impl*
 MakeCompareEditions(aDoc, aPara,
                     aEditionForCompare,
                     TnsDocumentForReturnInfo_C(aDoc, aPara));
//#UC END# *4F2BEE7302EB_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseEditionsModule.MakeCompareEditions

class procedure TBaseEditionsModule.MakeCompareEditions(const aLeft: IDocument;
  const aRight: IDocument;
  const aParaForPositionning: IeeLeafPara;
  const aDocumentForReturn: IDocument;
  const aParaForReturn: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *5211D23D038A_4A6D5F3D03A9_var*
var
 l_LeftState : IDocumentState;
//#UC END# *5211D23D038A_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *5211D23D038A_4A6D5F3D03A9_impl*
 aLeft.GetCurrentState(l_LeftState);
 MakeCompareEditions(aRight,
                     aParaForPositionning,
                     l_LeftState.Redaction,
                     TnsDocumentForReturnInfo_C(aDocumentForReturn, aParaForReturn));
//#UC END# *5211D23D038A_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseEditionsModule.MakeCompareEditions

class procedure TBaseEditionsModule.MakeCompareEditions(const aLeft: IDocument;
  const aRight: IDocument;
  const aPosition: TbsDocPos;
  const aDocumentForReturn: IDocument;
  const aParaForReturn: IeeLeafPara;
  const aContainer: IvcmContainer = nil);
var
 __WasEnter : Boolean;
//#UC START# *5214A1820193_4A6D5F3D03A9_var*
var
 l_LeftState: IDocumentState;
 l_Container: IvcmContainer;
//#UC END# *5214A1820193_4A6D5F3D03A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *5214A1820193_4A6D5F3D03A9_impl*
  try
   aLeft.GetCurrentState(l_LeftState);
   try
    if Assigned(aContainer)
     then l_Container := aContainer
     else l_Container := DefaultContainer;
    Tfs_CompareEditions.Make(
     TsdsCompareEditions.Make(TnsCompareEditionsInfo.Make(aRight,
                                                          aPosition,
                                                          l_LeftState.Redaction,
                                                          TnsDocumentForReturnInfo_C(aDocumentForReturn, aParaForReturn))),
     l_Container);
   finally
    l_LeftState := nil;
   end;
  except
   on ERedactionNotFound do
    vcmSay(inf_AnyInformation, [str_NoPrevEdition.AsCStr]);
  end;//try..except
//#UC END# *5214A1820193_4A6D5F3D03A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseEditionsModule.MakeCompareEditions

class procedure TBaseEditionsModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TLeftEditionForm);
 aList.Add(TRightEditionForm);
 aList.Add(TEditionsContainerForm);
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_NoPrevEdition
 str_NoPrevEdition.Init;
{$IfEnd} //not Admin AND not Monitorings

end.