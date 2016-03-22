program NemesisAppTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/NemesisAppTest.dpr"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMTestTarget::Category>> F1 Ежедневные тесты::Nemesis
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
uses
  ControlResizeBugFix,
  nsApplication,
  l3ExceptionsLog
  {$If not defined(NoScripts)}
  ,
  ObjectFromstackWords in 'w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas'
  {$IfEnd} //not NoScripts
  ,
  l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas',
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwScriptingExceptions in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas'
  {$IfEnd} //not NoScripts
  ,
  TypInfo {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas' {$EndIf},
  Types,
  Windows {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas' {$EndIf},
  ActiveX {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas' {$EndIf},
  Messages {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas' {$EndIf},
  Classes {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  Graphics {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas' {$EndIf},
  l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas',
  l3Types in 'w:\common\components\rtl\Garant\L3\l3Types.pas',
  l3PureMixIns in 'w:\common\components\rtl\Garant\L3\l3PureMixIns.pas',
  Refcounted in 'w:\common\components\rtl\Garant\L3\Refcounted.pas',
  l3MemorySizeUtilsPrim in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtilsPrim.pas',
  l3MemorySizeUtils in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtils.pas',
  l3Interlocked in 'w:\common\components\rtl\Garant\L3\l3Interlocked.pas',
  l3MemUtils in 'w:\common\components\rtl\Garant\L3\l3MemUtils.pas',
  l3CastableObject in 'w:\common\components\rtl\Garant\L3\l3CastableObject.pas',
  l3ProtoObject in 'w:\common\components\rtl\Garant\L3\l3ProtoObject.pas',
  l3ProtoDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas',
  l3Units in 'w:\common\components\rtl\Garant\L3\l3Units.pas'
  {$If not defined(NoScripts)}
  ,
  FontWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3PrinterInterfaces in 'w:\common\components\rtl\Garant\L3\l3PrinterInterfaces.pas',
  l3InternalInterfaces in 'w:\common\components\rtl\Garant\L3\l3InternalInterfaces.pas',
  l3IID in 'w:\common\components\rtl\Garant\L3\l3IID.pas',
  l3BaseStream in 'w:\common\components\rtl\Garant\L3\l3BaseStream.pas',
  l3InterfacesMisc in 'w:\common\components\rtl\Garant\L3\l3InterfacesMisc.pas',
  l3ProtoDataContainerWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainerWithCOMQI.pas',
  l3Memory in 'w:\common\components\rtl\Garant\L3\l3Memory.pas',
  l3Except in 'w:\common\components\rtl\Garant\L3\l3Except.pas',
  RTLConsts {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\RTLConsts.pas' {$EndIf},
  l3MinMax in 'w:\common\components\rtl\Garant\L3\l3MinMax.pas',
  l3Const in 'w:\common\components\rtl\Garant\L3\l3Const.pas',
  k2BaseTypes in 'w:\common\components\rtl\Garant\L3\k2BaseTypes.pas',
  l3CastablePersistent in 'w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas',
  l3DataContainerWithoutIUnknownPrim in 'w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknownPrim.pas',
  l3Variants in 'w:\common\components\rtl\Garant\L3\l3Variants.pas'
  {$If not defined(NoScripts)}
  ,
  kwFiltersAndGeneratorsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3ProtoObjectWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas',
  l3SimpleObject in 'w:\common\components\rtl\Garant\L3\l3SimpleObject.pas',
  l3_Base in 'w:\common\components\rtl\Garant\L3\l3_Base.pas',
  l3ProtoIntegerList in 'w:\common\components\rtl\Garant\L3\l3ProtoIntegerList.pas',
  k2PropertyArray in 'w:\common\components\rtl\Garant\K2\k2PropertyArray.pas',
  k2TypeTableCreatedListeners in 'w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas',
  l3String in 'w:\common\components\rtl\Garant\L3\l3String.pas',
  l3Chars in 'w:\common\components\rtl\Garant\L3\l3Chars.pas',
  k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas',
  k2Attributes in 'w:\common\components\rtl\Garant\K2\k2Attributes.pas',
  k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas',
  k2Empty_Const in 'w:\common\components\rtl\Garant\K2\k2Empty_Const.pas',
  k2Prim in 'w:\common\components\rtl\Garant\K2\k2Prim.pas',
  l3Date in 'w:\common\components\rtl\Garant\L3\l3Date.pas',
  k2Interfaces in 'w:\common\components\rtl\Garant\K2\k2Interfaces.pas',
  k2Long_Const in 'w:\common\components\rtl\Garant\K2\k2Long_Const.pas',
  l3Stream in 'w:\common\components\rtl\Garant\L3\l3Stream.pas',
  k2Object_Const in 'w:\common\components\rtl\Garant\K2\k2Object_Const.pas',
  k2SomeDataContainer_Const in 'w:\common\components\rtl\Garant\K2\k2SomeDataContainer_Const.pas',
  k2l3Base_Const in 'w:\common\components\rtl\Garant\K2\k2l3Base_Const.pas',
  k2Enum_Const in 'w:\common\components\rtl\Garant\K2\k2Enum_Const.pas',
  k2SortTagsListPrim in 'w:\common\components\rtl\Garant\K2\k2SortTagsListPrim.pas',
  k2SortTagsList in 'w:\common\components\rtl\Garant\K2\k2SortTagsList.pas',
  k2TypeModelPart in 'w:\common\components\rtl\Garant\K2\k2TypeModelPart.pas',
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
  l3BMSearch in 'w:\common\components\rtl\Garant\L3\l3BMSearch.pas',
  l3StringEx in 'w:\common\components\rtl\Garant\L3\l3StringEx.pas',
  l3StringAdapter in 'w:\common\components\rtl\Garant\L3\l3StringAdapter.pas',
  l3CustomString in 'w:\common\components\rtl\Garant\L3\l3CustomString.pas',
  l3_String in 'w:\common\components\rtl\Garant\L3\l3_String.pas',
  k2NonAtomicTag in 'w:\common\components\rtl\Garant\K2\k2NonAtomicTag.pas',
  k2ListTag in 'w:\common\components\rtl\Garant\K2\k2ListTag.pas',
  k2TagListPrim in 'w:\common\components\rtl\Garant\K2\k2TagListPrim.pas',
  k2TagList in 'w:\common\components\rtl\Garant\K2\k2TagList.pas',
  k2BaseStruct in 'w:\common\components\rtl\Garant\K2\k2BaseStruct.pas',
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
  l3SimpleDataContainer in 'w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas',
  l3BaseWithID in 'w:\common\components\rtl\Garant\L3\l3BaseWithID.pas',
  l3BaseWithIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDListPrim.pas',
  l3BaseWithIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDList.pas',
  l3ValueMap in 'w:\common\components\rtl\Garant\L3\l3ValueMap.pas',
  l3ValueMapManagerPrim in 'w:\common\components\rtl\Garant\L3\l3ValueMapManagerPrim.pas',
  l3ValueMapManager in 'w:\common\components\rtl\Garant\L3\l3ValueMapManager.pas',
  l3IntegerValueMapManager in 'w:\common\components\rtl\Garant\L3\l3IntegerValueMapManager.pas'
  {$If not defined(NoVCL)}
  ,
  Dialogs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
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
  k2VariantImpl in 'w:\common\components\rtl\Garant\K2\k2VariantImpl.pas',
  k2CustomStackGeneratorEx in 'w:\common\components\rtl\Garant\K2\k2CustomStackGeneratorEx.pas',
  k2CustomFileGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomFileGenerator.pas',
  k2EVDWriterService in 'w:\common\components\rtl\Garant\K2\k2EVDWriterService.pas',
  k2TagGen in 'w:\common\components\rtl\Garant\K2\k2TagGen.pas',
  k2BaseStackGenerator in 'w:\common\components\rtl\Garant\K2\k2BaseStackGenerator.pas',
  k2CustomStackGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomStackGenerator.pas',
  k2CustomReader in 'w:\common\components\rtl\Garant\K2\k2CustomReader.pas',
  k2CustomFileReader in 'w:\common\components\rtl\Garant\K2\k2CustomFileReader.pas',
  k2EVDReaderService in 'w:\common\components\rtl\Garant\K2\k2EVDReaderService.pas',
  l3Variant in 'w:\common\components\rtl\Garant\L3\l3Variant.pas'
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
  tfwKeyWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeyWordPrim.pas',
  StrUtils {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas' {$EndIf},
  l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas',
  l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas',
  tfwCStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringListPrim.pas',
  tfwCStringList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringList.pas',
  tfwCStringArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas',
  tfwCStringArraySing in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas',
  tfwCStringArraySing2 in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas',
  tfwCStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringFactory.pas'
  {$If not defined(NoScripts)}
  ,
  tfwClassRef in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassRef.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ItfwParserWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordRefList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSourcePointWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSourcePointWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrimPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwClassLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassLike.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwPropertyLike.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ItfwKeywordFinderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ItfwParserExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  tfwParserInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas',
  tfwStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStreamFactory.pas'
  {$If not defined(NoScripts)}
  ,
  kwModifier in 'w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTypeModifier in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeModifier.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRTTIProperty in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTIProperty.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ArrayProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ArrayProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  Math {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  tfwDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionary.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIteratableParent in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwMembersIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIteratorPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwMembersIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryExPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryPtrList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInitedDictionariesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwForwardDeclarationHolder in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclarationHolder.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStandardDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionary.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStandardDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStandardDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStandardDictionaries in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaries.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIl3CStringPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwAutoregisteredDiction in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAutoregisteredDiction.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInitCodeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitCodeWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryEx.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryDataIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryDataIteratorPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryPtrListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrListIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwExportedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwExportedDictionariesIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwUsedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwUsedDictionariesIterator.pas'
  {$IfEnd} //not NoScripts
  ,
  l3DateSt in 'w:\common\components\rtl\Garant\L3\l3DateSt.pas'
  {$If not defined(NoScripts)}
  ,
  tfwMainDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryList.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(seCacheDict) AND not defined(NoScripts)}
  ,
  tfwMainDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryCache.pas'
  {$IfEnd} //seCacheDict AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryCachePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCachePrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(seCacheDict) AND not defined(NoScripts)}
  ,
  tfwDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCache.pas'
  {$IfEnd} //seCacheDict AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwKeywordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeywordsIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwMainDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionary.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwMainDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineExInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineExInterfaces.pas'
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
  tfwStoredValues in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingTypes.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingInterfaces.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwLeftParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwLeftParam.pas'
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
  kwForwardDeclaration in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclaration.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  KeyWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyWordPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3ParserInterfaces in 'w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas'
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
  kwBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginLikeCompiledCode.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwBeginLikeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwBeginLikeWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwCloseBracket.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwAxiomaticsResNameGetterList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetterList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwAxiomaticsResNameGetters in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwAxiomaticsResNameGetter in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetter.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArrayView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRevertedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRevertedArrayView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwLambdedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwLambdedArrayView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwFilteredArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFilteredArrayView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwMappedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMappedArrayView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIteratorFromFunctor in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratorFromFunctor.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwJoinIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwJoinIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTruncatedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTruncatedArrayView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwSliceView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSliceView.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  BasicsPack in 'w:\common\components\rtl\Garant\ScriptEngine\BasicsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3MessagesService in 'w:\common\components\rtl\Garant\L3\l3MessagesService.pas'
  {$If not defined(NoScripts)}
  ,
  tfwEnumRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRTTITypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTITypeInfoList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRegisteredEnums in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisteredEnums.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStringToEnumValue in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringToEnumValue.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIntegerToEnumName in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerToEnumName.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwString.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStringConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringConstantRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInterfaceRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInterfaceRegistrator.pas'
  {$IfEnd} //not NoScripts
  ,
  l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas'
  {$If not defined(NoScripts)}
  ,
  kwValue in 'w:\common\components\rtl\Garant\ScriptEngine\kwValue.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwWordPtrWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrWorker.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwWordPtrPushWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrPushWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  FileProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FileProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3InterfacedComponent in 'w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas',
  l3ProgressComponent in 'w:\common\components\rtl\Garant\L3\l3ProgressComponent.pas',
  l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas',
  l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas',
  l3CProtoObject in 'w:\common\components\rtl\Garant\L3\l3CProtoObject.pas'
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
  kwCompiledWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerEx.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorkerEx.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwGlobalKeyWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwGlobalKeyWord.pas'
  {$IfEnd} //not NoScripts
  ,
  l3FileUtils in 'w:\common\components\rtl\Garant\L3\l3FileUtils.pas'
  {$If not defined(NoScripts)}
  ,
  SysUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SysUtilsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3TabService in 'w:\common\components\rtl\Garant\L3\l3TabService.pas',
  l3SysUtils in 'w:\common\components\rtl\Garant\L3\l3SysUtils.pas',
  JclSysInfo {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\source\common\JclSysInfo.pas' {$EndIf},
  DateUtils {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\DateUtils.pas' {$EndIf}
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ContainedActionsWordspack in 'w:\common\components\rtl\Garant\ScriptEngine\ContainedActionsWordspack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ActionListWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ActionListWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ActnList {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ActnList.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  WinControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinControlsProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ScrollingWinControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollingWinControlWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ScrollInfoProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollInfoProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  kwObjectFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwObjectFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwComponentFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWinControlFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWinControlFromStackWord.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwScrollInfoWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwScrollInfoWord.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwPopControlScrollInfo in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfo.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwPopControlScrollInfoMin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMin.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwPopControlScrollInfoMax in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMax.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwPopControlScrollInfoPageSize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPageSize.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwPopControlScrollInfoPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPosition.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ControlsProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  FormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  l3ObjectList in 'w:\common\components\rtl\Garant\L3\l3ObjectList.pas'
  {$If not defined(NoVCL)}
  ,
  Menus {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Menus.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  MenuWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\MenuWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  l3ScreenService in 'w:\common\components\rtl\Garant\L3\l3ScreenService.pas'
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  CustomFormProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CustomFormProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3CloseFormHelper in 'w:\common\components\rtl\Garant\L3\l3CloseFormHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3FormsService in 'w:\common\components\rtl\Garant\L3\l3FormsService.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwControlWord.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush in 'w:\common\components\rtl\Garant\ScriptEngine\kwBynameControlPush.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3PopupMenuHelper in 'w:\common\components\rtl\Garant\L3\l3PopupMenuHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3ControlFontService in 'w:\common\components\rtl\Garant\L3\l3ControlFontService.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Controls.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Forms.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Clipbrd {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Clipbrd.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  l3Utils in 'w:\common\components\rtl\Garant\L3\l3Utils.pas',
  l3ProtoPersistentDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas',
  l3StringListPrim in 'w:\common\components\rtl\Garant\L3\l3StringListPrim.pas',
  l3StringList1 in 'w:\common\components\rtl\Garant\L3\l3StringList1.pas',
  l3StringList2 in 'w:\common\components\rtl\Garant\L3\l3StringList2.pas',
  l3StringList in 'w:\common\components\rtl\Garant\L3\l3StringList.pas',
  l3LongintListPrim in 'w:\common\components\rtl\Garant\L3\l3LongintListPrim.pas',
  l3LongintList in 'w:\common\components\rtl\Garant\L3\l3LongintList.pas',
  l3DataObjectEnum in 'w:\common\components\rtl\Garant\L3\l3DataObjectEnum.pas',
  ShlObj {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShlObj.pas' {$EndIf},
  l3DataObject in 'w:\common\components\rtl\Garant\L3\l3DataObject.pas',
  l3StorableDataObject in 'w:\common\components\rtl\Garant\L3\l3StorableDataObject.pas',
  l3CStringDataObject in 'w:\common\components\rtl\Garant\L3\l3CStringDataObject.pas'
  {$If not defined(NoScripts)}
  ,
  WordsRTTIPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsRTTIPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  seWordsInfo in 'w:\common\components\rtl\Garant\ScriptEngine\seWordsInfo.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordsIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwCodeIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCodeIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordContainer.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDualCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwDualCompiledWordContainer.pas'
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
  tfwEnumConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumConstantRegistrator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TypeInfoPack in 'w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwStandardDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInitedDictionariesListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesListIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  VarWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VarWorkingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTypeInfo in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfo.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTypeInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwTypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueTypesListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueTypesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueTypesCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesCache.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypes.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueTypesWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordInfoWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ItfwScriptEngineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwScriptEngineWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordInfoCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoCache.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwWordInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  NewWordDefinitorPack in 'w:\common\components\rtl\Garant\ScriptEngine\NewWordDefinitorPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ItfwCompilerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWordPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopClassInherits in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopClassInherits.pas'
  {$IfEnd} //not NoScripts
  ,
  l3RTTI in 'w:\common\components\rtl\Garant\L3\l3RTTI.pas',
  l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas',
  l3ObjectRefList1 in 'w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas',
  SyncObjs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\SyncObjs.pas' {$EndIf},
  l3SimpleMemoryManagerPrim in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManagerPrim.pas',
  l3SimpleMemoryManager in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManager.pas',
  l3ObjectsMemoryManager in 'w:\common\components\rtl\Garant\L3\l3ObjectsMemoryManager.pas',
  l3TwoByteCString in 'w:\common\components\rtl\Garant\L3\l3TwoByteCString.pas',
  l3OneByteCString in 'w:\common\components\rtl\Garant\L3\l3OneByteCString.pas',
  l3CEmptyStringPrim in 'w:\common\components\rtl\Garant\L3\l3CEmptyStringPrim.pas',
  l3CEmptyString in 'w:\common\components\rtl\Garant\L3\l3CEmptyString.pas',
  l3FourByteCString in 'w:\common\components\rtl\Garant\L3\l3FourByteCString.pas',
  l3Base in 'w:\common\components\rtl\Garant\L3\l3Base.pas'
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ITestWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\ITestWordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  ,
  TestFrameWork in 'w:\common\components\rtl\external\DUnit\src\TestFrameWork.pas',
  TextTestRunner in 'w:\common\components\rtl\external\DUnit\src\TextTestRunner.pas'
  {$If not defined(NoScripts)}
  ,
  l3NodesKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\l3NodesKeyWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas',
  afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas'
  {$If not defined(NoVCL)}
  ,
  ImgList {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas'
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces in 'w:\common\components\gui\Garant\VCM\vcmExternalInterfaces.pas'
  {$IfEnd} //not NoVCM
  ,
  l3CastableStrings in 'w:\common\components\rtl\Garant\L3\l3CastableStrings.pas',
  l3VCLStringsItems in 'w:\common\components\rtl\Garant\L3\l3VCLStringsItems.pas',
  l3VCLStrings in 'w:\common\components\rtl\Garant\L3\l3VCLStrings.pas',
  ctTypes in 'w:\common\components\gui\Garant\VT\ComboTree\ctTypes.pas',
  l3ControlsTypes in 'w:\common\components\rtl\Garant\L3\l3ControlsTypes.pas',
  evdStyles in 'w:\common\components\rtl\Garant\EVD\evdStyles.pas'
  {$If not defined(NoScripts)}
  ,
  InterfacedNodeWords in 'w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas'
  {$IfEnd} //not NoScripts
  ,
  l3Tree_TLB in 'w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas',
  evdTypes in 'w:\common\components\rtl\Garant\EVD\evdTypes.pas',
  evdInterfaces in 'w:\common\components\rtl\Garant\EVD\evdInterfaces.pas',
  evResultFont in 'w:\common\components\gui\Garant\Everest\evResultFont.pas',
  evResultFontInterfaces in 'w:\common\components\gui\Garant\Everest\evResultFontInterfaces.pas',
  nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas'
  {$If not defined(NoScripts)}
  ,
  evParaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas',
  evTypes in 'w:\common\components\gui\Garant\Everest\evTypes.pas',
  nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas',
  l3Defaults in 'w:\common\components\rtl\Garant\L3\l3Defaults.pas',
  evDef in 'w:\common\components\gui\Garant\Everest\evDef.pas',
  evCustomTextSource in 'w:\common\components\gui\Garant\Everest\evCustomTextSource.pas',
  evExcept in 'w:\common\components\gui\Garant\Everest\evExcept.pas',
  nevBasePointList in 'w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas',
  l3Region in 'w:\common\components\rtl\Garant\L3\l3Region.pas',
  l3RectList in 'w:\common\components\rtl\Garant\L3\l3RectList.pas',
  l3ScreenIC in 'w:\common\components\rtl\Garant\L3\l3ScreenIC.pas',
  l3CanvasUtils in 'w:\common\components\rtl\Garant\L3\l3CanvasUtils.pas',
  l3FontTools in 'w:\common\components\rtl\Garant\L3\l3FontTools.pas',
  l3FormattedLines in 'w:\common\components\rtl\Garant\L3\l3FormattedLines.pas',
  l3LineArray in 'w:\common\components\rtl\Garant\L3\l3LineArray.pas',
  l3VirtualCanvas in 'w:\common\components\rtl\Garant\L3\l3VirtualCanvas.pas'
  {$If defined(l3Requires_m0)}
  ,
  m2XLtLib in 'w:\common\components\rtl\Garant\L3\m2\m2XLtLib.pas'
  {$IfEnd} //l3Requires_m0
  ,
  l3UnitsTools in 'w:\common\components\rtl\Garant\L3\l3UnitsTools.pas',
  l3FrameLine in 'w:\common\components\rtl\Garant\L3\l3FrameLine.pas',
  l3FrameLineList in 'w:\common\components\rtl\Garant\L3\l3FrameLineList.pas',
  l3InterfacedIntegerList in 'w:\common\components\rtl\Garant\L3\l3InterfacedIntegerList.pas',
  l3CoordinateMap in 'w:\common\components\rtl\Garant\L3\l3CoordinateMap.pas',
  l3FrameObject in 'w:\common\components\rtl\Garant\L3\l3FrameObject.pas',
  l3FrameObjectList in 'w:\common\components\rtl\Garant\L3\l3FrameObjectList.pas',
  l3FrameLinesSpy in 'w:\common\components\rtl\Garant\L3\l3FrameLinesSpy.pas',
  l3FrameLines in 'w:\common\components\rtl\Garant\L3\l3FrameLines.pas',
  l3CanvasPrim in 'w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas',
  l3Canvas in 'w:\common\components\rtl\Garant\L3\l3Canvas.pas',
  l3Bitmap in 'w:\common\components\rtl\Garant\L3\l3Bitmap.pas',
  afwCustomCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCaretType.pas',
  afwSingleCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwSingleCaret.pas',
  afwInsCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInsCaretType.pas',
  afwOvrCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwOvrCaretType.pas',
  afwCaretPair in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaretPair.pas',
  afwCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaret.pas',
  evMsgCode in 'w:\common\components\gui\Garant\Everest\evMsgCode.pas',
  evOp in 'w:\common\components\gui\Garant\Everest\evOp.pas',
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
  HyTechProviderParams_Const in 'w:\common\components\rtl\Garant\EVD\HyTechProviderParams_Const.pas',
  evdNcsTypes in 'w:\common\components\rtl\Garant\EVD\evdNcsTypes.pas',
  csMessage_Const in 'w:\common\components\rtl\Garant\EVD\csMessage_Const.pas',
  TaskID_Const in 'w:\common\components\rtl\Garant\EVD\TaskID_Const.pas',
  csReply_Const in 'w:\common\components\rtl\Garant\EVD\csReply_Const.pas',
  csMessageWithReply_Const in 'w:\common\components\rtl\Garant\EVD\csMessageWithReply_Const.pas',
  csGetTaskDescription_Const in 'w:\common\components\rtl\Garant\EVD\csGetTaskDescription_Const.pas',
  FileDesc_Const in 'w:\common\components\rtl\Garant\EVD\FileDesc_Const.pas',
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
  mdpSyncDicts_Const in 'w:\common\components\rtl\Garant\EVD\mdpSyncDicts_Const.pas',
  mdpImportDocs_Const in 'w:\common\components\rtl\Garant\EVD\mdpImportDocs_Const.pas',
  ComboAccessProviderParams_Const in 'w:\common\components\rtl\Garant\EVD\ComboAccessProviderParams_Const.pas',
  evdTasks_Schema in 'w:\common\components\rtl\Garant\EVD\evdTasks_Schema.pas',
  ddTaskItemPrim in 'w:\common\components\rtl\Garant\EVD\ddTaskItemPrim.pas',
  evdCustomNativeWriterServices in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriterServices.pas',
  evdCustomNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriter.pas',
  evdNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeWriter.pas',
  k2CustomFileParser in 'w:\common\components\rtl\Garant\K2\k2CustomFileParser.pas',
  evdNativeReaderServices in 'w:\common\components\rtl\Garant\EVD\evdNativeReaderServices.pas',
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
  SegmentWithChildren_Const in 'w:\common\components\rtl\Garant\EVD\SegmentWithChildren_Const.pas',
  evFont_Wrap in 'w:\common\components\rtl\Garant\EVD\evFont_Wrap.pas',
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
  SectionBreak_Const in 'w:\common\components\rtl\Garant\EVD\SectionBreak_Const.pas',
  evStyle in 'w:\common\components\rtl\Garant\EVD\evStyle.pas',
  k2DictItem in 'w:\common\components\rtl\Garant\K2\k2DictItem.pas',
  k2Layer in 'w:\common\components\rtl\Garant\K2\k2Layer.pas',
  SegmentsLayer_Const in 'w:\common\components\rtl\Garant\EVD\SegmentsLayer_Const.pas',
  Bullet_Const in 'w:\common\components\rtl\Garant\EVD\Bullet_Const.pas',
  Bookmark_Const in 'w:\common\components\rtl\Garant\EVD\Bookmark_Const.pas',
  Mark_Const in 'w:\common\components\rtl\Garant\EVD\Mark_Const.pas',
  DocSubLayer_Const in 'w:\common\components\rtl\Garant\EVD\DocSubLayer_Const.pas',
  ActiveInterval_Const in 'w:\common\components\rtl\Garant\EVD\ActiveInterval_Const.pas',
  Alarm_Const in 'w:\common\components\rtl\Garant\EVD\Alarm_Const.pas',
  LogRecord_Const in 'w:\common\components\rtl\Garant\EVD\LogRecord_Const.pas',
  Stage_Const in 'w:\common\components\rtl\Garant\EVD\Stage_Const.pas',
  NumANDDate_Const in 'w:\common\components\rtl\Garant\EVD\NumANDDate_Const.pas',
  Check_Const in 'w:\common\components\rtl\Garant\EVD\Check_Const.pas',
  PIRec_Const in 'w:\common\components\rtl\Garant\EVD\PIRec_Const.pas',
  TabStop_Const in 'w:\common\components\rtl\Garant\EVD\TabStop_Const.pas',
  ObjectSegment_Const in 'w:\common\components\rtl\Garant\EVD\ObjectSegment_Const.pas',
  HyperLink_Const in 'w:\common\components\rtl\Garant\EVD\HyperLink_Const.pas',
  evdNative_AttrValues in 'w:\common\components\rtl\Garant\EVD\evdNative_AttrValues.pas',
  evdNative_Schema in 'w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas',
  ObjectWithHandle_Const in 'w:\common\components\rtl\Garant\EVD\ObjectWithHandle_Const.pas',
  evdFrame_Const in 'w:\common\components\rtl\Garant\EVD\evdFrame_Const.pas',
  Para_Const in 'w:\common\components\rtl\Garant\EVD\Para_Const.pas',
  LeafPara_Const in 'w:\common\components\rtl\Garant\EVD\LeafPara_Const.pas',
  evInternalInterfaces in 'w:\common\components\gui\Garant\Everest\evInternalInterfaces.pas',
  evSearch in 'w:\common\components\gui\Garant\Everest\evSearch.pas',
  nevConfirm in 'w:\common\components\gui\Garant\Everest\new\nevConfirm.pas',
  k2PureMixIns in 'w:\common\components\rtl\Garant\K2\k2PureMixIns.pas'
  {$If not defined(NoScripts)}
  ,
  IedTableWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  IedRangeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedRangeWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  evEditorInterfaces in 'w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas',
  k2TagTool in 'w:\common\components\rtl\Garant\K2\k2TagTool.pas',
  k2ProcessorTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcessorTagTool.pas',
  nevFacade in 'w:\common\components\gui\Garant\Everest\new\nevFacade.pas'
  {$If defined(k2ForEditor)}
  ,
  evCursorTools in 'w:\common\components\gui\Garant\Everest\evCursorTools.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
  ,
  evCustomParaListUtils in 'w:\common\components\gui\Garant\Everest\evCustomParaListUtils.pas'
  {$IfEnd} //evNeedEditableCursors AND k2ForEditor
  
  {$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
  ,
  evParaUtilClasses in 'w:\common\components\gui\Garant\Everest\evParaUtilClasses.pas'
  {$IfEnd} //evNeedEditableCursors AND k2ForEditor
  ,
  l3NCString in 'w:\common\components\rtl\Garant\L3\l3NCString.pas',
  l3InterfacedString in 'w:\common\components\rtl\Garant\L3\l3InterfacedString.pas',
  evQueryCardInt in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardInt.pas',
  ControlPara_Const in 'w:\common\components\gui\Garant\Everest\ControlPara_Const.pas',
  HFParent_Const in 'w:\common\components\gui\Garant\Everest\HFParent_Const.pas',
  Header_Const in 'w:\common\components\gui\Garant\Everest\Header_Const.pas',
  Footer_Const in 'w:\common\components\gui\Garant\Everest\Footer_Const.pas',
  ContentsElement_Const in 'w:\common\components\gui\Garant\Everest\ContentsElement_Const.pas',
  evConst in 'w:\common\components\gui\Garant\Everest\evConst.pas',
  Participant_Const in 'w:\common\components\gui\Garant\Everest\Participant_Const.pas',
  Version_Const in 'w:\common\components\gui\Garant\Everest\Version_Const.pas',
  EditablePart_Const in 'w:\common\components\gui\Garant\Everest\EditablePart_Const.pas',
  Document_Const in 'w:\common\components\gui\Garant\Everest\Document_Const.pas'
  {$If defined(k2ForEditor)}
  ,
  evDocumentPart in 'w:\common\components\gui\Garant\Everest\evDocumentPart.pas'
  {$IfEnd} //k2ForEditor
  ,
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
  SimpleDocument_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocument_Const.pas',
  DictEntryBlock_Const in 'w:\common\components\gui\Garant\Everest\DictEntryBlock_Const.pas',
  SBSCell_Const in 'w:\common\components\gui\Garant\Everest\SBSCell_Const.pas',
  TableRow_Const in 'w:\common\components\gui\Garant\Everest\TableRow_Const.pas',
  SBSRow_Const in 'w:\common\components\gui\Garant\Everest\SBSRow_Const.pas',
  Table_Const in 'w:\common\components\gui\Garant\Everest\Table_Const.pas',
  QueryCard_Const in 'w:\common\components\gui\Garant\Everest\QueryCard_Const.pas',
  ReqCell_Const in 'w:\common\components\gui\Garant\Everest\ReqCell_Const.pas',
  ReqRow_Const in 'w:\common\components\gui\Garant\Everest\ReqRow_Const.pas',
  evControlsBlockConst in 'w:\common\components\gui\Garant\Everest\evControlsBlockConst.pas',
  ControlsBlock_Const in 'w:\common\components\gui\Garant\Everest\ControlsBlock_Const.pas',
  XMLTag_Const in 'w:\common\components\gui\Garant\Everest\XMLTag_Const.pas',
  AttrName_Const in 'w:\common\components\gui\Garant\Everest\AttrName_Const.pas',
  TableTextPara_Const in 'w:\common\components\gui\Garant\Everest\TableTextPara_Const.pas',
  evTextPara_Wrap in 'w:\common\components\gui\Garant\Everest\evTextPara_Wrap.pas',
  evControlParaConst in 'w:\common\components\gui\Garant\Everest\evControlParaConst.pas',
  ReqGroup_Const in 'w:\common\components\gui\Garant\Everest\ReqGroup_Const.pas'
  {$If defined(k2ForEditor)}
  ,
  evControlPara_Wrap in 'w:\common\components\gui\Garant\Everest\evControlPara_Wrap.pas'
  {$IfEnd} //k2ForEditor
  ,
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
  evParaInterfaceFactoryPrim in 'w:\common\components\gui\Garant\Everest\evParaInterfaceFactoryPrim.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evSelection in 'w:\common\components\gui\Garant\Everest\evSelection.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evDocumentPreviewInfoList in 'w:\common\components\gui\Garant\Everest\new\evDocumentPreviewInfoList.pas',
  nevWaiterList in 'w:\common\components\gui\Garant\Everest\new\nevWaiterList.pas',
  nevInternalInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInternalInterfaces.pas',
  k2InternalInterfaces in 'w:\common\components\rtl\Garant\K2\k2InternalInterfaces.pas',
  l3NotifyPtrList in 'w:\common\components\rtl\Garant\L3\l3NotifyPtrList.pas',
  l3InterfacePtrList in 'w:\common\components\rtl\Garant\L3\l3InterfacePtrList.pas',
  l3KeyboardLayoutService in 'w:\common\components\rtl\Garant\L3\l3KeyboardLayoutService.pas',
  afwSettingsImplPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrimPrim.pas',
  afwSettingsImplPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrim.pas',
  afwSettingsImpl in 'w:\common\components\gui\Garant\AFW\afwSettingsImpl.pas',
  afwSettingsImplPersistent in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPersistent.pas',
  afwSettingsImplSing in 'w:\common\components\gui\Garant\AFW\afwSettingsImplSing.pas',
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
  evStylesPrintAndExportFontSizeSettingRes in 'w:\common\components\gui\Garant\Everest\evStylesPrintAndExportFontSizeSettingRes.pas',
  evStyles_SH in 'w:\common\components\gui\Garant\Everest\evStyles_SH.pas',
  evFontInterface in 'w:\common\components\gui\Garant\Everest\evFontInterface.pas',
  l3Nodes in 'w:\common\components\rtl\Garant\L3\l3Nodes.pas',
  k2SimpleTagList in 'w:\common\components\rtl\Garant\K2\k2SimpleTagList.pas',
  evStyleInterface in 'w:\common\components\gui\Garant\Everest\evStyleInterface.pas'
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy in 'w:\common\components\gui\Garant\Everest\evStyleTableSpy.pas'
  {$IfEnd} //not DesignTimeLibrary
  ,
  nevFormatPoolBase in 'w:\common\components\gui\Garant\Everest\new\nevFormatPoolBase.pas',
  SBS_Const in 'w:\common\components\gui\Garant\Everest\SBS_Const.pas',
  nevTableCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas',
  evSectionPara in 'w:\common\components\gui\Garant\Everest\new\evSectionPara.pas'
  {$If defined(k2ForEditor)}
  ,
  evTableCellUtils in 'w:\common\components\gui\Garant\Everest\evTableCellUtils.pas'
  {$IfEnd} //k2ForEditor
  ,
  nevTableRowRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas',
  nevRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevRubberCellsRenderInfo.pas',
  nevFormatInfoList in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoList.pas',
  nevParaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevParaFormatInfo.pas',
  nevLeafRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevLeafRenderInfo.pas'
  {$If defined(k2ForEditor)}
  ,
  evSegLst in 'w:\common\components\gui\Garant\Everest\evSegLst.pas'
  {$IfEnd} //k2ForEditor
  ,
  evTextParaConst in 'w:\common\components\gui\Garant\Everest\evTextParaConst.pas',
  nevSegmentObject in 'w:\common\components\gui\Garant\Everest\nevSegmentObject.pas',
  l3SingleLineInfo in 'w:\common\components\rtl\Garant\L3\l3SingleLineInfo.pas',
  k2InterfacesEx in 'w:\common\components\rtl\Garant\K2\k2InterfacesEx.pas',
  evSegOp in 'w:\common\components\gui\Garant\Everest\evSegOp.pas'
  {$If defined(k2ForEditor)}
  ,
  evAlignBySeparatorUtils in 'w:\common\components\gui\Garant\Everest\evAlignBySeparatorUtils.pas'
  {$IfEnd} //k2ForEditor
  ,
  evParaString in 'w:\common\components\gui\Garant\Everest\evParaString.pas',
  nevStringCache in 'w:\common\components\gui\Garant\Everest\nevStringCache.pas',
  k2InterfacedTagList in 'w:\common\components\rtl\Garant\K2\k2InterfacedTagList.pas'
  {$If defined(k2ForEditor)}
  ,
  evChangeCodePage in 'w:\common\components\gui\Garant\Everest\evChangeCodePage.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTextParaTools in 'w:\common\components\gui\Garant\Everest\evTextParaTools.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evAACContentUtils in 'w:\common\components\gui\Garant\Everest\evAACContentUtils.pas'
  {$IfEnd} //k2ForEditor
  ,
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
  Cloak_Const in 'w:\common\components\gui\Garant\Everest\Cloak_Const.pas',
  evResultFontHolder in 'w:\common\components\gui\Garant\Everest\evResultFontHolder.pas',
  nevSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSegmentFormatInfo.pas',
  evCustomFont in 'w:\common\components\gui\Garant\Everest\evCustomFont.pas',
  evGlyphFont in 'w:\common\components\gui\Garant\Everest\evGlyphFont.pas',
  nevObjectSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevObjectSegmentFormatInfo.pas',
  nevSBSCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSCellFormatInfo.pas',
  nevSBSRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSRowFormatInfo.pas',
  nevTableRowRenderInfoEx in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfoEx.pas',
  nevReqRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevReqRowFormatInfo.pas',
  nevPageBreakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevPageBreakFormatInfo.pas',
  nevNodeGroupFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevNodeGroupFormatInfo.pas',
  NodeGroup_Const in 'w:\common\components\gui\Garant\Everest\NodeGroup_Const.pas',
  nevFormatInfoFactory in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoFactory.pas',
  evStandardStylesListPrim in 'w:\common\components\gui\Garant\Everest\evStandardStylesListPrim.pas',
  evStandardStylesList in 'w:\common\components\gui\Garant\Everest\evStandardStylesList.pas',
  evDefaultStylesFontSizesPrim in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim.pas',
  evDefaultStylesFontSizesPrim1 in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim1.pas',
  evDefaultStylesFontSizes in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizes.pas',
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
  DocumentContainer_Const in 'w:\common\components\gui\Garant\Everest\DocumentContainer_Const.pas',
  nevDocumentContainerPrimPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrimPrim.pas',
  nevDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrim.pas',
  nevObjectHolderPrim in 'w:\common\components\gui\Garant\Everest\nevObjectHolderPrim.pas',
  nevInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInterfaces.pas',
  l3DocumentsCacheService in 'w:\common\components\rtl\Garant\L3\l3DocumentsCacheService.pas',
  evDocumentsCachePrim in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCachePrim.pas',
  nevDocumentContainerListPrim in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerListPrim.pas',
  nevDocumentContainerList in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerList.pas',
  evDocumentsCache in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCache.pas',
  nevTextSourcePool in 'w:\common\components\gui\Garant\Everest\new\nevTextSourcePool.pas',
  afwPreviewNotifierPtrList in 'w:\common\components\gui\Garant\AFW\implementation\afwPreviewNotifierPtrList.pas',
  afwComplexDocumentPreview in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreview.pas',
  afwComplexDocumentPreviewFactory in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreviewFactory.pas',
  k2ProcTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcTagTool.pas',
  evSubImplementation in 'w:\common\components\gui\Garant\Everest\new\evSubImplementation.pas',
  l3DatLst in 'w:\common\components\rtl\Garant\L3\l3DatLst.pas',
  l3Bits in 'w:\common\components\rtl\Garant\L3\l3Bits.pas',
  l3NodesModelPart in 'w:\common\components\rtl\Garant\L3\l3NodesModelPart.pas',
  evNode in 'w:\common\components\gui\Garant\Everest\new\evNode.pas',
  evSubNode in 'w:\common\components\gui\Garant\Everest\new\evSubNode.pas',
  LeafParaDecorationsHolder_Const in 'w:\common\components\gui\Garant\Everest\LeafParaDecorationsHolder_Const.pas',
  nevDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainer.pas',
  evOpProc in 'w:\common\components\gui\Garant\Everest\evOpProc.pas',
  evDefaultContext in 'w:\common\components\gui\Garant\Everest\evDefaultContext.pas',
  evDocumentContainerWithProcessor in 'w:\common\components\gui\Garant\Everest\new\evDocumentContainerWithProcessor.pas',
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
  evMergedCellFilter in 'w:\common\components\gui\Garant\Everest\evMergedCellFilter.pas',
  ShellAPI {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShellAPI.pas' {$EndIf},
  evStyleTableTools in 'w:\common\components\gui\Garant\Everest\evStyleTableTools.pas',
  afwFont in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwFont.pas',
  evCustomWikiReader in 'w:\common\components\gui\Garant\Everest\evCustomWikiReader.pas',
  evdLeafParaFilter in 'w:\common\components\rtl\Garant\EVD\evdLeafParaFilter.pas',
  evStyleHeaderAdder in 'w:\common\components\gui\Garant\Everest\evStyleHeaderAdder.pas',
  evdNativeUnpackedWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeUnpackedWriter.pas',
  nevPersistentDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPersistentDocumentContainer.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evLocationBase in 'w:\common\components\gui\Garant\Everest\evLocationBase.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evLocation in 'w:\common\components\gui\Garant\Everest\evLocation.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  evSelectConst in 'w:\common\components\gui\Garant\Everest\evSelectConst.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  nevRangePrim in 'w:\common\components\gui\Garant\Everest\nevRangePrim.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evCursor in 'w:\common\components\gui\Garant\Everest\evCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  nevRealTools in 'w:\common\components\gui\Garant\Everest\new\nevRealTools.pas'
  {$If defined(k2ForEditor)}
  ,
  evPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevPara in 'w:\common\components\gui\Garant\Everest\new\nevPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTabStops in 'w:\common\components\gui\Garant\Everest\new\evTabStops.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevParaPrim in 'w:\common\components\gui\Garant\Everest\new\nevParaPrim.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evCursorPair in 'w:\common\components\gui\Garant\Everest\evCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaCursor in 'w:\common\components\gui\Garant\Everest\evParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
  ,
  evDeadCursor in 'w:\common\components\gui\Garant\Everest\evDeadCursor.pas'
  {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4AnchorMapper in 'w:\common\components\gui\Garant\Everest\evInevBaseLine4AnchorMapper.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  k2InterfaceMapper in 'w:\common\components\rtl\Garant\K2\k2InterfaceMapper.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4PrintMapper in 'w:\common\components\gui\Garant\Everest\evInevBaseLine4PrintMapper.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evIevAnchorIndexMapper in 'w:\common\components\gui\Garant\Everest\new\evIevAnchorIndexMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evInevDrawingShapeMapper in 'w:\common\components\gui\Garant\Everest\evInevDrawingShapeMapper.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(k2ForEditor)}
  ,
  evInevParaMapper in 'w:\common\components\gui\Garant\Everest\new\evInevParaMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evLeafPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evLeafPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevLeafPara in 'w:\common\components\gui\Garant\Everest\new\nevLeafPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evLeafParaCursorPair in 'w:\common\components\gui\Garant\Everest\evLeafParaCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evLeafParaCursor in 'w:\common\components\gui\Garant\Everest\evLeafParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evMarker in 'w:\common\components\gui\Garant\Everest\evMarker.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  nevLeafParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevLeafParaAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevLeafParaInevLeafParaMapper in 'w:\common\components\gui\Garant\Everest\new\nevLeafParaInevLeafParaMapper.pas'
  {$IfEnd} //k2ForEditor
  ,
  nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas'
  {$If defined(k2ForEditor)}
  ,
  evTextPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTextPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaCursor in 'w:\common\components\gui\Garant\Everest\evTextParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
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
  evTextManipulationInterfaces in 'w:\common\components\gui\Garant\Everest\new\evTextManipulationInterfaces.pas'
  {$If defined(k2ForEditor)}
  ,
  evSegment in 'w:\common\components\gui\Garant\Everest\evSegment.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evTextParaPainterEx in 'w:\common\components\gui\Garant\Everest\evTextParaPainterEx.pas'
  {$IfEnd} //evNeedPainters
  ,
  l3SmartCanvas in 'w:\common\components\rtl\Garant\L3\l3SmartCanvas.pas',
  l3ItemsStorage in 'w:\common\components\rtl\Garant\L3\l3ItemsStorage.pas',
  l3Tree in 'w:\common\components\rtl\Garant\L3\l3Tree.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  nevAfterEndPoint in 'w:\common\components\gui\Garant\Everest\nevAfterEndPoint.pas'
  {$IfEnd} //evUseVisibleCursors
  
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
  evAACTextPainter in 'w:\common\components\gui\Garant\Everest\evAACTextPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedPainters)}
  ,
  evLinePainter in 'w:\common\components\gui\Garant\Everest\evLinePainter.pas'
  {$IfEnd} //evNeedPainters
  
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
  evCustomStyleManager in 'w:\common\components\gui\Garant\Everest\evCustomStyleManager.pas'
  {$If defined(k2ForEditor)}
  ,
  nevTextPara in 'w:\common\components\gui\Garant\Everest\new\nevTextPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTextCursorPair in 'w:\common\components\gui\Garant\Everest\evTextCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evTextParaHotSpotTester in 'w:\common\components\gui\Garant\Everest\evTextParaHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  
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
  evCollapserHyperlink in 'w:\common\components\gui\Garant\Everest\evCollapserHyperlink.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evParaCollapser in 'w:\common\components\gui\Garant\Everest\evParaCollapser.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evExpandedTextActiveHyperlink in 'w:\common\components\gui\Garant\Everest\evExpandedTextActiveHyperlink.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evExpandedTextCollapser in 'w:\common\components\gui\Garant\Everest\evExpandedTextCollapser.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evArchiCollapser in 'w:\common\components\gui\Garant\Everest\evArchiCollapser.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(k2ForEditor)}
  ,
  evTextParaStringImpl in 'w:\common\components\gui\Garant\Everest\new\evTextParaStringImpl.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevTextParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTextParaAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevTextParaInevTextParaMapper in 'w:\common\components\gui\Garant\Everest\new\nevTextParaInevTextParaMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evControlPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evControlPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evControlParaPainter in 'w:\common\components\gui\Garant\Everest\evControlParaPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  evControlParaTools in 'w:\common\components\gui\Garant\Everest\qf\evControlParaTools.pas'
  {$If defined(k2ForEditor)}
  ,
  nevControlPara in 'w:\common\components\gui\Garant\Everest\new\nevControlPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevFontPrim in 'w:\common\components\gui\Garant\Everest\new\nevFontPrim.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevControlParaIevControlFriendMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlParaIevControlFriendMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevControlParaModelControlMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlParaModelControlMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evFormula_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evFormula_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evFormulaPainter in 'w:\common\components\gui\Garant\Everest\evFormulaPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(k2ForEditor)}
  ,
  nevFormulaPara in 'w:\common\components\gui\Garant\Everest\new\nevFormulaPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evFormulaCursor in 'w:\common\components\gui\Garant\Everest\evFormulaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evParaList_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evParaList_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas',
  nevShapePrimRefList in 'w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas',
  nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas',
  nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas',
  nevBaseView in 'w:\common\components\gui\Garant\Everest\new\nevBaseView.pas',
  nevBaseDetachedView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDetachedView.pas',
  nevVirtualDrawView in 'w:\common\components\gui\Garant\Everest\new\nevVirtualDrawView.pas',
  evParaDrawTools in 'w:\common\components\gui\Garant\Everest\evParaDrawTools.pas'
  {$If defined(k2ForEditor)}
  ,
  nevParaList in 'w:\common\components\gui\Garant\Everest\new\nevParaList.pas'
  {$IfEnd} //k2ForEditor
  ,
  nevParas in 'w:\common\components\gui\Garant\Everest\new\nevParas.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursorPair in 'w:\common\components\gui\Garant\Everest\evParaListCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaPackOperation in 'w:\common\components\gui\Garant\Everest\evParaPackOperation.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  nevParaListAnchor in 'w:\common\components\gui\Garant\Everest\new\nevParaListAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedHotSpot)}
  ,
  evParaListHotSpotTester in 'w:\common\components\gui\Garant\Everest\evParaListHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot)}
  ,
  evParaListHotSpotTesterPrim in 'w:\common\components\gui\Garant\Everest\evParaListHotSpotTesterPrim.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(k2ForEditor)}
  ,
  nevParaListInevParaListMapper in 'w:\common\components\gui\Garant\Everest\new\nevParaListInevParaListMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evBlock_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evBlock_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevDocumentPartAnchor in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPartAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevDocumentPart in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPart.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evDocument_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evDocument_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  evdDOM in 'w:\common\components\rtl\Garant\EVD\evdDOM.pas'
  {$If defined(k2ForEditor)}
  ,
  nevDocument in 'w:\common\components\gui\Garant\Everest\new\nevDocument.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evDocumentAnchorIndex in 'w:\common\components\gui\Garant\Everest\new\evDocumentAnchorIndex.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evQueryCard_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evQueryCard_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evQueryCardCursor in 'w:\common\components\gui\Garant\Everest\evQueryCardCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evTableCell_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTableCell_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evTableCellPainter in 'w:\common\components\gui\Garant\Everest\evTableCellPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(k2ForEditor)}
  ,
  nevTableCell in 'w:\common\components\gui\Garant\Everest\new\nevTableCell.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedHotSpot)}
  ,
  evTableCellHotSpot in 'w:\common\components\gui\Garant\Everest\evTableCellHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(k2ForEditor)}
  ,
  nevTableCellAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTableCellAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCellCursor in 'w:\common\components\gui\Garant\Everest\evTableCellCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evTableImplementation in 'w:\common\components\gui\Garant\Everest\evTableImplementation.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCellCursorPair in 'w:\common\components\gui\Garant\Everest\evTableCellCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evSBSCell_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSBSCell_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evSBSCellPainter in 'w:\common\components\gui\Garant\Everest\evSBSCellPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(k2ForEditor)}
  ,
  evTableRow_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTableRow_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evTableRowPainter in 'w:\common\components\gui\Garant\Everest\evTableRowPainter.pas'
  {$IfEnd} //evNeedPainters
  ,
  PrintRowHeightsSpy in 'w:\common\components\gui\Garant\Everest\new\PrintRowHeightsSpy.pas'
  {$If defined(k2ForEditor)}
  ,
  nevTableRow in 'w:\common\components\gui\Garant\Everest\new\nevTableRow.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevTableRowAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTableRowAnchor.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  evSBSRow_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSBSRow_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  evTable_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTable_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevTable in 'w:\common\components\gui\Garant\Everest\new\nevTable.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevTableAnchor in 'w:\common\components\gui\Garant\Everest\new\nevTableAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedHotSpot)}
  ,
  evTableHotSpot in 'w:\common\components\gui\Garant\Everest\evTableHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evNeedHotSpot) AND defined(k2ForEditor)}
  ,
  nevTableIevChangeParamToolMapper in 'w:\common\components\gui\Garant\Everest\new\nevTableIevChangeParamToolMapper.pas'
  {$IfEnd} //evNeedHotSpot AND k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evReqCell_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqCell_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evReqCellCursor in 'w:\common\components\gui\Garant\Everest\evReqCellCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evReqCellHotSpot in 'w:\common\components\gui\Garant\Everest\evReqCellHotSpot.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(k2ForEditor)}
  ,
  evReqRow_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqRow_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evReqRowPainter in 'w:\common\components\gui\Garant\Everest\evReqRowPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evReqRowHotSpotTester in 'w:\common\components\gui\Garant\Everest\evReqRowHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  
  {$If defined(k2ForEditor)}
  ,
  evReqRowModelControlMapper in 'w:\common\components\gui\Garant\Everest\new\evReqRowModelControlMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evControlsBlock_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evControlsBlock_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evControlsBlockPainter in 'w:\common\components\gui\Garant\Everest\evControlsBlockPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(k2ForEditor)}
  ,
  nevControlsBlock in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlock.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevControlsBlockIevCommonControlMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockIevCommonControlMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevControlsBlockModelControlMapper in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockModelControlMapper.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evSolidPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSolidPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evSolidParaCursor in 'w:\common\components\gui\Garant\Everest\evSolidParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  nevSolidParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevSolidParaAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evSolidParaCursorPair in 'w:\common\components\gui\Garant\Everest\evSolidParaCursorPair.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evBitmapPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evBitmapPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevBitmapParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevBitmapParaAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evCommentPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evCommentPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  nevCommentPara in 'w:\common\components\gui\Garant\Everest\new\nevCommentPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedHotSpot)}
  ,
  evCommentParaHotSpotTester in 'w:\common\components\gui\Garant\Everest\evCommentParaHotSpotTester.pas'
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(k2ForEditor)}
  ,
  evSBS_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSBS_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evSBSPainter in 'w:\common\components\gui\Garant\Everest\evSBSPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(k2ForEditor)}
  ,
  evReqGroup_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evReqGroup_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  AutoreferatDocument_Const in 'w:\common\components\gui\Garant\Everest\AutoreferatDocument_Const.pas'
  {$If defined(k2ForEditor)}
  ,
  evAutoreferatDocument_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evAutoreferatDocument_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevAutoreferatDocumentAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAutoreferatDocumentAnchor.pas'
  {$IfEnd} //k2ForEditor
  ,
  DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas',
  Division_Const in 'w:\common\components\gui\Garant\Everest\Division_Const.pas',
  XML_Const in 'w:\common\components\gui\Garant\Everest\XML_Const.pas',
  ExtDataPara_Const in 'w:\common\components\gui\Garant\Everest\ExtDataPara_Const.pas',
  AttrValue_Const in 'w:\common\components\gui\Garant\Everest\AttrValue_Const.pas',
  Attr_Const in 'w:\common\components\gui\Garant\Everest\Attr_Const.pas',
  TagName_Const in 'w:\common\components\gui\Garant\Everest\TagName_Const.pas',
  TagBody_Const in 'w:\common\components\gui\Garant\Everest\TagBody_Const.pas',
  TinyDocument_Const in 'w:\common\components\gui\Garant\Everest\TinyDocument_Const.pas',
  DictEntry_Const in 'w:\common\components\gui\Garant\Everest\DictEntry_Const.pas',
  DocumentQuery_Const in 'w:\common\components\gui\Garant\Everest\DocumentQuery_Const.pas',
  AnnoTopic_Const in 'w:\common\components\gui\Garant\Everest\AnnoTopic_Const.pas',
  evNative_AttrValues in 'w:\common\components\gui\Garant\Everest\evNative_AttrValues.pas',
  evNative_Schema in 'w:\common\components\gui\Garant\Everest\evNative_Schema.pas',
  evStyleTableFontSizeCorrector in 'w:\common\components\gui\Garant\Everest\evStyleTableFontSizeCorrector.pas',
  evStyleInterfaceEx in 'w:\common\components\gui\Garant\Everest\evStyleInterfaceEx.pas',
  StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas',
  TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas',
  ParaList_Const in 'w:\common\components\gui\Garant\Everest\ParaList_Const.pas',
  TableCell_Const in 'w:\common\components\gui\Garant\Everest\TableCell_Const.pas'
  {$If defined(k2ForEditor)}
  ,
  evParaTools in 'w:\common\components\gui\Garant\Everest\evParaTools.pas'
  {$IfEnd} //k2ForEditor
  ,
  evCursorController in 'w:\common\components\gui\Garant\Everest\evCursorController.pas',
  evWindowCursor in 'w:\common\components\gui\Garant\Everest\evWindowCursor.pas',
  evEditorInterfacesMisc in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesMisc.pas',
  evBitmapReader in 'w:\common\components\gui\Garant\Everest\evBitmapReader.pas'
  {$If defined(k2ForEditor)}
  ,
  evParaFrame in 'w:\common\components\gui\Garant\Everest\evParaFrame.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evUsialParagraph in 'w:\common\components\gui\Garant\Everest\evUsialParagraph.pas'
  {$IfEnd} //k2ForEditor
  ,
  evRange in 'w:\common\components\gui\Garant\Everest\evRange.pas',
  evBlockCursor in 'w:\common\components\gui\Garant\Everest\evBlockCursor.pas',
  nevSelection in 'w:\common\components\gui\Garant\Everest\nevSelection.pas',
  l3Tool in 'w:\common\components\rtl\Garant\L3\l3Tool.pas',
  evDataObject in 'w:\common\components\gui\Garant\Everest\evDataObject.pas',
  evEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evEditorWindowHotSpot.pas',
  OvcController in 'w:\common\components\rtl\external\Orpheus\OvcController.pas',
  OvcBase in 'w:\common\components\rtl\external\Orpheus\OvcBase.pas',
  afwControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControlPrim.pas',
  l3ControlCanvas in 'w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas',
  l3WinControlCanvas in 'w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas'
  {$If not defined(NoScripts)}
  ,
  RadioButtonWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3CBTListenersList in 'w:\common\components\rtl\Garant\L3\l3CBTListenersList.pas',
  l3GetMessageListenersList in 'w:\common\components\rtl\Garant\L3\l3GetMessageListenersList.pas',
  l3WndProcListenersList in 'w:\common\components\rtl\Garant\L3\l3WndProcListenersList.pas',
  l3WndProcRetListenersList in 'w:\common\components\rtl\Garant\L3\l3WndProcRetListenersList.pas',
  l3MouseListenersList in 'w:\common\components\rtl\Garant\L3\l3MouseListenersList.pas',
  l3MouseWheelListenersList in 'w:\common\components\rtl\Garant\L3\l3MouseWheelListenersList.pas',
  l3ListenersHooks in 'w:\common\components\rtl\Garant\L3\l3ListenersHooks.pas',
  l3ListenersManager in 'w:\common\components\rtl\Garant\L3\l3ListenersManager.pas'
  {$If not defined(NoVCL)}
  ,
  Themes {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Themes.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  l3Operations in 'w:\common\components\rtl\Garant\L3\l3Operations.pas',
  l3DropTarget in 'w:\common\components\rtl\Garant\L3\l3DropTarget.pas',
  l3DropSource in 'w:\common\components\rtl\Garant\L3\l3DropSource.pas',
  afwVCL in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas'
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  PanelProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  RadioGroupWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  afwHintManager in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas',
  l3CustomControlCanvas in 'w:\common\components\rtl\Garant\L3\l3CustomControlCanvas.pas',
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
  tfwClipboardFormatWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClipboardFormatWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCFHTML in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFHTML.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCFXML in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFXML.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCFEVEREST in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFEVEREST.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCFRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFRTF.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCFEVERESTBIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFEVERESTBIN.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCFPDF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFPDF.pas'
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
  kwSelectCellsWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSelectCellsWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorSelectCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas'
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
  kwPopEditorJumpToHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorRepaintTableLinesAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintTableLinesAndCheckWithEtalon.pas'
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
  kwPopEditorGetLeftIndentDelta in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLeftIndentDelta.pas'
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
  evdStartAndTimeEliminator in 'w:\common\components\gui\Garant\Everest\evdStartAndTimeEliminator.pas'
  {$If not defined(NoImageEn)}
  ,
  imageenio in 'w:\common\components\rtl\external\ImageEn\src\imageenio.pas'
  {$IfEnd} //not NoImageEn
  ,
  l3PicturePathService in 'w:\common\components\rtl\Garant\L3\l3PicturePathService.pas'
  {$If not defined(NoScripts)}
  ,
  PictureEtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas'
  {$IfEnd} //not NoScripts
  ,
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
  kwPopEditorSetCursorByPoint in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetCursorByPoint.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorRepaintAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorCopyAndPaste2DocumentBottom in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCopyAndPaste2DocumentBottom.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEditorFromStackTableColumnResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTableColumnResize.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorResizeTableColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopEditorResizeTableColumnEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumnEX.pas'
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
  kwPopEditorPasteEVDTroughClipboard in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteEVDTroughClipboard.pas'
  {$IfEnd} //not NoScripts
  ,
  l3MetafileHeader in 'w:\common\components\rtl\Garant\L3\l3MetafileHeader.pas',
  l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas',
  afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas',
  l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas',
  afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas',
  afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas',
  evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
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
  TevCustomEditorWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TevCustomEditorWordsPack.pas'
  {$IfEnd} //not NoScripts
  
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
  ,
  nevObjectList in 'w:\common\components\gui\Garant\Everest\new\nevObjectList.pas',
  nevBaseDrawView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDrawView.pas',
  nevView in 'w:\common\components\gui\Garant\Everest\new\nevView.pas',
  l3ProcessMessagesManager in 'w:\common\components\rtl\Garant\L3\l3ProcessMessagesManager.pas',
  evCustomEditorWindow in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindow.pas',
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
  evCustomEditor in 'w:\common\components\gui\Garant\Everest\evCustomEditor.pas',
  evEditorWithOperations in 'w:\common\components\gui\Garant\Everest\evEditorWithOperations.pas',
  evTextSource in 'w:\common\components\gui\Garant\Everest\evTextSource.pas',
  l3BaseWithLargeIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDListPrim.pas',
  l3BaseWithLargeIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDList.pas',
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
  l3AFWExceptions in 'w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas'
  {$If not defined(NoScripts)}
  ,
  l3ScriptService in 'w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas'
  {$IfEnd} //not NoScripts
  ,
  l3ModalService in 'w:\common\components\rtl\Garant\L3\l3ModalService.pas',
  l3BatchService in 'w:\common\components\rtl\Garant\L3\l3BatchService.pas'
  {$If not defined(NoScripts)}
  ,
  afwAnswer in 'w:\common\components\rtl\Garant\L3\afwAnswer.pas'
  {$IfEnd} //not NoScripts
  ,
  evDocumentPreviewPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPreviewPrim.pas',
  evDocumentPreview in 'w:\common\components\gui\Garant\Everest\evDocumentPreview.pas',
  evHAFPainterMacros in 'w:\common\components\gui\Garant\Everest\evHAFPainterMacros.pas'
  {$If defined(k2ForEditor)}
  ,
  evSBSPar in 'w:\common\components\gui\Garant\Everest\evSBSPar.pas'
  {$IfEnd} //k2ForEditor
  ,
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
  ctAbstractEdit in 'w:\common\components\gui\Garant\VT\ComboTree\ctAbstractEdit.pas',
  ElUxTheme in 'w:\common\components\gui\Garant\VT\elClone\Source\ElUxTheme.pas',
  ElPopBtn in 'w:\common\components\gui\Garant\Everest\ElPopBtn.pas',
  ElVclUtils in 'w:\common\components\gui\Garant\Everest\ElVclUtils.pas'
  {$If not defined(NoVCL)}
  ,
  l3GetCaptureHelper in 'w:\common\components\rtl\Garant\L3\l3GetCaptureHelper.pas'
  {$IfEnd} //not NoVCL
  ,
  AbstractDropDown in 'w:\common\components\gui\Garant\VT\ComboTree\AbstractDropDown.pas',
  afwInputControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInputControl.pas',
  vtHeader in 'w:\common\components\gui\Garant\VT\vtHeader.pas',
  l3LogicalArray in 'w:\common\components\rtl\Garant\L3\l3LogicalArray.pas',
  OvcColor in 'w:\common\components\rtl\external\Orpheus\OvcColor.pas',
  OvcData in 'w:\common\components\rtl\external\Orpheus\OvcData.pas',
  OvcExcpt in 'w:\common\components\rtl\external\Orpheus\OvcExcpt.pas',
  vtStdRes in 'w:\common\components\gui\Garant\VT\vtStdRes.pas' {vtStdResources: TDataModule},
  l3TabStops in 'w:\common\components\rtl\Garant\L3\l3TabStops.pas',
  vtHintManager in 'w:\common\components\gui\Garant\VT\vtHintManager.pas'
  {$If not defined(NoScripts)}
  ,
  vtHintWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  vtMultilineHint in 'w:\common\components\gui\Garant\VT\vtMultilineHint.pas'
  {$If not defined(NoScripts)}
  ,
  ListerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  vtLister in 'w:\common\components\gui\Garant\VT\vtLister.pas',
  vtTreeSource in 'w:\common\components\gui\Garant\VT\vtTreeSource.pas'
  {$If not defined(NoScripts)}
  ,
  vtOutlinerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas'
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
  FakeBox in 'w:\common\components\gui\Garant\VT\ComboTree\FakeBox.pas',
  vtComboTree in 'w:\common\components\gui\Garant\VT\ComboTree\vtComboTree.pas'
  {$If not defined(NoScripts)}
  ,
  vtComboTreeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboTreeWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  vtComboBoxQS in 'w:\common\components\gui\Garant\VT\vtComboBoxQS.pas'
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  TreeNodeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeNodeWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  TreeViewWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ComCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  FolderSupport in 'w:\common\components\rtl\external\DUnit\src\FolderSupport.pas'
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  TTreeNodeForTestsWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  ,
  TestForm4Scripts in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\TestForm4Scripts.pas',
  l3CardinalList in 'w:\common\components\rtl\Garant\L3\l3CardinalList.pas',
  JwaNtStatus {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas' {$EndIf},
  JwaWinNT {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas' {$EndIf},
  JwaWinType {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas' {$EndIf},
  JwaWinBase {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas' {$EndIf},
  l3ImageUtils in 'w:\common\components\rtl\Garant\L3\l3ImageUtils.pas'
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  SecuritySrv_int in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv_int.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  Contents_int in 'w:\common\components\rtl\Garant\ServerGate\Contents_int.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  orb_int in 'w:\common\components\rtl\external\MTDOrb\src\orbint\orb_int.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  CosNaming_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming_int.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  pi_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi_int.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  orb in 'w:\common\components\rtl\external\MTDOrb\src\orb\orb.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  pi in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  orbtypes in 'w:\common\components\rtl\external\MTDOrb\src\orb\orbtypes.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  GarClientSecurity in 'w:\common\components\rtl\Garant\GarORB\GarClientSecurity.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  pi_impl in 'w:\common\components\rtl\external\MTDOrb\src\orb\pi_impl.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  GarORBInitializerImpl in 'w:\common\components\rtl\Garant\GarORB\GarORBInitializerImpl.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  CosNaming in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  SecuritySrv in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  Contents in 'w:\common\components\rtl\Garant\ServerGate\Contents.pas'
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  tfwKConst in 'w:\common\components\rtl\Garant\DUnitTuning\tfwKConst.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KBridge in 'w:\common\components\rtl\Garant\DUnitTuning\KBridge.pas'
  {$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\BaseTest.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  TestNameString in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameString.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  TestNameList in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameList.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  ExcludedTests in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTests.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  ExcludedTestsFolders in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTestsFolders.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  TestDocumentList in 'w:\common\components\rtl\Garant\DUnitTuning\TestDocumentList.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  vtVerInf in 'w:\common\components\rtl\Garant\L3\vtVerInf.pas',
  l3VersionInfoService in 'w:\common\components\rtl\Garant\L3\l3VersionInfoService.pas'
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner in 'w:\common\components\rtl\Garant\DUnitTuning\KTestRunner.pas'
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  GUITestRunner in 'w:\common\components\rtl\external\DUnit\src\GUITestRunner.pas',
  tfwFileStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFileStreamFactory.pas',
  tfwStringStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringStreamFactory.pas'
  {$If not defined(NoScripts)}
  ,
  kwEmitString in 'w:\common\components\rtl\Garant\ScriptEngine\kwEmitString.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDualWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDualWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryFinally.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledTryExcept in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryExcept.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEND in 'w:\common\components\rtl\Garant\ScriptEngine\kwEND.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMedianBacket in 'w:\common\components\rtl\Garant\ScriptEngine\kwMedianBacket.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFINALLY in 'w:\common\components\rtl\Garant\ScriptEngine\kwFINALLY.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwEXCEPT in 'w:\common\components\rtl\Garant\ScriptEngine\kwEXCEPT.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwTryFinally.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwValueStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueStack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwSourcePointList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSourcePointList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDictionaryStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryStack.pas'
  {$IfEnd} //not NoScripts
  ,
  tfwCachedTokens in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCachedTokens.pas',
  tfwParser in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParser.pas'
  {$If not defined(NoScripts)}
  ,
  tfwStoredValuesStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  seThreadSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seThreadSupport.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEnginePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEnginePrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIncluded.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIncludedPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncludedPrim.pas'
  {$IfEnd} //not NoScripts
  ,
  tfwCOMStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCOMStreamFactory.pas'
  {$If not defined(NoScripts)}
  ,
  kwSystemIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwSystemIncluded.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledMain.pas'
  {$IfEnd} //not NoScripts
  ,
  l3EtalonsService in 'w:\common\components\rtl\Garant\L3\l3EtalonsService.pas',
  tfwResourceStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwResourceStreamFactory.pas'
  {$If not defined(NoScripts)}
  ,
  tfwCompiledAxiomaticsRes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompiledAxiomaticsRes.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwMain.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngine.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  AutoTestSuiteWithDUnitSupport in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestSuiteWithDUnitSupport.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  StdRes in 'StdRes.pas' {dmStdRes: TvcmApplicationRes}
  {$IfEnd} //not NoVCM
  ,
  DynamicTreeDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeDefinesUnit.pas',
  IOUnit in 'w:\shared\GCI\IOUnit.pas',
  BaseTypesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTypesUnit.pas',
  DynamicTreeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeUnit.pas',
  ContextSearchSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ContextSearchSupportUnit.pas',
  BaseTreeSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTreeSupportUnit.pas',
  SearchDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchDefinesUnit.pas',
  ExternalObjectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalObjectUnit.pas',
  UnderControlUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UnderControlUnit.pas',
  FoldersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FoldersUnit.pas',
  DocumentUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DocumentUnit.pas',
  FiltersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FiltersUnit.pas',
  ProgressIndicatorSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ProgressIndicatorSupportUnit.pas',
  SearchProgressIndicatorUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchProgressIndicatorUnit.pas',
  DynamicDocListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicDocListUnit.pas',
  SearchUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchUnit.pas',
  nsQueryInterfaces in 'Search\nsQueryInterfaces.pas'
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Result_Controls.pas'
  {$IfEnd} //not NoVCM
  ,
  nsUtils in 'Data\Common\nsUtils.pas',
  nsConst in 'Data\Common\nsConst.pas',
  eeConst in 'w:\common\components\gui\Garant\Everest_Engine\eeConst.pas',
  eeInterfaces in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas',
  bsTypesNew in 'Model\bsTypesNew.pas',
  l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  InsiderOwnScripter in 'InsiderOwnScripter.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  F1AutoScripter in 'F1AutoScripter.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  F1AutoTestSuite in 'F1_AutoTests\F1AutoTestSuite.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If not defined(XE)}
  ,
  F1Test in 'F1Test.pas'
  {$IfEnd} //not XE
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseTypes in 'w:\common\components\gui\Garant\VCM\vcmBaseTypes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls in 'w:\common\components\gui\Garant\VCM\vcmUserControls.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormItemList in 'w:\common\components\gui\Garant\VCM\vcmFormSetFormItemList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormDispatcherInterfaces in 'w:\common\components\gui\Garant\VCM\vcmFormDispatcherInterfaces.pas'
  {$IfEnd} //not NoVCM
  ,
  l3TabbedContainersDispatcher in 'w:\common\components\rtl\Garant\L3\l3TabbedContainersDispatcher.pas'
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces in 'w:\common\components\gui\Garant\VCM\vcmInterfaces.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmToolbarsInterfaces in 'w:\common\components\gui\Garant\VCM\vcmToolbarsInterfaces.pas'
  {$IfEnd} //not NoVCM
  ,
  l3Forms in 'w:\common\components\rtl\Garant\L3\l3Forms.pas'
  {$If not defined(NoVCM)}
  ,
  vcmGUI in 'w:\common\components\gui\Garant\VCM\vcmGUI.pas'
  {$IfEnd} //not NoVCM
  
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
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  VGSceneAndWinControlPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGSceneAndWinControlPack.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  VGComboBoxPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGComboBoxPack.pas'
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_listbox in 'w:\common\components\rtl\external\VGScene\vg_listbox.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_objects in 'w:\common\components\rtl\external\VGScene\vg_objects.pas'
  {$IfEnd} //not NoVGScene
  
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
  
  {$If not defined(NoVGScene)}
  ,
  vgVisualObjectList in 'w:\common\components\rtl\external\VGScene\vgVisualObjectList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_extctrls in 'w:\common\components\rtl\external\VGScene\vg_extctrls.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVCL)}
  ,
  l3IterateComponentParents in 'w:\common\components\rtl\Garant\L3\l3IterateComponentParents.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3GetComponentFromPointHelper in 'w:\common\components\rtl\Garant\L3\l3GetComponentFromPointHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3FormatActionInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatActionInfoHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3HugeMessageDlgWithWikiHelper in 'w:\common\components\rtl\Garant\L3\l3HugeMessageDlgWithWikiHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3FormatObjectInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatObjectInfoHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3GetComponentBoundsHelper in 'w:\common\components\rtl\Garant\L3\l3GetComponentBoundsHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVGScene)}
  ,
  vg_services in 'w:\common\components\rtl\external\VGScene\vg_services.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_scene in 'w:\common\components\rtl\external\VGScene\vg_scene.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_controls in 'w:\common\components\rtl\external\VGScene\vg_controls.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vtVGButton in 'w:\common\components\gui\Garant\VT\vtVGButton.pas'
  {$IfEnd} //not NoVGScene
  ,
  vtDialogsRes in 'w:\common\components\gui\Garant\VT\vtDialogsRes.pas',
  vtDialogsResEx in 'w:\common\components\gui\Garant\VT\vtDialogsResEx.pas'
  {$If not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmMessageFormPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageFormPrim.pas'
  {$IfEnd} //not NoVCM AND not NoVGScene
  ,
  nscSimpleEditor in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditor.pas',
  nscSimpleEditorForDialogsContainer in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsContainer.pas',
  nscSimpleEditorForDialogsTextSource in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsTextSource.pas',
  nscSimpleEditorForDialogs in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogs.pas',
  vtFocusLabel in 'w:\common\components\gui\Garant\VT\vtFocusLabel.pas',
  l3FormCanvas in 'w:\common\components\rtl\Garant\L3\l3FormCanvas.pas',
  vtUtils in 'w:\common\components\gui\Garant\VT\vtUtils.pas'
  {$If not defined(NoVGScene)}
  ,
  vtVGSceneRes in 'w:\common\components\gui\Garant\VT\vtVGSceneRes.pas' {vtVGSceneResources: TDataModule}
  {$IfEnd} //not NoVGScene
  ,
  vtF1InterfaceConst in 'w:\common\components\gui\Garant\VT\vtF1InterfaceConst.pas'
  {$If not defined(NoVCM)}
  ,
  vcmMessagesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMessagesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmStringIDExHelper in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringIDExHelper.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMakeParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmMakeParams.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase in 'w:\common\components\gui\Garant\VCM\implementation\vcmBase.pas'
  {$IfEnd} //not NoVCM
  ,
  l3VCLFormPtrList in 'w:\common\components\rtl\Garant\L3\l3VCLFormPtrList.pas'
  {$If not defined(NoVCM)}
  ,
  vcmModule in 'w:\common\components\gui\Garant\VCM\implementation\vcmModule.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmModulesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModulesCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenus in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenus.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmPopupMenuPrim in 'w:\common\components\gui\Garant\VCM\vcmPopupMenuPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmAction.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseOperationState in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationState.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmPrimCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmPrimCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationParams in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationParams.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseOperationStates in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationStates.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmActiveControlsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmActiveControlsCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If defined(XE)}
  ,
  Actions {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Actions.pas' {$EndIf}
  {$IfEnd} //XE
  
  {$If not defined(NoVCM)}
  ,
  vcmInternalConst in 'w:\common\components\gui\Garant\VCM\implementation\vcmInternalConst.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmModulesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModulesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationDefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmOperationDefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseOperationsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationsCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmTargetedControlsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmTargetedControlsCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmRepositoryEx in 'w:\common\components\gui\Garant\VCM\implementation\vcmRepositoryEx.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntitiesCollectionItemEntity in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesCollectionItemEntity.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmControlsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmControlsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseEntityDef in 'w:\common\components\gui\Garant\VCM\implementation\vcmBaseEntityDef.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationableIdentifiedUserFriendly in 'w:\common\components\gui\Garant\VCM\implementation\vcmOperationableIdentifiedUserFriendly.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmModuleDef in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModuleDef.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmCommandIDsListPrim in 'w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsListPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmCommandIDsList in 'w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOVCCommands in 'w:\common\components\gui\Garant\VCM\implementation\vcmOVCCommands.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmModuleAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmModuleAction.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityAction.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmActiveControlsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmActiveControlsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseOperationDef in 'w:\common\components\gui\Garant\VCM\implementation\vcmBaseOperationDef.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUtils in 'w:\common\components\gui\Garant\VCM\implementation\vcmUtils.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmRepOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepOperationsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmComponent in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmComponent.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntitiesDefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmEntitiesDefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntities in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntities.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseEntitiesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseEntities in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntities.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(XE)}
  ,
  DesignMenus {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Toolsapi\DesignMenus.pas' {$EndIf}
  {$IfEnd} //not XE
  
  {$If not defined(XE)}
  ,
  DesignIntf {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Toolsapi\DesignIntf.pas' {$EndIf}
  {$IfEnd} //not XE
  
  {$If not defined(XE)}
  ,
  ToolsAPI {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Toolsapi\ToolsAPI.pas' {$EndIf}
  {$IfEnd} //not XE
  
  {$If not defined(NoVCM)}
  ,
  vcmStringCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmStringCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmFormsCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMessagesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMessagesCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmRepEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepEntitiesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuManagerTypes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManagerTypes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuItemClickListenerList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuItemClickListenerList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwEntityOperation in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperation.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwEntityOperationPrim in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationPrim.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwEntityOperationTest in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationTest.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationsManager in 'w:\common\components\gui\Garant\VCM\vcmOperationsManager.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwOperationsRegistrar in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationsRegistrar.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationsDefIteratorForContextMenu in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationsDefIteratorForContextMenu.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityDefForContextMenu in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntityDefForContextMenu.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntitiesDefIteratorForContextMenu in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesDefIteratorForContextMenu.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  VCMWordsPack in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmDispatcherLock in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLock.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmDispatcherUnlock in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlock.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmDispatcherBeginOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherBeginOp.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmDispatcherEndOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherEndOp.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryGetBackCount in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackCount.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryGetBackItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackItem.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryGetForwardCount in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardCount.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryGetForwardItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardItem.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwOperationParamWordPrim in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWordPrim.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwOperationParamWord in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWord.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpEnabled in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpEnabled.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpVisible in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpVisible.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpChecked in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpChecked.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpDefault in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpDefault.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpCaption in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpCaption.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpHint in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpHint.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpImageIndex in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpImageIndex.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpShortcut in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpShortcut.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmOpLongHint in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpLongHint.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  ,
  afwTextControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControlPrim.pas',
  afwTextControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControl.pas',
  vtPanel in 'w:\common\components\gui\Garant\VT\vtPanel.pas'
  {$If not defined(NoVCL)}
  ,
  Buttons {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Buttons.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  vtForm in 'w:\common\components\gui\Garant\VT\vtForm.pas'
  {$If not defined(NoVCL)}
  ,
  Mask {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Mask.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  vtCombo in 'w:\common\components\gui\Garant\VT\vtCombo.pas',
  vtDateEditRes in 'w:\common\components\gui\Garant\VT\vtDateEditRes.pas',
  vtCalendarPanel in 'w:\common\components\gui\Garant\VT\vtCalendarPanel.pas',
  Spin {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Samples\Spin.pas' {$EndIf},
  l3GraphicControlCanvas in 'w:\common\components\rtl\Garant\L3\l3GraphicControlCanvas.pas',
  vtLabel in 'w:\common\components\gui\Garant\VT\vtLabel.pas',
  MaskUtils {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\MaskUtils.pas' {$EndIf},
  vtDateEdit in 'w:\common\components\gui\Garant\VT\vtDateEdit.pas',
  vtDblClickDateEdit in 'w:\common\components\gui\Garant\VT\vtDblClickDateEdit.pas',
  IafwMenuUnlockedPostBuildPtrList in 'w:\common\components\gui\Garant\AFW\implementation\IafwMenuUnlockedPostBuildPtrList.pas'
  {$If not defined(NoVCM)}
  ,
  vcmToolbarMenuRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmToolbarMenuRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoTB97)}
  ,
  tb97GraphicControl in 'w:\common\components\rtl\external\tb97\tb97GraphicControl.pas'
  {$IfEnd} //not NoTB97
  
  {$If not defined(NoScripts) AND not defined(NoTB97)}
  ,
  tb97WordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tb97WordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoTB97
  
  {$If not defined(NoTB97)}
  ,
  tb97Ctls in 'w:\common\components\rtl\external\tb97\tb97Ctls.pas'
  {$IfEnd} //not NoTB97
  
  {$If not defined(NoVCM)}
  ,
  vcmOperationAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmOperationAction.pas'
  {$IfEnd} //not NoVCM
  ,
  afwCustomCommonControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControlPrim.pas',
  afwCustomCommonControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControl.pas'
  {$If not defined(NoTB97)}
  ,
  tb97Control in 'w:\common\components\rtl\external\tb97\tb97Control.pas'
  {$IfEnd} //not NoTB97
  
  {$If not defined(NoTB97)}
  ,
  TB97 in 'w:\common\components\rtl\external\tb97\TB97.pas'
  {$IfEnd} //not NoTB97
  
  {$If not defined(NoTB97)}
  ,
  TB97Tlbr in 'w:\common\components\rtl\external\tb97\TB97Tlbr.pas'
  {$IfEnd} //not NoTB97
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces in 'w:\common\components\gui\Garant\VCM\implementation\vcmLocalInterfaces.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmControl in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmControl.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmToolbarUtils in 'w:\common\components\gui\Garant\VCM\vcmToolbarUtils.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuItemsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMenuItemsCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserTypeDefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmUserTypeDefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  VCMApllicationSettingsPack in 'w:\common\components\rtl\Garant\ScriptEngine\VCMApllicationSettingsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ToolWin {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ToolWin.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  afwDrawing in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwDrawing.pas'
  {$If not defined(NoVCM)}
  ,
  vcmToolbar in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmToolbar.pas'
  {$IfEnd} //not NoVCM
  ,
  evButton in 'w:\common\components\gui\Garant\Everest\evButton.pas'
  {$If not defined(NoTB97)}
  ,
  TB97ExtInterfaces in 'w:\common\components\rtl\external\tb97\TB97ExtInterfaces.pas'
  {$IfEnd} //not NoTB97
  
  {$If not defined(NoVCM)}
  ,
  vcmWinControlActionLink in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmWinControlActionLink.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoTB97)}
  ,
  tb97vt in 'w:\common\components\rtl\external\tb97\tb97vt.pas'
  {$IfEnd} //not NoTB97
  ,
  l3MenuManagerHelper in 'w:\common\components\rtl\Garant\L3\l3MenuManagerHelper.pas'
  {$If not defined(NoVCM)}
  ,
  vcmMessages in 'w:\common\components\gui\Garant\VCM\implementation\vcmMessages.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuManagerUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManagerUtils.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmSettings in 'w:\common\components\gui\Garant\VCM\implementation\vcmSettings.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormHandler in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormHandler.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuManagerRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmMenuManagerRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuItemsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMenuItemsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainMenuAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainMenuAction.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmChromeLikeTypes in 'w:\common\components\gui\Garant\VCM\vcmChromeLikeTypes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityDefList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityDefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmModuleDefList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmModuleDefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainMenuBuilder in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainMenuBuilder.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManager.pas'
  {$IfEnd} //not NoVCM
  ,
  ElXPThemedControl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElXPThemedControl.pas'
  {$If not defined(NoScripts)}
  ,
  PageControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\PageControlWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  ElPgCtl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtl.pas',
  vtCustomCommonPanel in 'w:\common\components\gui\Garant\VT\vtCustomCommonPanel.pas',
  ElPgCtlConsts in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtlConsts.pas'
  {$If not defined(NoVCM)}
  ,
  vtNavigatorForm in 'w:\common\components\gui\Garant\VT\vtNavigatorForm.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vtNavigatorFormListPrimPrim in 'w:\common\components\gui\Garant\VT\vtNavigatorFormListPrimPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vtNavigatorFormListPrim in 'w:\common\components\gui\Garant\VT\vtNavigatorFormListPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vtNavigatorFormList in 'w:\common\components\gui\Garant\VT\vtNavigatorFormList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vtNavigatorRes in 'w:\common\components\gui\Garant\VT\vtNavigatorRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  npControls in 'w:\common\components\gui\Garant\VT\npControls.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  npControlsListPrim in 'w:\common\components\gui\Garant\VT\npControlsListPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  npControlsList in 'w:\common\components\gui\Garant\VT\npControlsList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  npNavigatorListPrim in 'w:\common\components\gui\Garant\VT\npNavigatorListPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  npNavigatorListCBT in 'w:\common\components\gui\Garant\VT\npNavigatorListCBT.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  npNavigatorList in 'w:\common\components\gui\Garant\VT\npNavigatorList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vtNavigatorUtils in 'w:\common\components\gui\Garant\VT\vtNavigatorUtils.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLayoutImplementation in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmLayoutImplementation.pas'
  {$IfEnd} //not NoVCM
  ,
  l3PopupControlService in 'w:\common\components\rtl\Garant\L3\l3PopupControlService.pas'
  {$If not defined(NoVCM)}
  ,
  vtNavigator in 'w:\common\components\gui\Garant\VT\vtNavigator.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVGScene)}
  ,
  vg_layouts in 'w:\common\components\rtl\external\VGScene\vg_layouts.pas'
  {$IfEnd} //not NoVGScene
  ,
  l3DockTree in 'w:\common\components\rtl\Garant\L3\l3DockTree.pas'
  {$If not defined(NoVCM)}
  ,
  vcmDockTree in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDockTree.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVGScene)}
  ,
  vtPopupForm in 'w:\common\components\gui\Garant\VT\vtPopupForm.pas'
  {$IfEnd} //not NoVGScene
  ,
  NewRemindersInterfaces in 'w:\common\components\gui\Garant\VT\NewRemindersInterfaces.pas'
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineForm in 'w:\common\components\gui\Garant\VT\vgRemindersLineForm.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ReminderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ReminderWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vtPopupFormModelPart in 'w:\common\components\gui\Garant\VT\vtPopupFormModelPart.pas'
  {$IfEnd} //not NoVCM AND not NoVGScene
  ,
  afwDockingInterfaces in 'w:\common\components\gui\Garant\AFW\afwDockingInterfaces.pas'
  {$If not defined(NoImageEn)}
  ,
  hyieutils in 'w:\common\components\rtl\external\ImageEn\src\hyieutils.pas'
  {$IfEnd} //not NoImageEn
  ,
  vtInterfaces in 'w:\common\components\gui\Garant\VT\vtInterfaces.pas',
  l3ProcedureList in 'w:\common\components\rtl\Garant\L3\l3ProcedureList.pas'
  {$If not defined(NoImageEn)}
  ,
  hyiedefs in 'w:\common\components\rtl\external\ImageEn\src\hyiedefs.pas'
  {$IfEnd} //not NoImageEn
  ,
  vtPngImgListUtils in 'w:\common\components\gui\Garant\VT\vtPngImgListUtils.pas',
  vtPngImgList in 'w:\common\components\gui\Garant\VT\vtPngImgList.pas'
  {$If not defined(NoVGScene)}
  ,
  vgReminderConsts in 'w:\common\components\gui\Garant\VT\vgReminderConsts.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgReminderWithAction in 'w:\common\components\gui\Garant\VT\vgReminderWithAction.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineList in 'w:\common\components\gui\Garant\VT\vgRemindersLineList.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineManager in 'w:\common\components\gui\Garant\VT\vgRemindersLineManager.pas'
  {$IfEnd} //not NoVGScene
  ,
  l3ByteList in 'w:\common\components\rtl\Garant\L3\l3ByteList.pas',
  spHelpNotifyManager in 'w:\common\components\gui\Garant\AFW\spHelpNotifyManager.pas'
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineNotificationProxy in 'w:\common\components\gui\Garant\VT\vgRemindersLineNotificationProxy.pas'
  {$IfEnd} //not NoVGScene
  ,
  l3DwmApi in 'w:\common\components\rtl\Garant\L3\l3DwmApi.pas'
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineTabbedContainerNotificationProxy in 'w:\common\components\gui\Garant\VT\vgRemindersLineTabbedContainerNotificationProxy.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLine in 'w:\common\components\gui\Garant\VT\vgRemindersLine.pas'
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  RemindersLineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RemindersLineWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  RegisterVcmControls in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\RegisterVcmControls.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryDeleteBackItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteBackItem.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmFindForm in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmFindForm.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryClear in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryClear.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmHistoryDeleteForwardItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteForwardItem.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwTryFocusOnForm in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwTryFocusOnForm.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwObjectCreate in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwObjectCreate.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmDispatcherLockInOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLockInOp.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwVcmDispatcherUnlockInOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlockInOp.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseMenuManagerRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmBaseMenuManagerRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExportConst in 'w:\common\components\gui\Garant\VCM\implementation\vcmExportConst.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContentConst in 'w:\common\components\gui\Garant\VCM\implementation\vcmContentConst.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmRepEntitiesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepEntitiesCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmFormsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmCustomHelpers in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomHelpers.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmBaseMenuManager.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMessageQueuePrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueuePrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMessageQueue in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueue.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessagesSupport.pas'
  {$IfEnd} //not NoVCM
  ,
  eeCheckBox in 'w:\common\components\gui\Garant\VT\eeCheckBox.pas',
  vtCheckBox in 'w:\common\components\gui\Garant\VT\vtCheckBox.pas'
  {$If not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmDialogs in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDialogs.pas'
  {$IfEnd} //not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM)}
  ,
  vcmUserInteractiveForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmForm.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers in 'w:\common\components\gui\Garant\VCM\vcmControllers.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityFormModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityFormModelPart.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  VCMFormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VCMFormsProcessingPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityFormImplementationModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityFormImplementationModelPart.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserTypesCollectionItemPrim in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmUserTypesCollectionItemPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBaseUserTypesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseUserTypesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserTypesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmUserTypesCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormsUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormsUtils.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmControlList in 'w:\common\components\gui\Garant\VCM\implementation\vcmControlList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityForm.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerFormModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmContainerFormModelPart.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmAggregateRefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmAggregateRefList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmContainerForm.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainFormModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormModelPart.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmIEntityList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainFormRes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmDockManagerList in 'w:\common\components\gui\Garant\VCM\implementation\vcmDockManagerList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLockListenerList in 'w:\common\components\gui\Garant\VCM\implementation\vcmLockListenerList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormDispatcherListenerList in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormDispatcherListenerList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainForm.pas'
  {$IfEnd} //not NoVCM
  ,
  nsTypesNew in 'Model\nsTypesNew.pas',
  nsTypes in 'Model\nsTypes.pas',
  SecurityUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SecurityUnit.pas',
  SettingsUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SettingsUnit.pas',
  bsTypes in 'Model\bsTypes.pas',
  bsInterfaces in 'Model\bsInterfaces.pas'
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscNewInterfaces.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDefsList in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarOperationDefsList.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarItemDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarItemDef.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarOperationDef.pas'
  {$IfEnd} //Nemesis
  ,
  F1_Without_Usecases_System_Controls in 'View\F1_Without_Usecases_System_Controls.pas',
  F1_Application_Template_InternalOperations_Controls in 'View\F1_Application_Template_InternalOperations_Controls.pas',
  PresentationInterfaces in 'w:\common\components\gui\Garant\VCM\View\PresentationInterfaces.pas'
  {$If defined(Nemesis)}
  ,
  nscNavigator in 'w:\common\components\gui\Garant\Nemesis\nscNavigator.pas'
  {$IfEnd} //Nemesis
  ,
  vtSizeablePanel in 'w:\common\components\gui\Garant\VT\vtSizeablePanel.pas',
  vtProportionalPanel in 'w:\common\components\gui\Garant\VT\vtProportionalPanel.pas'
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionPrimPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionPrimPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemModelPart.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollection.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItem.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactoryPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmAggregate in 'w:\common\components\gui\Garant\VCM\implementation\vcmAggregate.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshDataParamsList in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefreshDataParamsList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefreshParams.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetContainerRegistry in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetContainerRegistry.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSet in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSet.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParamsList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetRefreshParamsList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetDataSource in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmIEntityFormPtrList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormPtrList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmHistoryItemList in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistoryItemList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmHistoryFormNode in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistoryFormNode.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces in 'w:\common\components\gui\Garant\VCM\vcmTaskPanelInterfaces.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmHistoryRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistoryRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmHistory in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistory.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmHistoryService in 'w:\common\components\gui\Garant\VCM\vcmHistoryService.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryFacade in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactoryFacade.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormDataSourceList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmZoneTypeList in 'w:\common\components\gui\Garant\VCM\implementation\vcmZoneTypeList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactory.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmApplication in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmApplication.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  PrimCustomizeTools_Form in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\PrimCustomizeTools_Form.pas'
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  eeShortCutEdit in 'w:\common\components\gui\Garant\Everest_Engine\eeShortCutEdit.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  CustomizeTools_ut_CustomizeTools_UserType in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_ut_CustomizeTools_UserType.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  CustomizeTools_Form in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_Form.pas' {CustomizeToolsForm: TvcmEntityForm}
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  CustomizeToolsKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\CustomizeToolsKeywordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwControlString.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  vcmCustomizeAvailableToolbarOps in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomizeAvailableToolbarOps.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  tfwModuleOperationWord in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWord.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kw_ToolbarMenu_opCustomize in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opCustomize.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kw_ToolbarMenu_opAvailableOperations in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opAvailableOperations.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kw_ToolbarMenu_opIconsSize in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opIconsSize.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kw_ToolbarMenu_opFasten in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opFasten.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  PrimToolbarMenu_Module in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\PrimToolbarMenu_Module.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  moToolbarMenu in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\moToolbarMenu.pas' {mo_ToolbarMenu: TvcmModule}
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLikeRes in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLikeMain_Form in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeMain_Form.pas'
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  StatusBarUtils in 'w:\common\components\gui\Garant\Nemesis\StatusBarUtils.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscSizeGripPanel in 'w:\common\components\gui\Garant\Nemesis\nscSizeGripPanel.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarButton in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarButton.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  StatusBarButtonWords in 'w:\common\components\rtl\Garant\ScriptEngine\StatusBarButtonWords.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarPanel in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarPanel.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarSep in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarSep.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBar in 'w:\common\components\gui\Garant\Nemesis\nscStatusBar.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  StatusBarWords in 'w:\common\components\rtl\Garant\ScriptEngine\StatusBarWords.pas'
  {$IfEnd} //Nemesis AND not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_System_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_System_Controls.pas'
  {$IfEnd} //not NoVCM
  ,
  F1Like_InternalOperations_Controls in 'w:\common\components\gui\Garant\VCM\View\F1Like_InternalOperations_Controls.pas',
  eeInterfacesEx in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfacesEx.pas',
  vtOutlinerWithDragDropRes in 'w:\common\components\gui\Garant\VT\vtOutlinerWithDragDropRes.pas',
  vtOutlinerWithDragDrop in 'w:\common\components\gui\Garant\VT\vtOutlinerWithDragDrop.pas',
  eeNodeUtils in 'w:\common\components\gui\Garant\Everest_Engine\eeNodeUtils.pas',
  eeNode in 'w:\common\components\gui\Garant\Everest_Engine\eeNode.pas',
  eeTreeViewExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeViewExport.pas',
  eeTreeView in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeView.pas',
  vtCtrls in 'w:\common\components\gui\Garant\VT\vtCtrls.pas',
  vtGroupBox in 'w:\common\components\gui\Garant\VT\vtGroupBox.pas',
  eeButton in 'w:\common\components\gui\Garant\VT\eeButton.pas',
  vtButton in 'w:\common\components\gui\Garant\VT\vtButton.pas'
  {$If not defined(NoVCM)}
  ,
  CustomizeTasksPanelRes in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\CustomizeTasksPanelRes.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  PrimCustomizeTasksPanel_Form in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\PrimCustomizeTasksPanel_Form.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmCustOpsRepGroupList in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\vcmCustOpsRepGroupList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  CustomizeTasksPanel_Form in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_Form.pas' {CustomizeTasksPanelForm: TvcmEntityForm}
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  CustomizeTasksPanelKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\CustomizeTasksPanelKeywordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kw_TasksPanelMenu_opCustomize in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\kw_TasksPanelMenu_opCustomize.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  PrimTasksPanelMenu_Module in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\PrimTasksPanelMenu_Module.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  moTasksPanelMenu in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\moTasksPanelMenu.pas' {mo_TasksPanelMenu: TvcmModule}
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscFormsPageControl in 'w:\common\components\gui\Garant\Nemesis\nscFormsPageControl.pas'
  {$IfEnd} //Nemesis
  ,
  PrimChild_cutUsual_UserType in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutUsual_UserType.pas',
  PrimChild_cutForDiction_UserType in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutForDiction_UserType.pas',
  nsFormUtils in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsFormUtils.pas',
  PrimChild_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_Form.pas',
  PrimParent_utHistory_UserType in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_utHistory_UserType.pas',
  PrimParent_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_Form.pas',
  F1Like_FormDefinitions_Controls in 'w:\common\components\gui\Garant\VCM\View\F1Like_FormDefinitions_Controls.pas',
  Parent_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Parent_Form.pas' {ParentForm: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  ParentKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  Child_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Child_Form.pas' {ChildForm: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  ChildKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\ChildKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  ParentAndChildPrim_Module in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentAndChildPrim_Module.pas',
  moParentAndChild in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\moParentAndChild.pas' {mo_ParentAndChild: TvcmModule},
  F1LikeRes in 'w:\common\components\gui\Garant\VCM\View\F1LikeRes.pas'
  {$If not defined(NoVCM)}
  ,
  OfficeLikeAppInterfaces in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeAppInterfaces.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmGlassFrame in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassFrame.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmGlassForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassForm.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmChromeLikeTabbedContainerFormPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabbedContainerFormPrim.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeFormFramePainter in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormFramePainter.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeWindowCaptionButtonsRes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeWindowCaptionButtonsRes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTypes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTypes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeWinUtils in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeWinUtils.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeFormCaptionData in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormCaptionData.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  UxTheme {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\UxTheme.pas' {$EndIf}
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeBaseWindowCaptionButton in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseWindowCaptionButton.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeLegacyWindowCaptionButtons in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeLegacyWindowCaptionButtons.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeBaseThemedWindowCaptionButton in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseThemedWindowCaptionButton.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeThemedWindowCaptionButtons in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeThemedWindowCaptionButtons.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  FormFrameDecorator in 'w:\common\components\gui\Garant\ChromeLikeControls\FormFrameDecorator.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeInterfaces in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeInterfaces.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  GDIPOBJ {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\GDIPLUS\GDIPOBJ.pas' {$EndIf}
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetTypes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetTypes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetUtils in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetUtils.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeDrawingContext in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeDrawingContext.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetControlPrim in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlPrim.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeBaseVisualObjectList in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObjectList.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeBaseVisualObject in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObject.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  MMSystem {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\MMSystem.pas' {$EndIf}
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetAnimationManager in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetAnimationManager.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeBaseVisualObjectPrim in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObjectPrim.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  GDIPUTIL {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\GDIPLUS\GDIPUTIL.pas' {$EndIf},
  GDIPAPI {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\GDIPLUS\GDIPAPI.pas' {$EndIf}
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetStyles in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetStyles.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabParams in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabParams.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetControlRes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlRes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetControl in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControl.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetRes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetRes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmChromeLikeTabbedContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabbedContainerForm.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmMainMenuForChromeLikeTypes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmMainMenuForChromeLikeTypes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmMenuForChromeLikeItems in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmMenuForChromeLikeItems.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmBaseMenuForChromeLike in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmBaseMenuForChromeLike.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
  ,
  vcmTabbedMenuWordsPack in 'w:\common\components\gui\Garant\VCM\vcmTabbedMenuWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ShadowWnd {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ShadowWnd.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  multimon {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\multimon.pas' {$EndIf}
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmDropDownMenuForChromeLike in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmDropDownMenuForChromeLike.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmPopupControlWindowService in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmPopupControlWindowService.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmMainMenuStripForChromeLike in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmMainMenuStripForChromeLike.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM)}
  ,
  vcmTabbedContainersService in 'w:\common\components\gui\Garant\VCM\vcmTabbedContainersService.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
  ,
  vcmTabsWordsPack in 'w:\common\components\gui\Garant\VCM\vcmTabsWordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcherUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerFormDispatcherUtils.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerRes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerRes.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmFormSetHistoryItemList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistoryItemList.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmFormSetFormHistoryItemList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetFormHistoryItemList.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmFormSetHistoryStepItemList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistoryStepItemList.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmFormSetHistoryStepList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistoryStepList.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM)}
  ,
  vcmIEntityFormList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmFormSetHistory in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistory.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabsHistoryService in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabsHistoryService.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerFormDispatcher.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerForm.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityFormsIterable in 'w:\common\components\gui\Garant\VCM\implementation\vcmEntityFormsIterable.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeFormTabParamsList in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormTabParamsList.pas'
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCM)}
  ,
  vcmStringList in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  nsWindowNode in 'w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowNode.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  nsWindowsListPrim in 'w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowsListPrim.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  nsWindowsList in 'w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowsList.pas'
  {$IfEnd} //not NoVCM
  ,
  nsSettingsConst in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsSettingsConst.pas',
  MainPrim_Form in 'w:\common\components\gui\Garant\VCM\View\MainPrim_Form.pas',
  LoggingInterfaces in 'Model\LoggingInterfaces.pas',
  LoggingUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\LoggingUnit.pas',
  LoggingWrapperInterfaces in 'Logging\LoggingWrapperInterfaces.pas',
  AdminDomainInterfaces in 'Model\AdminDomainInterfaces.pas',
  DataAdapterInterfaces in 'Model\DataAdapterInterfaces.pas',
  nsQuestionsWithChoices in 'Data\nsQuestionsWithChoices.pas',
  nsLoginUtils in 'Data\Common\nsLoginUtils.pas',
  DataAdapter in 'Data\Common\DataAdapter.pas',
  bsConvert in 'Data\Common\bsConvert.pas',
  nsLogEventData in 'Logging\nsLogEventData.pas',
  nsLoggingTestService in 'Logging\nsLoggingTestService.pas'
  {$If not defined(NoScripts)}
  ,
  LoggingWordsPack in 'Logging\LoggingWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  InsDefferedEventList in 'Logging\InsDefferedEventList.pas',
  nsPrimCachedEventsProcessor in 'Logging\nsPrimCachedEventsProcessor.pas',
  nsCachedEventsProcessor in 'Logging\nsCachedEventsProcessor.pas',
  nsLogManager in 'Logging\nsLogManager.pas',
  nsLogEvent in 'Logging\nsLogEvent.pas',
  nsPrimCachedEvent in 'Logging\nsPrimCachedEvent.pas',
  afwConsts in 'w:\common\components\gui\Garant\AFW\afwConsts.pas',
  BannerUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BannerUnit.pas',
  StartUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\StartUnit.pas',
  SPHTMLHelp in 'w:\common\components\gui\Garant\AFW\SPHTMLHelp.pas',
  GblAdapter,
  TreeInterfaces in 'Tree\TreeInterfaces.pas',
  SearchDomainInterfaces in 'Model\SearchDomainInterfaces.pas',
  SearchInterfaces in 'Search\SearchInterfaces.pas'
  {$If defined(Nemesis)}
  ,
  nscContextFilterRes in 'w:\common\components\gui\Garant\Nemesis\nscContextFilterRes.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscContextFilter in 'w:\common\components\gui\Garant\Nemesis\nscContextFilter.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Text_Controls.pas'
  {$IfEnd} //not NoVCM
  ,
  TreeAttribute_Form in 'View\LiteSearch\Forms\TreeAttribute_Form.pas',
  L10nInterfaces in 'Model\L10nInterfaces.pas',
  SearchLite_Strange_Controls in 'View\SearchLite_Strange_Controls.pas'
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Tree_Controls.pas'
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewRes in 'w:\common\components\gui\Garant\Nemesis\nscTreeViewRes.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmDefaultOperations in 'w:\common\components\gui\Garant\VCM\vcmDefaultOperations.pas'
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscTreeView in 'w:\common\components\gui\Garant\Nemesis\nscTreeView.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck in 'w:\common\components\gui\Garant\Nemesis\nscTreeViewHotTruck.pas'
  {$IfEnd} //Nemesis
  ,
  PrimTreeAttributeSelect_astNone_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas',
  PrimTreeAttributeSelect_astOneLevel_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astOneLevel_UserType.pas',
  PrimTreeAttributeSelect_astFirstLevel_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astFirstLevel_UserType.pas',
  PrimTreeAttributeSelect_astTaxesPublishSearch_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas'
  {$If defined(Nemesis)}
  ,
  nscContextFilterState in 'w:\common\components\gui\Garant\Nemesis\nscContextFilterState.pas'
  {$IfEnd} //Nemesis
  ,
  PrimTreeAttributeSelect_astPharmPublishSearch_UserType in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas',
  nsLogicOperationToFlags in 'Tree\nsLogicOperationToFlags.pas',
  nsINodeWrapBase in 'Data\Tree\nsINodeWrapBase.pas',
  nsRootManager in 'Data\Tree\nsRootManager.pas',
  nsINodeWrap in 'Data\Tree\nsINodeWrap.pas',
  nsINodeRootWrap in 'Data\Tree\nsINodeRootWrap.pas',
  nsTreeStruct in 'Data\Tree\nsTreeStruct.pas',
  l3TreeFilters in 'w:\common\components\rtl\Garant\L3\l3TreeFilters.pas',
  nsAdapterFilters in 'Data\Tree\nsAdapterFilters.pas',
  Il3ContextFilterParamsNotifierPtrList in 'Data\Tree\Il3ContextFilterParamsNotifierPtrList.pas',
  nsContextFilterParams in 'Data\Tree\nsContextFilterParams.pas',
  nsFilterableTreeStruct in 'Data\Tree\nsFilterableTreeStruct.pas',
  nsDataResetTreeStruct in 'Data\Tree\nsDataResetTreeStruct.pas',
  nsINodeOneLevelWrap in 'Data\Tree\nsINodeOneLevelWrap.pas',
  nsINodeOneLevelRootWrap in 'Data\Tree\nsINodeOneLevelRootWrap.pas',
  nsOneLevelTreeStruct in 'Data\Tree\nsOneLevelTreeStruct.pas',
  bsUtils in 'Data\Common\bsUtils.pas',
  nsAttributeTreeFilters in 'Data\Search\nsAttributeTreeFilters.pas',
  l3InterfacedStringList in 'w:\common\components\rtl\Garant\L3\l3InterfacedStringList.pas',
  nsAttributeTreeCacheNew in 'Data\Search\nsAttributeTreeCacheNew.pas',
  nsAttributeOneLevelTreeStruct in 'Data\Search\nsAttributeOneLevelTreeStruct.pas',
  nsAttrBranchStruct in 'Data\Search\nsAttrBranchStruct.pas',
  nsSelectedAttributesIterators in 'Search\nsSelectedAttributesIterators.pas',
  nsTreeAttributeNodesNew in 'View\LiteSearch\nsTreeAttributeNodesNew.pas',
  nsAttributeTreeStruct in 'Data\Search\nsAttributeTreeStruct.pas',
  nsIntegerValueMapFactory in 'Data\Common\nsIntegerValueMapFactory.pas',
  nsStringValueMapFactoryRes in 'Data\Common\nsStringValueMapFactoryRes.pas',
  nsStringValueMapFactory in 'Data\Common\nsStringValueMapFactory.pas',
  nsValueMaps in 'Data\Common\nsValueMaps.pas',
  nsValueMapsIDs in 'Data\Common\nsValueMapsIDs.pas',
  nsFirstLevelStruct in 'Data\Search\nsFirstLevelStruct.pas',
  SearchRes in 'View\SearchRes.pas' {nsSearchRes: TDataModule},
  nsNewCachableNode in 'Data\Tree\nsNewCachableNode.pas',
  dsTreeAttributeSelect in 'Search\dsTreeAttributeSelect.pas',
  deSearch in 'Search\deSearch.pas',
  nsQuery in 'View\LiteSearch\nsQuery.pas',
  SearchLite_FormDefinitions_Controls in 'View\SearchLite_FormDefinitions_Controls.pas',
  tasSaveLoadProxy in 'View\LiteSearch\tasSaveLoadProxy.pas',
  PrimTreeAttributeSelect_Form in 'View\LiteSearch\Forms\PrimTreeAttributeSelect_Form.pas',
  PrimTreeAttributeSelectOptions_Form in 'View\LiteSearch\Forms\PrimTreeAttributeSelectOptions_Form.pas',
  TreeAttributeSelect_Form in 'View\LiteSearch\Forms\TreeAttributeSelect_Form.pas' {efTreeAttributeSelect: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  TreeAttributeSelectKeywordsPack in 'View\LiteSearch\TreeAttributeSelectKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_ResultEx_Controls.pas'
  {$IfEnd} //not NoVCM
  ,
  PrimAttributeSelect_utAttributeSelect_UserType in 'View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas',
  PrimAttributeSelect_utSingleSearch_UserType in 'View\LiteSearch\Forms\PrimAttributeSelect_utSingleSearch_UserType.pas',
  OldTreeInterfaces in 'Model\OldTreeInterfaces.pas',
  nsWrapperNode in 'Data\Tree\nsWrapperNode.pas',
  l3VirtualNode in 'w:\common\components\rtl\Garant\L3\l3VirtualNode.pas',
  eeVirtualNode in 'w:\common\components\gui\Garant\Everest_Engine\eeVirtualNode.pas',
  nsPrimNode in 'Data\Tree\nsPrimNode.pas',
  nsPrimAdapterNode in 'Data\Tree\nsPrimAdapterNode.pas',
  nsPrimCacheableNode in 'Data\Tree\nsPrimCacheableNode.pas',
  nsBaseNode in 'Data\Tree\nsBaseNode.pas',
  nsNodes in 'Data\Tree\nsNodes.pas',
  PrimAttributeSelect_Form in 'View\LiteSearch\Forms\PrimAttributeSelect_Form.pas',
  PrimAttributeSelectOptions_Form in 'View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas',
  AttributeSelect_Form in 'View\LiteSearch\Forms\AttributeSelect_Form.pas' {cfAttributeSelect: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  AttributeSelectKeywordsPack in 'View\LiteSearch\AttributeSelectKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  evStorable in 'w:\common\components\gui\Garant\Everest\evStorable.pas',
  evStringStorable in 'w:\common\components\gui\Garant\Everest\evStringStorable.pas',
  evNodeStorable in 'w:\common\components\gui\Garant\Everest\evNodeStorable.pas',
  evPersistentDataObject in 'w:\common\components\gui\Garant\Everest\evPersistentDataObject.pas',
  evPersistentDataObjectEx in 'w:\common\components\gui\Garant\Everest\evPersistentDataObjectEx.pas',
  evFormats in 'w:\common\components\gui\Garant\Everest\evFormats.pas',
  evNodeDataObject in 'w:\common\components\gui\Garant\Everest\evNodeDataObject.pas',
  l3TreeConst in 'w:\common\components\rtl\Garant\L3\l3TreeConst.pas',
  evdAllParaEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllParaEliminator.pas',
  ddDocument in 'w:\common\components\rtl\Garant\dd\ddDocument.pas',
  rtfListTable in 'w:\common\components\rtl\Garant\dd\rtfListTable.pas',
  RTFtypes in 'w:\common\components\rtl\Garant\dd\RTFtypes.pas',
  ddRTFProperties in 'w:\common\components\rtl\Garant\dd\ddRTFProperties.pas',
  ddTypes in 'w:\common\components\rtl\Garant\dd\ddTypes.pas',
  ddCustomDestination in 'w:\common\components\rtl\Garant\dd\ddCustomDestination.pas',
  ddDocumentAtom in 'w:\common\components\rtl\Garant\dd\ddDocumentAtom.pas',
  ddCharacterProperty in 'w:\common\components\rtl\Garant\dd\ddCharacterProperty.pas',
  ddEVDTypesSupport in 'w:\common\components\rtl\Garant\dd\ddEVDTypesSupport.pas',
  ddBaseObject in 'w:\common\components\rtl\Garant\dd\ddBaseObject.pas',
  ddHyperlinkTarget in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTarget.pas',
  ddHyperlinkTargetList in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTargetList.pas',
  ddTextSegment in 'w:\common\components\rtl\Garant\dd\ddTextSegment.pas',
  ddParagraphProperty in 'w:\common\components\rtl\Garant\dd\ddParagraphProperty.pas',
  ddTextSegmentsList in 'w:\common\components\rtl\Garant\dd\ddTextSegmentsList.pas',
  ddSub in 'w:\common\components\rtl\Garant\dd\ddSub.pas',
  ddSubsList in 'w:\common\components\rtl\Garant\dd\ddSubsList.pas',
  ddTextParaString in 'w:\common\components\rtl\Garant\dd\ddTextParaString.pas',
  ddTextParagraph in 'w:\common\components\rtl\Garant\dd\ddTextParagraph.pas',
  ddHyperlink in 'w:\common\components\rtl\Garant\dd\ddHyperlink.pas',
  ddTextSegmentQueue in 'w:\common\components\rtl\Garant\dd\ddTextSegmentQueue.pas'
  {$If not defined(NoImageEn)}
  ,
  imageenview in 'w:\common\components\rtl\external\ImageEn\src\imageenview.pas'
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn) AND not defined(NoScripts)}
  ,
  ImageEnPack in 'w:\common\components\rtl\Garant\ScriptEngine\ImageEnPack.pas'
  {$IfEnd} //not NoImageEn AND not NoScripts
  
  {$If not defined(NoImageEn) AND not defined(NoScripts)}
  ,
  kwImageEnControl in 'w:\common\components\rtl\Garant\ScriptEngine\kwImageEnControl.pas'
  {$IfEnd} //not NoImageEn AND not NoScripts
  
  {$If not defined(NoImageEn) AND not defined(NoScripts)}
  ,
  kwImageEnViewerSaveBitmap in 'w:\common\components\rtl\Garant\ScriptEngine\kwImageEnViewerSaveBitmap.pas'
  {$IfEnd} //not NoImageEn AND not NoScripts
  
  {$If not defined(NoImageEn) AND not defined(NoScripts)}
  ,
  ImageEnViewRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\ImageEnViewRegistrator.pas'
  {$IfEnd} //not NoImageEn AND not NoScripts
  ,
  ddRTFUnits in 'w:\common\components\rtl\Garant\dd\ddRTFUnits.pas',
  l3CharSkipper in 'w:\common\components\rtl\Garant\L3\l3CharSkipper.pas',
  ddHexCharReader in 'w:\common\components\rtl\Garant\dd\ddHexCharReader.pas',
  ddPicture in 'w:\common\components\rtl\Garant\dd\ddPicture.pas',
  ddObjectSegment in 'w:\common\components\rtl\Garant\dd\ddObjectSegment.pas',
  ddPictureSegment in 'w:\common\components\rtl\Garant\dd\ddPictureSegment.pas',
  ddFormulaSegment in 'w:\common\components\rtl\Garant\dd\ddFormulaSegment.pas',
  ddRTFSegmentWriter in 'w:\common\components\rtl\Garant\dd\ddRTFSegmentWriter.pas',
  ddRTFExpandedTextWriter in 'w:\common\components\rtl\Garant\dd\ddRTFExpandedTextWriter.pas',
  ddRTFWriter in 'w:\common\components\rtl\Garant\dd\ddRTFWriter.pas',
  evNodeData in 'w:\common\components\gui\Garant\EverestCommon\evNodeData.pas',
  nsNodeStorable in 'Components\nsNodeStorable.pas',
  nsNodeDataObject in 'Components\nsNodeDataObject.pas',
  nsEntitiesTreeDataObject in 'Components\nsEntitiesTreeDataObject.pas',
  nscTreeViewWithAdapterDragDrop in 'Components\nscTreeViewWithAdapterDragDrop.pas',
  nsNodeBaseList in 'View\LiteSearch\nsNodeBaseList.pas',
  PrimSelectedAttributes_utSelectedAttributes_UserType in 'View\LiteSearch\Forms\PrimSelectedAttributes_utSelectedAttributes_UserType.pas',
  nsSelectedTreeStruct in 'View\LiteSearch\nsSelectedTreeStruct.pas',
  PrimSelectedAttributes_Form in 'View\LiteSearch\Forms\PrimSelectedAttributes_Form.pas',
  PrimSelectedAttributesOptions_Form in 'View\LiteSearch\Forms\PrimSelectedAttributesOptions_Form.pas',
  SelectedAttributes_Form in 'View\LiteSearch\Forms\SelectedAttributes_Form.pas' {enSelectedAttributes: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  SelectedAttributesKeywordsPack in 'View\LiteSearch\SelectedAttributesKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  LiteSearch_Module in 'View\LiteSearch\LiteSearch_Module.pas',
  moLiteSearch in 'View\LiteSearch\moLiteSearch.pas' {mo_LiteSearch: TvcmModule},
  PrimShutDown_sftNone_UserType in 'View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas',
  f1NotificationManager in 'View\f1NotificationManager.pas',
  PrimShutDown_Form in 'View\PrimCommon\Forms\PrimShutDown_Form.pas',
  ShutDown_Form in 'View\PrimCommon\Forms\ShutDown_Form.pas' {ShutDownForm: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  ShutDownKeywordsPack in 'View\PrimCommon\ShutDownKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(Nemesis)}
  ,
  nscComboBox in 'w:\common\components\gui\Garant\Nemesis\nscComboBox.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly in 'w:\common\components\gui\Garant\Nemesis\nscComboBoxWithReadOnly.pas'
  {$IfEnd} //Nemesis
  ,
  nsStartupSupport in 'Data\Common\nsStartupSupport.pas',
  nsFlashWindow in 'View\nsFlashWindow.pas',
  PrimLogin_Form in 'View\PrimCommon\Forms\PrimLogin_Form.pas',
  Login_ut_Login_UserType in 'View\PrimCommon\Forms\Login_ut_Login_UserType.pas',
  Login_Form in 'View\PrimCommon\Forms\Login_Form.pas' {LoginForm: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  LoginKeywordsPack in 'View\PrimCommon\LoginKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  vtGradientWaitbar in 'w:\common\components\gui\Garant\VT\vtGradientWaitbar.pas',
  l3AsincMessageWindowRes in 'w:\common\components\rtl\Garant\L3\l3AsincMessageWindowRes.pas',
  PrimLongProcess_Form in 'View\PrimCommon\Forms\PrimLongProcess_Form.pas',
  LongProcess_ut_LongProcess_UserType in 'View\PrimCommon\Forms\LongProcess_ut_LongProcess_UserType.pas',
  LongProcess_Form in 'View\PrimCommon\Forms\LongProcess_Form.pas' {LongProcessForm: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  LongProcessKeywordsPack in 'View\PrimCommon\LongProcessKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  PrimCommon_Module in 'View\PrimCommon\PrimCommon_Module.pas',
  moRealCommon in 'View\PrimCommon\moRealCommon.pas' {mo_RealCommon: TvcmModule},
  DebugStr in 'Data\Common\DebugStr.pas'
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
  eeTextParaCursor in 'w:\common\components\gui\Garant\Everest_Engine\eeTextParaCursor.pas'
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
  eeDocument_Schema in 'w:\common\components\gui\Garant\Everest_Engine\eeDocument_Schema.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  F1_AttrValues in 'w:\common\components\gui\Garant\Everest_Engine\F1_AttrValues.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  F1_Schema in 'w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas'
  {$IfEnd} //Nemesis
  ,
  InsUserSettingsListenerPtrList in 'Data\Settings\InsUserSettingsListenerPtrList.pas',
  InsUserSettingsEditListenerPtrList in 'Data\Settings\InsUserSettingsEditListenerPtrList.pas',
  nsSettings in 'Data\Settings\nsSettings.pas',
  nsContextFilterEventDataList in 'Logging\nsContextFilterEventDataList.pas',
  nsContextFilterEventListener in 'Logging\nsContextFilterEventListener.pas'
  {$If defined(Archi)}
  ,
  arList_Const in 'w:\common\components\gui\Garant\Everest\arList_Const.pas'
  {$IfEnd} //Archi
  
  {$If defined(Archi) AND defined(k2ForEditor)}
  ,
  evList_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evList_InterfaceFactory.pas'
  {$IfEnd} //Archi AND k2ForEditor
  
  {$If defined(Archi)}
  ,
  evArchi_Schema in 'w:\common\components\gui\Garant\Everest\evArchi_Schema.pas'
  {$IfEnd} //Archi
  
  {$If defined(evMyEditor)}
  ,
  My_Schema in 'w:\common\components\gui\Garant\Everest\My_Schema.pas'
  {$IfEnd} //evMyEditor
  
  {$If defined(DesignTimeLibrary)}
  ,
  dsgnTextStyle_Const in 'w:\common\components\gui\Garant\Everest\dsgnTextStyle_Const.pas'
  {$IfEnd} //DesignTimeLibrary
  ,
  Design_AttrValues in 'w:\common\components\gui\Garant\Everest\Design_AttrValues.pas'
  {$If defined(DesignTimeLibrary)}
  ,
  Design_Schema in 'w:\common\components\gui\Garant\Everest\Design_Schema.pas'
  {$IfEnd} //DesignTimeLibrary
  ,
  evdSchema in 'w:\common\components\gui\Garant\Everest\evdSchema.pas',
  Logo_ut_Logo_UserType in 'View\PrimCommon\Forms\Logo_ut_Logo_UserType.pas',
  Logo_Form in 'View\PrimCommon\Forms\Logo_Form.pas' {LogoForm: TvcmEntityForm}
  {$If not defined(NoScripts)}
  ,
  LogoKeywordsPack in 'View\PrimCommon\LogoKeywordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  nsAppTitleData in 'Data\Common\nsAppTitleData.pas',
  f1StartupCompletedService in 'View\PrimCommon\f1StartupCompletedService.pas',
  PrimF1Res in 'View\PrimF1Res.pas',
  nscDocumentHistory in 'Components\nscDocumentHistory.pas',
  nsCustomStyleProcessor in 'f1DocumentTagsImplementation\nsCustomStyleProcessor.pas',
  PrimMain_Form in 'View\PrimMain_Form.pas',
  PrimMainOptions_Form in 'View\PrimMainOptions_Form.pas',
  evTunedEditor in 'w:\common\components\gui\Garant\Everest\evTunedEditor.pas',
  evEditor in 'w:\common\components\gui\Garant\Everest\evEditor.pas',
  evQueryCardEditorHotSpot in 'w:\common\components\gui\Garant\Everest\evQueryCardEditorHotSpot.pas',
  evQueryCardSelection in 'w:\common\components\gui\Garant\Everest\evQueryCardSelection.pas',
  evQueryCardEditor in 'w:\common\components\gui\Garant\Everest\evQueryCardEditor.pas'
  {$If not defined(NoScripts)}
  ,
  QueryCardProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwQueryCardFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwQueryCardFromStackWord.pas'
  {$IfEnd} //not NoScripts
  ,
  evReqIterator in 'w:\common\components\gui\Garant\Everest\evReqIterator.pas'
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeSetWithLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetWithLogicOperation.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardSetAttribute in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardSetAttribute.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeSetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetCollapsed.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeSetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetFocus.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeGetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetFocus.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeGetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetCollapsed.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeGetLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetLogicOperation.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardAttributeIsLogicOperationEnabled in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeIsLogicOperationEnabled.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopQueryCardGetCurrentReqName in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardGetCurrentReqName.pas'
  {$IfEnd} //not NoScripts
  ,
  ConfigInterfaces in 'Model\ConfigInterfaces.pas',
  Search_FormDefinitions_Controls in 'View\Search_FormDefinitions_Controls.pas',
  PrimPrimListInterfaces in 'Search\PrimPrimListInterfaces.pas',
  Search_Strange_Controls in 'View\Search_Strange_Controls.pas',
  PrimSaveLoadUserTypes_slqtKW_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtKW_UserType.pas',
  PrimSaveLoadUserTypes_slqtOldKW_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtOldKW_UserType.pas',
  PrimSaveLoadUserTypes_slqtPublishSource_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtPublishSource_UserType.pas',
  PrimSaveLoadUserTypes_slqtFilters_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtFilters_UserType.pas',
  PrimSaveLoadUserTypes_slqtLegislationReview_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas',
  PrimSaveLoadUserTypes_slqtPostingOrder_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtPostingOrder_UserType.pas',
  PrimSaveLoadUserTypes_slqtConsult_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtConsult_UserType.pas',
  PrimSaveLoadUserTypes_slqtInpharmSearch_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas',
  PrimSaveLoadUserTypes_slqtAttribute_UserType in 'View\Search\Forms\PrimSaveLoadUserTypes_slqtAttribute_UserType.pas',
  SimpleListInterfaces in 'List\SimpleListInterfaces.pas',
  FoldersDomainInterfaces in 'Search\FoldersDomainInterfaces.pas'
  {$If not defined(NoVCM)}
  ,
  vcmItems in 'w:\common\components\gui\Garant\VCM\implementation\vcmItems.pas'
  {$IfEnd} //not NoVCM
  ,
  PrimBaseSearchInterfaces in 'Search\PrimBaseSearchInterfaces.pas',
  PrimWorkJournalInterfaces in 'Search\PrimWorkJournalInterfaces.pas',
  ConsultingUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ConsultingUnit.pas',
  PrimeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\PrimeUnit.pas',
  PrimeDomainInterfaces in 'View\PrimeDomainInterfaces.pas',
  nsPrimeNode in 'View\Search\nsPrimeNode.pas'
  {$If defined(Nemesis)}
  ,
  eeTreeMisc in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeMisc.pas'
  {$IfEnd} //Nemesis
  ,
  nsPostingsLine in 'View\Search\nsPostingsLine.pas',
  nsPostingsTreeSingle in 'View\Search\nsPostingsTreeSingle.pas',
  nsFolders in 'Data\Common\nsFolders.pas',
  nsbQueryUtils in 'Search\nsbQueryUtils.pas',
  nsFolderFilterInfo in 'Search\nsFolderFilterInfo.pas',
  TabbedContainerRes in 'TabInterface\TabbedContainerRes.pas',
  nsTabbedInterfaceTypes in 'TabInterface\nsTabbedInterfaceTypes.pas',
  l3CObjectRefList in 'w:\common\components\rtl\Garant\L3\l3CObjectRefList.pas',
  BaseSearchInterfaces in 'Search\BaseSearchInterfaces.pas',
  ContextHistoryInterfaces in 'rtl\Garant\ContextHistory\ContextHistoryInterfaces.pas',
  nsContextUtils in 'Search\nsContextUtils.pas',
  nsVerifyValue in 'Data\Common\nsVerifyValue.pas',
  nsTreeUtils in 'Data\Tree\nsTreeUtils.pas',
  SystemStr in 'Data\Common\SystemStr.pas',
  nsSearchClasses in 'QueryCardProcessing\nsSearchClasses.pas',
  nsQueryAttribute in 'Search\nsQueryAttribute.pas',
  MonitoringUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\MonitoringUnit.pas',
  nsQueryExecuteProgressIndicator in 'View\LiteSearch\nsQueryExecuteProgressIndicator.pas'
  {$If defined(vcmUseProfilers)}
  ,
  ProfilersInterfaces in 'Model\ProfilersInterfaces.pas'
  {$IfEnd} //vcmUseProfilers
  ,
  nsManagers in 'Data\Common\nsManagers.pas',
  nsQuestions in 'Data\nsQuestions.pas',
  InsContextSearchHistoryNotifierList in 'rtl\Garant\ContextHistory\InsContextSearchHistoryNotifierList.pas',
  nsInpharmContextHistoryPrim in 'rtl\Garant\ContextHistory\nsInpharmContextHistoryPrim.pas',
  nsInpharmContextHistory in 'rtl\Garant\ContextHistory\nsInpharmContextHistory.pas',
  nsDocumentContextHistoryPrim in 'rtl\Garant\ContextHistory\nsDocumentContextHistoryPrim.pas',
  nsDocumentContextHistory in 'rtl\Garant\ContextHistory\nsDocumentContextHistory.pas',
  nsContextHistory in 'rtl\Garant\ContextHistory\nsContextHistory.pas',
  nsDataExchangeProxy in 'Search\nsDataExchangeProxy.pas',
  nsQueryUtils in 'Search\nsQueryUtils.pas',
  PrimSaveLoad_Form in 'View\Search\Forms\PrimSaveLoad_Form.pas',
  PrimSaveLoadOptions_Form in 'View\Search\Forms\PrimSaveLoadOptions_Form.pas',
  PrimSaveLoadOptionsWithUserTypes_Form in 'View\Search\Forms\PrimSaveLoadOptionsWithUserTypes_Form.pas',
  SaveLoad_Form in 'View\Search\Forms\SaveLoad_Form.pas' {cfSaveLoad: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  SaveLoadKeywordsPack in 'View\Search\SaveLoadKeywordsPack.pas'
  {$IfEnd} //not Admin AND not NoScripts
  ,
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
  nsHAFPainterPrim in 'Search\nsHAFPainterPrim.pas',
  nsHAFPainter in 'Search\nsHAFPainter.pas',
  nsFixedHAFMacroReplacer in 'Search\nsFixedHAFMacroReplacer.pas'
  {$If defined(Nemesis)}
  ,
  eeProcessor in 'w:\common\components\gui\Garant\Everest_Engine\eeProcessor.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentPartGenerator.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeSubExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubExport.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainerPrim.pas'
  {$IfEnd} //Nemesis
  ,
  evCommentParaDecorator in 'w:\common\components\gui\Garant\Everest\evCommentParaDecorator.pas',
  evLeafParaDecorationsHolderEliminator in 'w:\common\components\gui\Garant\EverestCommon\evLeafParaDecorationsHolderEliminator.pas',
  evBlocksEliminator in 'w:\common\components\gui\Garant\EverestCommon\evBlocksEliminator.pas',
  evUserCommentFilter in 'w:\common\components\gui\Garant\Everest\evUserCommentFilter.pas',
  evCommentDecorator in 'w:\common\components\gui\Garant\Everest\evCommentDecorator.pas',
  evNestedDocumentEliminator in 'w:\common\components\gui\Garant\Everest\evNestedDocumentEliminator.pas',
  evCommentParaAdder in 'w:\common\components\gui\Garant\Everest\evCommentParaAdder.pas',
  evPageBreakEliminator in 'w:\common\components\gui\Garant\Everest\evPageBreakEliminator.pas',
  evControlParaFilter in 'w:\common\components\gui\Garant\Everest\evControlParaFilter.pas',
  evBlocksButNotCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evBlocksButNotCommentsEliminator.pas',
  evStrictContentsElementEliminator in 'w:\common\components\gui\Garant\EverestCommon\evStrictContentsElementEliminator.pas'
  {$If defined(Nemesis)}
  ,
  eeDocumentContainer in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainer.pas'
  {$IfEnd} //Nemesis
  ,
  evQueryCardDropControlsInt in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardDropControlsInt.pas',
  evCustomControlTool in 'w:\common\components\gui\Garant\Everest\qf\evCustomControlTool.pas',
  evQueryGroupList in 'w:\common\components\gui\Garant\Everest\qf\evQueryGroupList.pas',
  evReqList in 'w:\common\components\gui\Garant\Everest\qf\evReqList.pas',
  evDescriptionReqList in 'w:\common\components\gui\Garant\Everest\qf\evDescriptionReqList.pas',
  evEditorControlList in 'w:\common\components\gui\Garant\Everest\qf\evEditorControlList.pas',
  evEditorControlFieldList in 'w:\common\components\gui\Garant\Everest\qf\evEditorControlFieldList.pas',
  evControl in 'w:\common\components\gui\Garant\Everest\qf\evControl.pas',
  evQueryCardConst in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardConst.pas',
  evButtonControl in 'w:\common\components\gui\Garant\Everest\qf\evButtonControl.pas',
  evEditControl in 'w:\common\components\gui\Garant\Everest\qf\evEditControl.pas',
  evDropControl in 'w:\common\components\gui\Garant\Everest\qf\evDropControl.pas',
  evDropCalendarControl in 'w:\common\components\gui\Garant\Everest\qf\evDropCalendarControl.pas',
  evDropCombo in 'w:\common\components\gui\Garant\Everest\qf\evDropCombo.pas',
  evLabel in 'w:\common\components\gui\Garant\Everest\qf\evLabel.pas',
  evSimpleEdit in 'w:\common\components\gui\Garant\Everest\qf\evSimpleEdit.pas',
  evMemoEdit in 'w:\common\components\gui\Garant\Everest\qf\evMemoEdit.pas',
  evEmailEdit in 'w:\common\components\gui\Garant\Everest\qf\evEmailEdit.pas',
  evPhoneEdit in 'w:\common\components\gui\Garant\Everest\qf\evPhoneEdit.pas'
  {$If defined(k2ForEditor)}
  ,
  evReqRowImplementation in 'w:\common\components\gui\Garant\Everest\evReqRowImplementation.pas'
  {$IfEnd} //k2ForEditor
  ,
  evReq in 'w:\common\components\gui\Garant\Everest\qf\evReq.pas',
  evDescriptionReq in 'w:\common\components\gui\Garant\Everest\qf\evDescriptionReq.pas',
  evControlGroup in 'w:\common\components\gui\Garant\Everest\qf\evControlGroup.pas',
  evControlContainer in 'w:\common\components\gui\Garant\Everest\qf\evControlContainer.pas',
  evDropTree in 'w:\common\components\gui\Garant\Everest\qf\evDropTree.pas',
  evDropCalendar in 'w:\common\components\gui\Garant\Everest\qf\evDropCalendar.pas',
  evControlContainerEX in 'w:\common\components\gui\Garant\Everest\qf\evControlContainerEX.pas',
  MainMenuNewRes in 'View\MainMenuNewRes.pas' {dmMainMenuNew: TDataModule},
  ExternalOperationUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalOperationUnit.pas',
  evQueryCardProcessor in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardProcessor.pas',
  evControlGenerator in 'w:\common\components\gui\Garant\Everest\qf\evControlGenerator.pas',
  evQueryDocumentContainer in 'w:\common\components\gui\Garant\Everest\qf\evQueryDocumentContainer.pas',
  k2IUnknownTag in 'w:\common\components\rtl\Garant\K2\k2IUnknownTag.pas',
  f1QueryDocumentContainer in 'QueryCardProcessing\f1QueryDocumentContainer.pas',
  PrimQueryCard_Form in 'View\Search\Forms\PrimQueryCard_Form.pas',
  PrimQueryCardOptions_Form in 'View\Search\Forms\PrimQueryCardOptions_Form.pas',
  QueryCard_Form in 'View\Search\Forms\QueryCard_Form.pas' {enQueryCard: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  QueryCardKeywordsPack in 'View\Search\QueryCardKeywordsPack.pas'
  {$IfEnd} //not Admin AND not NoScripts
  ,
  vtCustomPreviewPanel in 'w:\common\components\gui\Garant\VT\vtCustomPreviewPanel.pas',
  eePreviewPanel in 'w:\common\components\gui\Garant\Everest_Engine\eePreviewPanel.pas'
  {$If defined(Nemesis)}
  ,
  nscPreviewPanel in 'w:\common\components\gui\Garant\Nemesis\nscPreviewPanel.pas'
  {$IfEnd} //Nemesis
  ,
  Search_ScalingSupport_Controls in 'View\Search_ScalingSupport_Controls.pas',
  PrimPreview_utPrintPreview_UserType in 'View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas',
  nsTrialSupport in 'View\nsTrialSupport.pas',
  PrimPreview_Form in 'View\Search\Forms\PrimPreview_Form.pas',
  Preview_Form in 'View\Search\Forms\Preview_Form.pas' {efPreviewForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PreviewFormKeywordsPack in 'View\Search\PreviewFormKeywordsPack.pas'
  {$IfEnd} //not Admin AND not NoScripts
  
  {$If defined(Nemesis)}
  ,
  nscPageControl in 'w:\common\components\gui\Garant\Nemesis\nscPageControl.pas'
  {$IfEnd} //Nemesis
  ,
  PrimPageSetup_pstNone_UserType in 'View\Search\Forms\PrimPageSetup_pstNone_UserType.pas',
  nsPageSetup in 'View\nsPageSetup.pas',
  PrimPageSetup_Form in 'View\Search\Forms\PrimPageSetup_Form.pas',
  PrimPageSetupOptions_Form in 'View\Search\Forms\PrimPageSetupOptions_Form.pas',
  PageSetup_Form in 'View\Search\Forms\PageSetup_Form.pas' {en_PageSetup: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PageSetupKeywordsPack in 'View\Search\PageSetupKeywordsPack.pas'
  {$IfEnd} //not Admin AND not NoScripts
  ,
  PrimPrintDialog_Form in 'View\Search\Forms\PrimPrintDialog_Form.pas',
  vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas'
  {$If not defined(NoScripts)}
  ,
  SpinEditWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  vtRadioButton in 'w:\common\components\gui\Garant\VT\vtRadioButton.pas',
  PreviewInterfaces in 'Model\PreviewInterfaces.pas',
  l3RangeManager in 'w:\common\components\rtl\Garant\L3\l3RangeManager.pas',
  PrimPrintDialogOptions_Form in 'View\Search\Forms\PrimPrintDialogOptions_Form.pas',
  PrintDialog_ut_PrintDialog_UserType in 'View\Search\Forms\PrintDialog_ut_PrintDialog_UserType.pas',
  PrintDialog_Form in 'View\Search\Forms\PrintDialog_Form.pas' {en_PrintDialog: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PrintDialogKeywordsPack in 'View\Search\PrintDialogKeywordsPack.pas'
  {$IfEnd} //not Admin AND not NoScripts
  ,
  CommonSearch_Module in 'View\Search\CommonSearch_Module.pas',
  moCommonSearch in 'View\Search\moCommonSearch.pas' {mo_CommonSearch: TvcmModule},
  tasSaveLoadRealization in 'View\tasSaveLoadRealization.pas',
  ShellAndMonitoringsRes in 'View\ShellAndMonitoringsRes.pas',
  ShellAndMonitoringsMain_Form in 'View\ShellAndMonitoringsMain_Form.pas',
  AdapterFacade in 'Model\AdapterFacade.pas',
  DocumentInterfaces in 'F1DocumentProcessingInterfaces\DocumentInterfaces.pas',
  F1TagDataProviderInterface in 'f1DocumentTagsImplementation\F1TagDataProviderInterface.pas',
  PrimListInterfaces in 'BusinessInterfaces\PrimListInterfaces.pas',
  DocumentAndListInterfaces in 'BusinessInterfaces\Common\DocumentAndListInterfaces.pas',
  MainWindowInterfaces in 'MainWindowControllers\MainWindowInterfaces.pas',
  nsUnderControlNotificationManager in 'Data\Common\nsUnderControlNotificationManager.pas',
  nsChangeFontSizeEvent in 'View\nsChangeFontSizeEvent.pas',
  nsStyleEditor in 'View\nsStyleEditor.pas',
  nsSettingsUtils in 'View\nsSettingsUtils.pas',
  nsPrimaryMonitorResolutionEvent in 'View\nsPrimaryMonitorResolutionEvent.pas',
  nsDPIEvent in 'View\nsDPIEvent.pas',
  nsFontSizeEvent in 'View\nsFontSizeEvent.pas',
  NemesisMain_utMainWindow_UserType in 'View\NemesisMain_utMainWindow_UserType.pas',
  resWarnImages in 'View\resWarnImages.pas' {nsWarnImages: TDataModule},
  nsForwardEvent in 'View\nsForwardEvent.pas',
  nsBackEvent in 'View\nsBackEvent.pas',
  dsWarning in 'Business\Document\dsWarning.pas',
  WarningUserTypes_Warning_UserType in 'View\WarningUserTypes_Warning_UserType.pas',
  BaloonWarningUserTypes_Fake_UserType in 'View\BaloonWarningUserTypes_Fake_UserType.pas',
  BaloonWarningUserTypes_WarnJuror_UserType in 'View\BaloonWarningUserTypes_WarnJuror_UserType.pas',
  BaloonWarningUserTypes_WarnPreActive_UserType in 'View\BaloonWarningUserTypes_WarnPreActive_UserType.pas',
  BaloonWarningUserTypes_WarnIsAbolished_UserType in 'View\BaloonWarningUserTypes_WarnIsAbolished_UserType.pas',
  BaloonWarningUserTypes_WarnOnControl_UserType in 'View\BaloonWarningUserTypes_WarnOnControl_UserType.pas',
  BaloonWarningUserTypes_WarnInactualDocument_UserType in 'View\BaloonWarningUserTypes_WarnInactualDocument_UserType.pas',
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType in 'View\BaloonWarningUserTypes_WarnTimeMachineOn_UserType.pas',
  BaloonWarningUserTypes_WarnRedaction_UserType in 'View\BaloonWarningUserTypes_WarnRedaction_UserType.pas',
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType in 'View\BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas',
  BaloonWarningUserTypes_WarnTimeMachineException_UserType in 'View\BaloonWarningUserTypes_WarnTimeMachineException_UserType.pas',
  BaloonWarningUserTypes_remListModified_UserType in 'View\BaloonWarningUserTypes_remListModified_UserType.pas',
  BaloonWarningUserTypes_remListFiltered_UserType in 'View\BaloonWarningUserTypes_remListFiltered_UserType.pas',
  BaloonWarningUserTypes_remTimeMachineWarning_UserType in 'View\BaloonWarningUserTypes_remTimeMachineWarning_UserType.pas',
  BaloonWarningUserTypes_remUnreadConsultations_UserType in 'View\BaloonWarningUserTypes_remUnreadConsultations_UserType.pas',
  BaloonWarningUserTypes_remOnlineDead_UserType in 'View\BaloonWarningUserTypes_remOnlineDead_UserType.pas',
  BaloonWarningUserTypes_TrialModeWarning_UserType in 'View\BaloonWarningUserTypes_TrialModeWarning_UserType.pas',
  BaloonWarningUserTypes_OldBaseWarning_UserType in 'View\BaloonWarningUserTypes_OldBaseWarning_UserType.pas',
  BaloonWarningUserTypes_ControlledChangingWarning_UserType in 'View\BaloonWarningUserTypes_ControlledChangingWarning_UserType.pas',
  sdsMainWindow in 'MainWindowControllers\sdsMainWindow.pas',
  NemesisMain_Form in 'View\NemesisMain_Form.pas',
  nsIntegrationSupport in 'View\nsIntegrationSupport.pas'
  {$If defined(Nemesis)}
  ,
  nscReminder in 'w:\common\components\gui\Garant\Nemesis\nscReminder.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineWithState in 'w:\common\components\gui\Garant\VT\vgRemindersLineWithState.pas'
  {$IfEnd} //not NoVGScene
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine in 'w:\common\components\gui\Garant\Nemesis\nscRemindersLine.pas'
  {$IfEnd} //Nemesis
  ,
  ddHTMLWriterRes in 'w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas',
  ddHTMLWriter in 'w:\common\components\rtl\Garant\dd\ddHTMLWriter.pas',
  nsExternalObjectModelPart in 'ExternalObjects\nsExternalObjectModelPart.pas',
  nsExternalObject in 'ExternalObjects\nsExternalObject.pas',
  nsRegistryHelper in 'ExternalObjects\nsRegistryHelper.pas',
  l3WinVersionHelper in 'w:\common\components\rtl\Garant\L3\l3WinVersionHelper.pas',
  nsBrowserInfo in 'ExternalObjects\nsBrowserInfo.pas',
  evCustomPDFWriter in 'w:\common\components\gui\Garant\Everest\evCustomPDFWriter.pas',
  SynCommons in 'w:\common\components\rtl\external\SynPDF\SynCommons.pas',
  SynCrypto in 'w:\common\components\rtl\external\SynPDF\SynCrypto.pas',
  SynZip in 'w:\common\components\rtl\external\SynPDF\SynZip.pas',
  SynGdiPlus in 'w:\common\components\rtl\external\SynPDF\SynGdiPlus.pas',
  SynLZ in 'w:\common\components\rtl\external\SynPDF\SynLZ.pas',
  SynPDF in 'w:\common\components\rtl\external\SynPDF\SynPDF.pas',
  GarantPDFDocument in 'w:\common\components\rtl\external\SynPDF\GarantPDFDocument.pas',
  ddPDFExporter in 'w:\common\components\rtl\Garant\dd\ddPDFExporter.pas',
  nevDocumentProvider4PDF in 'w:\common\components\gui\Garant\Everest\nevDocumentProvider4PDF.pas',
  evPDFWriter in 'w:\common\components\gui\Garant\Everest\evPDFWriter.pas',
  nsDocumentStreamList in 'ExternalObjects\nsDocumentStreamList.pas',
  nsExternalObjectPrim in 'ExternalObjects\nsExternalObjectPrim.pas',
  nsDataResetTree in 'Data\Tree\nsDataResetTree.pas',
  nsRubricatorCache in 'Common\nsRubricatorCache.pas',
  MainMenuDomainInterfaces in 'Common\MainMenuDomainInterfaces.pas',
  nsMainMenuNode in 'Common\nsMainMenuNode.pas',
  nsBaseMainMenuTree in 'Common\nsBaseMainMenuTree.pas',
  MainMenuUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\MainMenuUnit.pas',
  nsOpenUtils in 'Data\Common\nsOpenUtils.pas',
  Common_FormDefinitions_Controls in 'View\Common_FormDefinitions_Controls.pas',
  Common_Rubricator_Controls in 'View\Common_Rubricator_Controls.pas',
  MainOptions_Form in 'View\MainOptions_Form.pas',
  nsNotificationManager in 'Data\Common\nsNotificationManager.pas',
  nsFiltersInterfaces in 'Filters\nsFiltersInterfaces.pas',
  nsFiltersNode in 'Filters\nsFiltersNode.pas',
  nsFiltersListenersList in 'Filters\nsFiltersListenersList.pas',
  nsFiltersListenersManagerPrim in 'Filters\nsFiltersListenersManagerPrim.pas',
  nsFiltersListenersDocManager in 'Filters\nsFiltersListenersDocManager.pas',
  nsFiltersListenersDrugsManager in 'Filters\nsFiltersListenersDrugsManager.pas',
  nsFiltersRootNode in 'Filters\nsFiltersRootNode.pas',
  nsFiltersTree in 'Filters\nsFiltersTree.pas',
  nsFiltersContainerPrim in 'Filters\nsFiltersContainerPrim.pas',
  nsFiltersContainer in 'Filters\nsFiltersContainer.pas',
  nsBaseSearchClassList in 'Search\nsBaseSearchClassList.pas',
  nsBaseSearchClasses in 'Search\nsBaseSearchClasses.pas',
  nsBaseSearchService in 'Search\nsBaseSearchService.pas',
  nsBaseSearchServiceImpl in 'Search\nsBaseSearchServiceImpl.pas',
  nsBaseSearchWindowDataListenerList in 'Search\nsBaseSearchWindowDataListenerList.pas',
  nsBaseSearcherWindowData in 'Search\nsBaseSearcherWindowData.pas',
  nsBaseSearcher in 'Search\nsBaseSearcher.pas',
  evMemo in 'w:\common\components\gui\Garant\Everest\evMemo.pas',
  F1_Without_Usecases_DocumentsCacheOperations_Controls in 'View\F1_Without_Usecases_DocumentsCacheOperations_Controls.pas',
  MemoryUsagePrim_Form in 'View\MemoryUsagePrim_Form.pas',
  MemoryUsage_ut_MemoryUsage_UserType in 'View\MemoryUsage_ut_MemoryUsage_UserType.pas',
  MemoryUsage_Form in 'View\MemoryUsage_Form.pas' {MemoryUsageForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MemoryUsageKeywordsPack in 'View\MemoryUsageKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  l3AsincMessageWindow in 'w:\common\components\rtl\Garant\L3\l3AsincMessageWindow.pas',
  IntegrationProjectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\IntegrationProjectUnit.pas',
  HelpIntfs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\HelpIntfs.pas' {$EndIf},
  nsConfiguration in 'View\nsConfiguration.pas',
  Main_Form in 'View\Main_Form.pas',
  MainWithReminders_Form in 'View\MainWithReminders_Form.pas',
  MainWindow_Form in 'View\MainWindow_Form.pas' {nsMainWindow: TvcmMainForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MainWindowKeywordsPack in 'View\MainWindowKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  MedicMainMenuRes in 'View\MedicMainMenuRes.pas' {dmMedicMainMenuRes: TDataModule},
  nsHooks in 'View\nsHooks.pas',
  PrimNemesisRes in 'View\PrimNemesisRes.pas'
  {$If defined(Nemesis)}
  ,
  eeDocumentTool in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentTool.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeSub in 'w:\common\components\gui\Garant\Everest_Engine\eeSub.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeHotSpot in 'w:\common\components\gui\Garant\Everest_Engine\eeHotSpot.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(evNeedDisp)}
  ,
  evStandardActions in 'w:\common\components\gui\Garant\Everest\evStandardActions.pas'
  {$IfEnd} //evNeedDisp
  ,
  eeEditorExportModelPart in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExportModelPart.pas',
  vtScrollBar in 'w:\common\components\gui\Garant\VT\vtScrollBar.pas',
  eeExceptions in 'w:\common\components\gui\Garant\Everest_Engine\eeExceptions.pas'
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSourceExport.pas'
  {$IfEnd} //Nemesis
  ,
  eeEditorExport in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExport.pas',
  eeEditor in 'w:\common\components\gui\Garant\Everest_Engine\eeEditor.pas'
  {$If defined(Nemesis)}
  ,
  nscEditor in 'w:\common\components\gui\Garant\Nemesis\nscEditor.pas'
  {$IfEnd} //Nemesis
  ,
  EditionsInterfaces in 'Editions\EditionsInterfaces.pas',
  evSubWaiter in 'w:\common\components\gui\Garant\Everest\new\evSubWaiter.pas',
  Base_Operations_Editions_Controls in 'View\Base_Operations_Editions_Controls.pas',
  Base_Operations_View_Controls in 'View\Base_Operations_View_Controls.pas',
  NavigationInterfaces in 'View\NavigationInterfaces.pas',
  CompareEditions_Controls in 'View\CompareEditions_Controls.pas',
  DocumentRes in 'Business\Document\DocumentRes.pas' {nsDocumentRes: TDataModule},
  DocumentDomainInterfaces in 'Model\DocumentDomainInterfaces.pas'
  {$If not defined(NoScripts)}
  ,
  tfwDefaultScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDefaultScriptCaller.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwHyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwHyperlinkScriptCaller.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwF1HyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwF1HyperlinkScriptCaller.pas'
  {$IfEnd} //not NoScripts
  ,
  bsHyperLinkProcessorPrim in 'View\bsHyperLinkProcessorPrim.pas',
  nsHyperlinkProcessorTypes in 'View\nsHyperlinkProcessorTypes.pas',
  bsHyperlinkProcessorContainerMaker in 'View\bsHyperlinkProcessorContainerMaker.pas',
  bsDocumentMissingMessage in 'Common\bsDocumentMissingMessage.pas',
  Base_Operations_Strange_Controls in 'View\Base_Operations_Strange_Controls.pas',
  nsExternalObjectData in 'Common\nsExternalObjectData.pas',
  nsENOIntegration in 'Data\Common\nsENOIntegration.pas',
  WarningConst in 'View\WarningConst.pas',
  nsOpenDocumentFromLinkEvent in 'View\nsOpenDocumentFromLinkEvent.pas',
  nsTryingToOpenMissingDocumentFromLinkEvent in 'View\nsTryingToOpenMissingDocumentFromLinkEvent.pas',
  nsHyperLinkProcessor in 'View\nsHyperLinkProcessor.pas'
  {$If not defined(NoScripts)}
  ,
  F1ScriptEngine in 'ScriptEngine\F1ScriptEngine.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  seModalWorker in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorker.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  seModalWorkerListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerListPrim.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  seModalWorkerList in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  seModalSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seModalSupport.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  CodeFlowWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeFlowWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwNewWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwNewWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFORWARD in 'w:\common\components\rtl\Garant\ScriptEngine\kwFORWARD.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  CompilationPack in 'w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStandardProcedureCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwStandardProcedureCloseBracket.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordWorkerWordRunner in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordRunner.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordWorkerWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWordWorkerWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedure.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwKeyValuesPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyValuesPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwKeyValues in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyValues.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledProcedureWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledProcedureWithStackChecking in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledFunction in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledFunction.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwInlinedWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwInlinedWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\tfwProcedure.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  WordsDefinitionPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsDefinitionPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncluded.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIncludeLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIncludeLike.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwUsesLike in 'w:\common\components\rtl\Garant\ScriptEngine\kwUsesLike.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwInclude in 'w:\common\components\rtl\Garant\ScriptEngine\kwInclude.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwUses in 'w:\common\components\rtl\Garant\ScriptEngine\kwUses.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  IncludesAndUsesPack in 'w:\common\components\rtl\Garant\ScriptEngine\IncludesAndUsesPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCheckOutputWithInput in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckOutputWithInput.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCheckEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckEtalon.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTestResolveInputFilePath in 'w:\common\components\rtl\Garant\ScriptEngine\kwTestResolveInputFilePath.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  EtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSendInputSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupport.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseUpDownSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseUpDownSupport.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseLeftDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseLeftUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftUp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseMiddleUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleUp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseMiddleDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseRightUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightUp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseRightDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseSetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseSetCursorPosition.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseGetCursorIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseGetCursorNameByIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorNameByIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseGetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorPosition.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseWheelSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelSupport.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseWheelUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelUp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMouseWheelDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelDown.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  MouseInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\MouseInputPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWasWait in 'w:\common\components\rtl\Garant\ScriptEngine\kwWasWait.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWaitNo in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitNo.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWaitOk in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitOk.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWaitYes in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitYes.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWaitCancel in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitCancel.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwWaitChoice in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitChoice.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  ModalDialogsKeywordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ModalDialogsKeywordsPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKey in 'w:\common\components\rtl\Garant\ScriptEngine\kwKey.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwHardKey in 'w:\common\components\rtl\Garant\ScriptEngine\kwHardKey.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyDown.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyUp.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  KeyboardInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyboardInputPack.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledRules in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledRules.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRULES in 'w:\common\components\rtl\Garant\ScriptEngine\kwRULES.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledIF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIF.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIfElse.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwIfElse.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwElse.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledCase in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCase.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCASE in 'w:\common\components\rtl\Garant\ScriptEngine\kwCASE.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDEFAULT in 'w:\common\components\rtl\Garant\ScriptEngine\kwDEFAULT.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwRAISE in 'w:\common\components\rtl\Garant\ScriptEngine\kwRAISE.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwBracketEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketEnd.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTypedBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTypedBeginLikeCompiledCode.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwBracketBegin in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketBegin.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwBEGIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwBEGIN.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  CodeBranchingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeBranchingPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMainCodeController in 'w:\common\components\rtl\Garant\ScriptEngine\kwMainCodeController.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileAndProcess.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileAndProcess.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledScriptCompileStringAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileStringAndProcess.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwScriptCompileStringAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileStringAndProcess.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ScriptsCompilingAndProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScriptsCompilingAndProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  CommCtrl {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\CommCtrl.pas' {$EndIf}
  {$If not defined(NoScripts) AND not defined(NoWindows)}
  ,
  WinUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinUtilsPack.pas'
  {$IfEnd} //not NoScripts AND not NoWindows
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineEX.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDocumentsCacheClear in 'F1_Words\kwDocumentsCacheClear.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTimeMachineSetDate in 'F1_Words\kwTimeMachineSetDate.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwExportHelp in 'F1_Words\kwExportHelp.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwFiltersList in 'F1_Words\kwFiltersList.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwF1BaseDate in 'F1_Words\kwF1BaseDate.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwAttributeSearch in 'F1_Words\kwAttributeSearch.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwOk in 'F1_Words\kwOk.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwMainMenu in 'F1_Words\kwMainMenu.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwF1ComplectName in 'F1_Words\kwF1ComplectName.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwF1ComplectOwner in 'F1_Words\kwF1ComplectOwner.pas'
  {$IfEnd} //not NoScripts
  ,
  nsConfigurationList in 'Config\nsConfigurationList.pas'
  {$If not defined(NoScripts)}
  ,
  kwRestoreSettings in 'F1_Words\kwRestoreSettings.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwClearContextSearchHistory in 'F1_Words\kwClearContextSearchHistory.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwClearDocumentContextSearchHistory in 'F1_Words\kwClearDocumentContextSearchHistory.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwClearPharmContextSearchHistory in 'F1_Words\kwClearPharmContextSearchHistory.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPermanentFilterExists in 'F1_Words\kwPermanentFilterExists.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIsPharmPermanentFilterExists in 'F1_Words\kwIsPharmPermanentFilterExists.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIsLegalPermanentFilterExists in 'F1_Words\kwIsLegalPermanentFilterExists.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIsMyDocumentsEmpty in 'F1_Words\kwIsMyDocumentsEmpty.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationsWord in 'F1_Words\kwConfigurationsWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationsGetCount in 'F1_Words\kwConfigurationsGetCount.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationsGetConfiguration in 'F1_Words\kwConfigurationsGetConfiguration.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationWord in 'F1_Words\kwConfigurationWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationGetName in 'F1_Words\kwConfigurationGetName.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationGetType in 'F1_Words\kwConfigurationGetType.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationsGetActiveConfiguration in 'F1_Words\kwConfigurationsGetActiveConfiguration.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationActivate in 'F1_Words\kwConfigurationActivate.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigurationGetID in 'F1_Words\kwConfigurationGetID.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  f1WordsPack in 'F1_Words\f1WordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwOpenDocument in 'F1_Words\kwOpenDocument.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwF1ImportConsultation in 'F1_Shell_Words\kwF1ImportConsultation.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwConfigRestore in 'F1_Shell_Words\kwConfigRestore.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwStyleTableRestore in 'F1_Shell_Words\kwStyleTableRestore.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwFormFromControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwFormFromControlWord.pas'
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  kwDiffFormWord in 'F1_Shell_Words\kwDiffFormWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDiffIteratorWord in 'F1_Shell_Words\kwDiffIteratorWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDiffIteratorHasNext in 'F1_Shell_Words\kwDiffIteratorHasNext.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDiffIteratorNext in 'F1_Shell_Words\kwDiffIteratorNext.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDiffIteratorHasPrev in 'F1_Shell_Words\kwDiffIteratorHasPrev.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDiffIteratorPrev in 'F1_Shell_Words\kwDiffIteratorPrev.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(Nemesis)}
  ,
  eeTextSource in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSource.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource in 'w:\common\components\gui\Garant\Nemesis\nscTextSource.pas'
  {$IfEnd} //Nemesis
  ,
  Base_Operations_F1Specific_Controls in 'View\Base_Operations_F1Specific_Controls.pas'
  {$If defined(Nemesis)}
  ,
  eeParaTools in 'w:\common\components\gui\Garant\Everest_Engine\eeParaTools.pas'
  {$IfEnd} //Nemesis
  ,
  Common_Strange_Controls in 'View\Common_Strange_Controls.pas',
  nsDocumentPreviewWithoutBlockNames in 'Search\nsDocumentPreviewWithoutBlockNames.pas',
  nsDocumentTools in 'Common\nsDocumentTools.pas',
  nsToMSWordOp in 'View\Common\nsToMSWordOp.pas',
  nsExportToFileEvent in 'View\nsExportToFileEvent.pas',
  nsExportToWordEvent in 'View\nsExportToWordEvent.pas',
  nsSendDocumentByEMailEvent in 'View\nsSendDocumentByEMailEvent.pas',
  nsDocumentPrintPreviewEvent in 'View\nsDocumentPrintPreviewEvent.pas',
  nsBaseTextOperationsConst in 'View\nsBaseTextOperationsConst.pas',
  f1MultilinkResolver in 'F1DocumentProcessing\f1MultilinkResolver.pas',
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
  nsSearchInDocumentDoneEvent in 'View\nsSearchInDocumentDoneEvent.pas',
  nsSearchInDocumentNextEvent in 'View\nsSearchInDocumentNextEvent.pas',
  nsSearchInDocumentPrevEvent in 'View\nsSearchInDocumentPrevEvent.pas',
  nsSearchWindowManager in 'Search\nsSearchWindowManager.pas',
  evSubPanelSub in 'w:\common\components\gui\Garant\Everest\evSubPanelSub.pas',
  evSubPanelTools in 'w:\common\components\gui\Garant\Everest\evSubPanelTools.pas',
  evSubPanelSubArrayPrim in 'w:\common\components\gui\Garant\Everest\evSubPanelSubArrayPrim.pas',
  evSubPanelSubArray in 'w:\common\components\gui\Garant\Everest\evSubPanelSubArray.pas',
  evSubPanelSubCollectionPrim in 'w:\common\components\gui\Garant\Everest\evSubPanelSubCollectionPrim.pas',
  evSubPanelSubCollection in 'w:\common\components\gui\Garant\Everest\evSubPanelSubCollection.pas',
  l3ProtoObjectWithHandle in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithHandle.pas',
  l3ProtoPersistentWithHandle in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandle.pas',
  l3ProtoPersistentWithHandleRefListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandleRefListPrim.pas',
  l3ProtoPersistentWithHandleRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandleRefList.pas',
  evVisualInterfaces in 'w:\common\components\gui\Garant\Everest\evVisualInterfaces.pas',
  evToolPanel in 'w:\common\components\gui\Garant\Everest\evToolPanel.pas',
  evLinkedToolPanel in 'w:\common\components\gui\Garant\Everest\evLinkedToolPanel.pas'
  {$If not defined(NoScripts)}
  ,
  SubPanelWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SubPanelWordsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubDescriptorFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubDescriptorFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubdescriptorGetDrawType in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetDrawType.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubdescriptorGetBitmapIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetBitmapIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubdescriptorGetBlockBitmapIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetBlockBitmapIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubdescriptorGetDocumentBitmapIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetDocumentBitmapIndex.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubdescriptorGetVisible in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetVisible.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubdescriptorGetColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetColumn.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIterateSubDecriptorsOnSubPanel in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanel.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIterateSubDecriptorsOnSubPanelEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanelEX.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwSubPanelGetPopupMenuForSub in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubPanelGetPopupMenuForSub.pas'
  {$IfEnd} //not NoScripts
  ,
  evSubPn in 'w:\common\components\gui\Garant\Everest\evSubPn.pas'
  {$If not defined(NoScripts)}
  ,
  kwSubPanelFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubPanelFromStackWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIterateSubDescriptors in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDescriptors.pas'
  {$IfEnd} //not NoScripts
  ,
  evFont in 'w:\common\components\gui\Garant\Everest\evFont.pas',
  l3ObjectWithHandleRefListPrim in 'w:\common\components\rtl\Garant\L3\l3ObjectWithHandleRefListPrim.pas',
  evSubPanel in 'w:\common\components\gui\Garant\Everest\evSubPanel.pas'
  {$If defined(Nemesis)}
  ,
  eeSubDescriptorsExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubDescriptorsExport.pas'
  {$IfEnd} //Nemesis
  ,
  eeSubPanelExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubPanelExport.pas',
  eeSubPanel in 'w:\common\components\gui\Garant\Everest_Engine\eeSubPanel.pas',
  DocumentUserTypes_dftAACRight_UserType in 'View\DocumentUserTypes_dftAACRight_UserType.pas',
  DocumentUserTypes_dftAACContentsLeft_UserType in 'View\DocumentUserTypes_dftAACContentsLeft_UserType.pas',
  DocumentUserTypes_dftAACContentsRight_UserType in 'View\DocumentUserTypes_dftAACContentsRight_UserType.pas',
  DocumentUserTypes_dftChronology_UserType in 'View\DocumentUserTypes_dftChronology_UserType.pas',
  DocumentUserTypes_dftNone_UserType in 'View\DocumentUserTypes_dftNone_UserType.pas',
  DocumentUserTypes_dftDocument_UserType in 'View\DocumentUserTypes_dftDocument_UserType.pas',
  DocumentUserTypes_dftRelatedDoc_UserType in 'View\DocumentUserTypes_dftRelatedDoc_UserType.pas',
  DocumentUserTypes_dftDocSynchroView_UserType in 'View\DocumentUserTypes_dftDocSynchroView_UserType.pas',
  DocumentUserTypes_dftRelatedSynchroView_UserType in 'View\DocumentUserTypes_dftRelatedSynchroView_UserType.pas',
  DocumentUserTypes_dftDictEntry_UserType in 'View\DocumentUserTypes_dftDictEntry_UserType.pas',
  DocumentUserTypes_dftDictSubEntry_UserType in 'View\DocumentUserTypes_dftDictSubEntry_UserType.pas',
  DocumentUserTypes_dftAnnotation_UserType in 'View\DocumentUserTypes_dftAnnotation_UserType.pas',
  DocumentUserTypes_dftAutoreferatAfterSearch_UserType in 'View\DocumentUserTypes_dftAutoreferatAfterSearch_UserType.pas',
  DocumentUserTypes_dftConsultation_UserType in 'View\DocumentUserTypes_dftConsultation_UserType.pas',
  DocumentUserTypes_dftTranslation_UserType in 'View\DocumentUserTypes_dftTranslation_UserType.pas',
  DocumentUserTypes_dftAnnotationSynchroView_UserType in 'View\DocumentUserTypes_dftAnnotationSynchroView_UserType.pas',
  DocumentUserTypes_dftTips_UserType in 'View\DocumentUserTypes_dftTips_UserType.pas',
  DocumentUserTypes_dftMedDictEntry_UserType in 'View\DocumentUserTypes_dftMedDictEntry_UserType.pas',
  DocumentUserTypes_dftAutoreferat_UserType in 'View\DocumentUserTypes_dftAutoreferat_UserType.pas',
  DocumentUserTypes_dftDrug_UserType in 'View\DocumentUserTypes_dftDrug_UserType.pas',
  DocumentUserTypes_dftMedicFirm_UserType in 'View\DocumentUserTypes_dftMedicFirm_UserType.pas',
  DocumentUserTypes_dftMedicFirmSynchroView_UserType in 'View\DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas',
  DocumentUserTypes_dftDrugSynchroView_UserType in 'View\DocumentUserTypes_dftDrugSynchroView_UserType.pas',
  DocumentUserTypes_dftAACLeft_UserType in 'View\DocumentUserTypes_dftAACLeft_UserType.pas',
  Document_Strange_Controls in 'View\Document_Strange_Controls.pas',
  nsTimeMachineOffEvent in 'View\Document\nsTimeMachineOffEvent.pas',
  Document_F1Lite_Controls in 'View\Document_F1Lite_Controls.pas',
  nevContainers in 'w:\common\components\gui\Garant\Everest\nevContainers.pas',
  ConsultationDomainInterfaces in 'Consultation\ConsultationDomainInterfaces.pas',
  DictionInterfacesPrim in 'CommonDiction\DictionInterfacesPrim.pas',
  InpharmInterfaces in 'Medic\InpharmInterfaces.pas',
  nsFoundBlocksList in 'View\nsFoundBlocksList.pas',
  BaseDocumentWithAttributesInterfaces in 'BusinessInterfaces\BaseDocumentWithAttributesInterfaces.pas',
  nsDocumentFromListNavigationEvent in 'View\nsDocumentFromListNavigationEvent.pas'
  {$If defined(Nemesis)}
  ,
  nscStatusBarDelimiterDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarDelimiterDef.pas'
  {$IfEnd} //Nemesis
  ,
  DocumentUtil in 'View\DocumentUtil.pas',
  UnderControlInterfaces in 'UnderControl\UnderControlInterfaces.pas',
  Hypertext_Controls_Controls in 'LinksToGarant\Hypertext_Controls_Controls.pas',
  evConstStringStorable in 'w:\common\components\gui\Garant\Everest\evConstStringStorable.pas',
  evdTextToFirstParaAdder in 'w:\common\components\rtl\Garant\EVD\evdTextToFirstParaAdder.pas',
  evConstStringDataObject in 'w:\common\components\gui\Garant\Everest\evConstStringDataObject.pas',
  evConstStringData in 'w:\common\components\gui\Garant\EverestCommon\evConstStringData.pas',
  evdHyperlinkInfo in 'w:\common\components\rtl\Garant\EVD\evdHyperlinkInfo.pas',
  nsHyperlinkToDocumentProducerConst in 'LinksToGarant\nsHyperlinkToDocumentProducerConst.pas',
  DocInfoInterfaces in 'BusinessInterfaces\DocInfoInterfaces.pas',
  WorkWithDocumentInterfaces in 'BusinessInterfaces\WorkWithDocumentInterfaces.pas',
  bsChangeRedationWorker in 'Data\Common\bsChangeRedationWorker.pas',
  nsSwitchVersionCommentsEvent in 'View\Document\nsSwitchVersionCommentsEvent.pas',
  nsTextTabActivateEvent in 'View\Document\nsTextTabActivateEvent.pas',
  nsCounterEvent in 'Logging\nsCounterEvent.pas',
  nsUseDocumentSubPanelOperationEvent in 'View\Document\nsUseDocumentSubPanelOperationEvent.pas',
  deSimpleTree in 'Business\Document\deSimpleTree.pas',
  ControlStatusUtils in 'UnderControl\ControlStatusUtils.pas',
  nsInternalPictureData in 'View\Document\nsInternalPictureData.pas',
  Base_Operations_AAC_Controls in 'View\Base_Operations_AAC_Controls.pas',
  AACContainerPrim_AACContainer_UserType in 'View\AAC\Forms\AACContainerPrim_AACContainer_UserType.pas',
  AACContainerPrim_AACContentsContainer_UserType in 'View\AAC\Forms\AACContainerPrim_AACContentsContainer_UserType.pas',
  AACContainerPrim_Form in 'View\AAC\Forms\AACContainerPrim_Form.pas',
  AACTextContainerPrim_Form in 'View\AAC\Forms\AACTextContainerPrim_Form.pas',
  ExText_Form in 'View\Document\Forms\ExText_Form.pas'
  {$If not defined(NoScripts)}
  ,
  kwExTextFormWord in 'F1_Shell_Words\kwExTextFormWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  kwTextFormSetNeedShowIntranetWarning in 'F1_Shell_Words\kwTextFormSetNeedShowIntranetWarning.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwTextFormGetDocumentID in 'F1_Shell_Words\kwTextFormGetDocumentID.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwOpenSituationCard in 'F1_Shell_Words\kwOpenSituationCard.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwOpenOldSituationCard in 'F1_Shell_Words\kwOpenOldSituationCard.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwQueryCardFormWord in 'F1_Shell_Words\kwQueryCardFormWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwQueryCardSetCanSaveState in 'F1_Shell_Words\kwQueryCardSetCanSaveState.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwDocumentLikeState in 'F1_Shell_Words\kwDocumentLikeState.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwGetEncryptedComplectId in 'F1_Shell_Words\kwGetEncryptedComplectId.pas'
  {$IfEnd} //not NoScripts
  ,
  AutoreferatInterfaces in 'Autoreferat\AutoreferatInterfaces.pas',
  PrimeInterfaces in 'Common\PrimeInterfaces.pas',
  Autoreferat_InternalOperations_Controls in 'View\Autoreferat_InternalOperations_Controls.pas',
  nscTreeViewForNewsLine in 'View\Tree\nscTreeViewForNewsLine.pas',
  PrimNewsLine_nltMain_UserType in 'View\Search\Forms\PrimNewsLine_nltMain_UserType.pas',
  nsNewsLine in 'View\Search\nsNewsLine.pas',
  PrimNewsLine_Form in 'View\Search\Forms\PrimNewsLine_Form.pas',
  PrimNewsLineOptions_Form in 'View\Search\Forms\PrimNewsLineOptions_Form.pas',
  NewsLine_Form in 'View\Search\Forms\NewsLine_Form.pas' {enNewsLine: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  NewsLineKeywordsPack in 'View\Search\NewsLineKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  fsAutoreferat in 'View\Search\fsAutoreferat.pas' {fs_Autoreferat: TvcmFormSetFactory},
  fsAutoreferatAfterSearch in 'View\Search\fsAutoreferatAfterSearch.pas' {fs_AutoreferatAfterSearch: TvcmFormSetFactory}
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceRef.pas'
  {$IfEnd} //not NoVCM
  ,
  bsBase in 'F1DocumentProcessing\bsBase.pas',
  deBase in 'F1DocumentProcessing\deBase.pas',
  bsDataContainer in 'F1DocumentProcessing\bsDataContainer.pas',
  deDocInfo in 'F1DocumentProcessing\deDocInfo.pas',
  WorkWithListInterfaces in 'BusinessInterfaces\WorkWithListInterfaces.pas',
  nsDocumentLikeStateHolder in 'Business\Document\nsDocumentLikeStateHolder.pas',
  nsDocInfoHAFMacroReplacer in 'Business\Document\nsDocInfoHAFMacroReplacer.pas',
  evHolderDataObject in 'w:\common\components\gui\Garant\Everest\evHolderDataObject.pas',
  nsDocumentToolsNew in 'F1DocumentProcessing\nsDocumentToolsNew.pas',
  nsString in 'f1DocumentTagsImplementation\nsString.pas',
  nsTagString in 'f1DocumentTagsImplementation\nsTagString.pas',
  k2HugeTagObject in 'w:\common\components\rtl\Garant\K2\k2HugeTagObject.pas',
  nsBaseTagNode in 'f1DocumentTagsImplementation\nsBaseTagNode.pas',
  nsTagNodePrimPrim in 'f1DocumentTagsImplementation\nsTagNodePrimPrim.pas',
  evdVer in 'w:\common\components\rtl\Garant\EVD\evdVer.pas',
  k2InPlaceGenerator in 'w:\common\components\rtl\Garant\K2\k2InPlaceGenerator.pas',
  evNestedCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evNestedCommentsEliminator.pas',
  nsStyleParser in 'f1DocumentTagsImplementation\nsStyleParser.pas',
  nsTagNodePrim in 'f1DocumentTagsImplementation\nsTagNodePrim.pas',
  nsSubNode in 'f1DocumentTagsImplementation\nsSubNode.pas',
  f1AtomChecker in 'f1DocumentTagsImplementation\f1AtomChecker.pas',
  nsLeafParaNode in 'f1DocumentTagsImplementation\nsLeafParaNode.pas',
  nsSectionBreakNode in 'f1DocumentTagsImplementation\nsSectionBreakNode.pas',
  nsTextParaNode in 'f1DocumentTagsImplementation\nsTextParaNode.pas',
  nsControlParaNode in 'f1DocumentTagsImplementation\nsControlParaNode.pas',
  nsBitmapParaNode in 'f1DocumentTagsImplementation\nsBitmapParaNode.pas',
  nsReqCellNode in 'f1DocumentTagsImplementation\nsReqCellNode.pas',
  nsReqRowNode in 'f1DocumentTagsImplementation\nsReqRowNode.pas',
  nsBlockNode in 'f1DocumentTagsImplementation\nsBlockNode.pas',
  nsParentedTagNode in 'f1DocumentTagsImplementation\nsParentedTagNode.pas',
  nsNativeCommentPara in 'f1DocumentTagsImplementation\nsNativeCommentPara.pas',
  nsLeafParaDecorationsHolder in 'f1DocumentTagsImplementation\nsLeafParaDecorationsHolder.pas',
  nsParaListNodeModelPart in 'f1DocumentTagsImplementation\nsParaListNodeModelPart.pas',
  f1ChildMaker in 'f1DocumentTagsImplementation\f1ChildMaker.pas',
  nsCommentMemoryStream in 'f1DocumentTagsImplementation\nsCommentMemoryStream.pas',
  LegalDomain_DocumentNotifications_Controls in 'View\LegalDomain_DocumentNotifications_Controls.pas',
  nsCommentStorer in 'f1DocumentTagsImplementation\nsCommentStorer.pas',
  nsParaListNode in 'f1DocumentTagsImplementation\nsParaListNode.pas',
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
  nsIDocumentDataObject in 'F1DocumentProcessing\nsIDocumentDataObject.pas',
  nsDocumentPrintEvent in 'F1DocumentProcessing\nsDocumentPrintEvent.pas',
  nsAnnotationHeaderTagData in 'Autoreferat\nsAnnotationHeaderTagData.pas',
  nsAnnotationHeaderTagNode in 'Autoreferat\nsAnnotationHeaderTagNode.pas',
  nsF1AutoreferatDocumentTagNode in 'Autoreferat\nsF1AutoreferatDocumentTagNode.pas',
  nsAutoreferatDocumentContainer in 'Autoreferat\nsAutoreferatDocumentContainer.pas',
  dsAutoreferat in 'Autoreferat\dsAutoreferat.pas',
  dsNewsLine in 'Autoreferat\dsNewsLine.pas',
  dBaseDocument in 'Business\Document\dBaseDocument.pas',
  sdsAutoreferat in 'Autoreferat\sdsAutoreferat.pas',
  PostingOrder_FormDefinitions_Controls in 'View\PostingOrder_FormDefinitions_Controls.pas',
  PostingOrder_Strange_Controls in 'View\PostingOrder_Strange_Controls.pas',
  PrimPostingsList_MyPostingList_UserType in 'View\Monitorings\Forms\PrimPostingsList_MyPostingList_UserType.pas',
  vtSaveDialog in 'w:\common\components\gui\Garant\VT\vtSaveDialog.pas',
  PrimPostingsList_Form in 'View\Monitorings\Forms\PrimPostingsList_Form.pas',
  PrimPostingsListOptions_Form in 'View\Monitorings\Forms\PrimPostingsListOptions_Form.pas',
  PostingsList_Form in 'View\Monitorings\Forms\PostingsList_Form.pas' {enPostingsList: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PostingsListKeywordsPack in 'View\Monitorings\PostingsListKeywordsPack.pas'
  {$IfEnd} //not Admin AND not NoScripts
  
  {$If not defined(NoVCL)}
  ,
  FileCtrl {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\FileCtrl.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  nsFindSelectDialog in 'View\Monitorings\nsFindSelectDialog.pas'
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  kw_CommonPost_opSavePostList in 'View\Monitorings\kw_CommonPost_opSavePostList.pas'
  {$IfEnd} //not Admin AND not NoScripts
  ,
  CommonPost_Module in 'View\Monitorings\CommonPost_Module.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Monitorings_opOpenNewsLine in 'View\Search\kw_Monitorings_opOpenNewsLine.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Monitorings_opOpenLegislationReview in 'View\Search\kw_Monitorings_opOpenLegislationReview.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimMonitorings_Module in 'View\Search\PrimMonitorings_Module.pas'
  {$If not defined(NoScripts)}
  ,
  kwOpenPrimeForm in 'F1_Shell_Words\kwOpenPrimeForm.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  F1ShellWordsPack in 'F1_Shell_Words\F1ShellWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  WorkWithList_StatusBar_Controls in 'View\WorkWithList_StatusBar_Controls.pas',
  ListUserTypes_lftRespondent_UserType in 'View\ListUserTypes_lftRespondent_UserType.pas',
  ListUserTypes_lftCorrespondent_UserType in 'View\ListUserTypes_lftCorrespondent_UserType.pas',
  ListUserTypes_lftSynchroView_UserType in 'View\ListUserTypes_lftSynchroView_UserType.pas',
  ListUserTypes_lftCToPart_UserType in 'View\ListUserTypes_lftCToPart_UserType.pas',
  ListUserTypes_lftUserCR1_UserType in 'View\ListUserTypes_lftUserCR1_UserType.pas',
  ListUserTypes_lftUserCR2_UserType in 'View\ListUserTypes_lftUserCR2_UserType.pas',
  ListUserTypes_lftConsultation_UserType in 'View\ListUserTypes_lftConsultation_UserType.pas',
  ListUserTypes_lftSimilarDocuments_UserType in 'View\ListUserTypes_lftSimilarDocuments_UserType.pas',
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType in 'View\ListUserTypes_lftSimilarDocumentsSynchroView_UserType.pas',
  ListUserTypes_lftCorrespondentsSynchroForm_UserType in 'View\ListUserTypes_lftCorrespondentsSynchroForm_UserType.pas',
  ListUserTypes_lftRespondentsSynchroForm_UserType in 'View\ListUserTypes_lftRespondentsSynchroForm_UserType.pas',
  ListUserTypes_lftUserCRList1_SynchorForm_UserType in 'View\ListUserTypes_lftUserCRList1_SynchorForm_UserType.pas',
  ListUserTypes_lftUserCRList2_SynchorForm_UserType in 'View\ListUserTypes_lftUserCRList2_SynchorForm_UserType.pas',
  ListUserTypes_lftDrugList_UserType in 'View\ListUserTypes_lftDrugList_UserType.pas',
  ListUserTypes_lftDrugInternationalNameSynonyms_UserType in 'View\ListUserTypes_lftDrugInternationalNameSynonyms_UserType.pas',
  ListUserTypes_lftProducedDrugs_UserType in 'View\ListUserTypes_lftProducedDrugs_UserType.pas',
  ListUserTypes_lftProducedDrugsSynchroForm_UserType in 'View\ListUserTypes_lftProducedDrugsSynchroForm_UserType.pas',
  ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType in 'View\ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas',
  ListUserTypes_lftRToPart_UserType in 'View\ListUserTypes_lftRToPart_UserType.pas',
  ListUserTypes_lftSimilarDocumentsToFragment_UserType in 'View\ListUserTypes_lftSimilarDocumentsToFragment_UserType.pas',
  ListUserTypes_lftNone_UserType in 'View\ListUserTypes_lftNone_UserType.pas',
  WorkWithList_ListOperations_Controls in 'View\WorkWithList_ListOperations_Controls.pas',
  nscDocumentListTreeView in 'Components\nscDocumentListTreeView.pas'
  {$If defined(Nemesis)}
  ,
  eeGroupBox in 'w:\common\components\gui\Garant\Nemesis\eeGroupBox.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCL)}
  ,
  CommDlg {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CommDlg.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  nsSaveDialog in 'Common\nsSaveDialog.pas',
  deList in 'Search\deList.pas',
  nsListEvents in 'View\List\nsListEvents.pas',
  ListRes in 'Business\List\ListRes.pas' {nsListRes: TDataModule},
  nsTabbedContainerUtils in 'TabInterface\nsTabbedContainerUtils.pas',
  PrimList_Form in 'View\List\Forms\PrimList_Form.pas',
  nsListSortTypeMap in 'View\List\nsListSortTypeMap.pas',
  nsListExceptions in 'Business\Document\nsListExceptions.pas',
  PrimListOptions_Form in 'View\List\Forms\PrimListOptions_Form.pas'
  {$If not defined(NoScripts)}
  ,
  kwNscTreeViewWord in 'F1_Shell_Words\kwNscTreeViewWord.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwPopTreeViewExportSelectionWithFormat in 'F1_Shell_Words\kwPopTreeViewExportSelectionWithFormat.pas'
  {$IfEnd} //not NoScripts
  ,
  Registry {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Registry.pas' {$EndIf},
  LocaleMessages in 'Integration\Implementation\LocaleMessages.pas',
  nsIntegrationModelPart in 'Integration\Implementation\nsIntegrationModelPart.pas'
  {$If not defined(NoScripts)}
  ,
  kwIntegrationOpenLink in 'F1_Words\kwIntegrationOpenLink.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  Integration in 'F1_Words\Integration.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  InterfacedNodeWordsPack in 'F1_Words\InterfacedNodeWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  PrimEditionsRes_Form in 'View\Editions\Forms\PrimEditionsRes_Form.pas',
  EditionsRes_Form in 'View\Editions\Forms\EditionsRes_Form.pas' {EditionsResForm: TDataModule},
  nsEditionsUtils in 'Business\Document\nsEditionsUtils.pas',
  nevNodeView in 'w:\common\components\gui\Garant\Everest\nevNodeView.pas',
  evNodePainter in 'w:\common\components\gui\Garant\Everest\evNodePainter.pas',
  nsEditionNodes in 'Common\nsEditionNodes.pas',
  Diff_Form in 'View\Editions\Forms\Diff_Form.pas',
  DiffOptions_Form in 'View\Editions\Forms\DiffOptions_Form.pas',
  PrimLeftEdition_utLeftEdition_UserType in 'View\Editions\Forms\PrimLeftEdition_utLeftEdition_UserType.pas',
  PrimLeftEdition_Form in 'View\Editions\Forms\PrimLeftEdition_Form.pas',
  PrimRightEdition_utRightEdition_UserType in 'View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas',
  PrimRightEdition_Form in 'View\Editions\Forms\PrimRightEdition_Form.pas',
  CompareEditions_FormDefinitions_Controls in 'View\CompareEditions_FormDefinitions_Controls.pas',
  LeftEdition_Form in 'View\Editions\Forms\LeftEdition_Form.pas' {LeftEditionForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  LeftEditionKeywordsPack in 'View\Editions\LeftEditionKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  RightEdition_Form in 'View\Editions\Forms\RightEdition_Form.pas' {RightEditionForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RightEditionKeywordsPack in 'View\Editions\RightEditionKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimEditionsContainer_utEditionsContainer_UserType in 'View\Editions\Forms\PrimEditionsContainer_utEditionsContainer_UserType.pas',
  PrimEditionsContainer_Form in 'View\Editions\Forms\PrimEditionsContainer_Form.pas',
  EditionsContainer_Form in 'View\Editions\Forms\EditionsContainer_Form.pas' {EditionsContainerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  EditionsContainerKeywordsPack in 'View\Editions\EditionsContainerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  dsEditionsContainerData in 'Editions\dsEditionsContainerData.pas',
  nsTagNodeToolsNew in 'f1DocumentTagsImplementation\nsTagNodeToolsNew.pas',
  nsSubPrim in 'F1DocumentProcessing\nsSubPrim.pas',
  nsDocumentContainerSub in 'F1DocumentProcessing\nsDocumentContainerSub.pas',
  nsF1DocumentContainerPrim in 'F1DocumentProcessing\nsF1DocumentContainerPrim.pas',
  nsEditionFromDTPDocumentContainer in 'Editions\nsEditionFromDTPDocumentContainer.pas',
  dsRightEdition in 'Editions\dsRightEdition.pas',
  dsLeftEdition in 'Editions\dsLeftEdition.pas',
  nsRedactionCurrentPara in 'Editions\nsRedactionCurrentPara.pas',
  nsCompareEditionsInfoPrim in 'Editions\nsCompareEditionsInfoPrim.pas',
  nsEditionDiffData in 'Editions\nsEditionDiffData.pas',
  nsEditionsContainerData in 'Editions\nsEditionsContainerData.pas',
  sdsCompareEditionsState in 'Editions\sdsCompareEditionsState.pas',
  dsEditions in 'Business\Document\dsEditions.pas',
  sdsCompareEditions in 'Editions\sdsCompareEditions.pas',
  nsCompareEditionsInfo in 'Editions\nsCompareEditionsInfo.pas',
  fsCompareEditions in 'View\Editions\fsCompareEditions.pas' {fs_CompareEditions: TvcmFormSetFactory},
  BaseEditions_Module in 'View\Editions\BaseEditions_Module.pas',
  moCompareEditions in 'View\moCompareEditions.pas' {mo_CompareEditions: TvcmModule},
  InternetAgentInterfaces in 'InternetAgent\InternetAgentInterfaces.pas'
  {$If not defined(NoVCL)}
  ,
  OleCtrls {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\OleCtrls.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  shdocvw {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Internet\shdocvw.pas' {$EndIf},
  nsWebBrowserPrim in 'View\InternetAgent\nsWebBrowserPrim.pas',
  Variants,
  nsWebBrowserHelper in 'View\InternetAgent\nsWebBrowserHelper.pas',
  nsWebBrowser in 'View\InternetAgent\nsWebBrowser.pas',
  l3RegEx in 'w:\common\components\rtl\Garant\L3\l3RegEx.pas'
  {$If defined(Nemesis)}
  ,
  nsInternetUtils in 'w:\common\components\gui\Garant\Nemesis\nsInternetUtils.pas'
  {$IfEnd} //Nemesis
  ,
  PrimInternetAgent_utInternetAgent_UserType in 'View\InternetAgent\Forms\PrimInternetAgent_utInternetAgent_UserType.pas',
  UrlMon {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\UrlMon.pas' {$EndIf},
  PrimInternetAgent_Form in 'View\InternetAgent\Forms\PrimInternetAgent_Form.pas',
  InternetAgent_Form in 'View\InternetAgent\Forms\InternetAgent_Form.pas' {InternetAgentForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  InternetAgentKeywordsPack in 'View\InternetAgent\InternetAgentKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  fsInternetAgent in 'View\InternetAgent\fsInternetAgent.pas' {fs_InternetAgent: TvcmFormSetFactory},
  dsInternetAgent in 'InternetAgent\dsInternetAgent.pas',
  sdsInternetAgent in 'InternetAgent\sdsInternetAgent.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_InternetAgent_opInternetAgent in 'View\InternetAgent\kw_InternetAgent_opInternetAgent.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimInternetAgent_Module in 'View\InternetAgent\PrimInternetAgent_Module.pas',
  moInternetAgent in 'View\moInternetAgent.pas' {mo_InternetAgent: TvcmModule},
  FoldersInterfaces in 'Folders\FoldersInterfaces.pas',
  Folders_Strange_Controls in 'View\Folders_Strange_Controls.pas',
  Folders_Result_Controls in 'View\Folders_Result_Controls.pas',
  PrimFolders_utFolders_UserType in 'View\Folders\Forms\PrimFolders_utFolders_UserType.pas',
  PrimFolders_Form in 'View\Folders\Forms\PrimFolders_Form.pas',
  PrimFoldersOptions_Form in 'View\Folders\Forms\PrimFoldersOptions_Form.pas',
  Folders_Form in 'View\Folders\Forms\Folders_Form.pas' {cfFolders: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  FoldersKeywordsPack in 'View\Folders\FoldersKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimFoldersInfo_utFoldersInfoContainer_UserType in 'View\Folders\Forms\PrimFoldersInfo_utFoldersInfoContainer_UserType.pas',
  PrimFoldersInfo_Form in 'View\Folders\Forms\PrimFoldersInfo_Form.pas',
  PrimFoldersInfoOptions_Form in 'View\Folders\Forms\PrimFoldersInfoOptions_Form.pas',
  FoldersInfo_Form in 'View\Folders\Forms\FoldersInfo_Form.pas' {cfFoldersInfo: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  FoldersInfoKeywordsPack in 'View\Folders\FoldersInfoKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimFoldersTree_utSaveOpen_UserType in 'View\Folders\Forms\PrimFoldersTree_utSaveOpen_UserType.pas',
  PrimFoldersTree_utFoldersTree_UserType in 'View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas',
  FoldersRes in 'View\FoldersRes.pas' {nsFoldersRes: TDataModule},
  PrimFoldersTree_Form in 'View\Folders\Forms\PrimFoldersTree_Form.pas',
  nsFolderNodes in 'Common\nsFolderNodes.pas',
  nsFormCoordinates in 'View\Folders\nsFormCoordinates.pas',
  PrimFoldersTreeOptions_Form in 'View\Folders\Forms\PrimFoldersTreeOptions_Form.pas',
  FoldersTree_Form in 'View\Folders\Forms\FoldersTree_Form.pas' {enFoldersTree: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  FoldersTreeKeywordsPack in 'View\Folders\FoldersTreeKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  eeMemo in 'w:\common\components\gui\Garant\Everest_Engine\eeMemo.pas',
  eeMemoWithEditOperations in 'w:\common\components\gui\Garant\Everest_Engine\eeMemoWithEditOperations.pas',
  PrimFoldersElementInfo_utFoldersProperty_UserType in 'View\Folders\Forms\PrimFoldersElementInfo_utFoldersProperty_UserType.pas',
  nsSaveQueryEvent in 'View\Folders\nsSaveQueryEvent.pas',
  nsSaveDocumentToFoldersEvent in 'View\Folders\nsSaveDocumentToFoldersEvent.pas',
  PrimFoldersElementInfo_Form in 'View\Folders\Forms\PrimFoldersElementInfo_Form.pas',
  PrimFoldersElementInfoOptions_Form in 'View\Folders\Forms\PrimFoldersElementInfoOptions_Form.pas',
  FoldersElementInfo_Form in 'View\Folders\Forms\FoldersElementInfo_Form.pas' {enFoldersElementInfo: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  FoldersElementInfoKeywordsPack in 'View\Folders\FoldersElementInfoKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  fsFolders in 'View\Folders\fsFolders.pas' {fs_Folders: TvcmFormSetFactory},
  dsFolders in 'Folders\dsFolders.pas',
  bsConsultation in 'Consultation\bsConsultation.pas',
  dsFoldersTree in 'Folders\dsFoldersTree.pas',
  deSaveObject in 'Folders\deSaveObject.pas',
  dsFolderElement in 'Folders\dsFolderElement.pas',
  sdsFolders in 'Folders\sdsFolders.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Folders_opMyInformation in 'View\Folders\kw_Folders_opMyInformation.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Folders_opMyConsultations in 'View\Folders\kw_Folders_opMyConsultations.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Folders_opUnderControlOpenFrmAct in 'View\Folders\kw_Folders_opUnderControlOpenFrmAct.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Folders_opOpenFrmAct in 'View\Folders\kw_Folders_opOpenFrmAct.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimFolders_Module in 'View\Folders\PrimFolders_Module.pas',
  moFolders in 'View\moFolders.pas' {mo_Folders: TvcmModule},
  ChatTypes in 'Chat\ChatTypes.pas',
  ChatInterfaces in 'Chat\ChatInterfaces.pas',
  Base_Operations_Chat_Controls in 'View\Base_Operations_Chat_Controls.pas',
  PrimContactList_chatContacts_UserType in 'View\Chat\Forms\PrimContactList_chatContacts_UserType.pas',
  PrimContactList_chatAddContact_UserType in 'View\Chat\Forms\PrimContactList_chatAddContact_UserType.pas',
  nsUserFlagsFilter in 'Data\Users\nsUserFlagsFilter.pas',
  ChatRes in 'View\Chat\ChatRes.pas',
  PrimContactList_Form in 'View\Chat\Forms\PrimContactList_Form.pas',
  PrimContactListOptions_Form in 'View\Chat\Forms\PrimContactListOptions_Form.pas',
  ContactList_Form in 'View\Chat\Forms\ContactList_Form.pas' {ContactListForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ContactListKeywordsPack in 'View\Chat\ContactListKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  evCustomChatMemo in 'w:\common\components\gui\Garant\Everest\evCustomChatMemo.pas'
  {$If defined(Nemesis)}
  ,
  nscCustomChatMemoDocumentPartGenerator in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoDocumentPartGenerator.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscCustomChatMemoProcessor in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoProcessor.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscCustomChatMemoContainer in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoContainer.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscCustomChatMemoTextSource in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoTextSource.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscCustomChatMemo in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemo.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscChatMemo in 'w:\common\components\gui\Garant\Nemesis\nscChatMemo.pas'
  {$IfEnd} //Nemesis
  ,
  AbstractHistory_Form in 'View\Chat\Forms\AbstractHistory_Form.pas',
  BaseChatWindow_cwChat_UserType in 'View\Chat\Forms\BaseChatWindow_cwChat_UserType.pas',
  evdAllDocumentSubsEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllDocumentSubsEliminator.pas',
  BaseChatWindow_Form in 'View\Chat\Forms\BaseChatWindow_Form.pas',
  BaseChatWindowOptions_Form in 'View\Chat\Forms\BaseChatWindowOptions_Form.pas',
  ChatWindow_Form in 'View\Chat\Forms\ChatWindow_Form.pas' {ChatWindowForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChatWindowKeywordsPack in 'View\Chat\ChatWindowKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  BaseHistoryWindow_utChatHistory_UserType in 'View\Chat\Forms\BaseHistoryWindow_utChatHistory_UserType.pas',
  BaseHistoryWindow_Form in 'View\Chat\Forms\BaseHistoryWindow_Form.pas',
  ChatHistory_Form in 'View\Chat\Forms\ChatHistory_Form.pas' {ChatHistoryForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChatHistoryKeywordsPack in 'View\Chat\ChatHistoryKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  nsBaseChatWindowList in 'Chat\nsBaseChatWindowList.pas',
  nsChatWindowList in 'Chat\nsChatWindowList.pas',
  nsUserIDList in 'Chat\nsUserIDList.pas',
  nsBaseChatHistoryList in 'Chat\nsBaseChatHistoryList.pas',
  nsChatHistoryList in 'Chat\nsChatHistoryList.pas',
  nsContactListNotifiers in 'Chat\nsContactListNotifiers.pas',
  NotifyUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\NotifyUnit.pas',
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
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Chat_opOpenContactList in 'View\Chat\kw_Chat_opOpenContactList.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  BaseChat_Module in 'View\Chat\BaseChat_Module.pas',
  moChat in 'View\moChat.pas' {mo_Chat: TvcmModule},
  WorkJournal_Strange_Controls in 'View\WorkJournal_Strange_Controls.pas',
  PrimWorkJournal_utWorkJournal_UserType in 'View\WorkJournal\Forms\PrimWorkJournal_utWorkJournal_UserType.pas',
  UserJournalUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UserJournalUnit.pas',
  PrimWorkJournal_Form in 'View\WorkJournal\Forms\PrimWorkJournal_Form.pas',
  PrimWorkJournalOptions_Form in 'View\WorkJournal\Forms\PrimWorkJournalOptions_Form.pas',
  WorkJournal_Form in 'View\WorkJournal\Forms\WorkJournal_Form.pas' {WorkJournalForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  WorkJournalKeywordsPack in 'View\WorkJournal\WorkJournalKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  WorkJournalInterfaces in 'View\WorkJournalInterfaces.pas',
  nsWorkJournalListeners in 'WorkJournal\nsWorkJournalListeners.pas',
  nsJournalTreeStruct in 'WorkJournal\nsJournalTreeStruct.pas',
  bsWorkJournalPrim in 'WorkJournal\bsWorkJournalPrim.pas',
  bsWorkJournal in 'WorkJournal\bsWorkJournal.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_WorkJournal_opOpenJournal in 'View\WorkJournal\kw_WorkJournal_opOpenJournal.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  BaseWorkJournal_Module in 'View\WorkJournal\BaseWorkJournal_Module.pas',
  moWorkJournal in 'View\moWorkJournal.pas' {mo_WorkJournal: TvcmModule},
  moMonitorings in 'View\moMonitorings.pas' {mo_Monitorings: TvcmModule},
  PrimRememberPassword_Form in 'View\Common\Forms\PrimRememberPassword_Form.pas',
  RememberPassword_ut_RememberPassword_UserType in 'View\Common\Forms\RememberPassword_ut_RememberPassword_UserType.pas',
  RememberPassword_Form in 'View\Common\Forms\RememberPassword_Form.pas' {RememberPasswordForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RememberPasswordKeywordsPack in 'View\Common\RememberPasswordKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimProgressIndicator_utProgressIndicator_UserType in 'View\Common\Forms\PrimProgressIndicator_utProgressIndicator_UserType.pas',
  PrimProgressIndicator_Form in 'View\Common\Forms\PrimProgressIndicator_Form.pas',
  ProgressIndicator_Form in 'View\Common\Forms\ProgressIndicator_Form.pas' {efProgressIndicator: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ProgressIndicatorKeywordsPack in 'View\Common\ProgressIndicatorKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimEULA_Form in 'View\Common\Forms\PrimEULA_Form.pas',
  EULA_ut_EULA_UserType in 'View\Common\Forms\EULA_ut_EULA_UserType.pas',
  EULA_Form in 'View\Common\Forms\EULA_Form.pas' {efEULA: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  EULAKeywordsPack in 'View\Common\EULAKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimTurnOffTimeMachine_Form in 'View\Common\Forms\PrimTurnOffTimeMachine_Form.pas',
  PrimTurnOffTimeMachineOptions_Form in 'View\Common\Forms\PrimTurnOffTimeMachineOptions_Form.pas',
  TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType in 'View\Common\Forms\TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType.pas',
  TurnOffTimeMachine_Form in 'View\Common\Forms\TurnOffTimeMachine_Form.pas' {en_TurnOffTimeMachine: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TurnOffTimeMachineKeywordsPack in 'View\Common\TurnOffTimeMachineKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  ComplectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ComplectUnit.pas',
  About_ut_About_UserType in 'View\Common\Forms\About_ut_About_UserType.pas',
  About_Form in 'View\Common\Forms\About_Form.pas' {efAbout: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AboutKeywordsPack in 'View\Common\AboutKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  nsComplectInfoNode in 'Common\nsComplectInfoNode.pas',
  nsComplectInfoRootNode in 'Common\nsComplectInfoRootNode.pas',
  nsComplectInfoTreeStruct in 'Common\nsComplectInfoTreeStruct.pas',
  ComplectInfoRes in 'Common\ComplectInfoRes.pas',
  Gauges {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Samples\Gauges.pas' {$EndIf},
  vtGauge in 'w:\common\components\gui\Garant\VT\vtGauge.pas',
  PrimCompInfo_Form in 'View\Common\Forms\PrimCompInfo_Form.pas',
  CompInfo_ut_CompInfo_UserType in 'View\Common\Forms\CompInfo_ut_CompInfo_UserType.pas',
  CompInfo_Form in 'View\Common\Forms\CompInfo_Form.pas' {enCompInfo: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  CompInfoKeywordsPack in 'View\Common\CompInfoKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimRegistration_Form in 'View\Common\Forms\PrimRegistration_Form.pas',
  RegistrationForm_ut_RegistrationForm_UserType in 'View\Common\Forms\RegistrationForm_ut_RegistrationForm_UserType.pas',
  Registration_Form in 'View\Common\Forms\Registration_Form.pas' {nsRegistrationForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RegistrationFormKeywordsPack in 'View\Common\RegistrationFormKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If defined(Nemesis)}
  ,
  nscInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscInterfaces.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  vtHideFieldWords in 'w:\common\components\rtl\Garant\ScriptEngine\vtHideFieldWords.pas'
  {$IfEnd} //not NoScripts
  ,
  vtHideFieldUtils in 'w:\common\components\gui\Garant\VT\vtHideFieldUtils.pas',
  vtHideField in 'w:\common\components\gui\Garant\VT\vtHideField.pas'
  {$If defined(Nemesis)}
  ,
  nscHideField in 'w:\common\components\gui\Garant\Nemesis\nscHideField.pas'
  {$IfEnd} //Nemesis
  ,
  vtSpeedButton in 'w:\common\components\gui\Garant\VT\vtSpeedButton.pas'
  {$If defined(Nemesis)}
  ,
  nscTaskPanelInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscTaskPanelInterfaces.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelActionLink in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelActionLink.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelOperationNode in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelOperationNode.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelRootNode in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelRootNode.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscArrangeGridCell in 'w:\common\components\gui\Garant\Nemesis\nscArrangeGridCell.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTabTableCell in 'w:\common\components\gui\Garant\Nemesis\nscTabTableCell.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscArrangeGrid in 'w:\common\components\gui\Garant\Nemesis\nscArrangeGrid.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTabTable in 'w:\common\components\gui\Garant\Nemesis\nscTabTable.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelView in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelView.pas'
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  TaskPanelWords in 'w:\common\components\rtl\Garant\ScriptEngine\TaskPanelWords.pas'
  {$IfEnd} //not NoScripts AND not NoVCM
  ,
  PrimTasksPanel_tpMain_UserType in 'View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas',
  PrimTasksPanel_Form in 'View\Common\Forms\PrimTasksPanel_Form.pas',
  TasksPanel_Form in 'View\Common\Forms\TasksPanel_Form.pas' {en_TasksPanel: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TasksPanelKeywordsPack in 'View\Common\TasksPanelKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimNavigator_utNavigator_UserType in 'View\Common\Forms\PrimNavigator_utNavigator_UserType.pas',
  NavigatorUtils in 'View\Common\NavigatorUtils.pas',
  NavigatorRes in 'Common\NavigatorRes.pas',
  nsNavigatorTreeStruct in 'Common\nsNavigatorTreeStruct.pas',
  PrimNavigator_Form in 'View\Common\Forms\PrimNavigator_Form.pas',
  PrimNavigatorOptions_Form in 'View\Common\Forms\PrimNavigatorOptions_Form.pas',
  Navigator_Form in 'View\Common\Forms\Navigator_Form.pas' {en_Navigator: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  NavigatorKeywordsPack in 'View\Common\NavigatorKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opComplectInfo in 'View\Common\kw_Common_opComplectInfo.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opPageSetup in 'View\Common\kw_Common_opPageSetup.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opShowEULA in 'View\Common\kw_Common_opShowEULA.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opOpenMainMenuByButton in 'View\Common\kw_Common_opOpenMainMenuByButton.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_OpenMainMenuNew in 'View\Common\kw_Common_OpenMainMenuNew.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opTasksPanel in 'View\Common\kw_Common_opTasksPanel.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_LetterToDevelopers in 'View\Common\kw_Common_LetterToDevelopers.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opOpenRubricator in 'View\Common\kw_Common_opOpenRubricator.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opOpenInformation in 'View\Common\kw_Common_opOpenInformation.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_get_navigator in 'View\Common\kw_Common_get_navigator.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Common_opOpenIntranet in 'View\Common\kw_Common_opOpenIntranet.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimF1Common_Module in 'View\Common\PrimF1Common_Module.pas',
  deDocumentList in 'Business\Document\deDocumentList.pas',
  deListSet in 'Business\Document\deListSet.pas',
  deSearchInfo in 'Search\deSearchInfo.pas',
  nsDataExchangeRealization in 'Business\Document\nsDataExchangeRealization.pas',
  moCommon in 'View\moCommon.pas' {mo_Common: TvcmModule}
  {$If not defined(NoFlash)}
  ,
  vtShockwaveFlashEx in 'w:\common\components\gui\Garant\VT\vtShockwaveFlashEx.pas'
  {$IfEnd} //not NoFlash
  
  {$If not defined(NoScripts)}
  ,
  vtFlashWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtFlashWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  DocumentWithFlashUserTypes_dwftMain_UserType in 'View\DocumentWithFlashUserTypes_dwftMain_UserType.pas',
  DocumentWithFlashUserTypes_dwftSynchro_UserType in 'View\DocumentWithFlashUserTypes_dwftSynchro_UserType.pas',
  evBitmapDataObject in 'w:\common\components\gui\Garant\Everest\evBitmapDataObject.pas',
  nsObjectPreview in 'Printing\nsObjectPreview.pas',
  FlashUtils in 'View\Common\FlashUtils.pas',
  PrimDocumentWithFlash_Form in 'View\PrimDocumentWithFlash_Form.pas',
  PrimDocumentWithFlashOptions_Form in 'View\PrimDocumentWithFlashOptions_Form.pas',
  DocumentWithFlash_Form in 'View\Document\Forms\DocumentWithFlash_Form.pas' {DocumentWithFlashForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DocumentWithFlashKeywordsPack in 'View\Document\DocumentWithFlashKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  bsUtilsConst in 'Document\bsUtilsConst.pas',
  ExTextOptions_Form in 'View\Document\Forms\ExTextOptions_Form.pas',
  Text_Form in 'View\Document\Forms\Text_Form.pas' {TextForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TextKeywordsPack in 'View\Document\TextKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  RedactionsUserTypes_utRedaction_UserType in 'View\RedactionsUserTypes_utRedaction_UserType.pas',
  nsEditionTree in 'Common\nsEditionTree.pas',
  PrimRedactions_Form in 'View\PrimRedactions_Form.pas',
  PrimRedactionsOptions_Form in 'View\PrimRedactionsOptions_Form.pas',
  Redactions_Form in 'View\Document\Forms\Redactions_Form.pas' {RedactionsForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RedactionsKeywordsPack in 'View\Document\RedactionsKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  ContentsUserTypes_utContents_UserType in 'View\ContentsUserTypes_utContents_UserType.pas',
  ContentsUserTypes_utDrugContents_UserType in 'View\ContentsUserTypes_utDrugContents_UserType.pas',
  nevFlatSubsList in 'w:\common\components\gui\Garant\Everest\new\nevFlatSubsList.pas',
  evTreeStorable in 'w:\common\components\gui\Garant\Everest\evTreeStorable.pas',
  nsContentsTreeStorable in 'Common\nsContentsTreeStorable.pas'
  {$If not defined(NoVCM)}
  ,
  vcmTasksPanel in 'w:\common\components\gui\Garant\VCM\implementation\vcmTasksPanel.pas'
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelGroupDescList in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupDescList.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelGroup in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroup.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanelGroupsIterator in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupsIterator.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTasksPanel in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanel.pas'
  {$IfEnd} //Nemesis
  ,
  nsContentsListForFiltering in 'View\nsContentsListForFiltering.pas',
  PrimContents_Form in 'View\PrimContents_Form.pas',
  PrimContentsOptions_Form in 'View\PrimContentsOptions_Form.pas',
  Contents_Form in 'View\Document\Forms\Contents_Form.pas' {ContentsForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ContentsKeywordsPack in 'View\Document\ContentsKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(NoImageEn)}
  ,
  imageenproc in 'w:\common\components\rtl\external\ImageEn\src\imageenproc.pas'
  {$IfEnd} //not NoImageEn
  ,
  PrimPicture_pfImage_UserType in 'View\PrimPicture_pfImage_UserType.pas'
  {$If not defined(NoImageEn)}
  ,
  giflzw in 'w:\common\components\rtl\external\ImageEn\src\giflzw.pas'
  {$IfEnd} //not NoImageEn
  ,
  PrimPicture_Form in 'View\PrimPicture_Form.pas',
  PrimPictureOptions_Form in 'View\PrimPictureOptions_Form.pas',
  Picture_Form in 'View\Document\Forms\Picture_Form.pas' {PictureForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  PictureKeywordsPack in 'View\Document\PictureKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimPictureInfo_Form in 'View\PrimPictureInfo_Form.pas',
  PrimPictureInfoOptions_Form in 'View\PrimPictureInfoOptions_Form.pas',
  PictureInfo_ut_PictureInfo_UserType in 'View\Document\Forms\PictureInfo_ut_PictureInfo_UserType.pas',
  PictureInfo_Form in 'View\Document\Forms\PictureInfo_Form.pas' {en_PictureInfo: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  PictureInfoKeywordsPack in 'View\Document\PictureInfoKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimDocNumberQuery_Form in 'View\PrimDocNumberQuery_Form.pas',
  PrimDocNumberQueryOptions_Form in 'View\PrimDocNumberQueryOptions_Form.pas',
  DocNumberQuery_ut_DocNumberQuery_UserType in 'View\Document\Forms\DocNumberQuery_ut_DocNumberQuery_UserType.pas',
  DocNumberQuery_Form in 'View\Document\Forms\DocNumberQuery_Form.pas' {DocNumberQueryForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DocNumberQueryKeywordsPack in 'View\Document\DocNumberQueryKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  nsWarningDocumentContainer in 'View\nsWarningDocumentContainer.pas',
  PrimWarning_Form in 'View\PrimWarning_Form.pas',
  PrimWarningOptions_Form in 'View\PrimWarningOptions_Form.pas',
  PrimDockedWarning_Form in 'View\PrimDockedWarning_Form.pas',
  Warning_Form in 'View\Document\Forms\Warning_Form.pas' {WarningForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  WarningKeywordsPack in 'View\Document\WarningKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  AttributesUserTypes_fDocAttribute_UserType in 'View\AttributesUserTypes_fDocAttribute_UserType.pas',
  AttributesUserTypes_fAttributeSynchroView_UserType in 'View\AttributesUserTypes_fAttributeSynchroView_UserType.pas',
  nsSingleAttributeStorable in 'Common\nsSingleAttributeStorable.pas',
  nsSingleAttributeDataObject in 'Common\nsSingleAttributeDataObject.pas',
  nsSingleAttributeData in 'Common\nsSingleAttributeData.pas',
  PrimAttributes_Form in 'View\PrimAttributes_Form.pas',
  evTreeDataObject in 'w:\common\components\gui\Garant\Everest\evTreeDataObject.pas',
  PrimAttributesOptions_Form in 'View\PrimAttributesOptions_Form.pas',
  Attributes_Form in 'View\Document\Forms\Attributes_Form.pas' {AttributesForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AttributesKeywordsPack in 'View\Document\AttributesKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  SynchroViewUserTypes_svSynchroView_UserType in 'View\SynchroViewUserTypes_svSynchroView_UserType.pas',
  PrimSynchroView_Form in 'View\PrimSynchroView_Form.pas',
  PrimSynchroViewOptions_Form in 'View\PrimSynchroViewOptions_Form.pas',
  SynchroView_Form in 'View\Document\Forms\SynchroView_Form.pas' {fcSynchroView: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SynchroViewKeywordsPack in 'View\Document\SynchroViewKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimTurnOnTimeMachine_Form in 'View\PrimTurnOnTimeMachine_Form.pas',
  PrimTurnOnTimeMachineOptions_Form in 'View\PrimTurnOnTimeMachineOptions_Form.pas',
  TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType in 'View\Document\Forms\TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas',
  TurnOnTimeMachine_Form in 'View\Document\Forms\TurnOnTimeMachine_Form.pas' {en_TurnOnTimeMachine: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TurnOnTimeMachineKeywordsPack in 'View\Document\TurnOnTimeMachineKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimWarningBaloonOptions_Form in 'View\PrimWarningBaloonOptions_Form.pas',
  WarningBaloon_Form in 'View\Document\Forms\WarningBaloon_Form.pas' {WarningBaloonForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  WarningBaloonKeywordsPack in 'View\Document\WarningBaloonKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  SynchroView_WarningBaloon_Form in 'View\Document\Forms\SynchroView_WarningBaloon_Form.pas' {SynchroView_WarningBaloonForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SynchroView_WarningBaloonKeywordsPack in 'View\Document\SynchroView_WarningBaloonKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Translation_WarningBaloon_Form in 'View\Document\Forms\Translation_WarningBaloon_Form.pas' {Translation_WarningBaloonForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  Translation_WarningBaloonKeywordsPack in 'View\Document\Translation_WarningBaloonKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  UserCR1_WarningBaloon_Form in 'View\Document\Forms\UserCR1_WarningBaloon_Form.pas' {UserCR1_WarningBaloonForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  UserCR1_WarningBaloonKeywordsPack in 'View\Document\UserCR1_WarningBaloonKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  UserCR2_WarningBaloon_Form in 'View\Document\Forms\UserCR2_WarningBaloon_Form.pas' {UserCR2_WarningBaloonForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  UserCR2_WarningBaloonKeywordsPack in 'View\Document\UserCR2_WarningBaloonKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  fsAbstractDocument in 'View\fsAbstractDocument.pas',
  nsDocAttributeTreeStruct in 'Common\nsDocAttributeTreeStruct.pas',
  dsAttributes in 'Business\Document\dsAttributes.pas',
  nsContentsNode in 'f1DocumentTagsImplementation\nsContentsNode.pas',
  nsContentsTree in 'F1DocumentProcessing\nsContentsTree.pas',
  nsMedicContentsTree in 'F1DocumentProcessing\nsMedicContentsTree.pas',
  nsF1DocumentContainer in 'F1DocumentProcessing\nsF1DocumentContainer.pas',
  dsDocument in 'Business\Document\dsDocument.pas',
  nsINodesClipboardDataObject in 'Business\Document\nsINodesClipboardDataObject.pas',
  nsIListDataObject in 'Business\Document\nsIListDataObject.pas',
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
  nsFiltersUtils in 'Filters\nsFiltersUtils.pas',
  nsDocumentWithSnippetNode in 'Business\Document\nsDocumentWithSnippetNode.pas',
  nsDocumentWithSnippetList in 'Business\Document\nsDocumentWithSnippetList.pas',
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
  nsChronologyDocumentContainer in 'F1DocumentProcessing\nsChronologyDocumentContainer.pas',
  dsChronology in 'Business\Document\dsChronology.pas',
  dDocument in 'Document\dDocument.pas',
  dsDocumentListCRToPart in 'Document\dsDocumentListCRToPart.pas',
  dsBaseContentsRes in 'Business\Document\dsBaseContentsRes.pas',
  dsContents in 'Business\Document\dsContents.pas',
  nsDocumentWarningGenerator in 'PrimListAndDocumentControllers\nsDocumentWarningGenerator.pas',
  dsTranslationWarning in 'Document\dsTranslationWarning.pas',
  nsListWarningGenerator in 'PrimListControllers\nsListWarningGenerator.pas',
  dsCRWarning in 'Document\dsCRWarning.pas',
  sdsDocument in 'Document\sdsDocument.pas',
  sdsDocumentWithFlash in 'Document\sdsDocumentWithFlash.pas',
  fsDocument in 'View\Document\fsDocument.pas' {fs_Document: TvcmFormSetFactory},
  fsDocumentWithFlash in 'View\Document\fsDocumentWithFlash.pas' {fs_DocumentWithFlash: TvcmFormSetFactory},
  nsOpenDocOnNumberData in 'View\nsOpenDocOnNumberData.pas',
  DocumentShowChangesInfoSettingRes in 'View\Document\DocumentShowChangesInfoSettingRes.pas',
  Contnrs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Contnrs.pas' {$EndIf},
  l3ProtoPersistentRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentRefList.pas',
  ddAppConfigConst in 'w:\common\components\rtl\Garant\dd\ddAppConfigConst.pas',
  ddConfigStorages in 'w:\common\components\rtl\Garant\dd\ddConfigStorages.pas',
  ddAppConfigBase in 'w:\common\components\rtl\Garant\dd\ddAppConfigBase.pas',
  ddAppConfigTypesRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas'
  {$If not defined(NoVCL)}
  ,
  CheckLst {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CheckLst.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  CheckListBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  ddAppConfigRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas',
  ddAppConfigTypes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas',
  stDocumentShowChangesInfoItem in 'View\Document\stDocumentShowChangesInfoItem.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Document_opOpenDocOnNumber in 'View\Document\kw_Document_opOpenDocOnNumber.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Document_Module in 'View\Document\Document_Module.pas',
  moDocument in 'View\moDocument.pas' {mo_Document: TvcmModule},
  List_Form in 'View\List\Forms\List_Form.pas' {efList: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ListKeywordsPack in 'View\List\ListKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  ListInfoUserTypes_liListInfo_UserType in 'View\ListInfoUserTypes_liListInfo_UserType.pas',
  PrimListInfo_Form in 'View\List\Forms\PrimListInfo_Form.pas',
  PrimListInfoOptions_Form in 'View\List\Forms\PrimListInfoOptions_Form.pas',
  ListInfo_Form in 'View\List\Forms\ListInfo_Form.pas' {efListInfo: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ListInfoKeywordsPack in 'View\List\ListInfoKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimListAnalizer_listAnalize_UserType in 'View\List\Forms\PrimListAnalizer_listAnalize_UserType.pas',
  PrimListAnalizer_Form in 'View\List\Forms\PrimListAnalizer_Form.pas',
  ListAnalizer_Form in 'View\List\Forms\ListAnalizer_Form.pas' {ListAnalizerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ListAnalizerKeywordsPack in 'View\List\ListAnalizerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  ListInterfaces in 'Business\ListInterfaces.pas',
  bsOpenListInfo in 'Business\List\bsOpenListInfo.pas',
  FiltersUserTypes_utFilters_UserType in 'View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas',
  ListAnalizeUserTypes_Analize_UserType in 'View\ListAnalizeUserTypes_Analize_UserType.pas',
  PrimListAnalize_Form in 'View\List\Forms\PrimListAnalize_Form.pas',
  ListAnalize_Form in 'View\List\Forms\ListAnalize_Form.pas' {ListAnalizeForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ListAnalizeKeywordsPack in 'View\List\ListAnalizeKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  fsList in 'View\List\fsList.pas' {fs_List: TvcmFormSetFactory},
  dsSynchroView in 'Business\List\dsSynchroView.pas',
  dsListInfo in 'Business\List\dsListInfo.pas',
  dsMainList in 'List\dsMainList.pas',
  deFilter in 'List\deFilter.pas',
  dsFilters in 'List\dsFilters.pas',
  dList in 'List\dList.pas',
  dsListAnalize in 'List\dsListAnalize.pas',
  dsSynchroViewWarning in 'Business\Document\dsSynchroViewWarning.pas',
  nsAACDocumentContainerPrim in 'F1DocumentProcessing\nsAACDocumentContainerPrim.pas',
  nsAACDocumentSynchroViewContainer in 'F1DocumentProcessing\nsAACDocumentSynchroViewContainer.pas',
  dsSynchroViewDocument in 'List\dsSynchroViewDocument.pas',
  sdsList in 'List\sdsList.pas',
  List_Module in 'View\List\List_Module.pas',
  moList in 'View\moList.pas' {mo_List: TvcmModule},
  CommonDictionInterfaces in 'CommonDiction\CommonDictionInterfaces.pas',
  DictionInterfaces in 'Diction\DictionInterfaces.pas',
  Diction_Strange_Controls in 'View\Diction_Strange_Controls.pas',
  PrimDiction_utDiction_UserType in 'View\Diction\Forms\PrimDiction_utDiction_UserType.pas',
  DictionRes in 'View\Diction\DictionRes.pas' {nsDictRes: TDataModule},
  nsLangList in 'Diction\nsLangList.pas',
  nsDictCachePrim in 'Diction\nsDictCachePrim.pas',
  nsDictCache in 'Diction\nsDictCache.pas',
  nsDictListChild in 'Diction\nsDictListChild.pas',
  nsLayerFilter in 'Diction\nsLayerFilter.pas',
  nsLayeredTreeFilters in 'Diction\nsLayeredTreeFilters.pas',
  nsMedicDictCache in 'Diction\nsMedicDictCache.pas',
  nsDayTipsDictCache in 'Diction\nsDayTipsDictCache.pas',
  nsDictionTree in 'Diction\nsDictionTree.pas',
  PrimDiction_Form in 'View\Diction\Forms\PrimDiction_Form.pas',
  PrimDictionOptions_Form in 'View\Diction\Forms\PrimDictionOptions_Form.pas',
  Diction_Form in 'View\Diction\Forms\Diction_Form.pas' {enDiction: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DictionKeywordsPack in 'View\Diction\DictionKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimCommonDiction_utTips_UserType in 'View\Diction\Forms\PrimCommonDiction_utTips_UserType.pas',
  PrimCommonDiction_utMedicDiction_UserType in 'View\Diction\Forms\PrimCommonDiction_utMedicDiction_UserType.pas',
  PrimCommonDiction_Form in 'View\Diction\Forms\PrimCommonDiction_Form.pas',
  PrimCommonDictionOptions_Form in 'View\Diction\Forms\PrimCommonDictionOptions_Form.pas',
  CommonDiction_Form in 'View\Diction\Forms\CommonDiction_Form.pas' {en_CommonDiction: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  CommonDictionKeywordsPack in 'View\Diction\CommonDictionKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  DictionContainerUserTypes_slqtMedicDiction_UserType in 'View\DictionContainerUserTypes_slqtMedicDiction_UserType.pas',
  DictionContainerUserTypes_slqtDiction_UserType in 'View\DictionContainerUserTypes_slqtDiction_UserType.pas',
  PrimDictionContainer_Form in 'View\Diction\Forms\PrimDictionContainer_Form.pas',
  DictionContainer_Form in 'View\Diction\Forms\DictionContainer_Form.pas' {DictionContainerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DictionContainerKeywordsPack in 'View\Diction\DictionContainerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  deCommonDiction in 'CommonDiction\deCommonDiction.pas',
  deDiction in 'Diction\deDiction.pas',
  dCommonDiction in 'CommonDiction\dCommonDiction.pas',
  dsSaveLoad in 'Search\dsSaveLoad.pas',
  dsChild in 'CommonDiction\dsChild.pas'
  {$If defined(Nemesis)}
  ,
  InscContextFilterStateList in 'w:\common\components\gui\Garant\Nemesis\InscContextFilterStateList.pas'
  {$IfEnd} //Nemesis
  ,
  nsLangToContextMap in 'Diction\nsLangToContextMap.pas',
  dsDiction in 'Diction\dsDiction.pas',
  nsDictionDocumentContainer in 'DictionLikeDocumentProcessing\nsDictionDocumentContainer.pas',
  dsDictionDocument in 'Diction\dsDictionDocument.pas',
  l3InterfaceList in 'w:\common\components\rtl\Garant\L3\l3InterfaceList.pas',
  dDiction in 'Diction\dDiction.pas',
  sdsDiction in 'Diction\sdsDiction.pas',
  fsDiction in 'View\Diction\fsDiction.pas' {fs_Diction: TvcmFormSetFactory}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Diction_opOpenDict in 'View\Diction\kw_Diction_opOpenDict.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Diction_Module in 'View\Diction\Diction_Module.pas',
  moDiction in 'View\moDiction.pas' {mo_Diction: TvcmModule},
  DayTipsInterfaces in 'DayTips\DayTipsInterfaces.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evCursorShapeMisc in 'w:\common\components\gui\Garant\Everest\evCursorShapeMisc.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  PrimStartupTips_Form in 'View\DayTips\Forms\PrimStartupTips_Form.pas',
  StartupTips_ut_StartupTips_UserType in 'View\DayTips\Forms\StartupTips_ut_StartupTips_UserType.pas',
  StartupTips_Form in 'View\DayTips\Forms\StartupTips_Form.pas' {efStartupTips: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StartupTipsKeywordsPack in 'View\DayTips\StartupTipsKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  sdsCommonDiction in 'CommonDiction\sdsCommonDiction.pas',
  nsTipsDocumentContainer in 'DayTips\nsTipsDocumentContainer.pas',
  dsTipsDocument in 'DayTips\dsTipsDocument.pas',
  deTips in 'DayTips\deTips.pas',
  nsTipsTree in 'DayTips\nsTipsTree.pas',
  dsTips in 'DayTips\dsTips.pas',
  sdsTips in 'DayTips\sdsTips.pas',
  fsTips in 'View\DayTips\fsTips.pas' {fs_Tips: TvcmFormSetFactory},
  nsStartupTips in 'DayTips\nsStartupTips.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Tips_opShowDayTips in 'View\DayTips\kw_Tips_opShowDayTips.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  DayTips_Module in 'View\DayTips\DayTips_Module.pas',
  moTips in 'View\moTips.pas' {mo_Tips: TvcmModule},
  MedicInterfaces in 'Medic\MedicInterfaces.pas',
  nsQueryNode in 'Common\nsQueryNode.pas',
  nsMainMenuNew in 'View\MainMenu\Forms\nsMainMenuNew.pas',
  PrimMainMenu_Form in 'View\MainMenu\Forms\PrimMainMenu_Form.pas',
  InpharmMainMenu_ut_mmmMain_UserType in 'View\Inpharm\Forms\InpharmMainMenu_ut_mmmMain_UserType.pas',
  nsHistoryTree in 'Common\nsHistoryTree.pas',
  nsJournalBookmarkNode in 'Common\nsJournalBookmarkNode.pas',
  nsLastOpenDocTree in 'Common\nsLastOpenDocTree.pas',
  nsDocumentMainMenuNode in 'Common\nsDocumentMainMenuNode.pas',
  mmmTree in 'Medic\mmmTree.pas',
  mmmMainFeatures in 'Medic\mmmMainFeatures.pas',
  mmmReferencePharmaceuticalInformation in 'Medic\mmmReferencePharmaceuticalInformation.pas',
  mmmRegulatoryInformation in 'Medic\mmmRegulatoryInformation.pas',
  mmmReferencesAndDictionaries in 'Medic\mmmReferencesAndDictionaries.pas',
  InpharmMainMenu_Form in 'View\Inpharm\Forms\InpharmMainMenu_Form.pas',
  PrimMedicListSynchroView_mlsfDrugList_UserType in 'View\Inpharm\Forms\PrimMedicListSynchroView_mlsfDrugList_UserType.pas',
  Inpharm_Strange_Controls in 'View\Inpharm_Strange_Controls.pas',
  PrimMedicListSynchroView_mlsfMedicFirm_UserType in 'View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas',
  PrimMedicListSynchroView_Form in 'View\Inpharm\Forms\PrimMedicListSynchroView_Form.pas',
  MedicMainMenu_Form in 'View\Inpharm\Forms\MedicMainMenu_Form.pas' {en_MedicMainMenu: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MedicMainMenuKeywordsPack in 'View\Inpharm\MedicMainMenuKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimMedicFirmList_mflMain_UserType in 'View\Inpharm\Forms\PrimMedicFirmList_mflMain_UserType.pas',
  PrimMedicFirmList_Form in 'View\Inpharm\Forms\PrimMedicFirmList_Form.pas',
  PrimMedicFirmListOptions_Form in 'View\Inpharm\Forms\PrimMedicFirmListOptions_Form.pas',
  MedicFirmList_Form in 'View\Inpharm\Forms\MedicFirmList_Form.pas' {en_MedicFirmList: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MedicFirmListKeywordsPack in 'View\Inpharm\MedicFirmListKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  MedicListSynchroView_Form in 'View\Inpharm\Forms\MedicListSynchroView_Form.pas' {en_MedicListSynchroView: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MedicListSynchroViewKeywordsPack in 'View\Inpharm\MedicListSynchroViewKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
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
  dMedicFirmList in 'Medic\dMedicFirmList.pas',
  nsCountryFilter in 'Medic\nsCountryFilter.pas',
  nsMedicFirmListFilters in 'Medic\nsMedicFirmListFilters.pas',
  nsMedicFirmsTreeBase in 'Medic\nsMedicFirmsTreeBase.pas',
  nsMedicFirmsTree in 'Medic\nsMedicFirmsTree.pas',
  PharmFirmListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\PharmFirmListUnit.pas',
  nsMedicFirmsSubscribersList in 'Medic\nsMedicFirmsSubscribersList.pas',
  nsMedicFirmsCountryFilterTreeBase in 'Medic\nsMedicFirmsCountryFilterTreeBase.pas',
  nsMedicFirmsCountryFilterTree in 'Medic\nsMedicFirmsCountryFilterTree.pas',
  deMedicFirmList in 'Medic\deMedicFirmList.pas',
  dsMedicFirmList in 'Medic\dsMedicFirmList.pas',
  dsMedicFirmSynchroView in 'Medic\dsMedicFirmSynchroView.pas',
  sdsMedicFirmList in 'Medic\sdsMedicFirmList.pas',
  fsInpharmMainMenu in 'View\Inpharm\fsInpharmMainMenu.pas' {fs_InpharmMainMenu: TvcmFormSetFactory},
  dsInpharmMainMenu in 'InpharmControllers\dsInpharmMainMenu.pas',
  sdsInpharmMainMenu in 'InpharmControllers\sdsInpharmMainMenu.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Inpharm_opMedicDiction in 'View\Inpharm\kw_Inpharm_opMedicDiction.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Inpharm_opMedicFirms in 'View\Inpharm\kw_Inpharm_opMedicFirms.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Inpharm_opDrugList in 'View\Inpharm\kw_Inpharm_opDrugList.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Inpharm_opMedicMainMenu in 'View\Inpharm\kw_Inpharm_opMedicMainMenu.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Inpharm_Module in 'View\Inpharm\Inpharm_Module.pas',
  moInpharm in 'View\moInpharm.pas' {mo_Inpharm: TvcmModule},
  Rubricator_Strange_Controls in 'View\Rubricator_Strange_Controls.pas',
  RubricatorInterfaces in 'Rubricator\RubricatorInterfaces.pas',
  nsRubricatorList in 'Rubricator\nsRubricatorList.pas',
  PrimRubricator_utRubricatorList_UserType in 'View\Rubricator\Forms\PrimRubricator_utRubricatorList_UserType.pas',
  RubricatorRes in 'View\Rubricator\RubricatorRes.pas' {nsRubricatorRes: TDataModule},
  PrimRubricator_Form in 'View\Rubricator\Forms\PrimRubricator_Form.pas',
  Rubricator_Form in 'View\Rubricator\Forms\Rubricator_Form.pas' {efRubricator: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RubricatorKeywordsPack in 'View\Rubricator\RubricatorKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Rubricator_Module in 'View\Rubricator\Rubricator_Module.pas',
  moRubricator in 'View\moRubricator.pas' {mo_Rubricator: TvcmModule},
  Settings_Strange_Controls in 'View\Settings_Strange_Controls.pas',
  PrimStyleEditorContainer_utStyleEditorContainer_UserType in 'View\Settings\Forms\PrimStyleEditorContainer_utStyleEditorContainer_UserType.pas',
  PrimStyleEditorContainer_Form in 'View\Settings\Forms\PrimStyleEditorContainer_Form.pas',
  PrimStyleEditorContainerOptions_Form in 'View\Settings\Forms\PrimStyleEditorContainerOptions_Form.pas',
  StyleEditorContainer_Form in 'View\Settings\Forms\StyleEditorContainer_Form.pas' {StyleEditorContainerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorContainerKeywordsPack in 'View\Settings\StyleEditorContainerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vtColorBoxStrings in 'w:\common\components\gui\Garant\VT\vtColorBoxStrings.pas',
  vtColorBox in 'w:\common\components\gui\Garant\VT\vtColorBox.pas',
  PrimStyleEditorFont_Form in 'View\Settings\Forms\PrimStyleEditorFont_Form.pas',
  StyleEditorFont_ut_StyleEditorFont_UserType in 'View\Settings\Forms\StyleEditorFont_ut_StyleEditorFont_UserType.pas',
  StyleEditorFont_Form in 'View\Settings\Forms\StyleEditorFont_Form.pas' {StyleEditorFontForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorFontKeywordsPack in 'View\Settings\StyleEditorFontKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimStyleEditorNavigator_utStyleEditorNavigator_UserType in 'View\Settings\Forms\PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas',
  StyleTableRes in 'Config\StyleTableRes.pas',
  PrimStyleEditorNavigator_Form in 'View\Settings\Forms\PrimStyleEditorNavigator_Form.pas',
  StyleEditorNavigator_Form in 'View\Settings\Forms\StyleEditorNavigator_Form.pas' {StyleEditorNavigatorForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorNavigatorKeywordsPack in 'View\Settings\StyleEditorNavigatorKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimConfigurationList_utConfigurationList_UserType in 'View\Settings\Forms\PrimConfigurationList_utConfigurationList_UserType.pas',
  ConfigurationListRes in 'Config\ConfigurationListRes.pas',
  PrimConfigurationList_Form in 'View\Settings\Forms\PrimConfigurationList_Form.pas',
  ConfigurationList_Form in 'View\Settings\Forms\ConfigurationList_Form.pas' {en_ConfigurationList: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ConfigurationListKeywordsPack in 'View\Settings\ConfigurationListKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimSettings_cutSettings_UserType in 'View\Settings\Forms\PrimSettings_cutSettings_UserType.pas',
  ddAppConfigStringsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas',
  l3Base64 in 'w:\common\components\rtl\Garant\L3\l3Base64.pas',
  ddAppConfigStrings in 'w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas',
  l3ProtoPtrRecListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas',
  l3RecListWithPartialFind in 'w:\common\components\rtl\Garant\L3\l3RecListWithPartialFind.pas',
  l3ProtoPtrRecList in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecList.pas',
  l3BaseRecList in 'w:\common\components\rtl\Garant\L3\l3BaseRecList.pas',
  l3RecList in 'w:\common\components\rtl\Garant\L3\l3RecList.pas',
  ddAppConfigVersions in 'w:\common\components\rtl\Garant\dd\ddAppConfigVersions.pas',
  ddAppConfigWFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigWFrame.pas',
  ddAppConfigSimpleBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigSimpleBFrame.pas',
  l3TypedIntegerValueMap in 'w:\common\components\rtl\Garant\L3\l3TypedIntegerValueMap.pas',
  ddAppConfigDates in 'w:\common\components\rtl\Garant\dd\ddAppConfigDates.pas',
  ddAppConfigListsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigListsRes.pas',
  ddAppConfigLists in 'w:\common\components\rtl\Garant\dd\ddAppConfigLists.pas'
  {$If not defined(Nemesis)}
  ,
  ddIniStorage in 'w:\common\components\rtl\Garant\dd\ddIniStorage.pas'
  {$IfEnd} //not Nemesis
  ,
  ddAppConfigUtils in 'w:\common\components\rtl\Garant\dd\ddAppConfigUtils.pas',
  ddAppConfigDataAdapters in 'w:\common\components\rtl\Garant\dd\ddAppConfigDataAdapters.pas',
  ddAppConfigTFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigTFrame.pas',
  ddAppConfigBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigBFrame.pas',
  ddAppConfig in 'w:\common\components\rtl\Garant\dd\ddAppConfig.pas',
  nsAppConfigRes in 'Config\nsAppConfigRes.pas',
  nsConfigurationProperties in 'Config\nsConfigurationProperties.pas',
  nsAppConfig in 'Config\nsAppConfig.pas',
  PrimSettings_Form in 'View\Settings\Forms\PrimSettings_Form.pas',
  Settings_Form in 'View\Settings\Forms\Settings_Form.pas' {cf_Settings: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SettingsKeywordsPack in 'View\Settings\SettingsKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  eeEditorWithoutOperations in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorWithoutOperations.pas',
  PrimStyleEditorExample_utStyleEditorExample_UserType in 'View\Settings\Forms\PrimStyleEditorExample_utStyleEditorExample_UserType.pas',
  PrimStyleEditorExample_Form in 'View\Settings\Forms\PrimStyleEditorExample_Form.pas',
  StyleEditorExample_Form in 'View\Settings\Forms\StyleEditorExample_Form.pas' {StyleEditorExampleForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorExampleKeywordsPack in 'View\Settings\StyleEditorExampleKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  nsUserProperty in 'Data\Users\nsUserProperty.pas',
  PrimSelfInfo_Form in 'View\Settings\Forms\PrimSelfInfo_Form.pas',
  SelfInfo_ut_SelfInfo_UserType in 'View\Settings\Forms\SelfInfo_ut_SelfInfo_UserType.pas',
  SelfInfo_Form in 'View\Settings\Forms\SelfInfo_Form.pas' {SelfInfoForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SelfInfoKeywordsPack in 'View\Settings\SelfInfoKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opOpenStyleEditorAsModal in 'View\Settings\kw_Settings_opOpenStyleEditorAsModal.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opAutoLogin in 'View\Settings\kw_Settings_opAutoLogin.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opSelectConfig in 'View\Settings\kw_Settings_opSelectConfig.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opOpenConfList in 'View\Settings\kw_Settings_opOpenConfList.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opLoadActiveSettings in 'View\Settings\kw_Settings_opLoadActiveSettings.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opUserProperties in 'View\Settings\kw_Settings_opUserProperties.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Settings_Module in 'View\Settings\Settings_Module.pas',
  moSettings in 'View\moSettings.pas' {mo_Settings: TvcmModule}
  {$If not defined(NoVCM)}
  ,
  vcmFormGUIDFromMainFormList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormGUIDFromMainFormList.pas'
  {$IfEnd} //not NoVCM
  ,
  nsMainMenuFormGUIDFactory in 'View\MainMenu\nsMainMenuFormGUIDFactory.pas',
  MainMenuWithBaseSearchSupport_Form in 'View\MainMenu\Forms\MainMenuWithBaseSearchSupport_Form.pas',
  nsMainMenu2011Node in 'Common\nsMainMenu2011Node.pas',
  smTree in 'MainMenu\smTree.pas',
  smLawNewsTree in 'MainMenu\smLawNewsTree.pas',
  smNewSchoolReferencesTree in 'MainMenu\smNewSchoolReferencesTree.pas',
  PrimLegalMainMenu_Form in 'View\MainMenu\Forms\PrimLegalMainMenu_Form.pas'
  {$If defined(Nemesis)}
  ,
  nscFocusLabel in 'w:\common\components\gui\Garant\Nemesis\nscFocusLabel.pas'
  {$IfEnd} //Nemesis
  ,
  PrimMainMenuNew_utMainMenuNew_UserType in 'View\MainMenu\Forms\PrimMainMenuNew_utMainMenuNew_UserType.pas'
  {$If not defined(NoImageEn)}
  ,
  iemview in 'w:\common\components\rtl\external\ImageEn\src\iemview.pas'
  {$IfEnd} //not NoImageEn
  
  {$If defined(Nemesis)}
  ,
  nscFixedHeightControlCell in 'w:\common\components\gui\Garant\Nemesis\nscFixedHeightControlCell.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscFixedWidthControlCell in 'w:\common\components\gui\Garant\Nemesis\nscFixedWidthControlCell.pas'
  {$IfEnd} //Nemesis
  ,
  smChangeableTree in 'MainMenu\smChangeableTree.pas',
  PrimMainMenuNew_Form in 'View\MainMenu\Forms\PrimMainMenuNew_Form.pas',
  MainMenuNew_Form in 'View\MainMenu\Forms\MainMenuNew_Form.pas' {en_MainMenuNew: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MainMenuNewKeywordsPack in 'View\MainMenu\MainMenuNewKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  MainMenuChangeableMainMenuTypeSettingRes in 'View\MainMenu\MainMenuChangeableMainMenuTypeSettingRes.pas',
  stMainMenuChangeableMainMenuTypeItem in 'View\MainMenu\stMainMenuChangeableMainMenuTypeItem.pas',
  MainMenu_Module in 'View\MainMenu\MainMenu_Module.pas',
  moMainMenu in 'View\moMainMenu.pas' {mo_MainMenu: TvcmModule},
  ConsultationInterfaces in 'Consultation\ConsultationInterfaces.pas',
  PrimConsultationMark_utcmMain_UserType in 'View\Consultation\Forms\PrimConsultationMark_utcmMain_UserType.pas',
  PrimConsultationMark_Form in 'View\Consultation\Forms\PrimConsultationMark_Form.pas',
  PrimConsultationMarkOptions_Form in 'View\Consultation\Forms\PrimConsultationMarkOptions_Form.pas',
  ConsultationMark_Form in 'View\Consultation\Forms\ConsultationMark_Form.pas' {en_ConsultationMark: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ConsultationMarkKeywordsPack in 'View\Consultation\ConsultationMarkKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  nsConsultationHAFPainterImages_Form in 'Consultation\nsConsultationHAFPainterImages_Form.pas',
  nsConsultationDocumentContainerNew in 'Consultation\nsConsultationDocumentContainerNew.pas',
  dsConsultation in 'Consultation\dsConsultation.pas',
  dsConsultationMark in 'Consultation\dsConsultationMark.pas',
  dsConsultationList in 'Consultation\dsConsultationList.pas',
  bsConsultationManager in 'Consultation\bsConsultationManager.pas',
  sdsConsultation in 'Consultation\sdsConsultation.pas',
  dsQuery in 'Consultation\dsQuery.pas',
  sdsQuery in 'Consultation\sdsQuery.pas',
  dsSendConsultation in 'Consultation\dsSendConsultation.pas',
  sdsSendConsultation in 'Consultation\sdsSendConsultation.pas',
  fsSendConsultation in 'View\Consultation\fsSendConsultation.pas' {fs_SendConsultation: TvcmFormSetFactory},
  fsConsultation in 'View\Consultation\fsConsultation.pas' {fs_Consultation: TvcmFormSetFactory},
  Consultation_Module in 'View\Consultation\Consultation_Module.pas',
  moConsultations in 'View\moConsultations.pas' {mo_Consultations: TvcmModule}
  {$If defined(Nemesis)}
  ,
  nscLister in 'w:\common\components\gui\Garant\Nemesis\nscLister.pas'
  {$IfEnd} //Nemesis
  ,
  PrimBaseSearchCard_Form in 'View\BaseSearch\Forms\PrimBaseSearchCard_Form.pas',
  BaseSearchCard_ut_BaseSearchCard_UserType in 'View\BaseSearch\Forms\BaseSearchCard_ut_BaseSearchCard_UserType.pas',
  BaseSearchCard_Form in 'View\BaseSearch\Forms\BaseSearchCard_Form.pas' {en_BaseSearchCard: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  BaseSearchCardKeywordsPack in 'View\BaseSearch\BaseSearchCardKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  BaseSearch_Controls in 'View\BaseSearch_Controls.pas'
  {$If defined(Nemesis)}
  ,
  nscCustomTreeComboWithHistoryRes in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistoryRes.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscConst in 'w:\common\components\gui\Garant\Nemesis\nscConst.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscCustomTreeComboWithHistory in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistory.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeComboWithHistory in 'w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistory.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeComboWithHistoryAndOperations in 'w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistoryAndOperations.pas'
  {$IfEnd} //Nemesis
  ,
  PrimBaseSearch_BaseSearch_UserType in 'View\BaseSearch\Forms\PrimBaseSearch_BaseSearch_UserType.pas',
  nsBaseSearchFormGUIDFactory in 'View\BaseSearch\nsBaseSearchFormGUIDFactory.pas',
  PrimBaseSearch_Form in 'View\BaseSearch\Forms\PrimBaseSearch_Form.pas',
  PrimBaseSearchOptions_Form in 'View\BaseSearch\Forms\PrimBaseSearchOptions_Form.pas',
  NewBaseSearchForDFM_Form in 'View\BaseSearch\Forms\NewBaseSearchForDFM_Form.pas',
  NewBaseSearch_Form in 'View\BaseSearch\Forms\NewBaseSearch_Form.pas' {NewBaseSearchForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  NewBaseSearchKeywordsPack in 'View\BaseSearch\NewBaseSearchKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType in 'View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType.pas',
  PrimSaveLoadOptionsForBaseSearch_Form in 'View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_Form.pas',
  PrimBaseSearchContainer_Form in 'View\BaseSearch\Forms\PrimBaseSearchContainer_Form.pas',
  BaseSearchContainer_Form in 'View\BaseSearch\Forms\BaseSearchContainer_Form.pas' {BaseSearchContainerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  BaseSearchContainerKeywordsPack in 'View\BaseSearch\BaseSearchContainerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  BaseSearch_Module in 'View\BaseSearch\BaseSearch_Module.pas',
  moBaseSearch in 'View\moBaseSearch.pas' {mo_BaseSearch: TvcmModule},
  Filters_Strange_Controls in 'View\Filters_Strange_Controls.pas',
  nsIFilterFromQueryList in 'View\Filters\nsIFilterFromQueryList.pas',
  PrimFilters_Form in 'View\Filters\Forms\PrimFilters_Form.pas',
  PrimFiltersOptions_Form in 'View\Filters\Forms\PrimFiltersOptions_Form.pas',
  Filters_Form in 'View\Filters\Forms\Filters_Form.pas' {enFilters: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  FiltersKeywordsPack in 'View\Filters\FiltersKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimCreateFilter_cfCreate_UserType in 'View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas',
  FiltersInterfaces in 'Filters\FiltersInterfaces.pas',
  PrimCreateFilter_cfRename_UserType in 'View\Filters\Forms\PrimCreateFilter_cfRename_UserType.pas',
  PrimCreateFilter_Form in 'View\Filters\Forms\PrimCreateFilter_Form.pas',
  CreateFilter_Form in 'View\Filters\Forms\CreateFilter_Form.pas' {CreateFilterForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  CreateFilterKeywordsPack in 'View\Filters\CreateFilterKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  dsCreateFilter in 'Filters\dsCreateFilter.pas',
  Filters_Module in 'View\Filters\Filters_Module.pas',
  moFilters in 'View\moFilters.pas' {mo_Filters: TvcmModule},
  PrimUnderControl_utUnderControl_UserType in 'View\UnderControl\Forms\PrimUnderControl_utUnderControl_UserType.pas',
  PrimUnderControl_Form in 'View\UnderControl\Forms\PrimUnderControl_Form.pas',
  UnderControl_Strange_Controls in 'View\UnderControl_Strange_Controls.pas',
  PrimUnderControlOptions_Form in 'View\UnderControl\Forms\PrimUnderControlOptions_Form.pas',
  UnderControl_Form in 'View\UnderControl\Forms\UnderControl_Form.pas' {enUnderControl: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  UnderControlKeywordsPack in 'View\UnderControl\UnderControlKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  UnderControl_Module in 'View\UnderControl\UnderControl_Module.pas',
  moUnderControl in 'View\moUnderControl.pas' {mo_UnderControl: TvcmModule},
  nsOpenDialog in 'Common\nsOpenDialog.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_DocumentListFromFile_opOpenDocumentListFromFile in 'View\DocumentListFromFile\kw_DocumentListFromFile_opOpenDocumentListFromFile.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimDocumentListFromFile_Module in 'View\DocumentListFromFile\PrimDocumentListFromFile_Module.pas',
  moDocumentListFromFile in 'View\moDocumentListFromFile.pas' {mo_DocumentListFromFile: TvcmModule},
  ChangesBetweenEditionsInterfaces in 'ChangesBetweenEditions\ChangesBetweenEditionsInterfaces.pas',
  PrimChangesBetweenEditons_DocumentChanges_UserType in 'View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_DocumentChanges_UserType.pas',
  PrimChangesBetweenEditons_Form in 'View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_Form.pas',
  ChangesBetweenEditons_Form in 'View\ChangesBetweenEditons\Forms\ChangesBetweenEditons_Form.pas' {ChangesBetweenEditonsForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChangesBetweenEditonsKeywordsPack in 'View\ChangesBetweenEditons\ChangesBetweenEditonsKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  nsChangesBetweenEditionsDocumentContainer in 'ChangesBetweenEditions\nsChangesBetweenEditionsDocumentContainer.pas',
  dsChangesBetweenEditions in 'ChangesBetweenEditions\dsChangesBetweenEditions.pas',
  sdsChangesBetweenEditionsData in 'ChangesBetweenEditions\sdsChangesBetweenEditionsData.pas',
  sdsChangesBetweenEditions in 'ChangesBetweenEditions\sdsChangesBetweenEditions.pas',
  nsChangesBetweenEditionsInfo in 'ChangesBetweenEditions\nsChangesBetweenEditionsInfo.pas',
  fsViewChangedFragments in 'View\ChangesBetweenEditons\fsViewChangedFragments.pas' {fs_ViewChangedFragments: TvcmFormSetFactory},
  ChangesBetweenEditions_Module in 'View\ChangesBetweenEditons\ChangesBetweenEditions_Module.pas',
  moChangesBetweenEditions in 'View\moChangesBetweenEditions.pas' {mo_ChangesBetweenEditions: TvcmModule},
  PrimTreeAttributeFirstLevel_flSituation_UserType in 'View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas',
  PrimTreeAttributeFirstLevel_Form in 'View\Search\Forms\PrimTreeAttributeFirstLevel_Form.pas',
  DefineSearchDateUtils in 'View\Search\DefineSearchDateUtils.pas',
  PrimDefineSearchDate_Form in 'View\Search\Forms\PrimDefineSearchDate_Form.pas',
  DefineSearchDate_ut_DefineSearchDate_UserType in 'View\Search\Forms\DefineSearchDate_ut_DefineSearchDate_UserType.pas',
  DefineSearchDate_Form in 'View\Search\Forms\DefineSearchDate_Form.pas' {en_DefineSearchDate: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DefineSearchDateKeywordsPack in 'View\Search\DefineSearchDateKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  TreeAttributeFirstLevel_Form in 'View\Search\Forms\TreeAttributeFirstLevel_Form.pas' {efTreeAttributeFirstLevel: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TreeAttributeFirstLevelKeywordsPack in 'View\Search\TreeAttributeFirstLevelKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  PrimOldSituationSearch_cutOldKeyWord_UserType in 'View\Search\Forms\PrimOldSituationSearch_cutOldKeyWord_UserType.pas',
  PrimOldSituationSearch_Form in 'View\Search\Forms\PrimOldSituationSearch_Form.pas',
  PrimOldSituationSearchOptions_Form in 'View\Search\Forms\PrimOldSituationSearchOptions_Form.pas',
  OldSituationSearch_Form in 'View\Search\Forms\OldSituationSearch_Form.pas' {cfOldSituationSearch: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  OldSituationSearchKeywordsPack in 'View\Search\OldSituationSearchKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  fsSituationSearch in 'View\Search\fsSituationSearch.pas' {fs_SituationSearch: TvcmFormSetFactory},
  fsSituationFilter in 'View\Search\fsSituationFilter.pas' {fs_SituationFilter: TvcmFormSetFactory},
  dsSelectedAttributes in 'Search\dsSelectedAttributes.pas',
  deSelectedAttributes in 'Search\deSelectedAttributes.pas',
  dsTreeAttributeFirstLevel in 'Search\dsTreeAttributeFirstLevel.pas',
  dsAttributeSelect in 'Search\dsAttributeSelect.pas',
  sdsSituation in 'Search\sdsSituation.pas'
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opPublishSourceSearch in 'View\Search\kw_Search_opPublishSourceSearch.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opInpharmSearch in 'View\Search\kw_Search_opInpharmSearch.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opStartENO in 'View\Search\kw_Search_opStartENO.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opDocumentsWithoutClass in 'View\Search\kw_Search_opDocumentsWithoutClass.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opDocumentsWithoutIncluded in 'View\Search\kw_Search_opDocumentsWithoutIncluded.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opDocumentsWithoutKey in 'View\Search\kw_Search_opDocumentsWithoutKey.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opBaseSearch in 'View\Search\kw_Search_opBaseSearch.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opOpenConsult in 'View\Search\kw_Search_opOpenConsult.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opAllSearch in 'View\Search\kw_Search_opAllSearch.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opOpenKeyWordSearch in 'View\Search\kw_Search_opOpenKeyWordSearch.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Search_opAttributeSearch in 'View\Search\kw_Search_opAttributeSearch.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  Search_Module in 'View\Search\Search_Module.pas',
  moSearch in 'View\moSearch.pas' {mo_Search: TvcmModule},
  AACContainer_Form in 'View\AAC\Forms\AACContainer_Form.pas' {AACContainerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AACContainerKeywordsPack in 'View\AAC\AACContainerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  AACContentsContainer_Form in 'View\AAC\Forms\AACContentsContainer_Form.pas' {AACContentsContainerForm: TvcmEntityForm}
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AACContentsContainerKeywordsPack in 'View\AAC\AACContentsContainerKeywordsPack.pas'
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  dsAACContainer in 'AAC\dsAACContainer.pas',
  dsAACDocumentPrim in 'AAC\dsAACDocumentPrim.pas',
  nsAACLeftDocumentContainer in 'AAC\nsAACLeftDocumentContainer.pas',
  dsAACDocumentLeft in 'AAC\dsAACDocumentLeft.pas',
  nsAACRightDocumentContainer in 'AAC\nsAACRightDocumentContainer.pas',
  dsAACDocumentRight in 'AAC\dsAACDocumentRight.pas',
  sdsAAC in 'AAC\sdsAAC.pas',
  fsAACContents in 'View\AAC\fsAACContents.pas' {fs_AACContents: TvcmFormSetFactory},
  fsAAC in 'View\AAC\fsAAC.pas' {fs_AAC: TvcmFormSetFactory},
  AACPrim_Module in 'View\AAC\AACPrim_Module.pas',
  moAAC in 'View\moAAC.pas' {mo_AAC: TvcmModule},
  moCommonPost in 'View\moCommonPost.pas' {mo_CommonPost: TvcmModule},
  evdHyperlinkEliminator in 'w:\common\components\rtl\Garant\EVD\evdHyperlinkEliminator.pas',
  evdScriptHyperlinkEliminator in 'w:\common\components\gui\Garant\Everest\evdScriptHyperlinkEliminator.pas',
  evExtFormat in 'w:\common\components\gui\Garant\Everest\ext\evExtFormat.pas',
  NemesisRes in 'NemesisRes.pas' {NemesisRes: TDataModule}
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  tfwScriptDebugger in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptDebugger.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
  ,
  l3ComponentInfoHelper in 'w:\common\components\rtl\Garant\L3\l3ComponentInfoHelper.pas',
  toK in 'toK.pas',
  ItsLAW in 'ItsLAW.pas',
  toK64 in 'toK64.pas',
  toKT in 'toKT.pas',
  BaseUC in 'BaseUC.pas',
  toK2 in 'toK2.pas',
  toK3 in 'toK3.pas',
  NemesisTestRes in 'NemesisTestRes.pas' {NemesisTestRes: TDataModule}
  ;
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

{$R NemesisAppTest.res}

begin
 {$IfDef nsTest}
 g_CVSPath := 'w:\garant6x\implementation\Garant\GbaNemesis';
 {$EndIf nsTest}
 //#UC START# *4D9F2DB20054CVSPath*
 //#UC END# *4D9F2DB20054CVSPath*
 TF1AutoTestSuite.Register;
 StdRes.TdmStdRes.Run(str_NemesisTitle, 'F1Shell.chm');
end.