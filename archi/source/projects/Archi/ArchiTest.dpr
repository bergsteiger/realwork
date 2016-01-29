program ArchiTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/Archi/ArchiTest.dpr"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestTarget::Category>> archi$Test::Archi$Test
//
// Тесты Арчи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Archi\arDefine.inc}

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  ControlResizeBugFix
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
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
  ,
  tfwScriptDebugger in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptDebugger.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
  
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
  kwInnerIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncluded.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwINCLUDES in 'w:\common\components\rtl\Garant\ScriptEngine\kwINCLUDES.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwInnerIncludedInChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwInnerIncludedInChildren.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwIncludesInChildren in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncludesInChildren.pas'
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
  ,
  GUIAppTester in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.pas',
  l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiInsiderTest in 'Archi_Insider_Test_Support\ArchiInsiderTest.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  K264902382 in 'Tests\K264902382.pas',
  K266421641 in 'Tests\K266421641.pas',
  K271754614 in 'Tests\K271754614.pas',
  K200902504 in 'Tests\K200902504.pas',
  K280007486 in 'Tests\K280007486.pas',
  K280010450 in 'Tests\K280010450.pas',
  K227478574 in 'Tests\K227478574.pas',
  K296094711 in 'Tests\K296094711.pas',
  K296621183 in 'Tests\K296621183.pas',
  K296094716 in 'Tests\K296094716.pas',
  K297698018 in 'Tests\K297698018.pas',
  K313754442 in 'Tests\K313754442.pas',
  K224788683 in 'Tests\K224788683.pas',
  K210436431 in 'Tests\K210436431.pas',
  K294603661 in 'Tests\K294603661.pas',
  K325258836 in 'Tests\K325258836.pas',
  K329649989 in 'Tests\K329649989.pas',
  K330139532 in 'Tests\K330139532.pas',
  K330704233 in 'Tests\K330704233.pas',
  K342861821 in 'Tests\K342861821.pas',
  K344130696 in 'Tests\K344130696.pas',
  K345637305 in 'Tests\K345637305.pas',
  K352455870 in 'Tests\K352455870.pas',
  K358976702 in 'Tests\K358976702.pas',
  K358976074 in 'Tests\K358976074.pas',
  K371636355 in 'Tests\K371636355.pas',
  K380045677 in 'Tests\K380045677.pas',
  K377750479 in 'Tests\K377750479.pas',
  K338003978 in 'Tests\K338003978.pas',
  K273595400 in 'Tests\K273595400.pas',
  K323059794 in 'Tests\K323059794.pas',
  K327812385 in 'Tests\K327812385.pas',
  K330141531 in 'Tests\K330141531.pas',
  K356070765 in 'Tests\K356070765.pas',
  K358976777 in 'Tests\K358976777.pas',
  K389942714 in 'Tests\K389942714.pas',
  K330705088 in 'Tests\K330705088.pas',
  K434737002 in 'Tests\K434737002.pas',
  K437125222 in 'Tests\K437125222.pas',
  K480809940 in 'Tests\K480809940.pas',
  K481449280 in 'Tests\K481449280.pas',
  K522796828 in 'Tests\K522796828.pas',
  K235876114 in 'Tests\K235876114.pas',
  K280859299 in 'Tests\K280859299.pas',
  K330140819 in 'Tests\K330140819.pas',
  K339869830 in 'Tests\K339869830.pas',
  K356063074 in 'Tests\K356063074.pas',
  K384434990 in 'Tests\K384434990.pas',
  K392695706 in 'Tests\K392695706.pas',
  K397291894 in 'Tests\K397291894.pas',
  K401511110 in 'Tests\K401511110.pas',
  K407745210 in 'Tests\K407745210.pas',
  K419695643 in 'Tests\K419695643.pas',
  K425284919 in 'Tests\K425284919.pas',
  K452392846 in 'Tests\K452392846.pas',
  K448463392 in 'Tests\K448463392.pas',
  K458072971 in 'Tests\K458072971.pas',
  K466751170 in 'Tests\K466751170.pas',
  K449678171 in 'Tests\K449678171.pas',
  K466752657 in 'Tests\K466752657.pas',
  K466752604 in 'Tests\K466752604.pas',
  K474154467 in 'Tests\K474154467.pas',
  K161121021 in 'Tests\K161121021.pas',
  K144575411 in 'Tests\K144575411.pas',
  K475464074 in 'Tests\K475464074.pas',
  K477643230 in 'Tests\K477643230.pas',
  K281519812 in 'Tests\K281519812.pas',
  K120718860 in 'Tests\K120718860.pas',
  K479402089 in 'Tests\K479402089.pas',
  K441354827 in 'Tests\K441354827.pas',
  K479402974 in 'Tests\K479402974.pas',
  K479402808 in 'Tests\K479402808.pas',
  K278843000 in 'Tests\K278843000.pas',
  K430740658 in 'Tests\K430740658.pas',
  K447393371 in 'Tests\K447393371.pas',
  K269080484 in 'Tests\K269080484.pas',
  K271189977 in 'Tests\K271189977.pas',
  K271190109 in 'Tests\K271190109.pas',
  K271752866 in 'Tests\K271752866.pas',
  K300027413 in 'Tests\K300027413.pas',
  K300028777 in 'Tests\K300028777.pas',
  K296094705 in 'Tests\K296094705.pas',
  K296620708 in 'Tests\K296620708.pas',
  K331186226 in 'Tests\K331186226.pas',
  K356063519 in 'Tests\K356063519.pas',
  K367198557 in 'Tests\K367198557.pas',
  K522096709 in 'Tests\K522096709.pas',
  K309168151 in 'Tests\K309168151.pas',
  K109904163 in 'Tests\K109904163.pas',
  K310673720 in 'Tests\K310673720.pas',
  K320743144 in 'Tests\K320743144.pas',
  K104434922 in 'Tests\K104434922.pas',
  K290947845 in 'Tests\K290947845.pas',
  K290951663 in 'Tests\K290951663.pas',
  K290951686 in 'Tests\K290951686.pas',
  K297703832 in 'Tests\K297703832.pas',
  K323061070 in 'Tests\K323061070.pas',
  K330140470 in 'Tests\K330140470.pas',
  K330140904 in 'Tests\K330140904.pas',
  K333550210 in 'Tests\K333550210.pas',
  K336137132 in 'Tests\K336137132.pas',
  K336137156 in 'Tests\K336137156.pas',
  K336659951 in 'Tests\K336659951.pas',
  K336660676 in 'Tests\K336660676.pas',
  K235864238 in 'Tests\K235864238.pas',
  K235864247 in 'Tests\K235864247.pas',
  K341838531 in 'Tests\K341838531.pas',
  K342862858 in 'Tests\K342862858.pas',
  K349116289 in 'Tests\K349116289.pas',
  K354255065 in 'Tests\K354255065.pas',
  K358354724 in 'Tests\K358354724.pas',
  K358365470 in 'Tests\K358365470.pas',
  K370383707 in 'Tests\K370383707.pas',
  K380044630 in 'Tests\K380044630.pas',
  K390585154 in 'Tests\K390585154.pas',
  K395647218 in 'Tests\K395647218.pas',
  K395658761 in 'Tests\K395658761.pas',
  K395654924 in 'Tests\K395654924.pas',
  K395659375 in 'Tests\K395659375.pas',
  K400531159 in 'Tests\K400531159.pas',
  K407150344 in 'Tests\K407150344.pas',
  K410628348 in 'Tests\K410628348.pas',
  K431359667 in 'Tests\K431359667.pas',
  K336658853 in 'Tests\K336658853.pas',
  K362130404 in 'Tests\K362130404.pas',
  K370384889 in 'Tests\K370384889.pas',
  K377749722 in 'Tests\K377749722.pas',
  K341082326 in 'Tests\K341082326.pas',
  K340165072 in 'Tests\K340165072.pas',
  K340176143 in 'Tests\K340176143.pas',
  K349118532 in 'Tests\K349118532.pas',
  K358353189 in 'Tests\K358353189.pas',
  K358355183 in 'Tests\K358355183.pas',
  K358355026 in 'Tests\K358355026.pas',
  K358975645 in 'Tests\K358975645.pas',
  K336667714 in 'Tests\K336667714.pas',
  K358975616 in 'Tests\K358975616.pas',
  K358353966 in 'Tests\K358353966.pas',
  K365831268 in 'Tests\K365831268.pas',
  K365844614 in 'Tests\K365844614.pas',
  K371644395 in 'Tests\K371644395.pas',
  K379250166 in 'Tests\K379250166.pas',
  K380604713 in 'Tests\K380604713.pas',
  K382408648 in 'Tests\K382408648.pas',
  K409747548 in 'Tests\K409747548.pas',
  K435460780 in 'Tests\K435460780.pas',
  K439979342 in 'Tests\K439979342.pas',
  K447392400 in 'Tests\K447392400.pas',
  K449024991 in 'Tests\K449024991.pas',
  K159367236 in 'Tests\K159367236.pas',
  K289276523 in 'Tests\K289276523.pas',
  K299140051 in 'Tests\K299140051.pas',
  K342866806 in 'Tests\K342866806.pas',
  K343640765 in 'Tests\K343640765.pas',
  K370383768 in 'Tests\K370383768.pas',
  K382421131 in 'Tests\K382421131.pas',
  K407150878 in 'Tests\K407150878.pas',
  K407736033 in 'Tests\K407736033.pas',
  K404361004 in 'Tests\K404361004.pas',
  K421123801 in 'Tests\K421123801.pas',
  K423593340 in 'Tests\K423593340.pas',
  K425036023 in 'Tests\K425036023.pas',
  K271754328 in 'Tests\K271754328.pas',
  K338005013 in 'Tests\K338005013.pas',
  K233734230 in 'Tests\K233734230.pas',
  K356060358 in 'Tests\K356060358.pas',
  K358976247 in 'Tests\K358976247.pas',
  K382407838 in 'Tests\K382407838.pas',
  K390586769 in 'Tests\K390586769.pas',
  K395662507 in 'Tests\K395662507.pas',
  K395658792 in 'Tests\K395658792.pas',
  K407150397 in 'Tests\K407150397.pas',
  K407150049 in 'Tests\K407150049.pas',
  K407740554 in 'Tests\K407740554.pas',
  K421123924 in 'Tests\K421123924.pas',
  K421111320 in 'Tests\K421111320.pas',
  K423605014 in 'Tests\K423605014.pas',
  K425035996 in 'Tests\K425035996.pas',
  K425264440 in 'Tests\K425264440.pas',
  K425273666 in 'Tests\K425273666.pas',
  K382406560 in 'Tests\K382406560.pas',
  K515524193 in 'Tests\K515524193.pas',
  K342859055 in 'Tests\K342859055.pas',
  K281520291 in 'Tests\K281520291.pas',
  K344138247 in 'Tests\K344138247.pas',
  K356072821 in 'Tests\K356072821.pas',
  K333553224 in 'Tests\K333553224.pas',
  K370389917 in 'Tests\K370389917.pas',
  K371196695 in 'Tests\K371196695.pas',
  K375849907 in 'Tests\K375849907.pas',
  K382420133 in 'Tests\K382420133.pas',
  K265412031 in 'Tests\K265412031.pas',
  K271754425 in 'Tests\K271754425.pas',
  K347635743 in 'Tests\K347635743.pas',
  K347636295 in 'Tests\K347636295.pas',
  K360481669 in 'Tests\K360481669.pas',
  K363564248 in 'Tests\K363564248.pas',
  K363571851 in 'Tests\K363571851.pas',
  K103940427 in 'Tests\K103940427.pas',
  K363570808 in 'Tests\K363570808.pas',
  K105579791 in 'Tests\K105579791.pas',
  K370384999 in 'Tests\K370384999.pas',
  K409757935 in 'Tests\K409757935.pas',
  K362973200 in 'Tests\K362973200.pas',
  K362975266 in 'Tests\K362975266.pas',
  K330140756 in 'Tests\K330140756.pas',
  K200087275 in 'Tests\K200087275.pas',
  K206078013 in 'Tests\K206078013.pas',
  K365824453 in 'Tests\K365824453.pas',
  K380606923 in 'Tests\K380606923.pas',
  K425040715 in 'Tests\K425040715.pas',
  K437519082 in 'Tests\K437519082.pas',
  K437519085 in 'Tests\K437519085.pas',
  K437519128 in 'Tests\K437519128.pas',
  K437519159 in 'Tests\K437519159.pas',
  K453149163 in 'Tests\K453149163.pas',
  K400523879 in 'Tests\K400523879.pas',
  K425273506 in 'Tests\K425273506.pas',
  K425263512 in 'Tests\K425263512.pas',
  K409758383 in 'Tests\K409758383.pas',
  K424381826 in 'Tests\K424381826.pas',
  K437519030 in 'Tests\K437519030.pas',
  K358976813 in 'Tests\K358976813.pas',
  K480819960 in 'Tests\K480819960.pas',
  K480817440 in 'Tests\K480817440.pas',
  K482752570 in 'Tests\K482752570.pas',
  K482767115 in 'Tests\K482767115.pas',
  K517791575 in 'Tests\K517791575.pas',
  dt_Types in 'w:\common\components\rtl\Garant\dd\dt_Types.pas'
  {$If not defined(Nemesis)}
  ,
  csTaskTypes in 'w:\common\components\rtl\Garant\cs\csTaskTypes.pas'
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ddTaskRecord in 'w:\common\components\rtl\Garant\cs\ddTaskRecord.pas'
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ddTaskRecordList in 'w:\common\components\rtl\Garant\cs\ddTaskRecordList.pas'
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ddTaskClassManager in 'w:\common\components\rtl\Garant\cs\ddTaskClassManager.pas'
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ddServerTask in 'w:\common\components\rtl\Garant\cs\ddServerTask.pas'
  {$IfEnd} //not Nemesis
  ,
  RegisteredTasksTest in 'Tests\RegisteredTasksTest.pas',
  toK in 'toK.pas'
  {$If defined(AppClientSide)}
  ,
  arHAFPainer in 'Editor\arHAFPainer.pas'
  {$IfEnd} //AppClientSide
  ,
  dt_Const in 'w:\common\components\rtl\Garant\dd\dt_Const.pas'
  {$If defined(AppClientSide)}
  ,
  arSubImplementation in 'Editor\arSubImplementation.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  arDocumentContainer in 'Editor\arDocumentContainer.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  arTextOfDocument in 'Editor\arTextOfDocument.pas'
  {$IfEnd} //AppClientSide
  ,
  evOutTextParaEliminator in 'w:\common\components\gui\Garant\Everest\evOutTextParaEliminator.pas'
  {$If defined(AppClientSide)}
  ,
  arSpravkaDocumentContainer in 'Editor\arSpravkaDocumentContainer.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  arSpravkaTextOfDocument in 'Editor\arSpravkaTextOfDocument.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  DocIntf in 'Editor\DocIntf.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  DictMetaForm in 'MetaForms\DictMetaForm.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  InsDWin in 'Dlg\InsDWin.pas'
  {$IfEnd} //AppClientSide
  ,
  l3Forms in 'w:\common\components\rtl\Garant\L3\l3Forms.pas',
  vtForm in 'w:\common\components\gui\Garant\VT\vtForm.pas'
  {$If defined(AppClientSide)}
  ,
  VMailWin in 'Dlg\VMailWin.pas'
  {$IfEnd} //AppClientSide
  ,
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
  evExtFormat in 'w:\common\components\gui\Garant\Everest\ext\evExtFormat.pas'
  {$If defined(AppClientSide)}
  ,
  Main in 'Main\Main.pas'
  {$IfEnd} //AppClientSide
  ,
  daTypes in 'w:\common\components\rtl\Garant\DA\daTypes.pas'
  {$If not defined(Nemesis)}
  ,
  DictsSup in 'w:\common\components\rtl\Garant\DT\DictsSup.pas'
  {$IfEnd} //not Nemesis
  
  {$If defined(AppClientSide) AND not defined(Nemesis)}
  ,
  ddClientBaseEngine in 'w:\common\components\rtl\Garant\cs\ddClientBaseEngine.pas'
  {$IfEnd} //AppClientSide AND not Nemesis
  ,
  m3StorageInterfaces in 'w:\common\components\rtl\Garant\m3\m3StorageInterfaces.pas',
  m2InternalInterfaces in 'w:\common\components\rtl\Garant\L3\m2\m2InternalInterfaces.pas',
  m3BaseStore in 'w:\common\components\rtl\Garant\m3\m3BaseStore.pas',
  m2COMLib in 'w:\common\components\rtl\Garant\L3\m2\m2COMLib.pas',
  m3BaseStorage in 'w:\common\components\rtl\Garant\m3\m3BaseStorage.pas',
  m3StoragePrim in 'w:\common\components\rtl\Garant\m3\m3StoragePrim.pas',
  m3PrimStream in 'w:\common\components\rtl\Garant\m3\m3PrimStream.pas',
  m3BaseStream in 'w:\common\components\rtl\Garant\m3\m3BaseStream.pas',
  m3Exceptions in 'w:\common\components\rtl\Garant\m3\m3Exceptions.pas',
  m3CustomStream in 'w:\common\components\rtl\Garant\m3\m3CustomStream.pas',
  m2S32Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S32Lib.pas',
  m2S64Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S64Lib.pas',
  m3BuffStream in 'w:\common\components\rtl\Garant\m3\m3BuffStream.pas',
  m3Persistent in 'w:\common\components\rtl\Garant\m3\m3Persistent.pas',
  l3ExceptionsLogEx in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLogEx.pas',
  l3Logger in 'w:\common\components\rtl\Garant\L3\l3Logger.pas',
  m3FileRegion in 'w:\common\components\rtl\Garant\m3\m3FileRegion.pas',
  m3RootStreamManagerPrimPrim in 'w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrimPrim.pas',
  m3StoreHeaderDataPrim in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderDataPrim.pas',
  m3RootStreamManagerPrim in 'w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrim.pas',
  m3TOCHandle in 'w:\common\components\rtl\Garant\m3\m3TOCHandle.pas',
  m3TOCHandleList in 'w:\common\components\rtl\Garant\m3\m3TOCHandleList.pas',
  m3Const in 'w:\common\components\rtl\Garant\m3\m3Const.pas',
  m3CommonStorageStream in 'w:\common\components\rtl\Garant\m3\m3CommonStorageStream.pas',
  m3CommonStorage in 'w:\common\components\rtl\Garant\m3\m3CommonStorage.pas',
  m3StorageHolder in 'w:\common\components\rtl\Garant\m3\m3StorageHolder.pas',
  m3StorageHolderListPrim in 'w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim.pas',
  m3StorageHolderListPrim1 in 'w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim1.pas',
  m3StorageHolderList in 'w:\common\components\rtl\Garant\m3\m3StorageHolderList.pas'
  {$If defined(AppClientSide)}
  ,
  archiHTInit in 'Main\archiHTInit.pas'
  {$IfEnd} //AppClientSide
  
  {$If not defined(Nemesis)}
  ,
  dt_Mail in 'w:\common\components\rtl\Garant\DT\dt_Mail.pas'
  {$IfEnd} //not Nemesis
  
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
  
  {$If not defined(NoImageEn)}
  ,
  imageenview in 'w:\common\components\rtl\external\ImageEn\src\imageenview.pas'
  {$IfEnd} //not NoImageEn
  
  {$If defined(AppClientSide)}
  ,
  F_ImageView in 'Frames\F_ImageView.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  CustEditWin in 'Main\CustEditWin.pas'
  {$IfEnd} //AppClientSide
  
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
  tfwArchiHyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArchiHyperlinkScriptCaller.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(AppClientSide)}
  ,
  arHyperLinkProcessor in 'Editor\arHyperLinkProcessor.pas'
  {$IfEnd} //AppClientSide
  
  {$If not defined(NoScripts)}
  ,
  TSpellCheckDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TSpellCheckDlgWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  D_spell in 'w:\archi\source\projects\Common\Dialogs\D_spell.pas'
  {$If defined(AppClientSide)}
  ,
  arEditorDebugInfo in 'Main\arEditorDebugInfo.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  Editwin in 'Main\Editwin.pas'
  {$IfEnd} //AppClientSide
  ,
  arConst in 'w:\archi\source\projects\Common\Utils\arConst.pas',
  evCommonTypes in 'w:\common\components\gui\Garant\EverestCommon\evCommonTypes.pas',
  arCommonTypes in 'w:\archi\source\projects\Common\Utils\arCommonTypes.pas',
  D_PicSizeEdit in 'w:\archi\source\projects\Common\Dialogs\D_PicSizeEdit.pas'
  {$If not defined(NoScripts)}
  ,
  TPicSizeEditDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TPicSizeEditDlgWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  evFacadeGUI in 'w:\common\components\gui\Garant\EverestCommon\evFacadeGUI.pas',
  evTableTools in 'w:\common\components\gui\Garant\Everest\evTableTools.pas',
  evOneCharLongIntList in 'w:\common\components\gui\Garant\Everest\evOneCharLongIntList.pas',
  edCellTypesList in 'w:\common\components\gui\Garant\Everest\edCellTypesList.pas',
  evCellsCharOffsets in 'w:\common\components\gui\Garant\Everest\evCellsCharOffsets.pas',
  evCellsOffsetsPair in 'w:\common\components\gui\Garant\Everest\evCellsOffsetsPair.pas',
  evCellsOffsetsPairList in 'w:\common\components\gui\Garant\Everest\evCellsOffsetsPairList.pas',
  evCellWidthCorrecterSpy in 'w:\common\components\gui\Garant\Everest\evCellWidthCorrecterSpy.pas',
  evCellsOffsetsList in 'w:\common\components\gui\Garant\Everest\evCellsOffsetsList.pas',
  evRowAndTableTypeSupport in 'w:\common\components\gui\Garant\Everest\evRowAndTableTypeSupport.pas',
  evCellsWidthCorrecter in 'w:\common\components\gui\Garant\Everest\evCellsWidthCorrecter.pas',
  evCopyTableCellWidth in 'w:\common\components\gui\Garant\Everest\evCopyTableCellWidth.pas',
  evTabStopsFilter in 'w:\common\components\gui\Garant\Everest\evTabStopsFilter.pas',
  evdEmptyRowFilter in 'w:\common\components\gui\Garant\Everest\evdEmptyRowFilter.pas',
  evTableFilter in 'w:\common\components\gui\Garant\Everest\evTableFilter.pas',
  evTextInTableCorrector in 'w:\common\components\gui\Garant\Everest\evTextInTableCorrector.pas',
  evMemo in 'w:\common\components\gui\Garant\Everest\evMemo.pas',
  evFacadeSelection in 'w:\common\components\gui\Garant\EverestCommon\evFacadeSelection.pas'
  {$If not defined(Nemesis)}
  ,
  vtDialogs in 'w:\common\components\gui\Garant\VT\vtDialogs.pas'
  {$IfEnd} //not Nemesis
  ,
  evCommonRes in 'w:\archi\source\projects\Common\Utils\evCommonRes.pas',
  evStubs in 'w:\common\components\gui\Garant\EverestCommon\evStubs.pas',
  evFacadeSub in 'w:\common\components\gui\Garant\EverestCommon\evFacadeSub.pas',
  d_edMSub in 'w:\archi\source\projects\Common\Dialogs\d_edMSub.pas'
  {$If not defined(NoScripts)}
  ,
  TNewSubDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TNewSubDlgWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  arTextUtils in 'w:\archi\source\projects\Common\Utils\arTextUtils.pas',
  l3SimpleCalc in 'w:\common\components\rtl\Garant\L3\ext\l3SimpleCalc.pas'
  {$If defined(Archi) AND not defined(Nemesis)}
  ,
  dt_LinkServ in 'w:\common\components\rtl\Garant\DT\dt_LinkServ.pas'
  {$IfEnd} //Archi AND not Nemesis
  ,
  evCommonUtils in 'w:\archi\source\projects\Common\Utils\evCommonUtils.pas',
  ExprEditForm in 'w:\archi\source\projects\Common\Dialogs\ExprEditForm.pas'
  {$If not defined(NoScripts)}
  ,
  TExprEditorWordsPack in 'w:\archi\source\projects\Common\Dialogs\TExprEditorWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  ddTableConvTypes in 'w:\common\components\rtl\Garant\dd\ddTableConvTypes.pas',
  evdAllParaEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllParaEliminator.pas',
  ddDocument in 'w:\common\components\rtl\Garant\dd\ddDocument.pas',
  rtfListTable in 'w:\common\components\rtl\Garant\dd\rtfListTable.pas',
  RTFtypes in 'w:\common\components\rtl\Garant\dd\RTFtypes.pas',
  ddRTFProperties in 'w:\common\components\rtl\Garant\dd\ddRTFProperties.pas',
  ddTypes in 'w:\common\components\rtl\Garant\dd\ddTypes.pas',
  ddCustomDestination in 'w:\common\components\rtl\Garant\dd\ddCustomDestination.pas',
  ddDocumentAtom in 'w:\common\components\rtl\Garant\dd\ddDocumentAtom.pas',
  ddPropertyObject in 'w:\common\components\rtl\Garant\dd\ddPropertyObject.pas',
  ddEVDTypesSupport in 'w:\common\components\rtl\Garant\dd\ddEVDTypesSupport.pas',
  ddBaseObject in 'w:\common\components\rtl\Garant\dd\ddBaseObject.pas',
  ddBorderPart in 'w:\common\components\rtl\Garant\dd\ddBorderPart.pas',
  ddBorder in 'w:\common\components\rtl\Garant\dd\ddBorder.pas',
  ddBase in 'w:\common\components\rtl\Garant\dd\ddBase.pas',
  ddCellProperty in 'w:\common\components\rtl\Garant\dd\ddCellProperty.pas',
  ddDocumentAtomList in 'w:\common\components\rtl\Garant\dd\ddDocumentAtomList.pas',
  ddCharacterProperty in 'w:\common\components\rtl\Garant\dd\ddCharacterProperty.pas',
  ddHyperlinkTarget in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTarget.pas',
  ddHyperlinkTargetList in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTargetList.pas',
  ddTextSegment in 'w:\common\components\rtl\Garant\dd\ddTextSegment.pas',
  ddParagraphProperty in 'w:\common\components\rtl\Garant\dd\ddParagraphProperty.pas',
  ddTextSegmentsList in 'w:\common\components\rtl\Garant\dd\ddTextSegmentsList.pas',
  ddSub in 'w:\common\components\rtl\Garant\dd\ddSub.pas',
  ddSubsList in 'w:\common\components\rtl\Garant\dd\ddSubsList.pas',
  ddTextParaString in 'w:\common\components\rtl\Garant\dd\ddTextParaString.pas',
  ddTextParagraph in 'w:\common\components\rtl\Garant\dd\ddTextParagraph.pas',
  ddCellList in 'w:\common\components\rtl\Garant\dd\ddCellList.pas',
  ddCellsPropertyList in 'w:\common\components\rtl\Garant\dd\ddCellsPropertyList.pas',
  ddRowProperty in 'w:\common\components\rtl\Garant\dd\ddRowProperty.pas',
  ddTableRow in 'w:\common\components\rtl\Garant\dd\ddTableRow.pas',
  ddTableCell in 'w:\common\components\rtl\Garant\dd\ddTableCell.pas',
  ddRowList in 'w:\common\components\rtl\Garant\dd\ddRowList.pas',
  ddRTFUnits in 'w:\common\components\rtl\Garant\dd\ddRTFUnits.pas',
  l3CharSkipper in 'w:\common\components\rtl\Garant\L3\l3CharSkipper.pas',
  ddHexCharReader in 'w:\common\components\rtl\Garant\dd\ddHexCharReader.pas',
  ddPicture in 'w:\common\components\rtl\Garant\dd\ddPicture.pas',
  ddTablePrim in 'w:\common\components\rtl\Garant\dd\ddTablePrim.pas',
  ddTable in 'w:\common\components\rtl\Garant\dd\ddTable.pas',
  ddVirtualTable in 'w:\common\components\rtl\Garant\dd\ddVirtualTable.pas',
  ddTextToTableConverters in 'w:\common\components\rtl\Garant\dd\ddTextToTableConverters.pas',
  D_Base in 'w:\archi\source\projects\Common\Meta\D_Base.pas'
  {$If not defined(NoScripts)}
  ,
  TTableConvParamDialogWordsPack in 'w:\archi\source\projects\Common\Dialogs\TTableConvParamDialogWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  ddTableConvParamDlg in 'w:\archi\source\projects\Common\Dialogs\ddTableConvParamDlg.pas',
  evTableConverter in 'w:\archi\source\projects\Common\Utils\evTableConverter.pas'
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  archiDocEditorWindowWordsPack in 'Archi_Insider_Test_Support\archiDocEditorWindowWordsPack.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arArchiTestsAdapter in 'Archi_Insider_Test_Support\arArchiTestsAdapter.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arEditorControl in 'Archi_Insider_Test_Support\arEditorControl.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwClickOnCommentHeader in 'Archi_Insider_Test_Support\kwClickOnCommentHeader.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEditorDblClickOnSub in 'Archi_Insider_Test_Support\kwEditorDblClickOnSub.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwDeleteSub in 'Archi_Insider_Test_Support\kwDeleteSub.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwDocEditorSetModified in 'Archi_Insider_Test_Support\kwDocEditorSetModified.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwAddBlock in 'Archi_Insider_Test_Support\kwAddBlock.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEditorSetTOC in 'Archi_Insider_Test_Support\kwEditorSetTOC.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwGotoSub in 'Archi_Insider_Test_Support\kwGotoSub.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  DragData in 'w:\common\components\gui\Garant\VT\DragData.pas'
  {$If not defined(NoScripts)}
  ,
  kwVTControlsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwVTControlsPack.pas'
  {$IfEnd} //not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arArchiTestAdapter2 in 'Archi_Insider_Test_Support\arArchiTestAdapter2.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEndAddSubByMouse in 'Archi_Insider_Test_Support\kwEndAddSubByMouse.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwSetExpiredStyle in 'Archi_Insider_Test_Support\kwSetExpiredStyle.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arEditorUtils in 'Archi_Insider_Test_Support\arEditorUtils.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwOpenInsDWin in 'Archi_Insider_Test_Support\kwOpenInsDWin.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwMakeChangeDoc in 'Archi_Insider_Test_Support\kwMakeChangeDoc.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwInsertDocChanges in 'Archi_Insider_Test_Support\kwInsertDocChanges.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwIniRecSetZoom in 'Archi_Insider_Test_Support\kwIniRecSetZoom.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwIniRecGetZoom in 'Archi_Insider_Test_Support\kwIniRecGetZoom.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arDialogsPack in 'Archi_Insider_Test_Support\arDialogsPack.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwCreateNewFile in 'Archi_Insider_Test_Support\kwCreateNewFile.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiNewDocument in 'Archi_Insider_Test_Support\kwArchiNewDocument.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  arDBUtils in 'w:\archi\source\projects\Common\Utils\arDBUtils.pas',
  JclMiscel {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\source\windows\JclMiscel.pas' {$EndIf},
  ddZipUtils in 'w:\common\components\rtl\Garant\dd\ddZipUtils.pas'
  {$If not defined(Nemesis)}
  ,
  dt_Jour in 'w:\common\components\rtl\Garant\DT\dt_Jour.pas'
  {$IfEnd} //not Nemesis
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwClearDataBase in 'Archi_Insider_Test_Support\kwClearDataBase.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiCloseDocument in 'Archi_Insider_Test_Support\kwArchiCloseDocument.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiOpenDocument in 'Archi_Insider_Test_Support\kwArchiOpenDocument.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiNewDocumentPrim in 'Archi_Insider_Test_Support\kwArchiNewDocumentPrim.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwGetActiveEditorPageName in 'Archi_Insider_Test_Support\kwGetActiveEditorPageName.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiNewEmptyDocument in 'Archi_Insider_Test_Support\kwArchiNewEmptyDocument.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwSetActivePage in 'Archi_Insider_Test_Support\kwSetActivePage.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwShowMailMessage in 'Archi_Insider_Test_Support\kwShowMailMessage.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  CommonArchiWords in 'Archi_Insider_Test_Support\CommonArchiWords.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  kwDocumentSpravka in 'Archi_Script_Engine\kwDocumentSpravka.pas'
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorEditFormula in 'Archi_Insider_Test_Support\kwPopEditorEditFormula.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorAlignCellsBoundary in 'Archi_Insider_Test_Support\kwPopEditorAlignCellsBoundary.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorSetStyle2Block in 'Archi_Insider_Test_Support\kwPopEditorSetStyle2Block.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorInsertFormula in 'Archi_Insider_Test_Support\kwPopEditorInsertFormula.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPushMainForm in 'Archi_Insider_Test_Support\kwPushMainForm.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPopEditorSetStyle2Table in 'Archi_Insider_Test_Support\kwPopEditorSetStyle2Table.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEditorKeyWordsPack in 'Archi_Insider_Test_Support\kwEditorKeyWordsPack.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwMainFormFindDocuments in 'Archi_Insider_Test_Support\kwMainFormFindDocuments.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  ,
  SewerPipe in 'w:\common\components\rtl\Garant\dd\PipeOut\SewerPipe.pas',
  dt_AttrSchema in 'w:\common\components\rtl\Garant\dd\dt_AttrSchema.pas'
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwBaseExport in 'Archi_Insider_Test_Support\kwBaseExport.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwBaseRelCorrecter in 'Archi_Insider_Test_Support\kwBaseRelCorrecter.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwPreview in 'Archi_Insider_Test_Support\kwPreview.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwSearchWinSaveDocumentList in 'Archi_Insider_Test_Support\kwSearchWinSaveDocumentList.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwMainFormClearHistory in 'Archi_Insider_Test_Support\kwMainFormClearHistory.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEditorTextSaveAs in 'Archi_Insider_Test_Support\kwEditorTextSaveAs.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwClearTemplateStorage in 'Archi_Insider_Test_Support\kwClearTemplateStorage.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwMainFormFormClose in 'Archi_Insider_Test_Support\kwMainFormFormClose.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwDialogsLockDocumentGetSkipMode in 'Archi_Insider_Test_Support\kwDialogsLockDocumentGetSkipMode.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwDialogsLockDocumentSetSkipMode in 'Archi_Insider_Test_Support\kwDialogsLockDocumentSetSkipMode.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  AttributeExplorerWordsPack in 'Archi_Insider_Test_Support\AttributeExplorerWordsPack.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide)}
  ,
  F_AttrExplorer in 'Frames\F_AttrExplorer.pas'
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwCommonArchiWords in 'Archi_Insider_Test_Support\kwCommonArchiWords.pas'
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  ,
  ArchiScriptEngine in 'Archi_Script_Engine\ArchiScriptEngine.pas',
  l3CustomSortIntegerList in 'w:\common\components\rtl\Garant\L3\l3CustomSortIntegerList.pas',
  l3CustomOtherListView in 'w:\common\components\rtl\Garant\L3\l3CustomOtherListView.pas',
  l3CustomLongintListView in 'w:\common\components\rtl\Garant\L3\l3CustomLongintListView.pas',
  l3LongintListReverseSorter in 'w:\common\components\rtl\Garant\L3\l3LongintListReverseSorter.pas',
  l3ProtoPtrRecListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas',
  l3CustomRecListView in 'w:\common\components\rtl\Garant\L3\l3CustomRecListView.pas',
  l3EventedRecListView in 'w:\common\components\rtl\Garant\L3\l3EventedRecListView.pas',
  k2CustomTagView in 'w:\common\components\rtl\Garant\K2\k2CustomTagView.pas',
  k2TagByHandleView in 'w:\common\components\rtl\Garant\K2\k2TagByHandleView.pas'
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas'
  {$IfEnd} //nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiAutoTest in 'Archi_Insider_Test_Support\ArchiAutoTest.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwDisableMergedCellFilter in 'Archi_Insider_Test_Support\kwDisableMergedCellFilter.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TTextSearchDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TTextSearchDlgWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  D_TxSrch in 'w:\archi\source\projects\Common\Dialogs\D_TxSrch.pas'
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwClearFindDialog in 'Archi_Insider_Test_Support\kwClearFindDialog.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(k2ForEditor)}
  ,
  evAutoComplete in 'w:\common\components\gui\Garant\Everest\evAutoComplete.pas'
  {$IfEnd} //k2ForEditor
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwAutoCompleteClear in 'Archi_Insider_Test_Support\kwAutoCompleteClear.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwArchiEverestWordsPack in 'Archi_Insider_Test_Support\kwArchiEverestWordsPack.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If not defined(NoVCL)}
  ,
  l3HugeMessageDlgWithWikiHelper in 'w:\common\components\rtl\Garant\L3\l3HugeMessageDlgWithWikiHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3IterateComponentParents in 'w:\common\components\rtl\Garant\L3\l3IterateComponentParents.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3FormatActionInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatActionInfoHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3GetComponentFromPointHelper in 'w:\common\components\rtl\Garant\L3\l3GetComponentFromPointHelper.pas'
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3FormatObjectInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatObjectInfoHelper.pas'
  {$IfEnd} //not NoVCL
  ,
  l3ComponentInfoHelper in 'w:\common\components\rtl\Garant\L3\l3ComponentInfoHelper.pas'
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiAutoTestSuite in 'Archi_Insider_Test_Support\ArchiAutoTestSuite.pas'
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  toKT in 'toKT.pas',
  ArchiTestRes in 'ArchiTestRes.pas'
//#UC START# *4DE4A1D0031Emanualuses*

  ,
  ddKTExtractor,
  evdSchema,
  PrevInst,
  evExtActions,
  evExtActionsRes,
  D_TxSrch_Res,
  d_GetNewDocParam in 'DLG\d_GetNewDocParam.pas' {NewDocParam},
  D_dsprm in 'DLG\D_DSPRM.PAS' {DocSetParamDlg},
  D_pass in 'DLG\D_PASS.PAS' {1_PasswordDlg _V},
  Logo in 'DLG\LOGO.PAS' {1_LOGODlg},
  Progress in 'DLG\PROGRESS.PAS' {1_ProgressDlg},
  Srchwin in 'SRCHWIN.PAS' {20.SearchWin},
  D_getnum in 'DLG\D_GETNUM.PAS' {21.GetNumberDlg _V},
  D_srch in 'DLG\D_SRCH.PAS' {21.DocSearchDlg _V},
  D_schres in 'DLG\D_SCHRES.PAS' {21.SearchResultDlg _V},
  D_export in 'DLG\D_EXPORT.PAS' {ExportDlg},
  D_CorrectExportFolder in 'Dlg\D_CorrectExportFolder.pas' {TCorrectExportFolder},
  D_ShowInfo in 'DLG\D_ShowInfo.pas' {D_ShowInfo},
  DictEntryWin in 'DictEntryWin.pas' {DictEntryWindow},
  D_Style,
  D_cref in 'DLG\D_CREF.PAS' {4_ChoiceRefDlg},
  Showmes in 'DLG\SHOWMES.PAS' {4_ShowLongMessageDlg _V},
  Objexwin in 'OBJEXWIN.PAS' {5.ObjectExplorerWin},
  MailWin in 'MAILWIN.PAS' {5_SendMailWin},
  TreeDWin in 'DLG\TREEDWIN.PAS' {9.TreeDesignerForm},
  DSHOWEQI in 'DLG\DSHOWEQI.pas' {DShowEq},
  D_DictItemEdit in 'DLG\D_DictItemEdit.pas' {DictItemEditDlg},
  D_NameSrcEd in 'D_NameSrcEd.pas' {NameEditSrcDlg},
  D_getds in 'DLG\D_GETDS.PAS' {GetDocSetDlg _V},
  Dsubview in 'DLG\DSUBVIEW.PAS' {ViewSubDlg},
  D_stat in 'DLG\D_STAT.PAS' {StatisticDlg _V},
  D_getabo in 'DLG\D_GETABO.PAS' {GetAbolishDataDlg},
  D_RepCon in 'DLG\D_REPCON.PAS' {ReplaceConfirmDlg _V},
  D_datein in 'DLG\D_DATEIN.PAS' {FindByJournalDlg _V},
  D_dtfilt in 'DLG\D_DTFILT.PAS' {DocTypeFilterDlg},
  D_hnddoc in 'DLG\D_HNDDOC.PAS' {!!!HandlingDocDlg _V},
  D_config in 'DLG\D_CONFIG.PAS' {ConfigDlg},
  D_repask in 'DLG\D_REPASK.PAS' {SaveTroubleDlg _V},
  BtnDlg in 'MetaForms\BtnDlg.pas' {BtnDlg},
  RBtnDlg in 'MetaForms\RBtnDlg.pas' {RBtnDlg},
  BottomBtnDlg in 'MetaForms\BottomBtnDlg.pas' {BottomBtnDlg},
  RightBtnDlg in 'MetaForms\RightBtnDlg.pas' {RightBtnDlg},
  TabRBtnDlg in 'MetaForms\TabRBtnDlg.pas' {TabRBtnDlg},
  TabBBtnDlg in 'MetaForms\TabBBtnDlg.pas' {TabBBtnDlg},
  D_SrcChk in 'DLG\D_SrcChk.pas' {SrcCheckDlg},
  D_PaperWhere in 'DLG\D_PaperWhere.pas' {PaperWhereDlg},
  D_DateNumberEditor in 'DLG\D_DateNumberEditor.pas' {DateNumEditorDlg},
  D_StrEdit in 'DLG\common\d_StrEdit.pas' {StringEditDlg},
  D_DeltaKWFileEdit in 'Dlg\d_DeltaKWFileEdit.pas' {DeltaKWFileEditDlg},
  D_DirEdit in 'DLG\common\d_DirEdit.pas' {DirEditDlg},
  D_DateIntervalEdit in 'DLG\common\d_DateIntervalEdit.pas' {DateIntervalDlg},
  ClosingWin in 'ClosingWin.pas' {ClosingForm},
  D_DocByStageInfo in 'DLG\D_DocByStageInfo.pas' {DocByStageInfoDlg},
  D_SrchByAction in 'DLG\d_SrchByAction.pas' {SrchByActionDlg},
  D_ExtNameEd in 'DLG\D_ExtNameEd.pas' {ExtNameEditDlg},
  D_NewClassNameEd in 'DLG\D_NewClassNameEd.pas' {NewClassNameEditDlg},
  D_DictItemRequest in 'DLG\d_DictItemRequest.pas' {DictItemRequest},
  LinkHistoWin in 'LinkHistoWin.pas' {LinkHistoForm},
  D_DocAddr in 'DLG\D_DocAddr.pas' {DocAddrDlg},
  D_AttrActiveInterval in 'DLG\D_AttrActiveInterval.pas' {AttrActiveIntervalDlg},
  D_AttrAlarm in 'DLG\D_AttrAlarm.pas' {AttrAlarmDlg},
  D_AttrCopyEdit in 'DLG\D_AttrCopyEdit.pas' {AttrCopyEdit},
  D_OldEdition in 'DLG\d_OldEdition.pas' {OldEditionDlg},
  D_WizIzm in 'DLG\D_WizIzm.pas' {IzmWizardDlg},
  ResShop in 'CM\ResShop.pas' {ArchiResources: TDataModule},
  F_TextEditor in 'Frames\F_TextEditor.pas' {TextEditorWin: TvtFrame},
  F_DocList in 'Frames\F_DocList.pas' {DocumentList: TvtFrame},
  d_AddrEdit in 'DLG\common\d_AddrEdit.pas' {TAddressEditDlg},
  d_ReplCorresp in 'DLG\d_ReplCorresp.pas' {TReplaceCorrespDlg},
  d_ExternalObject in 'DLG\d_ExternalObject.pas' {ExternalObjectDlg},
  D_MacroSubNameProp in 'DLG\D_MacroSubNameProp.pas' {GetSubNamePropDlg},
  d_GetJurOp in 'DLG\d_GetJurOp.pas' {TGetJurOpDlg},
  D_DateCalc in 'DLG\D_DateCalc.PAS' {DateCalcDlg},
  d_DenyList in 'DLG\d_DenyList.pas' {AccessErrorWin},
  arAttrNodes in 'arAttrNodes.pas',
  D_TextMessages in 'Dlg\D_TextMessages.pas' {dlgTextMessages},
  d_BatchDelAttr in 'Dlg\d_BatchDelAttr.pas' {BatchAttrDelDlg},
  d_SearchSettings in 'Dlg\d_SearchSettings.pas' {SearchSettingsDlg},
  F_DictItemEdit in 'DLG\frames\F_DictItemEdit.pas' {DictItemEditFrame: TFrame},
  d_HyperlinkAddrChange in 'Dlg\d_HyperlinkAddrChange.pas' {ChangeHLAddrDlg},
  DeferDeleletedItemsWin in 'DeferDeleletedItemsWin.pas' {DeferDelItemsWin},
  arDocObject in 'arDocObject.pas',
  F_MiscDocImgView in 'Frames\F_MiscDocImgView.pas' {frmMiscDocImgView: TFrame},
  D_Doc2DocLinkEdit in 'Dlg\D_Doc2DocLinkEdit.pas' {Doc2DocLinkEditDlg},
  d_SrchByDocLink in 'Dlg\d_SrchByDocLink.pas' {SearchByDocLinkDlg},
  arDeliveryList in 'arDeliveryList.pas',
  arResultDeliverer in 'Processing\arResultDeliverer.pas',
  arOneTaskDeliverer in 'Processing\arOneTaskDeliverer.pas',
  arResultDeliveryInterfaces in 'Processing\arResultDeliveryInterfaces.pas',
  m4WordIDStr,
  m4WordIDStrListPrim,
  m4WordIDStrList,
  m4Word,
  m4WordList

//#UC END# *4DE4A1D0031Emanualuses*
  ;
{$IfEnd} //InsiderTest AND nsTest

{$R ArchiTest.res}

//#UC START# *4DE4A1D0031Emanualres*
{$R versioninfo.res} // включаем Version Info
//#UC END# *4DE4A1D0031Emanualres*

begin
 {$IfDef nsTest}
 g_CVSPath := 'w:\archi\source\projects\Archi';
 {$EndIf nsTest}
 //#UC START# *4DE4A1D0031ECVSPath*
 //#UC END# *4DE4A1D0031ECVSPath*
 //#UC START# *4DE4A1D0031Emanualcode*
 Application.Title := 'АРХИВАРИУС';

 if (Win32Platform <> VER_PLATFORM_WIN32_NT) or
    (Win32MajorVersion < 5) then
 begin
  ShowMessage('Для работы программы небходима OS Windows 2000 или выше!');
  Exit;
 end;//Win32Platform <> VER_PLATFORM_WIN32_NT

 {.$IfNDef DebugRelease}
 if not GoToPrevinst then
 {.$EndIf}
 try
  Application.CreateForm(TArchiResources, ArchiResources);
  GlobalInit;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  //--- Инициализация тестов ----
  //g_CVSPath := 'w:\archi\source\projects\Archi\';
  TArchiAutoTestSuite.Register;
  TArchiTestRes.ReadyToRun;
  // ------
  Application.Run;
 except
  on E : EAbort do;
  on E : Exception do Application.ShowException(E);
 end;//try..except
 //#UC END# *4DE4A1D0031Emanualcode*
end.