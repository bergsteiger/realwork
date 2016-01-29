program AdapterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterTest.dpr"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ExeTarget::Category>> garant6x_test::AdapterTest$Target
//
// Консольные тесты адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$APPTYPE CONSOLE}

uses
  Types,
  Windows {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas' {$EndIf},
  ActiveX {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas' {$EndIf},
  SysUtils,
  l3PureMixIns in 'w:\common\components\rtl\Garant\L3\l3PureMixIns.pas',
  Messages {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas',
  l3Types in 'w:\common\components\rtl\Garant\L3\l3Types.pas',
  l3Const in 'w:\common\components\rtl\Garant\L3\l3Const.pas',
  k2BaseTypes in 'w:\common\components\rtl\Garant\L3\k2BaseTypes.pas',
  l3CastablePersistent in 'w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas',
  l3IID in 'w:\common\components\rtl\Garant\L3\l3IID.pas',
  l3InterfacesMisc in 'w:\common\components\rtl\Garant\L3\l3InterfacesMisc.pas',
  l3DataContainerWithoutIUnknownPrim in 'w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknownPrim.pas',
  l3Variants in 'w:\common\components\rtl\Garant\L3\l3Variants.pas',
  l3String in 'w:\common\components\rtl\Garant\L3\l3String.pas',
  l3Chars in 'w:\common\components\rtl\Garant\L3\l3Chars.pas',
  l3Date in 'w:\common\components\rtl\Garant\L3\l3Date.pas',
  l3Variant in 'w:\common\components\rtl\Garant\L3\l3Variant.pas',
  l3BMSearch in 'w:\common\components\rtl\Garant\L3\l3BMSearch.pas',
  l3StringEx in 'w:\common\components\rtl\Garant\L3\l3StringEx.pas',
  l3Units in 'w:\common\components\rtl\Garant\L3\l3Units.pas'
  {$If not defined(NoScripts)}
  ,
  FontWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3ProtoDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas',
  l3Except in 'w:\common\components\rtl\Garant\L3\l3Except.pas',
  RTLConsts {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\RTLConsts.pas' {$EndIf},
  l3MinMax in 'w:\common\components\rtl\Garant\L3\l3MinMax.pas'
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryPrimPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrimPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrim.pas'
  {$IfEnd} //not NoScripts
  ,
  TypInfo {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas' {$EndIf},
  l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas',
  l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas'
  {$If not defined(NoScripts)}
  ,
  tfwCStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCStringList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCStringArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCStringArraySing in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCStringArraySing2 in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringFactory.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwClassRef in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassRef.pas'
  {$IfEnd} //not NoScripts
  ,
  l3CastableObject in 'w:\common\components\rtl\Garant\L3\l3CastableObject.pas',
  StrUtils {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  tfwAutoregisteredDiction in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAutoregisteredDiction.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas'
  {$IfEnd} //not NoScripts
  
(*  {$If not defined(NoScripts)}
  ,
  kwFontWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontSize in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontSize.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontName in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontName.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontColor in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontColor.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontIsItalic in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontIsItalic.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontIsBold in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontIsBold.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontIsUnderline in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontIsUnderline.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFontIsStrikeOut in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontIsStrikeOut.pas'
  {$IfEnd} //not NoScripts*)
  ,
  ActnList {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ActnList.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  WinControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinControlsProcessingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ScrollingWinControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollingWinControlWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  FormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwObjectFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwObjectFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwComponentFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwWinControlFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWinControlFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCustomFormFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCustomFormFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormFormStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormFormStyle.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFormFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwFormFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormSetWindowState in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormSetWindowState.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormGetWindowState in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormGetWindowState.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormNext in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormNext.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormHasControl in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormHasControl.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormMDIChildCount in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormMDIChildCount.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormMDIChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormMDIChildren.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormClose in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormClose.pas'
  {$IfEnd} //not NoScripts
  ,
  l3SimpleDataContainer in 'w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas',
  l3ObjectList in 'w:\common\components\rtl\Garant\L3\l3ObjectList.pas'
  {$If not defined(NoScripts)}
  ,
  kwIterateForms in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateForms.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormActiveMDIChild in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormActiveMDIChild.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormModalResult in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormModalResult.pas'
  {$IfEnd} //not NoScripts
  ,
  Menus {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Menus.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  MenuWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\MenuWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuItemFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuItemFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuitemGetCount in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemGetCount.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuitemGetCaption in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemGetCaption.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuitemGetItem in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemGetItem.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuitemIsVisible in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemIsVisible.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuitemIsEnabled in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemIsEnabled.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMenuitemClick in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemClick.pas'
  {$IfEnd} //not NoScripts
  ,
  l3Defaults in 'w:\common\components\rtl\Garant\L3\l3Defaults.pas',
  l3Stream in 'w:\common\components\rtl\Garant\L3\l3Stream.pas',
  l3LongintListPrim in 'w:\common\components\rtl\Garant\L3\l3LongintListPrim.pas',
  l3LongintList in 'w:\common\components\rtl\Garant\L3\l3LongintList.pas',
  l3RectList in 'w:\common\components\rtl\Garant\L3\l3RectList.pas',
  l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas',
  l3CanvasPrim in 'w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas',
  l3LineArray in 'w:\common\components\rtl\Garant\L3\l3LineArray.pas',
  l3Region in 'w:\common\components\rtl\Garant\L3\l3Region.pas',
  l3Canvas in 'w:\common\components\rtl\Garant\L3\l3Canvas.pas',
  l3ScreenIC in 'w:\common\components\rtl\Garant\L3\l3ScreenIC.pas'
  {$If not defined(NoScripts)}
  ,
  kwMenuitemGetMenuHeight in 'w:\common\components\rtl\Garant\ScriptEngine\kwMenuitemGetMenuHeight.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopFormFindMenuItem in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopFormFindMenuItem.pas'
  {$IfEnd} //not NoScripts
  ,
  Forms {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Forms.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  ScrollInfoProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollInfoProcessingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwScrollInfoWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwScrollInfoWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopControlScrollInfo in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfo.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopControlScrollInfoMin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMin.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopControlScrollInfoMax in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMax.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopControlScrollInfoPageSize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPageSize.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopControlScrollInfoPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPosition.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ControlsProcessingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  //,
  //kwFocusedControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwFocusedControlWord.pas'
  {$IfEnd} //not NoScripts

  {$If not defined(NoScripts)}
  //,
  //kwFocusedControlPush in 'w:\common\components\rtl\Garant\ScriptEngine\kwFocusedControlPush.pas'
  {$IfEnd} //not NoScripts
  ,
  l3CloseFormHelper in 'w:\common\components\rtl\Garant\L3\l3CloseFormHelper.pas',
  l3MessagesService in 'w:\common\components\rtl\Garant\L3\l3MessagesService.pas',
  l3FormsService in 'w:\common\components\rtl\Garant\L3\l3FormsService.pas'
  {$If not defined(NoScripts)}
  ,
  kwControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwControlWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwBynameControlPush in 'w:\common\components\rtl\Garant\ScriptEngine\kwBynameControlPush.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  //,
  //kwByhandleControlPush in 'w:\common\components\rtl\Garant\ScriptEngine\kwByhandleControlPush.pas'
  {$IfEnd} //not NoScripts
  ,
  l3PopupMenuHelper in 'w:\common\components\rtl\Garant\L3\l3PopupMenuHelper.pas',
  Controls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Controls.pas' {$EndIf},
  evdStyles in 'w:\common\components\rtl\Garant\EVD\evdStyles.pas',
  l3ProtoIntegerList in 'w:\common\components\rtl\Garant\L3\l3ProtoIntegerList.pas',
  k2PropertyArray in 'w:\common\components\rtl\Garant\K2\k2PropertyArray.pas',
  k2TypeTableCreatedListeners in 'w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas',
  k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas',
  k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas',
  k2Empty_Const in 'w:\common\components\rtl\Garant\K2\k2Empty_Const.pas',
  k2Attributes in 'w:\common\components\rtl\Garant\K2\k2Attributes.pas',
  k2Prim in 'w:\common\components\rtl\Garant\K2\k2Prim.pas',
  k2Interfaces in 'w:\common\components\rtl\Garant\K2\k2Interfaces.pas'
  {$If not defined(NoScripts)}
  ,
  l3NodesKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\l3NodesKeyWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas'
  {$If not defined(NoScripts)}
  ,
  InterfacedNodeWords in 'w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas'
  {$IfEnd} //not NoScripts
  ,
  l3Tree_TLB in 'w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas',
  afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas',
  ImgList {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas' {$EndIf},
  afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas',
  k2SortTagsListPrim in 'w:\common\components\rtl\Garant\K2\k2SortTagsListPrim.pas',
  k2SortTagsList in 'w:\common\components\rtl\Garant\K2\k2SortTagsList.pas',
  k2Object_Const in 'w:\common\components\rtl\Garant\K2\k2Object_Const.pas',
  k2SomeDataContainer_Const in 'w:\common\components\rtl\Garant\K2\k2SomeDataContainer_Const.pas',
  k2l3Base_Const in 'w:\common\components\rtl\Garant\K2\k2l3Base_Const.pas',
  k2Long_Const in 'w:\common\components\rtl\Garant\K2\k2Long_Const.pas',
  k2Enum_Const in 'w:\common\components\rtl\Garant\K2\k2Enum_Const.pas',
  k2AtomWrapPrim in 'w:\common\components\rtl\Garant\K2\k2AtomWrapPrim.pas',
  k2PropSorter in 'w:\common\components\rtl\Garant\K2\k2PropSorter.pas',
  k2Tag in 'w:\common\components\rtl\Garant\K2\k2Tag.pas',
  k2NotStructuredTag in 'w:\common\components\rtl\Garant\K2\k2NotStructuredTag.pas',
  k2SpecialTag in 'w:\common\components\rtl\Garant\K2\k2SpecialTag.pas',
  k2Strings in 'w:\common\components\rtl\Garant\K2\k2Strings.pas',
  k2NullTagImplPrim in 'w:\common\components\rtl\Garant\K2\k2NullTagImplPrim.pas',
  k2NullTagImpl in 'w:\common\components\rtl\Garant\K2\k2NullTagImpl.pas',
  k2Base in 'w:\common\components\rtl\Garant\K2\k2Base.pas',
  Object_Wrap in 'w:\common\components\rtl\Garant\K2\Object_Wrap.pas',
  Persistent_Wrap in 'w:\common\components\rtl\Garant\K2\Persistent_Wrap.pas',
  l3_String in 'w:\common\components\rtl\Garant\L3\l3_String.pas',
  k2NonAtomicTag in 'w:\common\components\rtl\Garant\K2\k2NonAtomicTag.pas',
  k2ListTag in 'w:\common\components\rtl\Garant\K2\k2ListTag.pas',
  k2TagListPrim in 'w:\common\components\rtl\Garant\K2\k2TagListPrim.pas',
  k2TagList in 'w:\common\components\rtl\Garant\K2\k2TagList.pas',
  k2ToolPrim in 'w:\common\components\rtl\Garant\K2\k2ToolPrim.pas',
  k2InterfaceList in 'w:\common\components\rtl\Garant\K2\k2InterfaceList.pas',
  l3ProtoObjectRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectRefList.pas',
  k2ToolPrimList in 'w:\common\components\rtl\Garant\K2\k2ToolPrimList.pas',
  k2ToolCacheList in 'w:\common\components\rtl\Garant\K2\k2ToolCacheList.pas',
  k2InterfaceCache in 'w:\common\components\rtl\Garant\K2\k2InterfaceCache.pas',
  k2TagPointer in 'w:\common\components\rtl\Garant\K2\k2TagPointer.pas',
  k2InterfaceFactory in 'w:\common\components\rtl\Garant\K2\k2InterfaceFactory.pas',
  k2List in 'w:\common\components\rtl\Garant\K2\k2List.pas',
  l3CacheableBase in 'w:\common\components\rtl\Garant\L3\l3CacheableBase.pas',
  k2NilOp in 'w:\common\components\rtl\Garant\K2\k2NilOp.pas',
  k2Op in 'w:\common\components\rtl\Garant\K2\k2Op.pas',
  k2OpRefList in 'w:\common\components\rtl\Garant\K2\k2OpRefList.pas',
  l3ConstStrings1 in 'w:\common\components\rtl\Garant\L3\l3ConstStrings1.pas',
  l3ConstStrings in 'w:\common\components\rtl\Garant\L3\l3ConstStrings.pas',
  l3StringIDEx in 'w:\common\components\rtl\Garant\L3\l3StringIDEx.pas',
  l3BaseWithID in 'w:\common\components\rtl\Garant\L3\l3BaseWithID.pas',
  l3BaseWithIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDListPrim.pas',
  l3BaseWithIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDList.pas',
  l3ValueMap in 'w:\common\components\rtl\Garant\L3\l3ValueMap.pas',
  l3ValueMapManagerPrim in 'w:\common\components\rtl\Garant\L3\l3ValueMapManagerPrim.pas',
  l3ValueMapManager in 'w:\common\components\rtl\Garant\L3\l3ValueMapManager.pas',
  l3IntegerValueMapManager in 'w:\common\components\rtl\Garant\L3\l3IntegerValueMapManager.pas',
  Dialogs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas' {$EndIf},
  Pl3StringIDExList in 'w:\common\components\rtl\Garant\L3\Pl3StringIDExList.pas',
  Pl3MessageIDListPrim in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDListPrim.pas',
  Pl3MessageIDList in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDList.pas',
  l3MessageID in 'w:\common\components\rtl\Garant\L3\l3MessageID.pas',
  k2OperationContainer in 'w:\common\components\rtl\Garant\K2\k2OperationContainer.pas',
  k2Context in 'w:\common\components\rtl\Garant\K2\k2Context.pas',
  k2NonOptimizeContext in 'w:\common\components\rtl\Garant\K2\k2NonOptimizeContext.pas',
  k2DictionaryPrim in 'w:\common\components\rtl\Garant\K2\k2DictionaryPrim.pas',
  k2DictionaryIDIndexPrim in 'w:\common\components\rtl\Garant\K2\k2DictionaryIDIndexPrim.pas',
  k2DictionaryIDIndex in 'w:\common\components\rtl\Garant\K2\k2DictionaryIDIndex.pas',
  k2Dictionary in 'w:\common\components\rtl\Garant\K2\k2Dictionary.pas',
  l3DictionaryPrim in 'w:\common\components\rtl\Garant\L3\l3DictionaryPrim.pas',
  l3IDIndexPrim in 'w:\common\components\rtl\Garant\L3\l3IDIndexPrim.pas',
  l3IDIndex in 'w:\common\components\rtl\Garant\L3\l3IDIndex.pas',
  l3Dict in 'w:\common\components\rtl\Garant\L3\l3Dict.pas',
  k2Const in 'w:\common\components\rtl\Garant\K2\k2Const.pas',
  k2Except in 'w:\common\components\rtl\Garant\K2\k2Except.pas',
  k2Facade in 'w:\common\components\rtl\Garant\K2\k2Facade.pas',
  k2OList_Const in 'w:\common\components\rtl\Garant\K2\k2OList_Const.pas',
  k2VariantImpl in 'w:\common\components\rtl\Garant\K2\k2VariantImpl.pas',
  k2Bool_Const in 'w:\common\components\rtl\Garant\K2\k2Bool_Const.pas',
  k2String in 'w:\common\components\rtl\Garant\K2\k2String.pas',
  l3String_Wrap in 'w:\common\components\rtl\Garant\K2\l3String_Wrap.pas',
  l3List_Wrap in 'w:\common\components\rtl\Garant\K2\l3List_Wrap.pas',
  Long_Wrap in 'w:\common\components\rtl\Garant\K2\Long_Wrap.pas',
  Enumeration_Wrap in 'w:\common\components\rtl\Garant\K2\Enumeration_Wrap.pas',
  Bool_Wrap in 'w:\common\components\rtl\Garant\K2\Bool_Wrap.pas',
  l3LogFont in 'w:\common\components\rtl\Garant\L3\l3LogFont.pas',
  l3FontManagerPrimPrim in 'w:\common\components\rtl\Garant\L3\l3FontManagerPrimPrim.pas',
  l3FontManagerPrim in 'w:\common\components\rtl\Garant\L3\l3FontManagerPrim.pas',
  l3FontManager in 'w:\common\components\rtl\Garant\L3\l3FontManager.pas',
  k2FontName_Const in 'w:\common\components\rtl\Garant\K2\k2FontName_Const.pas',
  l3FontManagerEx in 'w:\common\components\rtl\Garant\L3\l3FontManagerEx.pas',
  k2FontName in 'w:\common\components\rtl\Garant\K2\k2FontName.pas',
  k2FontNameListPrim in 'w:\common\components\rtl\Garant\K2\k2FontNameListPrim.pas',
  k2FontNameList in 'w:\common\components\rtl\Garant\K2\k2FontNameList.pas',
  k2FontManager in 'w:\common\components\rtl\Garant\K2\k2FontManager.pas',
  evFontName_Wrap in 'w:\common\components\rtl\Garant\K2\evFontName_Wrap.pas',
  k2SetOf_Const in 'w:\common\components\rtl\Garant\K2\k2SetOf_Const.pas',
  SetOf_Wrap in 'w:\common\components\rtl\Garant\K2\SetOf_Wrap.pas',
  k2IUnknown_Const in 'w:\common\components\rtl\Garant\K2\k2IUnknown_Const.pas',
  k2Core_Schema in 'w:\common\components\rtl\Garant\K2\k2Core_Schema.pas',
  k2String_Const in 'w:\common\components\rtl\Garant\K2\k2String_Const.pas',
  k2TypeModelPart in 'w:\common\components\rtl\Garant\K2\k2TypeModelPart.pas',
  k2BaseStruct in 'w:\common\components\rtl\Garant\K2\k2BaseStruct.pas',
  evdTypes in 'w:\common\components\rtl\Garant\EVD\evdTypes.pas',
  evdInterfaces in 'w:\common\components\rtl\Garant\EVD\evdInterfaces.pas',
  evResultFont in 'w:\common\components\gui\Garant\Everest\evResultFont.pas',
  evResultFontInterfaces in 'w:\common\components\gui\Garant\Everest\evResultFontInterfaces.pas',
  nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas'
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces in 'w:\common\components\gui\Garant\VCM\vcmExternalInterfaces.pas'
  {$IfEnd} //not NoVCM
  ,
  evTypes in 'w:\common\components\gui\Garant\Everest\evTypes.pas',
  nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas',
  l3InterfacedComponent in 'w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas',
  evCustomTextSource in 'w:\common\components\gui\Garant\Everest\evCustomTextSource.pas',
  evExcept in 'w:\common\components\gui\Garant\Everest\evExcept.pas',
  nevBasePointList in 'w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas',
  l3Bitmap in 'w:\common\components\rtl\Garant\L3\l3Bitmap.pas',
  afwCustomCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCaretType.pas',
  afwSingleCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwSingleCaret.pas',
  afwInsCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInsCaretType.pas',
  afwOvrCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwOvrCaretType.pas',
  afwCaretPair in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaretPair.pas',
  afwCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaret.pas',
  evMsgCode in 'w:\common\components\gui\Garant\Everest\evMsgCode.pas',
  evOp in 'w:\common\components\gui\Garant\Everest\evOp.pas',
  k2TagGen in 'w:\common\components\rtl\Garant\K2\k2TagGen.pas',
  k2BaseStackGenerator in 'w:\common\components\rtl\Garant\K2\k2BaseStackGenerator.pas',
  k2DocumentGenerator in 'w:\common\components\rtl\Garant\K2\k2DocumentGenerator.pas',
  evHighLevelDocumentGenerator in 'w:\common\components\gui\Garant\Everest\evHighLevelDocumentGenerator.pas',
  evGeneratorsInterfaces in 'w:\common\components\gui\Garant\Everest\evGeneratorsInterfaces.pas',
  evDocumentPartGeneratorPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPartGeneratorPrim.pas',
  evDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest\evDocumentPartGenerator.pas',
  afwNavigation in 'w:\common\components\gui\Garant\AFW\afwNavigation.pas',
  nevNavigation in 'w:\common\components\gui\Garant\Everest\new\nevNavigation.pas',
  k2Tag_Const in 'w:\common\components\rtl\Garant\K2\k2Tag_Const.pas',
  k2Inch_Const in 'w:\common\components\rtl\Garant\K2\k2Inch_Const.pas',
  k2Color_Const in 'w:\common\components\rtl\Garant\K2\k2Color_Const.pas',
  k2Handle_Const in 'w:\common\components\rtl\Garant\K2\k2Handle_Const.pas',
  Justification_Const in 'w:\common\components\rtl\Garant\EVD\Justification_Const.pas',
  Position_Const in 'w:\common\components\rtl\Garant\EVD\Position_Const.pas',
  Date_Const in 'w:\common\components\rtl\Garant\EVD\Date_Const.pas',
  Time_Const in 'w:\common\components\rtl\Garant\EVD\Time_Const.pas',
  Type_Const in 'w:\common\components\rtl\Garant\EVD\Type_Const.pas',
  k2Tag_Wrap in 'w:\common\components\rtl\Garant\K2\k2Tag_Wrap.pas',
  Color_Wrap in 'w:\common\components\rtl\Garant\K2\Color_Wrap.pas',
  k2RawData_Const in 'w:\common\components\rtl\Garant\K2\k2RawData_Const.pas',
  k2SizedMemoryPool in 'w:\common\components\rtl\Garant\K2\k2SizedMemoryPool.pas',
  l3ProtoDataContainerWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainerWithCOMQI.pas',
  ComObj {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas' {$EndIf},
  k2MemoryPoolAdapter in 'w:\common\components\rtl\Garant\K2\k2MemoryPoolAdapter.pas',
  k2MemoryStream in 'w:\common\components\rtl\Garant\K2\k2MemoryStream.pas',
  l3TempMemoryStream in 'w:\common\components\rtl\Garant\L3\l3TempMemoryStream.pas',
  k2RawData_Wrap in 'w:\common\components\rtl\Garant\K2\k2RawData_Wrap.pas',
  k2Int64_Const in 'w:\common\components\rtl\Garant\K2\k2Int64_Const.pas',
  k2Native_Schema in 'w:\common\components\rtl\Garant\K2\k2Native_Schema.pas',
  evdTaskTypes in 'w:\common\components\rtl\Garant\EVD\evdTaskTypes.pas',
  ULong_Const in 'w:\common\components\rtl\Garant\EVD\ULong_Const.pas',
  DateTime_Const in 'w:\common\components\rtl\Garant\EVD\DateTime_Const.pas',
  DateTimeNotNull_Const in 'w:\common\components\rtl\Garant\EVD\DateTimeNotNull_Const.pas',
  Task_Const in 'w:\common\components\rtl\Garant\EVD\Task_Const.pas',
  ProcessTask_Const in 'w:\common\components\rtl\Garant\EVD\ProcessTask_Const.pas',
  evdDTTypes in 'w:\common\components\rtl\Garant\EVD\evdDTTypes.pas',
  ExportTask_Const in 'w:\common\components\rtl\Garant\EVD\ExportTask_Const.pas',
  PlainFile_Const in 'w:\common\components\rtl\Garant\EVD\PlainFile_Const.pas',
  File_Const in 'w:\common\components\rtl\Garant\EVD\File_Const.pas',
  ImportTask_Const in 'w:\common\components\rtl\Garant\EVD\ImportTask_Const.pas',
  RequestTask_Const in 'w:\common\components\rtl\Garant\EVD\RequestTask_Const.pas',
  AutoExportTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoExportTask_Const.pas',
  TaskResult_Const in 'w:\common\components\rtl\Garant\EVD\TaskResult_Const.pas',
  ImportTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\ImportTaskResult_Const.pas',
  CourtDecisionPhrase_Const in 'w:\common\components\rtl\Garant\EVD\CourtDecisionPhrase_Const.pas',
  CourtDescription_Const in 'w:\common\components\rtl\Garant\EVD\CourtDescription_Const.pas',
  CourtDecisionSabCheckerParams_Const in 'w:\common\components\rtl\Garant\EVD\CourtDecisionSabCheckerParams_Const.pas',
  FTPBrowser_Const in 'w:\common\components\rtl\Garant\EVD\FTPBrowser_Const.pas',
  DataProviderParams_Const in 'w:\common\components\rtl\Garant\EVD\DataProviderParams_Const.pas',
  evdNcsTypes in 'w:\common\components\rtl\Garant\EVD\evdNcsTypes.pas',
  csMessage_Const in 'w:\common\components\rtl\Garant\EVD\csMessage_Const.pas',
  TaskID_Const in 'w:\common\components\rtl\Garant\EVD\TaskID_Const.pas',
  csReply_Const in 'w:\common\components\rtl\Garant\EVD\csReply_Const.pas',
  csMessageWithReply_Const in 'w:\common\components\rtl\Garant\EVD\csMessageWithReply_Const.pas',
  csGetTaskDescription_Const in 'w:\common\components\rtl\Garant\EVD\csGetTaskDescription_Const.pas',
  FileDesc_Const in 'w:\common\components\rtl\Garant\EVD\FileDesc_Const.pas',
  Math {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas' {$EndIf},
  evdTask_Wrap in 'w:\common\components\rtl\Garant\EVD\evdTask_Wrap.pas',
  evdProcessTask_Wrap in 'w:\common\components\rtl\Garant\EVD\evdProcessTask_Wrap.pas',
  DictEditQuery_Const in 'w:\common\components\rtl\Garant\EVD\DictEditQuery_Const.pas',
  UserEditQuery_Const in 'w:\common\components\rtl\Garant\EVD\UserEditQuery_Const.pas',
  RemoteDictEditQuery_Const in 'w:\common\components\rtl\Garant\EVD\RemoteDictEditQuery_Const.pas',
  AutoSpellTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoSpellTask_Const.pas',
  CommonDataRequest_Const in 'w:\common\components\rtl\Garant\EVD\CommonDataRequest_Const.pas',
  LineRequest_Const in 'w:\common\components\rtl\Garant\EVD\LineRequest_Const.pas',
  ServerStatusRequest_Const in 'w:\common\components\rtl\Garant\EVD\ServerStatusRequest_Const.pas',
  DeleteDocsQuery_Const in 'w:\common\components\rtl\Garant\EVD\DeleteDocsQuery_Const.pas',
  TaskResultRequest_Const in 'w:\common\components\rtl\Garant\EVD\TaskResultRequest_Const.pas',
  GetTaskRequest_Const in 'w:\common\components\rtl\Garant\EVD\GetTaskRequest_Const.pas',
  AutoClassTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoClassTask_Const.pas',
  AnnotationTask_Const in 'w:\common\components\rtl\Garant\EVD\AnnotationTask_Const.pas',
  RunCommandTask_Const in 'w:\common\components\rtl\Garant\EVD\RunCommandTask_Const.pas',
  CaseCodeTask_Const in 'w:\common\components\rtl\Garant\EVD\CaseCodeTask_Const.pas',
  AutoAnnoExportTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoAnnoExportTask_Const.pas',
  SpellCorrectTask_Const in 'w:\common\components\rtl\Garant\EVD\SpellCorrectTask_Const.pas',
  UserDefinedExportTask_Const in 'w:\common\components\rtl\Garant\EVD\UserDefinedExportTask_Const.pas',
  ClientMessage_Const in 'w:\common\components\rtl\Garant\EVD\ClientMessage_Const.pas',
  AnoncedExportTask_Const in 'w:\common\components\rtl\Garant\EVD\AnoncedExportTask_Const.pas',
  HavanskyExportTask_Const in 'w:\common\components\rtl\Garant\EVD\HavanskyExportTask_Const.pas',
  RelPublishTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\RelPublishTaskResult_Const.pas',
  AACImportTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AACImportTaskResult_Const.pas',
  AACImport_Const in 'w:\common\components\rtl\Garant\EVD\AACImport_Const.pas',
  AutoClassTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AutoClassTaskResult_Const.pas',
  AnnotationTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AnnotationTaskResult_Const.pas',
  AutoSpellTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AutoSpellTaskResult_Const.pas',
  AutoExportTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AutoExportTaskResult_Const.pas',
  RegionAutoExportTask_Const in 'w:\common\components\rtl\Garant\EVD\RegionAutoExportTask_Const.pas',
  RegionImportTask_Const in 'w:\common\components\rtl\Garant\EVD\RegionImportTask_Const.pas',
  RegionImportTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\RegionImportTaskResult_Const.pas',
  HyTechProviderParams_Const in 'w:\common\components\rtl\Garant\EVD\HyTechProviderParams_Const.pas',
  PostgresProviderParams_Const in 'w:\common\components\rtl\Garant\EVD\PostgresProviderParams_Const.pas',
  csLogin_Const in 'w:\common\components\rtl\Garant\EVD\csLogin_Const.pas',
  csLoginReply_Const in 'w:\common\components\rtl\Garant\EVD\csLoginReply_Const.pas',
  csGetReadyToDeliveryTasksReply_Const in 'w:\common\components\rtl\Garant\EVD\csGetReadyToDeliveryTasksReply_Const.pas',
  csGetReadyToDeliveryTasks_Const in 'w:\common\components\rtl\Garant\EVD\csGetReadyToDeliveryTasks_Const.pas',
  csGetTaskDescriptionReply_Const in 'w:\common\components\rtl\Garant\EVD\csGetTaskDescriptionReply_Const.pas',
  TaskedFileDesc_Const in 'w:\common\components\rtl\Garant\EVD\TaskedFileDesc_Const.pas',
  csTaskProgress_Const in 'w:\common\components\rtl\Garant\EVD\csTaskProgress_Const.pas',
  csDeliveryResult_Const in 'w:\common\components\rtl\Garant\EVD\csDeliveryResult_Const.pas',
  csGetFilePart_Const in 'w:\common\components\rtl\Garant\EVD\csGetFilePart_Const.pas',
  csGetFilePartReply_Const in 'w:\common\components\rtl\Garant\EVD\csGetFilePartReply_Const.pas',
  csDIsconnect_Const in 'w:\common\components\rtl\Garant\EVD\csDIsconnect_Const.pas',
  csDIsconnectReply_Const in 'w:\common\components\rtl\Garant\EVD\csDIsconnectReply_Const.pas',
  csSendTask_Const in 'w:\common\components\rtl\Garant\EVD\csSendTask_Const.pas',
  csSendTaskReply_Const in 'w:\common\components\rtl\Garant\EVD\csSendTaskReply_Const.pas',
  csPushFilePart_Const in 'w:\common\components\rtl\Garant\EVD\csPushFilePart_Const.pas',
  csCorrectFolder_Const in 'w:\common\components\rtl\Garant\EVD\csCorrectFolder_Const.pas',
  RelPublishTask_Const in 'w:\common\components\rtl\Garant\EVD\RelPublishTask_Const.pas',
  csGetPartialTaskDescription_Const in 'w:\common\components\rtl\Garant\EVD\csGetPartialTaskDescription_Const.pas',
  evdTasks_Schema in 'w:\common\components\rtl\Garant\EVD\evdTasks_Schema.pas',
  ddTaskItemPrim in 'w:\common\components\rtl\Garant\EVD\ddTaskItemPrim.pas',
  k2CustomStackGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomStackGenerator.pas',
  k2CustomStackGeneratorEx in 'w:\common\components\rtl\Garant\K2\k2CustomStackGeneratorEx.pas',
  k2CustomFileGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomFileGenerator.pas',
  evdCustomNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriter.pas',
  evdNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeWriter.pas',
  l3ProgressComponent in 'w:\common\components\rtl\Garant\L3\l3ProgressComponent.pas',
  l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas',
  l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas',
  k2CustomReader in 'w:\common\components\rtl\Garant\K2\k2CustomReader.pas',
  k2CustomFileReader in 'w:\common\components\rtl\Garant\K2\k2CustomFileReader.pas',
  k2CustomFileParser in 'w:\common\components\rtl\Garant\K2\k2CustomFileParser.pas',
  evdNativeReader in 'w:\common\components\rtl\Garant\EVD\evdNativeReader.pas',
  k2DocumentBuffer in 'w:\common\components\rtl\Garant\K2\k2DocumentBuffer.pas',
  csTaskListening in 'w:\common\components\rtl\Garant\EVD\csTaskListening.pas',
  Address_Const in 'w:\common\components\rtl\Garant\EVD\Address_Const.pas',
  Font_Const in 'w:\common\components\rtl\Garant\EVD\Font_Const.pas',
  Style_Const in 'w:\common\components\rtl\Garant\EVD\Style_Const.pas',
  FramePart_Const in 'w:\common\components\rtl\Garant\EVD\FramePart_Const.pas',
  k2DictionaryEx in 'w:\common\components\rtl\Garant\K2\k2DictionaryEx.pas',
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
  Segment_Const in 'w:\common\components\rtl\Garant\EVD\Segment_Const.pas',
  LogRecordPrim_Const in 'w:\common\components\rtl\Garant\EVD\LogRecordPrim_Const.pas',
  StagePrim_Const in 'w:\common\components\rtl\Garant\EVD\StagePrim_Const.pas',
  TextSegment_Const in 'w:\common\components\rtl\Garant\EVD\TextSegment_Const.pas',
  PageProperties_Const in 'w:\common\components\rtl\Garant\EVD\PageProperties_Const.pas',
  PageBreak_Const in 'w:\common\components\rtl\Garant\EVD\PageBreak_Const.pas',
  SegmentWithChildren_Const in 'w:\common\components\rtl\Garant\EVD\SegmentWithChildren_Const.pas'
  {$If not defined(NoScripts)}
  //,
  //kwFontBackColor in 'w:\common\components\rtl\Garant\ScriptEngine\kwFontBackColor.pas'
  {$IfEnd} //not NoScripts
  ,
  evFont_Wrap in 'w:\common\components\rtl\Garant\EVD\evFont_Wrap.pas',
  Refcounted in 'w:\common\components\rtl\Garant\L3\Refcounted.pas',
  SyncObjs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\SyncObjs.pas' {$EndIf},
  l3SimpleMemoryManagerPrim in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManagerPrim.pas',
  l3MemorySizeUtilsPrim in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtilsPrim.pas',
  l3MemorySizeUtils in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtils.pas',
  l3Interlocked in 'w:\common\components\rtl\Garant\L3\l3Interlocked.pas',
  l3MemUtils in 'w:\common\components\rtl\Garant\L3\l3MemUtils.pas',
  l3ExceptionsLog in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLog.pas',
  l3SimpleMemoryManager in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManager.pas',
  l3BaseBoxMemoryManager in 'w:\common\components\rtl\Garant\L3\l3BaseBoxMemoryManager.pas',
  l3BoxMemoryManagerPrim in 'w:\common\components\rtl\Garant\L3\l3BoxMemoryManagerPrim.pas',
  l3BitArr in 'w:\common\components\rtl\Garant\L3\l3BitArr.pas',
  k2LeafTag in 'w:\common\components\rtl\Garant\K2\k2LeafTag.pas',
  k2DictRecTag in 'w:\common\components\rtl\Garant\K2\k2DictRecTag.pas',
  k2DictRec in 'w:\common\components\rtl\Garant\K2\k2DictRec.pas',
  k2DictRec_Wrap in 'w:\common\components\rtl\Garant\K2\k2DictRec_Wrap.pas',
  evStyle_Wrap in 'w:\common\components\rtl\Garant\EVD\evStyle_Wrap.pas',
  evFramePart_Wrap in 'w:\common\components\rtl\Garant\EVD\evFramePart_Wrap.pas',
  evFrame_Wrap in 'w:\common\components\rtl\Garant\EVD\evFrame_Wrap.pas',
  evdDictRec_Wrap in 'w:\common\components\rtl\Garant\EVD\evdDictRec_Wrap.pas',
  evSub_Wrap in 'w:\common\components\rtl\Garant\EVD\evSub_Wrap.pas',
  evPara_Wrap in 'w:\common\components\rtl\Garant\EVD\evPara_Wrap.pas',
  evParaInterfaceFactoryPrim in 'w:\common\components\gui\Garant\Everest\evParaInterfaceFactoryPrim.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evSelection in 'w:\common\components\gui\Garant\Everest\evSelection.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evDocumentPreviewInfoList in 'w:\common\components\gui\Garant\Everest\new\evDocumentPreviewInfoList.pas',
  nevWaiterList in 'w:\common\components\gui\Garant\Everest\new\nevWaiterList.pas',
  evInternalInterfaces in 'w:\common\components\gui\Garant\Everest\evInternalInterfaces.pas',
  nevInternalInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInternalInterfaces.pas',
  k2InternalInterfaces in 'w:\common\components\rtl\Garant\K2\k2InternalInterfaces.pas',
  l3NotifyPtrList in 'w:\common\components\rtl\Garant\L3\l3NotifyPtrList.pas',
  l3InterfacePtrList in 'w:\common\components\rtl\Garant\L3\l3InterfacePtrList.pas',
  l3KeyboardLayoutService in 'w:\common\components\rtl\Garant\L3\l3KeyboardLayoutService.pas',
  afwSettingsImplPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrimPrim.pas',
  afwSettingsImplPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrim.pas',
  afwSettingsImpl in 'w:\common\components\gui\Garant\AFW\afwSettingsImpl.pas',
  l3NCString in 'w:\common\components\rtl\Garant\L3\l3NCString.pas',
  l3InterfacedString in 'w:\common\components\rtl\Garant\L3\l3InterfacedString.pas',
  afwSettingsImplPersistent in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPersistent.pas',
  afwSettingsImplSing in 'w:\common\components\gui\Garant\AFW\afwSettingsImplSing.pas',
  l3CastableStrings in 'w:\common\components\rtl\Garant\L3\l3CastableStrings.pas',
  l3VCLStringsItems in 'w:\common\components\rtl\Garant\L3\l3VCLStringsItems.pas',
  l3VCLStrings in 'w:\common\components\rtl\Garant\L3\l3VCLStrings.pas',
  afwAString in 'w:\common\components\gui\Garant\AFW\afwAString.pas',
  afwSettingsPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsPrimPrim.pas',
  IafwSettingListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingListenerPtrList.pas',
  IafwSettingsReplaceListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingsReplaceListenerPtrList.pas',
  afwSettingsChangePublisherPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisherPrim.pas',
  afwSettingsChangePublisher in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisher.pas',
  afwSettings in 'w:\common\components\gui\Garant\AFW\afwSettings.pas',
  afwSettingsImplemented in 'w:\common\components\gui\Garant\AFW\afwSettingsImplemented.pas',
  afwFacade in 'w:\common\components\gui\Garant\AFW\afwFacade.pas',
  evInterface in 'w:\common\components\gui\Garant\Everest\evInterface.pas',
  evStylesPrintAndExportSettingRes in 'w:\common\components\gui\Garant\Everest\evStylesPrintAndExportSettingRes.pas',
  l3CProtoObject in 'w:\common\components\rtl\Garant\L3\l3CProtoObject.pas',
  evStylesPrintAndExportFontSizeSettingRes in 'w:\common\components\gui\Garant\Everest\evStylesPrintAndExportFontSizeSettingRes.pas',
  evStyles_SH in 'w:\common\components\gui\Garant\Everest\evStyles_SH.pas',
  evFontInterface in 'w:\common\components\gui\Garant\Everest\evFontInterface.pas',
  evStyleInterface in 'w:\common\components\gui\Garant\Everest\evStyleInterface.pas'
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy in 'w:\common\components\gui\Garant\Everest\evStyleTableSpy.pas'
  {$IfEnd} //not DesignTimeLibrary
  ,
  nevFormatPoolBase in 'w:\common\components\gui\Garant\Everest\new\nevFormatPoolBase.pas',
  Bullet_Const in 'w:\common\components\rtl\Garant\EVD\Bullet_Const.pas',
  SegmentsLayer_Const in 'w:\common\components\rtl\Garant\EVD\SegmentsLayer_Const.pas',
  TabStop_Const in 'w:\common\components\rtl\Garant\EVD\TabStop_Const.pas',
  evQueryCardInt in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardInt.pas',
  DocSubLayer_Const in 'w:\common\components\rtl\Garant\EVD\DocSubLayer_Const.pas',
  ActiveInterval_Const in 'w:\common\components\rtl\Garant\EVD\ActiveInterval_Const.pas',
  Alarm_Const in 'w:\common\components\rtl\Garant\EVD\Alarm_Const.pas',
  LogRecord_Const in 'w:\common\components\rtl\Garant\EVD\LogRecord_Const.pas',
  Stage_Const in 'w:\common\components\rtl\Garant\EVD\Stage_Const.pas',
  NumANDDate_Const in 'w:\common\components\rtl\Garant\EVD\NumANDDate_Const.pas',
  Check_Const in 'w:\common\components\rtl\Garant\EVD\Check_Const.pas',
  PIRec_Const in 'w:\common\components\rtl\Garant\EVD\PIRec_Const.pas',
  HyperLink_Const in 'w:\common\components\rtl\Garant\EVD\HyperLink_Const.pas',
  ObjectSegment_Const in 'w:\common\components\rtl\Garant\EVD\ObjectSegment_Const.pas',
  ControlPara_Const in 'w:\common\components\gui\Garant\Everest\ControlPara_Const.pas',
  ParaList_Const in 'w:\common\components\gui\Garant\Everest\ParaList_Const.pas',
  HFParent_Const in 'w:\common\components\gui\Garant\Everest\HFParent_Const.pas',
  Header_Const in 'w:\common\components\gui\Garant\Everest\Header_Const.pas',
  Footer_Const in 'w:\common\components\gui\Garant\Everest\Footer_Const.pas',
  ContentsElement_Const in 'w:\common\components\gui\Garant\Everest\ContentsElement_Const.pas',
  evConst in 'w:\common\components\gui\Garant\Everest\evConst.pas',
  Participant_Const in 'w:\common\components\gui\Garant\Everest\Participant_Const.pas',
  Version_Const in 'w:\common\components\gui\Garant\Everest\Version_Const.pas',
  EditablePart_Const in 'w:\common\components\gui\Garant\Everest\EditablePart_Const.pas',
  Document_Const in 'w:\common\components\gui\Garant\Everest\Document_Const.pas',
  evDocumentPart in 'w:\common\components\gui\Garant\Everest\evDocumentPart.pas',
  Block_Const in 'w:\common\components\gui\Garant\Everest\Block_Const.pas',
  l3GraphicContainerStack in 'w:\common\components\rtl\Garant\L3\l3GraphicContainerStack.pas',
  l3GraphicContainer in 'w:\common\components\rtl\Garant\L3\l3GraphicContainer.pas',
  l3IEBitmapContainerStack in 'w:\common\components\rtl\Garant\L3\l3IEBitmapContainerStack.pas',
  l3IEBitmapContainer in 'w:\common\components\rtl\Garant\L3\l3IEBitmapContainer.pas',
  evBitmapParaBitmapContainer in 'w:\common\components\gui\Garant\Everest\evBitmapParaBitmapContainer.pas',
  BitmapPara_Const in 'w:\common\components\gui\Garant\Everest\BitmapPara_Const.pas',
  ImageListBitmap_Const in 'w:\common\components\gui\Garant\Everest\ImageListBitmap_Const.pas',
  evTextStyle_Const in 'w:\common\components\gui\Garant\Everest\evTextStyle_Const.pas',
  SimpleDocumentTextPara_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocumentTextPara_Const.pas',
  evDef in 'w:\common\components\gui\Garant\Everest\evDef.pas',
  SimpleDocument_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocument_Const.pas',
  DictEntryBlock_Const in 'w:\common\components\gui\Garant\Everest\DictEntryBlock_Const.pas',
  QueryCard_Const in 'w:\common\components\gui\Garant\Everest\QueryCard_Const.pas',
  TableTextPara_Const in 'w:\common\components\gui\Garant\Everest\TableTextPara_Const.pas',
  TableCell_Const in 'w:\common\components\gui\Garant\Everest\TableCell_Const.pas',
  SBSCell_Const in 'w:\common\components\gui\Garant\Everest\SBSCell_Const.pas',
  TableRow_Const in 'w:\common\components\gui\Garant\Everest\TableRow_Const.pas',
  SBSRow_Const in 'w:\common\components\gui\Garant\Everest\SBSRow_Const.pas',
  Table_Const in 'w:\common\components\gui\Garant\Everest\Table_Const.pas',
  ReqCell_Const in 'w:\common\components\gui\Garant\Everest\ReqCell_Const.pas',
  ReqRow_Const in 'w:\common\components\gui\Garant\Everest\ReqRow_Const.pas',
  evControlsBlockConst in 'w:\common\components\gui\Garant\Everest\evControlsBlockConst.pas',
  ControlsBlock_Const in 'w:\common\components\gui\Garant\Everest\ControlsBlock_Const.pas',
  XMLTag_Const in 'w:\common\components\gui\Garant\Everest\XMLTag_Const.pas',
  AttrName_Const in 'w:\common\components\gui\Garant\Everest\AttrName_Const.pas',
  evTextPara_Wrap in 'w:\common\components\gui\Garant\Everest\evTextPara_Wrap.pas',
  evControlParaConst in 'w:\common\components\gui\Garant\Everest\evControlParaConst.pas',
  evSearch in 'w:\common\components\gui\Garant\Everest\evSearch.pas',
  nevConfirm in 'w:\common\components\gui\Garant\Everest\new\nevConfirm.pas',
  k2PureMixIns in 'w:\common\components\rtl\Garant\K2\k2PureMixIns.pas',
  evEditorInterfaces in 'w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas',
  k2TagTool in 'w:\common\components\rtl\Garant\K2\k2TagTool.pas',
  k2ProcessorTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcessorTagTool.pas',
  evSegLst in 'w:\common\components\gui\Garant\Everest\evSegLst.pas',
  nevFacade in 'w:\common\components\gui\Garant\Everest\new\nevFacade.pas',
  k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas',
  evCursorTools in 'w:\common\components\gui\Garant\Everest\evCursorTools.pas'
  {$If defined(evNeedEditableCursors)}
  ,
  evCustomParaListUtils in 'w:\common\components\gui\Garant\Everest\evCustomParaListUtils.pas'
  {$IfEnd} //evNeedEditableCursors
  
  {$If defined(evNeedEditableCursors)}
  ,
  evParaUtilClasses in 'w:\common\components\gui\Garant\Everest\evParaUtilClasses.pas'
  {$IfEnd} //evNeedEditableCursors
  ,
  evParaTools in 'w:\common\components\gui\Garant\Everest\evParaTools.pas',
  ReqGroup_Const in 'w:\common\components\gui\Garant\Everest\ReqGroup_Const.pas',
  evControlPara_Wrap in 'w:\common\components\gui\Garant\Everest\evControlPara_Wrap.pas',
  Formula_Const in 'w:\common\components\gui\Garant\Everest\Formula_Const.pas',
  l3Drawer in 'w:\common\components\rtl\Garant\L3\l3Drawer.pas',
  ExprDraw in 'w:\common\components\rtl\external\Expr\ExprDraw.pas',
  exprTokensList in 'w:\common\components\rtl\external\Expr\exprTokensList.pas',
  ExprMake in 'w:\common\components\rtl\external\Expr\ExprMake.pas',
  evFormula_Wrap in 'w:\common\components\gui\Garant\Everest\evFormula_Wrap.pas',
  evDocument_Wrap in 'w:\common\components\gui\Garant\Everest\evDocument_Wrap.pas',
  evReqRow_Wrap in 'w:\common\components\gui\Garant\Everest\evReqRow_Wrap.pas',
  evBitmapPara_Wrap in 'w:\common\components\gui\Garant\Everest\evBitmapPara_Wrap.pas',
  CommentPara_Const in 'w:\common\components\gui\Garant\Everest\CommentPara_Const.pas',
  evCommentPara_Wrap in 'w:\common\components\gui\Garant\Everest\evCommentPara_Wrap.pas',
  evReqGroup_Wrap in 'w:\common\components\gui\Garant\Everest\evReqGroup_Wrap.pas',
  evLeafPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evLeafPara_InterfaceFactory.pas',
  nevLeafPara in 'w:\common\components\gui\Garant\Everest\new\nevLeafPara.pas',
  evTabStops in 'w:\common\components\gui\Garant\Everest\new\evTabStops.pas',
  nevParaPrim in 'w:\common\components\gui\Garant\Everest\new\nevParaPrim.pas',
  nevPara in 'w:\common\components\gui\Garant\Everest\new\nevPara.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evLeafParaCursorPair in 'w:\common\components\gui\Garant\Everest\evLeafParaCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evLocation in 'w:\common\components\gui\Garant\Everest\evLocation.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  nevRangePrim in 'w:\common\components\gui\Garant\Everest\nevRangePrim.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInterfaces.pas',
  evSelectConst in 'w:\common\components\gui\Garant\Everest\evSelectConst.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evCursor in 'w:\common\components\gui\Garant\Everest\evCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evCustomTxtReader in 'w:\common\components\gui\Garant\Everest\evCustomTxtReader.pas',
  evdDocumentFilter in 'w:\common\components\rtl\Garant\EVD\evdDocumentFilter.pas',
  evCustomTextFormatterModelPart in 'w:\common\components\gui\Garant\Everest\evCustomTextFormatterModelPart.pas',
  evCustomTextFormatter in 'w:\common\components\gui\Garant\Everest\evCustomTextFormatter.pas',
  evTextFormatter in 'w:\common\components\gui\Garant\Everest\evTextFormatter.pas',
  evdCustomPlainTextWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomPlainTextWriter.pas',
  evdPlainTextWriter in 'w:\common\components\rtl\Garant\EVD\evdPlainTextWriter.pas',
  evEpsilonLongIntList in 'w:\common\components\gui\Garant\Everest\evEpsilonLongIntList.pas',
  evCellsOffsets in 'w:\common\components\gui\Garant\Everest\evCellsOffsets.pas',
  k2TagTerminator in 'w:\common\components\rtl\Garant\K2\k2TagTerminator.pas',
  k2TagFilter in 'w:\common\components\rtl\Garant\K2\k2TagFilter.pas',
  l3UnitsTools in 'w:\common\components\rtl\Garant\L3\l3UnitsTools.pas',
  evMergedCellFilter in 'w:\common\components\gui\Garant\Everest\evMergedCellFilter.pas',
  ShellAPI {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShellAPI.pas' {$EndIf},
  evStyleTableTools in 'w:\common\components\gui\Garant\Everest\evStyleTableTools.pas',
  afwFont in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwFont.pas',
  Cloak_Const in 'w:\common\components\gui\Garant\Everest\Cloak_Const.pas',
  evCustomWikiReader in 'w:\common\components\gui\Garant\Everest\evCustomWikiReader.pas',
  evdLeafParaFilter in 'w:\common\components\rtl\Garant\EVD\evdLeafParaFilter.pas',
  evStyleHeaderAdder in 'w:\common\components\gui\Garant\Everest\evStyleHeaderAdder.pas',
  evdNativeUnpackedWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeUnpackedWriter.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evCursorPair in 'w:\common\components\gui\Garant\Everest\evCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evLeafParaCursor in 'w:\common\components\gui\Garant\Everest\evLeafParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evMarker in 'w:\common\components\gui\Garant\Everest\evMarker.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaCursor in 'w:\common\components\gui\Garant\Everest\evParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevLeafParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevLeafParaAnchor.pas',
  nevAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAnchor.pas',
  nevLeafParaInevLeafParaMapper in 'w:\common\components\gui\Garant\Everest\new\nevLeafParaInevLeafParaMapper.pas',
  k2InterfaceMapper in 'w:\common\components\rtl\Garant\K2\k2InterfaceMapper.pas',
  nevRealTools in 'w:\common\components\gui\Garant\Everest\new\nevRealTools.pas',
  nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas',
  evTextPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTextPara_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaCursor in 'w:\common\components\gui\Garant\Everest\evTextParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  k2InterfacesEx in 'w:\common\components\rtl\Garant\K2\k2InterfacesEx.pas',
  l3Utils in 'w:\common\components\rtl\Garant\L3\l3Utils.pas',
  evSegOp in 'w:\common\components\gui\Garant\Everest\evSegOp.pas',
  l3SingleLineInfo in 'w:\common\components\rtl\Garant\L3\l3SingleLineInfo.pas',
  nevSegmentObject in 'w:\common\components\gui\Garant\Everest\nevSegmentObject.pas',
  evAlignBySeparatorUtils in 'w:\common\components\gui\Garant\Everest\evAlignBySeparatorUtils.pas',
  evParaString in 'w:\common\components\gui\Garant\Everest\evParaString.pas',
  nevStringCache in 'w:\common\components\gui\Garant\Everest\nevStringCache.pas',
  k2SimpleTagList in 'w:\common\components\rtl\Garant\K2\k2SimpleTagList.pas',
  k2InterfacedTagList in 'w:\common\components\rtl\Garant\K2\k2InterfacedTagList.pas',
  evChangeCodePage in 'w:\common\components\gui\Garant\Everest\evChangeCodePage.pas',
  evTextParaTools in 'w:\common\components\gui\Garant\Everest\evTextParaTools.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evCursorConst in 'w:\common\components\gui\Garant\Everest\evCursorConst.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evHyperlink in 'w:\common\components\gui\Garant\Everest\evHyperlink.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDrawLineTool in 'w:\common\components\gui\Garant\Everest\evDrawLineTool.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaOp in 'w:\common\components\gui\Garant\Everest\evTextParaOp.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evTableCellUtils in 'w:\common\components\gui\Garant\Everest\evTableCellUtils.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evTabIndentMarker in 'w:\common\components\gui\Garant\Everest\evTabIndentMarker.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaMarkers in 'w:\common\components\gui\Garant\Everest\evTextParaMarkers.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaOpEx in 'w:\common\components\gui\Garant\Everest\evTextParaOpEx.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evTextManipulationInterfaces in 'w:\common\components\gui\Garant\Everest\new\evTextManipulationInterfaces.pas',
  evSegment in 'w:\common\components\gui\Garant\Everest\evSegment.pas'
  {$If defined(evNeedPainters)}
  ,
  evTextParaPainterEx in 'w:\common\components\gui\Garant\Everest\evTextParaPainterEx.pas'
  {$IfEnd} //evNeedPainters
  ,
  l3SmartCanvas in 'w:\common\components\rtl\Garant\L3\l3SmartCanvas.pas',
  l3ProtoPersistentDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas',
  l3ItemsStorage in 'w:\common\components\rtl\Garant\L3\l3ItemsStorage.pas',
  l3Tree in 'w:\common\components\rtl\Garant\L3\l3Tree.pas',
  Mark_Const in 'w:\common\components\rtl\Garant\EVD\Mark_Const.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  nevAfterEndPoint in 'w:\common\components\gui\Garant\Everest\nevAfterEndPoint.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evDefaultStylesFontSizesPrim in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim.pas',
  evDefaultStylesFontSizesPrim1 in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim1.pas',
  evDefaultStylesFontSizes in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizes.pas'
  {$If defined(evNeedPainters)}
  ,
  evTextParaPainterPrim in 'w:\common\components\gui\Garant\Everest\evTextParaPainterPrim.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evTextParaPainter in 'w:\common\components\gui\Garant\Everest\evTextParaPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evLinePainter in 'w:\common\components\gui\Garant\Everest\evLinePainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  evTextParaConst in 'w:\common\components\gui\Garant\Everest\evTextParaConst.pas'
  {$If defined(evNeedHotSpot)}
  ,
  nevActiveHyperlink in 'w:\common\components\gui\Garant\Everest\nevActiveHyperlink.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  nevActiveHyperlinkProxy in 'w:\common\components\gui\Garant\Everest\nevActiveHyperlinkProxy.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  nevDecorActiveHyperlink in 'w:\common\components\gui\Garant\Everest\nevDecorActiveHyperlink.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  evCustomStyleManager in 'w:\common\components\gui\Garant\Everest\evCustomStyleManager.pas',
  nevTextPara in 'w:\common\components\gui\Garant\Everest\new\nevTextPara.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evTextCursorPair in 'w:\common\components\gui\Garant\Everest\evTextCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evTextParaHotSpotTester in 'w:\common\components\gui\Garant\Everest\evTextParaHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  k2ProcTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcTagTool.pas'
  {$If defined(evNeedHotSpot)}
  ,
  evHotSpot in 'w:\common\components\gui\Garant\Everest\evHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evHotSpotMisc in 'w:\common\components\gui\Garant\Everest\evHotSpotMisc.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evSegmentHotSpot in 'w:\common\components\gui\Garant\Everest\evSegmentHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evTextParaHeaderHotSpot in 'w:\common\components\gui\Garant\Everest\evTextParaHeaderHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evHotSpotProxy in 'w:\common\components\gui\Garant\Everest\evHotSpotProxy.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evHyperlinkProxy in 'w:\common\components\gui\Garant\Everest\evHyperlinkProxy.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evDecorHyperlink in 'w:\common\components\gui\Garant\Everest\evDecorHyperlink.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evDecorHotSpot in 'w:\common\components\gui\Garant\Everest\evDecorHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evParaCollapser in 'w:\common\components\gui\Garant\Everest\evParaCollapser.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
  ,
  evDeadCursor in 'w:\common\components\gui\Garant\Everest\evDeadCursor.pas'
  {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
  ,
  evTextParaStringImpl in 'w:\common\components\gui\Garant\Everest\new\evTextParaStringImpl.pas',
  nevTextParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTextParaAnchor.pas',
  nevTextParaInevTextParaMapper in 'w:\common\components\gui\Garant\Everest\new\nevTextParaInevTextParaMapper.pas',
  evControlPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evControlPara_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evControlParaPainter in 'w:\common\components\gui\Garant\Everest\evControlParaPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  evControlParaTools in 'w:\common\components\gui\Garant\Everest\qf\evControlParaTools.pas',
  nevControlPara in 'w:\common\components\gui\Garant\Everest\new\nevControlPara.pas',
  nevFontPrim in 'w:\common\components\gui\Garant\Everest\new\nevFontPrim.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evControlParaCursor in 'w:\common\components\gui\Garant\Everest\evControlParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evControlParaCursorPair in 'w:\common\components\gui\Garant\Everest\evControlParaCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evControlParaHotSpotTester in 'w:\common\components\gui\Garant\Everest\evControlParaHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  
  {$If defined(evNeedHotSpot)}
  ,
  evControlParaHotSpot in 'w:\common\components\gui\Garant\Everest\evControlParaHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evControlSegmentHotSpot in 'w:\common\components\gui\Garant\Everest\evControlSegmentHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  nevControlParaIevControlFriendMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlParaIevControlFriendMapper.pas',
  nevControlParaModelControlMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlParaModelControlMapper.pas',
  evFormula_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evFormula_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evFormulaPainter in 'w:\common\components\gui\Garant\Everest\evFormulaPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  nevFormulaPara in 'w:\common\components\gui\Garant\Everest\new\nevFormulaPara.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evFormulaCursor in 'w:\common\components\gui\Garant\Everest\evFormulaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evParaList_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evParaList_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursor in 'w:\common\components\gui\Garant\Everest\evParaListCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  nevParaListAnchorModifyTypes in 'w:\common\components\gui\Garant\Everest\nevParaListAnchorModifyTypes.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursorPrim in 'w:\common\components\gui\Garant\Everest\evParaListCursorPrim.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursorInsertable in 'w:\common\components\gui\Garant\Everest\evParaListCursorInsertable.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursorDeletable in 'w:\common\components\gui\Garant\Everest\evParaListCursorDeletable.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedPainters)}
  ,
  evParaListPainter in 'w:\common\components\gui\Garant\Everest\evParaListPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  l3VirtualCanvas in 'w:\common\components\rtl\Garant\L3\l3VirtualCanvas.pas',
  nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas',
  nevShapePrimRefList in 'w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas',
  nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas',
  nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas',
  nevBaseView in 'w:\common\components\gui\Garant\Everest\new\nevBaseView.pas',
  nevBaseDetachedView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDetachedView.pas',
  nevVirtualDrawView in 'w:\common\components\gui\Garant\Everest\new\nevVirtualDrawView.pas',
  evParaDrawTools in 'w:\common\components\gui\Garant\Everest\evParaDrawTools.pas',
  nevParaList in 'w:\common\components\gui\Garant\Everest\new\nevParaList.pas',
  nevParas in 'w:\common\components\gui\Garant\Everest\new\nevParas.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursorPair in 'w:\common\components\gui\Garant\Everest\evParaListCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaPackOperation in 'w:\common\components\gui\Garant\Everest\evParaPackOperation.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevParaListAnchor in 'w:\common\components\gui\Garant\Everest\new\nevParaListAnchor.pas'
  {$If defined(evNeedHotSpot)}
  ,
  evParaListHotSpotTester in 'w:\common\components\gui\Garant\Everest\evParaListHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evParaListHotSpotTesterPrim in 'w:\common\components\gui\Garant\Everest\evParaListHotSpotTesterPrim.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  nevParaListInevParaListMapper in 'w:\common\components\gui\Garant\Everest\new\nevParaListInevParaListMapper.pas',
  evBlock_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evBlock_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentPartCursor in 'w:\common\components\gui\Garant\Everest\evDocumentPartCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  OvcConst in 'w:\common\components\rtl\external\Orpheus\OvcConst.pas',
  OvcCmd in 'w:\common\components\rtl\external\Orpheus\OvcCmd.pas'
  {$If defined(evNeedPainters)}
  ,
  evDocumentPartPainter in 'w:\common\components\gui\Garant\Everest\evDocumentPartPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot)}
  ,
  evDocumentPartHotSpotTester in 'w:\common\components\gui\Garant\Everest\evDocumentPartHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentPartCursorPair in 'w:\common\components\gui\Garant\Everest\evDocumentPartCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevDocumentPartAnchor in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPartAnchor.pas',
  nevDocumentPart in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPart.pas',
  evDocument_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evDocument_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evDocumentPainter in 'w:\common\components\gui\Garant\Everest\evDocumentPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot)}
  ,
  evDocumentHotSpotTester in 'w:\common\components\gui\Garant\Everest\evDocumentHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursor in 'w:\common\components\gui\Garant\Everest\evDocumentCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentMarkers in 'w:\common\components\gui\Garant\Everest\evDocumentMarkers.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursorPair in 'w:\common\components\gui\Garant\Everest\evDocumentCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evSectionPara in 'w:\common\components\gui\Garant\Everest\new\evSectionPara.pas',
  evdDOM in 'w:\common\components\rtl\Garant\EVD\evdDOM.pas',
  nevDocument in 'w:\common\components\gui\Garant\Everest\new\nevDocument.pas',
  evDocumentAnchorIndex in 'w:\common\components\gui\Garant\Everest\new\evDocumentAnchorIndex.pas',
  evQueryCard_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evQueryCard_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evQueryCardCursor in 'w:\common\components\gui\Garant\Everest\evQueryCardCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evTableCell_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTableCell_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evTableCellPainter in 'w:\common\components\gui\Garant\Everest\evTableCellPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  nevTableCell in 'w:\common\components\gui\Garant\Everest\new\nevTableCell.pas'
  {$If defined(evNeedHotSpot)}
  ,
  evTableCellHotSpot in 'w:\common\components\gui\Garant\Everest\evTableCellHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  nevTableCellAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTableCellAnchor.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCellCursor in 'w:\common\components\gui\Garant\Everest\evTableCellCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evTableImplementation in 'w:\common\components\gui\Garant\Everest\evTableImplementation.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCellCursorPair in 'w:\common\components\gui\Garant\Everest\evTableCellCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evSBSCell_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSBSCell_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evSBSCellPainter in 'w:\common\components\gui\Garant\Everest\evSBSCellPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  evTableRow_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTableRow_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evTableRowPainter in 'w:\common\components\gui\Garant\Everest\evTableRowPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(nsTest)}
  ,
  PrintRowHeightsSpy in 'w:\common\components\gui\Garant\Everest\new\PrintRowHeightsSpy.pas'
  {$IfEnd} //nsTest
  ,
  nevTableRow in 'w:\common\components\gui\Garant\Everest\new\nevTableRow.pas'
  {$If defined(evNeedHotSpot)}
  ,
  evTableRowHotSpot in 'w:\common\components\gui\Garant\Everest\evTableRowHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableRowCursor in 'w:\common\components\gui\Garant\Everest\evTableRowCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableRowCursorPair in 'w:\common\components\gui\Garant\Everest\evTableRowCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevTableRowAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTableRowAnchor.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  nevTableRowBaseLine4Print in 'w:\common\components\gui\Garant\Everest\nevTableRowBaseLine4Print.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  nevTableRowBaseLine4Anchor in 'w:\common\components\gui\Garant\Everest\nevTableRowBaseLine4Anchor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  nevBeforeStartPoint in 'w:\common\components\gui\Garant\Everest\nevBeforeStartPoint.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evSBSRow_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSBSRow_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evSBSRowCursor in 'w:\common\components\gui\Garant\Everest\evSBSRowCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evColumnBorderMarker in 'w:\common\components\gui\Garant\Everest\evColumnBorderMarker.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evSBSColumnBorderMarker in 'w:\common\components\gui\Garant\Everest\evSBSColumnBorderMarker.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evSBSRowHotSpotTester in 'w:\common\components\gui\Garant\Everest\evSBSRowHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  evTable_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTable_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evTablePainter in 'w:\common\components\gui\Garant\Everest\evTablePainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evSelectedParts in 'w:\common\components\gui\Garant\Everest\evSelectedParts.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evDelayedPaintersSpy in 'w:\common\components\gui\Garant\Everest\evDelayedPaintersSpy.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evFramedParaListPainter in 'w:\common\components\gui\Garant\Everest\evFramedParaListPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCursor in 'w:\common\components\gui\Garant\Everest\evTableCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableMarker in 'w:\common\components\gui\Garant\Everest\evTableMarker.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCursorPrim in 'w:\common\components\gui\Garant\Everest\evTableCursorPrim.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCursorPair in 'w:\common\components\gui\Garant\Everest\evTableCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevTable in 'w:\common\components\gui\Garant\Everest\new\nevTable.pas',
  nevTableAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTableAnchor.pas'
  {$If defined(evNeedHotSpot)}
  ,
  evTableHotSpot in 'w:\common\components\gui\Garant\Everest\evTableHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  nevTableIevChangeParamToolMapper in 'w:\common\components\gui\Garant\Everest\new\nevTableIevChangeParamToolMapper.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  evReqCell_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqCell_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evReqCellCursor in 'w:\common\components\gui\Garant\Everest\evReqCellCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evReqCellHotSpot in 'w:\common\components\gui\Garant\Everest\evReqCellHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  evReqRow_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqRow_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evReqRowPainter in 'w:\common\components\gui\Garant\Everest\evReqRowPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evReqRowHotSpotTester in 'w:\common\components\gui\Garant\Everest\evReqRowHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  ,
  evReqRowModelControlMapper in 'w:\common\components\gui\Garant\Everest\new\evReqRowModelControlMapper.pas',
  evControlsBlock_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evControlsBlock_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evControlsBlockPainter in 'w:\common\components\gui\Garant\Everest\evControlsBlockPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  NodeGroup_Const in 'w:\common\components\gui\Garant\Everest\NodeGroup_Const.pas',
  nevControlsBlock in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlock.pas'
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evControlsBlockHotSpotTester in 'w:\common\components\gui\Garant\Everest\evControlsBlockHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  
  {$If defined(evNeedHotSpot)}
  ,
  evControlsBlockHotSpotTesterPrim in 'w:\common\components\gui\Garant\Everest\evControlsBlockHotSpotTesterPrim.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evControlsBlockCursor in 'w:\common\components\gui\Garant\Everest\evControlsBlockCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevControlsBlockIevCommonControlMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockIevCommonControlMapper.pas',
  nevControlsBlockModelControlMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockModelControlMapper.pas',
  evSolidPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSolidPara_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evSolidParaCursor in 'w:\common\components\gui\Garant\Everest\evSolidParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevSolidParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevSolidParaAnchor.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evSolidParaCursorPair in 'w:\common\components\gui\Garant\Everest\evSolidParaCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evBitmapPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evBitmapPara_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evBitmapParaCursor in 'w:\common\components\gui\Garant\Everest\evBitmapParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedPainters)}
  ,
  evBitmapParaPainter in 'w:\common\components\gui\Garant\Everest\evBitmapParaPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evLeafParaPainter in 'w:\common\components\gui\Garant\Everest\evLeafParaPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  nevBitmapParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevBitmapParaAnchor.pas',
  evCommentPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evCommentPara_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evCommentParaCursor in 'w:\common\components\gui\Garant\Everest\evCommentParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedPainters)}
  ,
  evCommentParaPainter in 'w:\common\components\gui\Garant\Everest\evCommentParaPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evUseVisibleCursors)}
  ,
  evCommentParaCursorPair in 'w:\common\components\gui\Garant\Everest\evCommentParaCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevCommentPara in 'w:\common\components\gui\Garant\Everest\new\nevCommentPara.pas'
  {$If defined(evNeedHotSpot)}
  ,
  evCommentParaHotSpotTester in 'w:\common\components\gui\Garant\Everest\evCommentParaHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  SBS_Const in 'w:\common\components\gui\Garant\Everest\SBS_Const.pas',
  evSBS_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSBS_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evSBSPainter in 'w:\common\components\gui\Garant\Everest\evSBSPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  evReqGroup_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqGroup_InterfaceFactory.pas'
  {$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}
  ,
  evReqGroupHotSpotTester in 'w:\common\components\gui\Garant\Everest\evReqGroupHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio
  
  {$If defined(evNeedHotSpot)}
  ,
  evSelectingHotSpot in 'w:\common\components\gui\Garant\Everest\evSelectingHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
  ,
  evReqGroupPainter in 'w:\common\components\gui\Garant\Everest\evReqGroupPainter.pas'
  {$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio
  ,
  AutoreferatDocument_Const in 'w:\common\components\gui\Garant\Everest\AutoreferatDocument_Const.pas',
  evAutoreferatDocument_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evAutoreferatDocument_InterfaceFactory.pas',
  nevAutoreferatDocumentAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAutoreferatDocumentAnchor.pas',
  DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas',
  Division_Const in 'w:\common\components\gui\Garant\Everest\Division_Const.pas',
  XML_Const in 'w:\common\components\gui\Garant\Everest\XML_Const.pas',
  ExtDataPara_Const in 'w:\common\components\gui\Garant\Everest\ExtDataPara_Const.pas',
  AttrValue_Const in 'w:\common\components\gui\Garant\Everest\AttrValue_Const.pas',
  Attr_Const in 'w:\common\components\gui\Garant\Everest\Attr_Const.pas',
  TagName_Const in 'w:\common\components\gui\Garant\Everest\TagName_Const.pas',
  TagBody_Const in 'w:\common\components\gui\Garant\Everest\TagBody_Const.pas',
  TinyDocument_Const in 'w:\common\components\gui\Garant\Everest\TinyDocument_Const.pas',
  LeafParaDecorationsHolder_Const in 'w:\common\components\gui\Garant\Everest\LeafParaDecorationsHolder_Const.pas',
  DictEntry_Const in 'w:\common\components\gui\Garant\Everest\DictEntry_Const.pas',
  DocumentQuery_Const in 'w:\common\components\gui\Garant\Everest\DocumentQuery_Const.pas',
  AnnoTopic_Const in 'w:\common\components\gui\Garant\Everest\AnnoTopic_Const.pas',
  DocumentContainer_Const in 'w:\common\components\gui\Garant\Everest\DocumentContainer_Const.pas',
  Bookmark_Const in 'w:\common\components\rtl\Garant\EVD\Bookmark_Const.pas',
  evNative_AttrValues in 'w:\common\components\gui\Garant\Everest\evNative_AttrValues.pas',
  evNative_Schema in 'w:\common\components\gui\Garant\Everest\evNative_Schema.pas',
  evStyleInterfaceEx in 'w:\common\components\gui\Garant\Everest\evStyleInterfaceEx.pas',
  StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas',
  TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas',
  nevTableCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas',
  nevTableRowRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas',
  nevRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevRubberCellsRenderInfo.pas',
  nevFormatInfoList in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoList.pas',
  nevParaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevParaFormatInfo.pas',
  nevLeafRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevLeafRenderInfo.pas',
  nevTextParaRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTextParaRenderInfo.pas',
  nevZoomedCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedCellsRenderInfo.pas',
  nevZoomedRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedRubberCellsRenderInfo.pas',
  nevDocumentPartFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPartFormatInfo.pas',
  nevCommentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevCommentFormatInfo.pas',
  nevBitmapFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevBitmapFormatInfo.pas',
  nevControlFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevControlFormatInfo.pas',
  evFormulaParaBitmapContainer in 'w:\common\components\rtl\Garant\EVD\evFormulaParaBitmapContainer.pas',
  nevFormulaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormulaFormatInfo.pas',
  nevControlsBlockFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockFormatInfo.pas',
  nevCloakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevCloakFormatInfo.pas',
  evResultFontHolder in 'w:\common\components\gui\Garant\Everest\evResultFontHolder.pas',
  nevSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSegmentFormatInfo.pas',
  evGlyphFont in 'w:\common\components\gui\Garant\Everest\evGlyphFont.pas',
  nevObjectSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevObjectSegmentFormatInfo.pas',
  nevSBSCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSCellFormatInfo.pas',
  nevSBSRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSRowFormatInfo.pas',
  nevTableRowRenderInfoEx in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfoEx.pas',
  nevReqRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevReqRowFormatInfo.pas',
  nevPageBreakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevPageBreakFormatInfo.pas',
  nevNodeGroupFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevNodeGroupFormatInfo.pas',
  nevFormatInfoFactory in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoFactory.pas',
  evStandardStylesListPrim in 'w:\common\components\gui\Garant\Everest\evStandardStylesListPrim.pas',
  evStandardStylesList in 'w:\common\components\gui\Garant\Everest\evStandardStylesList.pas',
  evStandardStyles in 'w:\common\components\gui\Garant\Everest\evStandardStyles.pas',
  evdStylesRes in 'w:\common\components\rtl\Garant\EVD\evdStylesRes.pas' {evdStyles_Res: TDataModule},
  l3ImageList in 'w:\common\components\rtl\Garant\L3\l3ImageList.pas',
  nevFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfo.pas',
  nevFormatInfoArray in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoArray.pas',
  nevListFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevListFormatInfo.pas',
  nevDocumentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentFormatInfo.pas',
  Printers {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Printers.pas' {$EndIf},
  Consts {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas' {$EndIf},
  l3Printer in 'w:\common\components\rtl\Garant\L3\l3Printer.pas',
  l3PrinterIC in 'w:\common\components\rtl\Garant\L3\l3PrinterIC.pas',
  nevRootFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevRootFormatInfo.pas',
  m2MemLib in 'w:\common\components\rtl\Garant\L3\m2\m2MemLib.pas',
  nevRootFormatInfoListPrim in 'w:\common\components\gui\Garant\Everest\new\nevRootFormatInfoListPrim.pas',
  nevPrintingRootFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevPrintingRootFormatInfo.pas',
  nevFormatPool in 'w:\common\components\gui\Garant\Everest\new\nevFormatPool.pas',
  nevSectionBreakListPrim in 'w:\common\components\gui\Garant\Everest\nevSectionBreakListPrim.pas',
  nevSectionBreakList in 'w:\common\components\gui\Garant\Everest\nevSectionBreakList.pas',
  nevDocumentContainerPrimPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrimPrim.pas',
  nevDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrim.pas',
  SectionBreak_Const in 'w:\common\components\rtl\Garant\EVD\SectionBreak_Const.pas',
  nevObjectHolderPrim in 'w:\common\components\gui\Garant\Everest\nevObjectHolderPrim.pas',
  l3DocumentsCacheService in 'w:\common\components\rtl\Garant\L3\l3DocumentsCacheService.pas',
  evDocumentsCachePrim in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCachePrim.pas',
  nevDocumentContainerListPrim in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerListPrim.pas',
  nevDocumentContainerList in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerList.pas',
  evDocumentsCache in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCache.pas',
  nevTextSourcePool in 'w:\common\components\gui\Garant\Everest\new\nevTextSourcePool.pas',
  afwPreviewNotifierPtrList in 'w:\common\components\gui\Garant\AFW\implementation\afwPreviewNotifierPtrList.pas',
  afwComplexDocumentPreview in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreview.pas',
  afwComplexDocumentPreviewFactory in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreviewFactory.pas',
  evSubImplementation in 'w:\common\components\gui\Garant\Everest\new\evSubImplementation.pas',
  l3Nodes in 'w:\common\components\rtl\Garant\L3\l3Nodes.pas',
  l3DatLst in 'w:\common\components\rtl\Garant\L3\l3DatLst.pas',
  l3Bits in 'w:\common\components\rtl\Garant\L3\l3Bits.pas',
  l3NodesModelPart in 'w:\common\components\rtl\Garant\L3\l3NodesModelPart.pas',
  evNode in 'w:\common\components\gui\Garant\Everest\new\evNode.pas',
  evSubNode in 'w:\common\components\gui\Garant\Everest\new\evSubNode.pas',
  nevDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainer.pas',
  evOpProc in 'w:\common\components\gui\Garant\Everest\evOpProc.pas',
  evDefaultContext in 'w:\common\components\gui\Garant\Everest\evDefaultContext.pas',
  evDocumentContainerWithProcessor in 'w:\common\components\gui\Garant\Everest\new\evDocumentContainerWithProcessor.pas',
  nevPersistentDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPersistentDocumentContainer.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evLocationBase in 'w:\common\components\gui\Garant\Everest\evLocationBase.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evPara_InterfaceFactory.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4AnchorMapper in 'w:\common\components\gui\Garant\Everest\evInevBaseLine4AnchorMapper.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4PrintMapper in 'w:\common\components\gui\Garant\Everest\evInevBaseLine4PrintMapper.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evIevAnchorIndexMapper in 'w:\common\components\gui\Garant\Everest\new\evIevAnchorIndexMapper.pas'
  {$If defined(evNeedPainters)}
  ,
  evInevDrawingShapeMapper in 'w:\common\components\gui\Garant\Everest\evInevDrawingShapeMapper.pas'
  {$IfEnd} //evNeedPainters
  ,
  evInevParaMapper in 'w:\common\components\gui\Garant\Everest\new\evInevParaMapper.pas',
  evPageBreak_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evPageBreak_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evPageBreakPainter in 'w:\common\components\gui\Garant\Everest\evPageBreakPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evUseVisibleCursors)}
  ,
  evBreakParaCursor in 'w:\common\components\gui\Garant\Everest\evBreakParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevBreakParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevBreakParaAnchor.pas',
  evSectionBreak_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSectionBreak_InterfaceFactory.pas'
  {$If defined(evNeedPainters)}
  ,
  evSectionBreakPainter in 'w:\common\components\gui\Garant\Everest\evSectionBreakPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot)}
  ,
  evSectionBreakHotSpot in 'w:\common\components\gui\Garant\Everest\evSectionBreakHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  ,
  evStyle in 'w:\common\components\rtl\Garant\EVD\evStyle.pas',
  k2DictItem in 'w:\common\components\rtl\Garant\K2\k2DictItem.pas',
  k2Layer in 'w:\common\components\rtl\Garant\K2\k2Layer.pas',
  evdNative_AttrValues in 'w:\common\components\rtl\Garant\EVD\evdNative_AttrValues.pas',
  evdNative_Schema in 'w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas',
  ObjectWithHandle_Const in 'w:\common\components\rtl\Garant\EVD\ObjectWithHandle_Const.pas',
  evdFrame_Const in 'w:\common\components\rtl\Garant\EVD\evdFrame_Const.pas',
  Para_Const in 'w:\common\components\rtl\Garant\EVD\Para_Const.pas',
  LeafPara_Const in 'w:\common\components\rtl\Garant\EVD\LeafPara_Const.pas',
  evCursorController in 'w:\common\components\gui\Garant\Everest\evCursorController.pas',
  evWindowCursor in 'w:\common\components\gui\Garant\Everest\evWindowCursor.pas',
  evEditorInterfacesMisc in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesMisc.pas',
  evBitmapReader in 'w:\common\components\gui\Garant\Everest\evBitmapReader.pas',
  evParaFrame in 'w:\common\components\gui\Garant\Everest\evParaFrame.pas',
  evUsialParagraph in 'w:\common\components\gui\Garant\Everest\evUsialParagraph.pas',
  evRange in 'w:\common\components\gui\Garant\Everest\evRange.pas',
  evBlockCursor in 'w:\common\components\gui\Garant\Everest\evBlockCursor.pas',
  nevSelection in 'w:\common\components\gui\Garant\Everest\nevSelection.pas',
  l3Tool in 'w:\common\components\rtl\Garant\L3\l3Tool.pas',
  l3DataObjectEnum in 'w:\common\components\rtl\Garant\L3\l3DataObjectEnum.pas',
  ShlObj {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShlObj.pas' {$EndIf},
  l3DataObject in 'w:\common\components\rtl\Garant\L3\l3DataObject.pas',
  l3StorableDataObject in 'w:\common\components\rtl\Garant\L3\l3StorableDataObject.pas',
  evDataObject in 'w:\common\components\gui\Garant\Everest\evDataObject.pas',
  evEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evEditorWindowHotSpot.pas',
  OvcController in 'w:\common\components\rtl\external\Orpheus\OvcController.pas',
  OvcBase in 'w:\common\components\rtl\external\Orpheus\OvcBase.pas',
  afwControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControlPrim.pas',
  l3ControlCanvas in 'w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas',
  l3WinControlCanvas in 'w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas'
  {$If not defined(NoScripts)}
  ,
  kwVTControlsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwVTControlsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopSpinEditSetValue in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopSpinEditSetValue.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRadioButtonFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwRadioButtonFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopRadioButtonGetChecked in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopRadioButtonGetChecked.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopRadioButtonSetChecked in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopRadioButtonSetChecked.pas'
  {$IfEnd} //not NoScripts
  ,
  l3ControlsTypes in 'w:\common\components\rtl\Garant\L3\l3ControlsTypes.pas',
  afwInputControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInputControl.pas'
  {$If not defined(NoScripts)}
  ,
  PanelProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  RadioGroupWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  ExtCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas' {$EndIf},
  vtHeader in 'w:\common\components\gui\Garant\VT\vtHeader.pas',
  l3LogicalArray in 'w:\common\components\rtl\Garant\L3\l3LogicalArray.pas',
  OvcColor in 'w:\common\components\rtl\external\Orpheus\OvcColor.pas',
  l3FontTools in 'w:\common\components\rtl\Garant\L3\l3FontTools.pas',
  OvcData in 'w:\common\components\rtl\external\Orpheus\OvcData.pas',
  OvcExcpt in 'w:\common\components\rtl\external\Orpheus\OvcExcpt.pas',
  vtStdRes in 'w:\common\components\gui\Garant\VT\vtStdRes.pas' {vtStdResources: TDataModule},
  l3TabStops in 'w:\common\components\rtl\Garant\L3\l3TabStops.pas',
  l3FormattedLines in 'w:\common\components\rtl\Garant\L3\l3FormattedLines.pas',
  vtHintManager in 'w:\common\components\gui\Garant\VT\vtHintManager.pas'
  {$If not defined(NoScripts)}
  ,
  vtHintWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwApplicationCancelHint in 'w:\common\components\rtl\Garant\ScriptEngine\kwApplicationCancelHint.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwApplicationIsHintVisible in 'w:\common\components\rtl\Garant\ScriptEngine\kwApplicationIsHintVisible.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwApplicationGetLastHint in 'w:\common\components\rtl\Garant\ScriptEngine\kwApplicationGetLastHint.pas'
  {$IfEnd} //not NoScripts
  ,
  l3CustomControlCanvas in 'w:\common\components\rtl\Garant\L3\l3CustomControlCanvas.pas',
  vtMultilineHint in 'w:\common\components\gui\Garant\VT\vtMultilineHint.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopListerSelectWithShift in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopListerSelectWithShift.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopListerFooterCaption in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopListerFooterCaption.pas'
  {$IfEnd} //not NoScripts
  ,
  afwCustomCommonControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControlPrim.pas',
  afwCustomCommonControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControl.pas',
  ElXPThemedControl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElXPThemedControl.pas'
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  kwPopPageControlPageCaptionByIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopPageControlPageCaptionByIndex.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  kwPopPageControlFindPageByCaption in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopPageControlFindPageByCaption.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  kwPopPageControlPageByIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopPageControlPageByIndex.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopListerGetSelected in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopListerGetSelected.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopCheckListBoxSetCheked in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopCheckListBoxSetCheked.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopCheckListBoxUncheckAll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopCheckListBoxUncheckAll.pas'
  {$IfEnd} //not NoScripts
  ,
  DragData in 'w:\common\components\gui\Garant\VT\DragData.pas'
  {$If not defined(NoScripts)}
  ,
  kwDDSupportGetState in 'w:\common\components\rtl\Garant\ScriptEngine\kwDDSupportGetState.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TreeViewWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeViewNodeFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeViewNodeFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopTreeViewGetItem in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopTreeViewGetItem.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeNodeFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeNodeFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopTreeNodeGetNext in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopTreeNodeGetNext.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopTreeNodeHasChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopTreeNodeHasChildren.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TreeNodeRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\TreeNodeRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TreeViewRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewRegistrator.pas'
  {$IfEnd} //not NoScripts
  ,
  ComCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  vtStatusPanelFromStack in 'w:\common\components\rtl\Garant\ScriptEngine\vtStatusPanelFromStack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopVtStatusPanelGetText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopVtStatusPanelGetText.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtSpinEditRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\vtSpinEditRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  RadioButtonRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtStatusBarRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\vtStatusBarRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  CheckListBoxRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ElCustomPageControlRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\ElCustomPageControlRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtStatusPanelRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\vtStatusPanelRegistrator.pas'
  {$IfEnd} //not NoScripts
  ,
  afwDrawing in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwDrawing.pas',
  vtStatusBar in 'w:\common\components\gui\Garant\VT\vtStatusBar.pas'
  {$If not defined(NoScripts)}
  ,
  vtStatusBarFromStack in 'w:\common\components\rtl\Garant\ScriptEngine\vtStatusBarFromStack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopVtStatusBarGetPanel in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopVtStatusBarGetPanel.pas'
  {$IfEnd} //not NoScripts
  ,
  CheckLst {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CheckLst.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  kwCheckListBox in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckListBox.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopCheckListBoxGetChecked in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopCheckListBoxGetChecked.pas'
  {$IfEnd} //not NoScripts
  ,
  ElPgCtl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtl.pas'
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  kwPageControlFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwPageControlFromStackWord.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  kwPopPageControlGetAllPageCaptions in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopPageControlGetAllPageCaptions.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  ,
  vtLister in 'w:\common\components\gui\Garant\VT\vtLister.pas'
  {$If not defined(NoScripts)}
  ,
  kwVTCustomListerFromStackWords in 'w:\common\components\rtl\Garant\ScriptEngine\kwVTCustomListerFromStackWords.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopListerGetCurrent in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopListerGetCurrent.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSpintEditFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSpintEditFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopSpinEditGetValue in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopSpinEditGetValue.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ComboBoxProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComboBoxProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  StdCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas' {$EndIf},
  l3Operations in 'w:\common\components\rtl\Garant\L3\l3Operations.pas',
  l3SysUtils in 'w:\common\components\rtl\Garant\L3\l3SysUtils.pas',
  l3DropTarget in 'w:\common\components\rtl\Garant\L3\l3DropTarget.pas',
  l3DropSource in 'w:\common\components\rtl\Garant\L3\l3DropSource.pas',
  afwVCL in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas',
  afwHintManager in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas',
  afwBaseControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwBaseControl.pas',
  afwControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControl.pas',
  nevControl in 'w:\common\components\gui\Garant\Everest\nevControl.pas',
  evCustomEditorWindowPrim in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowPrim.pas'
  {$If not defined(NoScripts)}
  ,
  evSchemaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInteger.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIntegerConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerConstantRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRegisteredEnums in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisteredEnums.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwEnumRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRegisterSchema in 'w:\common\components\rtl\Garant\ScriptEngine\kwRegisterSchema.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStyleTableSaveToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableSaveToFile.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStyleTableChanging in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanging.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStyleTableChanged in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanged.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwSysUtilsWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSysUtilsWord.pas'
  {$IfEnd} //not NoScripts
  ,
  evEvdRd in 'w:\common\components\gui\Garant\Everest\evEvdRd.pas'
  {$If not defined(NoScripts)}
  ,
  kwEvdBin2EvdTxt in 'w:\common\components\rtl\Garant\ScriptEngine\kwEvdBin2EvdTxt.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  evParaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaStrA in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaStrA.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaStyleName in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaStyleName.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaIntA in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaIntA.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaText in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaText.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaBoolA in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaBoolA.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaBoolW in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaBoolW.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaGetParent in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaGetParent.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaGetType in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaGetType.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaIntW in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaIntW.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaIsSame in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaIsSame.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaTypeInherits in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaTypeInherits.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  EditorFromStackKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorFromStackKeyWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEditorFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetShowDocumentParts in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetShowDocumentParts.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetShowDocumentParts in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetShowDocumentParts.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSelectCellsWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSelectCellsWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas'
  {$IfEnd} //not NoScripts
  ,
  evCustomEditorWindowModelPart in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowModelPart.pas',
  nevRangeList in 'w:\common\components\gui\Garant\Everest\new\nevRangeList.pas',
  evMultiSelectionLocation in 'w:\common\components\gui\Garant\Everest\evMultiSelectionLocation.pas',
  evLeafParaMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evLeafParaMultiSelectionBlock.pas',
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
  evCustomEditor in 'w:\common\components\gui\Garant\Everest\evCustomEditor.pas'
  {$If not defined(NoScripts)}
  ,
  kwEditorWithToolsFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorWithToolsFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorNextHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorNextHyperlink.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorPrevHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrevHyperlink.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorScrollBottom in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorScrollBottom.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorScrollTo in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorScrollTo.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorWheelScroll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectColumn.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectCellsVertical in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorMergeTablesWithTimer in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorMergeTablesWithTimer.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorMergeCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorMergeCells.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorJumpToHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas'
  {$IfEnd} //not NoScripts
  ,
  l3FrameLine in 'w:\common\components\rtl\Garant\L3\l3FrameLine.pas',
  l3FrameLineList in 'w:\common\components\rtl\Garant\L3\l3FrameLineList.pas',
  l3InterfacedIntegerList in 'w:\common\components\rtl\Garant\L3\l3InterfacedIntegerList.pas',
  l3CoordinateMap in 'w:\common\components\rtl\Garant\L3\l3CoordinateMap.pas',
  l3FrameObject in 'w:\common\components\rtl\Garant\L3\l3FrameObject.pas',
  l3FrameLinesSpy in 'w:\common\components\rtl\Garant\L3\l3FrameLinesSpy.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopEditorRepaintTableLinesAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintTableLinesAndCheckWithEtalon.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorPushParaFromCursor in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPushParaFromCursor.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorPrintAcnhor in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintAcnhor.pas'
  {$IfEnd} //not NoScripts
  ,
  nevFormatInfoUtils in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoUtils.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopEditorPrintTableCellsParams in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintTableCellsParams.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSplitCell in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSplitCell.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorLP2DP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorLP2DP.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorDP2LP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDP2LP.pas'
  {$IfEnd} //not NoScripts
  ,
  evTableSearch in 'w:\common\components\gui\Garant\EverestCommon\evTableSearch.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopEditorCheckContinueCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckContinueCells.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorDocumentTailVisible in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDocumentTailVisible.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetDrawSpecial in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetDrawSpecial.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetDrawSpecial in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetDrawSpecial.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetWebStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetWebStyle.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetWebStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetWebStyle.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetLeftIndentDelta in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLeftIndentDelta.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetDrawLines in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetDrawLines.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetDrawLines in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetDrawLines.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorScrollLineUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorScrollLineUp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorScrollLineDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorScrollLineDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEditorFromStackCursorWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaUp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorAtTop in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorAtTop.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEnd.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaHome in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaHome.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectTable in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectTable.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectAll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectAll.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectPara in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectPara.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEditorFromStackTextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTextParaWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEditorFromStackNextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackNextParaWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorHasComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorHasComment.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorDeleteUserComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDeleteUserComment.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorCurrentText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCurrentText.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorUpdateCursorFromHotSpot in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpot.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorUpdateCursorFromHotSpotEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpotEx.pas'
  {$IfEnd} //not NoScripts
  ,
  evdMarkEliminator in 'w:\common\components\rtl\Garant\EVD\evdMarkEliminator.pas',
  evdDocumentMarksEliminator in 'w:\common\components\rtl\Garant\EVD\evdDocumentMarksEliminator.pas',
  evdDocumentBookmarksEliminator in 'w:\common\components\rtl\Garant\EVD\evdDocumentBookmarksEliminator.pas',
  evdDocumentSubsEliminator in 'w:\common\components\rtl\Garant\EVD\evdDocumentSubsEliminator.pas',
  evDocumentSubsChildrenCountEliminator in 'w:\common\components\gui\Garant\EverestCommon\evDocumentSubsChildrenCountEliminator.pas',
  evdHypelinkDocIDEliminator in 'w:\common\components\rtl\Garant\EVD\evdHypelinkDocIDEliminator.pas',
  evdBufferedFilter in 'w:\common\components\rtl\Garant\EVD\evdBufferedFilter.pas',
  evdEmptySubsEliminator in 'w:\common\components\rtl\Garant\EVD\evdEmptySubsEliminator.pas',
  evdStartAndTimeEliminator in 'w:\common\components\gui\Garant\Everest\evdStartAndTimeEliminator.pas',
  imageenio in 'w:\common\components\rtl\external\ImageEn\src\imageenio.pas',
  ddConst in 'w:\common\components\rtl\Garant\dd\ddConst.pas',
  ddUtils in 'w:\common\components\rtl\Garant\dd\ddUtils.pas',
  ddPicturePathListner in 'w:\common\components\rtl\Garant\dd\ddPicturePathListner.pas',
  evBitmapEliminator4Tests in 'w:\common\components\gui\Garant\Everest\evBitmapEliminator4Tests.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopEditorTextToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorTextToFile.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetSelectionText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionText.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetParaByID in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetParaByID.pas'
  {$IfEnd} //not NoScripts
  ,
  evdHeaderHyperlinkAdder in 'w:\common\components\gui\Garant\Everest\evdHeaderHyperlinkAdder.pas',
  evdBlockNameAdder in 'w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetSelectionTextInFormat in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionTextInFormat.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwBlockResize.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResize.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectCellByMouse in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellByMouse.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetTextParaStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetTextParaStyle.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorDeleteRow in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDeleteRow.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorInsertRow in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertRow.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorInsertTable in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertTable.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorInsertPageBreak in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertPageBreak.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSplitTable in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSplitTable.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorMergeTables in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorMergeTables.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetCursorByPoint in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetCursorByPoint.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorRepaintAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas'
  {$IfEnd} //nsTest AND not NoScripts
  ,
  l3ObjectsMemoryManager in 'w:\common\components\rtl\Garant\L3\l3ObjectsMemoryManager.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopEditorCopyAndPaste2DocumentBottom in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCopyAndPaste2DocumentBottom.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSetAllowRubberTables in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetAllowRubberTables.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetAllowRubberTables in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetAllowRubberTables.pas'
  {$IfEnd} //not NoScripts
  ,
  ctTypes in 'w:\common\components\gui\Garant\VT\ComboTree\ctTypes.pas',
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
  nevPrintView in 'w:\common\components\gui\Garant\Everest\new\nevPrintView.pas',
  l3Prg in 'w:\common\components\rtl\Garant\L3\l3Prg.pas',
  evAbortFilter in 'w:\common\components\gui\Garant\Everest\evAbortFilter.pas',
  evCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evCommentsEliminator.pas',
  evHiddenFilter in 'w:\common\components\gui\Garant\Everest\evHiddenFilter.pas',
  evdPageParamsFilter in 'w:\common\components\rtl\Garant\EVD\evdPageParamsFilter.pas',
  evNotifiedProcessor in 'w:\common\components\gui\Garant\Everest\evNotifiedProcessor.pas',
  evPreviewProcessor in 'w:\common\components\gui\Garant\Everest\evPreviewProcessor.pas',
  evPreviewForTestsTuning in 'w:\common\components\gui\Garant\Everest\evPreviewForTestsTuning.pas',
  nevDocumentProvider in 'w:\common\components\gui\Garant\Everest\nevDocumentProvider.pas',
  l3FileUtils in 'w:\common\components\rtl\Garant\L3\l3FileUtils.pas'
  {$If defined(InsiderTest)}
  ,
  evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
  {$IfEnd} //InsiderTest
  ,
  l3AFWExceptions in 'w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas'
  {$If not defined(NoScripts)}
  ,
  l3ScriptService in 'w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas'
  {$IfEnd} //not NoScripts
  ,
  l3BatchService in 'w:\common\components\rtl\Garant\L3\l3BatchService.pas'
  {$If defined(nsTest)}
  ,
  afwAnswer in 'w:\common\components\rtl\Garant\L3\afwAnswer.pas'
  {$IfEnd} //nsTest
  ,
  evDocumentPreviewPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPreviewPrim.pas',
  evDocumentPreview in 'w:\common\components\gui\Garant\Everest\evDocumentPreview.pas',
  evHAFPainterMacros in 'w:\common\components\gui\Garant\Everest\evHAFPainterMacros.pas',
  evSBSPar in 'w:\common\components\gui\Garant\Everest\evSBSPar.pas',
  nevObjectHolder in 'w:\common\components\gui\Garant\Everest\nevObjectHolder.pas',
  nevHAFPainterView in 'w:\common\components\gui\Garant\Everest\new\nevHAFPainterView.pas',
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
  Themes {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Themes.pas' {$EndIf},
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
  Clipbrd {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Clipbrd.pas' {$EndIf},
  ctAbstractEdit in 'w:\common\components\gui\Garant\VT\ComboTree\ctAbstractEdit.pas'
  {$If not defined(NoVGScene)}
  ,
  vgAnyObjectList in 'w:\common\components\rtl\external\VGScene\vgAnyObjectList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgComponent in 'w:\common\components\rtl\external\VGScene\vgComponent.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomObject in 'w:\common\components\rtl\external\VGScene\vgCustomObject.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgTypesPrim in 'w:\common\components\rtl\external\VGScene\vgTypesPrim.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgSortableObjectList in 'w:\common\components\rtl\external\VGScene\vgSortableObjectList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomObjectList in 'w:\common\components\rtl\external\VGScene\vgCustomObjectList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgObject in 'w:\common\components\rtl\external\VGScene\vgObject.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgTypes in 'w:\common\components\rtl\external\VGScene\vgTypes.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgObjectList in 'w:\common\components\rtl\external\VGScene\vgObjectList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgPersistent in 'w:\common\components\rtl\external\VGScene\vgPersistent.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgBounds in 'w:\common\components\rtl\external\VGScene\vgBounds.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgPosition in 'w:\common\components\rtl\external\VGScene\vgPosition.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgVisualObject in 'w:\common\components\rtl\external\VGScene\vgVisualObject.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  VGSceneWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGSceneWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomResources in 'w:\common\components\rtl\external\VGScene\vgCustomResources.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomCanvas in 'w:\common\components\rtl\external\VGScene\vgCustomCanvas.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgInterfacedPersistent in 'w:\common\components\rtl\external\VGScene\vgInterfacedPersistent.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomBitmap in 'w:\common\components\rtl\external\VGScene\vgCustomBitmap.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgInterfaces in 'w:\common\components\rtl\external\VGScene\vgInterfaces.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgSceneList in 'w:\common\components\rtl\external\VGScene\vgSceneList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomGradientPoint in 'w:\common\components\rtl\external\VGScene\vgCustomGradientPoint.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgGradientPoint in 'w:\common\components\rtl\external\VGScene\vgGradientPoint.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgGradientPoints in 'w:\common\components\rtl\external\VGScene\vgGradientPoints.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgCustomControl in 'w:\common\components\rtl\external\VGScene\vgCustomControl.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgScenePrim in 'w:\common\components\rtl\external\VGScene\vgScenePrim.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgVisual in 'w:\common\components\rtl\external\VGScene\vgVisual.pas'
  {$IfEnd} //not NoVGScene
  ,
  l3ProcessMessagesManager in 'w:\common\components\rtl\Garant\L3\l3ProcessMessagesManager.pas'
  {$If not defined(NoVGScene)}
  ,
  vgVisualObjectList in 'w:\common\components\rtl\external\VGScene\vgVisualObjectList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_extctrls in 'w:\common\components\rtl\external\VGScene\vg_extctrls.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_scene in 'w:\common\components\rtl\external\VGScene\vg_scene.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_controls in 'w:\common\components\rtl\external\VGScene\vg_controls.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlGetIsChecked in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlGetIsChecked.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlCountSiblingLikeMe in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlCountSiblingLikeMe.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlClick in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlClick.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlName in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlName.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlEnabled in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlEnabled.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlTopInScene in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlTopInScene.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlLeftInScene in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlLeftInScene.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlScene in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlScene.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlLeft in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlLeft.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlTop in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlTop.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_listbox in 'w:\common\components\rtl\external\VGScene\vg_listbox.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVGControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwVGControlWord.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVGComboboxWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwVGComboboxWord.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgComboBoxItemHeight in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgComboBoxItemHeight.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlWidth in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlWidth.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlHeight in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlHeight.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgComboBoxItemIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgComboBoxItemIndex.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgComboBoxGetText in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgComboBoxGetText.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlVisible in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlVisible.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_objects in 'w:\common\components\rtl\external\VGScene\vg_objects.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwPopControlFindVGControlByName in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlFindVGControlByName.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVGVisualObjectWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwVGVisualObjectWord.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  kwVgControlSetIsChecked in 'w:\common\components\rtl\Garant\ScriptEngine\kwVgControlSetIsChecked.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  ,
  ElUxTheme in 'w:\common\components\gui\Garant\VT\elClone\Source\ElUxTheme.pas',
  l3CBTListenersList in 'w:\common\components\rtl\Garant\L3\l3CBTListenersList.pas',
  l3GetMessageListenersList in 'w:\common\components\rtl\Garant\L3\l3GetMessageListenersList.pas',
  l3WndProcListenersList in 'w:\common\components\rtl\Garant\L3\l3WndProcListenersList.pas',
  l3WndProcRetListenersList in 'w:\common\components\rtl\Garant\L3\l3WndProcRetListenersList.pas',
  l3MouseListenersList in 'w:\common\components\rtl\Garant\L3\l3MouseListenersList.pas',
  l3MouseWheelListenersList in 'w:\common\components\rtl\Garant\L3\l3MouseWheelListenersList.pas',
  l3ListenersHooks in 'w:\common\components\rtl\Garant\L3\l3ListenersHooks.pas',
  l3ListenersManager in 'w:\common\components\rtl\Garant\L3\l3ListenersManager.pas',
  ElPopBtn in 'w:\common\components\gui\Garant\Everest\ElPopBtn.pas',
  ElVclUtils in 'w:\common\components\gui\Garant\Everest\ElVclUtils.pas',
  AbstractDropDown in 'w:\common\components\gui\Garant\VT\ComboTree\AbstractDropDown.pas',
  vtTreeSource in 'w:\common\components\gui\Garant\VT\vtTreeSource.pas'
  {$If not defined(NoScripts)}
  ,
  vtOutlinerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeControlWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeSaveState in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeSaveState.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeItemWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeItemWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwControlTreeExpand in 'w:\common\components\rtl\Garant\ScriptEngine\kwControlTreeExpand.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeCurrentNodeIsExpanded in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeCurrentNodeIsExpanded.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwControlTreeChildrenCount in 'w:\common\components\rtl\Garant\ScriptEngine\kwControlTreeChildrenCount.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeCheckFlag in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeCheckFlag.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetCurrentNode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetCurrentNode.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemImageIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemImageIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemTop in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemTop.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemWidth in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemWidth.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemHeight in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemHeight.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemLeft in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemLeft.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemBounds in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemBounds.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItemsCount in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItemsCount.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetItem in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetItem.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeExpandAll in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeExpandAll.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeCollapseAll in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeCollapseAll.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeSetSelected in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeSetSelected.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeGetSelected in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeGetSelected.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeDeleteAllChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeDeleteAllChildren.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TreeIterateNodesUtils in 'w:\common\components\rtl\Garant\ScriptEngine\TreeIterateNodesUtils.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTreeIterateNodes in 'w:\common\components\rtl\Garant\ScriptEngine\kwTreeIterateNodes.pas'
  {$IfEnd} //not NoScripts
  ,
  l3TreeUtils in 'w:\common\components\rtl\Garant\L3\l3TreeUtils.pas',
  vtOutliner in 'w:\common\components\gui\Garant\VT\vtOutliner.pas',
  vtOutlinerWithQuickSearch in 'w:\common\components\gui\Garant\VT\vtOutlinerWithQuickSearch.pas',
  AbsSubTree in 'w:\common\components\gui\Garant\VT\ComboTree\AbsSubTree.pas',
  DropDownTree in 'w:\common\components\gui\Garant\VT\ComboTree\DropDownTree.pas',
  l3SimpleTree in 'w:\common\components\rtl\Garant\L3\l3SimpleTree.pas',
  EditableBox in 'w:\common\components\gui\Garant\VT\ComboTree\EditableBox.pas',
  ctComboBoxStringsItemNode in 'w:\common\components\gui\Garant\VT\ComboTree\ctComboBoxStringsItemNode.pas',
  ComboBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ComboBoxStrings.pas',
  ctFakeBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ctFakeBoxStrings.pas',
  FakeBox in 'w:\common\components\gui\Garant\VT\ComboTree\FakeBox.pas'
  {$If not defined(NoScripts)}
  ,
  vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas'
  {$IfEnd} //not NoScripts
  
(*  {$If not defined(NoScripts)}
  ,
  kwComboBoxFromStack in 'w:\common\components\rtl\Garant\ScriptEngine\kwComboBoxFromStack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopComboBoxGetItemIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboBoxGetItemIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopComboBoxDropDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboBoxDropDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopComboBoxIndexOf in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboBoxIndexOf.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopComboBoxSelectItem in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboBoxSelectItem.pas'
  {$IfEnd} //not NoScripts
  ,
  vtComboBoxQS in 'w:\common\components\gui\Garant\VT\vtComboBoxQS.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopComboBoxSetItemIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboBoxSetItemIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopComboBoxSaveItems in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboBoxSaveItems.pas'
  {$IfEnd} //not NoScripts*)

  {$If not defined(NoScripts)}
  //,
  //kwComboTreeFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwComboTreeFromStackWord.pas'
  {$IfEnd} //not NoScripts

  {$If not defined(NoScripts)}
  //,
  //kwPopComboTreeCurrentNode in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopComboTreeCurrentNode.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEditorFromStackTableColumnResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTableColumnResize.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorResizeTableColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas'
  {$IfEnd} //not NoScripts
  ,
  l3ParserInterfaces in 'w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas'
  {$If not defined(NoScripts)}
  ,
  tfwParserInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorResizeTableColumnEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumnEX.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordRefList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwForwardDeclarationHolder in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclarationHolder.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRuntimeWordWithCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCode.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRuntimeWordWithCodeExecution in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCodeExecution.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwLeftParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwLeftParam.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRightParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwRightParam.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwNewWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwNewWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArray.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledVar in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwVar in 'w:\common\components\rtl\Garant\ScriptEngine\tfwVar.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwLeftWordRefParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwLeftWordRefParam.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIn in 'w:\common\components\rtl\Garant\ScriptEngine\kwIn.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledVarWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVarWorker.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  //,
  //kwCompiledPopToVar in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledPopToVar.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledInitParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledInitParam.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStoredValues in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\kwInteger.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwString in 'w:\common\components\rtl\Garant\ScriptEngine\kwString.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIntegerList in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIntegerArray in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerArray.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIntegerFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerFactory.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStringList in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringFactory.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCompilingWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompilingWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwAnonimousWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAnonimousWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTemporaryCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTemporaryCompiledCode.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorker.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCheckWithEtalon.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckWithEtalon.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetLMargin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLMargin.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetWrapLimit in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetWrapLimit.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorBlockResizeEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResizeEX.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwInsertFromStreamCommon in 'w:\common\components\rtl\Garant\ScriptEngine\kwInsertFromStreamCommon.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorPasteRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteRTF.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorInsertStream in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertStream.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorGetModified in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetModified.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorPasteEVDTroughClipboard in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteEVDTroughClipboard.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(InsiderTest) AND not defined(NoScripts)}
  ,
  kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
  {$IfEnd} //InsiderTest AND not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  kwBeginWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginWaitPrint.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEndWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  EditorParaCoordsToScreenPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorParaCoordsToScreenPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreen.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaCoordsToScreen.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaEndCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEndCoordsToScreen.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorParaMiddleCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaMiddleCoordsToScreen.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorCursorCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCursorCoordsToScreen.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  //,
  //kwPopControlGetFont in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlGetFont.pas'
  {$IfEnd} //not NoScripts
  ,
  nevObjectList in 'w:\common\components\gui\Garant\Everest\new\nevObjectList.pas',
  nevBaseDrawView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDrawView.pas',
  nevView in 'w:\common\components\gui\Garant\Everest\new\nevView.pas',
  evCustomEditorWindow in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindow.pas',
  l3InternalInterfaces in 'w:\common\components\rtl\Garant\L3\l3InternalInterfaces.pas',
  l3BaseStream in 'w:\common\components\rtl\Garant\L3\l3BaseStream.pas',
  l3Memory in 'w:\common\components\rtl\Garant\L3\l3Memory.pas',
  l3StringAdapter in 'w:\common\components\rtl\Garant\L3\l3StringAdapter.pas',
  l3CustomString in 'w:\common\components\rtl\Garant\L3\l3CustomString.pas',
  l3StringListPrim in 'w:\common\components\rtl\Garant\L3\l3StringListPrim.pas',
  l3StringList1 in 'w:\common\components\rtl\Garant\L3\l3StringList1.pas',
  l3StringList2 in 'w:\common\components\rtl\Garant\L3\l3StringList2.pas',
  l3StringList in 'w:\common\components\rtl\Garant\L3\l3StringList.pas'
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingInterfaces.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWordPrim.pas'
  {$IfEnd} //not NoScripts
  ,
  Classes {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas' {$EndIf},
  Graphics {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas' {$EndIf},
  l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas',
  l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas',
  l3ObjectRefList1 in 'w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas',
  l3TwoByteCString in 'w:\common\components\rtl\Garant\L3\l3TwoByteCString.pas',
  l3OneByteCString in 'w:\common\components\rtl\Garant\L3\l3OneByteCString.pas',
  l3CEmptyStringPrim in 'w:\common\components\rtl\Garant\L3\l3CEmptyStringPrim.pas',
  l3CEmptyString in 'w:\common\components\rtl\Garant\L3\l3CEmptyString.pas',
  l3FourByteCString in 'w:\common\components\rtl\Garant\L3\l3FourByteCString.pas',
  l3Base in 'w:\common\components\rtl\Garant\L3\l3Base.pas',
  l3ProtoObject in 'w:\common\components\rtl\Garant\L3\l3ProtoObject.pas',
  l3ProtoObjectWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas',
  l3SimpleObject in 'w:\common\components\rtl\Garant\L3\l3SimpleObject.pas',
  l3_Base in 'w:\common\components\rtl\Garant\L3\l3_Base.pas',
  Contnrs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Contnrs.pas' {$EndIf},
  IOUnit in 'w:\shared\GCI\IOUnit.pas',
  BaseTypesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTypesUnit.pas',
  DynamicTreeDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeDefinesUnit.pas',
  DynamicTreeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeUnit.pas',
  ExternalObjectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalObjectUnit.pas',
  UnderControlUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UnderControlUnit.pas',
  ContextSearchSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ContextSearchSupportUnit.pas',
  BaseTreeSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTreeSupportUnit.pas',
  FoldersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FoldersUnit.pas',
  DocumentUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DocumentUnit.pas',
  FiltersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FiltersUnit.pas',
  ProgressIndicatorSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ProgressIndicatorSupportUnit.pas',
  SearchProgressIndicatorUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchProgressIndicatorUnit.pas',
  DynamicDocListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicDocListUnit.pas',
  atDocumentHistory in 'OperationsFramework\atDocumentHistory.pas',
  atListHistory in 'OperationsFramework\atListHistory.pas',
  atUserWorkContext in 'OperationsFramework\atUserWorkContext.pas',
  SecurityUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SecurityUnit.pas',
  SettingsUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SettingsUnit.pas',
  BannerUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BannerUnit.pas',
  StartUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\StartUnit.pas',
  NotifyUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\NotifyUnit.pas',
  atInterfaces in 'atInterfaces.pas',
  atNotifier in 'CoreObjects\atNotifier.pas',
  GblAdapter,
  ChatInterfacesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ChatInterfacesUnit.pas',
  atStringToStringConverterBase in 'CoreObjects\atStringToStringConverterBase.pas',
  Variants,
  atLogger in 'CoreObjects\atLogger.pas',
  atCommon in 'atCommon.pas',
  SearchDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchDefinesUnit.pas',
  SearchUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchUnit.pas',
  UserJournalUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UserJournalUnit.pas',
  l3RegEx in 'w:\common\components\rtl\Garant\L3\l3RegEx.pas',
  atStringHelper in 'AdapterHelpers\atStringHelper.pas',
  atFoldersHelper in 'AdapterHelpers\atFoldersHelper.pas',
  atNotification in 'CoreObjects\atNotification.pas',
  XMLIntf {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Internet\XMLIntf.pas' {$EndIf},
  atQueryTypeConverter in 'AdapterHelpers\atQueryTypeConverter.pas',
  atQueryLogicOperationConverter in 'AdapterHelpers\atQueryLogicOperationConverter.pas',
  XMLDoc {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Internet\XMLDoc.pas' {$EndIf},
  atNonATQueryLogicOperationConverter in 'AdapterHelpers\atNonATQueryLogicOperationConverter.pas',
  atQuery in 'AdapterHelpers\atQuery.pas',
  atUserJournalHelper in 'AdapterHelpers\atUserJournalHelper.pas',
  atDocumentHelper in 'AdapterHelpers\atDocumentHelper.pas',
  atNodeHelper in 'AdapterHelpers\atNodeHelper.pas',
  atUserListHelper in 'AdapterHelpers\atUserListHelper.pas',
  atBaseEvdHelper in 'EvdHelpers\atBaseEvdHelper.pas',
  atChatMessage in 'EvdHelpers\atChatMessage.pas',
  atUserComment in 'EvdHelpers\atUserComment.pas',
  atChatWorker in 'AdapterHelpers\atChatWorker.pas',
  atGblAdapterWorker in 'AdapterHelpers\atGblAdapterWorker.pas',
  atExecutionContext in 'OperationsFramework\atExecutionContext.pas',
  atParameter in 'CoreObjects\atParameter.pas',
  atNamedParameter in 'CoreObjects\atNamedParameter.pas',
  atOperationEnv in 'OperationsFramework\atOperationEnv.pas',
  atOperationParameter in 'OperationsFramework\atOperationParameter.pas',
  atStringListWithOwn in 'CoreObjects\atStringListWithOwn.pas',
  atOperationParametersList in 'OperationsFramework\atOperationParametersList.pas',
  atOperationBase in 'OperationsFramework\atOperationBase.pas',
  atCRC32 in 'atCRC32.pas',
  atScenario in 'OperationsFramework\atScenario.pas',
  atCommandLineParameter in 'CoreObjects\atCommandLineParameter.pas',
  atCommandLineParametersList in 'CoreObjects\atCommandLineParametersList.pas',
  atCommandLine in 'CoreObjects\atCommandLine.pas',
  atAdapterTestCommandLine in 'Runner\atAdapterTestCommandLine.pas',
  atOperationFactory in 'OperationsFramework\atOperationFactory.pas',
  atXMLScenarioGenerator in 'OperationsFramework\atXMLScenarioGenerator.pas',
  atScenarioPlayer in 'OperationsFramework\atScenarioPlayer.pas',
  atAdapterTest in 'Runner\atAdapterTest.pas'
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const in 'w:\common\components\gui\Garant\Everest_Engine\f1TextStyle_Const.pas'
  {$IfEnd} //Nemesis
  ,
  Everest_Schema in 'w:\common\components\gui\Garant\Everest\Everest_Schema.pas'
  {$If defined(Nemesis)}
  ,
  eeTextPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest_Engine\eeTextPara_InterfaceFactory.pas'
  {$IfEnd} //Nemesis
  ,
  eeTextParaCursor in 'w:\common\components\gui\Garant\Everest_Engine\eeTextParaCursor.pas',
  eeInterfaces in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas',
  eeInterfacesEx in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfacesEx.pas'
  {$If defined(Nemesis)}
  ,
  eeTagEditorTool in 'w:\common\components\gui\Garant\Everest_Engine\eeTagEditorTool.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeSubList in 'w:\common\components\gui\Garant\Everest_Engine\eeSubList.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eePara in 'w:\common\components\gui\Garant\Everest_Engine\eePara.pas'
  {$IfEnd} //Nemesis
  ,
  eeCursorTools in 'w:\common\components\gui\Garant\Everest_Engine\eeCursorTools.pas',
  eeTextCursorPair in 'w:\common\components\gui\Garant\Everest_Engine\eeTextCursorPair.pas'
  {$If defined(Nemesis)}
  ,
  eeDocument_InterfaceFactory in 'w:\common\components\gui\Garant\Everest_Engine\eeDocument_InterfaceFactory.pas'
  {$IfEnd} //Nemesis
  ,
  eeDocumentCursor in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentCursor.pas',
  eeDocumentCursorPair in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentCursorPair.pas'
  {$If defined(Nemesis)}
  ,
  F1_AttrValues in 'w:\common\components\gui\Garant\Everest_Engine\F1_AttrValues.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  F1_Schema in 'w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeDocument_Schema in 'w:\common\components\gui\Garant\Everest_Engine\eeDocument_Schema.pas'
  {$IfEnd} //Nemesis
  ,
  Runner in 'Runner.pas'
//#UC START# *4DE8C9A603C1manualuses*
  ,
  atOperationImpl
  ,
  JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
//#UC END# *4DE8C9A603C1manualuses*
  ;

//#UC START# *4DE8C9A603C1manualres*
//#UC END# *4DE8C9A603C1manualres*

begin
 //#UC START# *4DE8C9A603C1manualcode*
 TRunner.Run;
 //#UC END# *4DE8C9A603C1manualcode*
end.