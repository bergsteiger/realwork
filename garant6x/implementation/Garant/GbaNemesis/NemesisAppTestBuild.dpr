program NemesisAppTestBuild;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/NemesisAppTest.dpr"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMTestTarget::Category>> F1 Test::Nemesis
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3ExceptionsLog,
  nsApplication,
  evExtFormat,
  //vtWheel,
  vtMultilineHint,
  l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas',
  l3Types in 'w:\common\components\rtl\Garant\L3\l3Types.pas',
  SysUtils,
  l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas',
  Types,
  Windows in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas',
  ActiveX in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas',
  Messages in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas',
  Classes in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas',
  l3HackPersistentOwner in 'w:\common\components\rtl\Garant\L3\l3HackPersistentOwner.pas',
  l3HackPersistentOwner1 in 'w:\common\components\rtl\Garant\L3\l3HackPersistentOwner1.pas',
  l3CastablePersistent in 'w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas',
  l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas',
  l3IID in 'w:\common\components\rtl\Garant\L3\l3IID.pas',
  l3InterfacesMisc in 'w:\common\components\rtl\Garant\L3\l3InterfacesMisc.pas',
  l3CBase in 'w:\common\components\rtl\Garant\L3\l3CBase.pas',
  l3_Base in 'w:\common\components\rtl\Garant\L3\l3_Base.pas',
  l3CacheableBase in 'w:\common\components\rtl\Garant\L3\l3CacheableBase.pas',
  l3SomeDataContainer in 'w:\common\components\rtl\Garant\L3\l3SomeDataContainer.pas',
  l3InternalInterfaces in 'w:\common\components\rtl\Garant\L3\l3InternalInterfaces.pas',
  l3BaseStream in 'w:\common\components\rtl\Garant\L3\l3BaseStream.pas',
  l3Memory in 'w:\common\components\rtl\Garant\L3\l3Memory.pas',
  l3Except in 'w:\common\components\rtl\Garant\L3\l3Except.pas',
  RTLConsts in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\RTLConsts.pas',
  l3MinMax in 'w:\common\components\rtl\Garant\L3\l3MinMax.pas',
  l3ObjectRefList1 in 'w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas',
  l3DataContainerWithoutIUnknown in 'w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknown.pas',
  l3String in 'w:\common\components\rtl\Garant\L3\l3String.pas',
  l3PrimString in 'w:\common\components\rtl\Garant\L3\l3PrimString.pas',
  l3CustomString in 'w:\common\components\rtl\Garant\L3\l3CustomString.pas',
  l3_String in 'w:\common\components\rtl\Garant\L3\l3_String.pas',
  l3Base in 'w:\common\components\rtl\Garant\L3\l3Base.pas',
  DynamicTreeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeUnit.pas',
  vcmExternalInterfaces in 'w:\common\components\gui\Garant\VCM\vcmExternalInterfaces.pas',
  vcmInterfaces in 'w:\common\components\gui\Garant\VCM\vcmInterfaces.pas',
  FoldersDomainInterfaces in 'Search\FoldersDomainInterfaces.pas',
  L10nInterfaces in 'Model\L10nInterfaces.pas',
  F1Test in 'F1Test.pas',
  OfficeLike_Result_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Result_Controls.pas',
  Common_Rubricator_Controls in 'View\Common_Rubricator_Controls.pas',
  OfficeLikeAppInterfaces in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeAppInterfaces.pas',
  Common_FormDefinitions_Controls in 'View\Common_FormDefinitions_Controls.pas',
  MainWindowInterfaces in 'MainWindowControllers\MainWindowInterfaces.pas',
  BaseTypesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTypesUnit.pas',
  BaseTreeSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTreeSupportUnit.pas',
  StartUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\StartUnit.pas',
  LoggingUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\LoggingUnit.pas',
  SearchUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchUnit.pas',
  l3Chars in 'w:\common\components\rtl\Garant\L3\l3Chars.pas',
  l3Tree_TLB in 'w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas',
  l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas',
  l3Nodes in 'w:\common\components\rtl\Garant\L3\l3Nodes.pas',
  OfficeLike_Usual_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas',
  afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas',
  Controls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Controls.pas',
  Forms in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Forms.pas',
  afwFacade in 'w:\common\components\gui\Garant\AFW\afwFacade.pas',
  l3Forms in 'w:\common\components\rtl\Garant\L3\l3Forms.pas',
  l3ProtoObject in 'w:\common\components\rtl\Garant\L3\l3ProtoObject.pas',
  l3ProtoDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas',
  l3ConstStrings1 in 'w:\common\components\rtl\Garant\L3\l3ConstStrings1.pas',
  l3ConstStrings in 'w:\common\components\rtl\Garant\L3\l3ConstStrings.pas',
  l3StringIDEx in 'w:\common\components\rtl\Garant\L3\l3StringIDEx.pas',
  vtDialogsRes in 'w:\common\components\gui\Garant\VT\vtDialogsRes.pas',
  vtVGSceneRes in 'w:\common\components\gui\Garant\VT\vtVGSceneRes.pas' {vtVGSceneResources: TDataModule},
  StdCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas',
  l3ProtoObjectWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas',
  l3SimpleObjectPrim in 'w:\common\components\rtl\Garant\L3\l3SimpleObjectPrim.pas',
  l3SimpleObject in 'w:\common\components\rtl\Garant\L3\l3SimpleObject.pas',
  l3SimpleDataContainer in 'w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas',
  l3ObjectList in 'w:\common\components\rtl\Garant\L3\l3ObjectList.pas',
  vgAnyObjectList in 'w:\common\components\rtl\external\VGScene\vgAnyObjectList.pas',
  vgComponent in 'w:\common\components\rtl\external\VGScene\vgComponent.pas',
  vgCustomObject in 'w:\common\components\rtl\external\VGScene\vgCustomObject.pas',
  vgTypesPrim in 'w:\common\components\rtl\external\VGScene\vgTypesPrim.pas',
  vgSortableObjectList in 'w:\common\components\rtl\external\VGScene\vgSortableObjectList.pas',
  vgCustomObjectList in 'w:\common\components\rtl\external\VGScene\vgCustomObjectList.pas',
  vgObject in 'w:\common\components\rtl\external\VGScene\vgObject.pas',
  vgTypes in 'w:\common\components\rtl\external\VGScene\vgTypes.pas',
  vgObjectList in 'w:\common\components\rtl\external\VGScene\vgObjectList.pas',
  vgPersistent in 'w:\common\components\rtl\external\VGScene\vgPersistent.pas',
  vgBounds in 'w:\common\components\rtl\external\VGScene\vgBounds.pas',
  vgPosition in 'w:\common\components\rtl\external\VGScene\vgPosition.pas',
  vgVisualObject in 'w:\common\components\rtl\external\VGScene\vgVisualObject.pas',
  vgCustomResources in 'w:\common\components\rtl\external\VGScene\vgCustomResources.pas',
  vgCustomCanvas in 'w:\common\components\rtl\external\VGScene\vgCustomCanvas.pas',
  vgInterfaces in 'w:\common\components\rtl\external\VGScene\vgInterfaces.pas',
  vgSceneList in 'w:\common\components\rtl\external\VGScene\vgSceneList.pas',
  vgCustomGradientPoint in 'w:\common\components\rtl\external\VGScene\vgCustomGradientPoint.pas',
  vgGradientPoint in 'w:\common\components\rtl\external\VGScene\vgGradientPoint.pas',
  vgGradientPoints in 'w:\common\components\rtl\external\VGScene\vgGradientPoints.pas',
  l3InterfacedComponent in 'w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas',
  OvcController in 'w:\common\components\rtl\external\Orpheus\OvcController.pas',
  OvcConst in 'w:\common\components\rtl\external\Orpheus\OvcConst.pas',
  vgCustomControl in 'w:\common\components\rtl\external\VGScene\vgCustomControl.pas',
  vgScenePrim in 'w:\common\components\rtl\external\VGScene\vgScenePrim.pas',
  vgVisual in 'w:\common\components\rtl\external\VGScene\vgVisual.pas',
  vgInterfacedPersistent in 'w:\common\components\rtl\external\VGScene\vgInterfacedPersistent.pas',
  vgCustomBitmap in 'w:\common\components\rtl\external\VGScene\vgCustomBitmap.pas',
  vgVisualObjectList in 'w:\common\components\rtl\external\VGScene\vgVisualObjectList.pas',
  vg_extctrls in 'w:\common\components\rtl\external\VGScene\vg_extctrls.pas',
  vg_scene in 'w:\common\components\rtl\external\VGScene\vg_scene.pas',
  vg_controls in 'w:\common\components\rtl\external\VGScene\vg_controls.pas',
  vtVGButton in 'w:\common\components\gui\Garant\VT\vtVGButton.pas',
  vtF1InterfaceConst in 'w:\common\components\gui\Garant\VT\vtF1InterfaceConst.pas',
  vtDialogsResEx in 'w:\common\components\gui\Garant\VT\vtDialogsResEx.pas',
  vcmDialogs in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDialogs.pas',
  vcmForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmForm.pas',
  vcmControllers in 'w:\common\components\gui\Garant\VCM\vcmControllers.pas',
  vcmToolbarsInterfaces in 'w:\common\components\gui\Garant\VCM\vcmToolbarsInterfaces.pas',
  vcmFormDispatcherInterfaces in 'w:\common\components\gui\Garant\VCM\vcmFormDispatcherInterfaces.pas',
  l3VCLFormPtrList in 'w:\common\components\rtl\Garant\L3\l3VCLFormPtrList.pas',
  vcmEntityForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityForm.pas',
  vcmUserControls in 'w:\common\components\gui\Garant\VCM\vcmUserControls.pas',
  vcmContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmContainerForm.pas',
  vcmMainForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainForm.pas',
  bsInterfaces in 'Model\bsInterfaces.pas',
  nscNewInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscNewInterfaces.pas',
  nscStatusBarOperationDefsList in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarOperationDefsList.pas',
  nscStatusBarItemDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarItemDef.pas',
  StdRes in 'StdRes.pas' {dmStdRes: TvcmApplicationRes},
  Nemesis_System_Controls in 'View\Nemesis_System_Controls.pas',
  F1_Application_Template_InternalOperations_Controls in 'View\F1_Application_Template_InternalOperations_Controls.pas',
  nscNavigator in 'w:\common\components\gui\Garant\Nemesis\nscNavigator.pas',
  vtSizeablePanel in 'w:\common\components\gui\Garant\VT\vtSizeablePanel.pas',
  vcmFormSetFactory in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactory.pas',
  vcmModule in 'w:\common\components\gui\Garant\VCM\implementation\vcmModule.pas',
  vcmBaseOperationState in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationState.pas',
  vcmModulesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModulesCollection.pas',
  vcmRepEntitiesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepEntitiesCollection.pas',
  vcmBaseMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseMenuManager.pas',
  vcmApplication in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmApplication.pas',
  PrimCustomizeTools_Form in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\PrimCustomizeTools_Form.pas',
  CustomizeTools_Form in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_Form.pas' {CustomizeToolsForm: TvcmEntityForm},
  vcmToolbarMenuRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmToolbarMenuRes.pas',
  vcmMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMenuManager.pas',
  ActnList in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ActnList.pas',
  vcmCustomizeAvailableToolbarOps in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomizeAvailableToolbarOps.pas',
  vcmMenus in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenus.pas',
  tfwScriptingInterfaces in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptingInterfaces.pas'
  ,
  l3KeyWrd in 'w:\common\components\rtl\Garant\L3\l3KeyWrd.pas'
  {$If defined(nsTest)}
  ,
  tfwDictionary in 'w:\common\components\rtl\Garant\DUnitTuning\tfwDictionary.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  tfwAutoregisteredDiction in 'w:\common\components\rtl\Garant\DUnitTuning\tfwAutoregisteredDiction.pas'
  {$IfEnd} //nsTest
  ,
  l3Stream in 'w:\common\components\rtl\Garant\L3\l3Stream.pas',
  l3ProtoPersistentDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas',
  l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas',
  l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas',
  l3StringListPrim in 'w:\common\components\rtl\Garant\L3\l3StringListPrim.pas',
  l3StringList1 in 'w:\common\components\rtl\Garant\L3\l3StringList1.pas',
  l3StringList2 in 'w:\common\components\rtl\Garant\L3\l3StringList2.pas',
  l3StringList in 'w:\common\components\rtl\Garant\L3\l3StringList.pas',
  l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas'
  {$If defined(nsTest)}
  ,
  tfwValueList in 'w:\common\components\rtl\Garant\DUnitTuning\tfwValueList.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  tfwValueStack in 'w:\common\components\rtl\Garant\DUnitTuning\tfwValueStack.pas'
  {$IfEnd} //nsTest
  ,
  l3ParserInterfaces in 'w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas',
  TypInfo in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas'
  {$If defined(nsTest)}
  ,
  kwFalse in 'w:\common\components\rtl\Garant\DUnitTuning\kwFalse.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwTrue in 'w:\common\components\rtl\Garant\DUnitTuning\kwTrue.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwHelp in 'w:\common\components\rtl\Garant\DUnitTuning\kwHelp.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwPrint in 'w:\common\components\rtl\Garant\DUnitTuning\kwPrint.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwEmitString in 'w:\common\components\rtl\Garant\DUnitTuning\kwEmitString.pas'
  {$IfEnd} //nsTest
  ,
  Menus in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Menus.pas'
  {$If defined(nsTest)}
  ,
  kwKey in 'w:\common\components\rtl\Garant\DUnitTuning\kwKey.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwProcessMessages in 'w:\common\components\rtl\Garant\DUnitTuning\kwProcessMessages.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledWord in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledWord.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwInteger in 'w:\common\components\rtl\Garant\DUnitTuning\kwInteger.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwString in 'w:\common\components\rtl\Garant\DUnitTuning\kwString.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwNewWord in 'w:\common\components\rtl\Garant\DUnitTuning\kwNewWord.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledWordContainer in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledWordContainer.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledFor in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledFor.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwFor in 'w:\common\components\rtl\Garant\DUnitTuning\kwFor.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwLessThenZero in 'w:\common\components\rtl\Garant\DUnitTuning\kwLessThenZero.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwGreaterThenZero in 'w:\common\components\rtl\Garant\DUnitTuning\kwGreaterThenZero.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwEqualZero in 'w:\common\components\rtl\Garant\DUnitTuning\kwEqualZero.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDUP in 'w:\common\components\rtl\Garant\DUnitTuning\kwDUP.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDROP in 'w:\common\components\rtl\Garant\DUnitTuning\kwDROP.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDualCompiledWordContainer in 'w:\common\components\rtl\Garant\DUnitTuning\kwDualCompiledWordContainer.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledIF in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledIF.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwIF in 'w:\common\components\rtl\Garant\DUnitTuning\kwIF.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwAdd in 'w:\common\components\rtl\Garant\DUnitTuning\kwAdd.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSub in 'w:\common\components\rtl\Garant\DUnitTuning\kwSub.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwInc in 'w:\common\components\rtl\Garant\DUnitTuning\kwInc.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDec in 'w:\common\components\rtl\Garant\DUnitTuning\kwDec.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSWAP in 'w:\common\components\rtl\Garant\DUnitTuning\kwSWAP.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwAssert in 'w:\common\components\rtl\Garant\DUnitTuning\kwAssert.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwAssertS in 'w:\common\components\rtl\Garant\DUnitTuning\kwAssertS.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwConstant in 'w:\common\components\rtl\Garant\DUnitTuning\kwConstant.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledTryFinally in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledTryFinally.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledTryExcept in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledTryExcept.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwTryFinally in 'w:\common\components\rtl\Garant\DUnitTuning\kwTryFinally.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwBeginWord in 'w:\common\components\rtl\Garant\DUnitTuning\kwBeginWord.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwNotZero in 'w:\common\components\rtl\Garant\DUnitTuning\kwNotZero.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwNot in 'w:\common\components\rtl\Garant\DUnitTuning\kwNot.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwAND in 'w:\common\components\rtl\Garant\DUnitTuning\kwAND.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwOR in 'w:\common\components\rtl\Garant\DUnitTuning\kwOR.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwRaise in 'w:\common\components\rtl\Garant\DUnitTuning\kwRaise.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDefault in 'w:\common\components\rtl\Garant\DUnitTuning\kwDefault.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledCase in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledCase.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCase in 'w:\common\components\rtl\Garant\DUnitTuning\kwCase.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwNOP in 'w:\common\components\rtl\Garant\DUnitTuning\kwNOP.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSleep in 'w:\common\components\rtl\Garant\DUnitTuning\kwSleep.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledVar in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledVar.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwVar in 'w:\common\components\rtl\Garant\DUnitTuning\kwVar.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledVarWorker in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledVarWorker.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledPopToVar in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledPopToVar.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwPopToVar in 'w:\common\components\rtl\Garant\DUnitTuning\kwPopToVar.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwProcedure in 'w:\common\components\rtl\Garant\DUnitTuning\kwProcedure.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwBracketBegin in 'w:\common\components\rtl\Garant\DUnitTuning\kwBracketBegin.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwConst in 'w:\common\components\rtl\Garant\DUnitTuning\kwConst.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledIncluded in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledIncluded.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwIncluded in 'w:\common\components\rtl\Garant\DUnitTuning\kwIncluded.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwInclude in 'w:\common\components\rtl\Garant\DUnitTuning\kwInclude.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwUses in 'w:\common\components\rtl\Garant\DUnitTuning\kwUses.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwMain in 'w:\common\components\rtl\Garant\DUnitTuning\kwMain.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwIn in 'w:\common\components\rtl\Garant\DUnitTuning\kwIn.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwStringModifier in 'w:\common\components\rtl\Garant\DUnitTuning\kwStringModifier.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwPrivateModifier in 'w:\common\components\rtl\Garant\DUnitTuning\kwPrivateModifier.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledWordWorker in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledWordWorker.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledPushWord in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledPushWord.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwPushWord in 'w:\common\components\rtl\Garant\DUnitTuning\kwPushWord.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDoPushedWord in 'w:\common\components\rtl\Garant\DUnitTuning\kwDoPushedWord.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwDUPIfNotZero in 'w:\common\components\rtl\Garant\DUnitTuning\kwDUPIfNotZero.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledWhile in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledWhile.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwWhile in 'w:\common\components\rtl\Garant\DUnitTuning\kwWhile.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledLoop in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledLoop.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwLoop in 'w:\common\components\rtl\Garant\DUnitTuning\kwLoop.pas'
  {$IfEnd} //nsTest
  ,
  l3PureMixIns in 'w:\common\components\rtl\Garant\L3\l3PureMixIns.pas'
  {$If defined(nsTest)}
  ,
  kwCompiledArray in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledArray.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwArray in 'w:\common\components\rtl\Garant\DUnitTuning\kwArray.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompiledAppendToList in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledAppendToList.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwAppendToList in 'w:\common\components\rtl\Garant\DUnitTuning\kwAppendToList.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  {,
  kwCompiledIterate in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompiledIterate.pas'}
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwIterate in 'w:\common\components\rtl\Garant\DUnitTuning\kwIterate.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwIntToStr in 'w:\common\components\rtl\Garant\DUnitTuning\kwIntToStr.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwStrToInt in 'w:\common\components\rtl\Garant\DUnitTuning\kwStrToInt.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCat in 'w:\common\components\rtl\Garant\DUnitTuning\kwCat.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSameStr in 'w:\common\components\rtl\Garant\DUnitTuning\kwSameStr.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSameText in 'w:\common\components\rtl\Garant\DUnitTuning\kwSameText.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompareStr in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompareStr.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwCompareText in 'w:\common\components\rtl\Garant\DUnitTuning\kwCompareText.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwScriptFileName in 'w:\common\components\rtl\Garant\DUnitTuning\kwScriptFileName.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSysUtilsChangeFileExt in 'w:\common\components\rtl\Garant\DUnitTuning\kwSysUtilsChangeFileExt.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  kwSysUtilsExtractFileName in 'w:\common\components\rtl\Garant\DUnitTuning\kwSysUtilsExtractFileName.pas'
  {$IfEnd} //nsTest
  
  {$If defined(nsTest)}
  ,
  tfwScriptEngine in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptEngine.pas'
  {$IfEnd} //nsTest
  ,
  vcmStringIDExHelper in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringIDExHelper.pas',
  vcmMakeParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmMakeParams.pas',
  vcmBase in 'w:\common\components\gui\Garant\VCM\implementation\vcmBase.pas'
  {$If defined(InsiderTest)}
  ,
  kw_ToolbarMenu_Customize in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_Customize.pas'
  {$IfEnd} //InsiderTest
  
  {$If defined(InsiderTest)}
  ,
  kw_ToolbarMenu_AvailableOperations in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_AvailableOperations.pas'
  {$IfEnd} //InsiderTest
  
  {$If defined(InsiderTest)}
  ,
  kw_ToolbarMenu_IconsSize in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_IconsSize.pas'
  {$IfEnd} //InsiderTest
  
  {$If defined(InsiderTest)}
  ,
  kw_ToolbarMenu_Fasten in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_Fasten.pas'
  {$IfEnd} //InsiderTest
  ,
  PrimToolbarMenu_Module in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\PrimToolbarMenu_Module.pas',
  moToolbarMenu in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\moToolbarMenu.pas' {mo_ToolbarMenu: TvcmModule},
  OfficeLikeRes in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas',
  OfficeLikeMain_Form in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeMain_Form.pas',
  PrimLegalMain_Form in 'w:\common\components\gui\Garant\VCM\Legal\PrimLegalMain_Form.pas'
  {$If defined(nsTest)}
  ,
  tfwString in 'w:\common\components\rtl\Garant\DUnitTuning\tfwString.pas'
  {$IfEnd} //nsTest
  ,
  Logo_Form in 'View\PrimCommon\Forms\Logo_Form.pas' {LogoForm: TvcmEntityForm},
  LegalRes in 'w:\common\components\gui\Garant\VCM\Legal\LegalRes.pas',
  lgTypes in 'View\lgTypes.pas',
  LoggingInterfaces in 'Model\LoggingInterfaces.pas',
  AdminDomainInterfaces in 'Model\AdminDomainInterfaces.pas',
  DataAdapterInterfaces in 'Model\DataAdapterInterfaces.pas',
  DataAdapter in 'Data\Common\DataAdapter.pas',
  nsLogEvent in 'Data\nsLogEvent.pas',
  InsDefferedEventList in 'Data\InsDefferedEventList.pas',
  DateUtils in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\DateUtils.pas',
  nsPrimCachedEventsProcessor in 'Data\nsPrimCachedEventsProcessor.pas',
  nsCachedEventsProcessor in 'Data\nsCachedEventsProcessor.pas',
  nsPrimCachedEvent in 'Data\nsPrimCachedEvent.pas',
  k2Interfaces in 'w:\common\components\rtl\Garant\K2\k2Interfaces.pas',
  nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas',
  nevDocumentContainerListPrim in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerListPrim.pas',
  k2Types in 'w:\common\components\rtl\Garant\K2\k2Types.pas',
  l3BitArr in 'w:\common\components\rtl\Garant\L3\l3BitArr.pas',
  k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas',
  k2Const in 'w:\common\components\rtl\Garant\K2\k2Const.pas',
  k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas',
  k2Prim in 'w:\common\components\rtl\Garant\K2\k2Prim.pas',
  k2Facade in 'w:\common\components\rtl\Garant\K2\k2Facade.pas',
  nevDocumentContainerList in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerList.pas',
  evDocumentsCache in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCache.pas',
  vcmHistory in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistory.pas',
  afwConsts in 'w:\common\components\gui\Garant\AFW\afwConsts.pas',
  SPHTMLHelp in 'w:\common\components\gui\Garant\AFW\SPHTMLHelp.pas',
  GblAdapter
  {$If not defined(Shell)}
  ,
  EmptyMain_Form in 'View\EmptyMain_Form.pas' {EmptyMainForm: TvcmMainForm}
  {$IfEnd} //not Shell
  ,
  SearchInterfaces in 'Search\SearchInterfaces.pas',
  IOUnit in 'w:\shared\GCI\IOUnit.pas',
  nsTypesNew in 'Model\nsTypesNew.pas',
  nsTypes in 'Model\nsTypes.pas',
  OfficeLike_Text_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Text_Controls.pas',
  nsUtils in 'Data\Common\nsUtils.pas',
  TreeAttribute_Form in 'View\LiteSearch\Forms\TreeAttribute_Form.pas',
  SearchDomainInterfaces in 'Model\SearchDomainInterfaces.pas',
  l3Units in 'w:\common\components\rtl\Garant\L3\l3Units.pas',
  afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas',
  OvcBase in 'w:\common\components\rtl\external\Orpheus\OvcBase.pas',
  afwControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControlPrim.pas',
  l3LongintListPrim in 'w:\common\components\rtl\Garant\L3\l3LongintListPrim.pas',
  l3LongintList in 'w:\common\components\rtl\Garant\L3\l3LongintList.pas',
  l3Defaults in 'w:\common\components\rtl\Garant\L3\l3Defaults.pas',
  l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas',
  l3Const in 'w:\common\components\rtl\Garant\L3\l3Const.pas',
  l3CanvasPrim in 'w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas',
  l3LineArray in 'w:\common\components\rtl\Garant\L3\l3LineArray.pas',
  l3Region in 'w:\common\components\rtl\Garant\L3\l3Region.pas',
  l3Canvas in 'w:\common\components\rtl\Garant\L3\l3Canvas.pas',
  l3ControlCanvas in 'w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas',
  l3WinControlCanvas in 'w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas',
  l3Operations in 'w:\common\components\rtl\Garant\L3\l3Operations.pas',
  Graphics in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas',
  l3Bitmap in 'w:\common\components\rtl\Garant\L3\l3Bitmap.pas',
  l3SysUtils in 'w:\common\components\rtl\Garant\L3\l3SysUtils.pas',
  l3DropTarget in 'w:\common\components\rtl\Garant\L3\l3DropTarget.pas',
  l3DropSource in 'w:\common\components\rtl\Garant\L3\l3DropSource.pas',
  afwFont in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwFont.pas',
  afwVCL in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas',
  ExtCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas',
  afwHintManager in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas',
  k2NilOp in 'w:\common\components\rtl\Garant\K2\k2NilOp.pas',
  k2Op in 'w:\common\components\rtl\Garant\K2\k2Op.pas',
  l3ProtoPersistentOwnedDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentOwnedDataContainer.pas',
  k2OpRefListAnscestor in 'w:\common\components\rtl\Garant\K2\k2OpRefListAnscestor.pas',
  k2OpRefList in 'w:\common\components\rtl\Garant\K2\k2OpRefList.pas',
  l3BaseWithID in 'w:\common\components\rtl\Garant\L3\l3BaseWithID.pas',
  l3BaseWithIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDListPrim.pas',
  l3BaseWithIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDList.pas',
  l3ValueMap in 'w:\common\components\rtl\Garant\L3\l3ValueMap.pas',
  l3ValueMapManagerPrim in 'w:\common\components\rtl\Garant\L3\l3ValueMapManagerPrim.pas',
  l3ValueMapManager in 'w:\common\components\rtl\Garant\L3\l3ValueMapManager.pas',
  l3IntegerValueMapManager in 'w:\common\components\rtl\Garant\L3\l3IntegerValueMapManager.pas',
  k2OperationContainer in 'w:\common\components\rtl\Garant\K2\k2OperationContainer.pas',
  afwBaseControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwBaseControl.pas',
  afwControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControl.pas',
  afwInputControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInputControl.pas',
  vtLister in 'w:\common\components\gui\Garant\VT\vtLister.pas',
  vtOutLiner in 'w:\common\components\gui\Garant\VT\vtOutLiner.pas',
  vtOutlinerWithQuickSearch in 'w:\common\components\gui\Garant\VT\vtOutlinerWithQuickSearch.pas',
  vtOutlinerWithDragDropRes in 'w:\common\components\gui\Garant\VT\vtOutlinerWithDragDropRes.pas',
  vtOutlinerWithDragDrop in 'w:\common\components\gui\Garant\VT\vtOutlinerWithDragDrop.pas',
  eeTreeViewExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeViewExport.pas',
  eeCustomTreeView in 'w:\common\components\gui\Garant\Everest_Engine\eeCustomTreeView.pas',
  eeTreeView in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeView.pas',
  nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas',
  evdInterfaces in 'w:\common\components\rtl\Garant\EVD\evdInterfaces.pas',
  evStorable in 'w:\common\components\gui\Garant\Everest\evStorable.pas',
  afwNavigation in 'w:\common\components\gui\Garant\AFW\afwNavigation.pas',
  evdTypes in 'w:\common\components\rtl\Garant\EVD\evdTypes.pas',
  k2Long_Const in 'w:\common\components\rtl\Garant\K2\k2Long_Const.pas',
  k2Handle_Const in 'w:\common\components\rtl\Garant\K2\k2Handle_Const.pas',
  k2Inch_Const in 'w:\common\components\rtl\Garant\K2\k2Inch_Const.pas',
  k2Enum_Const in 'w:\common\components\rtl\Garant\K2\k2Enum_Const.pas',
  k2Bool_Const in 'w:\common\components\rtl\Garant\K2\k2Bool_Const.pas',
  k2Object_Const in 'w:\common\components\rtl\Garant\K2\k2Object_Const.pas',
  k2SomeDataContainer_Const in 'w:\common\components\rtl\Garant\K2\k2SomeDataContainer_Const.pas',
  k2l3Base_Const in 'w:\common\components\rtl\Garant\K2\k2l3Base_Const.pas',
  k2SortTagsListPrim in 'w:\common\components\rtl\Garant\K2\k2SortTagsListPrim.pas',
  k2SortTagsList in 'w:\common\components\rtl\Garant\K2\k2SortTagsList.pas',
  k2TypeModelPart in 'w:\common\components\rtl\Garant\K2\k2TypeModelPart.pas',
  k2BaseStruct in 'w:\common\components\rtl\Garant\K2\k2BaseStruct.pas',
  k2PropSorter in 'w:\common\components\rtl\Garant\K2\k2PropSorter.pas',
  k2BaseTypes in 'w:\common\components\rtl\Garant\K2\k2BaseTypes.pas',
  k2PureMixIns in 'w:\common\components\rtl\Garant\K2\k2PureMixIns.pas',
  k2Strings in 'w:\common\components\rtl\Garant\K2\k2Strings.pas',
  k2NullTagImplPrim in 'w:\common\components\rtl\Garant\K2\k2NullTagImplPrim.pas',
  k2NullTagImpl in 'w:\common\components\rtl\Garant\K2\k2NullTagImpl.pas',
  k2Base in 'w:\common\components\rtl\Garant\K2\k2Base.pas',
  Object_Wrap in 'w:\common\components\rtl\Garant\K2\Object_Wrap.pas',
  k2TagListPrim in 'w:\common\components\rtl\Garant\K2\k2TagListPrim.pas',
  k2TagList in 'w:\common\components\rtl\Garant\K2\k2TagList.pas',
  k2List in 'w:\common\components\rtl\Garant\K2\k2List.pas',
  l3DictionaryPrim in 'w:\common\components\rtl\Garant\L3\l3DictionaryPrim.pas',
  l3IDIndexPrim in 'w:\common\components\rtl\Garant\L3\l3IDIndexPrim.pas',
  l3IDIndex in 'w:\common\components\rtl\Garant\L3\l3IDIndex.pas',
  l3Dict in 'w:\common\components\rtl\Garant\L3\l3Dict.pas',
  k2Except in 'w:\common\components\rtl\Garant\K2\k2Except.pas',
  k2AtomicTag in 'w:\common\components\rtl\Garant\K2\k2AtomicTag.pas',
  Long_Wrap in 'w:\common\components\rtl\Garant\K2\Long_Wrap.pas',
  Enumeration_Wrap in 'w:\common\components\rtl\Garant\K2\Enumeration_Wrap.pas',
  Bool_Wrap in 'w:\common\components\rtl\Garant\K2\Bool_Wrap.pas',
  k2Color_Const in 'w:\common\components\rtl\Garant\K2\k2Color_Const.pas',
  Color_Wrap in 'w:\common\components\rtl\Garant\K2\Color_Wrap.pas',
  k2RawData_Const in 'w:\common\components\rtl\Garant\K2\k2RawData_Const.pas',
  Persistent_Wrap in 'w:\common\components\rtl\Garant\K2\Persistent_Wrap.pas',
  l3String_Wrap in 'w:\common\components\rtl\Garant\K2\l3String_Wrap.pas',
  k2OList_Const in 'w:\common\components\rtl\Garant\K2\k2OList_Const.pas',
  l3List_Wrap in 'w:\common\components\rtl\Garant\K2\l3List_Wrap.pas',
  k2Tag_Const in 'w:\common\components\rtl\Garant\K2\k2Tag_Const.pas',
  k2SmallTagObject in 'w:\common\components\rtl\Garant\K2\k2SmallTagObject.pas',
  k2Tag_Wrap in 'w:\common\components\rtl\Garant\K2\k2Tag_Wrap.pas',
  k2IUnknown_Const in 'w:\common\components\rtl\Garant\K2\k2IUnknown_Const.pas',
  k2Native_Schema in 'w:\common\components\rtl\Garant\K2\k2Native_Schema.pas',
  k2String_Const in 'w:\common\components\rtl\Garant\K2\k2String_Const.pas',
  Date_Const in 'w:\common\components\rtl\Garant\EVD\Date_Const.pas',
  Type_Const in 'w:\common\components\rtl\Garant\EVD\Type_Const.pas',
  evdStyles in 'w:\common\components\rtl\Garant\EVD\evdStyles.pas',
  Justification_Const in 'w:\common\components\rtl\Garant\EVD\Justification_Const.pas',
  Position_Const in 'w:\common\components\rtl\Garant\EVD\Position_Const.pas',
  Time_Const in 'w:\common\components\rtl\Garant\EVD\Time_Const.pas',
  ObjectWithHandle_Const in 'w:\common\components\rtl\Garant\EVD\ObjectWithHandle_Const.pas',
  SgLHandle_Const in 'w:\common\components\rtl\Garant\EVD\SgLHandle_Const.pas',
  SbLHandle_Const in 'w:\common\components\rtl\Garant\EVD\SbLHandle_Const.pas',
  l3FontManager in 'w:\common\components\rtl\Garant\L3\l3FontManager.pas',
  FontName_Const in 'w:\common\components\rtl\Garant\EVD\FontName_Const.pas',
  Font_Const in 'w:\common\components\rtl\Garant\EVD\Font_Const.pas',
  Style_Const in 'w:\common\components\rtl\Garant\EVD\Style_Const.pas',
  FramePart_Const in 'w:\common\components\rtl\Garant\EVD\FramePart_Const.pas',
  evdFrame_Const in 'w:\common\components\rtl\Garant\EVD\evdFrame_Const.pas',
  k2Dictionary in 'w:\common\components\rtl\Garant\K2\k2Dictionary.pas',
  evdStyleContainer in 'w:\common\components\rtl\Garant\EVD\evdStyleContainer.pas',
  evdTextStyle_Const in 'w:\common\components\rtl\Garant\EVD\evdTextStyle_Const.pas',
  NSRCTag_Const in 'w:\common\components\rtl\Garant\EVD\NSRCTag_Const.pas',
  DictRec_Const in 'w:\common\components\rtl\Garant\EVD\DictRec_Const.pas',
  DictItem_Const in 'w:\common\components\rtl\Garant\EVD\DictItem_Const.pas',
  DictItemEx_Const in 'w:\common\components\rtl\Garant\EVD\DictItemEx_Const.pas',
  AutoClass_Const in 'w:\common\components\rtl\Garant\EVD\AutoClass_Const.pas',
  Sub_Const in 'w:\common\components\rtl\Garant\EVD\Sub_Const.pas',
  DocumentSub_Const in 'w:\common\components\rtl\Garant\EVD\DocumentSub_Const.pas',
  SubLayer_Const in 'w:\common\components\rtl\Garant\EVD\SubLayer_Const.pas',
  Para_Const in 'w:\common\components\rtl\Garant\EVD\Para_Const.pas',
  Segment_Const in 'w:\common\components\rtl\Garant\EVD\Segment_Const.pas',
  LogRecordPrim_Const in 'w:\common\components\rtl\Garant\EVD\LogRecordPrim_Const.pas',
  StagePrim_Const in 'w:\common\components\rtl\Garant\EVD\StagePrim_Const.pas',
  TextSegment_Const in 'w:\common\components\rtl\Garant\EVD\TextSegment_Const.pas',
  PageProperties_Const in 'w:\common\components\rtl\Garant\EVD\PageProperties_Const.pas',
  LeafPara_Const in 'w:\common\components\rtl\Garant\EVD\LeafPara_Const.pas',
  PageBreak_Const in 'w:\common\components\rtl\Garant\EVD\PageBreak_Const.pas',
  evSbLHandle_Wrap in 'w:\common\components\rtl\Garant\EVD\evSbLHandle_Wrap.pas',
  evFontName_Wrap in 'w:\common\components\rtl\Garant\EVD\evFontName_Wrap.pas',
  evFont_Wrap in 'w:\common\components\rtl\Garant\EVD\evFont_Wrap.pas',
  k2DictRec in 'w:\common\components\rtl\Garant\K2\k2DictRec.pas',
  k2DictRec_Wrap in 'w:\common\components\rtl\Garant\K2\k2DictRec_Wrap.pas',
  evStyle_Wrap in 'w:\common\components\rtl\Garant\EVD\evStyle_Wrap.pas',
  evFramePart_Wrap in 'w:\common\components\rtl\Garant\EVD\evFramePart_Wrap.pas',
  evFrame_Wrap in 'w:\common\components\rtl\Garant\EVD\evFrame_Wrap.pas',
  evdDictRec_Wrap in 'w:\common\components\rtl\Garant\EVD\evdDictRec_Wrap.pas',
  evSub_Wrap in 'w:\common\components\rtl\Garant\EVD\evSub_Wrap.pas',
  SegmentsLayer_Const in 'w:\common\components\rtl\Garant\EVD\SegmentsLayer_Const.pas',
  evLayer_Wrap in 'w:\common\components\rtl\Garant\EVD\evLayer_Wrap.pas',
  evChangeLayer_Wrap in 'w:\common\components\rtl\Garant\EVD\evChangeLayer_Wrap.pas',
  evPara_Wrap in 'w:\common\components\rtl\Garant\EVD\evPara_Wrap.pas',
  evSgLHandle_Wrap in 'w:\common\components\rtl\Garant\EVD\evSgLHandle_Wrap.pas',
  SectionBreak_Const in 'w:\common\components\rtl\Garant\EVD\SectionBreak_Const.pas',
  Bullet_Const in 'w:\common\components\rtl\Garant\EVD\Bullet_Const.pas',
  TabStop_Const in 'w:\common\components\rtl\Garant\EVD\TabStop_Const.pas',
  l3Drawer in 'w:\common\components\rtl\Garant\L3\l3Drawer.pas',
  ExprDraw in 'w:\common\components\rtl\external\Expr\ExprDraw.pas',
  evQueryCardInt in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardInt.pas',
  l3ItemsStorage in 'w:\common\components\rtl\Garant\L3\l3ItemsStorage.pas',
  l3Tree in 'w:\common\components\rtl\Garant\L3\l3Tree.pas',
  DocSubLayer_Const in 'w:\common\components\rtl\Garant\EVD\DocSubLayer_Const.pas',
  ActiveInterval_Const in 'w:\common\components\rtl\Garant\EVD\ActiveInterval_Const.pas',
  Alarm_Const in 'w:\common\components\rtl\Garant\EVD\Alarm_Const.pas',
  LogRecord_Const in 'w:\common\components\rtl\Garant\EVD\LogRecord_Const.pas',
  Stage_Const in 'w:\common\components\rtl\Garant\EVD\Stage_Const.pas',
  NumANDDate_Const in 'w:\common\components\rtl\Garant\EVD\NumANDDate_Const.pas',
  Check_Const in 'w:\common\components\rtl\Garant\EVD\Check_Const.pas',
  PIRec_Const in 'w:\common\components\rtl\Garant\EVD\PIRec_Const.pas',
  ControlPara_Const in 'w:\common\components\gui\Garant\Everest\ControlPara_Const.pas',
  evFormulaParaBitmapContainer in 'w:\common\components\rtl\Garant\EVD\evFormulaParaBitmapContainer.pas',
  ParaList_Const in 'w:\common\components\gui\Garant\Everest\ParaList_Const.pas',
  HFParent_Const in 'w:\common\components\gui\Garant\Everest\HFParent_Const.pas',
  Header_Const in 'w:\common\components\gui\Garant\Everest\Header_Const.pas',
  Footer_Const in 'w:\common\components\gui\Garant\Everest\Footer_Const.pas',
  Division_Const in 'w:\common\components\gui\Garant\Everest\Division_Const.pas',
  ContentsElement_Const in 'w:\common\components\gui\Garant\Everest\ContentsElement_Const.pas',
  evDocumentPart in 'w:\common\components\gui\Garant\Everest\evDocumentPart.pas',
  Block_Const in 'w:\common\components\gui\Garant\Everest\Block_Const.pas',
  evTextStyle_Const in 'w:\common\components\gui\Garant\Everest\evTextStyle_Const.pas',
  SimpleDocumentTextPara_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocumentTextPara_Const.pas',
  evDef in 'w:\common\components\gui\Garant\Everest\evDef.pas',
  SimpleDocument_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocument_Const.pas',
  DictEntryBlock_Const in 'w:\common\components\gui\Garant\Everest\DictEntryBlock_Const.pas',
  TableTextPara_Const in 'w:\common\components\gui\Garant\Everest\TableTextPara_Const.pas',
  TableCell_Const in 'w:\common\components\gui\Garant\Everest\TableCell_Const.pas',
  SBSCell_Const in 'w:\common\components\gui\Garant\Everest\SBSCell_Const.pas',
  TableRow_Const in 'w:\common\components\gui\Garant\Everest\TableRow_Const.pas',
  SBSRow_Const in 'w:\common\components\gui\Garant\Everest\SBSRow_Const.pas',
  Table_Const in 'w:\common\components\gui\Garant\Everest\Table_Const.pas',
  ReqCell_Const in 'w:\common\components\gui\Garant\Everest\ReqCell_Const.pas',
  ReqRow_Const in 'w:\common\components\gui\Garant\Everest\ReqRow_Const.pas',
  l3GraphicContainerStack in 'w:\common\components\rtl\Garant\L3\l3GraphicContainerStack.pas',
  l3GraphicContainer in 'w:\common\components\rtl\Garant\L3\l3GraphicContainer.pas',
  l3IEBitmapContainerStack in 'w:\common\components\rtl\Garant\L3\l3IEBitmapContainerStack.pas',
  l3IEBitmapContainer in 'w:\common\components\rtl\Garant\L3\l3IEBitmapContainer.pas',
  evBitmapParaBitmapContainer in 'w:\common\components\rtl\Garant\EVD\evBitmapParaBitmapContainer.pas',
  XMLTag_Const in 'w:\common\components\gui\Garant\Everest\XMLTag_Const.pas',
  AttrName_Const in 'w:\common\components\gui\Garant\Everest\AttrName_Const.pas',
  Participant_Const in 'w:\common\components\gui\Garant\Everest\Participant_Const.pas',
  evTextPara_Wrap in 'w:\common\components\gui\Garant\Everest\evTextPara_Wrap.pas',
  evControlParaConst in 'w:\common\components\gui\Garant\Everest\evControlParaConst.pas',
  evTypes in 'w:\common\components\gui\Garant\Everest\evTypes.pas',
  evInternalInterfaces in 'w:\common\components\gui\Garant\Everest\evInternalInterfaces.pas',
  evSearch in 'w:\common\components\gui\Garant\Everest\evSearch.pas',
  nevConfirm in 'w:\common\components\gui\Garant\Everest\new\nevConfirm.pas',
  evExcept in 'w:\common\components\gui\Garant\Everest\evExcept.pas',
  evParaUtilClasses in 'w:\common\components\gui\Garant\Everest\evParaUtilClasses.pas',
  evEditorInterfaces in 'w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas',
  nevNavigation in 'w:\common\components\gui\Garant\Everest\new\nevNavigation.pas',
  evMsgCode in 'w:\common\components\gui\Garant\Everest\evMsgCode.pas',
  evOp in 'w:\common\components\gui\Garant\Everest\evOp.pas',
  l3NCString in 'w:\common\components\rtl\Garant\L3\l3NCString.pas',
  l3InterfacedString in 'w:\common\components\rtl\Garant\L3\l3InterfacedString.pas',
  k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas',
  evCursorTools in 'w:\common\components\gui\Garant\Everest\evCursorTools.pas',
  k2Context in 'w:\common\components\rtl\Garant\K2\k2Context.pas',
  evParaTools in 'w:\common\components\gui\Garant\Everest\evParaTools.pas',
  ReqGroup_Const in 'w:\common\components\gui\Garant\Everest\ReqGroup_Const.pas',
  evControlPara_Wrap in 'w:\common\components\gui\Garant\Everest\evControlPara_Wrap.pas',
  Formula_Const in 'w:\common\components\gui\Garant\Everest\Formula_Const.pas',
  BitmapPara_Const in 'w:\common\components\gui\Garant\Everest\BitmapPara_Const.pas',
  evBitmapPara_Wrap in 'w:\common\components\gui\Garant\Everest\evBitmapPara_Wrap.pas',
  exprTokensList in 'w:\common\components\rtl\external\Expr\exprTokensList.pas',
  ExprMake in 'w:\common\components\rtl\external\Expr\ExprMake.pas',
  ObjectSegment_Const in 'w:\common\components\rtl\Garant\EVD\ObjectSegment_Const.pas',
  nevParaTools in 'w:\common\components\gui\Garant\Everest\nevParaTools.pas',
  evFormula_Wrap in 'w:\common\components\gui\Garant\Everest\evFormula_Wrap.pas',
  evHugeParaListPrim in 'w:\common\components\rtl\Garant\EVD\evHugeParaListPrim.pas',
  evHugeParaListPrimWithFind in 'w:\common\components\rtl\Garant\EVD\evHugeParaListPrimWithFind.pas',
  evHugeParaList in 'w:\common\components\rtl\Garant\EVD\evHugeParaList.pas',
  evBaseDocument in 'w:\common\components\rtl\Garant\EVD\evBaseDocument.pas',
  evDocument_Wrap in 'w:\common\components\gui\Garant\Everest\evDocument_Wrap.pas',
  evReqRow_Wrap in 'w:\common\components\gui\Garant\Everest\evReqRow_Wrap.pas',
  TreePara_Const in 'w:\common\components\gui\Garant\Everest\TreePara_Const.pas',
  evTreePara_Wrap in 'w:\common\components\gui\Garant\Everest\evTreePara_Wrap.pas',
  CommentPara_Const in 'w:\common\components\gui\Garant\Everest\CommentPara_Const.pas',
  evCommentPara_Wrap in 'w:\common\components\gui\Garant\Everest\evCommentPara_Wrap.pas',
  evReqGroup_Wrap in 'w:\common\components\gui\Garant\Everest\evReqGroup_Wrap.pas',
  nevLeafPara in 'w:\common\components\gui\Garant\Everest\new\nevLeafPara.pas',
  k2TagPointer in 'w:\common\components\rtl\Garant\K2\k2TagPointer.pas',
  k2TagTool in 'w:\common\components\rtl\Garant\K2\k2TagTool.pas',
  nevParaPrim in 'w:\common\components\gui\Garant\Everest\new\nevParaPrim.pas',
  nevPara in 'w:\common\components\gui\Garant\Everest\new\nevPara.pas',
  evLeafParaFormatter in 'w:\common\components\gui\Garant\Everest\evLeafParaFormatter.pas',
  nevRealTools in 'w:\common\components\gui\Garant\Everest\new\nevRealTools.pas',
  evLeafParaPainter in 'w:\common\components\gui\Garant\Everest\evLeafParaPainter.pas',
  nevTextPara in 'w:\common\components\gui\Garant\Everest\new\nevTextPara.pas',
  nevTextParaFormatter in 'w:\common\components\gui\Garant\Everest\nevTextParaFormatter.pas',
  evTextParaPainterEx in 'w:\common\components\gui\Garant\Everest\evTextParaPainterEx.pas',
  evTextParaPainter in 'w:\common\components\gui\Garant\Everest\evTextParaPainter.pas',
  evTextParaPainterPrim in 'w:\common\components\gui\Garant\Everest\evTextParaPainterPrim.pas',
  evTextParaCursor in 'w:\common\components\gui\Garant\Everest\evTextParaCursor.pas',
  evLocationBase in 'w:\common\components\gui\Garant\Everest\evLocationBase.pas',
  evCursor in 'w:\common\components\gui\Garant\Everest\evCursor.pas',
  evParaCursor in 'w:\common\components\gui\Garant\Everest\evParaCursor.pas',
  evLeafParaCursor in 'w:\common\components\gui\Garant\Everest\evLeafParaCursor.pas',
  evLocation in 'w:\common\components\gui\Garant\Everest\evLocation.pas',
  nevControlPara in 'w:\common\components\gui\Garant\Everest\new\nevControlPara.pas',
  evControlParaFormatter in 'w:\common\components\gui\Garant\Everest\evControlParaFormatter.pas',
  evControlParaPainter in 'w:\common\components\gui\Garant\Everest\evControlParaPainter.pas',
  nevFormulaPara in 'w:\common\components\gui\Garant\Everest\new\nevFormulaPara.pas',
  evFormulaFormatter in 'w:\common\components\gui\Garant\Everest\evFormulaFormatter.pas',
  evFormulaPainter in 'w:\common\components\gui\Garant\Everest\evFormulaPainter.pas',
  evParaListCursor in 'w:\common\components\gui\Garant\Everest\evParaListCursor.pas',
  evParaListCursorPrim in 'w:\common\components\gui\Garant\Everest\evParaListCursorPrim.pas',
  evParaListCursorInsertable in 'w:\common\components\gui\Garant\Everest\evParaListCursorInsertable.pas',
  evParaListCursorDeletable in 'w:\common\components\gui\Garant\Everest\evParaListCursorDeletable.pas',
  evParaListPainter in 'w:\common\components\gui\Garant\Everest\evParaListPainter.pas',
  nevParaList in 'w:\common\components\gui\Garant\Everest\new\nevParaList.pas',
  evParaListFormatter in 'w:\common\components\gui\Garant\Everest\evParaListFormatter.pas',
  evDocumentPartCursor in 'w:\common\components\gui\Garant\Everest\evDocumentPartCursor.pas',
  evDocumentPartPainter in 'w:\common\components\gui\Garant\Everest\evDocumentPartPainter.pas',
  evDocumentPartFormatter in 'w:\common\components\gui\Garant\Everest\evDocumentPartFormatter.pas',
  evDocumentCursor in 'w:\common\components\gui\Garant\Everest\evDocumentCursor.pas',
  evDocumentPainter in 'w:\common\components\gui\Garant\Everest\evDocumentPainter.pas',
  evDocumentFormatter in 'w:\common\components\gui\Garant\Everest\evDocumentFormatter.pas',
  evTableCellPainter in 'w:\common\components\gui\Garant\Everest\evTableCellPainter.pas',
  nevTableCell in 'w:\common\components\gui\Garant\Everest\new\nevTableCell.pas',
  evTableRowPainter in 'w:\common\components\gui\Garant\Everest\evTableRowPainter.pas',
  nevTableRow in 'w:\common\components\gui\Garant\Everest\new\nevTableRow.pas',
  evTableRowFormatter in 'w:\common\components\gui\Garant\Everest\evTableRowFormatter.pas',
  evSBSCellPainter in 'w:\common\components\gui\Garant\Everest\evSBSCellPainter.pas',
  evTablePainter in 'w:\common\components\gui\Garant\Everest\evTablePainter.pas',
  evFramedParaListPainter in 'w:\common\components\gui\Garant\Everest\evFramedParaListPainter.pas',
  evTableFormatter in 'w:\common\components\gui\Garant\Everest\evTableFormatter.pas',
  QueryCard_Const in 'w:\common\components\gui\Garant\Everest\QueryCard_Const.pas',
  evControlsBlockConst in 'w:\common\components\gui\Garant\Everest\evControlsBlockConst.pas',
  ControlsBlock_Const in 'w:\common\components\gui\Garant\Everest\ControlsBlock_Const.pas',
  evControlsBlockPainter in 'w:\common\components\gui\Garant\Everest\evControlsBlockPainter.pas',
  nevControlsBlock in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlock.pas',
  evBitmapParaFormatter in 'w:\common\components\gui\Garant\Everest\evBitmapParaFormatter.pas',
  evBitmapParaPainter in 'w:\common\components\gui\Garant\Everest\evBitmapParaPainter.pas',
  evBitmapParaCursor in 'w:\common\components\gui\Garant\Everest\evBitmapParaCursor.pas',
  evSolidParaCursor in 'w:\common\components\gui\Garant\Everest\evSolidParaCursor.pas',
  evCommentParaCursor in 'w:\common\components\gui\Garant\Everest\evCommentParaCursor.pas',
  evCommentParaPainter in 'w:\common\components\gui\Garant\Everest\evCommentParaPainter.pas',
  evCommentParaFormatter in 'w:\common\components\gui\Garant\Everest\evCommentParaFormatter.pas',
  SBS_Const in 'w:\common\components\gui\Garant\Everest\SBS_Const.pas',
  evSBSRowFormatter in 'w:\common\components\gui\Garant\Everest\evSBSRowFormatter.pas',
  nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas',
  evReqGroup_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqGroup_InterfaceFactory.pas'
  {$If defined(evReqGroupNeedsRadio)}
  ,
  evReqGroupHotSpotTester in 'w:\common\components\gui\Garant\Everest\evReqGroupHotSpotTester.pas'
  {$IfEnd} //evReqGroupNeedsRadio
  ,
  k2ProcTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcTagTool.pas',
  evHotSpot in 'w:\common\components\gui\Garant\Everest\evHotSpot.pas',
  evParaListHotSpotTester in 'w:\common\components\gui\Garant\Everest\evParaListHotSpotTester.pas'
  {$If defined(evReqGroupNeedsRadio)}
  ,
  evReqGroupPainter in 'w:\common\components\gui\Garant\Everest\evReqGroupPainter.pas'
  {$IfEnd} //evReqGroupNeedsRadio
  ,
  AutoreferatDocument_Const in 'w:\common\components\gui\Garant\Everest\AutoreferatDocument_Const.pas',
  evAutoreferatDocument_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evAutoreferatDocument_InterfaceFactory.pas',
  nevAutoreferatDocumentAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAutoreferatDocumentAnchor.pas',
  nevAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAnchor.pas',
  nevParaListAnchor in 'w:\common\components\gui\Garant\Everest\new\nevParaListAnchor.pas',
  evdBasePara in 'w:\common\components\rtl\Garant\EVD\evdBasePara.pas',
  evBitmapPara in 'w:\common\components\rtl\Garant\EVD\evBitmapPara.pas',
  evTreePara in 'w:\common\components\rtl\Garant\EVD\evTreePara.pas',
  DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas',
  DictEntry_Const in 'w:\common\components\gui\Garant\Everest\DictEntry_Const.pas',
  AnnoTopic_Const in 'w:\common\components\gui\Garant\Everest\AnnoTopic_Const.pas',
  XML_Const in 'w:\common\components\gui\Garant\Everest\XML_Const.pas',
  ExtDataPara_Const in 'w:\common\components\gui\Garant\Everest\ExtDataPara_Const.pas',
  AttrValue_Const in 'w:\common\components\gui\Garant\Everest\AttrValue_Const.pas',
  Attr_Const in 'w:\common\components\gui\Garant\Everest\Attr_Const.pas',
  TagName_Const in 'w:\common\components\gui\Garant\Everest\TagName_Const.pas',
  TagBody_Const in 'w:\common\components\gui\Garant\Everest\TagBody_Const.pas',
  nevFacade in 'w:\common\components\gui\Garant\Everest\new\nevFacade.pas',
  TinyDocument_Const in 'w:\common\components\gui\Garant\Everest\TinyDocument_Const.pas',
  LeafParaDecorationsHolder_Const in 'w:\common\components\gui\Garant\Everest\LeafParaDecorationsHolder_Const.pas',
  Bookmark_Const in 'w:\common\components\rtl\Garant\EVD\Bookmark_Const.pas',
  Mark_Const in 'w:\common\components\rtl\Garant\EVD\Mark_Const.pas',
  evNative_Schema in 'w:\common\components\gui\Garant\Everest\evNative_Schema.pas',
  evStyleInterfaceEx in 'w:\common\components\gui\Garant\Everest\evStyleInterfaceEx.pas',
  StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas',
  TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas',
  evPageBreakFormatter in 'w:\common\components\gui\Garant\Everest\evPageBreakFormatter.pas',
  evPageBreakPainter in 'w:\common\components\gui\Garant\Everest\evPageBreakPainter.pas',
  evBreakParaCursor in 'w:\common\components\gui\Garant\Everest\evBreakParaCursor.pas',
  evSectionBreakFormatter in 'w:\common\components\gui\Garant\Everest\evSectionBreakFormatter.pas',
  evSectionBreakPainter in 'w:\common\components\gui\Garant\Everest\evSectionBreakPainter.pas',
  evStdInt in 'w:\common\components\gui\Garant\Everest\evStdInt.pas',
  evBaseParaFormatter in 'w:\common\components\gui\Garant\Everest\evBaseParaFormatter.pas',
  //evParaPainter in 'w:\common\components\gui\Garant\Everest\evParaPainter.pas',
  k2ParentedTagObject in 'w:\common\components\rtl\Garant\K2\k2ParentedTagObject.pas',
  k2DictItem in 'w:\common\components\rtl\Garant\K2\k2DictItem.pas',
  k2Layer in 'w:\common\components\rtl\Garant\K2\k2Layer.pas',
  evBaseSegment in 'w:\common\components\rtl\Garant\EVD\evBaseSegment.pas',
  evHyperTextSegment in 'w:\common\components\rtl\Garant\EVD\evHyperTextSegment.pas',
  HyperLink_Const in 'w:\common\components\rtl\Garant\EVD\HyperLink_Const.pas',
  //evdNativeObjectSegmentClass in 'w:\common\components\rtl\Garant\EVD\evdNativeObjectSegmentClass.pas',
  evdSegmentsLayer in 'w:\common\components\rtl\Garant\EVD\evdSegmentsLayer.pas',
  evdNative_Schema in 'w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas',
  Address_Const in 'w:\common\components\rtl\Garant\EVD\Address_Const.pas',
  Document_Const in 'w:\common\components\gui\Garant\Everest\Document_Const.pas',
  evStringStorable in 'w:\common\components\gui\Garant\Everest\evStringStorable.pas',
  evNodeStorable in 'w:\common\components\gui\Garant\Everest\evNodeStorable.pas',
  l3DataObjectEnum in 'w:\common\components\rtl\Garant\L3\l3DataObjectEnum.pas',
  ShlObj in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShlObj.pas',
  l3DataObject in 'w:\common\components\rtl\Garant\L3\l3DataObject.pas',
  l3StorableDataObject in 'w:\common\components\rtl\Garant\L3\l3StorableDataObject.pas',
  evDataObject in 'w:\common\components\gui\Garant\Everest\evDataObject.pas',
  k2InternalInterfaces in 'w:\common\components\rtl\Garant\K2\k2InternalInterfaces.pas',
  evPersistentDataObject in 'w:\common\components\gui\Garant\Everest\evPersistentDataObject.pas',
  k2TagGen in 'w:\common\components\rtl\Garant\K2\k2TagGen.pas',
  evDocumentPreviewInfoList in 'w:\common\components\gui\Garant\Everest\new\evDocumentPreviewInfoList.pas',
  nevWaiterList in 'w:\common\components\gui\Garant\Everest\new\nevWaiterList.pas',
  nevInternalInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInternalInterfaces.pas',
  k2BaseStackGenerator in 'w:\common\components\rtl\Garant\K2\k2BaseStackGenerator.pas',
  k2DocumentGenerator in 'w:\common\components\rtl\Garant\K2\k2DocumentGenerator.pas',
  evHighLevelDocumentGenerator in 'w:\common\components\gui\Garant\Everest\evHighLevelDocumentGenerator.pas',
  evGeneratorsInterfaces in 'w:\common\components\gui\Garant\Everest\evGeneratorsInterfaces.pas',
  evDocumentPartGeneratorPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPartGeneratorPrim.pas',
  evDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest\evDocumentPartGenerator.pas',
  l3NotifyPtrList in 'w:\common\components\rtl\Garant\L3\l3NotifyPtrList.pas',
  l3InterfacePtrList in 'w:\common\components\rtl\Garant\L3\l3InterfacePtrList.pas',
  evStyleInterface in 'w:\common\components\gui\Garant\Everest\evStyleInterface.pas',
  evResultFont in 'w:\common\components\gui\Garant\Everest\evResultFont.pas',
  evStyleTableSpy in 'w:\common\components\gui\Garant\Everest\evStyleTableSpy.pas',
  l3CProtoObject in 'w:\common\components\rtl\Garant\L3\l3CProtoObject.pas',
  nevFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfo.pas',
  nevFormatInfoList in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoList.pas',
  nevFormatInfoArray in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoArray.pas',
  nevLeafRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevLeafRenderInfo.pas',
  evSegLst in 'w:\common\components\gui\Garant\Everest\evSegLst.pas',
  nevTextParaRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTextParaRenderInfo.pas',
  evConst in 'w:\common\components\gui\Garant\Everest\evConst.pas',
  Math in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas',
  l3UnitsTools in 'w:\common\components\rtl\Garant\L3\l3UnitsTools.pas',
  evTableCellUtils in 'w:\common\components\gui\Garant\Everest\evTableCellUtils.pas',
  nevTableRowRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas',
  nevRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevRubberCellsRenderInfo.pas',
  nevTableCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas',
  nevZoomedCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedCellsRenderInfo.pas',
  nevZoomedRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedRubberCellsRenderInfo.pas',
  evSectionPara in 'w:\common\components\gui\Garant\Everest\new\evSectionPara.pas',
  nevListFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevListFormatInfo.pas',
  nevFormatPoolBase in 'w:\common\components\gui\Garant\Everest\new\nevFormatPoolBase.pas',
  Printers in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Printers.pas',
  l3ScreenIC in 'w:\common\components\rtl\Garant\L3\l3ScreenIC.pas',
  Consts in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas',
  l3Printer in 'w:\common\components\rtl\Garant\L3\l3Printer.pas',
  l3PrinterIC in 'w:\common\components\rtl\Garant\L3\l3PrinterIC.pas',
  nevRootFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevRootFormatInfo.pas',
  nevRootFormatInfoListPrim in 'w:\common\components\gui\Garant\Everest\new\nevRootFormatInfoListPrim.pas',
  nevFormatPool in 'w:\common\components\gui\Garant\Everest\new\nevFormatPool.pas',
  nevSectionBreakListPrim in 'w:\common\components\gui\Garant\Everest\nevSectionBreakListPrim.pas',
  nevSectionBreakList in 'w:\common\components\gui\Garant\Everest\nevSectionBreakList.pas',
  nevDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrim.pas',
  nevObjectHolderPrim in 'w:\common\components\gui\Garant\Everest\nevObjectHolderPrim.pas',
  nevInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInterfaces.pas',
  nevTextSourcePool in 'w:\common\components\gui\Garant\Everest\new\nevTextSourcePool.pas',
  afwPreviewNotifierPtrList in 'w:\common\components\gui\Garant\AFW\implementation\afwPreviewNotifierPtrList.pas',
  afwComplexDocumentPreview in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreview.pas',
  afwComplexDocumentPreviewFactory in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreviewFactory.pas',
  evSubImplementation in 'w:\common\components\gui\Garant\Everest\new\evSubImplementation.pas',
  evSubNode in 'w:\common\components\gui\Garant\Everest\new\evSubNode.pas',
  evNode in 'w:\common\components\gui\Garant\Everest\new\evNode.pas',
  l3Bits in 'w:\common\components\rtl\Garant\L3\l3Bits.pas',
  nevDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainer.pas',
  evOpProc in 'w:\common\components\gui\Garant\Everest\evOpProc.pas',
  evDefaultContext in 'w:\common\components\gui\Garant\Everest\evDefaultContext.pas',
  evDocumentContainerWithProcessor in 'w:\common\components\gui\Garant\Everest\new\evDocumentContainerWithProcessor.pas',
  k2CustomStackGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomStackGenerator.pas',
  k2CustomReader in 'w:\common\components\rtl\Garant\K2\k2CustomReader.pas',
  nevPersistentDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPersistentDocumentContainer.pas',
  k2CustomFileReader in 'w:\common\components\rtl\Garant\K2\k2CustomFileReader.pas',
  evCustomTxtReader in 'w:\common\components\gui\Garant\Everest\evCustomTxtReader.pas',
  k2CustomFileParser in 'w:\common\components\rtl\Garant\K2\k2CustomFileParser.pas',
  evdNativeReader in 'w:\common\components\rtl\Garant\EVD\evdNativeReader.pas',
  k2CustomStackGeneratorEx in 'w:\common\components\rtl\Garant\K2\k2CustomStackGeneratorEx.pas',
  k2CustomFileGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomFileGenerator.pas',
  evdDocumentFilter in 'w:\common\components\rtl\Garant\EVD\evdDocumentFilter.pas',
  evCustomTextFormatter in 'w:\common\components\gui\Garant\Everest\evCustomTextFormatter.pas',
  evTextFormatter in 'w:\common\components\gui\Garant\Everest\evTextFormatter.pas',
  evdCustomPlainTextWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomPlainTextWriter.pas',
  evdPlainTextWriter in 'w:\common\components\rtl\Garant\EVD\evdPlainTextWriter.pas',
  evdCustomNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriter.pas',
  evdNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeWriter.pas',
  evMergedCellFilter in 'w:\common\components\gui\Garant\Everest\evMergedCellFilter.pas',
  ShellAPI in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShellAPI.pas',
  evCustomWikiReader in 'w:\common\components\gui\Garant\Everest\evCustomWikiReader.pas',
  evPersistentDataObjectEx in 'w:\common\components\gui\Garant\Everest\evPersistentDataObjectEx.pas',
  evFormats in 'w:\common\components\gui\Garant\Everest\evFormats.pas',
  evNodeDataObject in 'w:\common\components\gui\Garant\Everest\evNodeDataObject.pas',
  l3TreeConst in 'w:\common\components\rtl\Garant\L3\l3TreeConst.pas',
  ddRTFWriter in 'w:\common\components\rtl\Garant\dd\ddRTFWriter.pas',
  evNodeData in 'w:\common\components\gui\Garant\EverestCommon\evNodeData.pas',
  FoldersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FoldersUnit.pas',
  DocumentUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DocumentUnit.pas'
  {$If defined(Nemesis) AND not defined(DesignTimeLibrary)}
  ,
  nsNodeStorable in 'w:\common\components\gui\Garant\Nemesis\Tree\nsNodeStorable.pas'
  {$IfEnd} //Nemesis AND not DesignTimeLibrary
  
  {$If defined(Nemesis) AND not defined(DesignTimeLibrary)}
  ,
  nsNodeDataObject in 'w:\common\components\gui\Garant\Nemesis\Tree\nsNodeDataObject.pas'
  {$IfEnd} //Nemesis AND not DesignTimeLibrary
  
  {$If defined(Nemesis) AND not defined(DesignTimeLibrary)}
  ,
  nsEntitiesTreeDataObject in 'w:\common\components\gui\Garant\Nemesis\Tree\nsEntitiesTreeDataObject.pas'
  {$IfEnd} //Nemesis AND not DesignTimeLibrary
  ,
  nscTreeViewRes in 'w:\common\components\gui\Garant\Nemesis\nscTreeViewRes.pas',
  OfficeLike_Tree_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Tree_Controls.pas',
  nscTreeView in 'w:\common\components\gui\Garant\Nemesis\nscTreeView.pas',
  nscContextFilterRes in 'w:\common\components\gui\Garant\Nemesis\nscContextFilterRes.pas',
  nscContextFilter in 'w:\common\components\gui\Garant\Nemesis\nscContextFilter.pas',
  SearchLite_Strange_Controls in 'View\SearchLite_Strange_Controls.pas',
  PrimTreeAttributeSelect_astNone_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas',
  PrimTreeAttributeSelect_astOneLevel_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astOneLevel_UserType.pas',
  PrimTreeAttributeSelect_astFirstLevel_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astFirstLevel_UserType.pas',
  nscContextFilterState in 'w:\common\components\gui\Garant\Nemesis\nscContextFilterState.pas',
  PrimTreeAttributeSelect_astTaxesPublishSearch_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas',
  DynamicTreeDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeDefinesUnit.pas',
  nsLogicOperationToFlags in 'Tree\nsLogicOperationToFlags.pas',
  nsINodeWrapBase in 'Data\Tree\nsINodeWrapBase.pas',
  nsRootManager in 'Data\Tree\nsRootManager.pas',
  nsINodeWrap in 'Data\Tree\nsINodeWrap.pas',
  nsINodeRootWrap in 'Data\Tree\nsINodeRootWrap.pas',
  nsTreeStruct in 'Data\Tree\nsTreeStruct.pas',
  l3TreeFilters in 'w:\common\components\rtl\Garant\L3\l3TreeFilters.pas',
  SecurityUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SecurityUnit.pas',
  nsAdapterFilters in 'Data\Tree\nsAdapterFilters.pas',
  bsConvert in 'Data\Common\bsConvert.pas',
  Il3ContextFilterParamsNotifierPtrList in 'Data\Tree\Il3ContextFilterParamsNotifierPtrList.pas',
  nsContextFilterParams in 'Data\Tree\nsContextFilterParams.pas',
  nsFilterableTreeStruct in 'Data\Tree\nsFilterableTreeStruct.pas',
  nsDataResetTreeStruct in 'Data\Tree\nsDataResetTreeStruct.pas',
  nsINodeOneLevelWrap in 'Data\Tree\nsINodeOneLevelWrap.pas',
  nsINodeOneLevelRootWrap in 'Data\Tree\nsINodeOneLevelRootWrap.pas',
  nsOneLevelTreeStruct in 'Data\Tree\nsOneLevelTreeStruct.pas',
  DynamicDocListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicDocListUnit.pas',
  bsUtils in 'Data\Common\bsUtils.pas',
  nsAttributeTreeFilters in 'Data\Search\nsAttributeTreeFilters.pas',
  l3InterfacedStringList in 'w:\common\components\rtl\Garant\L3\l3InterfacedStringList.pas',
  nsAttributeTreeCacheNew in 'Data\Search\nsAttributeTreeCacheNew.pas',
  nsAttributeOneLevelTreeStruct in 'Data\Search\nsAttributeOneLevelTreeStruct.pas',
  nsAttrBranchStruct in 'Data\Search\nsAttrBranchStruct.pas',
  PrimTreeAttributeSelect_Form in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_Form.pas',
  PrimTreeAttributeSelectOptions_Form in 'View\LiteSearch\Forms\PrimTreeAttributeSelectOptions_Form.pas',
  PrimSelectedAttributes_utSelectedAttributes_UserType in 'View\LiteSearch\Forms\PrimSelectedAttributes_utSelectedAttributes_UserType.pas',
  nsTreeAttributeNodesNew in 'View\LiteSearch\nsTreeAttributeNodesNew.pas',
  PrimSelectedAttributes_Form in 'View\LiteSearch\Forms\PrimSelectedAttributes_Form.pas',
  PrimSelectedAttributesOptions_Form in 'View\LiteSearch\Forms\PrimSelectedAttributesOptions_Form.pas',
  nsQueryInterfaces in 'Search\nsQueryInterfaces.pas',
  OfficeLike_ResultEx_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_ResultEx_Controls.pas',
  PrimAttributeSelect_utAttributeSelect_UserType in 'View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas',
  PrimAttributeSelect_utSingleSearch_UserType in 'View\LiteSearch\Forms\PrimAttributeSelect_utSingleSearch_UserType.pas',
  nsQueryUtils in 'Data\Common\nsQueryUtils.pas',
  OldTreeInterfaces in 'Model\OldTreeInterfaces.pas',
  nsWrapperNode in 'Data\Tree\nsWrapperNode.pas',
  l3VirtualNode in 'w:\common\components\rtl\Garant\L3\l3VirtualNode.pas',
  eeVirtualNode in 'w:\common\components\gui\Garant\Everest_Engine\eeVirtualNode.pas',
  nsPrimNode in 'Data\Tree\nsPrimNode.pas',
  nsPrimAdapterNode in 'Data\Tree\nsPrimAdapterNode.pas',
  nsPrimCacheableNode in 'Data\Tree\nsPrimCacheableNode.pas',
  nsBaseNode in 'Data\Tree\nsBaseNode.pas',
  nsNodes in 'Data\Tree\nsNodes.pas',
  nsQuery in 'View\LiteSearch\nsQuery.pas',
  PrimAttributeSelect_Form in 'View\LiteSearch\Forms\PrimAttributeSelect_Form.pas',
  PrimAttributeSelectOptions_Form in 'View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas',
  SearchLite_FormDefinitions_Controls in 'View\SearchLite_FormDefinitions_Controls.pas',
  TreeAttributeSelect_Form in 'View\LiteSearch\Forms\TreeAttributeSelect_Form.pas' {efTreeAttributeSelect: TvcmEntityForm},
  AttributeSelect_Form in 'View\LiteSearch\Forms\AttributeSelect_Form.pas' {cfAttributeSelect: TvcmEntityForm},
  SelectedAttributes_Form in 'View\LiteSearch\Forms\SelectedAttributes_Form.pas' {enSelectedAttributes: TvcmEntityForm},
  LiteSearch_Module in 'View\LiteSearch\LiteSearch_Module.pas',
  moLiteSearch in 'View\LiteSearch\moLiteSearch.pas' {mo_LiteSearch: TvcmModule},
  vtLabel in 'w:\common\components\gui\Garant\VT\vtLabel.pas',
  PrimShutDown_sftNone_UserType in 'View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas',
  PrimShutDown_Form in 'View\PrimCommon\Forms\PrimShutDown_Form.pas',
  PrimLogin_Form in 'View\PrimCommon\Forms\PrimLogin_Form.pas',
  PrimLongProcess_Form in 'View\PrimCommon\Forms\PrimLongProcess_Form.pas',
  ElPgCtl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtl.pas',
  nscFormsPageControl in 'w:\common\components\gui\Garant\Nemesis\nscFormsPageControl.pas',
  PrimChild_cutUsual_UserType in 'View\PrimCommon\Forms\PrimChild_cutUsual_UserType.pas',
  PrimChild_cutForDiction_UserType in 'View\PrimCommon\Forms\PrimChild_cutForDiction_UserType.pas',
  PrimChild_Form in 'View\PrimCommon\Forms\PrimChild_Form.pas',
  F1_Application_Template_FormDefinitions_Controls in 'View\F1_Application_Template_FormDefinitions_Controls.pas',
  ShutDown_Form in 'View\PrimCommon\Forms\ShutDown_Form.pas' {ShutDownForm: TvcmEntityForm},
  Login_Form in 'View\PrimCommon\Forms\Login_Form.pas' {LoginForm: TvcmEntityForm},
  LongProcess_Form in 'View\PrimCommon\Forms\LongProcess_Form.pas' {LongProcessForm: TvcmEntityForm},
  Parent_Form in 'View\PrimCommon\Forms\Parent_Form.pas' {ParentForm: TvcmEntityForm},
  Child_Form in 'View\PrimCommon\Forms\Child_Form.pas' {ChildForm: TvcmEntityForm},
  PrimCommon_Module in 'View\PrimCommon\PrimCommon_Module.pas',
  moRealCommon in 'View\PrimCommon\moRealCommon.pas' {mo_RealCommon: TvcmModule},
  vtStdRes in 'w:\common\components\gui\Garant\VT\vtStdRes.pas' {vtStdResources: TDataModule},
  nsStartupSupport in 'Data\Common\nsStartupSupport.pas',
  SearchDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchDefinesUnit.pas',
  SearchProgressIndicatorUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchProgressIndicatorUnit.pas',
  DebugStr in 'Data\Common\DebugStr.pas',
  f1TextStyle_Const in 'w:\common\components\gui\Garant\Everest_Engine\f1TextStyle_Const.pas',
  eeDocument_Schema in 'w:\common\components\gui\Garant\Everest_Engine\eeDocument_Schema.pas',
  F1_Schema in 'w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas',
  SettingsUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SettingsUnit.pas',
  IafwSettingListenerPtrList in 'w:\common\components\gui\Garant\AFW\implementation\IafwSettingListenerPtrList.pas',
  IafwSettingsReplaceListenerPtrList in 'w:\common\components\gui\Garant\AFW\implementation\IafwSettingsReplaceListenerPtrList.pas',
  InsUserSettingsListenerPtrList in 'Data\Settings\InsUserSettingsListenerPtrList.pas',
  InsUserSettingsEditListenerPtrList in 'Data\Settings\InsUserSettingsEditListenerPtrList.pas',
  l3CastableStrings in 'w:\common\components\rtl\Garant\L3\l3CastableStrings.pas',
  l3VCLStringsItems in 'w:\common\components\rtl\Garant\L3\l3VCLStringsItems.pas',
  l3VCLStrings in 'w:\common\components\rtl\Garant\L3\l3VCLStrings.pas',
  vcmStringList in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringList.pas',
  nsSettings in 'Data\Settings\nsSettings.pas',
  nsContextFilterEventDataList in 'Data\nsContextFilterEventDataList.pas',
  nsContextFilterEventListener in 'Data\nsContextFilterEventListener.pas',
  evdSchema in 'w:\common\components\gui\Garant\Everest\evdSchema.pas',
  PrimF1Res in 'View\PrimF1Res.pas',
  PrimMain_Form in 'View\PrimMain_Form.pas',
  vtNavigator in 'w:\common\components\gui\Garant\VT\vtNavigator.pas',
  nsConst in 'Data\Common\nsConst.pas',
  PrimMainOptions_Form in 'View\PrimMainOptions_Form.pas',
  ShellAndMonitoringsMain_Form in 'View\ShellAndMonitoringsMain_Form.pas',
  Search_Strange_Controls in 'View\Search_Strange_Controls.pas',
  eeInterfaces in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas',
  ConfigInterfaces in 'Model\ConfigInterfaces.pas',
  afwCustomCommonControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControlPrim.pas',
  afwCustomCommonControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControl.pas',
  vtCustomPreviewPanel in 'w:\common\components\gui\Garant\VT\vtCustomPreviewPanel.pas',
  eePreviewPanel in 'w:\common\components\gui\Garant\Everest_Engine\eePreviewPanel.pas',
  nscPreviewPanel in 'w:\common\components\gui\Garant\Nemesis\nscPreviewPanel.pas',
  PrimPreview_utPrintPreview_UserType in 'View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas',
  nsTrialSupport in 'View\nsTrialSupport.pas',
  PrimPreview_Form in 'View\Search\Forms\PrimPreview_Form.pas',
  Search_FormDefinitions_Controls in 'View\Search_FormDefinitions_Controls.pas',
  vtComboBoxQS in 'w:\common\components\gui\Garant\VT\vtComboBoxQS.pas',
  PrimPrintDialog_Form in 'View\Search\Forms\PrimPrintDialog_Form.pas',
  eeCheckBox in 'w:\common\components\gui\Garant\Everest_Engine\eeCheckBox.pas',
  evCustomTextSource in 'w:\common\components\gui\Garant\Everest\evCustomTextSource.pas',
  nevBasePointList in 'w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas',
  afwCustomCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCaretType.pas',
  afwSingleCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwSingleCaret.pas',
  afwInsCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInsCaretType.pas',
  afwOvrCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwOvrCaretType.pas',
  afwCaretPair in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaretPair.pas',
  afwCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaret.pas',
  evCursorController in 'w:\common\components\gui\Garant\Everest\evCursorController.pas',
  evWindowCursor in 'w:\common\components\gui\Garant\Everest\evWindowCursor.pas',
  evEditorInterfacesMisc in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesMisc.pas',
  evBitmapReader in 'w:\common\components\gui\Garant\Everest\evBitmapReader.pas',
  //k2TagTools in 'w:\common\components\rtl\Garant\K2\k2TagTools.pas',
  evParaFrame in 'w:\common\components\gui\Garant\Everest\evParaFrame.pas',
  evUsialParagraph in 'w:\common\components\gui\Garant\Everest\evUsialParagraph.pas',
  evRange in 'w:\common\components\gui\Garant\Everest\evRange.pas',
  evBlockCursor in 'w:\common\components\gui\Garant\Everest\evBlockCursor.pas',
  evSelectConst in 'w:\common\components\gui\Garant\Everest\evSelectConst.pas',
  nevSelection in 'w:\common\components\gui\Garant\Everest\nevSelection.pas',
  l3Tool in 'w:\common\components\rtl\Garant\L3\l3Tool.pas',
  evEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evEditorWindowHotSpot.pas',
  nevControl in 'w:\common\components\gui\Garant\Everest\nevControl.pas',
  evCustomEditorWindowPrim in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowPrim.pas',
  nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas'
  {$If defined(nsTest)}
  ,
  nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas'
  {$IfEnd} //nsTest
  ,
  nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas',
  nevBaseView in 'w:\common\components\gui\Garant\Everest\new\nevBaseView.pas',
  nevObjectList in 'w:\common\components\gui\Garant\Everest\new\nevObjectList.pas',
  nevBaseDrawView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDrawView.pas',
  nevView in 'w:\common\components\gui\Garant\Everest\new\nevView.pas',
  evCustomEditorWindow in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindow.pas',
  evCustomEditorWindowModelPart in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowModelPart.pas',
  nevRangeList in 'w:\common\components\gui\Garant\Everest\new\nevRangeList.pas',
  evMultiSelectionLocation in 'w:\common\components\gui\Garant\Everest\evMultiSelectionLocation.pas',
  evLeafParaMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evLeafParaMultiSelectionBlock.pas',
  k2DocumentBuffer in 'w:\common\components\rtl\Garant\K2\k2DocumentBuffer.pas',
  evdSegmentsLayerJoiner in 'w:\common\components\rtl\Garant\EVD\evdSegmentsLayerJoiner.pas',
  evTextParaPartFilter in 'w:\common\components\gui\Garant\Everest\evTextParaPartFilter.pas',
  evTextParaMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evTextParaMultiSelectionBlock.pas',
  evMultiSelectionRange in 'w:\common\components\gui\Garant\Everest\evMultiSelectionRange.pas',
  evMultiSelectionDataFormatting in 'w:\common\components\gui\Garant\Everest\evMultiSelectionDataFormatting.pas',
  evMultiSelectionText in 'w:\common\components\gui\Garant\Everest\evMultiSelectionText.pas',
  evMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evMultiSelectionBlock.pas',
  evRangeTools in 'w:\common\components\gui\Garant\Everest\new\evRangeTools.pas',
  nevRangeListTools in 'w:\common\components\gui\Garant\Everest\new\nevRangeListTools.pas',
  evMultiSelection in 'w:\common\components\gui\Garant\Everest\evMultiSelection.pas',
  evMultiSelectEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evMultiSelectEditorWindowHotSpot.pas',
  evMultiSelectEditorWindow in 'w:\common\components\gui\Garant\Everest\evMultiSelectEditorWindow.pas',
  evCustomEditorModelPart in 'w:\common\components\gui\Garant\Everest\evCustomEditorModelPart.pas',
  evCustomEditor in 'w:\common\components\gui\Garant\Everest\evCustomEditor.pas',
  evEditorWithOperations in 'w:\common\components\gui\Garant\Everest\evEditorWithOperations.pas',
  evTextSource in 'w:\common\components\gui\Garant\Everest\evTextSource.pas',
  l3BaseWithLargeIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDListPrim.pas',
  l3BaseWithLargeIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDList.pas',
  afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas',
  l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas',
  l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas'
  {$If defined(nsTest)}
  ,
  afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
  {$IfEnd} //nsTest
  ,
  afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas',
  afwPreviewCanvas in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewCanvas.pas',
  l3TimeEstimation in 'w:\common\components\rtl\Garant\L3\l3TimeEstimation.pas',
  afwCanvasEx in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCanvasEx.pas',
  nevBaseDetachedView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDetachedView.pas',
  nevPrintView in 'w:\common\components\gui\Garant\Everest\new\nevPrintView.pas',
  l3Prg in 'w:\common\components\rtl\Garant\L3\l3Prg.pas',
  evAbortFilter in 'w:\common\components\gui\Garant\Everest\evAbortFilter.pas',
  k2TagTerminator in 'w:\common\components\rtl\Garant\K2\k2TagTerminator.pas',
  k2TagFilter in 'w:\common\components\rtl\Garant\K2\k2TagFilter.pas',
  evdLeafParaFilter in 'w:\common\components\rtl\Garant\EVD\evdLeafParaFilter.pas',
  evCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evCommentsEliminator.pas',
  evHiddenFilter in 'w:\common\components\gui\Garant\Everest\evHiddenFilter.pas',
  evdPageParamsFilter in 'w:\common\components\rtl\Garant\EVD\evdPageParamsFilter.pas',
  evNotifiedProcessor in 'w:\common\components\gui\Garant\Everest\evNotifiedProcessor.pas',
  evPreviewProcessor in 'w:\common\components\gui\Garant\Everest\evPreviewProcessor.pas',
  evParaDrawTools in 'w:\common\components\gui\Garant\Everest\evParaDrawTools.pas',
  evdHeaderHyperlinkAdder in 'w:\common\components\gui\Garant\Everest\evdHeaderHyperlinkAdder.pas',
  evdBlockNameAdder in 'w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas',
  evPreviewForTestsTuning in 'w:\common\components\gui\Garant\Everest\evPreviewForTestsTuning.pas',
  nevDocumentProvider in 'w:\common\components\gui\Garant\Everest\nevDocumentProvider.pas',
  evDocumentPreviewPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPreviewPrim.pas',
  evDocumentPreview in 'w:\common\components\gui\Garant\Everest\evDocumentPreview.pas',
  evHAFPainter in 'w:\common\components\gui\Garant\Everest\evHAFPainter.pas',
  evHAFPainterEx in 'w:\common\components\gui\Garant\Everest\evHAFPainterEx.pas',
  evCustomEditorWindowProcessor in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowProcessor.pas',
  evEditorWindowProcessor in 'w:\common\components\gui\Garant\Everest\evEditorWindowProcessor.pas',
  evCustomHAFMacroReplacer in 'w:\common\components\gui\Garant\Everest\evCustomHAFMacroReplacer.pas',
  evFormatHAFMacroReplacer in 'w:\common\components\gui\Garant\Everest\evFormatHAFMacroReplacer.pas',
  evFixedHAFMacroReplacer in 'w:\common\components\gui\Garant\Everest\new\evFixedHAFMacroReplacer.pas',
  nevDocumentProviderEx in 'w:\common\components\gui\Garant\Everest\nevDocumentProviderEx.pas',
  nevPrintableDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPrintableDocumentContainer.pas',
  evTagsListFilter in 'w:\common\components\gui\Garant\Everest\evTagsListFilter.pas',
  evMemoProcessor in 'w:\common\components\gui\Garant\Everest\evMemoProcessor.pas',
  evCustomMemoContainer in 'w:\common\components\gui\Garant\Everest\evCustomMemoContainer.pas',
  evCustomMemoTextSource in 'w:\common\components\gui\Garant\Everest\evCustomMemoTextSource.pas',
  evMemoContextMenu in 'w:\common\components\gui\Garant\Everest\evMemoContextMenu.pas',
  evCustomMemo in 'w:\common\components\gui\Garant\Everest\evCustomMemo.pas',
  Themes in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Themes.pas',
  evEditProcessor in 'w:\common\components\gui\Garant\Everest\evEditProcessor.pas',
  evCustomEditDocumentContainer in 'w:\common\components\gui\Garant\Everest\evCustomEditDocumentContainer.pas',
  evEditDocumentContainer in 'w:\common\components\gui\Garant\Everest\evEditDocumentContainer.pas',
  evCustomEditTextSource in 'w:\common\components\gui\Garant\Everest\evCustomEditTextSource.pas',
  evConvertTextTools in 'w:\common\components\gui\Garant\Everest\evConvertTextTools.pas',
  evCustomEdit in 'w:\common\components\gui\Garant\Everest\evCustomEdit.pas',
  elCustomEdit in 'w:\common\components\gui\Garant\Everest\elCustomEdit.pas',
  CustomElGraphicButton in 'w:\common\components\gui\Garant\Everest\CustomElGraphicButton.pas',
  elCustomButtonEdit in 'w:\common\components\gui\Garant\Everest\elCustomButtonEdit.pas',
  ctButtonEdit in 'w:\common\components\gui\Garant\Everest\ctButtonEdit.pas',
  Clipbrd in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Clipbrd.pas',
  ctAbstractEdit in 'w:\common\components\gui\Garant\VT\ComboTree\ctAbstractEdit.pas',
  AbstractDropDown in 'w:\common\components\gui\Garant\VT\ComboTree\AbstractDropDown.pas',
  DropDownTree in 'w:\common\components\gui\Garant\VT\ComboTree\DropDownTree.pas',
  l3SimpleTree in 'w:\common\components\rtl\Garant\L3\l3SimpleTree.pas',
  EditableBox in 'w:\common\components\gui\Garant\VT\ComboTree\EditableBox.pas',
  ctComboBoxStringsItemNode in 'w:\common\components\gui\Garant\VT\ComboTree\ctComboBoxStringsItemNode.pas',
  ComboBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ComboBoxStrings.pas',
  ctFakeBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ctFakeBoxStrings.pas',
  FakeBox in 'w:\common\components\gui\Garant\VT\ComboTree\FakeBox.pas',
  nscComboBox in 'w:\common\components\gui\Garant\Nemesis\nscComboBox.pas',
  nscEdit in 'w:\common\components\gui\Garant\Nemesis\nscEdit.pas',
  nscEditWithoutPlusMinusShortcut in 'w:\common\components\gui\Garant\Nemesis\nscEditWithoutPlusMinusShortcut.pas',
  vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas',
  eeButton in 'w:\common\components\gui\Garant\Everest_Engine\eeButton.pas',
  PreviewInterfaces in 'Model\PreviewInterfaces.pas',
  l3RangeManager in 'w:\common\components\rtl\Garant\L3\l3RangeManager.pas',
  PrimPrintDialogOptions_Form in 'View\Search\Forms\PrimPrintDialogOptions_Form.pas',
  evTunedEditor in 'w:\common\components\gui\Garant\Everest\evTunedEditor.pas',
  evEditor in 'w:\common\components\gui\Garant\Everest\evEditor.pas',
  evQueryCardEditorHook in 'w:\common\components\gui\Garant\Everest\evQueryCardEditorHook.pas',
  evQueryCardEditorHotSpot in 'w:\common\components\gui\Garant\Everest\evQueryCardEditorHotSpot.pas',
  evQueryCardSelection in 'w:\common\components\gui\Garant\Everest\evQueryCardSelection.pas',
  evTextParaTools in 'w:\common\components\gui\Garant\Everest\evTextParaTools.pas',
  evQueryCardEditor in 'w:\common\components\gui\Garant\Everest\evQueryCardEditor.pas',
  QueryCardInterfaces in 'Search\QueryCardInterfaces.pas',
  PrimQueryCard_utqcAttributeSearch_UserType in 'View\Search\Forms\PrimQueryCard_utqcAttributeSearch_UserType.pas',
  PrimQueryCard_utqcPostingOrder_UserType in 'View\Search\Forms\PrimQueryCard_utqcPostingOrder_UserType.pas',
  PrimQueryCard_utqcLegislationReview_UserType in 'View\Search\Forms\PrimQueryCard_utqcLegislationReview_UserType.pas',
  PrimQueryCard_utqcSendConsultation_UserType in 'View\Search\Forms\PrimQueryCard_utqcSendConsultation_UserType.pas',
  PrimQueryCard_utqcInpharmSearch_UserType in 'View\Search\Forms\PrimQueryCard_utqcInpharmSearch_UserType.pas',
  nsDocumentPreview in 'Search\nsDocumentPreview.pas',
  evStreamedDataObject in 'w:\common\components\gui\Garant\Everest\evStreamedDataObject.pas',
  evReaderDataObject in 'w:\common\components\gui\Garant\Everest\evReaderDataObject.pas',
  evEvdDataObject in 'w:\common\components\gui\Garant\Everest\evEvdDataObject.pas',
  PrimeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\PrimeUnit.pas'
  {$If defined(Monitorings) AND not defined(Admin)}
  ,
  PrimeDomainInterfaces in 'View\PrimeDomainInterfaces.pas'
  {$IfEnd} //Monitorings AND not Admin
  
  {$If defined(Monitorings) AND not defined(Admin)}
  ,
  nsPrimeNode in 'View\Search\nsPrimeNode.pas'
  {$IfEnd} //Monitorings AND not Admin
  
  {$If defined(Monitorings) AND not defined(Admin)}
  ,
  nsPostingsLine in 'View\Search\nsPostingsLine.pas'
  {$IfEnd} //Monitorings AND not Admin
  ,
  nsHAFPainter in 'Search\nsHAFPainter.pas',
  nsFixedHAFMacroReplacer in 'Search\nsFixedHAFMacroReplacer.pas',
  eeProcessor in 'w:\common\components\gui\Garant\Everest_Engine\eeProcessor.pas',
  eeDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentPartGenerator.pas',
  eeSubExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubExport.pas',
  eeDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainerPrim.pas',
  evCommentParaDecorator in 'w:\common\components\gui\Garant\Everest\evCommentParaDecorator.pas',
  evLeafParaDecorationsHolderEliminator in 'w:\common\components\gui\Garant\EverestCommon\evLeafParaDecorationsHolderEliminator.pas',
  evBlocksEliminator in 'w:\common\components\gui\Garant\EverestCommon\evBlocksEliminator.pas',
  evdBufferedFilter in 'w:\common\components\rtl\Garant\EVD\evdBufferedFilter.pas',
  evUserCommentFilter in 'w:\common\components\gui\Garant\Everest\evUserCommentFilter.pas',
  evCommentDecorator in 'w:\common\components\gui\Garant\Everest\evCommentDecorator.pas',
  evNestedDocumentEliminator in 'w:\common\components\gui\Garant\Everest\evNestedDocumentEliminator.pas',
  evCommentParaAdder in 'w:\common\components\gui\Garant\Everest\evCommentParaAdder.pas',
  evPageBreakEliminator in 'w:\common\components\gui\Garant\Everest\evPageBreakEliminator.pas',
  evControlParaFilter in 'w:\common\components\gui\Garant\Everest\evControlParaFilter.pas',
  evBlocksButNotCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evBlocksButNotCommentsEliminator.pas',
  evStrictContentsElementEliminator in 'w:\common\components\gui\Garant\EverestCommon\evStrictContentsElementEliminator.pas',
  eeDocumentContainer in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainer.pas',
  ComObj in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas',
  l3Date in 'w:\common\components\rtl\Garant\L3\l3Date.pas',
  evControlParaTools in 'w:\common\components\gui\Garant\Everest\qf\evControlParaTools.pas',
  PrimQueryCard_Form in 'View\Search\Forms\PrimQueryCard_Form.pas',
  PrimQueryCardOptions_Form in 'View\Search\Forms\PrimQueryCardOptions_Form.pas',
  bsTypes in 'Model\bsTypes.pas',
  SimpleListInterfaces in 'List\SimpleListInterfaces.pas',
  vtPanel in 'w:\common\components\gui\Garant\VT\vtPanel.pas',
  vcmItems in 'w:\common\components\gui\Garant\VCM\implementation\vcmItems.pas',
  PrimSaveLoad_slqtAttribute_UserType in 'View\Search\Forms\PrimSaveLoad_slqtAttribute_UserType.pas',
  PrimSaveLoad_slqtKW_UserType in 'View\Search\Forms\PrimSaveLoad_slqtKW_UserType.pas',
  PrimSaveLoad_slqtOldKW_UserType in 'View\Search\Forms\PrimSaveLoad_slqtOldKW_UserType.pas',
  PrimSaveLoad_slqtPublishSource_UserType in 'View\Search\Forms\PrimSaveLoad_slqtPublishSource_UserType.pas',
  PrimSaveLoad_slqtFilters_UserType in 'View\Search\Forms\PrimSaveLoad_slqtFilters_UserType.pas',
  PrimSaveLoad_slqtLegislationReview_UserType in 'View\Search\Forms\PrimSaveLoad_slqtLegislationReview_UserType.pas',
  PrimSaveLoad_slqtPostingOrder_UserType in 'View\Search\Forms\PrimSaveLoad_slqtPostingOrder_UserType.pas',
  PrimSaveLoad_slqtConsult_UserType in 'View\Search\Forms\PrimSaveLoad_slqtConsult_UserType.pas',
  PrimSaveLoad_slqtInpharmSearch_UserType in 'View\Search\Forms\PrimSaveLoad_slqtInpharmSearch_UserType.pas',
  PrimSaveLoad_slqtDiction_UserType in 'View\Search\Forms\PrimSaveLoad_slqtDiction_UserType.pas',
  PrimBaseSearchInterfaces in 'Search\PrimBaseSearchInterfaces.pas',
  PrimWorkJournalInterfaces in 'Search\PrimWorkJournalInterfaces.pas',
  PrimSaveLoad_slqtBaseSearch_UserType in 'View\Search\Forms\PrimSaveLoad_slqtBaseSearch_UserType.pas',
  PrimSaveLoad_slqtMedicDiction_UserType in 'View\Search\Forms\PrimSaveLoad_slqtMedicDiction_UserType.pas',
  PrimPrimListInterfaces in 'Search\PrimPrimListInterfaces.pas',
  FiltersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FiltersUnit.pas',
  ConsultingUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ConsultingUnit.pas',
  nsFolders in 'Data\Common\nsFolders.pas',
  nsbQueryUtils in 'View\Search\nsbQueryUtils.pas',
  nsFolderFilterInfo in 'Search\nsFolderFilterInfo.pas',
  vcmBaseOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationsCollectionItem.pas',
  StrUtils in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas',
  PrimSaveLoad_Form in 'View\Search\Forms\PrimSaveLoad_Form.pas',
  PrimSaveLoadOptions_Form in 'View\Search\Forms\PrimSaveLoadOptions_Form.pas',
  vtGroupBox in 'w:\common\components\gui\Garant\VT\vtGroupBox.pas',
  nscPageControl in 'w:\common\components\gui\Garant\Nemesis\nscPageControl.pas',
  PrimPageSetup_pstNone_UserType in 'View\Search\Forms\PrimPageSetup_pstNone_UserType.pas',
  nsPageSetup in 'View\nsPageSetup.pas',
  PrimPageSetup_Form in 'View\Search\Forms\PrimPageSetup_Form.pas',
  evHAFPainterMacros in 'w:\common\components\gui\Garant\Everest\evHAFPainterMacros.pas',
  PrimPageSetupOptions_Form in 'View\Search\Forms\PrimPageSetupOptions_Form.pas',
  SaveLoad_Form in 'View\Search\Forms\SaveLoad_Form.pas' {cfSaveLoad: TvcmEntityForm},
  evQueryCardProcessor in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardProcessor.pas',
  evControlGenerator in 'w:\common\components\gui\Garant\Everest\qf\evControlGenerator.pas',
  evQueryDocumentContainer in 'w:\common\components\gui\Garant\Everest\qf\evQueryDocumentContainer.pas',
  UnderControlUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UnderControlUnit.pas',
  eeTreeMisc in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeMisc.pas',
  nsTreeUtils in 'Data\Tree\nsTreeUtils.pas',
  nsAttributeTreeStruct in 'Data\Search\nsAttributeTreeStruct.pas',
  nsSearchClasses in 'QueryCardProcessing\nsSearchClasses.pas',
  f1QueryDocumentContainer in 'QueryCardProcessing\f1QueryDocumentContainer.pas',
  QueryCard_Form in 'View\Search\Forms\QueryCard_Form.pas' {enQueryCard: TvcmEntityForm},
  Preview_Form in 'View\Search\Forms\Preview_Form.pas' {efPreviewForm: TvcmEntityForm},
  PageSetup_Form in 'View\Search\Forms\PageSetup_Form.pas' {en_PageSetup: TvcmEntityForm},
  PrintDialog_Form in 'View\Search\Forms\PrintDialog_Form.pas' {en_PrintDialog: TvcmEntityForm},
  CommonSearch_Module in 'View\Search\CommonSearch_Module.pas',
  moCommonSearch in 'View\Search\moCommonSearch.pas' {mo_CommonSearch: TvcmModule},
  ShellAndMonitoringsRes in 'View\ShellAndMonitoringsRes.pas',
  MedicMainMenuRes in 'View\MedicMainMenuRes.pas' {dmMedicMainMenuRes: TDataModule},
  MainMenuNewRes in 'View\MainMenuNewRes.pas' {dmMainMenuNew: TDataModule},
  vtDateEdit in 'w:\common\components\gui\Garant\VT\vtDateEdit.pas',
  nsHooks in 'View\nsHooks.pas',
  BaseSearchInterfaces in 'View\BaseSearchInterfaces.pas',
  PrimNemesisRes in 'View\PrimNemesisRes.pas',
  nsStyleEditor in 'Config\nsStyleEditor.pas',
  nsSettingsUtils in 'Config\nsSettingsUtils.pas',
  evStyleTableTools in 'w:\common\components\gui\Garant\Everest\evStyleTableTools.pas',
  NemesisMain_utMainWindow_UserType in 'View\NemesisMain_utMainWindow_UserType.pas',
  resWarnImages in 'View\resWarnImages.pas' {nsWarnImages: TDataModule},
  Base_Operations_View_Controls in 'View\Base_Operations_View_Controls.pas',
  vcmLocalInterfaces in 'w:\common\components\gui\Garant\VCM\implementation\vcmLocalInterfaces.pas',
  DocumentAndListInterfaces in 'BusinessInterfaces\Common\DocumentAndListInterfaces.pas',
  DocumentInterfaces in 'F1DocumentProcessingInterfaces\DocumentInterfaces.pas',
  dsWarning in 'Business\Document\dsWarning.pas',
  WarningUserTypes_Warning_UserType in 'View\WarningUserTypes_Warning_UserType.pas',
  WarningUserTypes_WarnJuror_UserType in 'View\WarningUserTypes_WarnJuror_UserType.pas',
  WarningUserTypes_WarnPreActive_UserType in 'View\WarningUserTypes_WarnPreActive_UserType.pas',
  WarningUserTypes_WarnIsAbolished_UserType in 'View\WarningUserTypes_WarnIsAbolished_UserType.pas',
  WarningUserTypes_WarnOnControl_UserType in 'View\WarningUserTypes_WarnOnControl_UserType.pas',
  WarningUserTypes_WarnInactualDocument_UserType in 'View\WarningUserTypes_WarnInactualDocument_UserType.pas',
  WarningUserTypes_WarnTimeMachineOn_UserType in 'View\WarningUserTypes_WarnTimeMachineOn_UserType.pas',
  WarningUserTypes_WarnRedaction_UserType in 'View\WarningUserTypes_WarnRedaction_UserType.pas',
  WarningUserTypes_WarnTimeMachineWarning_UserType in 'View\WarningUserTypes_WarnTimeMachineWarning_UserType.pas',
  WarningUserTypes_WarnTimeMachineException_UserType in 'View\WarningUserTypes_WarnTimeMachineException_UserType.pas',
  WarningUserTypes_remListModified_UserType in 'View\WarningUserTypes_remListModified_UserType.pas',
  WarningUserTypes_remListFiltered_UserType in 'View\WarningUserTypes_remListFiltered_UserType.pas',
  WarningUserTypes_remTimeMachineWarning_UserType in 'View\WarningUserTypes_remTimeMachineWarning_UserType.pas',
  WarningUserTypes_remUnreadConsultations_UserType in 'View\WarningUserTypes_remUnreadConsultations_UserType.pas',
  WarningUserTypes_remOnlineDead_UserType in 'View\WarningUserTypes_remOnlineDead_UserType.pas',
  WarningUserTypes_TrialModeWarning_UserType in 'View\WarningUserTypes_TrialModeWarning_UserType.pas',
  WarningUserTypes_OldBaseWarning_UserType in 'View\WarningUserTypes_OldBaseWarning_UserType.pas',
  WarningUserTypes_ControlledChangingWarning_UserType in 'View\WarningUserTypes_ControlledChangingWarning_UserType.pas',
  sdsMainWindow in 'MainWindowControllers\sdsMainWindow.pas',
  eeEditorExportModelPart in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExportModelPart.pas',
  eeEditorExport in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExport.pas',
  eeCustomEditor in 'w:\common\components\gui\Garant\Everest_Engine\eeCustomEditor.pas',
  eeEditor in 'w:\common\components\gui\Garant\Everest_Engine\eeEditor.pas',
  Document_Strange_Controls in 'View\Document_Strange_Controls.pas',
  afwDockingInterfaces in 'w:\common\components\gui\Garant\AFW\afwDockingInterfaces.pas',
  Base_Operations_Strange_Controls in 'View\Base_Operations_Strange_Controls.pas',
  bsTypesNew in 'Model\bsTypesNew.pas',
  PrimWarning_Form in 'View\PrimWarning_Form.pas',
  nsDocInfoHAFMacroReplacer in 'Business\Document\nsDocInfoHAFMacroReplacer.pas',
  PrimWarningOptions_Form in 'View\PrimWarningOptions_Form.pas',
  WarningConst in 'View\WarningConst.pas',
  Warning_Form in 'View\Document\Forms\Warning_Form.pas' {WarningForm: TvcmEntityForm},
  NemesisMain_Form in 'View\NemesisMain_Form.pas',
  PresentationInterfaces in 'Common\PresentationInterfaces.pas',
  Main_Form in 'Main_Form.pas',
  nsWindowNode in 'View\nsWindowNode.pas',
  nsWindowsListPrim in 'View\nsWindowsListPrim.pas',
  nsFiltersInterfaces in 'Filters\nsFiltersInterfaces.pas',
  nsFiltersNode in 'Filters\nsFiltersNode.pas',
  nsFiltersTree in 'Filters\nsFiltersTree.pas',
  nsFiltersContainerPrim in 'Filters\nsFiltersContainerPrim.pas',
  nsFiltersContainer in 'Filters\nsFiltersContainer.pas',
  nsBaseSearcher in 'Search\nsBaseSearcher.pas',
  nsWindowsList in 'View\nsWindowsList.pas',
  MainWindow_Form in 'MainWindow_Form.pas' {MainWindowForm: TvcmMainForm},
  EditionsInterfaces in 'Editions\EditionsInterfaces.pas',
  evSubWaiter in 'w:\common\components\gui\Garant\Everest\new\evSubWaiter.pas',
  CompareEditions_Controls in 'View\CompareEditions_Controls.pas',
  DocumentRes in 'Business\Document\DocumentRes.pas' {nsDocumentRes: TDataModule},
  vtUtils in 'w:\common\components\gui\Garant\VT\vtUtils.pas',
  ExternalOperationUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalOperationUnit.pas',
  NavigationInterfaces in 'View\NavigationInterfaces.pas',
  nsHyperLinkProcessor in 'View\nsHyperLinkProcessor.pas',
  bsBase in 'F1DocumentProcessing\bsBase.pas',
  deBase in 'F1DocumentProcessing\deBase.pas',
  AdapterFacade in 'Model\AdapterFacade.pas',
  bsDataContainer in 'F1DocumentProcessing\bsDataContainer.pas',
  deDocInfo in 'F1DocumentProcessing\deDocInfo.pas',
  nsOpenUtils in 'Data\Common\nsOpenUtils.pas',
  vtFocusLabel in 'w:\common\components\gui\Garant\VT\vtFocusLabel.pas',
  ImgList in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas',
  nscEditor in 'w:\common\components\gui\Garant\Nemesis\nscEditor.pas',
  eeTextSourceExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSourceExport.pas',
  eeTextSource in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSource.pas',
  nscTextSource in 'w:\common\components\gui\Garant\Nemesis\nscTextSource.pas',
  Base_Operations_F1Specific_Controls in 'View\Base_Operations_F1Specific_Controls.pas',
  eeInterfacesEx in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfacesEx.pas',
  eePara in 'w:\common\components\gui\Garant\Everest_Engine\eePara.pas',
  eeParaTools in 'w:\common\components\gui\Garant\Everest_Engine\eeParaTools.pas',
  nsDocumentTools in 'Common\nsDocumentTools.pas',
  ddHTMLWriterRes in 'w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas',
  ddHTMLWriter in 'w:\common\components\rtl\Garant\dd\ddHTMLWriter.pas',
  nsExternalObject in 'Common\nsExternalObject.pas',
  nsToMSWordOp in 'View\Common\nsToMSWordOp.pas',
  nsExportToFileEvent in 'View\nsExportToFileEvent.pas',
  nsExportToWordEvent in 'View\nsExportToWordEvent.pas',
  nsSendDocumentByEMailEvent in 'View\nsSendDocumentByEMailEvent.pas',
  nsDocumentPrintPreviewEvent in 'View\nsDocumentPrintPreviewEvent.pas',
  nsBaseTextOperationsConst in 'View\nsBaseTextOperationsConst.pas',
  f1MultylinkResolver in 'F1DocumentProcessing\f1MultylinkResolver.pas',
  nsTagNodeTools in 'f1DocumentTagsImplementation\nsTagNodeTools.pas',
  nsContextSearchParams in 'Data\Common\nsContextSearchParams.pas',
  l3ProtoObjectForTie in 'View\l3ProtoObjectForTie.pas',
  nsFindIteratorNewFindPositionList in 'View\nsFindIteratorNewFindPositionList.pas',
  nsFindIteratorNew in 'View\nsFindIteratorNew.pas',
  nsFindIteratorNewForAutoreferat in 'View\nsFindIteratorNewForAutoreferat.pas',
  nsFindPositionListList in 'View\nsFindPositionListList.pas',
  nsFindIteratorNewForDiction in 'View\nsFindIteratorNewForDiction.pas',
  nsFragmentListForSearchViaEverestOwnSearcher in 'View\nsFragmentListForSearchViaEverestOwnSearcher.pas',
  nsContextListForSearchViaEverestOwnSearcher in 'View\nsContextListForSearchViaEverestOwnSearcher.pas',
  nsFoundRangeCollector in 'View\nsFoundRangeCollector.pas',
  bsDocumentContextSearcher in 'View\bsDocumentContextSearcher.pas',
  nsSearchInDocumentEvent in 'View\nsSearchInDocumentEvent.pas',
  UnderControlInterfaces in 'UnderControl\UnderControlInterfaces.pas',
  nsFoundBlocksList in 'View\nsFoundBlocksList.pas',
  vtPngImageList in 'w:\common\components\gui\Garant\VT\vtPngImageList.pas',
  PrimEditionsRes_Form in 'View\Editions\Forms\PrimEditionsRes_Form.pas',
  EditionsRes_Form in 'View\Editions\Forms\EditionsRes_Form.pas' {EditionsResForm: TDataModule},
  nsEditionsUtils in 'Business\Document\nsEditionsUtils.pas',
  nsEditionNodes in 'Common\nsEditionNodes.pas',
  l3ControlsTypes in 'w:\common\components\rtl\Garant\L3\l3ControlsTypes.pas',
  ctTypes in 'w:\common\components\gui\Garant\VT\ComboTree\ctTypes.pas',
  Diff_Form in 'View\Editions\Forms\Diff_Form.pas',
  DiffOptions_Form in 'View\Editions\Forms\DiffOptions_Form.pas',
  PrimLeftEdition_utLeftEdition_UserType in 'View\Editions\Forms\PrimLeftEdition_utLeftEdition_UserType.pas',
  PrimLeftEdition_Form in 'View\Editions\Forms\PrimLeftEdition_Form.pas',
  PrimRightEdition_utRightEdition_UserType in 'View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas',
  ExternalObjectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalObjectUnit.pas',
  PrimRightEdition_Form in 'View\Editions\Forms\PrimRightEdition_Form.pas',
  LeftEdition_Form in 'View\Editions\Forms\LeftEdition_Form.pas' {LeftEditionForm: TvcmEntityForm},
  RightEdition_Form in 'View\Editions\Forms\RightEdition_Form.pas' {RightEditionForm: TvcmEntityForm},
  Base_Operations_Editions_Controls in 'View\Base_Operations_Editions_Controls.pas',
  vtProportionalPanel in 'w:\common\components\gui\Garant\VT\vtProportionalPanel.pas',
  PrimEditionsContainer_utEditionsContainer_UserType in 'View\Editions\Forms\PrimEditionsContainer_utEditionsContainer_UserType.pas',
  PrimEditionsContainer_Form in 'View\Editions\Forms\PrimEditionsContainer_Form.pas',
  EditionsContainer_Form in 'View\Editions\Forms\EditionsContainer_Form.pas' {EditionsContainerForm: TvcmEntityForm},
  dsEditionsContainerData in 'Editions\dsEditionsContainerData.pas',
  l3Utils in 'w:\common\components\rtl\Garant\L3\l3Utils.pas',
  nsTagNodeToolsNew in 'f1DocumentTagsImplementation\nsTagNodeToolsNew.pas',
  nsSubPrim in 'F1DocumentProcessing\nsSubPrim.pas',
  nsDocumentContainerSub in 'F1DocumentProcessing\nsDocumentContainerSub.pas',
  nsF1DocumentContainerPrim in 'F1DocumentProcessing\nsF1DocumentContainerPrim.pas',
  F1TagDataProviderInterface in 'f1DocumentTagsImplementation\F1TagDataProviderInterface.pas',
  k2HugeTagObject in 'w:\common\components\rtl\Garant\K2\k2HugeTagObject.pas',
  nsBaseTagNode in 'f1DocumentTagsImplementation\nsBaseTagNode.pas',
  nsTagNodePrimPrim in 'f1DocumentTagsImplementation\nsTagNodePrimPrim.pas',
  evdVer in 'w:\common\components\rtl\Garant\EVD\evdVer.pas',
  k2InPlaceGenerator in 'w:\common\components\rtl\Garant\K2\k2InPlaceGenerator.pas',
  nsStyleParser in 'f1DocumentTagsImplementation\nsStyleParser.pas',
  nsString in 'f1DocumentTagsImplementation\nsString.pas',
  nsTagString in 'f1DocumentTagsImplementation\nsTagString.pas',
  nsNodeDataStream in 'f1DocumentTagsImplementation\nsNodeDataStream.pas',
  nsTagNodePrim in 'f1DocumentTagsImplementation\nsTagNodePrim.pas',
  nsSubNode in 'f1DocumentTagsImplementation\nsSubNode.pas',
  f1AtomChecker in 'f1DocumentTagsImplementation\f1AtomChecker.pas',
  nsLeafParaNode in 'f1DocumentTagsImplementation\nsLeafParaNode.pas',
  nsSectionBreakNode in 'f1DocumentTagsImplementation\nsSectionBreakNode.pas',
  nsTextParaNode in 'f1DocumentTagsImplementation\nsTextParaNode.pas',
  nsControlParaNode in 'f1DocumentTagsImplementation\nsControlParaNode.pas',
  nsBitmapParaNode in 'f1DocumentTagsImplementation\nsBitmapParaNode.pas',
  f1ChildMaker in 'f1DocumentTagsImplementation\f1ChildMaker.pas',
  nsNativeCommentPara in 'f1DocumentTagsImplementation\nsNativeCommentPara.pas',
  nsCommentMemoryStream in 'f1DocumentTagsImplementation\nsCommentMemoryStream.pas',
  nsCommentStorer in 'f1DocumentTagsImplementation\nsCommentStorer.pas',
  nsReqCellNode in 'f1DocumentTagsImplementation\nsReqCellNode.pas',
  nsReqRowNode in 'f1DocumentTagsImplementation\nsReqRowNode.pas',
  nsBlockNode in 'f1DocumentTagsImplementation\nsBlockNode.pas',
  nsParentedTagNode in 'f1DocumentTagsImplementation\nsParentedTagNode.pas',
  nsLeafParaDecorationsHolder in 'f1DocumentTagsImplementation\nsLeafParaDecorationsHolder.pas',
  nsParaListNodeModelPart in 'f1DocumentTagsImplementation\nsParaListNodeModelPart.pas',
  nsTagNode in 'f1DocumentTagsImplementation\nsTagNode.pas',
  nsBlockNodePrim in 'f1DocumentTagsImplementation\nsBlockNodePrim.pas',
  nsDocumentTagNodePrim in 'f1DocumentTagsImplementation\nsDocumentTagNodePrim.pas',
  nsOwnedDocumentTagNodePrim in 'f1DocumentTagsImplementation\nsOwnedDocumentTagNodePrim.pas',
  nsDocumentTagNodeBase in 'f1DocumentTagsImplementation\nsDocumentTagNodeBase.pas',
  nsCommentModifier in 'f1DocumentTagsImplementation\nsCommentModifier.pas',
  nsParaModifier in 'f1DocumentTagsImplementation\nsParaModifier.pas',
  f1LeafTagDataFromDTP in 'f1DocumentTagsImplementation\f1LeafTagDataFromDTP.pas',
  f1ListTagDataFromDTP in 'f1DocumentTagsImplementation\f1ListTagDataFromDTP.pas',
  f1TagDataFromDTPFactory in 'f1DocumentTagsImplementation\f1TagDataFromDTPFactory.pas',
  f1TagDataFromDTP in 'f1DocumentTagsImplementation\f1TagDataFromDTP.pas',
  f1DocumentTagDataFromDTP in 'f1DocumentTagsImplementation\f1DocumentTagDataFromDTP.pas',
  f1DocumentTagDataFromDTPHandle in 'f1DocumentTagsImplementation\f1DocumentTagDataFromDTPHandle.pas',
  nsF1DocumentTagNode in 'f1DocumentTagsImplementation\nsF1DocumentTagNode.pas',
  nsEditionFromDTPDocumentContainer in 'Editions\nsEditionFromDTPDocumentContainer.pas',
  dsRightEdition in 'Editions\dsRightEdition.pas',
  dsLeftEdition in 'Editions\dsLeftEdition.pas',
  nsRedactionCurrentPara in 'Editions\nsRedactionCurrentPara.pas',
  nsCompareEditionsInfoPrim in 'Editions\nsCompareEditionsInfoPrim.pas',
  nsEditionDiffData in 'Editions\nsEditionDiffData.pas',
  nsEditionsContainerData in 'Editions\nsEditionsContainerData.pas',
  vcmFormSetRefreshParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefreshParams.pas',
  sdsCompareEditionsState in 'Editions\sdsCompareEditionsState.pas',
  sdsCompareEditions in 'Editions\sdsCompareEditions.pas',
  nsCompareEditionsInfo in 'Editions\nsCompareEditionsInfo.pas',
  fsCompareEditions in 'View\Editions\fsCompareEditions.pas' {fs_CompareEditions: TvcmFormSetFactory},
  BaseEditions_Module in 'View\Editions\BaseEditions_Module.pas',
  moCompareEditions in 'View\moCompareEditions.pas' {mo_CompareEditions: TvcmModule},
  InternetAgentInterfaces in 'InternetAgent\InternetAgentInterfaces.pas',
  OleCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\OleCtrls.pas',
  shdocvw in 'w:\common\components\rtl\external\Borland\Delphi\Internet\shdocvw.pas',
  nsWebBrowserPrim in 'View\InternetAgent\nsWebBrowserPrim.pas',
  Variants,
  nsWebBrowser in 'View\InternetAgent\nsWebBrowser.pas',
  l3RegEx in 'w:\common\components\rtl\Garant\L3\l3RegEx.pas',
  nsInternetUtils in 'w:\common\components\gui\Garant\Nemesis\nsInternetUtils.pas',
  PrimInternetAgent_utInternetAgent_UserType in 'View\InternetAgent\Forms\PrimInternetAgent_utInternetAgent_UserType.pas',
  UrlMon in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\UrlMon.pas',
  PrimInternetAgent_Form in 'View\InternetAgent\Forms\PrimInternetAgent_Form.pas',
  InternetAgent_Form in 'View\InternetAgent\Forms\InternetAgent_Form.pas' {InternetAgentForm: TvcmEntityForm},
  fsInternetAgent in 'View\InternetAgent\fsInternetAgent.pas' {fs_InternetAgent: TvcmFormSetFactory},
  dsInternetAgent in 'InternetAgent\dsInternetAgent.pas',
  sdsInternetAgent in 'InternetAgent\sdsInternetAgent.pas',
  StdResPrim in 'w:\common\components\gui\Garant\VCM\implementation\StdResPrim.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_InternetAgent_InternetAgent in 'View\InternetAgent\kw_InternetAgent_InternetAgent.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  PrimInternetAgent_Module in 'View\InternetAgent\PrimInternetAgent_Module.pas',
  moInternetAgent in 'View\moInternetAgent.pas' {mo_InternetAgent: TvcmModule},
  FoldersInterfaces in 'Folders\FoldersInterfaces.pas',
  nsFormCoordinates in 'View\Folders\nsFormCoordinates.pas',
  Folders_Strange_Controls in 'View\Folders_Strange_Controls.pas',
  Folders_Result_Controls in 'View\Folders_Result_Controls.pas',
  PrimFolders_utFolders_UserType in 'View\Folders\Forms\PrimFolders_utFolders_UserType.pas',
  PrimFolders_Form in 'View\Folders\Forms\PrimFolders_Form.pas',
  PrimFoldersOptions_Form in 'View\Folders\Forms\PrimFoldersOptions_Form.pas',
  PrimFoldersTree_utSaveOpen_UserType in 'View\Folders\Forms\PrimFoldersTree_utSaveOpen_UserType.pas',
  PrimFoldersTree_utFoldersTree_UserType in 'View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas',
  PrimFoldersTree_Form in 'View\Folders\Forms\PrimFoldersTree_Form.pas',
  nsValueMapsIDs in 'Data\Common\nsValueMapsIDs.pas',
  nsIntegerValueMapFactory in 'Data\Common\nsIntegerValueMapFactory.pas',
  nsStringValueMapFactory in 'Data\Common\nsStringValueMapFactory.pas',
  nsValueMaps in 'Data\Common\nsValueMaps.pas',
  Dialogs in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas',
  nsFolderNodes in 'Common\nsFolderNodes.pas',
  vtSaveDialog in 'w:\common\components\gui\Garant\VT\vtSaveDialog.pas',
  PrimFoldersTreeOptions_Form in 'View\Folders\Forms\PrimFoldersTreeOptions_Form.pas',
  PrimFoldersInfo_utFoldersInfoContainer_UserType in 'View\Folders\Forms\PrimFoldersInfo_utFoldersInfoContainer_UserType.pas',
  PrimFoldersInfo_Form in 'View\Folders\Forms\PrimFoldersInfo_Form.pas',
  PrimFoldersInfoOptions_Form in 'View\Folders\Forms\PrimFoldersInfoOptions_Form.pas',
  nscComboBoxWithReadOnly in 'w:\common\components\gui\Garant\Nemesis\nscComboBoxWithReadOnly.pas',
  PrimFoldersElementInfo_utFoldersProperty_UserType in 'View\Folders\Forms\PrimFoldersElementInfo_utFoldersProperty_UserType.pas',
  PrimFoldersElementInfo_Form in 'View\Folders\Forms\PrimFoldersElementInfo_Form.pas',
  PrimFoldersElementInfoOptions_Form in 'View\Folders\Forms\PrimFoldersElementInfoOptions_Form.pas',
  Folders_Form in 'View\Folders\Forms\Folders_Form.pas' {cfFolders: TvcmEntityForm},
  fsFolders in 'View\Folders\fsFolders.pas' {fs_Folders: TvcmFormSetFactory},
  dsFolders in 'Folders\dsFolders.pas',
  ConsultationDomainInterfaces in 'Consultation\ConsultationDomainInterfaces.pas',
  bsConsultation in 'Consultation\bsConsultation.pas'
  {$If defined(vcmUseProfilers)}
  ,
  ProfilersInterfaces in 'Model\ProfilersInterfaces.pas'
  {$IfEnd} //vcmUseProfilers
  ,
  nsManagers in 'Data\Common\nsManagers.pas',
  dsFoldersTree in 'Folders\dsFoldersTree.pas',
  deSaveObject in 'Folders\deSaveObject.pas',
  dsFolderElement in 'Folders\dsFolderElement.pas',
  sdsFolders in 'Folders\sdsFolders.pas',
  FoldersInfo_Form in 'View\Folders\Forms\FoldersInfo_Form.pas' {cfFoldersInfo: TvcmEntityForm},
  FoldersTree_Form in 'View\Folders\Forms\FoldersTree_Form.pas' {enFoldersTree: TvcmEntityForm},
  FoldersElementInfo_Form in 'View\Folders\Forms\FoldersElementInfo_Form.pas' {enFoldersElementInfo: TvcmEntityForm},
  vtCtrls in 'w:\common\components\gui\Garant\VT\vtCtrls.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Folders_MyInformation in 'View\Folders\kw_Folders_MyInformation.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Folders_MyConsultations in 'View\Folders\kw_Folders_MyConsultations.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Folders_UnderControlOpenFrmAct in 'View\Folders\kw_Folders_UnderControlOpenFrmAct.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Folders_OpenFrmAct in 'View\Folders\kw_Folders_OpenFrmAct.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  PrimFolders_Module in 'View\Folders\PrimFolders_Module.pas',
  moFolders in 'View\moFolders.pas' {mo_Folders: TvcmModule},
  ChatTypes in 'Chat\ChatTypes.pas',
  ChatInterfaces in 'Chat\ChatInterfaces.pas',
  evCustomChatMemo in 'w:\common\components\gui\Garant\Everest\evCustomChatMemo.pas',
  nscCustomChatMemoDocumentPartGenerator in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoDocumentPartGenerator.pas',
  nscCustomChatMemoProcessor in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoProcessor.pas',
  nscCustomChatMemoContainer in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoContainer.pas',
  nscCustomChatMemoTextSource in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoTextSource.pas',
  nscCustomChatMemo in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemo.pas',
  nscChatMemo in 'w:\common\components\gui\Garant\Nemesis\nscChatMemo.pas',
  AbstractHistory_Form in 'View\Chat\Forms\AbstractHistory_Form.pas',
  Base_Operations_Chat_Controls in 'View\Base_Operations_Chat_Controls.pas',
  BaseHistoryWindow_utChatHistory_UserType in 'View\Chat\Forms\BaseHistoryWindow_utChatHistory_UserType.pas',
  BaseHistoryWindow_Form in 'View\Chat\Forms\BaseHistoryWindow_Form.pas',
  BaseChatWindow_cwChat_UserType in 'View\Chat\Forms\BaseChatWindow_cwChat_UserType.pas',
  BaseChatWindow_Form in 'View\Chat\Forms\BaseChatWindow_Form.pas',
  BaseChatWindowOptions_Form in 'View\Chat\Forms\BaseChatWindowOptions_Form.pas',
  PrimContactList_chatContacts_UserType in 'View\Chat\Forms\PrimContactList_chatContacts_UserType.pas',
  PrimContactList_chatAddContact_UserType in 'View\Chat\Forms\PrimContactList_chatAddContact_UserType.pas',
  nsUserFlagsFilter in 'Data\Users\nsUserFlagsFilter.pas',
  PrimContactList_Form in 'View\Chat\Forms\PrimContactList_Form.pas',
  PrimContactListOptions_Form in 'View\Chat\Forms\PrimContactListOptions_Form.pas',
  ContactList_Form in 'View\Chat\Forms\ContactList_Form.pas' {ContactListForm: TvcmEntityForm},
  ChatWindow_Form in 'View\Chat\Forms\ChatWindow_Form.pas' {ChatWindowForm: TvcmEntityForm},
  ChatHistory_Form in 'View\Chat\Forms\ChatHistory_Form.pas' {ChatHistoryForm: TvcmEntityForm},
  nsBaseChatWindowList in 'Chat\nsBaseChatWindowList.pas',
  nsChatWindowList in 'Chat\nsChatWindowList.pas',
  nsUserIDList in 'Chat\nsUserIDList.pas',
  nsBaseChatHistoryList in 'Chat\nsBaseChatHistoryList.pas',
  nsChatHistoryList in 'Chat\nsChatHistoryList.pas',
  nsContactListNotifiers in 'Chat\nsContactListNotifiers.pas',
  nsCounterEvent in 'Data\nsCounterEvent.pas',
  ChatInterfacesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ChatInterfacesUnit.pas',
  nsGroupFilter in 'Data\Users\nsGroupFilter.pas',
  nsUserFlagsFilters in 'Data\Users\nsUserFlagsFilters.pas',
  nsUserTreeStruct in 'Data\Users\nsUserTreeStruct.pas',
  nsChatTreeStruct in 'Chat\nsChatTreeStruct.pas',
  nsChatMessages in 'Chat\nsChatMessages.pas',
  nsChatMessage in 'Chat\nsChatMessage.pas',
  nsNotifiers in 'Data\Common\nsNotifiers.pas',
  bsChatDispatcherPrim in 'Chat\bsChatDispatcherPrim.pas',
  bsChatDispatcher in 'Chat\bsChatDispatcher.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Chat_OpenContactList in 'View\Chat\kw_Chat_OpenContactList.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  BaseChat_Module in 'View\Chat\BaseChat_Module.pas',
  moChat in 'View\moChat.pas' {mo_Chat: TvcmModule},
  WorkJournalInterfaces in 'View\WorkJournalInterfaces.pas',
  WorkJournal_Strange_Controls in 'View\WorkJournal_Strange_Controls.pas',
  PrimWorkJournal_utWorkJournal_UserType in 'View\WorkJournal\Forms\PrimWorkJournal_utWorkJournal_UserType.pas',
  FoldersRes in 'View\FoldersRes.pas' {nsFoldersRes: TDataModule},
  UserJournalUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UserJournalUnit.pas',
  PrimWorkJournal_Form in 'View\WorkJournal\Forms\PrimWorkJournal_Form.pas',
  PrimWorkJournalOptions_Form in 'View\WorkJournal\Forms\PrimWorkJournalOptions_Form.pas',
  WorkJournal_Form in 'View\WorkJournal\Forms\WorkJournal_Form.pas' {WorkJournalForm: TvcmEntityForm},
  nsWorkJournalListeners in 'WorkJournal\nsWorkJournalListeners.pas',
  nsJournalTreeStruct in 'WorkJournal\nsJournalTreeStruct.pas',
  bsWorkJournalPrim in 'WorkJournal\bsWorkJournalPrim.pas',
  bsWorkJournal in 'WorkJournal\bsWorkJournal.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_WorkJournal_OpenJournal in 'View\WorkJournal\kw_WorkJournal_OpenJournal.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  BaseWorkJournal_Module in 'View\WorkJournal\BaseWorkJournal_Module.pas',
  moWorkJournal in 'View\moWorkJournal.pas' {mo_WorkJournal: TvcmModule},
  MonitoringUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\MonitoringUnit.pas',
  AutoreferatInterfaces in 'Autoreferat\AutoreferatInterfaces.pas',
  Autoreferat_InternalOperations_Controls in 'View\Autoreferat_InternalOperations_Controls.pas',
  PrimNewsLine_nltMain_UserType in 'View\Search\Forms\PrimNewsLine_nltMain_UserType.pas',
  PrimNewsLine_Form in 'View\Search\Forms\PrimNewsLine_Form.pas',
  nsNewsLine in 'View\Search\nsNewsLine.pas',
  PrimNewsLineOptions_Form in 'View\Search\Forms\PrimNewsLineOptions_Form.pas',
  NewsLine_Form in 'View\Search\Forms\NewsLine_Form.pas' {enNewsLine: TvcmEntityForm},
  fsAutoreferat in 'View\Search\fsAutoreferat.pas' {fs_Autoreferat: TvcmFormSetFactory},
  fsAutoreferatAfterSearch in 'View\Search\fsAutoreferatAfterSearch.pas' {fs_AutoreferatAfterSearch: TvcmFormSetFactory},
  vcmFormDataSourceRef in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceRef.pas',
  WorkWithListInterfaces in 'BusinessInterfaces\WorkWithListInterfaces.pas',
  evHolderDataObject in 'w:\common\components\gui\Garant\Everest\evHolderDataObject.pas',
  nevObjectHolder in 'w:\common\components\gui\Garant\Everest\nevObjectHolder.pas',
  nsDocumentToolsNew in 'F1DocumentProcessing\nsDocumentToolsNew.pas',
  nsIDocumentDataObject in 'F1DocumentProcessing\nsIDocumentDataObject.pas',
  nsDocumentPrintEvent in 'F1DocumentProcessing\nsDocumentPrintEvent.pas',
  nsAnnotationHeaderTagData in 'Autoreferat\nsAnnotationHeaderTagData.pas',
  nsAnnotationHeaderTagNode in 'Autoreferat\nsAnnotationHeaderTagNode.pas',
  nsF1AutoreferatDocumentTagNode in 'Autoreferat\nsF1AutoreferatDocumentTagNode.pas',
  nsAutoreferatDocumentContainer in 'Autoreferat\nsAutoreferatDocumentContainer.pas',
  dsAutoreferat in 'Autoreferat\dsAutoreferat.pas',
  dsNewsLine in 'Autoreferat\dsNewsLine.pas',
  dBaseDocument in 'Business\Document\dBaseDocument.pas',
  sdsAutoreferat in 'Autoreferat\sdsAutoreferat.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Monitorings_OpenNewsLine in 'View\Search\kw_Monitorings_OpenNewsLine.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Monitorings_OpenLegislationReview in 'View\Search\kw_Monitorings_OpenLegislationReview.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  PrimMonitorings_Module in 'View\Search\PrimMonitorings_Module.pas',
  moMonitorings in 'View\moMonitorings.pas' {mo_Monitorings: TvcmModule},
  PrimRememberPassword_Form in 'View\Common\Forms\PrimRememberPassword_Form.pas',
  ComCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas',
  PrimProgressIndicator_Form in 'View\Common\Forms\PrimProgressIndicator_Form.pas',
  PrimEULA_Form in 'View\Common\Forms\PrimEULA_Form.pas',
  Common_Strange_Controls in 'View\Common_Strange_Controls.pas',
  PrimTasksPanel_tpMain_UserType in 'View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas',
  PrimTasksPanel_Form in 'View\Common\Forms\PrimTasksPanel_Form.pas',
  CommonDictionInterfaces in 'CommonDiction\CommonDictionInterfaces.pas',
  PrimCommonDiction_utTips_UserType in 'View\Common\Forms\PrimCommonDiction_utTips_UserType.pas',
  PrimCommonDiction_utMedicDiction_UserType in 'View\Common\Forms\PrimCommonDiction_utMedicDiction_UserType.pas',
  PrimCommonDiction_Form in 'View\Common\Forms\PrimCommonDiction_Form.pas',
  PrimCommonDictionOptions_Form in 'View\Common\Forms\PrimCommonDictionOptions_Form.pas',
  PrimNavigator_utNavigator_UserType in 'View\Common\Forms\PrimNavigator_utNavigator_UserType.pas',
  PrimNavigator_Form in 'View\Common\Forms\PrimNavigator_Form.pas',
  PrimNavigatorOptions_Form in 'View\Common\Forms\PrimNavigatorOptions_Form.pas',
  vtRadioButton in 'w:\common\components\gui\Garant\VT\vtRadioButton.pas',
  vtDblClickDateEdit in 'w:\common\components\gui\Garant\VT\vtDblClickDateEdit.pas',
  PrimTurnOffTimeMachine_Form in 'View\Common\Forms\PrimTurnOffTimeMachine_Form.pas',
  PrimTurnOffTimeMachineOptions_Form in 'View\Common\Forms\PrimTurnOffTimeMachineOptions_Form.pas',
  RememberPassword_Form in 'View\Common\Forms\RememberPassword_Form.pas' {RememberPasswordForm: TvcmEntityForm},
  ProgressIndicator_Form in 'View\Common\Forms\ProgressIndicator_Form.pas' {efProgressIndicator: TvcmEntityForm},
  EULA_Form in 'View\Common\Forms\EULA_Form.pas' {efEULA: TvcmEntityForm},
  About_Form in 'View\Common\Forms\About_Form.pas' {efAbout: TvcmEntityForm},
  ComplectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ComplectUnit.pas',
  nsComplectInfoNode in 'Common\nsComplectInfoNode.pas',
  nsComplectInfoRootNode in 'Common\nsComplectInfoRootNode.pas',
  nsComplectInfoTreeStruct in 'Common\nsComplectInfoTreeStruct.pas',
  CompInfo_Form in 'View\Common\Forms\CompInfo_Form.pas' {enCompInfo: TvcmEntityForm},
  Registration_Form in 'View\Common\Forms\Registration_Form.pas' {nsRegistrationForm: TvcmEntityForm},
  nsNewCachableNode in 'Data\Tree\nsNewCachableNode.pas',
  TasksPanel_Form in 'View\Common\Forms\TasksPanel_Form.pas' {en_TasksPanel: TvcmEntityForm},
  CommonDiction_Form in 'View\Common\Forms\CommonDiction_Form.pas' {en_CommonDiction: TvcmEntityForm},
  nsRubricatorCache in 'Common\nsRubricatorCache.pas',
  nsNavigatorTreeStruct in 'Common\nsNavigatorTreeStruct.pas',
  Navigator_Form in 'View\Common\Forms\Navigator_Form.pas' {en_Navigator: TvcmEntityForm},
  TurnOffTimeMachine_Form in 'View\Common\Forms\TurnOffTimeMachine_Form.pas' {en_TurnOffTimeMachine: TvcmEntityForm}
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_ComplectInfo in 'View\Common\kw_Common_ComplectInfo.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_PageSetup in 'View\Common\kw_Common_PageSetup.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_ShowEULA in 'View\Common\kw_Common_ShowEULA.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_OpenMainMenuByButton in 'View\Common\kw_Common_OpenMainMenuByButton.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_OpenMainMenuNew in 'View\Common\kw_Common_OpenMainMenuNew.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_TasksPanel in 'View\Common\kw_Common_TasksPanel.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_LetterToDevelopers in 'View\Common\kw_Common_LetterToDevelopers.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_OpenRubricator in 'View\Common\kw_Common_OpenRubricator.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_OpenInformation in 'View\Common\kw_Common_OpenInformation.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_get_navigator in 'View\Common\kw_Common_get_navigator.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Common_OpenIntranet in 'View\Common\kw_Common_OpenIntranet.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  PrimF1Common_Module in 'View\Common\PrimF1Common_Module.pas',
  moCommon in 'View\moCommon.pas' {mo_Common: TvcmModule},
  DocumentDomainInterfaces in 'Model\DocumentDomainInterfaces.pas',
  eeSubPanelExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubPanelExport.pas',
  eeSubPanel in 'w:\common\components\gui\Garant\Everest_Engine\eeSubPanel.pas',
  DocumentUserTypes_dftDocSynchroView_UserType in 'View\DocumentUserTypes_dftDocSynchroView_UserType.pas',
  DocumentUserTypes_dftAutoreferatAfterSearch_UserType in 'View\DocumentUserTypes_dftAutoreferatAfterSearch_UserType.pas',
  DocumentUserTypes_dftConsultation_UserType in 'View\DocumentUserTypes_dftConsultation_UserType.pas',
  DocumentUserTypes_dftTranslation_UserType in 'View\DocumentUserTypes_dftTranslation_UserType.pas',
  DocumentUserTypes_dftAnnotationSynchroView_UserType in 'View\DocumentUserTypes_dftAnnotationSynchroView_UserType.pas',
  DocumentUserTypes_dftRelatedSynchroView_UserType in 'View\DocumentUserTypes_dftRelatedSynchroView_UserType.pas',
  DocumentUserTypes_dftDictEntry_UserType in 'View\DocumentUserTypes_dftDictEntry_UserType.pas',
  DocumentUserTypes_dftDictSubEntry_UserType in 'View\DocumentUserTypes_dftDictSubEntry_UserType.pas',
  DocumentUserTypes_dftAnnotation_UserType in 'View\DocumentUserTypes_dftAnnotation_UserType.pas',
  DocumentUserTypes_dftRelatedDoc_UserType in 'View\DocumentUserTypes_dftRelatedDoc_UserType.pas',
  DocumentUserTypes_dftTips_UserType in 'View\DocumentUserTypes_dftTips_UserType.pas',
  DocumentUserTypes_dftMedDictEntry_UserType in 'View\DocumentUserTypes_dftMedDictEntry_UserType.pas',
  DocumentUserTypes_dftAutoreferat_UserType in 'View\DocumentUserTypes_dftAutoreferat_UserType.pas',
  DocumentUserTypes_dftDrug_UserType in 'View\DocumentUserTypes_dftDrug_UserType.pas',
  DocumentUserTypes_dftMedicFirm_UserType in 'View\DocumentUserTypes_dftMedicFirm_UserType.pas',
  DocumentUserTypes_dftMedicFirmSynchroView_UserType in 'View\DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas',
  DocumentUserTypes_dftDrugSynchroView_UserType in 'View\DocumentUserTypes_dftDrugSynchroView_UserType.pas',
  DocumentUserTypes_dftNone_UserType in 'View\DocumentUserTypes_dftNone_UserType.pas',
  DocumentUserTypes_dftDocument_UserType in 'View\DocumentUserTypes_dftDocument_UserType.pas',
  nsTimeMachineOffEvent in 'View\Document\nsTimeMachineOffEvent.pas',
  Document_F1Lite_Controls in 'View\Document_F1Lite_Controls.pas',
  DictionInterfacesPrim in 'CommonDiction\DictionInterfacesPrim.pas',
  InpharmInterfaces in 'Medic\InpharmInterfaces.pas',
  BaseDocumentWithAttributesInterfaces in 'BusinessInterfaces\BaseDocumentWithAttributesInterfaces.pas',
  nsDocumentFromListNavigationEvent in 'View\nsDocumentFromListNavigationEvent.pas',
  Hypertext_Controls_Controls in 'LinksToGarant\Hypertext_Controls_Controls.pas',
  evConstStringStorable in 'w:\common\components\gui\Garant\Everest\evConstStringStorable.pas',
  evdTextToFirstParaAdder in 'w:\common\components\rtl\Garant\EVD\evdTextToFirstParaAdder.pas',
  evConstStringDataObject in 'w:\common\components\gui\Garant\Everest\evConstStringDataObject.pas',
  evConstStringData in 'w:\common\components\gui\Garant\EverestCommon\evConstStringData.pas',
  evdHyperlinkInfo in 'w:\common\components\rtl\Garant\EVD\evdHyperlinkInfo.pas',
  nsHyperlinkToDocumentProducerConst in 'LinksToGarant\nsHyperlinkToDocumentProducerConst.pas',
  WorkWithDocumentInterfaces in 'BusinessInterfaces\WorkWithDocumentInterfaces.pas',
  DocInfoInterfaces in 'BusinessInterfaces\DocInfoInterfaces.pas',
  vcmGUI in 'w:\common\components\gui\Garant\VCM\vcmGUI.pas',
  bsChangeRedationWorker in 'Data\Common\bsChangeRedationWorker.pas',
  evSubPanelSub in 'w:\common\components\gui\Garant\Everest\evSubPanelSub.pas',
  evSubPanelSubArrayPrim in 'w:\common\components\gui\Garant\Everest\evSubPanelSubArrayPrim.pas',
  evSubPanelSubArray in 'w:\common\components\gui\Garant\Everest\evSubPanelSubArray.pas',
  evSubPanelSubCollectionPrim in 'w:\common\components\gui\Garant\Everest\evSubPanelSubCollectionPrim.pas',
  evSubPanelSubCollection in 'w:\common\components\gui\Garant\Everest\evSubPanelSubCollection.pas',
  evSubPn in 'w:\common\components\gui\Garant\Everest\evSubPn.pas',
  vcmCommandIDsListPrim in 'w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsListPrim.pas',
  vcmCommandIDsList in 'w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsList.pas',
  vcmOVCCommands in 'w:\common\components\gui\Garant\VCM\implementation\vcmOVCCommands.pas',
  vcmUtils in 'w:\common\components\gui\Garant\VCM\implementation\vcmUtils.pas',
  deSimpleTree in 'Business\Document\deSimpleTree.pas',
  ExText_Form in 'View\Document\Forms\ExText_Form.pas',
  afwTextControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControlPrim.pas',
  afwTextControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControl.pas',
  vtPopupForm in 'w:\common\components\gui\Garant\VT\vtPopupForm.pas',
  vtPopupFormModelPart in 'w:\common\components\gui\Garant\VT\vtPopupFormModelPart.pas',
  vtReminder in 'w:\common\components\gui\Garant\VT\vtReminder.pas',
  vtReminderModelPart in 'w:\common\components\gui\Garant\VT\vtReminderModelPart.pas',
  nscCustomReminderModelPart in 'w:\common\components\gui\Garant\Nemesis\nscCustomReminderModelPart.pas',
  nscReminder in 'w:\common\components\gui\Garant\Nemesis\nscReminder.pas',
  vtRemindersLine in 'w:\common\components\gui\Garant\VT\vtRemindersLine.pas',
  vtRemindersLineModelPart in 'w:\common\components\gui\Garant\VT\vtRemindersLineModelPart.pas',
  nscRemindersLine in 'w:\common\components\gui\Garant\Nemesis\nscRemindersLine.pas',
  ExTextOptions_Form in 'View\Document\Forms\ExTextOptions_Form.pas',
  PrimSynchroView_svSynchroView_UserType in 'View\PrimSynchroView_svSynchroView_UserType.pas',
  PrimSynchroView_Form in 'View\PrimSynchroView_Form.pas',
  PrimSynchroViewOptions_Form in 'View\PrimSynchroViewOptions_Form.pas',
  PrimRedactions_utRedaction_UserType in 'View\PrimRedactions_utRedaction_UserType.pas',
  PrimRedactions_Form in 'View\PrimRedactions_Form.pas',
  PrimRedactionsOptions_Form in 'View\PrimRedactionsOptions_Form.pas',
  eeCustomMemo in 'w:\common\components\gui\Garant\Everest_Engine\eeCustomMemo.pas',
  eeMemo in 'w:\common\components\gui\Garant\Everest_Engine\eeMemo.pas',
  eeMemoWithEditOperations in 'w:\common\components\gui\Garant\Everest_Engine\eeMemoWithEditOperations.pas',
  PrimPictureInfo_Form in 'View\PrimPictureInfo_Form.pas',
  PrimPictureInfoOptions_Form in 'View\PrimPictureInfoOptions_Form.pas',
  PrimDocNumberQuery_Form in 'View\PrimDocNumberQuery_Form.pas',
  PrimDocNumberQueryOptions_Form in 'View\PrimDocNumberQueryOptions_Form.pas',
  AttributesUserTypes_fDocAttribute_UserType in 'View\AttributesUserTypes_fDocAttribute_UserType.pas',
  AttributesUserTypes_fAttributeSynchroView_UserType in 'View\AttributesUserTypes_fAttributeSynchroView_UserType.pas',
  nsSingleAttributeStorable in 'Common\nsSingleAttributeStorable.pas',
  nsSingleAttributeDataObject in 'Common\nsSingleAttributeDataObject.pas',
  nsSingleAttributeData in 'Common\nsSingleAttributeData.pas',
  PrimAttributes_Form in 'View\PrimAttributes_Form.pas',
  evTreeStorable in 'w:\common\components\gui\Garant\Everest\evTreeStorable.pas',
  evTreeDataObject in 'w:\common\components\gui\Garant\Everest\evTreeDataObject.pas',
  PrimAttributesOptions_Form in 'View\PrimAttributesOptions_Form.pas',
  imageenio in 'w:\common\components\rtl\external\ImageEn\src\imageenio.pas',
  eeGroupBox in 'w:\common\components\gui\Garant\Nemesis\eeGroupBox.pas',
  Buttons in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Buttons.pas',
  CommDlg in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CommDlg.pas',
  nsSaveDialog in 'Common\nsSaveDialog.pas',
  PrimPicture_pfImage_UserType in 'View\PrimPicture_pfImage_UserType.pas',
  PrimPicture_Form in 'View\PrimPicture_Form.pas',
  imageenview in 'w:\common\components\rtl\external\ImageEn\src\imageenview.pas',
  imageenproc in 'w:\common\components\rtl\external\ImageEn\src\imageenproc.pas',
  evBitmapDataObject in 'w:\common\components\gui\Garant\Everest\evBitmapDataObject.pas',
  nsObjectPreview in 'Printing\nsObjectPreview.pas',
  PrimPictureOptions_Form in 'View\PrimPictureOptions_Form.pas',
  vtShockwaveFlashEx in 'w:\common\components\gui\Garant\VT\vtShockwaveFlashEx.pas',
  PrimDocumentWithFlash_dwftMain_UserType in 'View\PrimDocumentWithFlash_dwftMain_UserType.pas',
  PrimDocumentWithFlash_dwftSynchro_UserType in 'View\PrimDocumentWithFlash_dwftSynchro_UserType.pas',
  FlashUtils in 'View\Common\FlashUtils.pas',
  PrimDocumentWithFlash_Form in 'View\PrimDocumentWithFlash_Form.pas',
  PrimDocumentWithFlashOptions_Form in 'View\PrimDocumentWithFlashOptions_Form.pas',
  TreeInterfaces in 'Tree\TreeInterfaces.pas',
  nevContainers in 'w:\common\components\gui\Garant\Everest\nevContainers.pas',
  PrimContents_utContents_UserType in 'View\PrimContents_utContents_UserType.pas',
  PrimContents_utDrugContents_UserType in 'View\PrimContents_utDrugContents_UserType.pas',
  nscTasksPanelView in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelView.pas',
  nevFlatSubsList in 'w:\common\components\gui\Garant\Everest\new\nevFlatSubsList.pas',
  nsContentsTreeStorable in 'Common\nsContentsTreeStorable.pas',
  vcmTaskPanelInterfaces in 'w:\common\components\gui\Garant\VCM\vcmTaskPanelInterfaces.pas',
  vcmTasksPanel in 'w:\common\components\gui\Garant\VCM\implementation\vcmTasksPanel.pas',
  nscTasksPanelGroupDescList in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupDescList.pas',
  nscTasksPanelGroup in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroup.pas',
  nscTasksPanelGroupsIterator in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupsIterator.pas',
  nscTasksPanel in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanel.pas',
  nsContentsListForFiltering in 'View\nsContentsListForFiltering.pas',
  PrimContents_Form in 'View\PrimContents_Form.pas',
  PrimContentsOptions_Form in 'View\PrimContentsOptions_Form.pas',
  PrimTurnOnTimeMachine_Form in 'View\PrimTurnOnTimeMachine_Form.pas',
  PrimTurnOnTimeMachineOptions_Form in 'View\PrimTurnOnTimeMachineOptions_Form.pas',
  DocumentWithFlash_Form in 'View\Document\Forms\DocumentWithFlash_Form.pas' {DocumentWithFlashForm: TvcmEntityForm},
  Text_Form in 'View\Document\Forms\Text_Form.pas' {TextForm: TvcmEntityForm},
  Redactions_Form in 'View\Document\Forms\Redactions_Form.pas' {RedactionsForm: TvcmEntityForm},
  Contents_Form in 'View\Document\Forms\Contents_Form.pas' {ContentsForm: TvcmEntityForm},
  nsDocAttributeTreeStruct in 'Common\nsDocAttributeTreeStruct.pas',
  dsAttributes in 'Business\Document\dsAttributes.pas',
  PrimListInterfaces in 'BusinessInterfaces\PrimListInterfaces.pas',
  deSearchInfo in 'Search\deSearchInfo.pas',
  deList in 'Search\deList.pas',
  deDocumentList in 'Business\Document\deDocumentList.pas',
  deListSet in 'Business\Document\deListSet.pas',
  nsContentsNode in 'f1DocumentTagsImplementation\nsContentsNode.pas',
  nsContentsTree in 'F1DocumentProcessing\nsContentsTree.pas',
  nsMedicContentsTree in 'F1DocumentProcessing\nsMedicContentsTree.pas',
  nsF1DocumentContainer in 'F1DocumentProcessing\nsF1DocumentContainer.pas',
  dsDocument in 'Business\Document\dsDocument.pas',
  nsINodesClipboardDataObject in 'Business\Document\nsINodesClipboardDataObject.pas',
  nsIListDataObject in 'Business\Document\nsIListDataObject.pas',
  ListRes in 'Business\List\ListRes.pas' {nsListRes: TDataModule},
  nsDocumentStreamWrapper in 'Business\Document\nsDocumentStreamWrapper.pas',
  afwDocumentPreviewList in 'w:\common\components\gui\Garant\AFW\implementation\afwDocumentPreviewList.pas',
  afwMultiDocumentPreview in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwMultiDocumentPreview.pas',
  evMultiDocumentPreview in 'w:\common\components\gui\Garant\Everest\evMultiDocumentPreview.pas',
  bsConst in 'Data\Common\bsConst.pas',
  ddHTMLReader in 'w:\common\components\rtl\Garant\dd\ddHTMLReader.pas',
  evHTMLDataObject in 'w:\common\components\gui\Garant\Everest\evHTMLDataObject.pas',
  nsSuperComplexDocumentPreview in 'Common\nsSuperComplexDocumentPreview.pas',
  nsNodesInterfacedDataObject in 'Business\List\nsNodesInterfacedDataObject.pas',
  nsNodesDataObject in 'Business\List\nsNodesDataObject.pas',
  bsListDataObject in 'Business\List\bsListDataObject.pas',
  bsListTreeData in 'Business\List\bsListTreeData.pas',
  bsListTreeStruct in 'Business\List\bsListTreeStruct.pas',
  nsListHAFMacroReplacer in 'Business\List\nsListHAFMacroReplacer.pas',
  nsListPrintEvent in 'Business\Document\nsListPrintEvent.pas',
  nsTreeMultiDocumentPreviewContainer in 'Common\nsTreeMultiDocumentPreviewContainer.pas',
  nsAddToListEvent in 'Business\List\nsAddToListEvent.pas',
  nsListSortEvent in 'Business\List\nsListSortEvent.pas',
  nsFindContextInListEvent in 'Business\List\nsFindContextInListEvent.pas',
  dsDocumentListCR in 'Business\Document\dsDocumentListCR.pas',
  dsDocumentList in 'Business\List\dsDocumentList.pas',
  nsChildDocInfoHAFMacroReplacer in 'Business\Document\nsChildDocInfoHAFMacroReplacer.pas',
  dsChildDocument in 'Business\Document\dsChildDocument.pas',
  dsAnnotation in 'Business\Document\dsAnnotation.pas',
  dsDocumentWithFlash in 'Business\Document\dsDocumentWithFlash.pas',
  bsFrozenNode in 'Data\Tree\bsFrozenNode.pas',
  deDocumentListCR in 'Business\Document\deDocumentListCR.pas',
  bsUserCRListInfo in 'Business\Document\bsUserCRListInfo.pas',
  dsTranslation in 'Business\Document\dsTranslation.pas',
  dsRelatedDoc in 'Business\Document\dsRelatedDoc.pas',
  dDocument in 'Document\dDocument.pas',
  dsDocumentListCRToPart in 'Document\dsDocumentListCRToPart.pas',
  dsBaseContentsRes in 'Business\Document\dsBaseContentsRes.pas',
  dsContents in 'Business\Document\dsContents.pas',
  dsEditions in 'Business\Document\dsEditions.pas',
  sdsDocument in 'Document\sdsDocument.pas',
  sdsDocumentWithFlash in 'Document\sdsDocumentWithFlash.pas',
  fsDocument in 'View\Document\fsDocument.pas' {fs_Document: TvcmFormSetFactory},
  fsDocumentWithFlash in 'View\Document\fsDocumentWithFlash.pas' {fs_DocumentWithFlash: TvcmFormSetFactory},
  Picture_Form in 'View\Document\Forms\Picture_Form.pas' {PictureForm: TvcmEntityForm},
  PictureInfo_Form in 'View\Document\Forms\PictureInfo_Form.pas' {en_PictureInfo: TvcmEntityForm},
  DocNumberQuery_Form in 'View\Document\Forms\DocNumberQuery_Form.pas' {DocNumberQueryForm: TvcmEntityForm},
  nsOpenDocOnNumberData in 'View\nsOpenDocOnNumberData.pas',
  Attributes_Form in 'View\Document\Forms\Attributes_Form.pas' {AttributesForm: TvcmEntityForm},
  SynchroView_Form in 'View\Document\Forms\SynchroView_Form.pas' {fcSynchroView: TvcmEntityForm},
  TurnOnTimeMachine_Form in 'View\Document\Forms\TurnOnTimeMachine_Form.pas' {en_TurnOnTimeMachine: TvcmEntityForm}
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Document_OpenDocOnNumber in 'View\Document\kw_Document_OpenDocOnNumber.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  Document_Module in 'View\Document\Document_Module.pas',
  moDocument in 'View\moDocument.pas' {mo_Document: TvcmModule},
  PrimListAnalizer_listAnalize_UserType in 'View\List\Forms\PrimListAnalizer_listAnalize_UserType.pas',
  PrimListAnalizer_Form in 'View\List\Forms\PrimListAnalizer_Form.pas',
  ListInterfaces in 'List\ListInterfaces.pas',
  bsOpenListInfo in 'View\List\bsOpenListInfo.pas',
  WorkWithList_StatusBar_Controls in 'View\WorkWithList_StatusBar_Controls.pas',
  PrimList_lftNone_UserType in 'View\List\Forms\PrimList_lftNone_UserType.pas',
  PrimList_lftRespondent_UserType in 'View\List\Forms\PrimList_lftRespondent_UserType.pas',
  PrimList_lftCorrespondent_UserType in 'View\List\Forms\PrimList_lftCorrespondent_UserType.pas',
  PrimList_lftSynchroView_UserType in 'View\List\Forms\PrimList_lftSynchroView_UserType.pas',
  PrimList_lftRCToPart_UserType in 'View\List\Forms\PrimList_lftRCToPart_UserType.pas',
  PrimList_lftUserCR1_UserType in 'View\List\Forms\PrimList_lftUserCR1_UserType.pas',
  PrimList_lftUserCR2_UserType in 'View\List\Forms\PrimList_lftUserCR2_UserType.pas',
  PrimList_lftConsultation_UserType in 'View\List\Forms\PrimList_lftConsultation_UserType.pas',
  PrimList_lftSimilarDocuments_UserType in 'View\List\Forms\PrimList_lftSimilarDocuments_UserType.pas',
  PrimList_lftSimilarDocumentsSynchroView_UserType in 'View\List\Forms\PrimList_lftSimilarDocumentsSynchroView_UserType.pas',
  PrimList_lftCorrespondentsSynchroForm_UserType in 'View\List\Forms\PrimList_lftCorrespondentsSynchroForm_UserType.pas',
  PrimList_lftRespondentsSynchroForm_UserType in 'View\List\Forms\PrimList_lftRespondentsSynchroForm_UserType.pas',
  PrimList_lftUserCRList1_SynchorForm_UserType in 'View\List\Forms\PrimList_lftUserCRList1_SynchorForm_UserType.pas',
  PrimList_lftUserCRList2_SynchorForm_UserType in 'View\List\Forms\PrimList_lftUserCRList2_SynchorForm_UserType.pas',
  PrimList_lftDrugList_UserType in 'View\List\Forms\PrimList_lftDrugList_UserType.pas',
  PrimList_lftDrugInternationalNameSynonyms_UserType in 'View\List\Forms\PrimList_lftDrugInternationalNameSynonyms_UserType.pas',
  PrimList_lftProducedDrugs_UserType in 'View\List\Forms\PrimList_lftProducedDrugs_UserType.pas',
  PrimList_lftProducedDrugsSynchroForm_UserType in 'View\List\Forms\PrimList_lftProducedDrugsSynchroForm_UserType.pas',
  PrimList_lftDrugInternationalNameSynonymsSynchroForm_UserType in 'View\List\Forms\PrimList_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas',
  WorkWithList_ListOperations_Controls in 'View\WorkWithList_ListOperations_Controls.pas',
  PrimList_Form in 'View\List\Forms\PrimList_Form.pas',
  PrimListOptions_Form in 'View\List\Forms\PrimListOptions_Form.pas',
  PrimListInfo_liListInfo_UserType in 'View\List\Forms\PrimListInfo_liListInfo_UserType.pas',
  PrimListInfo_Form in 'View\List\Forms\PrimListInfo_Form.pas',
  PrimListInfoOptions_Form in 'View\List\Forms\PrimListInfoOptions_Form.pas',
  List_Form in 'View\List\Forms\List_Form.pas' {efList: TvcmEntityForm},
  ListInfo_Form in 'View\List\Forms\ListInfo_Form.pas' {efListInfo: TvcmEntityForm},
  ListAnalizer_Form in 'View\List\Forms\ListAnalizer_Form.pas' {ListAnalizerForm: TvcmEntityForm},
  fsList in 'View\List\fsList.pas' {fs_List: TvcmFormSetFactory},
  dsSynchroView in 'Business\List\dsSynchroView.pas',
  dsListInfo in 'Business\List\dsListInfo.pas',
  dsMainList in 'List\dsMainList.pas',
  deFilter in 'List\deFilter.pas',
  dsFilters in 'List\dsFilters.pas',
  dList in 'List\dList.pas',
  sdsList in 'List\sdsList.pas',
  List_Module in 'View\List\List_Module.pas',
  moList in 'View\moList.pas' {mo_List: TvcmModule},
  DictionInterfaces in 'Diction\DictionInterfaces.pas',
  Diction_Strange_Controls in 'View\Diction_Strange_Controls.pas',
  PrimDiction_Form in 'View\Diction\Forms\PrimDiction_Form.pas',
  PrimDiction_utDiction_UserType in 'View\Diction\Forms\PrimDiction_utDiction_UserType.pas',
  PrimDictionOptions_Form in 'View\Diction\Forms\PrimDictionOptions_Form.pas',
  PrimDictionContainer_Form in 'View\Diction\Forms\PrimDictionContainer_Form.pas',
  Diction_Form in 'View\Diction\Forms\Diction_Form.pas' {enDiction: TvcmEntityForm},
  deCommonDiction in 'CommonDiction\deCommonDiction.pas',
  deDiction in 'Diction\deDiction.pas',
  nsDictListChild in 'Diction\nsDictListChild.pas',
  nsLangList in 'Diction\nsLangList.pas',
  nsDictCache in 'Diction\nsDictCache.pas',
  nsLayerFilter in 'Diction\nsLayerFilter.pas',
  nsLayeredTreeFilters in 'Diction\nsLayeredTreeFilters.pas',
  nsDictionTree in 'Diction\nsDictionTree.pas',
  dCommonDiction in 'CommonDiction\dCommonDiction.pas',
  dsSaveLoad in 'Search\dsSaveLoad.pas',
  dsChild in 'CommonDiction\dsChild.pas',
  dsDiction in 'Diction\dsDiction.pas',
  nsDictionDocumentContainer in 'DictionLikeDocumentProcessing\nsDictionDocumentContainer.pas',
  dsDictionDocument in 'Diction\dsDictionDocument.pas',
  l3InterfaceList in 'w:\common\components\rtl\Garant\L3\l3InterfaceList.pas',
  dDiction in 'Diction\dDiction.pas',
  sdsDiction in 'Diction\sdsDiction.pas',
  fsDiction in 'View\Diction\fsDiction.pas' {fs_Diction: TvcmFormSetFactory},
  DictionContainer_Form in 'View\Diction\Forms\DictionContainer_Form.pas' {DictionContainerForm: TvcmEntityForm}
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Diction_OpenDict in 'View\Diction\kw_Diction_OpenDict.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  Diction_Module in 'View\Diction\Diction_Module.pas',
  moDiction in 'View\moDiction.pas' {mo_Diction: TvcmModule},
  DayTipsInterfaces in 'DayTips\DayTipsInterfaces.pas',
  PrimStartupTips_Form in 'View\DayTips\Forms\PrimStartupTips_Form.pas',
  sdsCommonDiction in 'CommonDiction\sdsCommonDiction.pas',
  nsTipsDocumentContainer in 'DayTips\nsTipsDocumentContainer.pas',
  dsTipsDocument in 'DayTips\dsTipsDocument.pas',
  deTips in 'DayTips\deTips.pas',
  nsTipsTree in 'DayTips\nsTipsTree.pas',
  dsTips in 'DayTips\dsTips.pas',
  sdsTips in 'DayTips\sdsTips.pas',
  fsTips in 'View\DayTips\fsTips.pas' {fs_Tips: TvcmFormSetFactory},
  StartupTips_Form in 'View\DayTips\Forms\StartupTips_Form.pas' {efStartupTips: TvcmEntityForm},
  nsStartupTips in 'DayTips\nsStartupTips.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Tips_ShowDayTips in 'View\DayTips\kw_Tips_ShowDayTips.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  DayTips_Module in 'View\DayTips\DayTips_Module.pas',
  moTips in 'View\moTips.pas' {mo_Tips: TvcmModule},
  MainMenuDomainInterfaces in 'Common\MainMenuDomainInterfaces.pas',
  nsMainMenuNew in 'View\MainMenu\Forms\nsMainMenuNew.pas',
  nscInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscInterfaces.pas',
  nscHideField in 'w:\common\components\gui\Garant\Nemesis\nscHideField.pas',
  nscTreeViewHotTruck in 'w:\common\components\gui\Garant\Nemesis\nscTreeViewHotTruck.pas',
  nscArrangeGrid in 'w:\common\components\gui\Garant\Nemesis\nscArrangeGrid.pas',
  nscTabTable in 'w:\common\components\gui\Garant\Nemesis\nscTabTable.pas',
  PrimMainMenu_Form in 'View\MainMenu\Forms\PrimMainMenu_Form.pas',
  InpharmMainMenu_ut_mmmMain_UserType in 'View\Inpharm\Forms\InpharmMainMenu_ut_mmmMain_UserType.pas',
  InpharmMainMenu_Form in 'View\Inpharm\Forms\InpharmMainMenu_Form.pas',
  PrimMedicListSynchroView_mlsfDrugList_UserType in 'View\Inpharm\Forms\PrimMedicListSynchroView_mlsfDrugList_UserType.pas',
  Inpharm_Strange_Controls in 'View\Inpharm_Strange_Controls.pas',
  PrimMedicListSynchroView_mlsfMedicFirm_UserType in 'View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas',
  PrimMedicListSynchroView_Form in 'View\Inpharm\Forms\PrimMedicListSynchroView_Form.pas',
  MedicInterfaces in 'Medic\MedicInterfaces.pas',
  PrimMedicFirmList_mflMain_UserType in 'View\Inpharm\Forms\PrimMedicFirmList_mflMain_UserType.pas',
  PrimMedicFirmList_Form in 'View\Inpharm\Forms\PrimMedicFirmList_Form.pas',
  PrimMedicFirmListOptions_Form in 'View\Inpharm\Forms\PrimMedicFirmListOptions_Form.pas',
  dsMedicDictionDocument in 'Medic\dsMedicDictionDocument.pas',
  deMedicDiction in 'Medic\deMedicDiction.pas',
  nsMedicDictionTreeBase in 'Medic\nsMedicDictionTreeBase.pas',
  nsMedicDictionTree in 'Medic\nsMedicDictionTree.pas',
  dsMedicDiction in 'Medic\dsMedicDiction.pas',
  sdsMedicDiction in 'Medic\sdsMedicDiction.pas',
  dsMedicFirmDocument in 'Medic\dsMedicFirmDocument.pas',
  dsDrugList in 'Medic\dsDrugList.pas',
  dMedicFirmDocument in 'Medic\dMedicFirmDocument.pas',
  sdsMedicFirmDocument in 'Medic\sdsMedicFirmDocument.pas',
  dsBaseContents in 'Business\Document\dsBaseContents.pas',
  dsDrugDocument in 'Medic\dsDrugDocument.pas',
  dDrugDocument in 'Drug\dDrugDocument.pas',
  sdsDrugDocument in 'Drug\sdsDrugDocument.pas',
  fsMedicDiction in 'View\Inpharm\fsMedicDiction.pas' {fs_MedicDiction: TvcmFormSetFactory},
  fsMedicFirmDocument in 'View\Inpharm\fsMedicFirmDocument.pas' {fs_MedicFirmDocument: TvcmFormSetFactory},
  fsDrugDocument in 'View\Inpharm\fsDrugDocument.pas' {fs_DrugDocument: TvcmFormSetFactory},
  fsDrugList in 'View\Inpharm\fsDrugList.pas' {fs_DrugList: TvcmFormSetFactory},
  dsDrugListSynchroView in 'Drug\dsDrugListSynchroView.pas',
  dDrugList in 'Drug\dDrugList.pas',
  dsMainDrugList in 'Drug\dsMainDrugList.pas',
  dsDrugListDocument in 'Drug\dsDrugListDocument.pas',
  sdsDrugList in 'Drug\sdsDrugList.pas',
  fsMedicFirmList in 'View\Inpharm\fsMedicFirmList.pas' {fs_MedicFirmList: TvcmFormSetFactory},
  MedicMainMenu_Form in 'View\Inpharm\Forms\MedicMainMenu_Form.pas' {en_MedicMainMenu: TvcmEntityForm},
  MedicFirmList_Form in 'View\Inpharm\Forms\MedicFirmList_Form.pas' {en_MedicFirmList: TvcmEntityForm},
  MedicListSynchroView_Form in 'View\Inpharm\Forms\MedicListSynchroView_Form.pas' {en_MedicListSynchroView: TvcmEntityForm},
  dMedicFirmList in 'Medic\dMedicFirmList.pas',
  nsCountryFilter in 'Medic\nsCountryFilter.pas',
  nsMedicFirmListFilters in 'Medic\nsMedicFirmListFilters.pas',
  nsMedicFirmsTreeBase in 'Medic\nsMedicFirmsTreeBase.pas',
  nsMedicFirmsTree in 'Medic\nsMedicFirmsTree.pas',
  PharmFirmListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\PharmFirmListUnit.pas',
  nsMedicFirmsSubscribersList in 'Medic\nsMedicFirmsSubscribersList.pas',
  nsMedicFirmsCountryFilterTreeBase in 'Medic\nsMedicFirmsCountryFilterTreeBase.pas',
  nsMedicFirmsCountryFilterTree in 'Medic\nsMedicFirmsCountryFilterTree.pas',
  dsMedicFirmList in 'Medic\dsMedicFirmList.pas',
  dsMedicFirmSynchroView in 'Medic\dsMedicFirmSynchroView.pas',
  sdsMedicFirmList in 'Medic\sdsMedicFirmList.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Inpharm_MedicDiction in 'View\Inpharm\kw_Inpharm_MedicDiction.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Inpharm_MedicFirms in 'View\Inpharm\kw_Inpharm_MedicFirms.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Inpharm_DrugList in 'View\Inpharm\kw_Inpharm_DrugList.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Inpharm_MedicMainMenu in 'View\Inpharm\kw_Inpharm_MedicMainMenu.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  Inpharm_Module in 'View\Inpharm\Inpharm_Module.pas',
  moInpharm in 'View\moInpharm.pas' {mo_Inpharm: TvcmModule},
  PrimTreeAttributeFirstLevel_flSituation_UserType in 'View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas',
  PrimTreeAttributeFirstLevel_Form in 'View\Search\Forms\PrimTreeAttributeFirstLevel_Form.pas',
  PrimDefineSearchDate_Form in 'View\Search\Forms\PrimDefineSearchDate_Form.pas',
  FiltersUserTypes_utFilters_UserType in 'View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas',
  PrimOldSituationSearch_cutOldKeyWord_UserType in 'View\Search\Forms\PrimOldSituationSearch_cutOldKeyWord_UserType.pas',
  PrimOldSituationSearch_Form in 'View\Search\Forms\PrimOldSituationSearch_Form.pas',
  PrimOldSituationSearchOptions_Form in 'View\Search\Forms\PrimOldSituationSearchOptions_Form.pas',
  fsSituationSearch in 'View\Search\fsSituationSearch.pas' {fs_SituationSearch: TvcmFormSetFactory},
  fsSituationFilter in 'View\Search\fsSituationFilter.pas' {fs_SituationFilter: TvcmFormSetFactory},
  nsENOIntegration in 'Data\Common\nsENOIntegration.pas',
  DefineSearchDate_Form in 'View\Search\Forms\DefineSearchDate_Form.pas' {en_DefineSearchDate: TvcmEntityForm},
  TreeAttributeFirstLevel_Form in 'View\Search\Forms\TreeAttributeFirstLevel_Form.pas' {efTreeAttributeFirstLevel: TvcmEntityForm},
  OldSituationSearch_Form in 'View\Search\Forms\OldSituationSearch_Form.pas' {cfOldSituationSearch: TvcmEntityForm},
  deSearch in 'Search\deSearch.pas',
  nsSelectedAttributesIterators in 'Search\nsSelectedAttributesIterators.pas',
  dsTreeAttributeSelect in 'Search\dsTreeAttributeSelect.pas',
  dsSelectedAttributes in 'Search\dsSelectedAttributes.pas',
  deSelectedAttributes in 'Search\deSelectedAttributes.pas',
  dsTreeAttributeFirstLevel in 'Search\dsTreeAttributeFirstLevel.pas',
  dsAttributeSelect in 'Search\dsAttributeSelect.pas',
  sdsSituation in 'Search\sdsSituation.pas'
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_PublishSourceSearch in 'View\Search\kw_Search_PublishSourceSearch.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_InpharmSearch in 'View\Search\kw_Search_InpharmSearch.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_StartENO in 'View\Search\kw_Search_StartENO.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_DocumentsWithoutClass in 'View\Search\kw_Search_DocumentsWithoutClass.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_DocumentsWithoutIncluded in 'View\Search\kw_Search_DocumentsWithoutIncluded.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_DocumentsWithoutKey in 'View\Search\kw_Search_DocumentsWithoutKey.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_BaseSearch in 'View\Search\kw_Search_BaseSearch.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_OpenConsult in 'View\Search\kw_Search_OpenConsult.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_AllSearch in 'View\Search\kw_Search_AllSearch.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_OpenKeyWordSearch in 'View\Search\kw_Search_OpenKeyWordSearch.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Search_AttributeSearch in 'View\Search\kw_Search_AttributeSearch.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  Search_Module in 'View\Search\Search_Module.pas',
  moSearch in 'View\moSearch.pas' {mo_Search: TvcmModule},
  Rubricator_Strange_Controls in 'View\Rubricator_Strange_Controls.pas',
  nsRubricatorList in 'Rubricator\nsRubricatorList.pas',
  PrimRubricator_utRubricatorList_UserType in 'View\Rubricator\Forms\PrimRubricator_utRubricatorList_UserType.pas',
  RubricatorRes in 'View\Rubricator\RubricatorRes.pas' {nsRubricatorRes: TDataModule},
  PrimRubricator_Form in 'View\Rubricator\Forms\PrimRubricator_Form.pas',
  Rubricator_Form in 'View\Rubricator\Forms\Rubricator_Form.pas' {efRubricator: TvcmEntityForm},
  Rubricator_Module in 'View\Rubricator\Rubricator_Module.pas',
  moRubricator in 'View\moRubricator.pas' {mo_Rubricator: TvcmModule},
  Settings_Strange_Controls in 'View\Settings_Strange_Controls.pas',
  PrimSettings_cutSettings_UserType in 'View\Settings\Forms\PrimSettings_cutSettings_UserType.pas',
  nsConfigurationList in 'Config\nsConfigurationList.pas',
  nsAppConfigRes in 'Config\nsAppConfigRes.pas',
  ddAppConfigRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas',
  ddAppConfigListsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigListsRes.pas',
  ddAppConfigLists in 'w:\common\components\rtl\Garant\dd\ddAppConfigLists.pas',
  ddAppConfigStringsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas',
  ddAppConfigStrings in 'w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas',
  ddAppConfigTypesRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas',
  ddAppConfigTypes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas',
  ddAppConfig in 'w:\common\components\rtl\Garant\dd\ddAppConfig.pas',
  nsAppConfig in 'Config\nsAppConfig.pas',
  PrimSettings_Form in 'View\Settings\Forms\PrimSettings_Form.pas',
  PrimStyleEditorFont_Form in 'View\Settings\Forms\PrimStyleEditorFont_Form.pas',
  eeNode in 'w:\common\components\gui\Garant\Everest_Engine\eeNode.pas',
  PrimStyleEditorNavigator_Form in 'View\Settings\Forms\PrimStyleEditorNavigator_Form.pas',
  PrimStyleEditorExample_utStyleEditorExample_UserType in 'View\Settings\Forms\PrimStyleEditorExample_utStyleEditorExample_UserType.pas',
  PrimStyleEditorExample_Form in 'View\Settings\Forms\PrimStyleEditorExample_Form.pas',
  nsUserProperty in 'Data\Users\nsUserProperty.pas',
  PrimSelfInfo_Form in 'View\Settings\Forms\PrimSelfInfo_Form.pas',
  PrimConfigurationList_utConfigurationList_UserType in 'View\Settings\Forms\PrimConfigurationList_utConfigurationList_UserType.pas',
  PrimConfigurationList_Form in 'View\Settings\Forms\PrimConfigurationList_Form.pas',
  PrimStyleEditorContainer_utStyleEditorContainer_UserType in 'View\Settings\Forms\PrimStyleEditorContainer_utStyleEditorContainer_UserType.pas',
  PrimStyleEditorContainer_Form in 'View\Settings\Forms\PrimStyleEditorContainer_Form.pas',
  PrimStyleEditorContainerOptions_Form in 'View\Settings\Forms\PrimStyleEditorContainerOptions_Form.pas',
  StyleEditorContainer_Form in 'View\Settings\Forms\StyleEditorContainer_Form.pas' {StyleEditorContainerForm: TvcmEntityForm},
  StyleEditorFont_Form in 'View\Settings\Forms\StyleEditorFont_Form.pas' {StyleEditorFontForm: TvcmEntityForm},
  StyleEditorNavigator_Form in 'View\Settings\Forms\StyleEditorNavigator_Form.pas' {StyleEditorNavigatorForm: TvcmEntityForm},
  ConfigurationList_Form in 'View\Settings\Forms\ConfigurationList_Form.pas' {en_ConfigurationList: TvcmEntityForm},
  Settings_Form in 'View\Settings\Forms\Settings_Form.pas' {cf_Settings: TvcmEntityForm},
  StyleEditorExample_Form in 'View\Settings\Forms\StyleEditorExample_Form.pas' {StyleEditorExampleForm: TvcmEntityForm},
  SelfInfo_Form in 'View\Settings\Forms\SelfInfo_Form.pas' {SelfInfoForm: TvcmEntityForm}
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Settings_OpenStyleEditorAsModal in 'View\Settings\kw_Settings_OpenStyleEditorAsModal.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Settings_AutoLogin in 'View\Settings\kw_Settings_AutoLogin.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Settings_SelectConfig in 'View\Settings\kw_Settings_SelectConfig.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Settings_OpenConfList in 'View\Settings\kw_Settings_OpenConfList.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Settings_LoadActiveSettings in 'View\Settings\kw_Settings_LoadActiveSettings.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_Settings_UserProperties in 'View\Settings\kw_Settings_UserProperties.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  Settings_Module in 'View\Settings\Settings_Module.pas',
  moSettings in 'View\moSettings.pas' {mo_Settings: TvcmModule},
  MainMenuWithBaseSearchSupport_Form in 'View\MainMenu\Forms\MainMenuWithBaseSearchSupport_Form.pas',
  nsDataResetTree in 'Data\Tree\nsDataResetTree.pas',
  nsMainMenuNode in 'Common\nsMainMenuNode.pas',
  nsBaseMainMenuTree in 'Common\nsBaseMainMenuTree.pas',
  smTree in 'MainMenu\smTree.pas',
  smReferencesTree in 'MainMenu\smReferencesTree.pas',
  smLawNewsTree in 'MainMenu\smLawNewsTree.pas',
  smNewSchoolReferencesTree in 'MainMenu\smNewSchoolReferencesTree.pas',
  PrimLegalMainMenu_Form in 'View\MainMenu\Forms\PrimLegalMainMenu_Form.pas',
  vtPngImgList in 'w:\common\components\gui\Garant\VT\vtPngImgList.pas',
  BannerUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BannerUnit.pas',
  nscFocusLabel in 'w:\common\components\gui\Garant\Nemesis\nscFocusLabel.pas',
  PrimMainMenuNew_utMainMenuNew_UserType in 'View\MainMenu\Forms\PrimMainMenuNew_utMainMenuNew_UserType.pas',
  hyiedefs in 'w:\common\components\rtl\external\ImageEn\src\hyiedefs.pas',
  iemview in 'w:\common\components\rtl\external\ImageEn\src\iemview.pas',
  nscArrangeGridCell in 'w:\common\components\gui\Garant\Nemesis\nscArrangeGridCell.pas',
  nscFixedHeightControlCell in 'w:\common\components\gui\Garant\Nemesis\nscFixedHeightControlCell.pas',
  nscFixedWidthControlCell in 'w:\common\components\gui\Garant\Nemesis\nscFixedWidthControlCell.pas',
  nsHistoryTree in 'Common\nsHistoryTree.pas',
  nsJournalBookmarkNode in 'Common\nsJournalBookmarkNode.pas',
  nsLastOpenDocTree in 'Common\nsLastOpenDocTree.pas',
  smTaxes in 'MainMenu\smTaxes.pas',
  nscTabTableCell in 'w:\common\components\gui\Garant\Nemesis\nscTabTableCell.pas',
  hyieutils in 'w:\common\components\rtl\external\ImageEn\src\hyieutils.pas',
  PrimMainMenuNew_Form in 'View\MainMenu\Forms\PrimMainMenuNew_Form.pas',
  PrimSimpleMainMenu_utSimpleMainMenu_UserType in 'View\MainMenu\Forms\PrimSimpleMainMenu_utSimpleMainMenu_UserType.pas',
  PrimSimpleMainMenu_Form in 'View\MainMenu\Forms\PrimSimpleMainMenu_Form.pas',
  fsSimpleMainMenu in 'View\MainMenu\fsSimpleMainMenu.pas' {fs_SimpleMainMenu: TvcmFormSetFactory},
  MainMenuNew_Form in 'View\MainMenu\Forms\MainMenuNew_Form.pas' {en_MainMenuNew: TvcmEntityForm},
  MainMenuInterfaces in 'MainMenu\MainMenuInterfaces.pas',
  dsSimpleMainMenu in 'MainMenu\dsSimpleMainMenu.pas',
  sdsSimpleMainMenu in 'MainMenu\sdsSimpleMainMenu.pas',
  SimpleMainMenu_Form in 'View\MainMenu\Forms\SimpleMainMenu_Form.pas' {en_SimpleMainMenu: TvcmEntityForm},
  MainMenu_Module in 'View\MainMenu\MainMenu_Module.pas',
  moMainMenu in 'View\moMainMenu.pas' {mo_MainMenu: TvcmModule},
  PrimConsultationMark_utcmMain_UserType in 'View\Consultation\Forms\PrimConsultationMark_utcmMain_UserType.pas',
  PrimConsultationMark_Form in 'View\Consultation\Forms\PrimConsultationMark_Form.pas',
  PrimConsultationMarkOptions_Form in 'View\Consultation\Forms\PrimConsultationMarkOptions_Form.pas',
  nsConsultationHAFPainterImages_Form in 'Consultation\nsConsultationHAFPainterImages_Form.pas',
  nsConsultationDocumentContainerNew in 'Consultation\nsConsultationDocumentContainerNew.pas',
  dsConsultation in 'Consultation\dsConsultation.pas',
  dsConsultationMark in 'Consultation\dsConsultationMark.pas',
  dsConsultationList in 'Consultation\dsConsultationList.pas',
  bsConsultationManager in 'Consultation\bsConsultationManager.pas',
  sdsConsultation in 'Consultation\sdsConsultation.pas',
  ConsultationInterfaces in 'Consultation\ConsultationInterfaces.pas',
  dsQuery in 'Consultation\dsQuery.pas',
  sdsQuery in 'Consultation\sdsQuery.pas',
  dsSendConsultation in 'Consultation\dsSendConsultation.pas',
  sdsSendConsultation in 'Consultation\sdsSendConsultation.pas',
  fsSendConsultation in 'View\Consultation\fsSendConsultation.pas' {fs_SendConsultation: TvcmFormSetFactory},
  fsConsultation in 'View\Consultation\fsConsultation.pas' {fs_Consultation: TvcmFormSetFactory},
  ConsultationMark_Form in 'View\Consultation\Forms\ConsultationMark_Form.pas' {en_ConsultationMark: TvcmEntityForm},
  Consultation_Module in 'View\Consultation\Consultation_Module.pas',
  moConsultations in 'View\moConsultations.pas' {mo_Consultations: TvcmModule},
  PrimCustomizeTasksPanel_Form in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\PrimCustomizeTasksPanel_Form.pas',
  CustomizeTasksPanel_Form in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_Form.pas' {CustomizeTasksPanelForm: TvcmEntityForm}
  {$If defined(InsiderTest)}
  ,
  kw_TasksPanelMenu_Customize in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\kw_TasksPanelMenu_Customize.pas'
  {$IfEnd} //InsiderTest
  ,
  PrimTasksPanelMenu_Module in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\PrimTasksPanelMenu_Module.pas',
  moTasksPanelMenu in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\moTasksPanelMenu.pas' {mo_TasksPanelMenu: TvcmModule},
  PrimBaseSearchCard_Form in 'View\BaseSearch\Forms\PrimBaseSearchCard_Form.pas',
  BaseSearch_Controls in 'View\BaseSearch_Controls.pas',
  nscCustomTreeComboWithHistoryRes in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistoryRes.pas',
  nscCustomTreeComboWithHistory in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistory.pas',
  nscTreeComboWithHistory in 'w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistory.pas',
  nscTreeComboWithHistoryAndOperations in 'w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistoryAndOperations.pas',
  PrimBaseSearch_BaseSearch_UserType in 'View\BaseSearch\Forms\PrimBaseSearch_BaseSearch_UserType.pas',
  InsContextSearchHistoryNotifierList in 'View\InsContextSearchHistoryNotifierList.pas',
  nsDocumentContextHistoryPrim in 'View\nsDocumentContextHistoryPrim.pas',
  nsDocumentContextHistory in 'View\nsDocumentContextHistory.pas',
  nsInpharmContextHistoryPrim in 'View\nsInpharmContextHistoryPrim.pas',
  nsInpharmContextHistory in 'View\nsInpharmContextHistory.pas',
  nsContextHistory in 'View\nsContextHistory.pas',
  PrimBaseSearch_Form in 'View\BaseSearch\Forms\PrimBaseSearch_Form.pas',
  PrimBaseSearchOptions_Form in 'View\BaseSearch\Forms\PrimBaseSearchOptions_Form.pas',
  vg_listbox in 'w:\common\components\rtl\external\VGScene\vg_listbox.pas',
  vg_objects in 'w:\common\components\rtl\external\VGScene\vg_objects.pas',
  vg_layouts in 'w:\common\components\rtl\external\VGScene\vg_layouts.pas',
  NewBaseSearchForDFM_Form in 'View\BaseSearch\Forms\NewBaseSearchForDFM_Form.pas',
  PrimBaseSearchContainer_Form in 'View\BaseSearch\Forms\PrimBaseSearchContainer_Form.pas',
  BaseSearchCard_Form in 'View\BaseSearch\Forms\BaseSearchCard_Form.pas' {en_BaseSearchCard: TvcmEntityForm},
  NewBaseSearch_Form in 'View\BaseSearch\Forms\NewBaseSearch_Form.pas' {NewBaseSearchForm: TvcmEntityForm},
  BaseSearchContainer_Form in 'View\BaseSearch\Forms\BaseSearchContainer_Form.pas' {BaseSearchContainerForm: TvcmEntityForm},
  BaseSearch_Module in 'View\BaseSearch\BaseSearch_Module.pas',
  moBaseSearch in 'View\moBaseSearch.pas' {mo_BaseSearch: TvcmModule},
  Filters_Strange_Controls in 'View\Filters_Strange_Controls.pas',
  PrimFilters_Form in 'View\Filters\Forms\PrimFilters_Form.pas',
  PrimFiltersOptions_Form in 'View\Filters\Forms\PrimFiltersOptions_Form.pas',
  nsIFilterFromQueryList in 'View\Filters\nsIFilterFromQueryList.pas',
  Filters_Form in 'View\Filters\Forms\Filters_Form.pas' {enFilters: TvcmEntityForm},
  PrimCreateFilter_cfCreate_UserType in 'View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas',
  FiltersInterfaces in 'Filters\FiltersInterfaces.pas',
  PrimCreateFilter_cfRename_UserType in 'View\Filters\Forms\PrimCreateFilter_cfRename_UserType.pas',
  PrimCreateFilter_Form in 'View\Filters\Forms\PrimCreateFilter_Form.pas',
  CreateFilter_Form in 'View\Filters\Forms\CreateFilter_Form.pas' {CreateFilterForm: TvcmEntityForm},
  dsCreateFilter in 'Filters\dsCreateFilter.pas',
  Filters_Module in 'View\Filters\Filters_Module.pas',
  moFilters in 'View\moFilters.pas' {mo_Filters: TvcmModule},
  PrimUnderControl_utUnderControl_UserType in 'View\UnderControl\Forms\PrimUnderControl_utUnderControl_UserType.pas',
  PrimUnderControl_Form in 'View\UnderControl\Forms\PrimUnderControl_Form.pas',
  UnderControl_Strange_Controls in 'View\UnderControl_Strange_Controls.pas',
  PrimUnderControlOptions_Form in 'View\UnderControl\Forms\PrimUnderControlOptions_Form.pas',
  UnderControl_Form in 'View\UnderControl\Forms\UnderControl_Form.pas' {enUnderControl: TvcmEntityForm},
  UnderControl_Module in 'View\UnderControl\UnderControl_Module.pas',
  moUnderControl in 'View\moUnderControl.pas' {mo_UnderControl: TvcmModule}
  {$If defined(InsiderTest) AND not defined(Admin) AND not defined(Monitorings)}
  ,
  kw_DocumentListFromFile_OpenDocumentListFromFile in 'View\DocumentListFromFile\kw_DocumentListFromFile_OpenDocumentListFromFile.pas'
  {$IfEnd} //InsiderTest AND not Admin AND not Monitorings
  ,
  PrimDocumentListFromFile_Module in 'View\DocumentListFromFile\PrimDocumentListFromFile_Module.pas',
  moDocumentListFromFile in 'View\moDocumentListFromFile.pas' {mo_DocumentListFromFile: TvcmModule},
  ChangesBetweenEditionsInterfaces in 'ChangesBetweenEditions\ChangesBetweenEditionsInterfaces.pas',
  PrimChangesBetweenEditons_DocumentChanges_UserType in 'View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_DocumentChanges_UserType.pas',
  PrimChangesBetweenEditons_Form in 'View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_Form.pas',
  ChangesBetweenEditons_Form in 'View\ChangesBetweenEditons\Forms\ChangesBetweenEditons_Form.pas' {ChangesBetweenEditonsForm: TvcmEntityForm},
  nsChangesBetweenEditionsDocumentContainer in 'ChangesBetweenEditions\nsChangesBetweenEditionsDocumentContainer.pas',
  dsChangesBetweenEditions in 'ChangesBetweenEditions\dsChangesBetweenEditions.pas',
  sdsChangesBetweenEditionsData in 'ChangesBetweenEditions\sdsChangesBetweenEditionsData.pas',
  sdsChangesBetweenEditions in 'ChangesBetweenEditions\sdsChangesBetweenEditions.pas',
  nsChangesBetweenEditionsInfo in 'ChangesBetweenEditions\nsChangesBetweenEditionsInfo.pas',
  fsViewChangedFragments in 'View\ChangesBetweenEditons\fsViewChangedFragments.pas' {fs_ViewChangedFragments: TvcmFormSetFactory},
  ChangesBetweenEditions_Module in 'View\ChangesBetweenEditons\ChangesBetweenEditions_Module.pas',
  moChangesBetweenEditions in 'View\moChangesBetweenEditions.pas' {mo_ChangesBetweenEditions: TvcmModule},
  NemesisRes in 'NemesisRes.pas' {NemesisRes: TvcmApplication},
  MainOptions_Form in 'MainOptions_Form.pas',
  TestFrameWork in 'w:\common\components\rtl\external\DUnit\src\TestFrameWork.pas',
  TextTestRunner in 'w:\common\components\rtl\external\DUnit\src\TextTestRunner.pas',
  GUITestRunner in 'w:\common\components\rtl\external\DUnit\src\GUITestRunner.pas',
  l3CardinalList in 'w:\common\components\rtl\Garant\L3\l3CardinalList.pas',
  l3FileUtils in 'w:\common\components\rtl\Garant\L3\l3FileUtils.pas'
  {$If defined(MTDORB)}
  ,
  SecuritySrv_int in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv_int.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  Contents_int in 'w:\common\components\rtl\Garant\ServerGate\Contents_int.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  orb_int in 'w:\common\components\rtl\external\MTDOrb\src\orbint\orb_int.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  CosNaming_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming_int.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  pi_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi_int.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  orb in 'w:\common\components\rtl\external\MTDOrb\src\orb\orb.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  pi in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  orbtypes in 'w:\common\components\rtl\external\MTDOrb\src\orb\orbtypes.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  GarClientSecurity in 'w:\common\components\rtl\Garant\GarORB\GarClientSecurity.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  pi_impl in 'w:\common\components\rtl\external\MTDOrb\src\orb\pi_impl.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  GarORBInitializerImpl in 'w:\common\components\rtl\Garant\GarORB\GarORBInitializerImpl.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  CosNaming in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  SecuritySrv in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB)}
  ,
  Contents in 'w:\common\components\rtl\Garant\ServerGate\Contents.pas'
  {$IfEnd} //MTDORB
  
  {$If defined(MTDORB) AND defined(NoKPageTool)}
  ,
  KBridge in 'w:\common\components\rtl\Garant\DUnitTuning\KBridge.pas'
  {$IfEnd} //MTDORB AND NoKPageTool
  ,
  l3ImageUtils in 'w:\common\components\rtl\Garant\L3\l3ImageUtils.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas',
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  BaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\BaseTest.pas',
  JclSysInfo in 'w:\common\components\rtl\external\JEDI\source\common\JclSysInfo.pas',
  l3DateSt in 'w:\common\components\rtl\Garant\L3\l3DateSt.pas',
  ExcludedTests in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTests.pas',
  ExcludedTestsFolders in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTestsFolders.pas',
  TestNameList in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameList.pas',
  KTestRunner in 'w:\common\components\rtl\Garant\DUnitTuning\KTestRunner.pas',
  vcmBaseEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollectionItem.pas',
  kwEntityOperation in 'w:\common\components\rtl\Garant\DUnitTuning\kwEntityOperation.pas'
  {$If defined(nsTest)}
  ,
  vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
  {$IfEnd} //nsTest
  
  {$If defined(InsiderTest)}
  ,
  tfwScriptDebugger in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptDebugger.pas'
  {$IfEnd} //InsiderTest
  ,
  CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas',
  InsiderOwnScripter in 'F1_Shell_Tests\InsiderOwnScripter.pas',
  F1AutoScripter in 'F1_Shell_Tests\F1AutoScripter.pas',
  K233013564 in 'F1_Shell_Tests\K233013564.pas',
  Open10003000 in 'F1_Shell_Tests\Open10003000.pas',
  Open10003000External in 'F1_Shell_Tests\Open10003000External.pas',
  Open10003000ByString in 'F1_Shell_Tests\Open10003000ByString.pas',
  EmitString in 'F1_Shell_Tests\EmitString.pas',
  ovcTest in 'F1_Shell_Tests\ovcTest.pas',
  K265391680 in 'F1_Shell_Tests\K265391680.pas',
  ModifyListTest in 'F1_Shell_Tests\ModifyListTest.pas',
  FilterListTest in 'F1_Shell_Tests\FilterListTest.pas',
  ListTimeMachineTest in 'F1_Shell_Tests\ListTimeMachineTest.pas',
  K265404457 in 'F1_Shell_Tests\K265404457.pas',
  K265410566 in 'F1_Shell_Tests\K265410566.pas',
  toK in 'toK.pas',
  ItsLAW in 'ItsLAW.pas',
  kwEditorDeleteUserComment in 'F1_Words\kwEditorDeleteUserComment.pas',
  kwDocumentsCacheClear in 'F1_Words\kwDocumentsCacheClear.pas',
  kwWaitYes in 'F1_Words\kwWaitYes.pas',
  kwWaitNo in 'F1_Words\kwWaitNo.pas',
  kwWasWait in 'F1_Words\kwWasWait.pas',
  kwTryFocus in 'F1_Words\kwTryFocus.pas',
  kwControlVisible in 'F1_Words\kwControlVisible.pas',
  kwApplicationActionIdle in 'F1_Words\kwApplicationActionIdle.pas',
  kwControlClick in 'F1_Words\kwControlClick.pas',
  kwFiltersList in 'F1_Words\kwFiltersList.pas',
  kwControlGetHandle in 'F1_Words\kwControlGetHandle.pas',
  kwControlSetFocus in 'F1_Words\kwControlSetFocus.pas',
  kwTreeSetSelected in 'F1_Words\kwTreeSetSelected.pas',
  kwReminderIsBaloonVisible in 'F1_Words\kwReminderIsBaloonVisible.pas',
  kwTimeMachineSetDate in 'F1_Words\kwTimeMachineSetDate.pas',
  kwEditorHasComment in 'F1_Words\kwEditorHasComment.pas',
  kwExportHelp in 'F1_Words\kwExportHelp.pas',
  kwCheckEtalon in 'F1_Words\kwCheckEtalon.pas',
  kwEditorCurrentText in 'F1_Words\kwEditorCurrentText.pas',
  kwEditorParaDown in 'F1_Words\kwEditorParaDown.pas',
  evdMarkEliminator in 'w:\common\components\rtl\Garant\EVD\evdMarkEliminator.pas',
  kwEditorTextToFile in 'F1_Words\kwEditorTextToFile.pas',
  kwReminderTryFocusEditor in 'F1_Words\kwReminderTryFocusEditor.pas',
  kwWaitOk in 'F1_Words\kwWaitOk.pas',
  kwTryFocusOnForm in 'F1_Words\kwTryFocusOnForm.pas',
  f1WordsPack in 'F1_Words\f1WordsPack.pas',
  kwAttributeSearch in 'F1_Words\kwAttributeSearch.pas',
  kwMainMenu in 'F1_Words\kwMainMenu.pas',
  kwOk in 'F1_Words\kwOk.pas',
  kwOpenDocument in 'F1_Words\kwOpenDocument.pas',
  CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas',
  F1AutoTestSuite in 'F1_Shell_Tests\F1AutoTestSuite.pas',
  kwDocumentSetBookmark in 'F1_Shell_Words\kwDocumentSetBookmark.pas',
  kwStyleTableSaveToFile in 'F1_Shell_Words\kwStyleTableSaveToFile.pas',
  F1ShellWordsPack in 'F1_Shell_Words\F1ShellWordsPack.pas',
  F1ScriptEngine in 'F1_Shell_Tests\F1ScriptEngine.pas',
  toK64 in 'toK64.pas',
  NemesisTestRes in 'NemesisTestRes.pas' {NemesisTestRes: TvcmApplication}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$R NemesisAppTest.res}

begin
 g_CVSPath := 'w:\garant6x\implementation\Garant\GbaNemesis';
 //#UC START# *4D9F2DB20054CVSPath*
 //#UC END# *4D9F2DB20054CVSPath*
 TF1AutoTestSuite.Register;
 StdRes.TdmStdRes.Run(str_NemesisTitle, 'F1Shell.chm');
end.