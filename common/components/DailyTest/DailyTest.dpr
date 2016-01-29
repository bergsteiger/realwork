program DailyTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/DailyTest/DailyTest.dpr"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestTarget::Category>> Shared Delphi Tests::Daily$Test
//
// Ежедневные тесты нашей библиотеки компонент
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DailyTest\DailyTest.inc}

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ControlResizeBugFix,
  ObjectFromstackWords in 'w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas',
  l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas',
  SysUtils,
  tfwScriptingExceptions in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas',
  TypInfo {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas' {$EndIf},
  Types,
  Windows {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas' {$EndIf},
  ActiveX {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas' {$EndIf},
  Messages {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas' {$EndIf},
  Classes {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas' {$EndIf},
  ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas',
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
  l3Units in 'w:\common\components\rtl\Garant\L3\l3Units.pas',
  FontWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas',
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
  l3Variants in 'w:\common\components\rtl\Garant\L3\l3Variants.pas',
  kwFiltersAndGeneratorsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas',
  l3ProtoObjectWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas',
  l3SimpleObject in 'w:\common\components\rtl\Garant\L3\l3SimpleObject.pas',
  l3_Base in 'w:\common\components\rtl\Garant\L3\l3_Base.pas',
  l3ProtoIntegerList in 'w:\common\components\rtl\Garant\L3\l3ProtoIntegerList.pas',
  k2PropertyArray in 'w:\common\components\rtl\Garant\K2\k2PropertyArray.pas',
  k2TypeTableCreatedListeners in 'w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas',
  l3String in 'w:\common\components\rtl\Garant\L3\l3String.pas',
  l3Chars in 'w:\common\components\rtl\Garant\L3\l3Chars.pas',
  k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas',
  k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas',
  k2Empty_Const in 'w:\common\components\rtl\Garant\K2\k2Empty_Const.pas',
  k2Attributes in 'w:\common\components\rtl\Garant\K2\k2Attributes.pas',
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
  l3Variant in 'w:\common\components\rtl\Garant\L3\l3Variant.pas',
  tfwDictionaryPrimPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrimPrim.pas',
  tfwDictionaryPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas',
  tfwDictionaryPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrim.pas',
  tfwKeyWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeyWordPrim.pas',
  StrUtils {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas' {$EndIf},
  l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas',
  l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas',
  tfwCStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringListPrim.pas',
  tfwCStringList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringList.pas',
  tfwCStringArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas',
  tfwCStringArraySing in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas',
  tfwCStringArraySing2 in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas',
  tfwCStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringFactory.pas',
  tfwClassRef in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassRef.pas',
  ItfwParserWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas',
  tfwWordRefList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas',
  kwSourcePointWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSourcePointWord.pas',
  kwCompiledWordPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrimPrim.pas',
  kwCompiledWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrim.pas',
  tfwClassLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassLike.pas',
  tfwPropertyLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwPropertyLike.pas',
  ItfwKeywordFinderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas',
  ItfwParserExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas',
  tfwParserInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas',
  tfwStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStreamFactory.pas',
  kwModifier in 'w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas',
  tfwTypeModifier in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeModifier.pas',
  tfwRTTIProperty in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTIProperty.pas',
  ArrayProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ArrayProcessingPack.pas',
  Math {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas' {$EndIf},
  tfwDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionary.pas',
  tfwDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryWordsPack.pas',
  tfwIteratableParent in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas',
  tfwMembersIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIteratorPrim.pas',
  tfwMembersIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIterator.pas',
  tfwDictionaryExPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExPrim.pas',
  tfwDictionaryPtrList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrList.pas',
  tfwInitedDictionariesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesList.pas',
  kwForwardDeclarationHolder in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclarationHolder.pas',
  tfwStandardDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionary.pas',
  tfwStandardDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListPrim.pas',
  tfwStandardDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryList.pas',
  tfwStandardDictionaries in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaries.pas',
  tfwIl3CStringPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas',
  tfwAutoregisteredDiction in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAutoregisteredDiction.pas',
  tfwInitCodeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitCodeWord.pas',
  tfwDictionaryEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryEx.pas',
  tfwDictionaryExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExWordsPack.pas',
  tfwDictionaryDataIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryDataIteratorPrim.pas',
  tfwDictionaryPtrListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrListIterator.pas',
  tfwExportedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwExportedDictionariesIterator.pas',
  tfwUsedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwUsedDictionariesIterator.pas',
  l3DateSt in 'w:\common\components\rtl\Garant\L3\l3DateSt.pas',
  tfwMainDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryList.pas'
  {$If defined(seCacheDict) AND not defined(NoScripts)}
  ,
  tfwMainDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryCache.pas'
  {$IfEnd} //seCacheDict AND not NoScripts
  ,
  tfwDictionaryCachePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCachePrim.pas'
  {$If defined(seCacheDict) AND not defined(NoScripts)}
  ,
  tfwDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCache.pas'
  {$IfEnd} //seCacheDict AND not NoScripts
  ,
  tfwKeywordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeywordsIterator.pas',
  tfwMainDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionary.pas',
  tfwMainDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryWordsPack.pas',
  tfwDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.pas',
  tfwScriptEngineExInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineExInterfaces.pas',
  kwRuntimeWordWithCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCode.pas',
  kwRuntimeWordWithCodeExecution in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCodeExecution.pas',
  tfwValueList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueList.pas',
  tfwArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArray.pas',
  kwCompiledVar in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.pas',
  tfwStoredValues in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas',
  tfwScriptingTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingTypes.pas',
  tfwScriptingInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingInterfaces.pas',
  kwLeftParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwLeftParam.pas',
  kwCompiledWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWord.pas',
  kwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\kwInteger.pas',
  kwString in 'w:\common\components\rtl\Garant\ScriptEngine\kwString.pas',
  kwForwardDeclaration in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclaration.pas',
  KeyWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyWordPack.pas',
  l3ParserInterfaces in 'w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas',
  kwIntegerList in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerList.pas',
  kwIntegerArray in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerArray.pas',
  kwIntegerFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerFactory.pas',
  kwStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringListPrim.pas',
  kwStringList in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringList.pas',
  kwStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringFactory.pas',
  tfwCompilingWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompilingWord.pas',
  tfwAnonimousWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAnonimousWord.pas',
  kwBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginLikeCompiledCode.pas',
  tfwBeginLikeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwBeginLikeWord.pas',
  kwCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwCloseBracket.pas',
  tfwAxiomaticsResNameGetterList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetterList.pas',
  tfwAxiomaticsResNameGetters in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas',
  tfwAxiomaticsResNameGetter in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetter.pas',
  tfwArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArrayView.pas',
  tfwRevertedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRevertedArrayView.pas',
  kwCompiledWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas',
  tfwLambdedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwLambdedArrayView.pas',
  tfwFilteredArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFilteredArrayView.pas',
  tfwMappedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMappedArrayView.pas',
  tfwIteratorFromFunctor in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratorFromFunctor.pas',
  tfwJoinIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwJoinIterator.pas',
  tfwTruncatedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTruncatedArrayView.pas',
  tfwSliceView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSliceView.pas',
  BasicsPack in 'w:\common\components\rtl\Garant\ScriptEngine\BasicsPack.pas',
  l3MessagesService in 'w:\common\components\rtl\Garant\L3\l3MessagesService.pas',
  tfwEnumRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumRegistrator.pas',
  tfwRTTITypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTITypeInfoList.pas',
  tfwRegisteredEnums in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisteredEnums.pas',
  tfwStringToEnumValue in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringToEnumValue.pas',
  tfwIntegerToEnumName in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerToEnumName.pas',
  tfwTypeRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeRegistrator.pas',
  tfwString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwString.pas',
  tfwStringConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringConstantRegistrator.pas',
  tfwInterfaceRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInterfaceRegistrator.pas',
  l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas',
  kwValue in 'w:\common\components\rtl\Garant\ScriptEngine\kwValue.pas',
  kwWordPtrWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrWorker.pas',
  kwWordPtrPushWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrPushWord.pas',
  FileProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FileProcessingPack.pas',
  l3InterfacedComponent in 'w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas',
  l3ProgressComponent in 'w:\common\components\rtl\Garant\L3\l3ProgressComponent.pas',
  l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas',
  l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas',
  l3CProtoObject in 'w:\common\components\rtl\Garant\L3\l3CProtoObject.pas',
  kwTemporaryCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTemporaryCompiledCode.pas',
  tfwWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorker.pas',
  kwCompiledWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerEx.pas',
  tfwWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorkerEx.pas',
  tfwGlobalKeyWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwGlobalKeyWord.pas',
  l3FileUtils in 'w:\common\components\rtl\Garant\L3\l3FileUtils.pas',
  SysUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SysUtilsPack.pas',
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
  ,
  kwObjectFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwObjectFromStackWord.pas',
  kwComponentFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas'
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
  l3CStringDataObject in 'w:\common\components\rtl\Garant\L3\l3CStringDataObject.pas',
  WordsRTTIPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsRTTIPack.pas',
  seWordsInfo in 'w:\common\components\rtl\Garant\ScriptEngine\seWordsInfo.pas',
  tfwWordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordsIterator.pas',
  tfwCodeIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCodeIterator.pas',
  kwCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordContainer.pas',
  kwDualCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwDualCompiledWordContainer.pas',
  tfwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInteger.pas',
  tfwIntegerConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerConstantRegistrator.pas',
  tfwEnumConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumConstantRegistrator.pas',
  TypeInfoPack in 'w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas',
  tfwStandardDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListIterator.pas',
  tfwInitedDictionariesListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesListIterator.pas',
  tfwDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.pas',
  VarWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VarWorkingPack.pas',
  tfwTypeInfo in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfo.pas',
  tfwTypeInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoListPrim.pas',
  tfwTypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas',
  tfwValueTypesListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesListPrim.pas',
  tfwValueTypesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesList.pas',
  tfwValueTypesCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesCache.pas',
  tfwValueTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypes.pas',
  tfwValueTypesWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesWordsPack.pas',
  tfwWordInfoWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoWordsPack.pas',
  ItfwScriptEngineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwScriptEngineWordsPack.pas',
  tfwWordInfoCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoCache.pas',
  tfwWordInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoListPrim.pas',
  tfwWordInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoList.pas',
  NewWordDefinitorPack in 'w:\common\components\rtl\Garant\ScriptEngine\NewWordDefinitorPack.pas',
  ItfwCompilerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas',
  tfwRegisterableWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWordPrim.pas',
  tfwRegisterableWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas',
  kwPopClassInherits in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopClassInherits.pas',
  l3RTTI in 'w:\common\components\rtl\Garant\L3\l3RTTI.pas',
  l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas',
  l3ObjectRefList1 in 'w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas',
  SyncObjs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\SyncObjs.pas' {$EndIf},
  l3SimpleMemoryManagerPrim in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManagerPrim.pas',
  l3ExceptionsLog in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLog.pas',
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
  TextTestRunner in 'w:\common\components\rtl\external\DUnit\src\TextTestRunner.pas',
  l3NodesKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\l3NodesKeyWordsPack.pas',
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
  evdStyles in 'w:\common\components\rtl\Garant\EVD\evdStyles.pas',
  InterfacedNodeWords in 'w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas',
  l3Tree_TLB in 'w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas',
  evdTypes in 'w:\common\components\rtl\Garant\EVD\evdTypes.pas',
  evdInterfaces in 'w:\common\components\rtl\Garant\EVD\evdInterfaces.pas',
  evResultFont in 'w:\common\components\gui\Garant\Everest\evResultFont.pas',
  evResultFontInterfaces in 'w:\common\components\gui\Garant\Everest\evResultFontInterfaces.pas',
  nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas',
  evParaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas',
  k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas',
  evTypes in 'w:\common\components\gui\Garant\Everest\evTypes.pas',
  nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas',
  l3Defaults in 'w:\common\components\rtl\Garant\L3\l3Defaults.pas',
  evDef in 'w:\common\components\gui\Garant\Everest\evDef.pas',
  evCustomTextSource in 'w:\common\components\gui\Garant\Everest\evCustomTextSource.pas',
  evExcept in 'w:\common\components\gui\Garant\Everest\evExcept.pas',
  nevBasePointList in 'w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas',
  l3RectList in 'w:\common\components\rtl\Garant\L3\l3RectList.pas',
  l3CanvasPrim in 'w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas',
  l3LineArray in 'w:\common\components\rtl\Garant\L3\l3LineArray.pas',
  l3Region in 'w:\common\components\rtl\Garant\L3\l3Region.pas',
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
  mdpSyncDicts_Const in 'w:\common\components\rtl\Garant\EVD\mdpSyncDicts_Const.pas',
  mdpImportDocs_Const in 'w:\common\components\rtl\Garant\EVD\mdpImportDocs_Const.pas',
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
  IedTableWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas',
  IedRangeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedRangeWordsPack.pas',
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
  Formula_Const in 'w:\common\components\gui\Garant\Everest\Formula_Const.pas',
  DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas'
  {$If defined(k2ForEditor)}
  ,
  evParaTools in 'w:\common\components\gui\Garant\Everest\evParaTools.pas'
  {$IfEnd} //k2ForEditor
  ,
  ReqGroup_Const in 'w:\common\components\gui\Garant\Everest\ReqGroup_Const.pas'
  {$If defined(k2ForEditor)}
  ,
  evControlPara_Wrap in 'w:\common\components\gui\Garant\Everest\evControlPara_Wrap.pas'
  {$IfEnd} //k2ForEditor
  ,
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
  evReqGroup_Wrap in 'w:\common\components\gui\Garant\Everest\evReqGroup_Wrap.pas'
  {$If defined(k2ForEditor)}
  ,
  evLeafPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evLeafPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevLeafPara in 'w:\common\components\gui\Garant\Everest\new\nevLeafPara.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTabStops in 'w:\common\components\gui\Garant\Everest\new\evTabStops.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevParaPrim in 'w:\common\components\gui\Garant\Everest\new\nevParaPrim.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevPara in 'w:\common\components\gui\Garant\Everest\new\nevPara.pas'
  {$IfEnd} //k2ForEditor
  
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
  ShellAPI {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShellAPI.pas' {$EndIf}
  {$If defined(k2ForEditor)}
  ,
  evSegLst in 'w:\common\components\gui\Garant\Everest\evSegLst.pas'
  {$IfEnd} //k2ForEditor
  ,
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
  
  {$If defined(k2ForEditor)}
  ,
  nevLeafParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevLeafParaAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevAnchor in 'w:\common\components\gui\Garant\Everest\new\nevAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  nevLeafParaInevLeafParaMapper in 'w:\common\components\gui\Garant\Everest\new\nevLeafParaInevLeafParaMapper.pas'
  {$IfEnd} //k2ForEditor
  ,
  k2InterfaceMapper in 'w:\common\components\rtl\Garant\K2\k2InterfaceMapper.pas',
  nevRealTools in 'w:\common\components\gui\Garant\Everest\new\nevRealTools.pas',
  nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas'
  {$If defined(k2ForEditor)}
  ,
  evTextPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evTextPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaCursor in 'w:\common\components\gui\Garant\Everest\evTextParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  ,
  k2InterfacesEx in 'w:\common\components\rtl\Garant\K2\k2InterfacesEx.pas',
  evSegOp in 'w:\common\components\gui\Garant\Everest\evSegOp.pas',
  l3SingleLineInfo in 'w:\common\components\rtl\Garant\L3\l3SingleLineInfo.pas',
  nevSegmentObject in 'w:\common\components\gui\Garant\Everest\nevSegmentObject.pas'
  {$If defined(k2ForEditor)}
  ,
  evAlignBySeparatorUtils in 'w:\common\components\gui\Garant\Everest\evAlignBySeparatorUtils.pas'
  {$IfEnd} //k2ForEditor
  ,
  evParaString in 'w:\common\components\gui\Garant\Everest\evParaString.pas',
  nevStringCache in 'w:\common\components\gui\Garant\Everest\nevStringCache.pas',
  k2SimpleTagList in 'w:\common\components\rtl\Garant\K2\k2SimpleTagList.pas',
  k2InterfacedTagList in 'w:\common\components\rtl\Garant\K2\k2InterfacedTagList.pas'
  {$If defined(k2ForEditor)}
  ,
  evChangeCodePage in 'w:\common\components\gui\Garant\Everest\evChangeCodePage.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTextParaTools in 'w:\common\components\gui\Garant\Everest\evTextParaTools.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  evTableCellUtils in 'w:\common\components\gui\Garant\Everest\evTableCellUtils.pas'
  {$IfEnd} //k2ForEditor
  
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
  
  {$If defined(k2ForEditor)}
  ,
  evAACContentUtils in 'w:\common\components\gui\Garant\Everest\evAACContentUtils.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evAACTextPainter in 'w:\common\components\gui\Garant\Everest\evAACTextPainter.pas'
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
  ,
  evStandardStylesListPrim in 'w:\common\components\gui\Garant\Everest\evStandardStylesListPrim.pas',
  evResultFontHolder in 'w:\common\components\gui\Garant\Everest\evResultFontHolder.pas',
  evStandardStylesList in 'w:\common\components\gui\Garant\Everest\evStandardStylesList.pas',
  evStandardStyles in 'w:\common\components\gui\Garant\Everest\evStandardStyles.pas',
  evCustomFont in 'w:\common\components\gui\Garant\Everest\evCustomFont.pas',
  evGlyphFont in 'w:\common\components\gui\Garant\Everest\evGlyphFont.pas',
  evdStylesRes in 'w:\common\components\rtl\Garant\EVD\evdStylesRes.pas' {evdStyles_Res: TDataModule},
  l3ImageList in 'w:\common\components\rtl\Garant\L3\l3ImageList.pas',
  nevFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfo.pas',
  SBS_Const in 'w:\common\components\gui\Garant\Everest\SBS_Const.pas',
  nevFormatInfoList in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoList.pas',
  nevFormatInfoArray in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoArray.pas',
  nevParaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevParaFormatInfo.pas',
  nevLeafRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevLeafRenderInfo.pas',
  nevTextParaRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTextParaRenderInfo.pas',
  nevTableRowRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas',
  nevRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevRubberCellsRenderInfo.pas',
  nevZoomedCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedCellsRenderInfo.pas',
  nevZoomedRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedRubberCellsRenderInfo.pas',
  evSectionPara in 'w:\common\components\gui\Garant\Everest\new\evSectionPara.pas',
  nevListFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevListFormatInfo.pas',
  nevTableCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas',
  nevDocumentPartFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPartFormatInfo.pas',
  nevCommentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevCommentFormatInfo.pas',
  nevBitmapFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevBitmapFormatInfo.pas',
  nevControlFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevControlFormatInfo.pas',
  evFormulaParaBitmapContainer in 'w:\common\components\rtl\Garant\EVD\evFormulaParaBitmapContainer.pas',
  nevFormulaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormulaFormatInfo.pas',
  nevControlsBlockFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockFormatInfo.pas',
  nevCloakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevCloakFormatInfo.pas',
  nevSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSegmentFormatInfo.pas',
  nevObjectSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevObjectSegmentFormatInfo.pas',
  nevDocumentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentFormatInfo.pas',
  nevSBSCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSCellFormatInfo.pas',
  nevSBSRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSRowFormatInfo.pas',
  nevTableRowRenderInfoEx in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfoEx.pas',
  nevReqRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevReqRowFormatInfo.pas',
  nevPageBreakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevPageBreakFormatInfo.pas',
  nevNodeGroupFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevNodeGroupFormatInfo.pas',
  NodeGroup_Const in 'w:\common\components\gui\Garant\Everest\NodeGroup_Const.pas',
  nevFormatInfoFactory in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoFactory.pas'
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
  
  {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
  ,
  evDeadCursor in 'w:\common\components\gui\Garant\Everest\evDeadCursor.pas'
  {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
  
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
  l3VirtualCanvas in 'w:\common\components\rtl\Garant\L3\l3VirtualCanvas.pas',
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
  evOpProc in 'w:\common\components\gui\Garant\Everest\evOpProc.pas',
  evStyleTableFontSizeCorrector in 'w:\common\components\gui\Garant\Everest\evStyleTableFontSizeCorrector.pas',
  evStyleInterfaceEx in 'w:\common\components\gui\Garant\Everest\evStyleInterfaceEx.pas',
  StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas',
  TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas',
  l3Nodes in 'w:\common\components\rtl\Garant\L3\l3Nodes.pas',
  evStyleInterface in 'w:\common\components\gui\Garant\Everest\evStyleInterface.pas'
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy in 'w:\common\components\gui\Garant\Everest\evStyleTableSpy.pas'
  {$IfEnd} //not DesignTimeLibrary
  ,
  nevFormatPoolBase in 'w:\common\components\gui\Garant\Everest\new\nevFormatPoolBase.pas',
  Printers {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Printers.pas' {$EndIf},
  l3ScreenIC in 'w:\common\components\rtl\Garant\L3\l3ScreenIC.pas',
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
  l3DatLst in 'w:\common\components\rtl\Garant\L3\l3DatLst.pas',
  l3Bits in 'w:\common\components\rtl\Garant\L3\l3Bits.pas',
  l3NodesModelPart in 'w:\common\components\rtl\Garant\L3\l3NodesModelPart.pas',
  evNode in 'w:\common\components\gui\Garant\Everest\new\evNode.pas',
  evSubNode in 'w:\common\components\gui\Garant\Everest\new\evSubNode.pas',
  nevDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainer.pas',
  evDefaultContext in 'w:\common\components\gui\Garant\Everest\evDefaultContext.pas',
  evDocumentContainerWithProcessor in 'w:\common\components\gui\Garant\Everest\new\evDocumentContainerWithProcessor.pas',
  nevPersistentDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPersistentDocumentContainer.pas'
  {$If defined(evUseVisibleCursors)}
  ,
  evLocationBase in 'w:\common\components\gui\Garant\Everest\evLocationBase.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evPara_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4AnchorMapper in 'w:\common\components\gui\Garant\Everest\evInevBaseLine4AnchorMapper.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4PrintMapper in 'w:\common\components\gui\Garant\Everest\evInevBaseLine4PrintMapper.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  evIevAnchorIndexMapper in 'w:\common\components\gui\Garant\Everest\new\evIevAnchorIndexMapper.pas'
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
  evPageBreak_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evPageBreak_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(evNeedPainters)}
  ,
  evPageBreakPainter in 'w:\common\components\gui\Garant\Everest\evPageBreakPainter.pas'
  {$IfEnd} //evNeedPainters
  
  {$If defined(evUseVisibleCursors)}
  ,
  evBreakParaCursor in 'w:\common\components\gui\Garant\Everest\evBreakParaCursor.pas'
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(k2ForEditor)}
  ,
  nevBreakParaAnchor in 'w:\common\components\gui\Garant\Everest\new\nevBreakParaAnchor.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evSectionBreak_InterfaceFactory in 'w:\common\components\gui\Garant\Everest\evSectionBreak_InterfaceFactory.pas'
  {$IfEnd} //k2ForEditor
  
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
  l3WinControlCanvas in 'w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas',
  RadioButtonWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas',
  vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas',
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
  evCustomEditorWindowPrim in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowPrim.pas',
  evSchemaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas',
  kwRegisterSchema in 'w:\common\components\rtl\Garant\ScriptEngine\kwRegisterSchema.pas',
  kwStyleTableSaveToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableSaveToFile.pas',
  kwStyleTableChanging in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanging.pas',
  kwStyleTableChanged in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanged.pas',
  tfwSysUtilsWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSysUtilsWord.pas',
  evEvdRd in 'w:\common\components\gui\Garant\Everest\evEvdRd.pas',
  kwEvdBin2EvdTxt in 'w:\common\components\rtl\Garant\ScriptEngine\kwEvdBin2EvdTxt.pas',
  tfwClipboardFormatWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClipboardFormatWord.pas',
  kwCFHTML in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFHTML.pas',
  kwCFXML in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFXML.pas',
  kwCFEVEREST in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFEVEREST.pas',
  kwCFRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFRTF.pas',
  kwCFEVERESTBIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFEVERESTBIN.pas',
  kwCFPDF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFPDF.pas',
  EditorFromStackKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorFromStackKeyWordsPack.pas',
  kwEditorFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackWord.pas',
  kwSelectCellsWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSelectCellsWord.pas',
  kwPopEditorSelectCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas',
  kwPopEditorWheelScroll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas',
  kwPopEditorSelectColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectColumn.pas',
  kwPopEditorSelectCellsVertical in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas',
  kwPopEditorJumpToHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas',
  l3FrameLine in 'w:\common\components\rtl\Garant\L3\l3FrameLine.pas',
  l3FrameLineList in 'w:\common\components\rtl\Garant\L3\l3FrameLineList.pas',
  l3InterfacedIntegerList in 'w:\common\components\rtl\Garant\L3\l3InterfacedIntegerList.pas',
  l3CoordinateMap in 'w:\common\components\rtl\Garant\L3\l3CoordinateMap.pas',
  l3FrameObject in 'w:\common\components\rtl\Garant\L3\l3FrameObject.pas',
  l3FrameLinesSpy in 'w:\common\components\rtl\Garant\L3\l3FrameLinesSpy.pas',
  kwPopEditorRepaintTableLinesAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintTableLinesAndCheckWithEtalon.pas',
  kwPopEditorPrintAcnhor in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintAcnhor.pas',
  nevFormatInfoUtils in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoUtils.pas',
  kwPopEditorPrintTableCellsParams in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintTableCellsParams.pas',
  kwPopEditorLP2DP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorLP2DP.pas',
  kwPopEditorDP2LP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDP2LP.pas',
  evTableSearch in 'w:\common\components\gui\Garant\EverestCommon\evTableSearch.pas',
  kwPopEditorCheckContinueCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckContinueCells.pas',
  kwPopEditorGetLeftIndentDelta in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLeftIndentDelta.pas',
  kwEditorFromStackCursorWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWord.pas',
  kwPopEditorParaDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaDown.pas',
  kwPopEditorParaUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaUp.pas',
  kwPopEditorParaEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEnd.pas',
  kwPopEditorParaHome in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaHome.pas',
  kwPopEditorSelectTable in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectTable.pas',
  kwEditorFromStackTextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTextParaWord.pas',
  kwEditorFromStackNextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackNextParaWord.pas',
  kwPopEditorHasComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorHasComment.pas',
  kwPopEditorDeleteUserComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDeleteUserComment.pas',
  kwPopEditorCurrentText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCurrentText.pas',
  kwPopEditorUpdateCursorFromHotSpot in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpot.pas',
  kwPopEditorUpdateCursorFromHotSpotEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpotEx.pas',
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
  l3PicturePathService in 'w:\common\components\rtl\Garant\L3\l3PicturePathService.pas',
  PictureEtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas',
  ddConst in 'w:\common\components\rtl\Garant\dd\ddConst.pas',
  ddUtils in 'w:\common\components\rtl\Garant\dd\ddUtils.pas',
  ddPicturePathListner in 'w:\common\components\rtl\Garant\dd\ddPicturePathListner.pas',
  evBitmapEliminator4Tests in 'w:\common\components\gui\Garant\Everest\evBitmapEliminator4Tests.pas',
  kwPopEditorTextToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorTextToFile.pas',
  kwPopEditorGetSelectionText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionText.pas',
  kwPopEditorGetParaByID in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetParaByID.pas',
  evdHeaderHyperlinkAdder in 'w:\common\components\gui\Garant\Everest\evdHeaderHyperlinkAdder.pas',
  evdBlockNameAdder in 'w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas',
  kwPopEditorGetSelectionTextInFormat in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionTextInFormat.pas',
  kwBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwBlockResize.pas',
  kwPopEditorBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResize.pas',
  kwPopEditorSelectCellByMouse in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellByMouse.pas',
  kwPopEditorSetTextParaStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetTextParaStyle.pas',
  kwPopEditorSetCursorByPoint in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetCursorByPoint.pas',
  kwPopEditorRepaintAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas',
  kwPopEditorCopyAndPaste2DocumentBottom in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCopyAndPaste2DocumentBottom.pas',
  kwEditorFromStackTableColumnResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTableColumnResize.pas',
  kwPopEditorResizeTableColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas',
  kwPopEditorResizeTableColumnEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumnEX.pas',
  kwCompiledCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCheckWithEtalon.pas',
  kwPopEditorCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckWithEtalon.pas',
  kwPopEditorGetLMargin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLMargin.pas',
  kwPopEditorGetWrapLimit in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetWrapLimit.pas',
  kwPopEditorBlockResizeEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResizeEX.pas',
  kwInsertFromStreamCommon in 'w:\common\components\rtl\Garant\ScriptEngine\kwInsertFromStreamCommon.pas',
  kwPopEditorPasteRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteRTF.pas',
  kwPopEditorInsertStream in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertStream.pas',
  kwPopEditorPasteEVDTroughClipboard in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteEVDTroughClipboard.pas',
  l3MetafileHeader in 'w:\common\components\rtl\Garant\L3\l3MetafileHeader.pas',
  l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas',
  afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas',
  l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas',
  afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas',
  afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
  {$If defined(InsiderTest)}
  ,
  evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
  {$IfEnd} //InsiderTest
  
  {$If defined(InsiderTest) AND not defined(NoScripts)}
  ,
  kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
  {$IfEnd} //InsiderTest AND not NoScripts
  ,
  kwBeginWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginWaitPrint.pas',
  kwEndWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas',
  TevCustomEditorWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TevCustomEditorWordsPack.pas',
  EditorParaCoordsToScreenPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorParaCoordsToScreenPack.pas',
  kwParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreen.pas',
  kwPopEditorParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaCoordsToScreen.pas',
  kwPopEditorParaEndCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEndCoordsToScreen.pas',
  kwPopEditorParaMiddleCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaMiddleCoordsToScreen.pas',
  kwPopEditorCursorCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCursorCoordsToScreen.pas',
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
  l3AFWExceptions in 'w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas',
  l3ScriptService in 'w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas',
  l3ModalService in 'w:\common\components\rtl\Garant\L3\l3ModalService.pas',
  l3BatchService in 'w:\common\components\rtl\Garant\L3\l3BatchService.pas',
  afwAnswer in 'w:\common\components\rtl\Garant\L3\afwAnswer.pas',
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
  l3FontTools in 'w:\common\components\rtl\Garant\L3\l3FontTools.pas',
  OvcData in 'w:\common\components\rtl\external\Orpheus\OvcData.pas',
  OvcExcpt in 'w:\common\components\rtl\external\Orpheus\OvcExcpt.pas',
  vtStdRes in 'w:\common\components\gui\Garant\VT\vtStdRes.pas' {vtStdResources: TDataModule},
  l3TabStops in 'w:\common\components\rtl\Garant\L3\l3TabStops.pas',
  l3FormattedLines in 'w:\common\components\rtl\Garant\L3\l3FormattedLines.pas',
  vtHintManager in 'w:\common\components\gui\Garant\VT\vtHintManager.pas',
  vtHintWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas',
  vtMultilineHint in 'w:\common\components\gui\Garant\VT\vtMultilineHint.pas',
  ListerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas',
  vtLister in 'w:\common\components\gui\Garant\VT\vtLister.pas',
  vtTreeSource in 'w:\common\components\gui\Garant\VT\vtTreeSource.pas',
  vtOutlinerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas',
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
  vtComboTree in 'w:\common\components\gui\Garant\VT\ComboTree\vtComboTree.pas',
  vtComboTreeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboTreeWordsPack.pas',
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
  tfwStringStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringStreamFactory.pas',
  kwEmitString in 'w:\common\components\rtl\Garant\ScriptEngine\kwEmitString.pas',
  tfwDualWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDualWord.pas',
  kwCompiledTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryFinally.pas',
  kwCompiledTryExcept in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryExcept.pas',
  kwEND in 'w:\common\components\rtl\Garant\ScriptEngine\kwEND.pas',
  kwMedianBacket in 'w:\common\components\rtl\Garant\ScriptEngine\kwMedianBacket.pas',
  kwFINALLY in 'w:\common\components\rtl\Garant\ScriptEngine\kwFINALLY.pas',
  kwEXCEPT in 'w:\common\components\rtl\Garant\ScriptEngine\kwEXCEPT.pas',
  kwTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwTryFinally.pas',
  tfwValueStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueStack.pas',
  tfwSourcePointList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSourcePointList.pas',
  tfwDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.pas',
  tfwDictionaryStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryStack.pas',
  tfwCachedTokens in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCachedTokens.pas',
  tfwParser in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParser.pas',
  tfwStoredValuesStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas',
  seThreadSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seThreadSupport.pas',
  tfwScriptEnginePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEnginePrim.pas',
  kwCompiledIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIncluded.pas',
  kwIncludedPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncludedPrim.pas',
  tfwCOMStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCOMStreamFactory.pas',
  kwSystemIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwSystemIncluded.pas',
  kwCompiledMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledMain.pas',
  l3EtalonsService in 'w:\common\components\rtl\Garant\L3\l3EtalonsService.pas',
  tfwResourceStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwResourceStreamFactory.pas',
  tfwCompiledAxiomaticsRes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompiledAxiomaticsRes.pas',
  kwMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwMain.pas',
  tfwScriptEngine in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngine.pas'
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit
  ,
  CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas',
  AutoTestSuiteWithDUnitSupport in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestSuiteWithDUnitSupport.pas',
  l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas',
  CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas',
  AutoTest in 'w:\common\components\rtl\Garant\ScriptTestLibrary\AutoTest.pas',
  DailyAutoTest in 'w:\common\components\rtl\Garant\DUnit_Script_Support\DailyAutoTest.pas',
  AutoTestsSuite in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestsSuite.pas',
  seModalWorker in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorker.pas',
  seModalWorkerListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerListPrim.pas',
  seModalWorkerList in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas',
  seModalSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seModalSupport.pas',
  CodeFlowWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeFlowWordsPack.pas',
  tfwNewWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwNewWord.pas',
  kwFORWARD in 'w:\common\components\rtl\Garant\ScriptEngine\kwFORWARD.pas',
  CompilationPack in 'w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas',
  kwStandardProcedureCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwStandardProcedureCloseBracket.pas',
  kwCompiledWordWorkerWordRunner in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordRunner.pas',
  kwCompiledWordWorkerWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWord.pas',
  kwCompiledWordWorkerWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordPack.pas',
  kwCompiledProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedure.pas',
  kwCompiledProcedureWithStackChecking in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas',
  kwCompiledFunction in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledFunction.pas',
  kwInlinedWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwInlinedWord.pas',
  tfwProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\tfwProcedure.pas',
  WordsDefinitionPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsDefinitionPack.pas',
  kwIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncluded.pas',
  tfwIncludeLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIncludeLike.pas',
  kwUsesLike in 'w:\common\components\rtl\Garant\ScriptEngine\kwUsesLike.pas',
  kwInclude in 'w:\common\components\rtl\Garant\ScriptEngine\kwInclude.pas',
  kwUses in 'w:\common\components\rtl\Garant\ScriptEngine\kwUses.pas',
  kwInnerIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncluded.pas',
  kwINCLUDES in 'w:\common\components\rtl\Garant\ScriptEngine\kwINCLUDES.pas',
  kwInnerIncludedInChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncludedInChildren.pas',
  kwIncludesInChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncludesInChildren.pas',
  IncludesAndUsesPack in 'w:\common\components\rtl\Garant\ScriptEngine\IncludesAndUsesPack.pas',
  kwCheckOutputWithInput in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckOutputWithInput.pas',
  kwCheckEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckEtalon.pas',
  kwTestResolveInputFilePath in 'w:\common\components\rtl\Garant\ScriptEngine\kwTestResolveInputFilePath.pas',
  EtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas',
  kwSendInputSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupport.pas',
  kwMouseUpDownSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseUpDownSupport.pas',
  kwMouseLeftDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftDown.pas',
  kwMouseLeftUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftUp.pas',
  kwMouseMiddleUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleUp.pas',
  kwMouseMiddleDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleDown.pas',
  kwMouseRightUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightUp.pas',
  kwMouseRightDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightDown.pas',
  kwMouseSetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseSetCursorPosition.pas',
  kwMouseGetCursorIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorIndex.pas',
  kwMouseGetCursorNameByIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorNameByIndex.pas',
  kwMouseGetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorPosition.pas',
  kwMouseWheelSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelSupport.pas',
  kwMouseWheelUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelUp.pas',
  kwMouseWheelDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelDown.pas',
  MouseInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\MouseInputPack.pas'
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
  ,
  kwCompiledRules in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledRules.pas',
  kwRULES in 'w:\common\components\rtl\Garant\ScriptEngine\kwRULES.pas',
  kwCompiledIF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIF.pas',
  kwCompiledIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIfElse.pas',
  kwIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwIfElse.pas',
  kwElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwElse.pas',
  kwCompiledCase in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCase.pas',
  kwCASE in 'w:\common\components\rtl\Garant\ScriptEngine\kwCASE.pas',
  kwDEFAULT in 'w:\common\components\rtl\Garant\ScriptEngine\kwDEFAULT.pas',
  kwRAISE in 'w:\common\components\rtl\Garant\ScriptEngine\kwRAISE.pas',
  kwBracketEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketEnd.pas',
  kwTypedBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTypedBeginLikeCompiledCode.pas',
  kwBracketBegin in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketBegin.pas',
  kwBEGIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwBEGIN.pas',
  CodeBranchingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeBranchingPack.pas',
  kwMainCodeController in 'w:\common\components\rtl\Garant\ScriptEngine\kwMainCodeController.pas',
  kwCompiledScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileAndProcess.pas',
  kwScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileAndProcess.pas',
  ScriptsCompilingAndProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScriptsCompilingAndProcessingPack.pas',
  CommCtrl {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\CommCtrl.pas' {$EndIf}
  {$If not defined(NoScripts) AND not defined(NoWindows)}
  ,
  WinUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinUtilsPack.pas'
  {$IfEnd} //not NoScripts AND not NoWindows
  ,
  tfwScriptEngineEX in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineEX.pas',
  l3MenuManagerHelper in 'w:\common\components\rtl\Garant\L3\l3MenuManagerHelper.pas'
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM) AND not defined(NotTunedDUnit)}
  ,
  VCMBaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\VCMBaseTest.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM AND not NotTunedDUnit
  
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
  
  {$If not defined(NoVCM)}
  ,
  StdRes in 'StdRes.pas' {dmStdRes: TvcmApplicationRes}
  {$IfEnd} //not NoVCM
  
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
  vcmFormsUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormsUtils.pas'
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
  vcmMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManager.pas'
  {$IfEnd} //not NoVCM
  ,
  ElXPThemedControl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElXPThemedControl.pas',
  PageControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\PageControlWordsPack.pas',
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
  vcmControlList in 'w:\common\components\gui\Garant\VCM\implementation\vcmControlList.pas'
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityForm.pas'
  {$IfEnd} //not NoVCM
  ,
  evLoadDocumentManager in 'w:\common\components\gui\Garant\Everest\ext\evLoadDocumentManager.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\PrimTextLoad_Form.pas'
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evTunedEditor in 'w:\common\components\gui\Garant\Everest\evTunedEditor.pas',
  evEditor in 'w:\common\components\gui\Garant\Everest\evEditor.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextLoad_ut_TextLoad_UserType in 'w:\common\components\gui\Garant\Daily\Forms\TextLoad_ut_TextLoad_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\TextLoad_Form.pas' {TextLoadForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  TextLoadKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\TextLoadKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  ,
  Everest_Schema in 'w:\common\components\gui\Garant\Everest\Everest_Schema.pas'
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
  evdSchema in 'w:\common\components\gui\Garant\Everest\evdSchema.pas'
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSourceExport.pas'
  {$IfEnd} //Nemesis
  ,
  eeInterfaces in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas',
  eeInterfacesEx in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfacesEx.pas'
  {$If defined(Nemesis)}
  ,
  eeDocumentTool in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentTool.pas'
  {$IfEnd} //Nemesis
  
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
  eeExceptions in 'w:\common\components\gui\Garant\Everest_Engine\eeExceptions.pas',
  eeEditorExport in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExport.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  F1LikeTextLoad_ut_F1LikeTextLoad_UserType in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_ut_F1LikeTextLoad_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  F1LikeTextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_Form.pas' {F1LikeTextLoadForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  F1LikeTextLoadKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoadKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  ,
  evQueryCardEditorHotSpot in 'w:\common\components\gui\Garant\Everest\evQueryCardEditorHotSpot.pas',
  evQueryCardSelection in 'w:\common\components\gui\Garant\Everest\evQueryCardSelection.pas',
  evQueryCardEditor in 'w:\common\components\gui\Garant\Everest\evQueryCardEditor.pas',
  QueryCardProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas',
  kwQueryCardFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwQueryCardFromStackWord.pas',
  evReqIterator in 'w:\common\components\gui\Garant\Everest\evReqIterator.pas',
  kwPopQueryCardAttributeSetWithLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetWithLogicOperation.pas',
  kwPopQueryCardSetAttribute in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardSetAttribute.pas',
  kwPopQueryCardAttributeSetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetCollapsed.pas',
  kwPopQueryCardAttributeSetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetFocus.pas',
  kwPopQueryCardAttributeGetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetFocus.pas',
  kwPopQueryCardAttributeGetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetCollapsed.pas',
  kwPopQueryCardAttributeGetLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetLogicOperation.pas',
  kwPopQueryCardAttributeIsLogicOperationEnabled in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeIsLogicOperationEnabled.pas',
  kwPopQueryCardGetCurrentReqName in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardGetCurrentReqName.pas',
  evQueryCardProcessor in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardProcessor.pas',
  evControlGenerator in 'w:\common\components\gui\Garant\Everest\qf\evControlGenerator.pas',
  evQueryDocumentContainer in 'w:\common\components\gui\Garant\Everest\qf\evQueryDocumentContainer.pas',
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
  evControlContainerEX in 'w:\common\components\gui\Garant\Everest\qf\evControlContainerEX.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  QFLikeTextLoad_ut_QFLikeTextLoad_UserType in 'w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_ut_QFLikeTextLoad_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  QFLikeTextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_Form.pas' {QFLikeTextLoadForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  QFLikeTextLoadKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoadKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscCustomTreeComboWithHistoryRes in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistoryRes.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscNewInterfaces.pas'
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
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  F1LikeFormWithBS_Form in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_Form.pas' {F1LikeFormWithBSForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  F1LikeFormWithBSKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBSKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessorPrim in 'w:\common\components\gui\Garant\Daily\TextViaEditorProcessorPrim.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  elCustomEdit_ut_elCustomEdit_UserType in 'w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_ut_elCustomEdit_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  elCustomEdit_Form in 'w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_Form.pas' {elCustomEditForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  elCustomEditKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\elCustomEditKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  K204114253 in 'w:\common\components\gui\Garant\Daily\K204114253.pas'
  {$IfEnd} //nsTest AND not NoVCM
  ,
  ddSectionRepair in 'w:\common\components\rtl\Garant\dd\ddSectionRepair.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextLoad in 'w:\common\components\gui\Garant\Daily\TextLoad.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextEditorVisitorPrim in 'w:\common\components\gui\Garant\Daily\TextEditorVisitorPrim.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextEditorVisitor in 'w:\common\components\gui\Garant\Daily\TextEditorVisitor.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor in 'w:\common\components\gui\Garant\Daily\TextViaEditorProcessor.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  SearchAndReplacePrimTest in 'w:\common\components\gui\Garant\Daily\SearchAndReplacePrimTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  ,
  vtCustomPreviewPanel in 'w:\common\components\gui\Garant\VT\vtCustomPreviewPanel.pas',
  vtPreviewPanel in 'w:\common\components\gui\Garant\VT\vtPreviewPanel.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewTestBefore235875079 in 'w:\common\components\gui\Garant\Daily\PreviewTestBefore235875079.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimScrollTest in 'w:\common\components\gui\Garant\Daily\PrimScrollTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollBackTest in 'w:\common\components\gui\Garant\Daily\ScrollBackTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ComplexScrollByLines in 'w:\common\components\gui\Garant\Daily\ComplexScrollByLines.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  SearchAndReplaceTest in 'w:\common\components\gui\Garant\Daily\SearchAndReplaceTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TwoEmptyParaForOneReplacerTest in 'w:\common\components\gui\Garant\Daily\TwoEmptyParaForOneReplacerTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TableSelectTest in 'w:\common\components\gui\Garant\Daily\TableSelectTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TwoSpaceForOneReplacerTest in 'w:\common\components\gui\Garant\Daily\TwoSpaceForOneReplacerTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ChangeAllTablesTest in 'w:\common\components\gui\Garant\Daily\ChangeAllTablesTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  OldNSRCFlagCnahge in 'w:\common\components\gui\Garant\Daily\OldNSRCFlagCnahge.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollBackByLineTest in 'w:\common\components\gui\Garant\Daily\ScrollBackByLineTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollBackByLineWithCheckTopAnchoTest in 'w:\common\components\gui\Garant\Daily\ScrollBackByLineWithCheckTopAnchoTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  DrawLineTest in 'w:\common\components\gui\Garant\Daily\DrawLineTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PasteColumnTest in 'w:\common\components\gui\Garant\Daily\PasteColumnTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollTest in 'w:\common\components\gui\Garant\Daily\ScrollTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  CommentAndScrollTest in 'w:\common\components\gui\Garant\Daily\CommentAndScrollTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  QueryCardAddAttributeTest in 'w:\common\components\gui\Garant\Daily\QueryCardAddAttributeTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  CommentInTableAndScrollTest in 'w:\common\components\gui\Garant\Daily\CommentInTableAndScrollTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  InsertRowTest in 'w:\common\components\gui\Garant\Daily\InsertRowTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  DrawTestPrim in 'w:\common\components\gui\Garant\Daily\DrawTestPrim.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  DeleteSectionBreakTest in 'w:\common\components\gui\Garant\Daily\DeleteSectionBreakTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TableToolsTestPrim in 'w:\common\components\gui\Garant\Daily\TableToolsTestPrim.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewWithLinesTestBefore235875079 in 'w:\common\components\gui\Garant\Daily\PreviewWithLinesTestBefore235875079.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewTestBefore278833302 in 'w:\common\components\gui\Garant\Daily\PreviewTestBefore278833302.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewWithLinesTest in 'w:\common\components\gui\Garant\Daily\PreviewWithLinesTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PreviewTest in 'w:\common\components\gui\Garant\Daily\PreviewTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PageCountTest in 'w:\common\components\gui\Garant\Daily\PageCountTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  ,
  vtOutlinerControl in 'w:\common\components\gui\Garant\VT\vtOutlinerControl.pas'
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  OutlinerForm_ut_OutlinerForm_UserType in 'w:\common\components\gui\Garant\Daily\Forms\OutlinerForm_ut_OutlinerForm_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  Outliner_Form in 'w:\common\components\gui\Garant\Daily\Forms\Outliner_Form.pas' {OutlinerFormForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  OutlinerFormKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\OutlinerFormKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  OutlinerTest in 'w:\common\components\gui\Garant\Daily\OutlinerTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  FromWithPanel_ut_FromWithPanel_UserType in 'w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_ut_FromWithPanel_UserType.pas'
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  FromWithPanel_Form in 'w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_Form.pas' {FromWithPanelForm: TvcmEntityForm}
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  FromWithPanelKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\FromWithPanelKeywordsPack.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  EmptyFormTest in 'w:\common\components\gui\Garant\Daily\EmptyFormTest.pas'
  {$IfEnd} //nsTest AND not NoVCM
  ,
  LongintListTest in 'w:\common\components\rtl\Garant\Containers\LongintListTest.pas',
  TestMMX in 'w:\common\components\rtl\Garant\Daily\TestMMX.pas',
  TestGlobals in 'w:\common\components\rtl\Garant\Daily\TestGlobals.pas',
  TestFilerReadLn in 'w:\common\components\rtl\Garant\Daily\TestFilerReadLn.pas',
  TestFilerCopyViaReadLn in 'w:\common\components\rtl\Garant\Daily\TestFilerCopyViaReadLn.pas',
  WriterTest in 'w:\common\components\rtl\Garant\Daily\WriterTest.pas',
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
  RTFWriterTest in 'w:\common\components\rtl\Garant\Daily\RTFWriterTest.pas',
  EVDtoRTFWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoRTFWriterTest.pas',
  ddLowLevelRTF in 'w:\common\components\rtl\Garant\dd\ddLowLevelRTF.pas',
  ddCustomRTFReader in 'w:\common\components\rtl\Garant\dd\ddCustomRTFReader.pas',
  ddRTFReader in 'w:\common\components\rtl\Garant\dd\ddRTFReader.pas',
  RTFReaderTest in 'w:\common\components\rtl\Garant\Daily\RTFReaderTest.pas',
  RTFtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\RTFtoEVDWriterTest.pas',
  EVDwithFormulasToRTFWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDwithFormulasToRTFWriterTest.pas',
  DOCtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\DOCtoEVDWriterTest.pas',
  dd_lcHiddenTextExtractor in 'w:\common\components\rtl\Garant\dd\dd_lcHiddenTextExtractor.pas',
  RTFtoEVDWithiddenTextExtractor in 'w:\common\components\rtl\Garant\Daily\RTFtoEVDWithiddenTextExtractor.pas',
  EVDWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDWriterTest.pas',
  EVDtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDWriterTest.pas',
  evdEmptyRowFilter in 'w:\common\components\gui\Garant\Everest\evdEmptyRowFilter.pas',
  EVDtoEVDEmptyRowTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowTest.pas',
  ddSectionWithSub2Para in 'w:\common\components\rtl\Garant\dd\ddSectionWithSub2Para.pas',
  EVDtoEVDSectionRepairTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDSectionRepairTest.pas',
  evOEMTableFlagFilter in 'w:\common\components\gui\Garant\EverestCommon\evOEMTableFlagFilter.pas',
  EVDtoEVDOEMTableFlagTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDOEMTableFlagTest.pas',
  EVDtoEVDBlockNameAdderTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDBlockNameAdderTest.pas',
  evEmptyTableEliminator in 'w:\common\components\gui\Garant\EverestCommon\evEmptyTableEliminator.pas',
  EVDtoEVDEmptyRowAndEmptyTableTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowAndEmptyTableTest.pas',
  evUnicodeFormulasToUnicodeConverter in 'w:\common\components\gui\Garant\Everest\evUnicodeFormulasToUnicodeConverter.pas',
  UnicodeFormulasToUnicodeConverterTest in 'w:\common\components\rtl\Garant\Daily\UnicodeFormulasToUnicodeConverterTest.pas',
  dt_Types in 'w:\common\components\rtl\Garant\dd\dt_Types.pas',
  dt_AttrSchema in 'w:\common\components\rtl\Garant\dd\dt_AttrSchema.pas',
  segTarget in 'w:\common\components\rtl\Garant\dd\segTarget.pas',
  segTargetList in 'w:\common\components\rtl\Garant\dd\segTargetList.pas',
  evNSRCConst in 'w:\common\components\rtl\Garant\dd\evNSRCConst.pas',
  ddNSRCStackItemList in 'w:\common\components\rtl\Garant\dd\ddNSRCStackItemList.pas',
  segObjectList in 'w:\common\components\rtl\Garant\dd\segObjectList.pas',
  segHyperLinkList in 'w:\common\components\rtl\Garant\dd\segHyperLinkList.pas',
  segSegList in 'w:\common\components\rtl\Garant\dd\segSegList.pas',
  ddSegmentScanner in 'w:\common\components\rtl\Garant\dd\ddSegmentScanner.pas',
  ddNSRCSegments in 'w:\common\components\rtl\Garant\dd\ddNSRCSegments.pas',
  ddNSRCSub in 'w:\common\components\rtl\Garant\dd\ddNSRCSub.pas',
  ddNSRCSubList in 'w:\common\components\rtl\Garant\dd\ddNSRCSubList.pas',
  ddNSRCConst in 'w:\common\components\rtl\Garant\dd\ddNSRCConst.pas',
  ddTk2TypeList in 'w:\common\components\rtl\Garant\dd\ddTk2TypeList.pas',
  ddDoc2DocLinkRecList in 'w:\common\components\rtl\Garant\dd\ddDoc2DocLinkRecList.pas',
  ddNSRC_r in 'w:\common\components\rtl\Garant\dd\ddNSRC_r.pas',
  evdNSRCReader in 'w:\common\components\gui\Garant\EverestCommon\evdNSRCReader.pas',
  ddNSRCGenerator in 'w:\common\components\rtl\Garant\EVD\ddNSRCGenerator.pas',
  tstNSRCGenerator in 'w:\common\components\rtl\Garant\Daily\tstNSRCGenerator.pas',
  evSimpleTextPainter in 'w:\common\components\gui\Garant\Everest\evSimpleTextPainter.pas',
  evCustomTextPainter in 'w:\common\components\gui\Garant\Everest\evCustomTextPainter.pas',
  evNSRCWriterTypes in 'w:\common\components\gui\Garant\Everest\evNSRCWriterTypes.pas',
  evNSRWrt in 'w:\common\components\gui\Garant\Everest\evNSRWrt.pas',
  evCustomNSRCWriter in 'w:\common\components\gui\Garant\Everest\evCustomNSRCWriter.pas',
  evNSRCPlusWriter in 'w:\common\components\gui\Garant\Everest\evNSRCPlusWriter.pas',
  NSRCWriterTest in 'w:\common\components\rtl\Garant\Daily\NSRCWriterTest.pas',
  EVDtoNSRCWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoNSRCWriterTest.pas',
  StyleCtoStyleJTest in 'w:\common\components\rtl\Garant\Daily\StyleCtoStyleJTest.pas',
  EVDtoNSRCPlusWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoNSRCPlusWriterTest.pas',
  EVDtoNSRCOldWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoNSRCOldWriterTest.pas',
  K177964264 in 'w:\common\components\rtl\Garant\Daily\K177964264.pas',
  K177964498 in 'w:\common\components\rtl\Garant\Daily\K177964498.pas',
  NSRCtoMemoryTest in 'w:\common\components\rtl\Garant\Daily\NSRCtoMemoryTest.pas',
  K180060897 in 'w:\common\components\rtl\Garant\Daily\K180060897.pas',
  EVDtoBothNSRCWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoBothNSRCWriterTest.pas',
  K177963362 in 'w:\common\components\rtl\Garant\Daily\K177963362.pas',
  K177963873 in 'w:\common\components\rtl\Garant\Daily\K177963873.pas',
  K164596048 in 'w:\common\components\rtl\Garant\Daily\K164596048.pas',
  K177964278 in 'w:\common\components\rtl\Garant\Daily\K177964278.pas',
  K177964664 in 'w:\common\components\rtl\Garant\Daily\K177964664.pas',
  K211878862 in 'w:\common\components\rtl\Garant\Daily\K211878862.pas',
  NSRCtoEVDTest in 'w:\common\components\rtl\Garant\Daily\NSRCtoEVDTest.pas',
  NSRCtoNSRCTest in 'w:\common\components\rtl\Garant\Daily\NSRCtoNSRCTest.pas',
  K412987699 in 'w:\common\components\rtl\Garant\Daily\K412987699.pas',
  K415728258 in 'w:\common\components\rtl\Garant\Daily\K415728258.pas',
  K404357586 in 'w:\common\components\rtl\Garant\Daily\K404357586.pas',
  K446824679 in 'w:\common\components\rtl\Garant\Daily\K446824679.pas',
  K565842263 in 'w:\common\components\rtl\Garant\Daily\K565842263.pas',
  K565862557 in 'w:\common\components\rtl\Garant\Daily\K565862557.pas',
  TextViaEditorProcessorWithNavigate in 'w:\common\components\rtl\Garant\Daily\TextViaEditorProcessorWithNavigate.pas',
  InsertStreamTest in 'w:\common\components\rtl\Garant\Daily\InsertStreamTest.pas',
  MoveSubTest in 'w:\common\components\rtl\Garant\Daily\MoveSubTest.pas',
  InsertStreamTestWithImplementedNavigate in 'w:\common\components\rtl\Garant\Daily\InsertStreamTestWithImplementedNavigate.pas',
  CopyPasteTest in 'w:\common\components\rtl\Garant\Daily\CopyPasteTest.pas',
  DeleteCharTest in 'w:\common\components\rtl\Garant\Daily\DeleteCharTest.pas',
  ScrollByLineTest in 'w:\common\components\rtl\Garant\Daily\ScrollByLineTest.pas',
  DeleteColumnToolTest in 'w:\common\components\rtl\Garant\Daily\DeleteColumnToolTest.pas',
  DrawTest in 'w:\common\components\rtl\Garant\Daily\DrawTest.pas',
  MergeAndCheck in 'w:\common\components\rtl\Garant\Daily\MergeAndCheck.pas',
  InsertBreakInTextTableTest in 'w:\common\components\rtl\Garant\Daily\InsertBreakInTextTableTest.pas',
  TableToolsTest in 'w:\common\components\rtl\Garant\Daily\TableToolsTest.pas',
  ScrollByArrow in 'w:\common\components\rtl\Garant\Daily\ScrollByArrow.pas',
  MergeCellsTest in 'w:\common\components\rtl\Garant\Daily\MergeCellsTest.pas',
  Translate2TextTest in 'w:\common\components\rtl\Garant\Daily\Translate2TextTest.pas',
  SelectColumnAndDelete in 'w:\common\components\rtl\Garant\Daily\SelectColumnAndDelete.pas',
  ColumnAlignHorisontallyTest in 'w:\common\components\rtl\Garant\Daily\ColumnAlignHorisontallyTest.pas',
  MergeAndCheckSelectionTest in 'w:\common\components\rtl\Garant\Daily\MergeAndCheckSelectionTest.pas',
  MergeTablesTest in 'w:\common\components\rtl\Garant\Daily\MergeTablesTest.pas',
  SplitTableTest in 'w:\common\components\rtl\Garant\Daily\SplitTableTest.pas',
  SelectRowAndDeleteTest in 'w:\common\components\rtl\Garant\Daily\SelectRowAndDeleteTest.pas',
  SelectPtTest in 'w:\common\components\rtl\Garant\Daily\SelectPtTest.pas',
  ScrollAndSelectPtTest in 'w:\common\components\rtl\Garant\Daily\ScrollAndSelectPtTest.pas',
  CheckTopAnchorTest in 'w:\common\components\rtl\Garant\Daily\CheckTopAnchorTest.pas',
  HotSpotSelectionTest in 'w:\common\components\rtl\Garant\Abstract_Tests\HotSpotSelectionTest.pas',
  CellMouseSelectionTest in 'w:\common\components\rtl\Garant\Daily\CellMouseSelectionTest.pas',
  TextViaEditorProcessorWithExternalSave in 'w:\common\components\rtl\Garant\Abstract_Tests\TextViaEditorProcessorWithExternalSave.pas',
  TextMetricsPrimTest in 'w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsPrimTest.pas',
  TextMetricsTest in 'w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsTest.pas',
  TextMetricsAfterCopyPasteTest in 'w:\common\components\rtl\Garant\Daily\TextMetricsAfterCopyPasteTest.pas',
  TextMericsAfterDeleteTest in 'w:\common\components\rtl\Garant\Daily\TextMericsAfterDeleteTest.pas',
  MouseMoveSelectionTest in 'w:\common\components\rtl\Garant\Abstract_Tests\MouseMoveSelectionTest.pas',
  MouseMoveCellsSelectTest in 'w:\common\components\rtl\Garant\Daily\MouseMoveCellsSelectTest.pas',
  SelectionCellTest in 'w:\common\components\rtl\Garant\Daily\SelectionCellTest.pas',
  ColumnResizeByMousePrimTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ColumnResizeByMousePrimTest.pas',
  ColumnResizeWithCtrl in 'w:\common\components\rtl\Garant\Daily\ColumnResizeWithCtrl.pas',
  SplitCellTest in 'w:\common\components\rtl\Garant\Daily\SplitCellTest.pas',
  ScrollAndCheckCursorTest in 'w:\common\components\rtl\Garant\Daily\ScrollAndCheckCursorTest.pas',
  nevVScrollerSpy in 'w:\common\components\gui\Garant\Everest\new\nevVScrollerSpy.pas',
  ComplexScrollParams in 'w:\common\components\rtl\Garant\Daily\ComplexScrollParams.pas',
  ScrollByArrowAndCheckShapesTest in 'w:\common\components\rtl\Garant\Daily\ScrollByArrowAndCheckShapesTest.pas',
  ScrollUpAndDownAndCheckShapes in 'w:\common\components\rtl\Garant\Daily\ScrollUpAndDownAndCheckShapes.pas',
  HorzMergeCells in 'w:\common\components\rtl\Garant\Daily\HorzMergeCells.pas',
  ScrollByLineBackAndSelectPt in 'w:\common\components\rtl\Garant\Daily\ScrollByLineBackAndSelectPt.pas',
  l3GZipStream in 'w:\common\components\rtl\Garant\L3\l3GZipStream.pas',
  GZipTest in 'w:\common\components\rtl\Garant\Daily\GZipTest.pas',
  GZipUnzipTest in 'w:\common\components\rtl\Garant\Daily\GZipUnzipTest.pas',
  K165514106 in 'w:\common\components\rtl\Garant\Daily\K165514106.pas',
  ddMisspellCorrect in 'w:\common\components\rtl\Garant\dd\ddMisspellCorrect.pas',
  K219122895 in 'w:\common\components\rtl\Garant\Daily\K219122895.pas',
  K165512428 in 'w:\common\components\rtl\Garant\Daily\K165512428.pas',
  K221250480 in 'w:\common\components\rtl\Garant\Daily\K221250480.pas',
  K217678457 in 'w:\common\components\rtl\Garant\Daily\K217678457.pas',
  K221251978 in 'w:\common\components\rtl\Garant\Daily\K221251978.pas',
  K222757750 in 'w:\common\components\rtl\Garant\Daily\K222757750.pas',
  K223608965 in 'w:\common\components\rtl\Garant\Daily\K223608965.pas',
  K224134476 in 'w:\common\components\rtl\Garant\Daily\K224134476.pas',
  K224133899 in 'w:\common\components\rtl\Garant\Daily\K224133899.pas',
  K224135562 in 'w:\common\components\rtl\Garant\Daily\K224135562.pas',
  K224788868 in 'w:\common\components\rtl\Garant\Daily\K224788868.pas',
  K200902351 in 'w:\common\components\rtl\Garant\Daily\K200902351.pas',
  K224791621 in 'w:\common\components\rtl\Garant\Daily\K224791621.pas',
  K226001213 in 'w:\common\components\rtl\Garant\Daily\K226001213.pas',
  K226001269 in 'w:\common\components\rtl\Garant\Daily\K226001269.pas',
  K226002079 in 'w:\common\components\rtl\Garant\Daily\K226002079.pas',
  K226005005 in 'w:\common\components\rtl\Garant\Daily\K226005005.pas',
  K226005021 in 'w:\common\components\rtl\Garant\Daily\K226005021.pas',
  K227477159 in 'w:\common\components\rtl\Garant\Daily\K227477159.pas',
  K227478617 in 'w:\common\components\rtl\Garant\Daily\K227478617.pas',
  K227477421 in 'w:\common\components\rtl\Garant\Daily\K227477421.pas',
  K227478018 in 'w:\common\components\rtl\Garant\Daily\K227478018.pas',
  K227972911 in 'w:\common\components\rtl\Garant\Daily\K227972911.pas',
  K228691360 in 'w:\common\components\rtl\Garant\Daily\K228691360.pas',
  K228692531 in 'w:\common\components\rtl\Garant\Daily\K228692531.pas',
  K228692538 in 'w:\common\components\rtl\Garant\Daily\K228692538.pas',
  K228692711 in 'w:\common\components\rtl\Garant\Daily\K228692711.pas',
  K228693150 in 'w:\common\components\rtl\Garant\Daily\K228693150.pas',
  K229213001 in 'w:\common\components\rtl\Garant\Daily\K229213001.pas',
  K228693052 in 'w:\common\components\rtl\Garant\Daily\K228693052.pas',
  evUnblockEmptyParaFilter in 'w:\common\components\gui\Garant\EverestCommon\evUnblockEmptyParaFilter.pas',
  K228692043 in 'w:\common\components\rtl\Garant\Daily\K228692043.pas',
  K228689782 in 'w:\common\components\rtl\Garant\Daily\K228689782.pas',
  K228688660 in 'w:\common\components\rtl\Garant\Daily\K228688660.pas',
  K232097143 in 'w:\common\components\rtl\Garant\Daily\K232097143.pas',
  K224133855 in 'w:\common\components\rtl\Garant\Daily\K224133855.pas',
  K232099823 in 'w:\common\components\rtl\Garant\Daily\K232099823.pas',
  K233014754 in 'w:\common\components\rtl\Garant\Daily\K233014754.pas',
  K233015524 in 'w:\common\components\rtl\Garant\Daily\K233015524.pas',
  K226006206 in 'w:\common\components\rtl\Garant\Daily\K226006206.pas',
  K233019435 in 'w:\common\components\rtl\Garant\Daily\K233019435.pas',
  K233014742 in 'w:\common\components\rtl\Garant\Daily\K233014742.pas',
  K226001945 in 'w:\common\components\rtl\Garant\Daily\K226001945.pas',
  K234361767 in 'w:\common\components\rtl\Garant\Daily\K234361767.pas',
  K234363360 in 'w:\common\components\rtl\Garant\Daily\K234363360.pas',
  K235046445 in 'w:\common\components\rtl\Garant\Daily\K235046445.pas',
  K234363136 in 'w:\common\components\rtl\Garant\Daily\K234363136.pas',
  K234360974 in 'w:\common\components\rtl\Garant\Daily\K234360974.pas',
  K235050903 in 'w:\common\components\rtl\Garant\Daily\K235050903.pas',
  K234363615 in 'w:\common\components\rtl\Garant\Daily\K234363615.pas',
  K235052899 in 'w:\common\components\rtl\Garant\Daily\K235052899.pas',
  K235052988 in 'w:\common\components\rtl\Garant\Daily\K235052988.pas',
  K235053014 in 'w:\common\components\rtl\Garant\Daily\K235053014.pas',
  K235054083 in 'w:\common\components\rtl\Garant\Daily\K235054083.pas',
  K235052965 in 'w:\common\components\rtl\Garant\Daily\K235052965.pas',
  K235050021 in 'w:\common\components\rtl\Garant\Daily\K235050021.pas',
  K235054362 in 'w:\common\components\rtl\Garant\Daily\K235054362.pas',
  K235057437 in 'w:\common\components\rtl\Garant\Daily\K235057437.pas',
  K235058888 in 'w:\common\components\rtl\Garant\Daily\K235058888.pas',
  K235060094 in 'w:\common\components\rtl\Garant\Daily\K235060094.pas',
  K235058873 in 'w:\common\components\rtl\Garant\Daily\K235058873.pas',
  K235050248 in 'w:\common\components\rtl\Garant\Daily\K235050248.pas',
  K234360788 in 'w:\common\components\rtl\Garant\Daily\K234360788.pas',
  K235062061 in 'w:\common\components\rtl\Garant\Daily\K235062061.pas',
  K235864191 in 'w:\common\components\rtl\Garant\Daily\K235864191.pas',
  K235866053 in 'w:\common\components\rtl\Garant\Daily\K235866053.pas',
  K235864157 in 'w:\common\components\rtl\Garant\Daily\K235864157.pas',
  K235866221 in 'w:\common\components\rtl\Garant\Daily\K235866221.pas',
  K235866981 in 'w:\common\components\rtl\Garant\Daily\K235866981.pas',
  K234360960 in 'w:\common\components\rtl\Garant\Daily\K234360960.pas',
  K235864277 in 'w:\common\components\rtl\Garant\Daily\K235864277.pas',
  K235873011 in 'w:\common\components\rtl\Garant\Daily\K235873011.pas',
  K235875463 in 'w:\common\components\rtl\Garant\Daily\K235875463.pas',
  K235876236 in 'w:\common\components\rtl\Garant\Daily\K235876236.pas',
  PreviewTestBefore235875079WithRowCmp in 'w:\common\components\rtl\Garant\Abstract_Tests\PreviewTestBefore235875079WithRowCmp.pas',
  K224789639 in 'w:\common\components\rtl\Garant\Daily\K224789639.pas',
  K233015604 in 'w:\common\components\rtl\Garant\Daily\K233015604.pas',
  K237503834 in 'w:\common\components\rtl\Garant\Daily\K237503834.pas',
  K237503768 in 'w:\common\components\rtl\Garant\Daily\K237503768.pas',
  K238420075 in 'w:\common\components\rtl\Garant\Daily\K238420075.pas',
  K239372528 in 'w:\common\components\rtl\Garant\Daily\K239372528.pas',
  K235869064 in 'w:\common\components\rtl\Garant\Daily\K235869064.pas',
  K238420863 in 'w:\common\components\rtl\Garant\Daily\K238420863.pas',
  K239894899 in 'w:\common\components\rtl\Garant\Daily\K239894899.pas',
  K234357754 in 'w:\common\components\rtl\Garant\Daily\K234357754.pas',
  K217681225 in 'w:\common\components\rtl\Garant\Daily\K217681225.pas',
  K216530981 in 'w:\common\components\rtl\Garant\Daily\K216530981.pas',
  K241011651 in 'w:\common\components\rtl\Garant\Daily\K241011651.pas',
  K242843959 in 'w:\common\components\rtl\Garant\Daily\K242843959.pas',
  K213713837 in 'w:\common\components\rtl\Garant\Daily\K213713837.pas',
  K216074128 in 'w:\common\components\rtl\Garant\Daily\K216074128.pas',
  K111739572 in 'w:\common\components\rtl\Garant\Daily\K111739572.pas',
  K242844505 in 'w:\common\components\rtl\Garant\Daily\K242844505.pas',
  K244195248 in 'w:\common\components\rtl\Garant\Daily\K244195248.pas',
  K245203249 in 'w:\common\components\rtl\Garant\Daily\K245203249.pas',
  K245204495 in 'w:\common\components\rtl\Garant\Daily\K245204495.pas',
  K245206060 in 'w:\common\components\rtl\Garant\Daily\K245206060.pas',
  evTreeGenerator in 'w:\common\components\gui\Garant\Everest\evTreeGenerator.pas',
  OutlinerWithEVDStyleNodes in 'w:\common\components\rtl\Garant\Daily\OutlinerWithEVDStyleNodes.pas',
  evAutoBlock in 'w:\common\components\gui\Garant\Everest\ext\evAutoBlock.pas',
  AutoBlockTest in 'w:\common\components\rtl\Garant\Abstract_Tests\AutoBlockTest.pas',
  K245761273 in 'w:\common\components\rtl\Garant\Daily\K245761273.pas',
  K245761265 in 'w:\common\components\rtl\Garant\Daily\K245761265.pas',
  K246939696 in 'w:\common\components\rtl\Garant\Daily\K246939696.pas',
  K206079417 in 'w:\common\components\rtl\Garant\Daily\K206079417.pas',
  K217685978 in 'w:\common\components\rtl\Garant\Daily\K217685978.pas',
  K247300520 in 'w:\common\components\rtl\Garant\Daily\K247300520.pas',
  K244712164 in 'w:\common\components\rtl\Garant\Daily\K244712164.pas',
  K248194804 in 'w:\common\components\rtl\Garant\Daily\K248194804.pas',
  K235875079 in 'w:\common\components\rtl\Garant\Daily\K235875079.pas',
  K247302160 in 'w:\common\components\rtl\Garant\Daily\K247302160.pas',
  PreviewWithRowCompare in 'w:\common\components\rtl\Garant\Abstract_Tests\PreviewWithRowCompare.pas',
  K249333540 in 'w:\common\components\rtl\Garant\Daily\K249333540.pas',
  K249336513 in 'w:\common\components\rtl\Garant\Daily\K249336513.pas',
  K235870623 in 'w:\common\components\rtl\Garant\Daily\K235870623.pas',
  K251342574 in 'w:\common\components\rtl\Garant\Daily\K251342574.pas',
  K251334429 in 'w:\common\components\rtl\Garant\Daily\K251334429.pas',
  K252086528 in 'w:\common\components\rtl\Garant\Daily\K252086528.pas',
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
  evdHyperlinkEliminator in 'w:\common\components\rtl\Garant\EVD\evdHyperlinkEliminator.pas',
  evdScriptHyperlinkEliminator in 'w:\common\components\gui\Garant\Everest\evdScriptHyperlinkEliminator.pas',
  evExtFormat in 'w:\common\components\gui\Garant\Everest\ext\evExtFormat.pas',
  InsertPictureTest in 'w:\common\components\rtl\Garant\Abstract_Tests\InsertPictureTest.pas',
  K252524029 in 'w:\common\components\rtl\Garant\Daily\K252524029.pas',
  K252524358 in 'w:\common\components\rtl\Garant\Daily\K252524358.pas',
  K253664689 in 'w:\common\components\rtl\Garant\Daily\K253664689.pas',
  K252524333 in 'w:\common\components\rtl\Garant\Daily\K252524333.pas',
  K177963847 in 'w:\common\components\rtl\Garant\Daily\K177963847.pas',
  TabInTableTest in 'w:\common\components\rtl\Garant\Abstract_Tests\TabInTableTest.pas',
  K252524299 in 'w:\common\components\rtl\Garant\Daily\K252524299.pas',
  K253668263 in 'w:\common\components\rtl\Garant\Daily\K253668263.pas',
  K253668417 in 'w:\common\components\rtl\Garant\Daily\K253668417.pas',
  K254941681 in 'w:\common\components\rtl\Garant\Daily\K254941681.pas',
  K182157315 in 'w:\common\components\rtl\Garant\Daily\K182157315.pas',
  K252520444 in 'w:\common\components\rtl\Garant\Daily\K252520444.pas',
  K252524393 in 'w:\common\components\rtl\Garant\Daily\K252524393.pas',
  ShowBaseSearchTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ShowBaseSearchTest.pas',
  K253659671 in 'w:\common\components\rtl\Garant\Daily\K253659671.pas',
  DrawSelectionInTableTest in 'w:\common\components\rtl\Garant\Abstract_Tests\DrawSelectionInTableTest.pas',
  K254354240 in 'w:\common\components\rtl\Garant\Daily\K254354240.pas',
  ScrollerParamsTestPrim in 'w:\common\components\rtl\Garant\Abstract_Tests\ScrollerParamsTestPrim.pas',
  ScrollParamsTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ScrollParamsTest.pas',
  K255956509 in 'w:\common\components\rtl\Garant\Daily\K255956509.pas',
  K255958998 in 'w:\common\components\rtl\Garant\Daily\K255958998.pas',
  VerticalCursorMovingTest in 'w:\common\components\rtl\Garant\Abstract_Tests\VerticalCursorMovingTest.pas',
  K91850237 in 'w:\common\components\rtl\Garant\Daily\K91850237.pas',
  K255975907 in 'w:\common\components\rtl\Garant\Daily\K255975907.pas',
  K252520765 in 'w:\common\components\rtl\Garant\Daily\K252520765.pas',
  MouseSelectPtTest in 'w:\common\components\rtl\Garant\Abstract_Tests\MouseSelectPtTest.pas',
  K258610458 in 'w:\common\components\rtl\Garant\Daily\K258610458.pas',
  WrongSearchTest in 'w:\common\components\rtl\Garant\Abstract_Tests\WrongSearchTest.pas',
  K259175668 in 'w:\common\components\rtl\Garant\Daily\K259175668.pas',
  K259163541 in 'w:\common\components\rtl\Garant\Daily\K259163541.pas',
  K259163553 in 'w:\common\components\rtl\Garant\Daily\K259163553.pas',
  K259164768 in 'w:\common\components\rtl\Garant\Daily\K259164768.pas',
  LinesTest in 'w:\common\components\rtl\Garant\Abstract_Tests\LinesTest.pas',
  K258613004 in 'w:\common\components\rtl\Garant\Daily\K258613004.pas',
  WholeSelectionWithMouseTest in 'w:\common\components\rtl\Garant\Abstract_Tests\WholeSelectionWithMouseTest.pas',
  K259893591 in 'w:\common\components\rtl\Garant\Daily\K259893591.pas',
  K263293373 in 'w:\common\components\rtl\Garant\Daily\K263293373.pas',
  InsertFormulaTest in 'w:\common\components\rtl\Garant\Abstract_Tests\InsertFormulaTest.pas',
  K263750307 in 'w:\common\components\rtl\Garant\Daily\K263750307.pas',
  K264900129 in 'w:\common\components\rtl\Garant\Daily\K264900129.pas',
  K265411837 in 'w:\common\components\rtl\Garant\Daily\K265411837.pas',
  K265412167 in 'w:\common\components\rtl\Garant\Daily\K265412167.pas',
  K265412255 in 'w:\common\components\rtl\Garant\Daily\K265412255.pas',
  K266405030 in 'w:\common\components\rtl\Garant\Daily\K266405030.pas',
  SelectCommentAndDelete in 'w:\common\components\rtl\Garant\Abstract_Tests\SelectCommentAndDelete.pas',
  K264902374 in 'w:\common\components\rtl\Garant\Daily\K264902374.pas',
  ClickOnCommentTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ClickOnCommentTest.pas',
  K265409480 in 'w:\common\components\rtl\Garant\Daily\K265409480.pas',
  K265409725 in 'w:\common\components\rtl\Garant\Daily\K265409725.pas',
  K269062434 in 'w:\common\components\rtl\Garant\Daily\K269062434.pas',
  K271754584 in 'w:\common\components\rtl\Garant\Daily\K271754584.pas',
  K272662869 in 'w:\common\components\rtl\Garant\Daily\K272662869.pas',
  RowSelectionTest in 'w:\common\components\rtl\Garant\Abstract_Tests\RowSelectionTest.pas',
  K272666734 in 'w:\common\components\rtl\Garant\Daily\K272666734.pas',
  InsertSectionBreak in 'w:\common\components\rtl\Garant\Abstract_Tests\InsertSectionBreak.pas',
  K272666721 in 'w:\common\components\rtl\Garant\Daily\K272666721.pas',
  K278135327 in 'w:\common\components\rtl\Garant\Daily\K278135327.pas',
  K269064546 in 'w:\common\components\rtl\Garant\Daily\K269064546.pas',
  ScrollAndLinesTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ScrollAndLinesTest.pas',
  K267328230 in 'w:\common\components\rtl\Garant\Daily\K267328230.pas',
  K283149108 in 'w:\common\components\rtl\Garant\Daily\K283149108.pas',
  K288787848 in 'w:\common\components\rtl\Garant\Daily\K288787848.pas',
  AllChildreCountTest in 'w:\common\components\rtl\Garant\Abstract_Tests\AllChildreCountTest.pas',
  K296095866 in 'w:\common\components\rtl\Garant\Daily\K296095866.pas',
  K297705917 in 'w:\common\components\rtl\Garant\Daily\K297705917.pas',
  K330700128 in 'w:\common\components\rtl\Garant\Daily\K330700128.pas',
  K347636412 in 'w:\common\components\rtl\Garant\Daily\K347636412.pas',
  evWikiReader in 'w:\common\components\gui\Garant\Everest\evWikiReader.pas',
  WikiReaderTest in 'w:\common\components\rtl\Garant\Daily\WikiReaderTest.pas',
  WikiToEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\WikiToEVDWriterTest.pas',
  ddHTMLReader in 'w:\common\components\rtl\Garant\dd\ddHTMLReader.pas',
  HTMLtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDWriterTest.pas',
  HTMLtoEVDTest in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDTest.pas',
  ddHTMLWriterRes in 'w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas',
  ddHTMLWriter in 'w:\common\components\rtl\Garant\dd\ddHTMLWriter.pas',
  EVDtoHTMLWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoHTMLWriterTest.pas',
  EVDtoHTMLTest in 'w:\common\components\rtl\Garant\Daily\EVDtoHTMLTest.pas',
  K253662098 in 'w:\common\components\rtl\Garant\Daily\K253662098.pas',
  K260442347 in 'w:\common\components\rtl\Garant\Daily\K260442347.pas',
  K267324701 in 'w:\common\components\rtl\Garant\Daily\K267324701.pas',
  K276535467 in 'w:\common\components\rtl\Garant\Daily\K276535467.pas',
  K280859294 in 'w:\common\components\rtl\Garant\Daily\K280859294.pas',
  K331186919 in 'w:\common\components\rtl\Garant\Daily\K331186919.pas',
  K332563400 in 'w:\common\components\rtl\Garant\Daily\K332563400.pas',
  K342865677 in 'w:\common\components\rtl\Garant\Daily\K342865677.pas',
  K532630317 in 'w:\common\components\rtl\Garant\Daily\K532630317.pas',
  K532634915 in 'w:\common\components\rtl\Garant\Daily\K532634915.pas',
  K197497243 in 'w:\common\components\rtl\Garant\Daily\K197497243.pas',
  K199589954 in 'w:\common\components\rtl\Garant\Daily\K199589954.pas',
  K199591594 in 'w:\common\components\rtl\Garant\Daily\K199591594.pas',
  K200088144 in 'w:\common\components\rtl\Garant\Daily\K200088144.pas',
  K200901262 in 'w:\common\components\rtl\Garant\Daily\K200901262.pas',
  K203131097 in 'w:\common\components\rtl\Garant\Daily\K203131097.pas',
  K205357352 in 'w:\common\components\rtl\Garant\Daily\K205357352.pas',
  K206504616 in 'w:\common\components\rtl\Garant\Daily\K206504616.pas',
  K206504312 in 'w:\common\components\rtl\Garant\Daily\K206504312.pas',
  K207013375 in 'w:\common\components\rtl\Garant\Daily\K207013375.pas',
  K207388924 in 'w:\common\components\rtl\Garant\Daily\K207388924.pas',
  K207389888 in 'w:\common\components\rtl\Garant\Daily\K207389888.pas',
  K208699964 in 'w:\common\components\rtl\Garant\Daily\K208699964.pas',
  K208700993 in 'w:\common\components\rtl\Garant\Daily\K208700993.pas',
  K209584396 in 'w:\common\components\rtl\Garant\Daily\K209584396.pas',
  K210043510 in 'w:\common\components\rtl\Garant\Daily\K210043510.pas',
  K210043101 in 'w:\common\components\rtl\Garant\Daily\K210043101.pas',
  K210043160 in 'w:\common\components\rtl\Garant\Daily\K210043160.pas',
  K208701762 in 'w:\common\components\rtl\Garant\Daily\K208701762.pas',
  K209584437 in 'w:\common\components\rtl\Garant\Daily\K209584437.pas',
  K210437198 in 'w:\common\components\rtl\Garant\Daily\K210437198.pas',
  K210438353 in 'w:\common\components\rtl\Garant\Daily\K210438353.pas',
  K210438308 in 'w:\common\components\rtl\Garant\Daily\K210438308.pas',
  K211878214 in 'w:\common\components\rtl\Garant\Daily\K211878214.pas',
  K211878770 in 'w:\common\components\rtl\Garant\Daily\K211878770.pas',
  K210438932 in 'w:\common\components\rtl\Garant\Daily\K210438932.pas',
  K211879983 in 'w:\common\components\rtl\Garant\Daily\K211879983.pas',
  K213254256 in 'w:\common\components\rtl\Garant\Daily\K213254256.pas',
  K210043147 in 'w:\common\components\rtl\Garant\Daily\K210043147.pas',
  K210043095 in 'w:\common\components\rtl\Garant\Daily\K210043095.pas',
  K213713115 in 'w:\common\components\rtl\Garant\Daily\K213713115.pas',
  K216072357 in 'w:\common\components\rtl\Garant\Daily\K216072357.pas',
  K210043423 in 'w:\common\components\rtl\Garant\Daily\K210043423.pas',
  K201493907 in 'w:\common\components\rtl\Garant\Daily\K201493907.pas',
  K204931408 in 'w:\common\components\rtl\Garant\Daily\K204931408.pas',
  K213713120 in 'w:\common\components\rtl\Garant\Daily\K213713120.pas',
  K210436976 in 'w:\common\components\rtl\Garant\Daily\K210436976.pas',
  K217681540 in 'w:\common\components\rtl\Garant\Daily\K217681540.pas',
  K217680060 in 'w:\common\components\rtl\Garant\Daily\K217680060.pas',
  K217683893 in 'w:\common\components\rtl\Garant\Daily\K217683893.pas',
  K203130960 in 'w:\common\components\rtl\Garant\Daily\K203130960.pas',
  K217684334 in 'w:\common\components\rtl\Garant\Daily\K217684334.pas',
  K217686256 in 'w:\common\components\rtl\Garant\Daily\K217686256.pas',
  K214074330 in 'w:\common\components\rtl\Garant\Daily\K214074330.pas',
  K204931515 in 'w:\common\components\rtl\Garant\Daily\K204931515.pas',
  K217691824 in 'w:\common\components\rtl\Garant\Daily\K217691824.pas',
  K217691845 in 'w:\common\components\rtl\Garant\Daily\K217691845.pas',
  K217693956 in 'w:\common\components\rtl\Garant\Daily\K217693956.pas',
  K217678468 in 'w:\common\components\rtl\Garant\Daily\K217678468.pas',
  K206079241 in 'w:\common\components\rtl\Garant\Daily\K206079241.pas',
  K207006496 in 'w:\common\components\rtl\Garant\Daily\K207006496.pas',
  K219119831 in 'w:\common\components\rtl\Garant\Daily\K219119831.pas',
  K218824755 in 'w:\common\components\rtl\Garant\Daily\K218824755.pas',
  K218464982 in 'w:\common\components\rtl\Garant\Daily\K218464982.pas',
  K219120094 in 'w:\common\components\rtl\Garant\Daily\K219120094.pas',
  K217680744 in 'w:\common\components\rtl\Garant\Daily\K217680744.pas',
  K219123621 in 'w:\common\components\rtl\Garant\Daily\K219123621.pas',
  K217688170 in 'w:\common\components\rtl\Garant\Daily\K217688170.pas',
  K219124975 in 'w:\common\components\rtl\Garant\Daily\K219124975.pas',
  K219124086 in 'w:\common\components\rtl\Garant\Daily\K219124086.pas',
  K220594340 in 'w:\common\components\rtl\Garant\Daily\K220594340.pas',
  K276537900 in 'w:\common\components\rtl\Garant\Daily\K276537900.pas',
  K254349574 in 'w:\common\components\rtl\Garant\Daily\K254349574.pas',
  K290266820 in 'w:\common\components\rtl\Garant\Daily\K290266820.pas',
  K290951357 in 'w:\common\components\rtl\Garant\Daily\K290951357.pas',
  K327822716 in 'w:\common\components\rtl\Garant\Daily\K327822716.pas',
  K254944075 in 'w:\common\components\rtl\Garant\Daily\K254944075.pas',
  K255966779 in 'w:\common\components\rtl\Garant\Daily\K255966779.pas',
  K269066487 in 'w:\common\components\rtl\Garant\Daily\K269066487.pas',
  K278136024 in 'w:\common\components\rtl\Garant\Daily\K278136024.pas',
  K280006084 in 'w:\common\components\rtl\Garant\Daily\K280006084.pas',
  K288010443 in 'w:\common\components\rtl\Garant\Daily\K288010443.pas',
  K288788279 in 'w:\common\components\rtl\Garant\Daily\K288788279.pas',
  K274825304 in 'w:\common\components\rtl\Garant\Daily\K274825304.pas',
  l3KeyWrd in 'w:\common\components\rtl\Garant\L3\l3KeyWrd.pas',
  K289933137 in 'w:\common\components\rtl\Garant\Daily\K289933137.pas',
  K259890927 in 'w:\common\components\rtl\Garant\Daily\K259890927.pas',
  l3InterfaceList in 'w:\common\components\rtl\Garant\L3\l3InterfaceList.pas',
  K293280527 in 'w:\common\components\rtl\Garant\Daily\K293280527.pas',
  K271188165 in 'w:\common\components\rtl\Garant\Daily\K271188165.pas'
  {$If not defined(notDebugStackTrace)}
  ,
  jclDebug {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\source\windows\jclDebug.pas' {$EndIf}
  {$IfEnd} //not notDebugStackTrace
  ,
  l3BitmapContainer in 'w:\common\components\rtl\Garant\L3\l3BitmapContainer.pas',
  evdVer in 'w:\common\components\rtl\Garant\EVD\evdVer.pas',
  eeRenderFormula in 'w:\common\components\rtl\Garant\RenderEVD\eeRenderFormula.pas',
  FormulaRender in 'w:\common\components\rtl\Garant\Abstract_Tests\FormulaRender.pas',
  K282693895 in 'w:\common\components\rtl\Garant\Daily\K282693895.pas',
  K321983051 in 'w:\common\components\rtl\Garant\Daily\K321983051.pas',
  K336664105 in 'w:\common\components\rtl\Garant\Daily\K336664105.pas',
  K336663851 in 'w:\common\components\rtl\Garant\Daily\K336663851.pas',
  K344139764 in 'w:\common\components\rtl\Garant\Daily\K344139764.pas',
  evdXMLWriter in 'w:\common\components\rtl\Garant\EVD\evdXMLWriter.pas',
  XMLWriterTest in 'w:\common\components\rtl\Garant\Daily\XMLWriterTest.pas',
  EVDtoXMLWiterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoXMLWiterTest.pas',
  l3XMLWriter in 'w:\common\components\rtl\Garant\L3\l3XMLWriter.pas',
  L3XMLWriterTest in 'w:\common\components\rtl\Garant\Daily\L3XMLWriterTest.pas',
  K337510841 in 'w:\common\components\rtl\Garant\Daily\K337510841.pas',
  K362130309 in 'w:\common\components\rtl\Garant\Daily\K362130309.pas',
  K385025566 in 'w:\common\components\rtl\Garant\Daily\K385025566.pas',
  K408654725 in 'w:\common\components\rtl\Garant\Daily\K408654725.pas',
  K398275085 in 'w:\common\components\rtl\Garant\Daily\K398275085.pas',
  K415729926 in 'w:\common\components\rtl\Garant\Daily\K415729926.pas',
  K423621421 in 'w:\common\components\rtl\Garant\Daily\K423621421.pas',
  K424386600 in 'w:\common\components\rtl\Garant\Daily\K424386600.pas',
  K424399558 in 'w:\common\components\rtl\Garant\Daily\K424399558.pas',
  K356070665 in 'w:\common\components\rtl\Garant\Daily\K356070665.pas',
  K346754389 in 'w:\common\components\rtl\Garant\Daily\K346754389.pas',
  K431378356 in 'w:\common\components\rtl\Garant\Daily\K431378356.pas',
  K434763341 in 'w:\common\components\rtl\Garant\Daily\K434763341.pas',
  K435460794 in 'w:\common\components\rtl\Garant\Daily\K435460794.pas',
  K431386712 in 'w:\common\components\rtl\Garant\Daily\K431386712.pas',
  K439429165 in 'w:\common\components\rtl\Garant\Daily\K439429165.pas',
  K439979725 in 'w:\common\components\rtl\Garant\Daily\K439979725.pas',
  K440434932 in 'w:\common\components\rtl\Garant\Daily\K440434932.pas',
  K442368006 in 'w:\common\components\rtl\Garant\Daily\K442368006.pas',
  K444236481 in 'w:\common\components\rtl\Garant\Daily\K444236481.pas',
  K444999575 in 'w:\common\components\rtl\Garant\Daily\K444999575.pas',
  K444993775 in 'w:\common\components\rtl\Garant\Daily\K444993775.pas',
  K449682598 in 'w:\common\components\rtl\Garant\Daily\K449682598.pas',
  K332202037 in 'w:\common\components\rtl\Garant\Daily\K332202037.pas',
  K288786476 in 'w:\common\components\rtl\Garant\Daily\K288786476.pas',
  K336662790 in 'w:\common\components\rtl\Garant\Daily\K336662790.pas',
  K336666483 in 'w:\common\components\rtl\Garant\Daily\K336666483.pas',
  K251339809 in 'w:\common\components\rtl\Garant\Daily\K251339809.pas',
  K450277041 in 'w:\common\components\rtl\Garant\Daily\K450277041.pas',
  K452374409 in 'w:\common\components\rtl\Garant\Daily\K452374409.pas',
  K453151648 in 'w:\common\components\rtl\Garant\Daily\K453151648.pas',
  K453164226 in 'w:\common\components\rtl\Garant\Daily\K453164226.pas',
  K293279996 in 'w:\common\components\rtl\Garant\Daily\K293279996.pas',
  K321986755 in 'w:\common\components\rtl\Garant\Daily\K321986755.pas',
  K358359010 in 'w:\common\components\rtl\Garant\Daily\K358359010.pas',
  K459284317 in 'w:\common\components\rtl\Garant\Daily\K459284317.pas',
  K459284359 in 'w:\common\components\rtl\Garant\Daily\K459284359.pas',
  K459282006 in 'w:\common\components\rtl\Garant\Daily\K459282006.pas',
  K371654285 in 'w:\common\components\rtl\Garant\Daily\K371654285.pas',
  CheckingFilesInFolderTest in 'w:\common\components\rtl\Garant\Abstract_Tests\CheckingFilesInFolderTest.pas',
  K460262716 in 'w:\common\components\rtl\Garant\Daily\K460262716.pas',
  l3RegEx in 'w:\common\components\rtl\Garant\L3\l3RegEx.pas',
  l3IniFile in 'w:\common\components\rtl\Garant\L3\l3IniFile.pas',
  RegExpTest in 'w:\common\components\rtl\Garant\Daily\RegExpTest.pas',
  CustomFolderTestSuite in 'w:\common\components\rtl\Garant\Abstract_Tests\CustomFolderTestSuite.pas',
  K460275638Suite in 'w:\common\components\rtl\Garant\Daily\K460275638Suite.pas',
  K460275638 in 'w:\common\components\rtl\Garant\Daily\K460275638.pas',
  ddConfigStorages in 'w:\common\components\rtl\Garant\dd\ddConfigStorages.pas',
  Contnrs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Contnrs.pas' {$EndIf},
  l3ProtoPersistentRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentRefList.pas',
  ddAppConfigConst in 'w:\common\components\rtl\Garant\dd\ddAppConfigConst.pas',
  ddAppConfigBase in 'w:\common\components\rtl\Garant\dd\ddAppConfigBase.pas',
  ddAppConfigTypesRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas',
  vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas',
  SpinEditWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas',
  vtRadioButton in 'w:\common\components\gui\Garant\VT\vtRadioButton.pas',
  vtGroupBox in 'w:\common\components\gui\Garant\VT\vtGroupBox.pas',
  eeButton in 'w:\common\components\gui\Garant\VT\eeButton.pas',
  vtButton in 'w:\common\components\gui\Garant\VT\vtButton.pas'
  {$If not defined(NoVCL)}
  ,
  CheckLst {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CheckLst.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  CheckListBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas',
  ddAppConfigRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas',
  ddAppConfigTypes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas',
  ddAppConfigSimpleBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigSimpleBFrame.pas',
  ddAppConfigStringsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas',
  l3Base64 in 'w:\common\components\rtl\Garant\L3\l3Base64.pas'
  {$If not defined(NoVCL)}
  ,
  FileCtrl {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\FileCtrl.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  MMSystem {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\MMSystem.pas' {$EndIf},
  ddAppConfigStrings in 'w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas',
  l3TypedIntegerValueMap in 'w:\common\components\rtl\Garant\L3\l3TypedIntegerValueMap.pas',
  ddAppConfigDates in 'w:\common\components\rtl\Garant\dd\ddAppConfigDates.pas',
  ddAppConfigDataAdapters in 'w:\common\components\rtl\Garant\dd\ddAppConfigDataAdapters.pas',
  ddAppConfigListsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigListsRes.pas',
  ddAppConfigLists in 'w:\common\components\rtl\Garant\dd\ddAppConfigLists.pas'
  {$If not defined(Nemesis)}
  ,
  ddIniStorage in 'w:\common\components\rtl\Garant\dd\ddIniStorage.pas'
  {$IfEnd} //not Nemesis
  ,
  ddAppConfigUtils in 'w:\common\components\rtl\Garant\dd\ddAppConfigUtils.pas',
  ConfigStorageStub in 'w:\common\components\rtl\Garant\Daily\ConfigStorageStub.pas',
  l3ProtoPtrRecListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas',
  l3RecListWithPartialFind in 'w:\common\components\rtl\Garant\L3\l3RecListWithPartialFind.pas',
  l3ProtoPtrRecList in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecList.pas',
  l3BaseRecList in 'w:\common\components\rtl\Garant\L3\l3BaseRecList.pas',
  l3RecList in 'w:\common\components\rtl\Garant\L3\l3RecList.pas',
  ddAppConfigVersions in 'w:\common\components\rtl\Garant\dd\ddAppConfigVersions.pas',
  ddAppConfigWFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigWFrame.pas',
  ddAppConfigTFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigTFrame.pas',
  ddAppConfigBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigBFrame.pas',
  multimon {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\multimon.pas' {$EndIf},
  ddAppConfig in 'w:\common\components\rtl\Garant\dd\ddAppConfig.pas',
  AppConfigBaseTest in 'w:\common\components\rtl\Garant\Daily\AppConfigBaseTest.pas',
  LostNodeAppConfigTest in 'w:\common\components\rtl\Garant\Daily\LostNodeAppConfigTest.pas',
  K462555833 in 'w:\common\components\rtl\Garant\Daily\K462555833.pas',
  K462555833_1 in 'w:\common\components\rtl\Garant\Daily\K462555833_1.pas',
  K466751465 in 'w:\common\components\rtl\Garant\Daily\K466751465.pas',
  K462555879 in 'w:\common\components\rtl\Garant\Daily\K462555879.pas',
  K461701432 in 'w:\common\components\rtl\Garant\Daily\K461701432.pas',
  K471764286 in 'w:\common\components\rtl\Garant\Daily\K471764286.pas',
  K460279011 in 'w:\common\components\rtl\Garant\Daily\K460279011.pas',
  K237503145 in 'w:\common\components\rtl\Garant\Daily\K237503145.pas',
  K481450949 in 'w:\common\components\rtl\Garant\Daily\K481450949.pas',
  K480822492 in 'w:\common\components\rtl\Garant\Daily\K480822492.pas',
  K481811864 in 'w:\common\components\rtl\Garant\Daily\K481811864.pas',
  K483405717 in 'w:\common\components\rtl\Garant\Daily\K483405717.pas',
  K480825135 in 'w:\common\components\rtl\Garant\Daily\K480825135.pas',
  K493868665 in 'w:\common\components\rtl\Garant\Daily\K493868665.pas',
  K493324121 in 'w:\common\components\rtl\Garant\Daily\K493324121.pas',
  K494524369 in 'w:\common\components\rtl\Garant\Daily\K494524369.pas',
  K494528807 in 'w:\common\components\rtl\Garant\Daily\K494528807.pas',
  K502351620 in 'w:\common\components\rtl\Garant\Daily\K502351620.pas',
  K103942050 in 'w:\common\components\rtl\Garant\Daily\K103942050.pas',
  evNestedDocumentEliminator in 'w:\common\components\gui\Garant\Everest\evNestedDocumentEliminator.pas',
  evCommentParaDecorator in 'w:\common\components\gui\Garant\Everest\evCommentParaDecorator.pas',
  evCommentDecorator in 'w:\common\components\gui\Garant\Everest\evCommentDecorator.pas'
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const in 'w:\common\components\gui\Garant\Everest_Engine\f1TextStyle_Const.pas'
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeTextPara_InterfaceFactory in 'w:\common\components\gui\Garant\Everest_Engine\eeTextPara_InterfaceFactory.pas'
  {$IfEnd} //Nemesis
  ,
  eeTextParaCursor in 'w:\common\components\gui\Garant\Everest_Engine\eeTextParaCursor.pas',
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
  eeEVDtoRTF in 'w:\common\components\rtl\Garant\RenderEVD\eeEVDtoRTF.pas',
  EVDtoRTFRender in 'w:\common\components\rtl\Garant\Abstract_Tests\EVDtoRTFRender.pas',
  K509706011 in 'w:\common\components\rtl\Garant\Daily\K509706011.pas',
  K509706011_1 in 'w:\common\components\rtl\Garant\Daily\K509706011_1.pas',
  K509706011_2 in 'w:\common\components\rtl\Garant\Daily\K509706011_2.pas',
  K512248597 in 'w:\common\components\rtl\Garant\Daily\K512248597.pas',
  K518756624 in 'w:\common\components\rtl\Garant\Daily\K518756624.pas',
  K519483189 in 'w:\common\components\rtl\Garant\Daily\K519483189.pas',
  K530839239 in 'w:\common\components\rtl\Garant\Daily\K530839239.pas',
  K531957202 in 'w:\common\components\rtl\Garant\Daily\K531957202.pas',
  K531975039 in 'w:\common\components\rtl\Garant\Daily\K531975039.pas',
  K371639884 in 'w:\common\components\rtl\Garant\Daily\K371639884.pas',
  K535902713 in 'w:\common\components\rtl\Garant\Daily\K535902713.pas',
  K537233020 in 'w:\common\components\rtl\Garant\Daily\K537233020.pas',
  K537234131 in 'w:\common\components\rtl\Garant\Daily\K537234131.pas',
  K537954167 in 'w:\common\components\rtl\Garant\Daily\K537954167.pas',
  K537768536 in 'w:\common\components\rtl\Garant\Daily\K537768536.pas',
  K537249545 in 'w:\common\components\rtl\Garant\Daily\K537249545.pas',
  K537974930 in 'w:\common\components\rtl\Garant\Daily\K537974930.pas',
  K537973036 in 'w:\common\components\rtl\Garant\Daily\K537973036.pas',
  K537974183 in 'w:\common\components\rtl\Garant\Daily\K537974183.pas',
  K538546220 in 'w:\common\components\rtl\Garant\Daily\K538546220.pas',
  K538561126 in 'w:\common\components\rtl\Garant\Daily\K538561126.pas',
  K538560814 in 'w:\common\components\rtl\Garant\Daily\K538560814.pas',
  K538566131 in 'w:\common\components\rtl\Garant\Daily\K538566131.pas',
  K538550781 in 'w:\common\components\rtl\Garant\Daily\K538550781.pas',
  K537973358 in 'w:\common\components\rtl\Garant\Daily\K537973358.pas',
  K540160887 in 'w:\common\components\rtl\Garant\Daily\K540160887.pas',
  K538550943 in 'w:\common\components\rtl\Garant\Daily\K538550943.pas',
  K540412066 in 'w:\common\components\rtl\Garant\Daily\K540412066.pas',
  K540414443 in 'w:\common\components\rtl\Garant\Daily\K540414443.pas',
  K540414514 in 'w:\common\components\rtl\Garant\Daily\K540414514.pas',
  K537232046 in 'w:\common\components\rtl\Garant\Daily\K537232046.pas',
  K540615571 in 'w:\common\components\rtl\Garant\Daily\K540615571.pas',
  K541116849 in 'w:\common\components\rtl\Garant\Daily\K541116849.pas',
  K541120799 in 'w:\common\components\rtl\Garant\Daily\K541120799.pas',
  K541895041 in 'w:\common\components\rtl\Garant\Daily\K541895041.pas',
  K543433648 in 'w:\common\components\rtl\Garant\Daily\K543433648.pas',
  K555392182 in 'w:\common\components\rtl\Garant\Daily\K555392182.pas',
  K558471539 in 'w:\common\components\rtl\Garant\Daily\K558471539.pas',
  K558957526 in 'w:\common\components\rtl\Garant\Daily\K558957526.pas',
  K565008782 in 'w:\common\components\rtl\Garant\Daily\K565008782.pas',
  K565269737 in 'w:\common\components\rtl\Garant\Daily\K565269737.pas',
  K568147841 in 'w:\common\components\rtl\Garant\Daily\K568147841.pas',
  K571646843 in 'w:\common\components\rtl\Garant\Daily\K571646843.pas',
  k2TagTranslator in 'w:\common\components\rtl\Garant\K2\k2TagTranslator.pas',
  evdBadEVDToEmptyDocumentTranslator in 'w:\common\components\gui\Garant\Everest\evdBadEVDToEmptyDocumentTranslator.pas',
  BadEVDTest in 'w:\common\components\rtl\Garant\Daily\BadEVDTest.pas',
  K553427493 in 'w:\common\components\rtl\Garant\Daily\K553427493.pas',
  K553427493_notBad in 'w:\common\components\rtl\Garant\Daily\K553427493_notBad.pas',
  K543448591 in 'w:\common\components\rtl\Garant\Daily\K543448591.pas',
  K554585756 in 'w:\common\components\rtl\Garant\Daily\K554585756.pas',
  K585129079 in 'w:\common\components\rtl\Garant\Daily\K585129079.pas',
  K585129079_NSRC in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC.pas',
  K585129079_NSRC_ANSI in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC_ANSI.pas',
  K585129079_NSRC_EAST_EUROPE in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC_EAST_EUROPE.pas',
  K585129079_NSRC_KeepExisting in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC_KeepExisting.pas',
  K569230238 in 'w:\common\components\rtl\Garant\Daily\K569230238.pas',
  K569230238_NSRC in 'w:\common\components\rtl\Garant\Daily\K569230238_NSRC.pas',
  K569230238_EVD2EVD in 'w:\common\components\rtl\Garant\Daily\K569230238_EVD2EVD.pas',
  K585940757 in 'w:\common\components\rtl\Garant\Daily\K585940757.pas',
  K570542913 in 'w:\common\components\rtl\Garant\Daily\K570542913.pas',
  K585940693 in 'w:\common\components\rtl\Garant\Daily\K585940693.pas',
  K586353041 in 'w:\common\components\rtl\Garant\Daily\K586353041.pas',
  K586706776 in 'w:\common\components\rtl\Garant\Daily\K586706776.pas',
  K586173596 in 'w:\common\components\rtl\Garant\Daily\K586173596.pas',
  K586185519 in 'w:\common\components\rtl\Garant\Daily\K586185519.pas',
  K522781517 in 'w:\common\components\rtl\Garant\Daily\K522781517.pas',
  K522781827 in 'w:\common\components\rtl\Garant\Daily\K522781827.pas',
  K587155634 in 'w:\common\components\rtl\Garant\Daily\K587155634.pas',
  K588037593 in 'w:\common\components\rtl\Garant\Daily\K588037593.pas',
  K589860215 in 'w:\common\components\rtl\Garant\Daily\K589860215.pas',
  K590528525 in 'w:\common\components\rtl\Garant\Daily\K590528525.pas',
  K590512137 in 'w:\common\components\rtl\Garant\Daily\K590512137.pas',
  K590541952 in 'w:\common\components\rtl\Garant\Daily\K590541952.pas',
  K590745463 in 'w:\common\components\rtl\Garant\Daily\K590745463.pas',
  K590745831 in 'w:\common\components\rtl\Garant\Daily\K590745831.pas',
  K590774242 in 'w:\common\components\rtl\Garant\Daily\K590774242.pas',
  K591142760 in 'w:\common\components\rtl\Garant\Daily\K591142760.pas',
  K590757091 in 'w:\common\components\rtl\Garant\Daily\K590757091.pas',
  K590758825 in 'w:\common\components\rtl\Garant\Daily\K590758825.pas',
  K592250384 in 'w:\common\components\rtl\Garant\Daily\K592250384.pas',
  K592251812 in 'w:\common\components\rtl\Garant\Daily\K592251812.pas',
  K595456849 in 'w:\common\components\rtl\Garant\Daily\K595456849.pas',
  K595967367 in 'w:\common\components\rtl\Garant\Daily\K595967367.pas',
  K595976509 in 'w:\common\components\rtl\Garant\Daily\K595976509.pas',
  K596385595 in 'w:\common\components\rtl\Garant\Daily\K596385595.pas',
  K596386207 in 'w:\common\components\rtl\Garant\Daily\K596386207.pas',
  K596385658 in 'w:\common\components\rtl\Garant\Daily\K596385658.pas',
  K596385821 in 'w:\common\components\rtl\Garant\Daily\K596385821.pas',
  K598118986 in 'w:\common\components\rtl\Garant\Daily\K598118986.pas',
  K598131905 in 'w:\common\components\rtl\Garant\Daily\K598131905.pas',
  K599800930 in 'w:\common\components\rtl\Garant\Daily\K599800930.pas',
  K600665073 in 'w:\common\components\rtl\Garant\Daily\K600665073.pas',
  K600945017 in 'w:\common\components\rtl\Garant\Daily\K600945017.pas',
  K601206322 in 'w:\common\components\rtl\Garant\Daily\K601206322.pas',
  K601992686 in 'w:\common\components\rtl\Garant\Daily\K601992686.pas',
  K602000766 in 'w:\common\components\rtl\Garant\Daily\K602000766.pas',
  K602940462 in 'w:\common\components\rtl\Garant\Daily\K602940462.pas',
  K602940495 in 'w:\common\components\rtl\Garant\Daily\K602940495.pas',
  K601686929 in 'w:\common\components\rtl\Garant\Daily\K601686929.pas',
  K602703982 in 'w:\common\components\rtl\Garant\Daily\K602703982.pas',
  K602943932 in 'w:\common\components\rtl\Garant\Daily\K602943932.pas',
  K601462517 in 'w:\common\components\rtl\Garant\Daily\K601462517.pas',
  K604494903 in 'w:\common\components\rtl\Garant\Daily\K604494903.pas',
  K604920400 in 'w:\common\components\rtl\Garant\Daily\K604920400.pas',
  K603416415 in 'w:\common\components\rtl\Garant\Daily\K603416415.pas',
  K605147298 in 'w:\common\components\rtl\Garant\Daily\K605147298.pas',
  K605380857 in 'w:\common\components\rtl\Garant\Daily\K605380857.pas',
  K604908954 in 'w:\common\components\rtl\Garant\Daily\K604908954.pas',
  K605843892 in 'w:\common\components\rtl\Garant\Daily\K605843892.pas',
  K606111976 in 'w:\common\components\rtl\Garant\Daily\K606111976.pas',
  K606118757 in 'w:\common\components\rtl\Garant\Daily\K606118757.pas',
  K606129271 in 'w:\common\components\rtl\Garant\Daily\K606129271.pas',
  K606138650 in 'w:\common\components\rtl\Garant\Daily\K606138650.pas',
  K588577774 in 'w:\common\components\rtl\Garant\Daily\K588577774.pas',
  K606634250 in 'w:\common\components\rtl\Garant\Daily\K606634250.pas',
  K606129412 in 'w:\common\components\rtl\Garant\Daily\K606129412.pas',
  K606808862 in 'w:\common\components\rtl\Garant\Daily\K606808862.pas',
  K606808786 in 'w:\common\components\rtl\Garant\Daily\K606808786.pas',
  K607532057 in 'w:\common\components\rtl\Garant\Daily\K607532057.pas',
  K607532796 in 'w:\common\components\rtl\Garant\Daily\K607532796.pas',
  K607532072 in 'w:\common\components\rtl\Garant\Daily\K607532072.pas',
  K607750753 in 'w:\common\components\rtl\Garant\Daily\K607750753.pas',
  K607284377 in 'w:\common\components\rtl\Garant\Daily\K607284377.pas',
  l3IntegerToIntegerMap in 'w:\common\components\rtl\Garant\L3\l3IntegerToIntegerMap.pas',
  l3IntegerToIntegerMapTest in 'w:\common\components\rtl\Garant\Daily\l3IntegerToIntegerMapTest.pas',
  testCConstDelphiString in 'w:\common\components\rtl\Garant\Daily\testCConstDelphiString.pas',
  tfwParserTokenListTest in 'w:\common\components\rtl\Garant\Daily\tfwParserTokenListTest.pas',
  K604929313 in 'w:\common\components\rtl\Garant\Daily\K604929313.pas',
  K604929290 in 'w:\common\components\rtl\Garant\Daily\K604929290.pas',
  K605362960 in 'w:\common\components\rtl\Garant\Daily\K605362960.pas',
  K607751255 in 'w:\common\components\rtl\Garant\Daily\K607751255.pas',
  K608627112 in 'w:\common\components\rtl\Garant\Daily\K608627112.pas',
  K608626880 in 'w:\common\components\rtl\Garant\Daily\K608626880.pas',
  K598131874 in 'w:\common\components\rtl\Garant\Daily\K598131874.pas',
  K598136171 in 'w:\common\components\rtl\Garant\Daily\K598136171.pas',
  K607531290 in 'w:\common\components\rtl\Garant\Daily\K607531290.pas',
  K608627000 in 'w:\common\components\rtl\Garant\Daily\K608627000.pas',
  K608627000_Back in 'w:\common\components\rtl\Garant\Daily\K608627000_Back.pas',
  K607531290_Back in 'w:\common\components\rtl\Garant\Daily\K607531290_Back.pas',
  K608627000_Restore in 'w:\common\components\rtl\Garant\Daily\K608627000_Restore.pas',
  K598136171_Restore in 'w:\common\components\rtl\Garant\Daily\K598136171_Restore.pas',
  K609131924 in 'w:\common\components\rtl\Garant\Daily\K609131924.pas',
  K607275587 in 'w:\common\components\rtl\Garant\Daily\K607275587.pas',
  K609886857 in 'w:\common\components\rtl\Garant\Daily\K609886857.pas',
  K609602166 in 'w:\common\components\rtl\Garant\Daily\K609602166.pas',
  K609132323 in 'w:\common\components\rtl\Garant\Daily\K609132323.pas',
  K610084627 in 'w:\common\components\rtl\Garant\Daily\K610084627.pas',
  K607284891 in 'w:\common\components\rtl\Garant\Daily\K607284891.pas',
  K138969449 in 'w:\common\components\rtl\Garant\Daily\K138969449.pas',
  K610503532 in 'w:\common\components\rtl\Garant\Daily\K610503532.pas',
  K610504218 in 'w:\common\components\rtl\Garant\Daily\K610504218.pas',
  K610745702 in 'w:\common\components\rtl\Garant\Daily\K610745702.pas',
  K610745715 in 'w:\common\components\rtl\Garant\Daily\K610745715.pas',
  K610745778 in 'w:\common\components\rtl\Garant\Daily\K610745778.pas',
  K610746048 in 'w:\common\components\rtl\Garant\Daily\K610746048.pas',
  evEvdWriter in 'w:\common\components\gui\Garant\Everest\evEvdWriter.pas',
  ddHeaderFilter in 'w:\common\components\rtl\Garant\dd\ddHeaderFilter.pas',
  dd_lcBaseFilter in 'w:\common\components\rtl\Garant\dd\dd_lcBaseFilter.pas',
  dd_lcTextFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcTextFormatter.pas',
  dd_lcSectionEliminator in 'w:\common\components\rtl\Garant\dd\dd_lcSectionEliminator.pas',
  ddSpaceTrimmer in 'w:\common\components\rtl\Garant\dd\ddSpaceTrimmer.pas',
  dd_lcTableEliminator in 'w:\common\components\rtl\Garant\dd\dd_lcTableEliminator.pas',
  evEvdReader in 'w:\common\components\gui\Garant\Everest\evEvdReader.pas',
  dd_lcPageNumberEliminator in 'w:\common\components\rtl\Garant\dd\dd_lcPageNumberEliminator.pas',
  dd_lcCodeCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcCodeCorrector.pas',
  dd_lcVASCodeCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcVASCodeCorrector.pas',
  dd_lcYearCodeCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcYearCodeCorrector.pas',
  ddDocumentFilter in 'w:\common\components\rtl\Garant\dd\ddDocumentFilter.pas',
  dd_lcBaseDocFilter in 'w:\common\components\rtl\Garant\dd\dd_lcBaseDocFilter.pas',
  dd_lcTypeConverter in 'w:\common\components\rtl\Garant\dd\dd_lcTypeConverter.pas',
  dd_lcSourceConverter in 'w:\common\components\rtl\Garant\dd\dd_lcSourceConverter.pas',
  dd_lcVASSourceCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcVASSourceCorrector.pas',
  dd_lcTextFormatter2 in 'w:\common\components\rtl\Garant\dd\dd_lcTextFormatter2.pas',
  dd_lcResolutionFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcResolutionFormatter.pas',
  dd_lcJudgeFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcJudgeFormatter.pas',
  dd_lcDateNumberFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcDateNumberFormatter.pas',
  dd_lcCityNameFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcCityNameFormatter.pas',
  dd_lcTitleFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcTitleFormatter.pas',
  dd_lcStartDocFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcStartDocFormatter.pas',
  dd_lcTextStyleCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcTextStyleCorrector.pas',
  dd_lcTextSplitter in 'w:\common\components\rtl\Garant\dd\dd_lcTextSplitter.pas',
  AACFiltersTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\AACFiltersTest.pas',
  m3Interfaces in 'w:\common\components\rtl\Garant\m3\m3Interfaces.pas',
  m3StorageInterfaces in 'w:\common\components\rtl\Garant\m3\m3StorageInterfaces.pas',
  m3DBInterfaces in 'w:\common\components\rtl\Garant\m3\m3DBInterfaces.pas',
  m3StorageTools in 'w:\common\components\rtl\Garant\m3\m3StorageTools.pas',
  m2COMLib in 'w:\common\components\rtl\Garant\L3\m2\m2COMLib.pas',
  m2InternalInterfaces in 'w:\common\components\rtl\Garant\L3\m2\m2InternalInterfaces.pas',
  m3PrimStream in 'w:\common\components\rtl\Garant\m3\m3PrimStream.pas',
  m3BaseStream in 'w:\common\components\rtl\Garant\m3\m3BaseStream.pas',
  m3FileStreamMapView in 'w:\common\components\rtl\Garant\m3\m3FileStreamMapView.pas',
  m2AddPrc in 'w:\common\components\rtl\Garant\L3\m2\m2AddPrc.pas',
  m3FileStream in 'w:\common\components\rtl\Garant\m3\m3FileStream.pas',
  m3SplittedFileStream in 'w:\common\components\rtl\Garant\m3\m3SplittedFileStream.pas',
  l3ExceptionsLogEx in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLogEx.pas',
  l3Logger in 'w:\common\components\rtl\Garant\L3\l3Logger.pas',
  m3FileRegion in 'w:\common\components\rtl\Garant\m3\m3FileRegion.pas',
  m3RootStreamManagerPrimPrim in 'w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrimPrim.pas',
  m3Exceptions in 'w:\common\components\rtl\Garant\m3\m3Exceptions.pas',
  m3StoreHeaderDataPrim in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderDataPrim.pas',
  m3RootStreamManagerPrim in 'w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrim.pas',
  m3StoreHeader in 'w:\common\components\rtl\Garant\m3\m3StoreHeader.pas',
  m3BaseStore in 'w:\common\components\rtl\Garant\m3\m3BaseStore.pas',
  m3BaseStorage in 'w:\common\components\rtl\Garant\m3\m3BaseStorage.pas',
  m3StoragePrim in 'w:\common\components\rtl\Garant\m3\m3StoragePrim.pas',
  m3CustomStream in 'w:\common\components\rtl\Garant\m3\m3CustomStream.pas',
  m2S32Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S32Lib.pas',
  m2S64Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S64Lib.pas',
  m3BuffStream in 'w:\common\components\rtl\Garant\m3\m3BuffStream.pas',
  m3Persistent in 'w:\common\components\rtl\Garant\m3\m3Persistent.pas',
  m3TOCHandle in 'w:\common\components\rtl\Garant\m3\m3TOCHandle.pas',
  m3TOCHandleList in 'w:\common\components\rtl\Garant\m3\m3TOCHandleList.pas',
  m3Const in 'w:\common\components\rtl\Garant\m3\m3Const.pas',
  m3CommonStorageStream in 'w:\common\components\rtl\Garant\m3\m3CommonStorageStream.pas',
  m3CommonStorage in 'w:\common\components\rtl\Garant\m3\m3CommonStorage.pas',
  m3NewStoragePrim in 'w:\common\components\rtl\Garant\m3\m3NewStoragePrim.pas',
  m3StorageBlock in 'w:\common\components\rtl\Garant\m3\m3StorageBlock.pas',
  m3NewStorageStreamPrim in 'w:\common\components\rtl\Garant\m3\m3NewStorageStreamPrim.pas',
  m3NewStorageStream in 'w:\common\components\rtl\Garant\m3\m3NewStorageStream.pas',
  m3StorageIndexStream in 'w:\common\components\rtl\Garant\m3\m3StorageIndexStream.pas',
  m3StorageIndexStreamForIterate in 'w:\common\components\rtl\Garant\m3\m3StorageIndexStreamForIterate.pas',
  m3StorageTableOfContentsStream in 'w:\common\components\rtl\Garant\m3\m3StorageTableOfContentsStream.pas',
  m3ReadOnlyRootStreamManager in 'w:\common\components\rtl\Garant\m3\m3ReadOnlyRootStreamManager.pas',
  m3LinkedStream in 'w:\common\components\rtl\Garant\m3\m3LinkedStream.pas',
  m3BaseHeaderStream in 'w:\common\components\rtl\Garant\m3\m3BaseHeaderStream.pas',
  m2AddDbg in 'w:\common\components\rtl\Garant\L3\m2\m2AddDbg.pas',
  m3RootStream in 'w:\common\components\rtl\Garant\m3\m3RootStream.pas',
  l3Int64List in 'w:\common\components\rtl\Garant\L3\l3Int64List.pas',
  l3RevertedInt64List in 'w:\common\components\rtl\Garant\L3\l3RevertedInt64List.pas',
  m3RootStreamManager in 'w:\common\components\rtl\Garant\m3\m3RootStreamManager.pas',
  m3StoreHeaderData in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderData.pas',
  m3StoreHeaderDataNew in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderDataNew.pas',
  m3RootStreamNew in 'w:\common\components\rtl\Garant\m3\m3RootStreamNew.pas',
  m3NewRootStreamManager in 'w:\common\components\rtl\Garant\m3\m3NewRootStreamManager.pas',
  m3CustomNewStorage in 'w:\common\components\rtl\Garant\m3\m3CustomNewStorage.pas',
  m3BaseEnumStatStg in 'w:\common\components\rtl\Garant\m3\m3BaseEnumStatStg.pas',
  m3TempEnumStatStg in 'w:\common\components\rtl\Garant\m3\m3TempEnumStatStg.pas',
  m3NewStorage in 'w:\common\components\rtl\Garant\m3\m3NewStorage.pas',
  m3ArchiveStorage in 'w:\common\components\rtl\Garant\m3\m3ArchiveStorage.pas',
  m3StorageService in 'w:\common\components\rtl\Garant\m3\m3StorageService.pas',
  m3StgMgr in 'w:\common\components\rtl\Garant\m3\m3StgMgr.pas',
  m3StorageElementIDList in 'w:\common\components\rtl\Garant\m3\m3StorageElementIDList.pas',
  m3BackupTools in 'w:\common\components\rtl\Garant\m3\m3BackupTools.pas',
  l3ProxyStream in 'w:\common\components\rtl\Garant\L3\l3ProxyStream.pas',
  m3DBProxyStream in 'w:\common\components\rtl\Garant\m3\m3DBProxyStream.pas',
  m3DBProxyWriteStream in 'w:\common\components\rtl\Garant\m3\m3DBProxyWriteStream.pas',
  m3DBActions in 'w:\common\components\rtl\Garant\m3\m3DBActions.pas',
  m3PrimDB in 'w:\common\components\rtl\Garant\m3\m3PrimDB.pas',
  m3BaseObject in 'w:\common\components\rtl\Garant\m3\m3BaseObject.pas',
  m3NewVersionStream in 'w:\common\components\rtl\Garant\m3\m3NewVersionStream.pas',
  l3ForkStream in 'w:\common\components\rtl\Garant\L3\l3ForkStream.pas',
  m3DBDocumentPart in 'w:\common\components\rtl\Garant\m3\m3DBDocumentPart.pas',
  m3DBDocument in 'w:\common\components\rtl\Garant\m3\m3DBDocument.pas',
  m3DBFiler in 'w:\common\components\rtl\Garant\m3\m3DBFiler.pas',
  m3DB in 'w:\common\components\rtl\Garant\m3\m3DB.pas',
  ArchiStorageTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTest.pas',
  ArchiStorageTestWithRename in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTestWithRename.pas',
  m4DBInterfaces in 'w:\common\components\rtl\Garant\m4\m4DBInterfaces.pas',
  m4DB in 'w:\common\components\rtl\Garant\m4\m4DB.pas',
  m3StorageIndexAdapter in 'w:\common\components\rtl\Garant\TestsSupport\m3StorageIndexAdapter.pas',
  StgIndexTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\StgIndexTest.pas',
  DataBaseTester in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\DataBaseTester.pas',
  MultyOperationTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\MultyOperationTest.pas',
  K275780190 in 'w:\common\components\rtl\Garant\Archi_Tests\K275780190.pas',
  K294595323Suite in 'w:\common\components\rtl\Garant\Archi_Tests\K294595323Suite.pas',
  K294595323 in 'w:\common\components\rtl\Garant\Archi_Tests\K294595323.pas',
  K327821495 in 'w:\common\components\rtl\Garant\Archi_Tests\K327821495.pas',
  K392696007 in 'w:\common\components\rtl\Garant\Archi_Tests\K392696007.pas',
  K361038156 in 'w:\common\components\rtl\Garant\Archi_Tests\K361038156.pas',
  K365838449 in 'w:\common\components\rtl\Garant\Archi_Tests\K365838449.pas'
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwLoadFromFile in 'w:\common\components\rtl\Garant\Keywords4Daily\kwLoadFromFile.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwSetFontSize in 'w:\common\components\rtl\Garant\Keywords4Daily\kwSetFontSize.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  kwGetFontSize in 'w:\common\components\rtl\Garant\Keywords4Daily\kwGetFontSize.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  SupportKeyWords in 'w:\common\components\rtl\Garant\Keywords4Daily\SupportKeyWords.pas'
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  {$If defined(nsTest) AND not defined(InsiderTest) AND not defined(NoScripts)}
  ,
  SHDTestScriptEngine in 'w:\common\components\rtl\Garant\Daily\SHDTestScriptEngine.pas'
  {$IfEnd} //nsTest AND not InsiderTest AND not NoScripts
  ,
  toK in 'toK.pas',
  ItsLAW in 'ItsLAW.pas',
  Archi2 in 'Archi2.pas',
  toK64 in 'toK64.pas',
  toKT in 'toKT.pas'
  ;
{$IfEnd} //nsTest AND not NoScripts

{$R DailyTest.res}

begin
 {$IfDef nsTest}
 g_CVSPath := 'w:\common\components\DailyTest';
 {$EndIf nsTest}
 //#UC START# *4B2A48AA03D4CVSPath*
 //#UC END# *4B2A48AA03D4CVSPath*
 TAutoTestsSuite.Register;
 try
  if KTestRunner.NeedKTestRunner([TtoK, TItsLAW, TArchi2, TtoK64, TtoKT]) then
   KTestRunner.RunRegisteredTests
  else
  if System.IsConsole then
   TextTestRunner.RunRegisteredTests
  else
   GUITestRunner.RunRegisteredTests;
 except
  on E: Exception do
  begin
   {$If defined(MTDORB) AND defined(NoKPageTool)}
   if TKBridge.Exists then
    TKBridge.Instance.Logout;
   {$IfEnd}
   l3System.Exception2Log(E);
   Halt(2);
  end;//Exception
 end;//try..except
 if (TestsExitCode <> 0) then
  Halt(TestsExitCode);
end.