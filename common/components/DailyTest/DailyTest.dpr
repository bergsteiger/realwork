program DailyTest;
 {* Ежедневные тесты нашей библиотеки компонент }

// Модуль: "w:\common\components\DailyTest\DailyTest.dpr"
// Стереотип: "TestTarget"
// Элемент модели: "Daily" MUID: (4B2A48AA03D4)

{$Include w:\common\components\DailyTest\DailyTest.inc}

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ImplUses
 , l3ExceptionsLog in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLog.pas'
 , ObjectFromstackWords in 'w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas'
 , tfwClassLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassLike.pas'
 , tfwRegisterableWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas'
 , tfwRegisterableWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWordPrim.pas'
 , tfwScriptingInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingInterfaces.pas'
 , l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas'
 , ActiveX {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas' {$EndIf}
 , Windows {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas' {$EndIf}
 , Types
 , l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas'
 , Messages {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas' {$EndIf}
 , Graphics {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas' {$EndIf}
 , Classes {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas' {$EndIf}
 , SysUtils
 , TtfwTypeRegistrator_Proxy in 'w:\common\components\rtl\Garant\ScriptEngine\TtfwTypeRegistrator_Proxy.pas'
 , ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
 , TypInfo {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas' {$EndIf}
 , tfwPropertyLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwPropertyLike.pas'
 , tfwTypeInfo in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfo.pas'
 , tfwScriptingExceptions in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas'
 , TtfwClassRef_Proxy in 'w:\common\components\rtl\Garant\ScriptEngine\TtfwClassRef_Proxy.pas'
 , TypeInfoPack in 'w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas'
 , tfwGlobalKeyWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwGlobalKeyWord.pas'
 , tfwScriptingTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingTypes.pas'
 , tfwValueTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypes.pas'
 , tfwTypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas'
 , tfwTypeInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoListPrim.pas'
 , l3ProtoDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas'
 , l3ProtoObject in 'w:\common\components\rtl\Garant\L3\l3ProtoObject.pas'
 , l3CastableObject in 'w:\common\components\rtl\Garant\L3\l3CastableObject.pas'
 , l3PureMixIns in 'w:\common\components\rtl\Garant\L3\l3PureMixIns.pas'
 , l3Base in 'w:\common\components\rtl\Garant\L3\l3Base.pas'
 , l3_Base in 'w:\common\components\rtl\Garant\L3\l3_Base.pas'
 , l3SimpleObject in 'w:\common\components\rtl\Garant\L3\l3SimpleObject.pas'
 , l3ProtoObjectWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas'
 , l3IID in 'w:\common\components\rtl\Garant\L3\l3IID.pas'
 , l3InterfacesMisc in 'w:\common\components\rtl\Garant\L3\l3InterfacesMisc.pas'
 , l3ObjectRefList1 in 'w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas'
 , l3Memory in 'w:\common\components\rtl\Garant\L3\l3Memory.pas'
 , l3BaseStream in 'w:\common\components\rtl\Garant\L3\l3BaseStream.pas'
 , l3InternalInterfaces in 'w:\common\components\rtl\Garant\L3\l3InternalInterfaces.pas'
 , l3Types in 'w:\common\components\rtl\Garant\L3\l3Types.pas'
 , l3Units in 'w:\common\components\rtl\Garant\L3\l3Units.pas'
 , l3PrinterInterfaces in 'w:\common\components\rtl\Garant\L3\l3PrinterInterfaces.pas'
 , l3MemUtils in 'w:\common\components\rtl\Garant\L3\l3MemUtils.pas'
 , Refcounted in 'w:\common\components\rtl\Garant\L3\Refcounted.pas'
 , l3MemorySizeUtils in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtils.pas'
 , l3MemorySizeUtilsPrim in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtilsPrim.pas'
 , l3Interlocked in 'w:\common\components\rtl\Garant\L3\l3Interlocked.pas'
 , l3ProtoDataContainerWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainerWithCOMQI.pas'
 , l3Except in 'w:\common\components\rtl\Garant\L3\l3Except.pas'
 , l3MinMax in 'w:\common\components\rtl\Garant\L3\l3MinMax.pas'
 , RTLConsts {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\RTLConsts.pas' {$EndIf}
 , l3_String in 'w:\common\components\rtl\Garant\L3\l3_String.pas'
 , l3CustomString in 'w:\common\components\rtl\Garant\L3\l3CustomString.pas'
 , l3Variant in 'w:\common\components\rtl\Garant\L3\l3Variant.pas'
 , l3Variants in 'w:\common\components\rtl\Garant\L3\l3Variants.pas'
 , l3DataContainerWithoutIUnknownPrim in 'w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknownPrim.pas'
 , l3CastablePersistent in 'w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas'
 , l3Const in 'w:\common\components\rtl\Garant\L3\l3Const.pas'
 , k2BaseTypes in 'w:\common\components\rtl\Garant\L3\k2BaseTypes.pas'
 , l3String in 'w:\common\components\rtl\Garant\L3\l3String.pas'
 , l3Chars in 'w:\common\components\rtl\Garant\L3\l3Chars.pas'
 , l3Date in 'w:\common\components\rtl\Garant\L3\l3Date.pas'
 , l3BMSearch in 'w:\common\components\rtl\Garant\L3\l3BMSearch.pas'
 , l3StringEx in 'w:\common\components\rtl\Garant\L3\l3StringEx.pas'
 , l3StringAdapter in 'w:\common\components\rtl\Garant\L3\l3StringAdapter.pas'
 , l3CProtoObject in 'w:\common\components\rtl\Garant\L3\l3CProtoObject.pas'
 , l3ObjectsMemoryManager in 'w:\common\components\rtl\Garant\L3\l3ObjectsMemoryManager.pas'
 , l3SimpleMemoryManager in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManager.pas'
 , l3SimpleMemoryManagerPrim in 'w:\common\components\rtl\Garant\L3\l3SimpleMemoryManagerPrim.pas'
 , SyncObjs {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\SyncObjs.pas' {$EndIf}
 , l3TwoByteCString in 'w:\common\components\rtl\Garant\L3\l3TwoByteCString.pas'
 , tfwIl3CStringPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas'
 , tfwIteratableParent in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas'
 , tfwIteratableParentPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParentPrim.pas'
 , tfwSafeArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSafeArrayView.pas'
 , tfwArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArrayView.pas'
 , tfwArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArray.pas'
 , tfwValueList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueList.pas'
 , tfwStoredValuesStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas'
 , tfwDictionaryPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrim.pas'
 , tfwDictionaryPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas'
 , tfwDictionaryPrimPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrimPrim.pas'
 , tfwStoredValues in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas'
 , kwCompiledVar in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.pas'
 , kwCompiledWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrim.pas'
 , kwCompiledWordPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrimPrim.pas'
 , kwSourcePointWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSourcePointWord.pas'
 , tfwKeyWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeyWordPrim.pas'
 , tfwWordRefList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas'
 , tfwThreadVar in 'w:\common\components\rtl\Garant\ScriptEngine\tfwThreadVar.pas'
 , tfwThreadVarPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwThreadVarPrim.pas'
 , tfwWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorkerEx.pas'
 , tfwWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorker.pas'
 , tfwAnonimousWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAnonimousWord.pas'
 , tfwCompilingWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompilingWord.pas'
 , l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas'
 , l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas'
 , kwCompiledWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWord.pas'
 , kwRuntimeWordWithCodeExecution in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCodeExecution.pas'
 , kwRuntimeWordWithCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCode.pas'
 , kwForwardDeclarationHolder in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclarationHolder.pas'
 , tfwDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionary.pas'
 , Math {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas' {$EndIf}
 , tfwDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryWordsPack.pas'
 , tfwMembersIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIterator.pas'
 , tfwMembersIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIteratorPrim.pas'
 , tfwScriptEngineExInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineExInterfaces.pas'
 , tfwDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.pas'
 , tfwDictionaryEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryEx.pas'
 , tfwDictionaryExPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExPrim.pas'
 , tfwDictionaryPtrList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrList.pas'
 , tfwStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStreamFactory.pas'
 , tfwInitCodeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitCodeWord.pas'
 , tfwAutoregisteredDiction in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAutoregisteredDiction.pas'
 , tfwStandardDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionary.pas'
 , tfwStandardDictionaries in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaries.pas'
 , tfwStandardDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryList.pas'
 , tfwStandardDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListPrim.pas'
 , tfwCStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringFactory.pas'
 , tfwCStringList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringList.pas'
 , tfwCStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringListPrim.pas'
 , tfwCStringArraySing in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas'
 , tfwCStringArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas'
 , tfwCStringArraySing2 in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas'
 , tfwInitedDictionariesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesList.pas'
 , tfwDictionaryExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExWordsPack.pas'
 , tfwAxiomaticsResNameGetter in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetter.pas'
 , tfwAxiomaticsResNameGetters in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas'
 , tfwAxiomaticsResNameGetterList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetterList.pas'
 , tfwDictionaryDataIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryDataIteratorPrim.pas'
 , tfwExportedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwExportedDictionariesIterator.pas'
 , tfwDictionaryPtrListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrListIterator.pas'
 , tfwUsedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwUsedDictionariesIterator.pas'
 , l3DateSt in 'w:\common\components\rtl\Garant\L3\l3DateSt.pas'
 {$If Defined(seCacheDict)}
 , tfwMainDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryCache.pas'
 {$IfEnd} // Defined(seCacheDict)
 , tfwMainDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryList.pas'
 , tfwMainDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionary.pas'
 , tfwMainDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryWordsPack.pas'
 {$If Defined(seCacheDict)}
 , tfwDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCache.pas'
 {$IfEnd} // Defined(seCacheDict)
 , tfwDictionaryCachePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCachePrim.pas'
 , tfwKeywordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeywordsIterator.pas'
 , kwLeftParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwLeftParam.pas'
 , kwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\kwInteger.pas'
 , kwString in 'w:\common\components\rtl\Garant\ScriptEngine\kwString.pas'
 , l3ParserInterfaces in 'w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas'
 , kwIntegerFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerFactory.pas'
 , kwIntegerArray in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerArray.pas'
 , kwIntegerList in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerList.pas'
 , kwStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringFactory.pas'
 , kwStringList in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringList.pas'
 , kwStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringListPrim.pas'
 , StrUtils {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas' {$EndIf}
 , kwCompiledWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas'
 , kwTemporaryCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTemporaryCompiledCode.pas'
 , kwCompiledWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerEx.pas'
 , m2HasLib in 'w:\common\components\rtl\Garant\L3\m2\m2HasLib.pas'
 , tfwHash16Table in 'w:\common\components\rtl\Garant\ScriptEngine\tfwHash16Table.pas'
 , l3OneByteCString in 'w:\common\components\rtl\Garant\L3\l3OneByteCString.pas'
 , l3CEmptyStringPrim in 'w:\common\components\rtl\Garant\L3\l3CEmptyStringPrim.pas'
 , l3CEmptyString in 'w:\common\components\rtl\Garant\L3\l3CEmptyString.pas'
 , l3FourByteCString in 'w:\common\components\rtl\Garant\L3\l3FourByteCString.pas'
 , tfwValueTypesCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesCache.pas'
 , tfwValueTypesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesList.pas'
 , tfwValueTypesListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesListPrim.pas'
 , tfwValueTypesWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesWordsPack.pas'
 , tfwStandardDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListIterator.pas'
 , tfwInitedDictionariesListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesListIterator.pas'
 , tfwDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.pas'
 , tfwWordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordsIterator.pas'
 , VarWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VarWorkingPack.pas'
 , tfwConst in 'w:\common\components\rtl\Garant\ScriptEngine\tfwConst.pas'
 , tfwConstLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwConstLike.pas'
 , tfwNewWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwNewWord.pas'
 , kwForwardDeclaration in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclaration.pas'
 , tfwClassRef in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassRef.pas'
 , tfwTypeModifier in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeModifier.pas'
 , kwModifier in 'w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas'
 , tfwRTTIProperty in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTIProperty.pas'
 , tfwEnumRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumRegistrator.pas'
 , tfwEnumConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumConstantRegistrator.pas'
 , tfwIntegerConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerConstantRegistrator.pas'
 , tfwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInteger.pas'
 , tfwRegisteredEnums in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisteredEnums.pas'
 , tfwRTTITypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTITypeInfoList.pas'
 , tfwIntegerToEnumName in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerToEnumName.pas'
 , tfwStringToEnumValue in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringToEnumValue.pas'
 , tfwTypeRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeRegistrator.pas'
 , tfwInterfaceRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInterfaceRegistrator.pas'
 , tfwStringConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringConstantRegistrator.pas'
 , tfwString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwString.pas'
 , kwConstLikeCompiled in 'w:\common\components\rtl\Garant\ScriptEngine\kwConstLikeCompiled.pas'
 , l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas'
 , l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas'
 , tfwParserInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas'
 , tfwWordInfoWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoWordsPack.pas'
 , tfwParserService in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserService.pas'
 , l3StringList in 'w:\common\components\rtl\Garant\L3\l3StringList.pas'
 , l3StringList2 in 'w:\common\components\rtl\Garant\L3\l3StringList2.pas'
 , l3StringList1 in 'w:\common\components\rtl\Garant\L3\l3StringList1.pas'
 , l3StringListPrim in 'w:\common\components\rtl\Garant\L3\l3StringListPrim.pas'
 , l3ProtoPersistentDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas'
 , l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas'
 , l3ProgressComponent in 'w:\common\components\rtl\Garant\L3\l3ProgressComponent.pas'
 , l3InterfacedComponent in 'w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas'
 , l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas'
 , l3StringIDEx in 'w:\common\components\rtl\Garant\L3\l3StringIDEx.pas'
 , l3ConstStrings in 'w:\common\components\rtl\Garant\L3\l3ConstStrings.pas'
 , l3ConstStrings1 in 'w:\common\components\rtl\Garant\L3\l3ConstStrings1.pas'
 , l3Stream in 'w:\common\components\rtl\Garant\L3\l3Stream.pas'
 , IniFiles {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\IniFiles.pas' {$EndIf}
 , l3FileUtils in 'w:\common\components\rtl\Garant\L3\l3FileUtils.pas'
 , tfwCS in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCS.pas'
 , ArrayProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ArrayProcessingPack.pas'
 , tfwBeginLikeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwBeginLikeWord.pas'
 , kwBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginLikeCompiledCode.pas'
 , kwCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwCloseBracket.pas'
 , tfwRevertedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRevertedArrayView.pas'
 , tfwFilteredArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFilteredArrayView.pas'
 , tfwLambdedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwLambdedArrayView.pas'
 , tfwMappedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMappedArrayView.pas'
 , tfwIteratorFromFunctor in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratorFromFunctor.pas'
 , tfwJoinIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwJoinIterator.pas'
 , tfwTruncatedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTruncatedArrayView.pas'
 , tfwSliceView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSliceView.pas'
 , BasicsPack in 'w:\common\components\rtl\Garant\ScriptEngine\BasicsPack.pas'
 , l3MessagesService in 'w:\common\components\rtl\Garant\L3\l3MessagesService.pas'
 , kwValue in 'w:\common\components\rtl\Garant\ScriptEngine\kwValue.pas'
 , kwWordPtrPushWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrPushWord.pas'
 , kwWordPtrWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrWorker.pas'
 , FileProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FileProcessingPack.pas'
 , l3TextSearch in 'w:\common\components\rtl\Garant\L3\l3TextSearch.pas'
 , SysUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SysUtilsPack.pas'
 , l3TabService in 'w:\common\components\rtl\Garant\L3\l3TabService.pas'
 , l3SysUtils in 'w:\common\components\rtl\Garant\L3\l3SysUtils.pas'
 , JclSysInfo {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\source\common\JclSysInfo.pas' {$EndIf}
 , DateUtils {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\DateUtils.pas' {$EndIf}
 {$If NOT Defined(NoVCL)}
 , Forms {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Forms.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Controls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ActnList {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ActnList.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ContainedActionsWordspack in 'w:\common\components\rtl\Garant\ScriptEngine\ContainedActionsWordspack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , CustomActionWordpack in 'w:\common\components\rtl\Garant\ScriptEngine\CustomActionWordpack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ActionListWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ActionListWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ControlsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Menus {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Menus.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , MenuWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\MenuWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ScreenService in 'w:\common\components\rtl\Garant\L3\l3ScreenService.pas'
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush in 'w:\common\components\rtl\Garant\ScriptEngine\kwBynameControlPush.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwControlWord.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3CloseFormHelper in 'w:\common\components\rtl\Garant\L3\l3CloseFormHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3FormsService in 'w:\common\components\rtl\Garant\L3\l3FormsService.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3PopupMenuHelper in 'w:\common\components\rtl\Garant\L3\l3PopupMenuHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3ControlFontService in 'w:\common\components\rtl\Garant\L3\l3ControlFontService.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , FontWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas'
 {$If NOT Defined(NoVCL)}
 , WinControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinControlsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ScrollingWinControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollingWinControlWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ScrollInfoProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollInfoProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwPopControlScrollInfo in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfo.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwScrollInfoWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwScrollInfoWord.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWinControlFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWinControlFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , kwComponentFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas'
 , kwObjectFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwObjectFromStackWord.pas'
 {$If NOT Defined(NoVCL)}
 , kwPopControlScrollInfoMin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMin.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwPopControlScrollInfoMax in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMax.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwPopControlScrollInfoPageSize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPageSize.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwPopControlScrollInfoPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPosition.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , FormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ObjectList in 'w:\common\components\rtl\Garant\L3\l3ObjectList.pas'
 , l3SimpleDataContainer in 'w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas'
 {$If NOT Defined(NoVCL)}
 , CustomFormProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CustomFormProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Clipbrd {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Clipbrd.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Utils in 'w:\common\components\rtl\Garant\L3\l3Utils.pas'
 , l3CStringDataObject in 'w:\common\components\rtl\Garant\L3\l3CStringDataObject.pas'
 , l3StorableDataObject in 'w:\common\components\rtl\Garant\L3\l3StorableDataObject.pas'
 , l3DataObject in 'w:\common\components\rtl\Garant\L3\l3DataObject.pas'
 , l3LongintList in 'w:\common\components\rtl\Garant\L3\l3LongintList.pas'
 , l3LongintListPrim in 'w:\common\components\rtl\Garant\L3\l3LongintListPrim.pas'
 , l3DataObjectEnum in 'w:\common\components\rtl\Garant\L3\l3DataObjectEnum.pas'
 , ShlObj {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShlObj.pas' {$EndIf}
 , tfwWordDeleteListeners in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordDeleteListeners.pas'
 , ItfwWordListenerList in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwWordListenerList.pas'
 , WordsRTTIPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsRTTIPack.pas'
 , seWordsInfo in 'w:\common\components\rtl\Garant\ScriptEngine\seWordsInfo.pas'
 , tfwCodeIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCodeIterator.pas'
 , kwCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordContainer.pas'
 , kwDualCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwDualCompiledWordContainer.pas'
 , kwCompiledWordWorkerWordRunner in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordRunner.pas'
 , kwCompiledWordWorkerWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWord.pas'
 , kwCompiledWordWorkerWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordPack.pas'
 , kwCompiledIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIfElse.pas'
 , kwCompiledIF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIF.pas'
 , tfwWordBoxPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordBoxPack.pas'
 , KeyWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyWordPack.pas'
 , tfwWordInfoCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoCache.pas'
 , tfwWordInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoList.pas'
 , tfwWordInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoListPrim.pas'
 , NewWordDefinitorPack in 'w:\common\components\rtl\Garant\ScriptEngine\NewWordDefinitorPack.pas'
 , ItfwKeywordFinderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas'
 , ItfwCompilerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas'
 , kwPopClassInherits in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopClassInherits.pas'
 , l3RTTI in 'w:\common\components\rtl\Garant\L3\l3RTTI.pas'
 {$If NOT Defined(NoVCL) AND NOT Defined(XE)}
 , ControlResizeBugFix
 {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(XE)
 , toK in 'w:\common\components\DailyTest\toK.pas'
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner in 'w:\common\components\rtl\Garant\DUnitTuning\KTestRunner.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\BaseTest.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , TestFrameWork in 'w:\common\components\rtl\external\DUnit\src\TestFrameWork.pas'
 {$If NOT Defined(NoVCL)}
 , ITestWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\ITestWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3CardinalList in 'w:\common\components\rtl\Garant\L3\l3CardinalList.pas'
 , l3ImageUtils in 'w:\common\components\rtl\Garant\L3\l3ImageUtils.pas'
 {$If Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)}
 , KBridge in 'w:\common\components\rtl\Garant\DUnitTuning\KBridge.pas'
 {$IfEnd} // Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , orb_int in 'w:\common\components\rtl\external\MTDOrb\src\orbint\orb_int.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , SecuritySrv_int in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv_int.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , CosNaming_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming_int.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , Contents_int in 'w:\common\components\rtl\Garant\ServerGate\Contents_int.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , GarORBInitializerImpl in 'w:\common\components\rtl\Garant\GarORB\GarORBInitializerImpl.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , pi in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , pi_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi_int.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , orb in 'w:\common\components\rtl\external\MTDOrb\src\orb\orb.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , GarClientSecurity in 'w:\common\components\rtl\Garant\GarORB\GarClientSecurity.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , orbtypes in 'w:\common\components\rtl\external\MTDOrb\src\orb\orbtypes.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , pi_impl in 'w:\common\components\rtl\external\MTDOrb\src\orb\pi_impl.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , CosNaming in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , SecuritySrv in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , Contents in 'w:\common\components\rtl\Garant\ServerGate\Contents.pas'
 {$IfEnd} // Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , tfwKConst in 'w:\common\components\rtl\Garant\DUnitTuning\tfwKConst.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , ddPicturePathListner in 'w:\common\components\rtl\Garant\dd\ddPicturePathListner.pas'
 , l3VCLStrings in 'w:\common\components\rtl\Garant\L3\l3VCLStrings.pas'
 , l3VCLStringsItems in 'w:\common\components\rtl\Garant\L3\l3VCLStringsItems.pas'
 , l3CastableStrings in 'w:\common\components\rtl\Garant\L3\l3CastableStrings.pas'
 , l3PicturePathService in 'w:\common\components\rtl\Garant\L3\l3PicturePathService.pas'
 , PictureEtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas'
 , ddConst in 'w:\common\components\rtl\Garant\dd\ddConst.pas'
 , ddUtils in 'w:\common\components\rtl\Garant\dd\ddUtils.pas'
 {$If NOT Defined(NotTunedDUnit)}
 , TestNameList in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameList.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , TestNameString in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameString.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , TextTestRunner in 'w:\common\components\rtl\external\DUnit\src\TextTestRunner.pas'
 {$If NOT Defined(NotTunedDUnit)}
 , TimeInfoList in 'w:\common\components\rtl\Garant\DUnitTuning\TimeInfoList.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , ExcludedTests in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTests.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , ExcludedTestsFolders in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTestsFolders.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , TestDocumentList in 'w:\common\components\rtl\Garant\DUnitTuning\TestDocumentList.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , vtVerInf in 'w:\common\components\rtl\Garant\L3\vtVerInf.pas'
 , l3VersionInfoService in 'w:\common\components\rtl\Garant\L3\l3VersionInfoService.pas'
 , JwaWinBase {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas' {$EndIf}
 , JwaNtStatus {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas' {$EndIf}
 , JwaWinNT {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas' {$EndIf}
 , JwaWinType {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas' {$EndIf}
 {$If NOT Defined(InsiderTest)}
 , SHDTestScriptEngine in 'w:\common\components\rtl\Garant\Daily\SHDTestScriptEngine.pas'
 {$IfEnd} // NOT Defined(InsiderTest)
 , tfwScriptEngineEX in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineEX.pas'
 , tfwScriptEngine in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngine.pas'
 , tfwStringStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringStreamFactory.pas'
 , tfwFileStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFileStreamFactory.pas'
 , kwEmitString in 'w:\common\components\rtl\Garant\ScriptEngine\kwEmitString.pas'
 , kwTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwTryFinally.pas'
 , tfwDualWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDualWord.pas'
 , kwCompiledTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryFinally.pas'
 , kwCompiledTryExcept in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryExcept.pas'
 , kwEND in 'w:\common\components\rtl\Garant\ScriptEngine\kwEND.pas'
 , kwFINALLY in 'w:\common\components\rtl\Garant\ScriptEngine\kwFINALLY.pas'
 , kwMedianBacket in 'w:\common\components\rtl\Garant\ScriptEngine\kwMedianBacket.pas'
 , kwEXCEPT in 'w:\common\components\rtl\Garant\ScriptEngine\kwEXCEPT.pas'
 , kwMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwMain.pas'
 , tfwScriptEnginePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEnginePrim.pas'
 , tfwValueStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueStack.pas'
 , tfwSourcePointList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSourcePointList.pas'
 , tfwDictionaryStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryStack.pas'
 , tfwDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.pas'
 , tfwParser in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParser.pas'
 , tfwCachedTokens in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCachedTokens.pas'
 , tfwParserProgressService in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserProgressService.pas'
 , ItfwParserWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas'
 , ItfwParserExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas'
 , l3ScriptService in 'w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas'
 , seThreadSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seThreadSupport.pas'
 , ItfwScriptEngineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwScriptEngineWordsPack.pas'
 , kwSystemIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwSystemIncluded.pas'
 , kwIncludedPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncludedPrim.pas'
 , kwCompiledIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIncluded.pas'
 , tfwCOMStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCOMStreamFactory.pas'
 , kwCompiledMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledMain.pas'
 , l3EtalonsService in 'w:\common\components\rtl\Garant\L3\l3EtalonsService.pas'
 , tfwResourceStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwResourceStreamFactory.pas'
 , tfwCompiledAxiomaticsRes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompiledAxiomaticsRes.pas'
 , tfwTypesForRegister in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypesForRegister.pas'
 , tfwClassesForRegister in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassesForRegister.pas'
 , l3ClassList in 'w:\common\components\rtl\Garant\L3\l3ClassList.pas'
 , tfwScriptsRunningAndDebugging in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptsRunningAndDebugging.pas'
 , tfwOutToFileScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwOutToFileScriptCaller.pas'
 , tfwConsoleScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwConsoleScriptCaller.pas'
 , tfwDefaultScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDefaultScriptCaller.pas'
 , tfwDebugScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDebugScriptCaller.pas'
 , tfwDebugService in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDebugService.pas'
 , CodeFlowWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeFlowWordsPack.pas'
 , seModalSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seModalSupport.pas'
 , l3ModalService in 'w:\common\components\rtl\Garant\L3\l3ModalService.pas'
 , seModalWorkerList in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas'
 , seModalWorkerListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerListPrim.pas'
 , seModalWorker in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorker.pas'
 , l3AFWExceptions in 'w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas'
 , l3BatchService in 'w:\common\components\rtl\Garant\L3\l3BatchService.pas'
 , afwAnswer in 'w:\common\components\rtl\Garant\L3\afwAnswer.pas'
 , l3ProtoIntegerList in 'w:\common\components\rtl\Garant\L3\l3ProtoIntegerList.pas'
 , CompilationPack in 'w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas'
 , kwFORWARD in 'w:\common\components\rtl\Garant\ScriptEngine\kwFORWARD.pas'
 , WordsDefinitionPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsDefinitionPack.pas'
 , tfwProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\tfwProcedure.pas'
 , kwStandardProcedureCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwStandardProcedureCloseBracket.pas'
 , kwCompiledProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedure.pas'
 , kwKeyValuesPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyValuesPack.pas'
 , kwKeyValues in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyValues.pas'
 , kwCompiledProcedureWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWordsPack.pas'
 , kwCompiledFunction in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledFunction.pas'
 , kwCompiledProcedureWithStackChecking in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas'
 , kwInlinedWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwInlinedWord.pas'
 , IncludesAndUsesPack in 'w:\common\components\rtl\Garant\ScriptEngine\IncludesAndUsesPack.pas'
 , kwInclude in 'w:\common\components\rtl\Garant\ScriptEngine\kwInclude.pas'
 , tfwIncludeLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIncludeLike.pas'
 , kwIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncluded.pas'
 , kwUses in 'w:\common\components\rtl\Garant\ScriptEngine\kwUses.pas'
 , kwUsesLike in 'w:\common\components\rtl\Garant\ScriptEngine\kwUsesLike.pas'
 , EtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas'
 , kwCheckOutputWithInput in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckOutputWithInput.pas'
 , kwCheckEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckEtalon.pas'
 , kwTestResolveInputFilePath in 'w:\common\components\rtl\Garant\ScriptEngine\kwTestResolveInputFilePath.pas'
 , MouseInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\MouseInputPack.pas'
 , kwMouseLeftDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftDown.pas'
 , kwMouseUpDownSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseUpDownSupport.pas'
 , kwSendInputSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupport.pas'
 , kwMouseLeftUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftUp.pas'
 , kwMouseMiddleUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleUp.pas'
 , kwMouseMiddleDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleDown.pas'
 , kwMouseRightUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightUp.pas'
 , kwMouseRightDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightDown.pas'
 , kwMouseSetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseSetCursorPosition.pas'
 , kwMouseGetCursorIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorIndex.pas'
 , kwMouseGetCursorNameByIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorNameByIndex.pas'
 , kwMouseGetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorPosition.pas'
 , kwMouseWheelUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelUp.pas'
 , kwMouseWheelSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelSupport.pas'
 , kwMouseWheelDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelDown.pas'
 {$If NOT Defined(NoVCL)}
 , ModalDialogsKeywordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ModalDialogsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWasWait in 'w:\common\components\rtl\Garant\ScriptEngine\kwWasWait.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWaitNo in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitNo.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWaitOk in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitOk.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWaitYes in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitYes.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWaitCancel in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitCancel.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwWaitChoice in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitChoice.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , KeyboardInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyboardInputPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwKey in 'w:\common\components\rtl\Garant\ScriptEngine\kwKey.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwHardKey in 'w:\common\components\rtl\Garant\ScriptEngine\kwHardKey.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , Consts {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas' {$EndIf}
 {$If NOT Defined(NoVCL)}
 , kwKeyDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyDown.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , kwKeyUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyUp.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , CodeBranchingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeBranchingPack.pas'
 , kwIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwIfElse.pas'
 , kwElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwElse.pas'
 , kwCASE in 'w:\common\components\rtl\Garant\ScriptEngine\kwCASE.pas'
 , kwCompiledCase in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCase.pas'
 , kwDEFAULT in 'w:\common\components\rtl\Garant\ScriptEngine\kwDEFAULT.pas'
 , kwRAISE in 'w:\common\components\rtl\Garant\ScriptEngine\kwRAISE.pas'
 , kwBracketBegin in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketBegin.pas'
 , kwBracketEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketEnd.pas'
 , kwTypedBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTypedBeginLikeCompiledCode.pas'
 , kwBEGIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwBEGIN.pas'
 , kwRULES in 'w:\common\components\rtl\Garant\ScriptEngine\kwRULES.pas'
 , kwCompiledRules in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledRules.pas'
 , ScriptsCompilingAndProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScriptsCompilingAndProcessingPack.pas'
 , kwScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileAndProcess.pas'
 , kwCompiledScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileAndProcess.pas'
 , kwMainCodeController in 'w:\common\components\rtl\Garant\ScriptEngine\kwMainCodeController.pas'
 , kwScriptCompileStringAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileStringAndProcess.pas'
 , kwCompiledScriptCompileStringAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileStringAndProcess.pas'
 {$If NOT Defined(NoWindows)}
 , WinUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinUtilsPack.pas'
 {$IfEnd} // NOT Defined(NoWindows)
 , CommCtrl {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\CommCtrl.pas' {$EndIf}
 , AutoTestsSuite in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestsSuite.pas'
 , AutoTestSuiteWithDUnitSupport in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestSuiteWithDUnitSupport.pas'
 , CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas'
 {$If NOT Defined(NoVCL)}
 , kwKeyWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , GUITestRunner in 'w:\common\components\rtl\external\DUnit\src\GUITestRunner.pas'
 , vtComboBoxQS in 'w:\common\components\gui\Garant\VT\vtComboBoxQS.pas'
 , vtComboTree in 'w:\common\components\gui\Garant\VT\ComboTree\vtComboTree.pas'
 , FakeBox in 'w:\common\components\gui\Garant\VT\ComboTree\FakeBox.pas'
 , EditableBox in 'w:\common\components\gui\Garant\VT\ComboTree\EditableBox.pas'
 , DropDownTree in 'w:\common\components\gui\Garant\VT\ComboTree\DropDownTree.pas'
 , AbstractDropDown in 'w:\common\components\gui\Garant\VT\ComboTree\AbstractDropDown.pas'
 , ctAbstractEdit in 'w:\common\components\gui\Garant\VT\ComboTree\ctAbstractEdit.pas'
 , ctButtonEdit in 'w:\common\components\gui\Garant\Everest\ctButtonEdit.pas'
 , elCustomButtonEdit in 'w:\common\components\gui\Garant\Everest\elCustomButtonEdit.pas'
 , elCustomEdit in 'w:\common\components\gui\Garant\Everest\elCustomEdit.pas'
 , evCustomEdit in 'w:\common\components\gui\Garant\Everest\evCustomEdit.pas'
 , evCustomMemo in 'w:\common\components\gui\Garant\Everest\evCustomMemo.pas'
 , evEditorWithOperations in 'w:\common\components\gui\Garant\Everest\evEditorWithOperations.pas'
 , evCustomEditor in 'w:\common\components\gui\Garant\Everest\evCustomEditor.pas'
 , evCustomEditorModelPart in 'w:\common\components\gui\Garant\Everest\evCustomEditorModelPart.pas'
 , evMultiSelectEditorWindow in 'w:\common\components\gui\Garant\Everest\evMultiSelectEditorWindow.pas'
 , evCustomEditorWindowModelPart in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowModelPart.pas'
 , evCustomEditorWindow in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindow.pas'
 , evCustomEditorWindowPrim in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowPrim.pas'
 , nevControl in 'w:\common\components\gui\Garant\Everest\nevControl.pas'
 , afwControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControl.pas'
 , afwBaseControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwBaseControl.pas'
 , afwControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControlPrim.pas'
 , OvcBase in 'w:\common\components\rtl\external\Orpheus\OvcBase.pas'
 , OvcController in 'w:\common\components\rtl\external\Orpheus\OvcController.pas'
 , afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas'
 , afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas'
 {$If NOT Defined(NoVCL)}
 , ImgList {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , l3WinControlCanvas in 'w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas'
 , l3ControlCanvas in 'w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas'
 , l3Canvas in 'w:\common\components\rtl\Garant\L3\l3Canvas.pas'
 , l3CanvasPrim in 'w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas'
 , l3RectList in 'w:\common\components\rtl\Garant\L3\l3RectList.pas'
 , l3Region in 'w:\common\components\rtl\Garant\L3\l3Region.pas'
 , l3Defaults in 'w:\common\components\rtl\Garant\L3\l3Defaults.pas'
 , l3CacheableBase in 'w:\common\components\rtl\Garant\L3\l3CacheableBase.pas'
 , l3CanvasUtils in 'w:\common\components\rtl\Garant\L3\l3CanvasUtils.pas'
 , l3ScreenIC in 'w:\common\components\rtl\Garant\L3\l3ScreenIC.pas'
 , l3LogFont in 'w:\common\components\rtl\Garant\L3\l3LogFont.pas'
 , l3FontManager in 'w:\common\components\rtl\Garant\L3\l3FontManager.pas'
 , l3FontManagerPrim in 'w:\common\components\rtl\Garant\L3\l3FontManagerPrim.pas'
 , l3FontManagerPrimPrim in 'w:\common\components\rtl\Garant\L3\l3FontManagerPrimPrim.pas'
 , l3FontTools in 'w:\common\components\rtl\Garant\L3\l3FontTools.pas'
 , l3FormattedLines in 'w:\common\components\rtl\Garant\L3\l3FormattedLines.pas'
 , l3ProtoObjectRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectRefList.pas'
 , l3LineArray in 'w:\common\components\rtl\Garant\L3\l3LineArray.pas'
 , l3VirtualCanvas in 'w:\common\components\rtl\Garant\L3\l3VirtualCanvas.pas'
 , l3Bitmap in 'w:\common\components\rtl\Garant\L3\l3Bitmap.pas'
 {$If Defined(l3Requires_m0)}
 , m2XLtLib in 'w:\common\components\rtl\Garant\L3\m2\m2XLtLib.pas'
 {$IfEnd} // Defined(l3Requires_m0)
 , l3FrameLines in 'w:\common\components\rtl\Garant\L3\l3FrameLines.pas'
 , l3FrameObjectList in 'w:\common\components\rtl\Garant\L3\l3FrameObjectList.pas'
 , l3FrameObject in 'w:\common\components\rtl\Garant\L3\l3FrameObject.pas'
 , l3CoordinateMap in 'w:\common\components\rtl\Garant\L3\l3CoordinateMap.pas'
 , l3FrameLineList in 'w:\common\components\rtl\Garant\L3\l3FrameLineList.pas'
 , l3FrameLine in 'w:\common\components\rtl\Garant\L3\l3FrameLine.pas'
 , l3UnitsTools in 'w:\common\components\rtl\Garant\L3\l3UnitsTools.pas'
 , l3InterfacedIntegerList in 'w:\common\components\rtl\Garant\L3\l3InterfacedIntegerList.pas'
 , l3FrameLinesSpy in 'w:\common\components\rtl\Garant\L3\l3FrameLinesSpy.pas'
 {$If NOT Defined(NoVCL)}
 , StdCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , RadioButtonWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas'
 , l3Operations in 'w:\common\components\rtl\Garant\L3\l3Operations.pas'
 , l3DropTarget in 'w:\common\components\rtl\Garant\L3\l3DropTarget.pas'
 , l3DropSource in 'w:\common\components\rtl\Garant\L3\l3DropSource.pas'
 , afwFacade in 'w:\common\components\gui\Garant\AFW\afwFacade.pas'
 , l3KeyboardLayoutService in 'w:\common\components\rtl\Garant\L3\l3KeyboardLayoutService.pas'
 , afwSettingsImplSing in 'w:\common\components\gui\Garant\AFW\afwSettingsImplSing.pas'
 , afwSettingsImplPersistent in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPersistent.pas'
 , afwSettingsImpl in 'w:\common\components\gui\Garant\AFW\afwSettingsImpl.pas'
 , afwSettingsImplPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrim.pas'
 , afwSettingsImplPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrimPrim.pas'
 , l3InterfacedString in 'w:\common\components\rtl\Garant\L3\l3InterfacedString.pas'
 , l3NCString in 'w:\common\components\rtl\Garant\L3\l3NCString.pas'
 , afwSettingsImplemented in 'w:\common\components\gui\Garant\AFW\afwSettingsImplemented.pas'
 , afwSettings in 'w:\common\components\gui\Garant\AFW\afwSettings.pas'
 , afwSettingsPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsPrimPrim.pas'
 , afwAString in 'w:\common\components\gui\Garant\AFW\afwAString.pas'
 , afwSettingsChangePublisher in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisher.pas'
 , afwSettingsChangePublisherPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisherPrim.pas'
 , IafwSettingListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingListenerPtrList.pas'
 , IafwSettingsReplaceListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingsReplaceListenerPtrList.pas'
 , afwVCL in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas'
 , afwFont in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwFont.pas'
 , afwHintManager in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas'
 {$If NOT Defined(NoVCL)}
 , ExtCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , PanelProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , RadioGroupWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , k2OperationContainer in 'w:\common\components\rtl\Garant\K2\k2OperationContainer.pas'
 , k2OpRefList in 'w:\common\components\rtl\Garant\K2\k2OpRefList.pas'
 , k2Op in 'w:\common\components\rtl\Garant\K2\k2Op.pas'
 , k2Prim in 'w:\common\components\rtl\Garant\K2\k2Prim.pas'
 , k2PropertyArray in 'w:\common\components\rtl\Garant\K2\k2PropertyArray.pas'
 , k2TypeTableCreatedListeners in 'w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas'
 , k2Attributes in 'w:\common\components\rtl\Garant\K2\k2Attributes.pas'
 , k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas'
 , k2Empty_Const in 'w:\common\components\rtl\Garant\K2\k2Empty_Const.pas'
 , k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas'
 , k2NilOp in 'w:\common\components\rtl\Garant\K2\k2NilOp.pas'
 , l3IntegerValueMapManager in 'w:\common\components\rtl\Garant\L3\l3IntegerValueMapManager.pas'
 , l3ValueMapManager in 'w:\common\components\rtl\Garant\L3\l3ValueMapManager.pas'
 , l3ValueMapManagerPrim in 'w:\common\components\rtl\Garant\L3\l3ValueMapManagerPrim.pas'
 , l3ValueMap in 'w:\common\components\rtl\Garant\L3\l3ValueMap.pas'
 , l3BaseWithIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDList.pas'
 , l3BaseWithIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDListPrim.pas'
 , l3BaseWithID in 'w:\common\components\rtl\Garant\L3\l3BaseWithID.pas'
 , l3CustomControlCanvas in 'w:\common\components\rtl\Garant\L3\l3CustomControlCanvas.pas'
 , nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas'
 , k2Interfaces in 'w:\common\components\rtl\Garant\K2\k2Interfaces.pas'
 , k2PureMixIns in 'w:\common\components\rtl\Garant\K2\k2PureMixIns.pas'
 , evdTypes in 'w:\common\components\rtl\Garant\EVD\evdTypes.pas'
 , evdStyles in 'w:\common\components\rtl\Garant\EVD\evdStyles.pas'
 , evConst in 'w:\common\components\gui\Garant\Everest\evConst.pas'
 , l3Tree_TLB in 'w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas'
 , evdInterfaces in 'w:\common\components\rtl\Garant\EVD\evdInterfaces.pas'
 , nevTypes in 'w:\common\components\gui\Garant\Everest\new\nevTypes.pas'
 , k2BaseStruct in 'w:\common\components\rtl\Garant\K2\k2BaseStruct.pas'
 , k2Base in 'w:\common\components\rtl\Garant\K2\k2Base.pas'
 , k2TypeModelPart in 'w:\common\components\rtl\Garant\K2\k2TypeModelPart.pas'
 , k2SortTagsList in 'w:\common\components\rtl\Garant\K2\k2SortTagsList.pas'
 , k2SortTagsListPrim in 'w:\common\components\rtl\Garant\K2\k2SortTagsListPrim.pas'
 , k2String_Const in 'w:\common\components\rtl\Garant\K2\k2String_Const.pas'
 , k2SomeDataContainer_Const in 'w:\common\components\rtl\Garant\K2\k2SomeDataContainer_Const.pas'
 , k2Object_Const in 'w:\common\components\rtl\Garant\K2\k2Object_Const.pas'
 , k2AtomWrapPrim in 'w:\common\components\rtl\Garant\K2\k2AtomWrapPrim.pas'
 , k2PropSorter in 'w:\common\components\rtl\Garant\K2\k2PropSorter.pas'
 , k2NullTagImpl in 'w:\common\components\rtl\Garant\K2\k2NullTagImpl.pas'
 , k2NullTagImplPrim in 'w:\common\components\rtl\Garant\K2\k2NullTagImplPrim.pas'
 , k2SpecialTag in 'w:\common\components\rtl\Garant\K2\k2SpecialTag.pas'
 , k2NotStructuredTag in 'w:\common\components\rtl\Garant\K2\k2NotStructuredTag.pas'
 , k2Tag in 'w:\common\components\rtl\Garant\K2\k2Tag.pas'
 , k2Strings in 'w:\common\components\rtl\Garant\K2\k2Strings.pas'
 , evResultFontInterfaces in 'w:\common\components\gui\Garant\Everest\evResultFontInterfaces.pas'
 , evResultFont in 'w:\common\components\gui\Garant\Everest\evResultFont.pas'
 , nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas'
 , evTypes in 'w:\common\components\gui\Garant\Everest\evTypes.pas'
 , afwNavigation in 'w:\common\components\gui\Garant\AFW\afwNavigation.pas'
 , nevFacade in 'w:\common\components\gui\Garant\Everest\new\nevFacade.pas'
 , TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas'
 , StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas'
 , LeafPara_Const in 'w:\common\components\rtl\Garant\EVD\LeafPara_Const.pas'
 , Para_Const in 'w:\common\components\rtl\Garant\EVD\Para_Const.pas'
 , k2Tag_Const in 'w:\common\components\rtl\Garant\K2\k2Tag_Const.pas'
 , k2Bool_Const in 'w:\common\components\rtl\Garant\K2\k2Bool_Const.pas'
 , k2Enum_Const in 'w:\common\components\rtl\Garant\K2\k2Enum_Const.pas'
 , k2Long_Const in 'w:\common\components\rtl\Garant\K2\k2Long_Const.pas'
 , k2Inch_Const in 'w:\common\components\rtl\Garant\K2\k2Inch_Const.pas'
 , k2Color_Const in 'w:\common\components\rtl\Garant\K2\k2Color_Const.pas'
 , evdFrame_Const in 'w:\common\components\rtl\Garant\EVD\evdFrame_Const.pas'
 , FramePart_Const in 'w:\common\components\rtl\Garant\EVD\FramePart_Const.pas'
 , SubLayer_Const in 'w:\common\components\rtl\Garant\EVD\SubLayer_Const.pas'
 , k2OList_Const in 'w:\common\components\rtl\Garant\K2\k2OList_Const.pas'
 , k2l3Base_Const in 'w:\common\components\rtl\Garant\K2\k2l3Base_Const.pas'
 , Sub_Const in 'w:\common\components\rtl\Garant\EVD\Sub_Const.pas'
 , DictItem_Const in 'w:\common\components\rtl\Garant\EVD\DictItem_Const.pas'
 , DictRec_Const in 'w:\common\components\rtl\Garant\EVD\DictRec_Const.pas'
 , AutoClass_Const in 'w:\common\components\rtl\Garant\EVD\AutoClass_Const.pas'
 , evdTextStyle_Const in 'w:\common\components\rtl\Garant\EVD\evdTextStyle_Const.pas'
 , Style_Const in 'w:\common\components\rtl\Garant\EVD\Style_Const.pas'
 , ObjectWithHandle_Const in 'w:\common\components\rtl\Garant\EVD\ObjectWithHandle_Const.pas'
 , k2Handle_Const in 'w:\common\components\rtl\Garant\K2\k2Handle_Const.pas'
 , Justification_Const in 'w:\common\components\rtl\Garant\EVD\Justification_Const.pas'
 , Font_Const in 'w:\common\components\rtl\Garant\EVD\Font_Const.pas'
 , k2FontName_Const in 'w:\common\components\rtl\Garant\K2\k2FontName_Const.pas'
 , evdStyleContainer in 'w:\common\components\rtl\Garant\EVD\evdStyleContainer.pas'
 , k2DictionaryEx in 'w:\common\components\rtl\Garant\K2\k2DictionaryEx.pas'
 , k2Dictionary in 'w:\common\components\rtl\Garant\K2\k2Dictionary.pas'
 , k2DictionaryPrim in 'w:\common\components\rtl\Garant\K2\k2DictionaryPrim.pas'
 , k2NonOptimizeContext in 'w:\common\components\rtl\Garant\K2\k2NonOptimizeContext.pas'
 , k2Context in 'w:\common\components\rtl\Garant\K2\k2Context.pas'
 , k2DictionaryIDIndex in 'w:\common\components\rtl\Garant\K2\k2DictionaryIDIndex.pas'
 , k2DictionaryIDIndexPrim in 'w:\common\components\rtl\Garant\K2\k2DictionaryIDIndexPrim.pas'
 , evStyleInterfaceEx in 'w:\common\components\gui\Garant\Everest\evStyleInterfaceEx.pas'
 , evStyleInterface in 'w:\common\components\gui\Garant\Everest\evStyleInterface.pas'
 , evStyles_SH in 'w:\common\components\gui\Garant\Everest\evStyles_SH.pas'
 , evInterface in 'w:\common\components\gui\Garant\Everest\evInterface.pas'
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy in 'w:\common\components\gui\Garant\Everest\evStyleTableSpy.pas'
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , l3InterfacePtrList in 'w:\common\components\rtl\Garant\L3\l3InterfacePtrList.pas'
 , k2Facade in 'w:\common\components\rtl\Garant\K2\k2Facade.pas'
 , evStylesPrintAndExportSettingRes in 'w:\common\components\gui\Garant\Everest\evStylesPrintAndExportSettingRes.pas'
 , evStylesPrintAndExportFontSizeSettingRes in 'w:\common\components\gui\Garant\Everest\evStylesPrintAndExportFontSizeSettingRes.pas'
 , l3MessageID in 'w:\common\components\rtl\Garant\L3\l3MessageID.pas'
 {$If NOT Defined(NoVCL)}
 , Dialogs {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , Pl3StringIDExList in 'w:\common\components\rtl\Garant\L3\Pl3StringIDExList.pas'
 , Pl3MessageIDList in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDList.pas'
 , Pl3MessageIDListPrim in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDListPrim.pas'
 , evFontInterface in 'w:\common\components\gui\Garant\Everest\evFontInterface.pas'
 , l3Nodes in 'w:\common\components\rtl\Garant\L3\l3Nodes.pas'
 , k2SimpleTagList in 'w:\common\components\rtl\Garant\K2\k2SimpleTagList.pas'
 , k2TagList in 'w:\common\components\rtl\Garant\K2\k2TagList.pas'
 , k2TagListPrim in 'w:\common\components\rtl\Garant\K2\k2TagListPrim.pas'
 , k2ListTag in 'w:\common\components\rtl\Garant\K2\k2ListTag.pas'
 , k2NonAtomicTag in 'w:\common\components\rtl\Garant\K2\k2NonAtomicTag.pas'
 , k2DocumentGenerator in 'w:\common\components\rtl\Garant\K2\k2DocumentGenerator.pas'
 , k2BaseStackGenerator in 'w:\common\components\rtl\Garant\K2\k2BaseStackGenerator.pas'
 , k2TagGen in 'w:\common\components\rtl\Garant\K2\k2TagGen.pas'
 , k2VariantImpl in 'w:\common\components\rtl\Garant\K2\k2VariantImpl.pas'
 , kwFiltersAndGeneratorsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas'
 , k2EVDReaderService in 'w:\common\components\rtl\Garant\K2\k2EVDReaderService.pas'
 , k2CustomFileReader in 'w:\common\components\rtl\Garant\K2\k2CustomFileReader.pas'
 , k2CustomReader in 'w:\common\components\rtl\Garant\K2\k2CustomReader.pas'
 , k2CustomStackGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomStackGenerator.pas'
 , k2EVDWriterService in 'w:\common\components\rtl\Garant\K2\k2EVDWriterService.pas'
 , k2CustomFileGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomFileGenerator.pas'
 , k2CustomStackGeneratorEx in 'w:\common\components\rtl\Garant\K2\k2CustomStackGeneratorEx.pas'
 , nevInternalInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInternalInterfaces.pas'
 , evOpProc in 'w:\common\components\gui\Garant\Everest\evOpProc.pas'
 , evdNativeReader in 'w:\common\components\rtl\Garant\EVD\evdNativeReader.pas'
 , k2CustomFileParser in 'w:\common\components\rtl\Garant\K2\k2CustomFileParser.pas'
 , evdNativeReaderServices in 'w:\common\components\rtl\Garant\EVD\evdNativeReaderServices.pas'
 , evStyleTableFontSizeCorrector in 'w:\common\components\gui\Garant\Everest\evStyleTableFontSizeCorrector.pas'
 , evdLeafParaFilter in 'w:\common\components\rtl\Garant\EVD\evdLeafParaFilter.pas'
 , k2TagFilter in 'w:\common\components\rtl\Garant\K2\k2TagFilter.pas'
 , k2TagTerminator in 'w:\common\components\rtl\Garant\K2\k2TagTerminator.pas'
 , evDefaultStylesFontSizes in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizes.pas'
 , evDefaultStylesFontSizesPrim1 in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim1.pas'
 , evDefaultStylesFontSizesPrim in 'w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim.pas'
 , evDef in 'w:\common\components\gui\Garant\Everest\evDef.pas'
 , evdNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeWriter.pas'
 , evdCustomNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriter.pas'
 , evdCustomNativeWriterServices in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriterServices.pas'
 , Bullet_Const in 'w:\common\components\rtl\Garant\EVD\Bullet_Const.pas'
 , SegmentsLayer_Const in 'w:\common\components\rtl\Garant\EVD\SegmentsLayer_Const.pas'
 , TextSegment_Const in 'w:\common\components\rtl\Garant\EVD\TextSegment_Const.pas'
 , Segment_Const in 'w:\common\components\rtl\Garant\EVD\Segment_Const.pas'
 , Position_Const in 'w:\common\components\rtl\Garant\EVD\Position_Const.pas'
 , TabStop_Const in 'w:\common\components\rtl\Garant\EVD\TabStop_Const.pas'
 , evSchemaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas'
 , evEvdRd in 'w:\common\components\gui\Garant\Everest\evEvdRd.pas'
 , evParaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas'
 , k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas'
 , EditorFromStackKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorFromStackKeyWordsPack.pas'
 , kwPopEditorSelectCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas'
 , kwSelectCellsWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSelectCellsWord.pas'
 , kwEditorFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackWord.pas'
 , nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas'
 , Table_Const in 'w:\common\components\gui\Garant\Everest\Table_Const.pas'
 , ParaList_Const in 'w:\common\components\gui\Garant\Everest\ParaList_Const.pas'
 , TableRow_Const in 'w:\common\components\gui\Garant\Everest\TableRow_Const.pas'
 , TableCell_Const in 'w:\common\components\gui\Garant\Everest\TableCell_Const.pas'
 , TableTextPara_Const in 'w:\common\components\gui\Garant\Everest\TableTextPara_Const.pas'
 , QueryCard_Const in 'w:\common\components\gui\Garant\Everest\QueryCard_Const.pas'
 , Document_Const in 'w:\common\components\gui\Garant\Everest\Document_Const.pas'
 , Block_Const in 'w:\common\components\gui\Garant\Everest\Block_Const.pas'
 {$If Defined(k2ForEditor)}
 , evDocumentPart in 'w:\common\components\gui\Garant\Everest\evDocumentPart.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , Type_Const in 'w:\common\components\rtl\Garant\EVD\Type_Const.pas'
 , Date_Const in 'w:\common\components\rtl\Garant\EVD\Date_Const.pas'
 , PageProperties_Const in 'w:\common\components\rtl\Garant\EVD\PageProperties_Const.pas'
 , DocSubLayer_Const in 'w:\common\components\rtl\Garant\EVD\DocSubLayer_Const.pas'
 , DocumentSub_Const in 'w:\common\components\rtl\Garant\EVD\DocumentSub_Const.pas'
 , NumANDDate_Const in 'w:\common\components\rtl\Garant\EVD\NumANDDate_Const.pas'
 , LogRecordPrim_Const in 'w:\common\components\rtl\Garant\EVD\LogRecordPrim_Const.pas'
 , NSRCTag_Const in 'w:\common\components\rtl\Garant\EVD\NSRCTag_Const.pas'
 , Address_Const in 'w:\common\components\rtl\Garant\EVD\Address_Const.pas'
 , LogRecord_Const in 'w:\common\components\rtl\Garant\EVD\LogRecord_Const.pas'
 , Time_Const in 'w:\common\components\rtl\Garant\EVD\Time_Const.pas'
 , Version_Const in 'w:\common\components\gui\Garant\Everest\Version_Const.pas'
 , Stage_Const in 'w:\common\components\rtl\Garant\EVD\Stage_Const.pas'
 , StagePrim_Const in 'w:\common\components\rtl\Garant\EVD\StagePrim_Const.pas'
 , Check_Const in 'w:\common\components\rtl\Garant\EVD\Check_Const.pas'
 , PIRec_Const in 'w:\common\components\rtl\Garant\EVD\PIRec_Const.pas'
 , DictItemEx_Const in 'w:\common\components\rtl\Garant\EVD\DictItemEx_Const.pas'
 , ActiveInterval_Const in 'w:\common\components\rtl\Garant\EVD\ActiveInterval_Const.pas'
 , Alarm_Const in 'w:\common\components\rtl\Garant\EVD\Alarm_Const.pas'
 , Participant_Const in 'w:\common\components\gui\Garant\Everest\Participant_Const.pas'
 , k2Int64_Const in 'w:\common\components\rtl\Garant\K2\k2Int64_Const.pas'
 , k2RawData_Const in 'w:\common\components\rtl\Garant\K2\k2RawData_Const.pas'
 , EditablePart_Const in 'w:\common\components\gui\Garant\Everest\EditablePart_Const.pas'
 , evQueryCardInt in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardInt.pas'
 , kwPopEditorWheelScroll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas'
 , kwPopEditorSelectColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectColumn.pas'
 {$If Defined(k2ForEditor)}
 , evCursorTools in 'w:\common\components\gui\Garant\Everest\evCursorTools.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , evInternalInterfaces in 'w:\common\components\gui\Garant\Everest\evInternalInterfaces.pas'
 , evMsgCode in 'w:\common\components\gui\Garant\Everest\evMsgCode.pas'
 , evOp in 'w:\common\components\gui\Garant\Everest\evOp.pas'
 , k2InterfaceFactory in 'w:\common\components\rtl\Garant\K2\k2InterfaceFactory.pas'
 , k2InterfaceCache in 'w:\common\components\rtl\Garant\K2\k2InterfaceCache.pas'
 , k2InterfaceList in 'w:\common\components\rtl\Garant\K2\k2InterfaceList.pas'
 , k2ToolPrim in 'w:\common\components\rtl\Garant\K2\k2ToolPrim.pas'
 , k2ToolCacheList in 'w:\common\components\rtl\Garant\K2\k2ToolCacheList.pas'
 , k2ToolPrimList in 'w:\common\components\rtl\Garant\K2\k2ToolPrimList.pas'
 , k2TagPointer in 'w:\common\components\rtl\Garant\K2\k2TagPointer.pas'
 , kwPopEditorSelectCellsVertical in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas'
 , kwPopEditorJumpToHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas'
 , nevNavigation in 'w:\common\components\gui\Garant\Everest\new\nevNavigation.pas'
 , kwPopEditorRepaintTableLinesAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintTableLinesAndCheckWithEtalon.pas'
 , kwPopEditorPrintAcnhor in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintAcnhor.pas'
 , kwPopEditorPrintTableCellsParams in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintTableCellsParams.pas'
 , nevFormatInfoUtils in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoUtils.pas'
 , nevTableCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas'
 , nevListFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevListFormatInfo.pas'
 , nevParaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevParaFormatInfo.pas'
 , nevFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfo.pas'
 , nevFormatInfoFactory in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoFactory.pas'
 , CommentPara_Const in 'w:\common\components\gui\Garant\Everest\CommentPara_Const.pas'
 , SBS_Const in 'w:\common\components\gui\Garant\Everest\SBS_Const.pas'
 , SBSRow_Const in 'w:\common\components\gui\Garant\Everest\SBSRow_Const.pas'
 , SBSCell_Const in 'w:\common\components\gui\Garant\Everest\SBSCell_Const.pas'
 , ReqRow_Const in 'w:\common\components\gui\Garant\Everest\ReqRow_Const.pas'
 , k2IUnknown_Const in 'w:\common\components\rtl\Garant\K2\k2IUnknown_Const.pas'
 , ReqCell_Const in 'w:\common\components\gui\Garant\Everest\ReqCell_Const.pas'
 , ControlPara_Const in 'w:\common\components\gui\Garant\Everest\ControlPara_Const.pas'
 {$If Defined(k2ForEditor)}
 , evParaTools in 'w:\common\components\gui\Garant\Everest\evParaTools.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , evSearch in 'w:\common\components\gui\Garant\Everest\evSearch.pas'
 , nevConfirm in 'w:\common\components\gui\Garant\Everest\new\nevConfirm.pas'
 , evExcept in 'w:\common\components\gui\Garant\Everest\evExcept.pas'
 {$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
 , evParaUtilClasses in 'w:\common\components\gui\Garant\Everest\evParaUtilClasses.pas'
 {$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)
 {$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
 , evCustomParaListUtils in 'w:\common\components\gui\Garant\Everest\evCustomParaListUtils.pas'
 {$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)
 , k2ProcessorTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcessorTagTool.pas'
 , k2TagTool in 'w:\common\components\rtl\Garant\K2\k2TagTool.pas'
 , evEditorInterfaces in 'w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas'
 , evEditorInterfacesTypes in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesTypes.pas'
 , IedTableWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas'
 , Formula_Const in 'w:\common\components\gui\Garant\Everest\Formula_Const.pas'
 , DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas'
 , LeafParaDecorationsHolder_Const in 'w:\common\components\gui\Garant\Everest\LeafParaDecorationsHolder_Const.pas'
 , k2Const in 'w:\common\components\rtl\Garant\K2\k2Const.pas'
 , evSectionPara in 'w:\common\components\gui\Garant\Everest\new\evSectionPara.pas'
 , nevRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevRubberCellsRenderInfo.pas'
 , nevTableRowRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas'
 {$If Defined(k2ForEditor)}
 , evTableCellUtils in 'w:\common\components\gui\Garant\Everest\evTableCellUtils.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , ObjectSegment_Const in 'w:\common\components\rtl\Garant\EVD\ObjectSegment_Const.pas'
 , SegmentWithChildren_Const in 'w:\common\components\rtl\Garant\EVD\SegmentWithChildren_Const.pas'
 , nevTextParaRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTextParaRenderInfo.pas'
 , nevLeafRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevLeafRenderInfo.pas'
 , nevFormatInfoList in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoList.pas'
 {$If Defined(k2ForEditor)}
 , evSegLst in 'w:\common\components\gui\Garant\Everest\evSegLst.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , evTextParaConst in 'w:\common\components\gui\Garant\Everest\evTextParaConst.pas'
 , nevSegmentObject in 'w:\common\components\gui\Garant\Everest\nevSegmentObject.pas'
 , l3SingleLineInfo in 'w:\common\components\rtl\Garant\L3\l3SingleLineInfo.pas'
 {$If Defined(k2ForEditor)}
 , evTextParaTools in 'w:\common\components\gui\Garant\Everest\evTextParaTools.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , k2InterfacesEx in 'w:\common\components\rtl\Garant\K2\k2InterfacesEx.pas'
 , evSegOp in 'w:\common\components\gui\Garant\Everest\evSegOp.pas'
 {$If Defined(k2ForEditor)}
 , evAlignBySeparatorUtils in 'w:\common\components\gui\Garant\Everest\evAlignBySeparatorUtils.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , nevStringCache in 'w:\common\components\gui\Garant\Everest\nevStringCache.pas'
 , evParaString in 'w:\common\components\gui\Garant\Everest\evParaString.pas'
 , k2InterfacedTagList in 'w:\common\components\rtl\Garant\K2\k2InterfacedTagList.pas'
 {$If Defined(k2ForEditor)}
 , evChangeCodePage in 'w:\common\components\gui\Garant\Everest\evChangeCodePage.pas'
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evAACContentUtils in 'w:\common\components\gui\Garant\Everest\evAACContentUtils.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , HyperLink_Const in 'w:\common\components\rtl\Garant\EVD\HyperLink_Const.pas'
 , nevZoomedCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedCellsRenderInfo.pas'
 , nevZoomedRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevZoomedRubberCellsRenderInfo.pas'
 , nevDocumentPartFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentPartFormatInfo.pas'
 , nevCommentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevCommentFormatInfo.pas'
 , nevBitmapFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevBitmapFormatInfo.pas'
 , nevControlFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevControlFormatInfo.pas'
 , nevFormulaFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevFormulaFormatInfo.pas'
 , evFormulaParaBitmapContainer in 'w:\common\components\rtl\Garant\EVD\evFormulaParaBitmapContainer.pas'
 , ExprDraw in 'w:\common\components\rtl\external\Expr\ExprDraw.pas'
 , l3Drawer in 'w:\common\components\rtl\Garant\L3\l3Drawer.pas'
 , ExprMake in 'w:\common\components\rtl\external\Expr\ExprMake.pas'
 , exprTokensList in 'w:\common\components\rtl\external\Expr\exprTokensList.pas'
 , BitmapPara_Const in 'w:\common\components\gui\Garant\Everest\BitmapPara_Const.pas'
 , evBitmapParaBitmapContainer in 'w:\common\components\gui\Garant\Everest\evBitmapParaBitmapContainer.pas'
 , l3IEBitmapContainer in 'w:\common\components\rtl\Garant\L3\l3IEBitmapContainer.pas'
 , l3GraphicContainer in 'w:\common\components\rtl\Garant\L3\l3GraphicContainer.pas'
 , l3GraphicContainerStack in 'w:\common\components\rtl\Garant\L3\l3GraphicContainerStack.pas'
 , l3IEBitmapContainerStack in 'w:\common\components\rtl\Garant\L3\l3IEBitmapContainerStack.pas'
 , l3Dict in 'w:\common\components\rtl\Garant\L3\l3Dict.pas'
 , l3DictionaryPrim in 'w:\common\components\rtl\Garant\L3\l3DictionaryPrim.pas'
 , l3IDIndex in 'w:\common\components\rtl\Garant\L3\l3IDIndex.pas'
 , l3IDIndexPrim in 'w:\common\components\rtl\Garant\L3\l3IDIndexPrim.pas'
 , k2Except in 'w:\common\components\rtl\Garant\K2\k2Except.pas'
 , k2String in 'w:\common\components\rtl\Garant\K2\k2String.pas'
 , k2List in 'w:\common\components\rtl\Garant\K2\k2List.pas'
 , nevControlsBlockFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevControlsBlockFormatInfo.pas'
 , evTextStyle_Const in 'w:\common\components\gui\Garant\Everest\evTextStyle_Const.pas'
 , ImageListBitmap_Const in 'w:\common\components\gui\Garant\Everest\ImageListBitmap_Const.pas'
 , nevCloakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevCloakFormatInfo.pas'
 , ControlsBlock_Const in 'w:\common\components\gui\Garant\Everest\ControlsBlock_Const.pas'
 , evControlsBlockConst in 'w:\common\components\gui\Garant\Everest\evControlsBlockConst.pas'
 , Cloak_Const in 'w:\common\components\gui\Garant\Everest\Cloak_Const.pas'
 , nevSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSegmentFormatInfo.pas'
 , evResultFontHolder in 'w:\common\components\gui\Garant\Everest\evResultFontHolder.pas'
 , nevObjectSegmentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevObjectSegmentFormatInfo.pas'
 , evGlyphFont in 'w:\common\components\gui\Garant\Everest\evGlyphFont.pas'
 , evCustomFont in 'w:\common\components\gui\Garant\Everest\evCustomFont.pas'
 , nevDocumentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentFormatInfo.pas'
 , nevSBSCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSCellFormatInfo.pas'
 , nevSBSRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevSBSRowFormatInfo.pas'
 , nevTableRowRenderInfoEx in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfoEx.pas'
 , nevReqRowFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevReqRowFormatInfo.pas'
 , evControlParaConst in 'w:\common\components\gui\Garant\Everest\evControlParaConst.pas'
 , nevPageBreakFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevPageBreakFormatInfo.pas'
 , PageBreak_Const in 'w:\common\components\rtl\Garant\EVD\PageBreak_Const.pas'
 , nevNodeGroupFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevNodeGroupFormatInfo.pas'
 , NodeGroup_Const in 'w:\common\components\gui\Garant\Everest\NodeGroup_Const.pas'
 , evStandardStyles in 'w:\common\components\gui\Garant\Everest\evStandardStyles.pas'
 , evStandardStylesList in 'w:\common\components\gui\Garant\Everest\evStandardStylesList.pas'
 , evStandardStylesListPrim in 'w:\common\components\gui\Garant\Everest\evStandardStylesListPrim.pas'
 , evdStylesRes in 'w:\common\components\rtl\Garant\EVD\evdStylesRes.pas'
 , l3ImageList in 'w:\common\components\rtl\Garant\L3\l3ImageList.pas'
 , nevFormatInfoArray in 'w:\common\components\gui\Garant\Everest\new\nevFormatInfoArray.pas'
 , kwPopEditorLP2DP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorLP2DP.pas'
 , kwPopEditorDP2LP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDP2LP.pas'
 , kwPopEditorCheckContinueCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckContinueCells.pas'
 , evTableSearch in 'w:\common\components\gui\Garant\EverestCommon\evTableSearch.pas'
 , kwPopEditorGetLeftIndentDelta in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLeftIndentDelta.pas'
 , kwPopEditorParaDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaDown.pas'
 , kwEditorFromStackCursorWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWord.pas'
 , kwPopEditorParaUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaUp.pas'
 , kwPopEditorParaEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEnd.pas'
 , kwPopEditorParaHome in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaHome.pas'
 , kwPopEditorSelectTable in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectTable.pas'
 , kwPopEditorHasComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorHasComment.pas'
 , kwEditorFromStackNextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackNextParaWord.pas'
 , kwEditorFromStackTextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTextParaWord.pas'
 , kwPopEditorDeleteUserComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDeleteUserComment.pas'
 , kwPopEditorCurrentText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCurrentText.pas'
 , kwPopEditorUpdateCursorFromHotSpot in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpot.pas'
 , kwPopEditorUpdateCursorFromHotSpotEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpotEx.pas'
 , kwPopEditorTextToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorTextToFile.pas'
 , evdMarkEliminator in 'w:\common\components\rtl\Garant\EVD\evdMarkEliminator.pas'
 , Mark_Const in 'w:\common\components\rtl\Garant\EVD\Mark_Const.pas'
 , evdDocumentMarksEliminator in 'w:\common\components\rtl\Garant\EVD\evdDocumentMarksEliminator.pas'
 , evdDocumentBookmarksEliminator in 'w:\common\components\rtl\Garant\EVD\evdDocumentBookmarksEliminator.pas'
 , evdDocumentSubsEliminator in 'w:\common\components\rtl\Garant\EVD\evdDocumentSubsEliminator.pas'
 , evDocumentSubsChildrenCountEliminator in 'w:\common\components\gui\Garant\EverestCommon\evDocumentSubsChildrenCountEliminator.pas'
 , evdHypelinkDocIDEliminator in 'w:\common\components\rtl\Garant\EVD\evdHypelinkDocIDEliminator.pas'
 , evdEmptySubsEliminator in 'w:\common\components\rtl\Garant\EVD\evdEmptySubsEliminator.pas'
 , evdBufferedFilter in 'w:\common\components\rtl\Garant\EVD\evdBufferedFilter.pas'
 , evdStartAndTimeEliminator in 'w:\common\components\gui\Garant\Everest\evdStartAndTimeEliminator.pas'
 , evBitmapEliminator4Tests in 'w:\common\components\gui\Garant\Everest\evBitmapEliminator4Tests.pas'
 {$If NOT Defined(NoImageEn)}
 , imageenio in 'w:\common\components\rtl\external\ImageEn\src\imageenio.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 , kwPopEditorGetSelectionText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionText.pas'
 , kwPopEditorGetParaByID in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetParaByID.pas'
 , kwPopEditorGetSelectionTextInFormat in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionTextInFormat.pas'
 , evdBlockNameAdder in 'w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas'
 , evdHeaderHyperlinkAdder in 'w:\common\components\gui\Garant\Everest\evdHeaderHyperlinkAdder.pas'
 , ContentsElement_Const in 'w:\common\components\gui\Garant\Everest\ContentsElement_Const.pas'
 , kwPopEditorBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResize.pas'
 , kwBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwBlockResize.pas'
 , kwPopEditorSelectCellByMouse in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellByMouse.pas'
 , kwPopEditorSetTextParaStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetTextParaStyle.pas'
 , kwPopEditorSetCursorByPoint in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetCursorByPoint.pas'
 , kwPopEditorRepaintAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas'
 , nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas'
 , nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas'
 , nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas'
 , nevShapePrimRefList in 'w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas'
 , kwPopEditorCopyAndPaste2DocumentBottom in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCopyAndPaste2DocumentBottom.pas'
 , kwPopEditorResizeTableColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas'
 , kwEditorFromStackTableColumnResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTableColumnResize.pas'
 , kwPopEditorResizeTableColumnEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumnEX.pas'
 , kwPopEditorCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckWithEtalon.pas'
 , kwCompiledCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCheckWithEtalon.pas'
 , kwPopEditorGetLMargin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLMargin.pas'
 , kwPopEditorGetWrapLimit in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetWrapLimit.pas'
 , kwPopEditorBlockResizeEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResizeEX.pas'
 , kwPopEditorPasteRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteRTF.pas'
 , kwInsertFromStreamCommon in 'w:\common\components\rtl\Garant\ScriptEngine\kwInsertFromStreamCommon.pas'
 , kwPopEditorInsertStream in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertStream.pas'
 , kwPopEditorPasteEVDTroughClipboard in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteEVDTroughClipboard.pas'
 , kwBeginWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginWaitPrint.pas'
 {$If Defined(InsiderTest)}
 , kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest)
 , afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
 , afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas'
 , l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas'
 , l3MetafileHeader in 'w:\common\components\rtl\Garant\L3\l3MetafileHeader.pas'
 , afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas'
 , l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas'
 , kwEndWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas'
 , TevCustomEditorWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TevCustomEditorWordsPack.pas'
 , IedRangeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedRangeWordsPack.pas'
 , EditorParaCoordsToScreenPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorParaCoordsToScreenPack.pas'
 , kwPopEditorParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaCoordsToScreen.pas'
 , kwParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreen.pas'
 , kwPopEditorParaEndCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEndCoordsToScreen.pas'
 , kwPopEditorParaMiddleCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaMiddleCoordsToScreen.pas'
 , kwPopEditorCursorCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCursorCoordsToScreen.pas'
 , evCustomTextSource in 'w:\common\components\gui\Garant\Everest\evCustomTextSource.pas'
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces in 'w:\common\components\gui\Garant\VCM\vcmExternalInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , evEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evEditorWindowHotSpot.pas'
 , l3Tool in 'w:\common\components\rtl\Garant\L3\l3Tool.pas'
 , evDataObject in 'w:\common\components\gui\Garant\Everest\evDataObject.pas'
 , nevSelection in 'w:\common\components\gui\Garant\Everest\nevSelection.pas'
 , evBlockCursor in 'w:\common\components\gui\Garant\Everest\evBlockCursor.pas'
 , evWindowCursor in 'w:\common\components\gui\Garant\Everest\evWindowCursor.pas'
 , evCursorController in 'w:\common\components\gui\Garant\Everest\evCursorController.pas'
 , evDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest\evDocumentPartGenerator.pas'
 , evDocumentPartGeneratorPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPartGeneratorPrim.pas'
 , evHighLevelDocumentGenerator in 'w:\common\components\gui\Garant\Everest\evHighLevelDocumentGenerator.pas'
 , evGeneratorsInterfaces in 'w:\common\components\gui\Garant\Everest\evGeneratorsInterfaces.pas'
 , afwCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaret.pas'
 , afwCaretPair in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaretPair.pas'
 , afwSingleCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwSingleCaret.pas'
 , afwCustomCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCaretType.pas'
 , afwInsCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInsCaretType.pas'
 , afwOvrCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwOvrCaretType.pas'
 , nevBasePointList in 'w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas'
 , evRange in 'w:\common\components\gui\Garant\Everest\evRange.pas'
 , k2ProcTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcTagTool.pas'
 , evEditorInterfacesMisc in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesMisc.pas'
 , evBitmapReader in 'w:\common\components\gui\Garant\Everest\evBitmapReader.pas'
 {$If Defined(k2ForEditor)}
 , evUsialParagraph in 'w:\common\components\gui\Garant\Everest\evUsialParagraph.pas'
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evParaFrame in 'w:\common\components\gui\Garant\Everest\evParaFrame.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , evSelectConst in 'w:\common\components\gui\Garant\Everest\evSelectConst.pas'
 , nevView in 'w:\common\components\gui\Garant\Everest\new\nevView.pas'
 , nevBaseDrawView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDrawView.pas'
 , nevBaseView in 'w:\common\components\gui\Garant\Everest\new\nevBaseView.pas'
 , nevObjectList in 'w:\common\components\gui\Garant\Everest\new\nevObjectList.pas'
 , l3PrinterIC in 'w:\common\components\rtl\Garant\L3\l3PrinterIC.pas'
 , Printers {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Printers.pas' {$EndIf}
 , l3Printer in 'w:\common\components\rtl\Garant\L3\l3Printer.pas'
 , nevRealTools in 'w:\common\components\gui\Garant\Everest\new\nevRealTools.pas'
 , nevViewInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevViewInterfaces.pas'
 , l3ProcessMessagesManager in 'w:\common\components\rtl\Garant\L3\l3ProcessMessagesManager.pas'
 , evMultiSelection in 'w:\common\components\gui\Garant\Everest\evMultiSelection.pas'
 , nevRangeList in 'w:\common\components\gui\Garant\Everest\new\nevRangeList.pas'
 , evMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evMultiSelectionBlock.pas'
 , evMultiSelectionText in 'w:\common\components\gui\Garant\Everest\evMultiSelectionText.pas'
 , evMultiSelectionDataFormatting in 'w:\common\components\gui\Garant\Everest\evMultiSelectionDataFormatting.pas'
 , evMultiSelectionRange in 'w:\common\components\gui\Garant\Everest\evMultiSelectionRange.pas'
 , evMultiSelectionLocation in 'w:\common\components\gui\Garant\Everest\evMultiSelectionLocation.pas'
 , evLeafParaMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evLeafParaMultiSelectionBlock.pas'
 , evTextParaMultiSelectionBlock in 'w:\common\components\gui\Garant\Everest\evTextParaMultiSelectionBlock.pas'
 , evdSegmentsLayerJoiner in 'w:\common\components\rtl\Garant\EVD\evdSegmentsLayerJoiner.pas'
 , k2DocumentBuffer in 'w:\common\components\rtl\Garant\K2\k2DocumentBuffer.pas'
 , evTextParaPartFilter in 'w:\common\components\gui\Garant\Everest\evTextParaPartFilter.pas'
 , nevRangeListTools in 'w:\common\components\gui\Garant\Everest\new\nevRangeListTools.pas'
 , evRangeTools in 'w:\common\components\gui\Garant\Everest\new\evRangeTools.pas'
 , evMultiSelectEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evMultiSelectEditorWindowHotSpot.pas'
 , evCustomMemoTextSource in 'w:\common\components\gui\Garant\Everest\evCustomMemoTextSource.pas'
 , evTextSource in 'w:\common\components\gui\Garant\Everest\evTextSource.pas'
 , evCustomMemoContainer in 'w:\common\components\gui\Garant\Everest\evCustomMemoContainer.pas'
 , nevPrintableDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPrintableDocumentContainer.pas'
 , nevPersistentDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevPersistentDocumentContainer.pas'
 , evDocumentContainerWithProcessor in 'w:\common\components\gui\Garant\Everest\new\evDocumentContainerWithProcessor.pas'
 , nevDocumentContainer in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainer.pas'
 , nevObjectHolderPrim in 'w:\common\components\gui\Garant\Everest\nevObjectHolderPrim.pas'
 , nevDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrim.pas'
 , nevDocumentContainerPrimPrim in 'w:\common\components\gui\Garant\Everest\nevDocumentContainerPrimPrim.pas'
 , DocumentContainer_Const in 'w:\common\components\gui\Garant\Everest\DocumentContainer_Const.pas'
 , nevFormatPool in 'w:\common\components\gui\Garant\Everest\new\nevFormatPool.pas'
 , nevFormatPoolBase in 'w:\common\components\gui\Garant\Everest\new\nevFormatPoolBase.pas'
 , nevRootFormatInfoListPrim in 'w:\common\components\gui\Garant\Everest\new\nevRootFormatInfoListPrim.pas'
 , nevRootFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevRootFormatInfo.pas'
 , m2MemLib in 'w:\common\components\rtl\Garant\L3\m2\m2MemLib.pas'
 , nevPrintingRootFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevPrintingRootFormatInfo.pas'
 , nevSectionBreakList in 'w:\common\components\gui\Garant\Everest\nevSectionBreakList.pas'
 , nevSectionBreakListPrim in 'w:\common\components\gui\Garant\Everest\nevSectionBreakListPrim.pas'
 , l3NotifyPtrList in 'w:\common\components\rtl\Garant\L3\l3NotifyPtrList.pas'
 , SectionBreak_Const in 'w:\common\components\rtl\Garant\EVD\SectionBreak_Const.pas'
 , nevWaiterList in 'w:\common\components\gui\Garant\Everest\new\nevWaiterList.pas'
 , evDocumentPreviewInfoList in 'w:\common\components\gui\Garant\Everest\new\evDocumentPreviewInfoList.pas'
 , k2InternalInterfaces in 'w:\common\components\rtl\Garant\K2\k2InternalInterfaces.pas'
 , nevInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevInterfaces.pas'
 , evDocumentsCache in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCache.pas'
 , evDocumentsCachePrim in 'w:\common\components\gui\Garant\Everest\new\evDocumentsCachePrim.pas'
 , l3DocumentsCacheService in 'w:\common\components\rtl\Garant\L3\l3DocumentsCacheService.pas'
 , nevDocumentContainerList in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerList.pas'
 , nevDocumentContainerListPrim in 'w:\common\components\gui\Garant\Everest\new\nevDocumentContainerListPrim.pas'
 , nevTextSourcePool in 'w:\common\components\gui\Garant\Everest\new\nevTextSourcePool.pas'
 , afwComplexDocumentPreviewFactory in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreviewFactory.pas'
 , afwComplexDocumentPreview in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwComplexDocumentPreview.pas'
 , afwPreviewNotifierPtrList in 'w:\common\components\gui\Garant\AFW\implementation\afwPreviewNotifierPtrList.pas'
 , evSubImplementation in 'w:\common\components\gui\Garant\Everest\new\evSubImplementation.pas'
 , evSubNode in 'w:\common\components\gui\Garant\Everest\new\evSubNode.pas'
 , evNode in 'w:\common\components\gui\Garant\Everest\new\evNode.pas'
 , l3NodesModelPart in 'w:\common\components\rtl\Garant\L3\l3NodesModelPart.pas'
 , l3DatLst in 'w:\common\components\rtl\Garant\L3\l3DatLst.pas'
 , l3NodesKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\l3NodesKeyWordsPack.pas'
 , l3Bits in 'w:\common\components\rtl\Garant\L3\l3Bits.pas'
 , InterfacedNodeWords in 'w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas'
 , Bookmark_Const in 'w:\common\components\rtl\Garant\EVD\Bookmark_Const.pas'
 , evDefaultContext in 'w:\common\components\gui\Garant\Everest\evDefaultContext.pas'
 , evCustomTxtReader in 'w:\common\components\gui\Garant\Everest\evCustomTxtReader.pas'
 , evTextFormatter in 'w:\common\components\gui\Garant\Everest\evTextFormatter.pas'
 , evCustomTextFormatter in 'w:\common\components\gui\Garant\Everest\evCustomTextFormatter.pas'
 , evCustomTextFormatterModelPart in 'w:\common\components\gui\Garant\Everest\evCustomTextFormatterModelPart.pas'
 , evdDocumentFilter in 'w:\common\components\rtl\Garant\EVD\evdDocumentFilter.pas'
 , evdPlainTextWriter in 'w:\common\components\rtl\Garant\EVD\evdPlainTextWriter.pas'
 , evdCustomPlainTextWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomPlainTextWriter.pas'
 , evMergedCellFilter in 'w:\common\components\gui\Garant\Everest\evMergedCellFilter.pas'
 , evCellsOffsets in 'w:\common\components\gui\Garant\Everest\evCellsOffsets.pas'
 , evEpsilonLongIntList in 'w:\common\components\gui\Garant\Everest\evEpsilonLongIntList.pas'
 , ShellAPI {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShellAPI.pas' {$EndIf}
 , evCustomWikiReader in 'w:\common\components\gui\Garant\Everest\evCustomWikiReader.pas'
 , evStyleTableTools in 'w:\common\components\gui\Garant\Everest\evStyleTableTools.pas'
 , evStyleHeaderAdder in 'w:\common\components\gui\Garant\Everest\evStyleHeaderAdder.pas'
 , evdNativeUnpackedWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeUnpackedWriter.pas'
 , evDocumentPreview in 'w:\common\components\gui\Garant\Everest\evDocumentPreview.pas'
 , evDocumentPreviewPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPreviewPrim.pas'
 , l3TimeEstimation in 'w:\common\components\rtl\Garant\L3\l3TimeEstimation.pas'
 , afwPreviewCanvas in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewCanvas.pas'
 , l3BaseWithLargeIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDList.pas'
 , l3BaseWithLargeIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDListPrim.pas'
 , evPreviewProcessor in 'w:\common\components\gui\Garant\Everest\evPreviewProcessor.pas'
 , evNotifiedProcessor in 'w:\common\components\gui\Garant\Everest\evNotifiedProcessor.pas'
 , evParaDrawTools in 'w:\common\components\gui\Garant\Everest\evParaDrawTools.pas'
 , nevDocumentProvider in 'w:\common\components\gui\Garant\Everest\nevDocumentProvider.pas'
 , evPreviewForTestsTuning in 'w:\common\components\gui\Garant\Everest\evPreviewForTestsTuning.pas'
 , PrintRowHeightsSpy in 'w:\common\components\gui\Garant\Everest\new\PrintRowHeightsSpy.pas'
 , afwCanvasEx in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCanvasEx.pas'
 , nevPrintView in 'w:\common\components\gui\Garant\Everest\new\nevPrintView.pas'
 , nevBaseDetachedView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDetachedView.pas'
 , l3Prg in 'w:\common\components\rtl\Garant\L3\l3Prg.pas'
 , evAbortFilter in 'w:\common\components\gui\Garant\Everest\evAbortFilter.pas'
 , evHiddenFilter in 'w:\common\components\gui\Garant\Everest\evHiddenFilter.pas'
 , evCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evCommentsEliminator.pas'
 , evdPageParamsFilter in 'w:\common\components\rtl\Garant\EVD\evdPageParamsFilter.pas'
 , evHAFPainterEx in 'w:\common\components\gui\Garant\Everest\evHAFPainterEx.pas'
 , evHAFPainter in 'w:\common\components\gui\Garant\Everest\evHAFPainter.pas'
 , evHAFPainterMacros in 'w:\common\components\gui\Garant\Everest\evHAFPainterMacros.pas'
 {$If Defined(k2ForEditor)}
 , evSBSPar in 'w:\common\components\gui\Garant\Everest\evSBSPar.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , nevHAFPainterView in 'w:\common\components\gui\Garant\Everest\new\nevHAFPainterView.pas'
 , nevVirtualDrawView in 'w:\common\components\gui\Garant\Everest\new\nevVirtualDrawView.pas'
 , nevObjectHolder in 'w:\common\components\gui\Garant\Everest\nevObjectHolder.pas'
 , evEditorWindowProcessor in 'w:\common\components\gui\Garant\Everest\evEditorWindowProcessor.pas'
 , evCustomEditorWindowProcessor in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowProcessor.pas'
 , evFormatHAFMacroReplacer in 'w:\common\components\gui\Garant\Everest\evFormatHAFMacroReplacer.pas'
 , evCustomHAFMacroReplacer in 'w:\common\components\gui\Garant\Everest\evCustomHAFMacroReplacer.pas'
 , evFixedHAFMacroReplacer in 'w:\common\components\gui\Garant\Everest\new\evFixedHAFMacroReplacer.pas'
 , nevDocumentProviderEx in 'w:\common\components\gui\Garant\Everest\nevDocumentProviderEx.pas'
 , evTagsListFilter in 'w:\common\components\gui\Garant\Everest\evTagsListFilter.pas'
 , evMemoProcessor in 'w:\common\components\gui\Garant\Everest\evMemoProcessor.pas'
 , SimpleDocument_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocument_Const.pas'
 , SimpleDocumentTextPara_Const in 'w:\common\components\gui\Garant\Everest\SimpleDocumentTextPara_Const.pas'
 , evMemoContextMenu in 'w:\common\components\gui\Garant\Everest\evMemoContextMenu.pas'
 , evCustomEditTextSource in 'w:\common\components\gui\Garant\Everest\evCustomEditTextSource.pas'
 , evEditDocumentContainer in 'w:\common\components\gui\Garant\Everest\evEditDocumentContainer.pas'
 , evCustomEditDocumentContainer in 'w:\common\components\gui\Garant\Everest\evCustomEditDocumentContainer.pas'
 , evEditProcessor in 'w:\common\components\gui\Garant\Everest\evEditProcessor.pas'
 , TinyDocument_Const in 'w:\common\components\gui\Garant\Everest\TinyDocument_Const.pas'
 , evConvertTextTools in 'w:\common\components\gui\Garant\Everest\evConvertTextTools.pas'
 {$If NOT Defined(NoVCL)}
 , Themes {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Themes.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , CustomElGraphicButton in 'w:\common\components\gui\Garant\Everest\CustomElGraphicButton.pas'
 , ctTypes in 'w:\common\components\gui\Garant\VT\ComboTree\ctTypes.pas'
 , ElUxTheme in 'w:\common\components\gui\Garant\VT\elClone\Source\ElUxTheme.pas'
 , l3ListenersManager in 'w:\common\components\rtl\Garant\L3\l3ListenersManager.pas'
 , l3WndProcListenersList in 'w:\common\components\rtl\Garant\L3\l3WndProcListenersList.pas'
 , l3CBTListenersList in 'w:\common\components\rtl\Garant\L3\l3CBTListenersList.pas'
 , l3GetMessageListenersList in 'w:\common\components\rtl\Garant\L3\l3GetMessageListenersList.pas'
 , l3WndProcRetListenersList in 'w:\common\components\rtl\Garant\L3\l3WndProcRetListenersList.pas'
 , l3MouseListenersList in 'w:\common\components\rtl\Garant\L3\l3MouseListenersList.pas'
 , l3MouseWheelListenersList in 'w:\common\components\rtl\Garant\L3\l3MouseWheelListenersList.pas'
 , l3ListenersHooks in 'w:\common\components\rtl\Garant\L3\l3ListenersHooks.pas'
 , ElPopBtn in 'w:\common\components\gui\Garant\Everest\ElPopBtn.pas'
 , ElVclUtils in 'w:\common\components\gui\Garant\Everest\ElVclUtils.pas'
 {$If NOT Defined(NoVCL)}
 , l3GetCaptureHelper in 'w:\common\components\rtl\Garant\L3\l3GetCaptureHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ControlsTypes in 'w:\common\components\rtl\Garant\L3\l3ControlsTypes.pas'
 , AbsSubTree in 'w:\common\components\gui\Garant\VT\ComboTree\AbsSubTree.pas'
 , vtOutlinerWithQuickSearch in 'w:\common\components\gui\Garant\VT\vtOutlinerWithQuickSearch.pas'
 , vtOutliner in 'w:\common\components\gui\Garant\VT\vtOutliner.pas'
 , vtLister in 'w:\common\components\gui\Garant\VT\vtLister.pas'
 , vtHeader in 'w:\common\components\gui\Garant\VT\vtHeader.pas'
 , afwInputControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInputControl.pas'
 , l3LogicalArray in 'w:\common\components\rtl\Garant\L3\l3LogicalArray.pas'
 , OvcColor in 'w:\common\components\rtl\external\Orpheus\OvcColor.pas'
 , OvcCmd in 'w:\common\components\rtl\external\Orpheus\OvcCmd.pas'
 , OvcConst in 'w:\common\components\rtl\external\Orpheus\OvcConst.pas'
 , OvcData in 'w:\common\components\rtl\external\Orpheus\OvcData.pas'
 , OvcExcpt in 'w:\common\components\rtl\external\Orpheus\OvcExcpt.pas'
 , vtStdRes in 'w:\common\components\gui\Garant\VT\vtStdRes.pas'
 , l3TabStops in 'w:\common\components\rtl\Garant\L3\l3TabStops.pas'
 , vtMultilineHint in 'w:\common\components\gui\Garant\VT\vtMultilineHint.pas'
 , vtHintManager in 'w:\common\components\gui\Garant\VT\vtHintManager.pas'
 {$If NOT Defined(NoVCL)}
 , vtHintWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3FontInfo in 'w:\common\components\rtl\Garant\L3\l3FontInfo.pas'
 {$If NOT Defined(NoVCL)}
 , ListerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , vtTreeSource in 'w:\common\components\gui\Garant\VT\vtTreeSource.pas'
 , l3Tree in 'w:\common\components\rtl\Garant\L3\l3Tree.pas'
 , l3ItemsStorage in 'w:\common\components\rtl\Garant\L3\l3ItemsStorage.pas'
 , l3TreeUtils in 'w:\common\components\rtl\Garant\L3\l3TreeUtils.pas'
 {$If NOT Defined(NoVCL)}
 , vtOutlinerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3SimpleTree in 'w:\common\components\rtl\Garant\L3\l3SimpleTree.pas'
 , ctFakeBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ctFakeBoxStrings.pas'
 , ComboBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ComboBoxStrings.pas'
 , ctComboBoxStringsItemNode in 'w:\common\components\gui\Garant\VT\ComboTree\ctComboBoxStringsItemNode.pas'
 , vtComboTreeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboTreeWordsPack.pas'
 {$If NOT Defined(NoVCL)}
 , ComCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , TreeNodeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeNodeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , TreeViewWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , TTreeNodeForTestsWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , FolderSupport in 'w:\common\components\rtl\external\DUnit\src\FolderSupport.pas'
 , TestForm4Scripts in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\TestForm4Scripts.pas'
 , DailyAutoTest in 'w:\common\components\rtl\Garant\DUnit_Script_Support\DailyAutoTest.pas'
 , AutoTest in 'w:\common\components\rtl\Garant\ScriptTestLibrary\AutoTest.pas'
 , CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas'
 {$If NOT Defined(NotTunedDUnit)}
 , vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
 {$If NOT Defined(NoVCM)}
 , SupportKeyWords in 'w:\common\components\rtl\Garant\Keywords4Daily\SupportKeyWords.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwLoadFromFile in 'w:\common\components\rtl\Garant\Keywords4Daily\kwLoadFromFile.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\PrimTextLoad_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityFormModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityFormModelPart.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserInteractiveForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Forms in 'w:\common\components\rtl\Garant\L3\l3Forms.pas'
 {$If NOT Defined(NoVCM)}
 , vcmGUI in 'w:\common\components\gui\Garant\VCM\vcmGUI.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
 , vcmDialogs in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDialogs.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
 , vcmMessageFormPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageFormPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_scene in 'w:\common\components\rtl\external\VGScene\vg_scene.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgScenePrim in 'w:\common\components\rtl\external\VGScene\vgScenePrim.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomControl in 'w:\common\components\rtl\external\VGScene\vgCustomControl.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgInterfaces in 'w:\common\components\rtl\external\VGScene\vgInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgTypes in 'w:\common\components\rtl\external\VGScene\vgTypes.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomObject in 'w:\common\components\rtl\external\VGScene\vgCustomObject.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgComponent in 'w:\common\components\rtl\external\VGScene\vgComponent.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomCanvas in 'w:\common\components\rtl\external\VGScene\vgCustomCanvas.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgPersistent in 'w:\common\components\rtl\external\VGScene\vgPersistent.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomResources in 'w:\common\components\rtl\external\VGScene\vgCustomResources.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomBitmap in 'w:\common\components\rtl\external\VGScene\vgCustomBitmap.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgInterfacedPersistent in 'w:\common\components\rtl\external\VGScene\vgInterfacedPersistent.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgObjectList in 'w:\common\components\rtl\external\VGScene\vgObjectList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgObject in 'w:\common\components\rtl\external\VGScene\vgObject.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgAnyObjectList in 'w:\common\components\rtl\external\VGScene\vgAnyObjectList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgSortableObjectList in 'w:\common\components\rtl\external\VGScene\vgSortableObjectList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgTypesPrim in 'w:\common\components\rtl\external\VGScene\vgTypesPrim.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomObjectList in 'w:\common\components\rtl\external\VGScene\vgCustomObjectList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgVisualObject in 'w:\common\components\rtl\external\VGScene\vgVisualObject.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgBounds in 'w:\common\components\rtl\external\VGScene\vgBounds.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgPosition in 'w:\common\components\rtl\external\VGScene\vgPosition.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , VGSceneWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGSceneWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , VGSceneAndWinControlPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGSceneAndWinControlPack.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_controls in 'w:\common\components\rtl\external\VGScene\vg_controls.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , VGComboBoxPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGComboBoxPack.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_listbox in 'w:\common\components\rtl\external\VGScene\vg_listbox.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_objects in 'w:\common\components\rtl\external\VGScene\vg_objects.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgSceneList in 'w:\common\components\rtl\external\VGScene\vgSceneList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgGradientPoint in 'w:\common\components\rtl\external\VGScene\vgGradientPoint.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgCustomGradientPoint in 'w:\common\components\rtl\external\VGScene\vgCustomGradientPoint.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgGradientPoints in 'w:\common\components\rtl\external\VGScene\vgGradientPoints.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgVisual in 'w:\common\components\rtl\external\VGScene\vgVisual.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_extctrls in 'w:\common\components\rtl\external\VGScene\vg_extctrls.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgVisualObjectList in 'w:\common\components\rtl\external\VGScene\vgVisualObjectList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_services in 'w:\common\components\rtl\external\VGScene\vg_services.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVCL)}
 , l3GetComponentFromPointHelper in 'w:\common\components\rtl\Garant\L3\l3GetComponentFromPointHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3FormatObjectInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatObjectInfoHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3FormatActionInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatActionInfoHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3HugeMessageDlgWithWikiHelper in 'w:\common\components\rtl\Garant\L3\l3HugeMessageDlgWithWikiHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3IterateComponentParents in 'w:\common\components\rtl\Garant\L3\l3IterateComponentParents.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3GetComponentBoundsHelper in 'w:\common\components\rtl\Garant\L3\l3GetComponentBoundsHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , vtDialogsResEx in 'w:\common\components\gui\Garant\VT\vtDialogsResEx.pas'
 , vtDialogsRes in 'w:\common\components\gui\Garant\VT\vtDialogsRes.pas'
 {$If NOT Defined(NoVGScene)}
 , vtVGButton in 'w:\common\components\gui\Garant\VT\vtVGButton.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vtVGSceneRes in 'w:\common\components\gui\Garant\VT\vtVGSceneRes.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 , vtF1InterfaceConst in 'w:\common\components\gui\Garant\VT\vtF1InterfaceConst.pas'
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessagesSupport.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMessagesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessageQueue in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueue.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessageQueuePrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueuePrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces in 'w:\common\components\gui\Garant\VCM\vcmInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormDispatcherInterfaces in 'w:\common\components\gui\Garant\VCM\vcmFormDispatcherInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls in 'w:\common\components\gui\Garant\VCM\vcmUserControls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseTypes in 'w:\common\components\gui\Garant\VCM\vcmBaseTypes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormItemList in 'w:\common\components\gui\Garant\VCM\vcmFormSetFormItemList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TabbedContainersDispatcher in 'w:\common\components\rtl\Garant\L3\l3TabbedContainersDispatcher.pas'
 {$If NOT Defined(NoVCM)}
 , vcmBase in 'w:\common\components\gui\Garant\VCM\implementation\vcmBase.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmStringIDExHelper in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringIDExHelper.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , l3CClassList in 'w:\common\components\rtl\Garant\L3\l3CClassList.pas'
 {$If NOT Defined(NoVCM)}
 , vcmMakeParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmMakeParams.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , l3VCLFormPtrList in 'w:\common\components\rtl\Garant\L3\l3VCLFormPtrList.pas'
 {$If NOT Defined(NoVCM)}
 , vcmBaseMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmBaseMenuManager.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationParams in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationParams.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmPrimCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmPrimCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationStates in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationStates.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmActiveControlsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmActiveControlsCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationState in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationState.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmAction.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(XE)}
 , Actions {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Actions.pas' {$EndIf}
 {$IfEnd} // Defined(XE)
 {$If NOT Defined(NoVCM)}
 , vcmInternalConst in 'w:\common\components\gui\Garant\VCM\implementation\vcmInternalConst.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModulesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModulesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationsCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationDefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmOperationDefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule in 'w:\common\components\gui\Garant\VCM\implementation\vcmModule.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation in 'w:\common\components\gui\Garant\VCM\implementation\vcmModuleContractImplementation.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmTargetedControlsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmTargetedControlsCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmRepositoryEx in 'w:\common\components\gui\Garant\VCM\implementation\vcmRepositoryEx.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntitiesCollectionItemEntity in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesCollectionItemEntity.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControlsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmControlsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseEntityDef in 'w:\common\components\gui\Garant\VCM\implementation\vcmBaseEntityDef.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationableIdentifiedUserFriendly in 'w:\common\components\gui\Garant\VCM\implementation\vcmOperationableIdentifiedUserFriendly.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleDef in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModuleDef.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOVCCommands in 'w:\common\components\gui\Garant\VCM\implementation\vcmOVCCommands.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmCommandIDsListPrim in 'w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsListPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmCommandIDsList in 'w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmModuleAction.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityAction.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmActiveControlsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmActiveControlsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationDef in 'w:\common\components\gui\Garant\VCM\implementation\vcmBaseOperationDef.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUtils in 'w:\common\components\gui\Garant\VCM\implementation\vcmUtils.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmRepOperationsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepOperationsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseEntities in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntities.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmComponent in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmComponent.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseEntitiesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntitiesDefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmEntitiesDefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntities.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmStringCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmStringCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModulesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmModulesCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWordEx in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWordEx.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWord in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWord.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmFormsCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMessagesCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmPopupMenuPrim in 'w:\common\components\gui\Garant\VCM\vcmPopupMenuPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(XE)}
 , ToolsAPI {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Toolsapi\ToolsAPI.pas' {$EndIf}
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , DesignIntf {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Toolsapi\DesignIntf.pas' {$EndIf}
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , DesignMenus {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Toolsapi\DesignMenus.pas' {$EndIf}
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(NoVCM)}
 , vcmMenuItemClickListenerList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuItemClickListenerList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenuManagerTypes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManagerTypes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenus in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenus.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmRepEntitiesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepEntitiesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtUtils in 'w:\common\components\gui\Garant\VT\vtUtils.pas'
 {$If NOT Defined(NoVCM)}
 , vcmBaseMenuManagerRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmBaseMenuManagerRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExportConst in 'w:\common\components\gui\Garant\VCM\implementation\vcmExportConst.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContentConst in 'w:\common\components\gui\Garant\VCM\implementation\vcmContentConst.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmRepEntitiesCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmRepEntitiesCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmSettings in 'w:\common\components\gui\Garant\VCM\implementation\vcmSettings.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainFormModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormModelPart.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmContainerForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerFormModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmContainerFormModelPart.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmAggregateRefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmAggregateRefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmIEntityList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainFormRes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmDockManagerList in 'w:\common\components\gui\Garant\VCM\implementation\vcmDockManagerList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmLockListenerList in 'w:\common\components\gui\Garant\VCM\implementation\vcmLockListenerList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormDispatcherListenerList in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormDispatcherListenerList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmDispatcher in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDispatcher.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmIEntityFormPtrList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormPtrList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenuManager in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManager.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoTB97)}
 , tb97vt in 'w:\common\components\rtl\external\tb97\tb97vt.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , TB97ExtInterfaces in 'w:\common\components\rtl\external\tb97\TB97ExtInterfaces.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 , evButton in 'w:\common\components\gui\Garant\Everest\evButton.pas'
 {$If NOT Defined(NoTB97)}
 , tb97Ctls in 'w:\common\components\rtl\external\tb97\tb97Ctls.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , tb97GraphicControl in 'w:\common\components\rtl\external\tb97\tb97GraphicControl.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , tb97WordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tb97WordsPack.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCM)}
 , vcmToolbarMenuRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmToolbarMenuRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenuItemsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMenuItemsCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserTypeDefList in 'w:\common\components\gui\Garant\VCM\implementation\vcmUserTypeDefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , IafwMenuUnlockedPostBuildPtrList in 'w:\common\components\gui\Garant\AFW\implementation\IafwMenuUnlockedPostBuildPtrList.pas'
 {$If NOT Defined(NoVCM)}
 , vcmToolbar in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmToolbar.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoTB97)}
 , TB97 in 'w:\common\components\rtl\external\tb97\TB97.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , tb97Control in 'w:\common\components\rtl\external\tb97\tb97Control.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 , afwCustomCommonControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControl.pas'
 , afwCustomCommonControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControlPrim.pas'
 {$If NOT Defined(NoTB97)}
 , TB97Tlbr in 'w:\common\components\rtl\external\tb97\TB97Tlbr.pas'
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces in 'w:\common\components\gui\Garant\VCM\implementation\vcmLocalInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControl in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmControl.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ToolWin {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ToolWin.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , afwDrawing in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwDrawing.pas'
 {$If NOT Defined(NoVCM)}
 , vcmToolbarUtils in 'w:\common\components\gui\Garant\VCM\vcmToolbarUtils.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmOperationAction.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtDblClickDateEdit in 'w:\common\components\gui\Garant\VT\vtDblClickDateEdit.pas'
 , vtDateEdit in 'w:\common\components\gui\Garant\VT\vtDateEdit.pas'
 , vtPanel in 'w:\common\components\gui\Garant\VT\vtPanel.pas'
 , afwTextControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControl.pas'
 , afwTextControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControlPrim.pas'
 {$If NOT Defined(NoVCL)}
 , Buttons {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Buttons.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , vtCalendarPanel in 'w:\common\components\gui\Garant\VT\vtCalendarPanel.pas'
 , vtDateEditRes in 'w:\common\components\gui\Garant\VT\vtDateEditRes.pas'
 , vtCombo in 'w:\common\components\gui\Garant\VT\vtCombo.pas'
 {$If NOT Defined(NoVCL)}
 , Mask {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Mask.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , vtForm in 'w:\common\components\gui\Garant\VT\vtForm.pas'
 , Spin {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Samples\Spin.pas' {$EndIf}
 , vtLabel in 'w:\common\components\gui\Garant\VT\vtLabel.pas'
 , l3GraphicControlCanvas in 'w:\common\components\rtl\Garant\L3\l3GraphicControlCanvas.pas'
 , MaskUtils {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\MaskUtils.pas' {$EndIf}
 , l3MenuManagerHelper in 'w:\common\components\rtl\Garant\L3\l3MenuManagerHelper.pas'
 {$If NOT Defined(NoVCM)}
 , vcmWinControlActionLink in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmWinControlActionLink.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntitiesDefIteratorForContextMenu in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesDefIteratorForContextMenu.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityDefForContextMenu in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntityDefForContextMenu.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationsDefIteratorForContextMenu in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationsDefIteratorForContextMenu.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenuManagerUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManagerUtils.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessages in 'w:\common\components\gui\Garant\VCM\implementation\vcmMessages.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormHandler in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormHandler.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenuManagerRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmMenuManagerRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMenuItemsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmMenuItemsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainMenuAction in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainMenuAction.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmChromeLikeTypes in 'w:\common\components\gui\Garant\VCM\vcmChromeLikeTypes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainMenuBuilder in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainMenuBuilder.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityDefList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityDefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleDefList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmModuleDefList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , VCMApllicationSettingsPack in 'w:\common\components\rtl\Garant\ScriptEngine\VCMApllicationSettingsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormsUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormsUtils.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmFormsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationsManager in 'w:\common\components\gui\Garant\VCM\vcmOperationsManager.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmCustomHelpers in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomHelpers.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwEntityOperation in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperation.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwEntityOperationPrim in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwEntityOperationTest in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwOperationsRegistrar in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationsRegistrar.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , VCMWordsPack in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmDispatcherLock in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLock.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes in 'StdRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmDispatcherUnlock in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlock.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmDispatcherBeginOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherBeginOp.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmDispatcherEndOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherEndOp.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryGetBackCount in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackCount.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryGetBackItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryGetForwardCount in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardCount.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryGetForwardItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpEnabled in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpEnabled.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwOperationParamWord in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWord.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwOperationParamWordPrim in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWordPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpVisible in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpVisible.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpChecked in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpChecked.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpDefault in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpDefault.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpCaption in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpCaption.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpHint in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpHint.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpImageIndex in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpImageIndex.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpShortcut in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpShortcut.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmOpLongHint in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpLongHint.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , RegisterVcmControls in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\RegisterVcmControls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigator in 'w:\common\components\gui\Garant\VT\vtNavigator.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , ElPgCtlConsts in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtlConsts.pas'
 , vtCustomCommonPanel in 'w:\common\components\gui\Garant\VT\vtCustomCommonPanel.pas'
 , ElPgCtl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtl.pas'
 , ElXPThemedControl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElXPThemedControl.pas'
 {$If NOT Defined(NoVCL)}
 , PageControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\PageControlWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MsgList in 'w:\common\components\rtl\Garant\L3\l3MsgList.pas'
 {$If NOT Defined(NoVCM)}
 , vtNavigatorFormList in 'w:\common\components\gui\Garant\VT\vtNavigatorFormList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigatorFormListPrim in 'w:\common\components\gui\Garant\VT\vtNavigatorFormListPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigatorFormListPrimPrim in 'w:\common\components\gui\Garant\VT\vtNavigatorFormListPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigatorForm in 'w:\common\components\gui\Garant\VT\vtNavigatorForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigatorRes in 'w:\common\components\gui\Garant\VT\vtNavigatorRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , npControlsList in 'w:\common\components\gui\Garant\VT\npControlsList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , npControlsListPrim in 'w:\common\components\gui\Garant\VT\npControlsListPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , npControls in 'w:\common\components\gui\Garant\VT\npControls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , npNavigatorList in 'w:\common\components\gui\Garant\VT\npNavigatorList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , npNavigatorListCBT in 'w:\common\components\gui\Garant\VT\npNavigatorListCBT.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , npNavigatorListPrim in 'w:\common\components\gui\Garant\VT\npNavigatorListPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigatorUtils in 'w:\common\components\gui\Garant\VT\vtNavigatorUtils.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , l3PopupControlService in 'w:\common\components\rtl\Garant\L3\l3PopupControlService.pas'
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineForm in 'w:\common\components\gui\Garant\VT\vgRemindersLineForm.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vtPopupForm in 'w:\common\components\gui\Garant\VT\vtPopupForm.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_layouts in 'w:\common\components\rtl\external\VGScene\vg_layouts.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVCM)}
 , vcmDockTree in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDockTree.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , l3DockTree in 'w:\common\components\rtl\Garant\L3\l3DockTree.pas'
 , NewRemindersInterfaces in 'w:\common\components\gui\Garant\VT\NewRemindersInterfaces.pas'
 {$If NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
 , ReminderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ReminderWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
 , vtPopupFormModelPart in 'w:\common\components\gui\Garant\VT\vtPopupFormModelPart.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLine in 'w:\common\components\gui\Garant\VT\vgRemindersLine.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 , afwDockingInterfaces in 'w:\common\components\gui\Garant\AFW\afwDockingInterfaces.pas'
 , vtPngImgList in 'w:\common\components\gui\Garant\VT\vtPngImgList.pas'
 , vtInterfaces in 'w:\common\components\gui\Garant\VT\vtInterfaces.pas'
 , vtPngImgListUtils in 'w:\common\components\gui\Garant\VT\vtPngImgListUtils.pas'
 {$If NOT Defined(NoImageEn)}
 , hyieutils in 'w:\common\components\rtl\external\ImageEn\src\hyieutils.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3ProcedureList in 'w:\common\components\rtl\Garant\L3\l3ProcedureList.pas'
 {$If NOT Defined(NoImageEn)}
 , hyiedefs in 'w:\common\components\rtl\external\ImageEn\src\hyiedefs.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoVGScene)}
 , vgReminderConsts in 'w:\common\components\gui\Garant\VT\vgReminderConsts.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgReminderWithAction in 'w:\common\components\gui\Garant\VT\vgReminderWithAction.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineManager in 'w:\common\components\gui\Garant\VT\vgRemindersLineManager.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineList in 'w:\common\components\gui\Garant\VT\vgRemindersLineList.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 , l3ByteList in 'w:\common\components\rtl\Garant\L3\l3ByteList.pas'
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineNotificationProxy in 'w:\common\components\gui\Garant\VT\vgRemindersLineNotificationProxy.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 , spHelpNotifyManager in 'w:\common\components\gui\Garant\AFW\spHelpNotifyManager.pas'
 , l3DwmApi in 'w:\common\components\rtl\Garant\L3\l3DwmApi.pas'
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineTabbedContainerNotificationProxy in 'w:\common\components\gui\Garant\VT\vgRemindersLineTabbedContainerNotificationProxy.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
 , RemindersLineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RemindersLineWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryDeleteBackItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteBackItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmFindForm in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmFindForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryClear in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryClear.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmHistoryDeleteForwardItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteForwardItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwTryFocusOnForm in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwTryFocusOnForm.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwObjectCreate in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwObjectCreate.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmDispatcherLockInOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLockInOp.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwVcmDispatcherUnlockInOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlockInOp.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtCheckBox in 'w:\common\components\gui\Garant\VT\vtCheckBox.pas'
 , eeCheckBox in 'w:\common\components\gui\Garant\VT\eeCheckBox.pas'
 , nscSimpleEditorForDialogs in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogs.pas'
 , nscSimpleEditor in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditor.pas'
 , nscSimpleEditorForDialogsTextSource in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsTextSource.pas'
 , nscSimpleEditorForDialogsContainer in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsContainer.pas'
 , vtFocusLabel in 'w:\common\components\gui\Garant\VT\vtFocusLabel.pas'
 , l3FormCanvas in 'w:\common\components\rtl\Garant\L3\l3FormCanvas.pas'
 {$If NOT Defined(NoVCM)}
 , vcmLayoutImplementation in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmLayoutImplementation.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers in 'w:\common\components\gui\Garant\VCM\vcmControllers.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , VCMFormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VCMFormsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmToolbarsInterfaces in 'w:\common\components\gui\Garant\VCM\vcmToolbarsInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserTypesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmUserTypesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBaseUserTypesCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseUserTypesCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserTypesCollectionItemPrim in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmUserTypesCollectionItemPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityFormImplementationModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityFormImplementationModelPart.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControlList in 'w:\common\components\gui\Garant\VCM\implementation\vcmControlList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , evLoadDocumentManager in 'w:\common\components\gui\Garant\Everest\ext\evLoadDocumentManager.pas'
 {$If NOT Defined(NoVCM)}
 , kwSetFontSize in 'w:\common\components\rtl\Garant\Keywords4Daily\kwSetFontSize.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , kwGetFontSize in 'w:\common\components\rtl\Garant\Keywords4Daily\kwGetFontSize.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , ItsLAW in 'w:\common\components\DailyTest\ItsLAW.pas'
 , Archi2 in 'w:\common\components\DailyTest\Archi2.pas'
 , toK64 in 'w:\common\components\DailyTest\toK64.pas'
 , toKT in 'w:\common\components\DailyTest\toKT.pas'
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_TestLibrary in 'w:\common\components\gui\Garant\Daily\TestFormsTest_TestLibrary.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_Everest_TestUnit in 'w:\common\components\gui\Garant\Daily\TestFormsTest_Everest_TestUnit.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , K204114253 in 'w:\common\components\gui\Garant\Daily\K204114253.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoVCM)}
 , VCMBaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\VCMBaseTest.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , elCustomEdit_Form in 'w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , elCustomEdit_ut_elCustomEdit_UserType in 'w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_ut_elCustomEdit_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , elCustomEditKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\elCustomEditKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 , tfwControlString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwControlString.pas'
 , evdSchema in 'w:\common\components\gui\Garant\Everest\evdSchema.pas'
 , evNative_Schema in 'w:\common\components\gui\Garant\Everest\evNative_Schema.pas'
 , evdNative_Schema in 'w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas'
 , evdTasks_Schema in 'w:\common\components\rtl\Garant\EVD\evdTasks_Schema.pas'
 , k2Native_Schema in 'w:\common\components\rtl\Garant\K2\k2Native_Schema.pas'
 , k2Core_Schema in 'w:\common\components\rtl\Garant\K2\k2Core_Schema.pas'
 , ddTaskItemPrim in 'w:\common\components\rtl\Garant\EVD\ddTaskItemPrim.pas'
 , evdTaskTypes in 'w:\common\components\rtl\Garant\EVD\evdTaskTypes.pas'
 , csTaskListening in 'w:\common\components\rtl\Garant\EVD\csTaskListening.pas'
 , Task_Const in 'w:\common\components\rtl\Garant\EVD\Task_Const.pas'
 , DateTimeNotNull_Const in 'w:\common\components\rtl\Garant\EVD\DateTimeNotNull_Const.pas'
 , DateTime_Const in 'w:\common\components\rtl\Garant\EVD\DateTime_Const.pas'
 , ULong_Const in 'w:\common\components\rtl\Garant\EVD\ULong_Const.pas'
 , evdNative_AttrValues in 'w:\common\components\rtl\Garant\EVD\evdNative_AttrValues.pas'
 , evNative_AttrValues in 'w:\common\components\gui\Garant\Everest\evNative_AttrValues.pas'
 {$If Defined(Archi)}
 , evArchi_Schema in 'w:\common\components\gui\Garant\Everest\evArchi_Schema.pas'
 {$IfEnd} // Defined(Archi)
 , Everest_Schema in 'w:\common\components\gui\Garant\Everest\Everest_Schema.pas'
 {$If Defined(evMyEditor)}
 , My_Schema in 'w:\common\components\gui\Garant\Everest\My_Schema.pas'
 {$IfEnd} // Defined(evMyEditor)
 {$If Defined(DesignTimeLibrary)}
 , Design_Schema in 'w:\common\components\gui\Garant\Everest\Design_Schema.pas'
 {$IfEnd} // Defined(DesignTimeLibrary)
 , Design_AttrValues in 'w:\common\components\gui\Garant\Everest\Design_AttrValues.pas'
 {$If NOT Defined(NoVCM)}
 , TextLoad in 'w:\common\components\gui\Garant\Daily\TextLoad.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessorPrim in 'w:\common\components\gui\Garant\Daily\TextViaEditorProcessorPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\TextLoad_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , evEditor in 'w:\common\components\gui\Garant\Everest\evEditor.pas'
 , evTunedEditor in 'w:\common\components\gui\Garant\Everest\evTunedEditor.pas'
 {$If NOT Defined(NoVCM)}
 , TextLoad_ut_TextLoad_UserType in 'w:\common\components\gui\Garant\Daily\Forms\TextLoad_ut_TextLoad_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , TextLoadKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\TextLoadKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , F1LikeTextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , eeEditorExport in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExport.pas'
 , eeEditorExportModelPart in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExportModelPart.pas'
 , eeInterfaces in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas'
 , eeConst in 'w:\common\components\gui\Garant\Everest_Engine\eeConst.pas'
 , eeInterfacesEx in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfacesEx.pas'
 {$If Defined(Nemesis)}
 , eeDocumentTool in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentTool.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeHotSpot in 'w:\common\components\gui\Garant\Everest_Engine\eeHotSpot.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeTagEditorTool in 'w:\common\components\gui\Garant\Everest_Engine\eeTagEditorTool.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eePara in 'w:\common\components\gui\Garant\Everest_Engine\eePara.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeSubList in 'w:\common\components\gui\Garant\Everest_Engine\eeSubList.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(evNeedDisp)}
 , evStandardActions in 'w:\common\components\gui\Garant\Everest\evStandardActions.pas'
 {$IfEnd} // Defined(evNeedDisp)
 {$If Defined(Nemesis)}
 , eeSub in 'w:\common\components\gui\Garant\Everest_Engine\eeSub.pas'
 {$IfEnd} // Defined(Nemesis)
 , vtScrollBar in 'w:\common\components\gui\Garant\VT\vtScrollBar.pas'
 , eeExceptions in 'w:\common\components\gui\Garant\Everest_Engine\eeExceptions.pas'
 {$If Defined(Nemesis)}
 , eeTextSourceExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSourceExport.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , F1LikeTextLoad_ut_F1LikeTextLoad_UserType in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_ut_F1LikeTextLoad_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , F1LikeTextLoadKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoadKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , QFLikeTextLoad_Form in 'w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , evQueryCardEditor in 'w:\common\components\gui\Garant\Everest\evQueryCardEditor.pas'
 , evQueryCardEditorHotSpot in 'w:\common\components\gui\Garant\Everest\evQueryCardEditorHotSpot.pas'
 , evQueryCardSelection in 'w:\common\components\gui\Garant\Everest\evQueryCardSelection.pas'
 , QueryCardProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas'
 , kwPopQueryCardAttributeSetWithLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetWithLogicOperation.pas'
 , kwQueryCardFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwQueryCardFromStackWord.pas'
 , evReqIterator in 'w:\common\components\gui\Garant\Everest\evReqIterator.pas'
 , kwPopQueryCardSetAttribute in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardSetAttribute.pas'
 , kwPopQueryCardAttributeSetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetCollapsed.pas'
 , kwPopQueryCardAttributeSetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetFocus.pas'
 , kwPopQueryCardAttributeGetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetFocus.pas'
 , kwPopQueryCardAttributeGetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetCollapsed.pas'
 , kwPopQueryCardAttributeGetLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetLogicOperation.pas'
 , kwPopQueryCardAttributeIsLogicOperationEnabled in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeIsLogicOperationEnabled.pas'
 , kwPopQueryCardGetCurrentReqName in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardGetCurrentReqName.pas'
 , evQueryDocumentContainer in 'w:\common\components\gui\Garant\Everest\qf\evQueryDocumentContainer.pas'
 , evQueryCardProcessor in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardProcessor.pas'
 , evControlGenerator in 'w:\common\components\gui\Garant\Everest\qf\evControlGenerator.pas'
 , evControlContainerEX in 'w:\common\components\gui\Garant\Everest\qf\evControlContainerEX.pas'
 , evControlContainer in 'w:\common\components\gui\Garant\Everest\qf\evControlContainer.pas'
 , evCustomControlTool in 'w:\common\components\gui\Garant\Everest\qf\evCustomControlTool.pas'
 , evQueryGroupList in 'w:\common\components\gui\Garant\Everest\qf\evQueryGroupList.pas'
 , evControlParaTools in 'w:\common\components\gui\Garant\Everest\qf\evControlParaTools.pas'
 , evQueryCardConst in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardConst.pas'
 , evControlGroup in 'w:\common\components\gui\Garant\Everest\qf\evControlGroup.pas'
 , evReqList in 'w:\common\components\gui\Garant\Everest\qf\evReqList.pas'
 , evDescriptionReqList in 'w:\common\components\gui\Garant\Everest\qf\evDescriptionReqList.pas'
 , evReq in 'w:\common\components\gui\Garant\Everest\qf\evReq.pas'
 , evEditorControlFieldList in 'w:\common\components\gui\Garant\Everest\qf\evEditorControlFieldList.pas'
 , evEditorControlList in 'w:\common\components\gui\Garant\Everest\qf\evEditorControlList.pas'
 , evControl in 'w:\common\components\gui\Garant\Everest\qf\evControl.pas'
 , evButtonControl in 'w:\common\components\gui\Garant\Everest\qf\evButtonControl.pas'
 , evQueryCardDropControlsInt in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardDropControlsInt.pas'
 , evDropCalendarControl in 'w:\common\components\gui\Garant\Everest\qf\evDropCalendarControl.pas'
 , evDropControl in 'w:\common\components\gui\Garant\Everest\qf\evDropControl.pas'
 , evEditControl in 'w:\common\components\gui\Garant\Everest\qf\evEditControl.pas'
 , evDropCombo in 'w:\common\components\gui\Garant\Everest\qf\evDropCombo.pas'
 , evLabel in 'w:\common\components\gui\Garant\Everest\qf\evLabel.pas'
 , evSimpleEdit in 'w:\common\components\gui\Garant\Everest\qf\evSimpleEdit.pas'
 , evMemoEdit in 'w:\common\components\gui\Garant\Everest\qf\evMemoEdit.pas'
 , evEmailEdit in 'w:\common\components\gui\Garant\Everest\qf\evEmailEdit.pas'
 , evPhoneEdit in 'w:\common\components\gui\Garant\Everest\qf\evPhoneEdit.pas'
 {$If Defined(k2ForEditor)}
 , evReqRowImplementation in 'w:\common\components\gui\Garant\Everest\evReqRowImplementation.pas'
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evTableImplementation in 'w:\common\components\gui\Garant\Everest\evTableImplementation.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , evDescriptionReq in 'w:\common\components\gui\Garant\Everest\qf\evDescriptionReq.pas'
 , evDropCalendar in 'w:\common\components\gui\Garant\Everest\qf\evDropCalendar.pas'
 , evDropTree in 'w:\common\components\gui\Garant\Everest\qf\evDropTree.pas'
 {$If NOT Defined(NoVCM)}
 , QFLikeTextLoad_ut_QFLikeTextLoad_UserType in 'w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_ut_QFLikeTextLoad_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , QFLikeTextLoadKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoadKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , F1LikeFormWithBS_Form in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations in 'w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistoryAndOperations.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistory in 'w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistory.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscCustomTreeComboWithHistory in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistory.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscCustomTreeComboWithHistoryRes in 'w:\common\components\gui\Garant\Nemesis\nscCustomTreeComboWithHistoryRes.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscNewInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscNewInterfaces.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscConst in 'w:\common\components\gui\Garant\Nemesis\nscConst.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , F1LikeFormWithBSKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBSKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 , ddSectionRepair in 'w:\common\components\rtl\Garant\dd\ddSectionRepair.pas'
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_OutlinerTests_TestUnit in 'w:\common\components\gui\Garant\Daily\TestFormsTest_OutlinerTests_TestUnit.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_EmptyFormTests_TestUnit in 'w:\common\components\gui\Garant\Daily\TestFormsTest_EmptyFormTests_TestUnit.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , ScriptTestLibrary_TestLibrary in 'w:\common\components\rtl\Garant\ScriptTestLibrary\ScriptTestLibrary_TestLibrary.pas'
 , ScriptTestLibrary_ScriptTestUnit_TestUnit in 'w:\common\components\rtl\Garant\ScriptTestLibrary\ScriptTestLibrary_ScriptTestUnit_TestUnit.pas'
 , Containers_TestLibrary in 'w:\common\components\rtl\Garant\Containers\Containers_TestLibrary.pas'
 , Containers_Lists_TestUnit in 'w:\common\components\rtl\Garant\Containers\Containers_Lists_TestUnit.pas'
 , LongintListTest in 'w:\common\components\rtl\Garant\Containers\LongintListTest.pas'
 , DailyTest_TestLibrary in 'w:\common\components\rtl\Garant\Daily\DailyTest_TestLibrary.pas'
 , DailyTest_Core_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_Core_TestUnit.pas'
 , TestMMX in 'w:\common\components\rtl\Garant\Daily\TestMMX.pas'
 , TestFilerReadLn in 'w:\common\components\rtl\Garant\Daily\TestFilerReadLn.pas'
 , TestGlobals in 'w:\common\components\rtl\Garant\Daily\TestGlobals.pas'
 , TestFilerCopyViaReadLn in 'w:\common\components\rtl\Garant\Daily\TestFilerCopyViaReadLn.pas'
 , DailyTest_Write_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_Write_TestUnit.pas'
 , DailyTest_RTF_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_RTF_TestUnit.pas'
 , DailyTest_EVD_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_EVD_TestUnit.pas'
 , DailyTest_NSRCTests_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_NSRCTests_TestUnit.pas'
 , StyleCtoStyleJTest in 'w:\common\components\rtl\Garant\Daily\StyleCtoStyleJTest.pas'
 , NSRCWriterTest in 'w:\common\components\rtl\Garant\Daily\NSRCWriterTest.pas'
 , WriterTest in 'w:\common\components\rtl\Garant\Daily\WriterTest.pas'
 , tstNSRCGenerator in 'w:\common\components\rtl\Garant\Daily\tstNSRCGenerator.pas'
 , ddNSRCGenerator in 'w:\common\components\rtl\Garant\EVD\ddNSRCGenerator.pas'
 , evdNSRCReader in 'w:\common\components\gui\Garant\EverestCommon\evdNSRCReader.pas'
 , ddNSRC_r in 'w:\common\components\rtl\Garant\dd\ddNSRC_r.pas'
 , dt_AttrSchema in 'w:\common\components\rtl\Garant\dd\dt_AttrSchema.pas'
 , dt_Types in 'w:\common\components\rtl\Garant\dd\dt_Types.pas'
 , l3MarshalledTypes in 'w:\common\components\rtl\Garant\L3\l3MarshalledTypes.pas'
 , evdDTTypes in 'w:\common\components\rtl\Garant\EVD\evdDTTypes.pas'
 , ddNSRCSegments in 'w:\common\components\rtl\Garant\dd\ddNSRCSegments.pas'
 , segTargetList in 'w:\common\components\rtl\Garant\dd\segTargetList.pas'
 , segTarget in 'w:\common\components\rtl\Garant\dd\segTarget.pas'
 , ddSegmentScanner in 'w:\common\components\rtl\Garant\dd\ddSegmentScanner.pas'
 , ddNSRCStackItemList in 'w:\common\components\rtl\Garant\dd\ddNSRCStackItemList.pas'
 , segObjectList in 'w:\common\components\rtl\Garant\dd\segObjectList.pas'
 , segHyperLinkList in 'w:\common\components\rtl\Garant\dd\segHyperLinkList.pas'
 , segSegList in 'w:\common\components\rtl\Garant\dd\segSegList.pas'
 , evNSRCConst in 'w:\common\components\rtl\Garant\dd\evNSRCConst.pas'
 , ddNSRCSub in 'w:\common\components\rtl\Garant\dd\ddNSRCSub.pas'
 , ddNSRCSubList in 'w:\common\components\rtl\Garant\dd\ddNSRCSubList.pas'
 , ddNSRCConst in 'w:\common\components\rtl\Garant\dd\ddNSRCConst.pas'
 , ddTk2TypeList in 'w:\common\components\rtl\Garant\dd\ddTk2TypeList.pas'
 , ddDoc2DocLinkRecList in 'w:\common\components\rtl\Garant\dd\ddDoc2DocLinkRecList.pas'
 , evSimpleTextPainter in 'w:\common\components\gui\Garant\Everest\evSimpleTextPainter.pas'
 , evNSRCPlusWriter in 'w:\common\components\gui\Garant\Everest\evNSRCPlusWriter.pas'
 , evCustomNSRCWriter in 'w:\common\components\gui\Garant\Everest\evCustomNSRCWriter.pas'
 , evCustomTextPainter in 'w:\common\components\gui\Garant\Everest\evCustomTextPainter.pas'
 , evNSRWrt in 'w:\common\components\gui\Garant\Everest\evNSRWrt.pas'
 , evNSRCWriterTypes in 'w:\common\components\gui\Garant\Everest\evNSRCWriterTypes.pas'
 , evEmptyTableEliminator in 'w:\common\components\gui\Garant\EverestCommon\evEmptyTableEliminator.pas'
 , K177964264 in 'w:\common\components\rtl\Garant\Daily\K177964264.pas'
 , EVDtoNSRCOldWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoNSRCOldWriterTest.pas'
 , EVDtoNSRCWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoNSRCWriterTest.pas'
 , K177964498 in 'w:\common\components\rtl\Garant\Daily\K177964498.pas'
 , EVDtoNSRCPlusWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoNSRCPlusWriterTest.pas'
 , K180060897 in 'w:\common\components\rtl\Garant\Daily\K180060897.pas'
 , K177963362 in 'w:\common\components\rtl\Garant\Daily\K177963362.pas'
 , K177963873 in 'w:\common\components\rtl\Garant\Daily\K177963873.pas'
 , EVDtoBothNSRCWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoBothNSRCWriterTest.pas'
 , K164596048 in 'w:\common\components\rtl\Garant\Daily\K164596048.pas'
 , K177964278 in 'w:\common\components\rtl\Garant\Daily\K177964278.pas'
 , K177964664 in 'w:\common\components\rtl\Garant\Daily\K177964664.pas'
 , NSRCtoMemoryTest in 'w:\common\components\rtl\Garant\Daily\NSRCtoMemoryTest.pas'
 , K211878862 in 'w:\common\components\rtl\Garant\Daily\K211878862.pas'
 , K412987699 in 'w:\common\components\rtl\Garant\Daily\K412987699.pas'
 , NSRCtoEVDTest in 'w:\common\components\rtl\Garant\Daily\NSRCtoEVDTest.pas'
 , K415728258 in 'w:\common\components\rtl\Garant\Daily\K415728258.pas'
 , K404357586 in 'w:\common\components\rtl\Garant\Daily\K404357586.pas'
 , K446824679 in 'w:\common\components\rtl\Garant\Daily\K446824679.pas'
 , K565842263 in 'w:\common\components\rtl\Garant\Daily\K565842263.pas'
 , K565862557 in 'w:\common\components\rtl\Garant\Daily\K565862557.pas'
 , DailyTest_EditorTests_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_EditorTests_TestUnit.pas'
 , DailyTest_GZip_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_GZip_TestUnit.pas'
 , GZipUnzipTest in 'w:\common\components\rtl\Garant\Daily\GZipUnzipTest.pas'
 , l3GZipStream in 'w:\common\components\rtl\Garant\L3\l3GZipStream.pas'
 , DailyTest_7_6_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_6_TestUnit.pas'
 , K165514106 in 'w:\common\components\rtl\Garant\Daily\K165514106.pas'
 {$If NOT Defined(NoVCM)}
 , TwoEmptyParaForOneReplacerTest in 'w:\common\components\gui\Garant\Daily\TwoEmptyParaForOneReplacerTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , SearchAndReplacePrimTest in 'w:\common\components\gui\Garant\Daily\SearchAndReplacePrimTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor in 'w:\common\components\gui\Garant\Daily\TextViaEditorProcessor.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor in 'w:\common\components\gui\Garant\Daily\TextEditorVisitor.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitorPrim in 'w:\common\components\gui\Garant\Daily\TextEditorVisitorPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K219122895 in 'w:\common\components\rtl\Garant\Daily\K219122895.pas'
 , EVDtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDWriterTest.pas'
 , EVDWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDWriterTest.pas'
 , ddMisspellCorrect in 'w:\common\components\rtl\Garant\dd\ddMisspellCorrect.pas'
 , K165512428 in 'w:\common\components\rtl\Garant\Daily\K165512428.pas'
 , K221250480 in 'w:\common\components\rtl\Garant\Daily\K221250480.pas'
 {$If NOT Defined(NoVCM)}
 , ScrollTest in 'w:\common\components\gui\Garant\Daily\ScrollTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimScrollTest in 'w:\common\components\gui\Garant\Daily\PrimScrollTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K217678457 in 'w:\common\components\rtl\Garant\Daily\K217678457.pas'
 , EVDtoEVDSectionRepairTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDSectionRepairTest.pas'
 , ddSectionWithSub2Para in 'w:\common\components\rtl\Garant\dd\ddSectionWithSub2Para.pas'
 , K221251978 in 'w:\common\components\rtl\Garant\Daily\K221251978.pas'
 , K222757750 in 'w:\common\components\rtl\Garant\Daily\K222757750.pas'
 , K223608965 in 'w:\common\components\rtl\Garant\Daily\K223608965.pas'
 , K224134476 in 'w:\common\components\rtl\Garant\Daily\K224134476.pas'
 {$If NOT Defined(NoVCM)}
 , ComplexScrollByLines in 'w:\common\components\gui\Garant\Daily\ComplexScrollByLines.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K224133899 in 'w:\common\components\rtl\Garant\Daily\K224133899.pas'
 , Translate2TextTest in 'w:\common\components\rtl\Garant\Daily\Translate2TextTest.pas'
 , TableToolsTest in 'w:\common\components\rtl\Garant\Daily\TableToolsTest.pas'
 {$If NOT Defined(NoVCM)}
 , TableToolsTestPrim in 'w:\common\components\gui\Garant\Daily\TableToolsTestPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K224135562 in 'w:\common\components\rtl\Garant\Daily\K224135562.pas'
 , K224788868 in 'w:\common\components\rtl\Garant\Daily\K224788868.pas'
 {$If NOT Defined(NoVCM)}
 , SearchAndReplaceTest in 'w:\common\components\gui\Garant\Daily\SearchAndReplaceTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K200902351 in 'w:\common\components\rtl\Garant\Daily\K200902351.pas'
 {$If NOT Defined(NoVCM)}
 , TableSelectTest in 'w:\common\components\gui\Garant\Daily\TableSelectTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K224791621 in 'w:\common\components\rtl\Garant\Daily\K224791621.pas'
 , MergeTablesTest in 'w:\common\components\rtl\Garant\Daily\MergeTablesTest.pas'
 , K226001213 in 'w:\common\components\rtl\Garant\Daily\K226001213.pas'
 , ColumnAlignHorisontallyTest in 'w:\common\components\rtl\Garant\Daily\ColumnAlignHorisontallyTest.pas'
 , K226001269 in 'w:\common\components\rtl\Garant\Daily\K226001269.pas'
 {$If NOT Defined(NoVCM)}
 , TwoSpaceForOneReplacerTest in 'w:\common\components\gui\Garant\Daily\TwoSpaceForOneReplacerTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K226002079 in 'w:\common\components\rtl\Garant\Daily\K226002079.pas'
 , CheckTopAnchorTest in 'w:\common\components\rtl\Garant\Daily\CheckTopAnchorTest.pas'
 , ScrollAndSelectPtTest in 'w:\common\components\rtl\Garant\Daily\ScrollAndSelectPtTest.pas'
 , SelectPtTest in 'w:\common\components\rtl\Garant\Daily\SelectPtTest.pas'
 , K226005005 in 'w:\common\components\rtl\Garant\Daily\K226005005.pas'
 , EVDtoEVDOEMTableFlagTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDOEMTableFlagTest.pas'
 , evOEMTableFlagFilter in 'w:\common\components\gui\Garant\EverestCommon\evOEMTableFlagFilter.pas'
 , K226005021 in 'w:\common\components\rtl\Garant\Daily\K226005021.pas'
 {$If NOT Defined(NoVCM)}
 , OldNSRCFlagCnahge in 'w:\common\components\gui\Garant\Daily\OldNSRCFlagCnahge.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , ChangeAllTablesTest in 'w:\common\components\gui\Garant\Daily\ChangeAllTablesTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K227477159 in 'w:\common\components\rtl\Garant\Daily\K227477159.pas'
 {$If NOT Defined(NoVCM)}
 , ScrollBackByLineTest in 'w:\common\components\gui\Garant\Daily\ScrollBackByLineTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K227478617 in 'w:\common\components\rtl\Garant\Daily\K227478617.pas'
 , DeleteCharTest in 'w:\common\components\rtl\Garant\Daily\DeleteCharTest.pas'
 , TextViaEditorProcessorWithNavigate in 'w:\common\components\rtl\Garant\Daily\TextViaEditorProcessorWithNavigate.pas'
 , K227477421 in 'w:\common\components\rtl\Garant\Daily\K227477421.pas'
 {$If NOT Defined(NoVCM)}
 , ScrollBackByLineWithCheckTopAnchoTest in 'w:\common\components\gui\Garant\Daily\ScrollBackByLineWithCheckTopAnchoTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K227478018 in 'w:\common\components\rtl\Garant\Daily\K227478018.pas'
 {$If NOT Defined(NoVCM)}
 , DrawLineTest in 'w:\common\components\gui\Garant\Daily\DrawLineTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K227972911 in 'w:\common\components\rtl\Garant\Daily\K227972911.pas'
 , MergeCellsTest in 'w:\common\components\rtl\Garant\Daily\MergeCellsTest.pas'
 , K228691360 in 'w:\common\components\rtl\Garant\Daily\K228691360.pas'
 , InsertStreamTest in 'w:\common\components\rtl\Garant\Daily\InsertStreamTest.pas'
 , K228692531 in 'w:\common\components\rtl\Garant\Daily\K228692531.pas'
 , K228692538 in 'w:\common\components\rtl\Garant\Daily\K228692538.pas'
 , K228692711 in 'w:\common\components\rtl\Garant\Daily\K228692711.pas'
 , K228693150 in 'w:\common\components\rtl\Garant\Daily\K228693150.pas'
 , K229213001 in 'w:\common\components\rtl\Garant\Daily\K229213001.pas'
 , K228693052 in 'w:\common\components\rtl\Garant\Daily\K228693052.pas'
 , K228692043 in 'w:\common\components\rtl\Garant\Daily\K228692043.pas'
 , evUnblockEmptyParaFilter in 'w:\common\components\gui\Garant\EverestCommon\evUnblockEmptyParaFilter.pas'
 , K228689782 in 'w:\common\components\rtl\Garant\Daily\K228689782.pas'
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore235875079 in 'w:\common\components\gui\Garant\Daily\PreviewTestBefore235875079.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPreviewPanel in 'w:\common\components\gui\Garant\VT\vtPreviewPanel.pas'
 , vtCustomPreviewPanel in 'w:\common\components\gui\Garant\VT\vtCustomPreviewPanel.pas'
 , K228688660 in 'w:\common\components\rtl\Garant\Daily\K228688660.pas'
 , K232097143 in 'w:\common\components\rtl\Garant\Daily\K232097143.pas'
 , K224133855 in 'w:\common\components\rtl\Garant\Daily\K224133855.pas'
 , K232099823 in 'w:\common\components\rtl\Garant\Daily\K232099823.pas'
 , K233014754 in 'w:\common\components\rtl\Garant\Daily\K233014754.pas'
 , K233015524 in 'w:\common\components\rtl\Garant\Daily\K233015524.pas'
 , SplitTableTest in 'w:\common\components\rtl\Garant\Daily\SplitTableTest.pas'
 , K226006206 in 'w:\common\components\rtl\Garant\Daily\K226006206.pas'
 , K233019435 in 'w:\common\components\rtl\Garant\Daily\K233019435.pas'
 , K233014742 in 'w:\common\components\rtl\Garant\Daily\K233014742.pas'
 , GZipTest in 'w:\common\components\rtl\Garant\Daily\GZipTest.pas'
 , K226001945 in 'w:\common\components\rtl\Garant\Daily\K226001945.pas'
 , EVDtoRTFWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoRTFWriterTest.pas'
 , RTFWriterTest in 'w:\common\components\rtl\Garant\Daily\RTFWriterTest.pas'
 , ddRTFWriter in 'w:\common\components\rtl\Garant\dd\ddRTFWriter.pas'
 , ddRTFExpandedTextWriter in 'w:\common\components\rtl\Garant\dd\ddRTFExpandedTextWriter.pas'
 , ddRTFSegmentWriter in 'w:\common\components\rtl\Garant\dd\ddRTFSegmentWriter.pas'
 , ddDocument in 'w:\common\components\rtl\Garant\dd\ddDocument.pas'
 , evdAllParaEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllParaEliminator.pas'
 , ddTextSegmentQueue in 'w:\common\components\rtl\Garant\dd\ddTextSegmentQueue.pas'
 , ddTextSegmentsList in 'w:\common\components\rtl\Garant\dd\ddTextSegmentsList.pas'
 , ddTextSegment in 'w:\common\components\rtl\Garant\dd\ddTextSegment.pas'
 , ddCharacterProperty in 'w:\common\components\rtl\Garant\dd\ddCharacterProperty.pas'
 , ddDocumentAtom in 'w:\common\components\rtl\Garant\dd\ddDocumentAtom.pas'
 , ddCustomDestination in 'w:\common\components\rtl\Garant\dd\ddCustomDestination.pas'
 , ddRTFProperties in 'w:\common\components\rtl\Garant\dd\ddRTFProperties.pas'
 , RTFtypes in 'w:\common\components\rtl\Garant\dd\RTFtypes.pas'
 , rtfListTable in 'w:\common\components\rtl\Garant\dd\rtfListTable.pas'
 , ddTypes in 'w:\common\components\rtl\Garant\dd\ddTypes.pas'
 , ddHyperlinkTarget in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTarget.pas'
 , ddBaseObject in 'w:\common\components\rtl\Garant\dd\ddBaseObject.pas'
 , ddEVDTypesSupport in 'w:\common\components\rtl\Garant\dd\ddEVDTypesSupport.pas'
 , ddHyperlinkTargetList in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTargetList.pas'
 , ddHyperlink in 'w:\common\components\rtl\Garant\dd\ddHyperlink.pas'
 , ddTextParagraph in 'w:\common\components\rtl\Garant\dd\ddTextParagraph.pas'
 , ddParagraphProperty in 'w:\common\components\rtl\Garant\dd\ddParagraphProperty.pas'
 , ddSubsList in 'w:\common\components\rtl\Garant\dd\ddSubsList.pas'
 , ddSub in 'w:\common\components\rtl\Garant\dd\ddSub.pas'
 , ddTextParaString in 'w:\common\components\rtl\Garant\dd\ddTextParaString.pas'
 , ddPicture in 'w:\common\components\rtl\Garant\dd\ddPicture.pas'
 {$If NOT Defined(NoImageEn)}
 , imageenview in 'w:\common\components\rtl\external\ImageEn\src\imageenview.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , ImageEnPack in 'w:\common\components\rtl\Garant\ScriptEngine\ImageEnPack.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , kwImageEnViewerSaveBitmap in 'w:\common\components\rtl\Garant\ScriptEngine\kwImageEnViewerSaveBitmap.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , kwImageEnControl in 'w:\common\components\rtl\Garant\ScriptEngine\kwImageEnControl.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , ImageEnViewRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\ImageEnViewRegistrator.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 , ddRTFUnits in 'w:\common\components\rtl\Garant\dd\ddRTFUnits.pas'
 , ddHexCharReader in 'w:\common\components\rtl\Garant\dd\ddHexCharReader.pas'
 , l3CharSkipper in 'w:\common\components\rtl\Garant\L3\l3CharSkipper.pas'
 , ddPictureSegment in 'w:\common\components\rtl\Garant\dd\ddPictureSegment.pas'
 , ddObjectSegment in 'w:\common\components\rtl\Garant\dd\ddObjectSegment.pas'
 , ddFormulaSegment in 'w:\common\components\rtl\Garant\dd\ddFormulaSegment.pas'
 , K234361767 in 'w:\common\components\rtl\Garant\Daily\K234361767.pas'
 , K234363360 in 'w:\common\components\rtl\Garant\Daily\K234363360.pas'
 {$If NOT Defined(NoVCM)}
 , PasteColumnTest in 'w:\common\components\gui\Garant\Daily\PasteColumnTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K235046445 in 'w:\common\components\rtl\Garant\Daily\K235046445.pas'
 , K234363136 in 'w:\common\components\rtl\Garant\Daily\K234363136.pas'
 , K234360974 in 'w:\common\components\rtl\Garant\Daily\K234360974.pas'
 , MoveSubTest in 'w:\common\components\rtl\Garant\Daily\MoveSubTest.pas'
 , K235050903 in 'w:\common\components\rtl\Garant\Daily\K235050903.pas'
 , EVDwithFormulasToRTFWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDwithFormulasToRTFWriterTest.pas'
 , K234363615 in 'w:\common\components\rtl\Garant\Daily\K234363615.pas'
 , CopyPasteTest in 'w:\common\components\rtl\Garant\Daily\CopyPasteTest.pas'
 , K235052899 in 'w:\common\components\rtl\Garant\Daily\K235052899.pas'
 , K235052988 in 'w:\common\components\rtl\Garant\Daily\K235052988.pas'
 , RTFtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\RTFtoEVDWriterTest.pas'
 , RTFReaderTest in 'w:\common\components\rtl\Garant\Daily\RTFReaderTest.pas'
 , ddRTFReader in 'w:\common\components\rtl\Garant\dd\ddRTFReader.pas'
 , ddCustomRTFReader in 'w:\common\components\rtl\Garant\dd\ddCustomRTFReader.pas'
 , ddLowLevelRTF in 'w:\common\components\rtl\Garant\dd\ddLowLevelRTF.pas'
 , destNorm in 'w:\common\components\rtl\Garant\dd\destNorm.pas'
 , ddRTFdestination in 'w:\common\components\rtl\Garant\dd\ddRTFdestination.pas'
 , ddRTFState in 'w:\common\components\rtl\Garant\dd\ddRTFState.pas'
 , ddBorder in 'w:\common\components\rtl\Garant\dd\ddBorder.pas'
 , ddPropertyObject in 'w:\common\components\rtl\Garant\dd\ddPropertyObject.pas'
 , ddBorderPart in 'w:\common\components\rtl\Garant\dd\ddBorderPart.pas'
 , ddCellProperty in 'w:\common\components\rtl\Garant\dd\ddCellProperty.pas'
 , ddBase in 'w:\common\components\rtl\Garant\dd\ddBase.pas'
 , ddSectionProperty in 'w:\common\components\rtl\Garant\dd\ddSectionProperty.pas'
 , ddDocumentProperty in 'w:\common\components\rtl\Garant\dd\ddDocumentProperty.pas'
 , ddRTFConst in 'w:\common\components\rtl\Garant\dd\ddRTFConst.pas'
 , ddRowProperty in 'w:\common\components\rtl\Garant\dd\ddRowProperty.pas'
 , ddTab in 'w:\common\components\rtl\Garant\dd\ddTab.pas'
 , ddDocumentAtomList in 'w:\common\components\rtl\Garant\dd\ddDocumentAtomList.pas'
 , ddTable in 'w:\common\components\rtl\Garant\dd\ddTable.pas'
 , ddTablePrim in 'w:\common\components\rtl\Garant\dd\ddTablePrim.pas'
 , ddRowList in 'w:\common\components\rtl\Garant\dd\ddRowList.pas'
 , ddTableRow in 'w:\common\components\rtl\Garant\dd\ddTableRow.pas'
 , ddCellList in 'w:\common\components\rtl\Garant\dd\ddCellList.pas'
 , ddTableCell in 'w:\common\components\rtl\Garant\dd\ddTableCell.pas'
 , ddCellsPropertyList in 'w:\common\components\rtl\Garant\dd\ddCellsPropertyList.pas'
 , ddBreak in 'w:\common\components\rtl\Garant\dd\ddBreak.pas'
 , ddFormulaParagraph in 'w:\common\components\rtl\Garant\dd\ddFormulaParagraph.pas'
 , ddRTFShape in 'w:\common\components\rtl\Garant\dd\ddRTFShape.pas'
 , K235053014 in 'w:\common\components\rtl\Garant\Daily\K235053014.pas'
 , K235054083 in 'w:\common\components\rtl\Garant\Daily\K235054083.pas'
 , K235052965 in 'w:\common\components\rtl\Garant\Daily\K235052965.pas'
 , SelectColumnAndDelete in 'w:\common\components\rtl\Garant\Daily\SelectColumnAndDelete.pas'
 , K235050021 in 'w:\common\components\rtl\Garant\Daily\K235050021.pas'
 {$If NOT Defined(NoVCM)}
 , CommentAndScrollTest in 'w:\common\components\gui\Garant\Daily\CommentAndScrollTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K235054362 in 'w:\common\components\rtl\Garant\Daily\K235054362.pas'
 , K235057437 in 'w:\common\components\rtl\Garant\Daily\K235057437.pas'
 {$If NOT Defined(NoVCM)}
 , QueryCardAddAttributeTest in 'w:\common\components\gui\Garant\Daily\QueryCardAddAttributeTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K235058888 in 'w:\common\components\rtl\Garant\Daily\K235058888.pas'
 , K235060094 in 'w:\common\components\rtl\Garant\Daily\K235060094.pas'
 , K235058873 in 'w:\common\components\rtl\Garant\Daily\K235058873.pas'
 , K235050248 in 'w:\common\components\rtl\Garant\Daily\K235050248.pas'
 {$If NOT Defined(NoVCM)}
 , CommentInTableAndScrollTest in 'w:\common\components\gui\Garant\Daily\CommentInTableAndScrollTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K234360788 in 'w:\common\components\rtl\Garant\Daily\K234360788.pas'
 , K235062061 in 'w:\common\components\rtl\Garant\Daily\K235062061.pas'
 , K235864191 in 'w:\common\components\rtl\Garant\Daily\K235864191.pas'
 , K235866053 in 'w:\common\components\rtl\Garant\Daily\K235866053.pas'
 , K235864157 in 'w:\common\components\rtl\Garant\Daily\K235864157.pas'
 , K235866221 in 'w:\common\components\rtl\Garant\Daily\K235866221.pas'
 , K235866981 in 'w:\common\components\rtl\Garant\Daily\K235866981.pas'
 , K234360960 in 'w:\common\components\rtl\Garant\Daily\K234360960.pas'
 {$If NOT Defined(NoVCM)}
 , InsertRowTest in 'w:\common\components\gui\Garant\Daily\InsertRowTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K235864277 in 'w:\common\components\rtl\Garant\Daily\K235864277.pas'
 {$If NOT Defined(NoVCM)}
 , DeleteSectionBreakTest in 'w:\common\components\gui\Garant\Daily\DeleteSectionBreakTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , DrawTestPrim in 'w:\common\components\gui\Garant\Daily\DrawTestPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K235873011 in 'w:\common\components\rtl\Garant\Daily\K235873011.pas'
 , K235875463 in 'w:\common\components\rtl\Garant\Daily\K235875463.pas'
 , ScrollByLineTest in 'w:\common\components\rtl\Garant\Daily\ScrollByLineTest.pas'
 , K235876236 in 'w:\common\components\rtl\Garant\Daily\K235876236.pas'
 , K224789639 in 'w:\common\components\rtl\Garant\Daily\K224789639.pas'
 , PreviewTestBefore235875079WithRowCmp in 'w:\common\components\rtl\Garant\Abstract_Tests\PreviewTestBefore235875079WithRowCmp.pas'
 , K233015604 in 'w:\common\components\rtl\Garant\Daily\K233015604.pas'
 , K237503834 in 'w:\common\components\rtl\Garant\Daily\K237503834.pas'
 , DeleteColumnToolTest in 'w:\common\components\rtl\Garant\Daily\DeleteColumnToolTest.pas'
 , K237503768 in 'w:\common\components\rtl\Garant\Daily\K237503768.pas'
 , MergeAndCheck in 'w:\common\components\rtl\Garant\Daily\MergeAndCheck.pas'
 , K238420075 in 'w:\common\components\rtl\Garant\Daily\K238420075.pas'
 , K239372528 in 'w:\common\components\rtl\Garant\Daily\K239372528.pas'
 , InsertBreakInTextTableTest in 'w:\common\components\rtl\Garant\Daily\InsertBreakInTextTableTest.pas'
 , K235869064 in 'w:\common\components\rtl\Garant\Daily\K235869064.pas'
 , K238420863 in 'w:\common\components\rtl\Garant\Daily\K238420863.pas'
 , K239894899 in 'w:\common\components\rtl\Garant\Daily\K239894899.pas'
 , K234357754 in 'w:\common\components\rtl\Garant\Daily\K234357754.pas'
 , MergeAndCheckSelectionTest in 'w:\common\components\rtl\Garant\Daily\MergeAndCheckSelectionTest.pas'
 , K217681225 in 'w:\common\components\rtl\Garant\Daily\K217681225.pas'
 , ScrollByArrow in 'w:\common\components\rtl\Garant\Daily\ScrollByArrow.pas'
 , K216530981 in 'w:\common\components\rtl\Garant\Daily\K216530981.pas'
 , K241011651 in 'w:\common\components\rtl\Garant\Daily\K241011651.pas'
 , SelectRowAndDeleteTest in 'w:\common\components\rtl\Garant\Daily\SelectRowAndDeleteTest.pas'
 , K242843959 in 'w:\common\components\rtl\Garant\Daily\K242843959.pas'
 , NSRCtoNSRCTest in 'w:\common\components\rtl\Garant\Daily\NSRCtoNSRCTest.pas'
 , K213713837 in 'w:\common\components\rtl\Garant\Daily\K213713837.pas'
 , K216074128 in 'w:\common\components\rtl\Garant\Daily\K216074128.pas'
 , K111739572 in 'w:\common\components\rtl\Garant\Daily\K111739572.pas'
 , CellMouseSelectionTest in 'w:\common\components\rtl\Garant\Daily\CellMouseSelectionTest.pas'
 , HotSpotSelectionTest in 'w:\common\components\rtl\Garant\Abstract_Tests\HotSpotSelectionTest.pas'
 , K242844505 in 'w:\common\components\rtl\Garant\Daily\K242844505.pas'
 , K244195248 in 'w:\common\components\rtl\Garant\Daily\K244195248.pas'
 , K245203249 in 'w:\common\components\rtl\Garant\Daily\K245203249.pas'
 , K245204495 in 'w:\common\components\rtl\Garant\Daily\K245204495.pas'
 {$If NOT Defined(NoVCM)}
 , PreviewWithLinesTestBefore235875079 in 'w:\common\components\gui\Garant\Daily\PreviewWithLinesTestBefore235875079.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , DailyTest_NSRC_7_6_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_NSRC_7_6_TestUnit.pas'
 , K245206060 in 'w:\common\components\rtl\Garant\Daily\K245206060.pas'
 , DailyTest_OutlinerTests_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_OutlinerTests_TestUnit.pas'
 , DailyTest_7_7_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_7_TestUnit.pas'
 , K245761273 in 'w:\common\components\rtl\Garant\Daily\K245761273.pas'
 , AutoBlockTest in 'w:\common\components\rtl\Garant\Abstract_Tests\AutoBlockTest.pas'
 , evAutoBlock in 'w:\common\components\gui\Garant\Everest\ext\evAutoBlock.pas'
 , K245761265 in 'w:\common\components\rtl\Garant\Daily\K245761265.pas'
 , K246939696 in 'w:\common\components\rtl\Garant\Daily\K246939696.pas'
 , K206079417 in 'w:\common\components\rtl\Garant\Daily\K206079417.pas'
 , TextMetricsAfterCopyPasteTest in 'w:\common\components\rtl\Garant\Daily\TextMetricsAfterCopyPasteTest.pas'
 , TextMetricsTest in 'w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsTest.pas'
 , TextMetricsPrimTest in 'w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsPrimTest.pas'
 , TextViaEditorProcessorWithExternalSave in 'w:\common\components\rtl\Garant\Abstract_Tests\TextViaEditorProcessorWithExternalSave.pas'
 , K217685978 in 'w:\common\components\rtl\Garant\Daily\K217685978.pas'
 , K247300520 in 'w:\common\components\rtl\Garant\Daily\K247300520.pas'
 , K244712164 in 'w:\common\components\rtl\Garant\Daily\K244712164.pas'
 , K248194804 in 'w:\common\components\rtl\Garant\Daily\K248194804.pas'
 , K235875079 in 'w:\common\components\rtl\Garant\Daily\K235875079.pas'
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore278833302 in 'w:\common\components\gui\Garant\Daily\PreviewTestBefore278833302.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K247302160 in 'w:\common\components\rtl\Garant\Daily\K247302160.pas'
 , TextMericsAfterDeleteTest in 'w:\common\components\rtl\Garant\Daily\TextMericsAfterDeleteTest.pas'
 , K249333540 in 'w:\common\components\rtl\Garant\Daily\K249333540.pas'
 , PreviewWithRowCompare in 'w:\common\components\rtl\Garant\Abstract_Tests\PreviewWithRowCompare.pas'
 , K249336513 in 'w:\common\components\rtl\Garant\Daily\K249336513.pas'
 , K235870623 in 'w:\common\components\rtl\Garant\Daily\K235870623.pas'
 , MouseMoveCellsSelectTest in 'w:\common\components\rtl\Garant\Daily\MouseMoveCellsSelectTest.pas'
 , MouseMoveSelectionTest in 'w:\common\components\rtl\Garant\Abstract_Tests\MouseMoveSelectionTest.pas'
 , K251342574 in 'w:\common\components\rtl\Garant\Daily\K251342574.pas'
 , SelectionCellTest in 'w:\common\components\rtl\Garant\Daily\SelectionCellTest.pas'
 , K251334429 in 'w:\common\components\rtl\Garant\Daily\K251334429.pas'
 , DrawTest in 'w:\common\components\rtl\Garant\Daily\DrawTest.pas'
 , K252086528 in 'w:\common\components\rtl\Garant\Daily\K252086528.pas'
 , OutlinerWithEVDStyleNodes in 'w:\common\components\rtl\Garant\Daily\OutlinerWithEVDStyleNodes.pas'
 {$If NOT Defined(NoVCM)}
 , OutlinerTest in 'w:\common\components\gui\Garant\Daily\OutlinerTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , Outliner_Form in 'w:\common\components\gui\Garant\Daily\Forms\Outliner_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtOutlinerControl in 'w:\common\components\gui\Garant\VT\vtOutlinerControl.pas'
 {$If NOT Defined(NoVCM)}
 , OutlinerForm_ut_OutlinerForm_UserType in 'w:\common\components\gui\Garant\Daily\Forms\OutlinerForm_ut_OutlinerForm_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , OutlinerFormKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\OutlinerFormKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 , evTreeGenerator in 'w:\common\components\gui\Garant\Everest\evTreeGenerator.pas'
 , K252524029 in 'w:\common\components\rtl\Garant\Daily\K252524029.pas'
 , InsertPictureTest in 'w:\common\components\rtl\Garant\Abstract_Tests\InsertPictureTest.pas'
 , evExtFormat in 'w:\common\components\gui\Garant\Everest\ext\evExtFormat.pas'
 , evdScriptHyperlinkEliminator in 'w:\common\components\gui\Garant\Everest\evdScriptHyperlinkEliminator.pas'
 , evdHyperlinkEliminator in 'w:\common\components\rtl\Garant\EVD\evdHyperlinkEliminator.pas'
 , evPDFWriter in 'w:\common\components\gui\Garant\Everest\evPDFWriter.pas'
 , evCustomPDFWriter in 'w:\common\components\gui\Garant\Everest\evCustomPDFWriter.pas'
 , ddPDFExporter in 'w:\common\components\rtl\Garant\dd\ddPDFExporter.pas'
 , GarantPDFDocument in 'w:\common\components\rtl\external\SynPDF\GarantPDFDocument.pas'
 , SynPDF in 'w:\common\components\rtl\external\SynPDF\SynPDF.pas'
 , SynCommons in 'w:\common\components\rtl\external\SynPDF\SynCommons.pas'
 , SynCrypto in 'w:\common\components\rtl\external\SynPDF\SynCrypto.pas'
 , SynZip in 'w:\common\components\rtl\external\SynPDF\SynZip.pas'
 , SynGdiPlus in 'w:\common\components\rtl\external\SynPDF\SynGdiPlus.pas'
 , SynLZ in 'w:\common\components\rtl\external\SynPDF\SynLZ.pas'
 , nevDocumentProvider4PDF in 'w:\common\components\gui\Garant\Everest\nevDocumentProvider4PDF.pas'
 , K252524358 in 'w:\common\components\rtl\Garant\Daily\K252524358.pas'
 , K253664689 in 'w:\common\components\rtl\Garant\Daily\K253664689.pas'
 , K252524333 in 'w:\common\components\rtl\Garant\Daily\K252524333.pas'
 , ColumnResizeWithCtrl in 'w:\common\components\rtl\Garant\Daily\ColumnResizeWithCtrl.pas'
 , ColumnResizeByMousePrimTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ColumnResizeByMousePrimTest.pas'
 , K177963847 in 'w:\common\components\rtl\Garant\Daily\K177963847.pas'
 , K252524299 in 'w:\common\components\rtl\Garant\Daily\K252524299.pas'
 , TabInTableTest in 'w:\common\components\rtl\Garant\Abstract_Tests\TabInTableTest.pas'
 , K253668263 in 'w:\common\components\rtl\Garant\Daily\K253668263.pas'
 , SplitCellTest in 'w:\common\components\rtl\Garant\Daily\SplitCellTest.pas'
 , K253668417 in 'w:\common\components\rtl\Garant\Daily\K253668417.pas'
 , K254941681 in 'w:\common\components\rtl\Garant\Daily\K254941681.pas'
 , K182157315 in 'w:\common\components\rtl\Garant\Daily\K182157315.pas'
 , K252520444 in 'w:\common\components\rtl\Garant\Daily\K252520444.pas'
 , K252524393 in 'w:\common\components\rtl\Garant\Daily\K252524393.pas'
 , ScrollAndCheckCursorTest in 'w:\common\components\rtl\Garant\Daily\ScrollAndCheckCursorTest.pas'
 , K253659671 in 'w:\common\components\rtl\Garant\Daily\K253659671.pas'
 , ShowBaseSearchTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ShowBaseSearchTest.pas'
 , K254354240 in 'w:\common\components\rtl\Garant\Daily\K254354240.pas'
 , DrawSelectionInTableTest in 'w:\common\components\rtl\Garant\Abstract_Tests\DrawSelectionInTableTest.pas'
 {$If Defined(evNeedPainters)}
 , evDelayedPaintersSpy in 'w:\common\components\gui\Garant\Everest\evDelayedPaintersSpy.pas'
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evNeedPainters)}
 , evSelectedParts in 'w:\common\components\gui\Garant\Everest\evSelectedParts.pas'
 {$IfEnd} // Defined(evNeedPainters)
 , K255956509 in 'w:\common\components\rtl\Garant\Daily\K255956509.pas'
 , ScrollParamsTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ScrollParamsTest.pas'
 , ScrollerParamsTestPrim in 'w:\common\components\rtl\Garant\Abstract_Tests\ScrollerParamsTestPrim.pas'
 , K255958998 in 'w:\common\components\rtl\Garant\Daily\K255958998.pas'
 , ComplexScrollParams in 'w:\common\components\rtl\Garant\Daily\ComplexScrollParams.pas'
 , nevVScrollerSpy in 'w:\common\components\gui\Garant\Everest\new\nevVScrollerSpy.pas'
 , K91850237 in 'w:\common\components\rtl\Garant\Daily\K91850237.pas'
 , VerticalCursorMovingTest in 'w:\common\components\rtl\Garant\Abstract_Tests\VerticalCursorMovingTest.pas'
 , K255975907 in 'w:\common\components\rtl\Garant\Daily\K255975907.pas'
 , K252520765 in 'w:\common\components\rtl\Garant\Daily\K252520765.pas'
 , ScrollByArrowAndCheckShapesTest in 'w:\common\components\rtl\Garant\Daily\ScrollByArrowAndCheckShapesTest.pas'
 , K258610458 in 'w:\common\components\rtl\Garant\Daily\K258610458.pas'
 , MouseSelectPtTest in 'w:\common\components\rtl\Garant\Abstract_Tests\MouseSelectPtTest.pas'
 , K259175668 in 'w:\common\components\rtl\Garant\Daily\K259175668.pas'
 , WrongSearchTest in 'w:\common\components\rtl\Garant\Abstract_Tests\WrongSearchTest.pas'
 , K259163541 in 'w:\common\components\rtl\Garant\Daily\K259163541.pas'
 , ScrollUpAndDownAndCheckShapes in 'w:\common\components\rtl\Garant\Daily\ScrollUpAndDownAndCheckShapes.pas'
 , K259163553 in 'w:\common\components\rtl\Garant\Daily\K259163553.pas'
 , K259164768 in 'w:\common\components\rtl\Garant\Daily\K259164768.pas'
 , K258613004 in 'w:\common\components\rtl\Garant\Daily\K258613004.pas'
 , LinesTest in 'w:\common\components\rtl\Garant\Abstract_Tests\LinesTest.pas'
 , K259893591 in 'w:\common\components\rtl\Garant\Daily\K259893591.pas'
 , WholeSelectionWithMouseTest in 'w:\common\components\rtl\Garant\Abstract_Tests\WholeSelectionWithMouseTest.pas'
 , K263293373 in 'w:\common\components\rtl\Garant\Daily\K263293373.pas'
 , K263750307 in 'w:\common\components\rtl\Garant\Daily\K263750307.pas'
 , InsertFormulaTest in 'w:\common\components\rtl\Garant\Abstract_Tests\InsertFormulaTest.pas'
 , K264900129 in 'w:\common\components\rtl\Garant\Daily\K264900129.pas'
 , K265411837 in 'w:\common\components\rtl\Garant\Daily\K265411837.pas'
 , HorzMergeCells in 'w:\common\components\rtl\Garant\Daily\HorzMergeCells.pas'
 , K265412167 in 'w:\common\components\rtl\Garant\Daily\K265412167.pas'
 , K265412255 in 'w:\common\components\rtl\Garant\Daily\K265412255.pas'
 , K266405030 in 'w:\common\components\rtl\Garant\Daily\K266405030.pas'
 , K264902374 in 'w:\common\components\rtl\Garant\Daily\K264902374.pas'
 , SelectCommentAndDelete in 'w:\common\components\rtl\Garant\Abstract_Tests\SelectCommentAndDelete.pas'
 , K265409480 in 'w:\common\components\rtl\Garant\Daily\K265409480.pas'
 , ClickOnCommentTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ClickOnCommentTest.pas'
 , K265409725 in 'w:\common\components\rtl\Garant\Daily\K265409725.pas'
 , K269062434 in 'w:\common\components\rtl\Garant\Daily\K269062434.pas'
 , K271754584 in 'w:\common\components\rtl\Garant\Daily\K271754584.pas'
 , K272662869 in 'w:\common\components\rtl\Garant\Daily\K272662869.pas'
 , K272666734 in 'w:\common\components\rtl\Garant\Daily\K272666734.pas'
 , RowSelectionTest in 'w:\common\components\rtl\Garant\Abstract_Tests\RowSelectionTest.pas'
 , K272666721 in 'w:\common\components\rtl\Garant\Daily\K272666721.pas'
 , InsertSectionBreak in 'w:\common\components\rtl\Garant\Abstract_Tests\InsertSectionBreak.pas'
 , K278135327 in 'w:\common\components\rtl\Garant\Daily\K278135327.pas'
 , K269064546 in 'w:\common\components\rtl\Garant\Daily\K269064546.pas'
 , ScrollByLineBackAndSelectPt in 'w:\common\components\rtl\Garant\Daily\ScrollByLineBackAndSelectPt.pas'
 , K267328230 in 'w:\common\components\rtl\Garant\Daily\K267328230.pas'
 , ScrollAndLinesTest in 'w:\common\components\rtl\Garant\Abstract_Tests\ScrollAndLinesTest.pas'
 , K283149108 in 'w:\common\components\rtl\Garant\Daily\K283149108.pas'
 {$If NOT Defined(NoVCM)}
 , PreviewTest in 'w:\common\components\gui\Garant\Daily\PreviewTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K288787848 in 'w:\common\components\rtl\Garant\Daily\K288787848.pas'
 , K296095866 in 'w:\common\components\rtl\Garant\Daily\K296095866.pas'
 , AllChildreCountTest in 'w:\common\components\rtl\Garant\Abstract_Tests\AllChildreCountTest.pas'
 , K297705917 in 'w:\common\components\rtl\Garant\Daily\K297705917.pas'
 , K330700128 in 'w:\common\components\rtl\Garant\Daily\K330700128.pas'
 , K347636412 in 'w:\common\components\rtl\Garant\Daily\K347636412.pas'
 , DailyTest_Wiki_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_Wiki_TestUnit.pas'
 , DailyTest_HTML_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_HTML_TestUnit.pas'
 , DailyTest_NSRC_7_7_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_NSRC_7_7_TestUnit.pas'
 , K253662098 in 'w:\common\components\rtl\Garant\Daily\K253662098.pas'
 , K260442347 in 'w:\common\components\rtl\Garant\Daily\K260442347.pas'
 , K267324701 in 'w:\common\components\rtl\Garant\Daily\K267324701.pas'
 , K276535467 in 'w:\common\components\rtl\Garant\Daily\K276535467.pas'
 , K280859294 in 'w:\common\components\rtl\Garant\Daily\K280859294.pas'
 , K331186919 in 'w:\common\components\rtl\Garant\Daily\K331186919.pas'
 , K332563400 in 'w:\common\components\rtl\Garant\Daily\K332563400.pas'
 , K342865677 in 'w:\common\components\rtl\Garant\Daily\K342865677.pas'
 , K532630317 in 'w:\common\components\rtl\Garant\Daily\K532630317.pas'
 , K532634915 in 'w:\common\components\rtl\Garant\Daily\K532634915.pas'
 , DailyTest_7_5_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_5_TestUnit.pas'
 , K197497243 in 'w:\common\components\rtl\Garant\Daily\K197497243.pas'
 , K199589954 in 'w:\common\components\rtl\Garant\Daily\K199589954.pas'
 , K199591594 in 'w:\common\components\rtl\Garant\Daily\K199591594.pas'
 , K200088144 in 'w:\common\components\rtl\Garant\Daily\K200088144.pas'
 , K200901262 in 'w:\common\components\rtl\Garant\Daily\K200901262.pas'
 , K203131097 in 'w:\common\components\rtl\Garant\Daily\K203131097.pas'
 , K205357352 in 'w:\common\components\rtl\Garant\Daily\K205357352.pas'
 , K206504616 in 'w:\common\components\rtl\Garant\Daily\K206504616.pas'
 , K206504312 in 'w:\common\components\rtl\Garant\Daily\K206504312.pas'
 , K207013375 in 'w:\common\components\rtl\Garant\Daily\K207013375.pas'
 , K207388924 in 'w:\common\components\rtl\Garant\Daily\K207388924.pas'
 , K207389888 in 'w:\common\components\rtl\Garant\Daily\K207389888.pas'
 , K208699964 in 'w:\common\components\rtl\Garant\Daily\K208699964.pas'
 , K208700993 in 'w:\common\components\rtl\Garant\Daily\K208700993.pas'
 , K209584396 in 'w:\common\components\rtl\Garant\Daily\K209584396.pas'
 , K210043510 in 'w:\common\components\rtl\Garant\Daily\K210043510.pas'
 , K210043101 in 'w:\common\components\rtl\Garant\Daily\K210043101.pas'
 , K210043160 in 'w:\common\components\rtl\Garant\Daily\K210043160.pas'
 , K208701762 in 'w:\common\components\rtl\Garant\Daily\K208701762.pas'
 , K209584437 in 'w:\common\components\rtl\Garant\Daily\K209584437.pas'
 , K210437198 in 'w:\common\components\rtl\Garant\Daily\K210437198.pas'
 , K210438353 in 'w:\common\components\rtl\Garant\Daily\K210438353.pas'
 , K210438308 in 'w:\common\components\rtl\Garant\Daily\K210438308.pas'
 , K211878214 in 'w:\common\components\rtl\Garant\Daily\K211878214.pas'
 , K211878770 in 'w:\common\components\rtl\Garant\Daily\K211878770.pas'
 , K210438932 in 'w:\common\components\rtl\Garant\Daily\K210438932.pas'
 , K211879983 in 'w:\common\components\rtl\Garant\Daily\K211879983.pas'
 , K213254256 in 'w:\common\components\rtl\Garant\Daily\K213254256.pas'
 , K210043147 in 'w:\common\components\rtl\Garant\Daily\K210043147.pas'
 , K210043095 in 'w:\common\components\rtl\Garant\Daily\K210043095.pas'
 , K213713115 in 'w:\common\components\rtl\Garant\Daily\K213713115.pas'
 , K216072357 in 'w:\common\components\rtl\Garant\Daily\K216072357.pas'
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest in 'w:\common\components\gui\Garant\Daily\ScrollBackTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K210043423 in 'w:\common\components\rtl\Garant\Daily\K210043423.pas'
 , K201493907 in 'w:\common\components\rtl\Garant\Daily\K201493907.pas'
 , K204931408 in 'w:\common\components\rtl\Garant\Daily\K204931408.pas'
 , EVDtoEVDEmptyRowTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowTest.pas'
 , evdEmptyRowFilter in 'w:\common\components\gui\Garant\Everest\evdEmptyRowFilter.pas'
 , K213713120 in 'w:\common\components\rtl\Garant\Daily\K213713120.pas'
 , K210436976 in 'w:\common\components\rtl\Garant\Daily\K210436976.pas'
 , K217681540 in 'w:\common\components\rtl\Garant\Daily\K217681540.pas'
 , K217680060 in 'w:\common\components\rtl\Garant\Daily\K217680060.pas'
 , K217683893 in 'w:\common\components\rtl\Garant\Daily\K217683893.pas'
 , K203130960 in 'w:\common\components\rtl\Garant\Daily\K203130960.pas'
 , K217684334 in 'w:\common\components\rtl\Garant\Daily\K217684334.pas'
 , K217686256 in 'w:\common\components\rtl\Garant\Daily\K217686256.pas'
 , K214074330 in 'w:\common\components\rtl\Garant\Daily\K214074330.pas'
 , K204931515 in 'w:\common\components\rtl\Garant\Daily\K204931515.pas'
 , K217691824 in 'w:\common\components\rtl\Garant\Daily\K217691824.pas'
 , K217691845 in 'w:\common\components\rtl\Garant\Daily\K217691845.pas'
 , K217693956 in 'w:\common\components\rtl\Garant\Daily\K217693956.pas'
 , K217678468 in 'w:\common\components\rtl\Garant\Daily\K217678468.pas'
 , K206079241 in 'w:\common\components\rtl\Garant\Daily\K206079241.pas'
 , K207006496 in 'w:\common\components\rtl\Garant\Daily\K207006496.pas'
 , K219119831 in 'w:\common\components\rtl\Garant\Daily\K219119831.pas'
 , K218824755 in 'w:\common\components\rtl\Garant\Daily\K218824755.pas'
 , K218464982 in 'w:\common\components\rtl\Garant\Daily\K218464982.pas'
 , K219120094 in 'w:\common\components\rtl\Garant\Daily\K219120094.pas'
 , K217680744 in 'w:\common\components\rtl\Garant\Daily\K217680744.pas'
 , K219123621 in 'w:\common\components\rtl\Garant\Daily\K219123621.pas'
 , K217688170 in 'w:\common\components\rtl\Garant\Daily\K217688170.pas'
 , K219124975 in 'w:\common\components\rtl\Garant\Daily\K219124975.pas'
 , K219124086 in 'w:\common\components\rtl\Garant\Daily\K219124086.pas'
 , K220594340 in 'w:\common\components\rtl\Garant\Daily\K220594340.pas'
 , DailyTest_ScriptTest_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_ScriptTest_TestUnit.pas'
 , K276537900 in 'w:\common\components\rtl\Garant\Daily\K276537900.pas'
 , K254349574 in 'w:\common\components\rtl\Garant\Daily\K254349574.pas'
 , K290266820 in 'w:\common\components\rtl\Garant\Daily\K290266820.pas'
 , K290951357 in 'w:\common\components\rtl\Garant\Daily\K290951357.pas'
 , K327822716 in 'w:\common\components\rtl\Garant\Daily\K327822716.pas'
 , DailyTest_7_7_Lulin_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_7_Lulin_TestUnit.pas'
 , K254944075 in 'w:\common\components\rtl\Garant\Daily\K254944075.pas'
 , WikiToEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\WikiToEVDWriterTest.pas'
 , WikiReaderTest in 'w:\common\components\rtl\Garant\Daily\WikiReaderTest.pas'
 , evWikiReader in 'w:\common\components\gui\Garant\Everest\evWikiReader.pas'
 , K255966779 in 'w:\common\components\rtl\Garant\Daily\K255966779.pas'
 , EVDtoEVDBlockNameAdderTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDBlockNameAdderTest.pas'
 , K269066487 in 'w:\common\components\rtl\Garant\Daily\K269066487.pas'
 , K278136024 in 'w:\common\components\rtl\Garant\Daily\K278136024.pas'
 , K280006084 in 'w:\common\components\rtl\Garant\Daily\K280006084.pas'
 , K288010443 in 'w:\common\components\rtl\Garant\Daily\K288010443.pas'
 , K288788279 in 'w:\common\components\rtl\Garant\Daily\K288788279.pas'
 , HTMLtoEVDTest in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDTest.pas'
 , HTMLtoEVDWriterTest in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDWriterTest.pas'
 , ddHTMLReader in 'w:\common\components\rtl\Garant\dd\ddHTMLReader.pas'
 , K274825304 in 'w:\common\components\rtl\Garant\Daily\K274825304.pas'
 , K289933137 in 'w:\common\components\rtl\Garant\Daily\K289933137.pas'
 , l3KeyWrd in 'w:\common\components\rtl\Garant\L3\l3KeyWrd.pas'
 , K259890927 in 'w:\common\components\rtl\Garant\Daily\K259890927.pas'
 , K293280527 in 'w:\common\components\rtl\Garant\Daily\K293280527.pas'
 , l3InterfaceList in 'w:\common\components\rtl\Garant\L3\l3InterfaceList.pas'
 , K271188165 in 'w:\common\components\rtl\Garant\Daily\K271188165.pas'
 , K282693895 in 'w:\common\components\rtl\Garant\Daily\K282693895.pas'
 , FormulaRender in 'w:\common\components\rtl\Garant\Abstract_Tests\FormulaRender.pas'
 , eeRenderFormula in 'w:\common\components\rtl\Garant\RenderEVD\eeRenderFormula.pas'
 {$If NOT Defined(notDebugStackTrace)}
 , jclDebug {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\source\windows\jclDebug.pas' {$EndIf}
 {$IfEnd} // NOT Defined(notDebugStackTrace)
 , l3BitmapContainer in 'w:\common\components\rtl\Garant\L3\l3BitmapContainer.pas'
 , evdVer in 'w:\common\components\rtl\Garant\EVD\evdVer.pas'
 , K321983051 in 'w:\common\components\rtl\Garant\Daily\K321983051.pas'
 , K336664105 in 'w:\common\components\rtl\Garant\Daily\K336664105.pas'
 , K336663851 in 'w:\common\components\rtl\Garant\Daily\K336663851.pas'
 , K344139764 in 'w:\common\components\rtl\Garant\Daily\K344139764.pas'
 , DailyTest_XML_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_XML_TestUnit.pas'
 , L3XMLWriterTest in 'w:\common\components\rtl\Garant\Daily\L3XMLWriterTest.pas'
 , l3XMLWriter in 'w:\common\components\rtl\Garant\L3\l3XMLWriter.pas'
 , DailyTest_7_8_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_8_TestUnit.pas'
 , K337510841 in 'w:\common\components\rtl\Garant\Daily\K337510841.pas'
 , K362130309 in 'w:\common\components\rtl\Garant\Daily\K362130309.pas'
 , K385025566 in 'w:\common\components\rtl\Garant\Daily\K385025566.pas'
 , EVDtoXMLWiterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoXMLWiterTest.pas'
 , XMLWriterTest in 'w:\common\components\rtl\Garant\Daily\XMLWriterTest.pas'
 , evdXMLWriter in 'w:\common\components\rtl\Garant\EVD\evdXMLWriter.pas'
 , K408654725 in 'w:\common\components\rtl\Garant\Daily\K408654725.pas'
 , K398275085 in 'w:\common\components\rtl\Garant\Daily\K398275085.pas'
 , K415729926 in 'w:\common\components\rtl\Garant\Daily\K415729926.pas'
 , K423621421 in 'w:\common\components\rtl\Garant\Daily\K423621421.pas'
 , K424386600 in 'w:\common\components\rtl\Garant\Daily\K424386600.pas'
 , K424399558 in 'w:\common\components\rtl\Garant\Daily\K424399558.pas'
 , K356070665 in 'w:\common\components\rtl\Garant\Daily\K356070665.pas'
 , K346754389 in 'w:\common\components\rtl\Garant\Daily\K346754389.pas'
 , K431378356 in 'w:\common\components\rtl\Garant\Daily\K431378356.pas'
 , K434763341 in 'w:\common\components\rtl\Garant\Daily\K434763341.pas'
 , K435460794 in 'w:\common\components\rtl\Garant\Daily\K435460794.pas'
 , K431386712 in 'w:\common\components\rtl\Garant\Daily\K431386712.pas'
 , K439429165 in 'w:\common\components\rtl\Garant\Daily\K439429165.pas'
 , K439979725 in 'w:\common\components\rtl\Garant\Daily\K439979725.pas'
 , K440434932 in 'w:\common\components\rtl\Garant\Daily\K440434932.pas'
 , K442368006 in 'w:\common\components\rtl\Garant\Daily\K442368006.pas'
 , K444236481 in 'w:\common\components\rtl\Garant\Daily\K444236481.pas'
 , K444999575 in 'w:\common\components\rtl\Garant\Daily\K444999575.pas'
 , K444993775 in 'w:\common\components\rtl\Garant\Daily\K444993775.pas'
 , K449682598 in 'w:\common\components\rtl\Garant\Daily\K449682598.pas'
 , K332202037 in 'w:\common\components\rtl\Garant\Daily\K332202037.pas'
 , K288786476 in 'w:\common\components\rtl\Garant\Daily\K288786476.pas'
 , K336662790 in 'w:\common\components\rtl\Garant\Daily\K336662790.pas'
 , K336666483 in 'w:\common\components\rtl\Garant\Daily\K336666483.pas'
 , K251339809 in 'w:\common\components\rtl\Garant\Daily\K251339809.pas'
 , EVDtoHTMLTest in 'w:\common\components\rtl\Garant\Daily\EVDtoHTMLTest.pas'
 , EVDtoHTMLWriterTest in 'w:\common\components\rtl\Garant\Daily\EVDtoHTMLWriterTest.pas'
 , ddHTMLWriter in 'w:\common\components\rtl\Garant\dd\ddHTMLWriter.pas'
 , ddHTMLWriterRes in 'w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas'
 , K450277041 in 'w:\common\components\rtl\Garant\Daily\K450277041.pas'
 , K452374409 in 'w:\common\components\rtl\Garant\Daily\K452374409.pas'
 , K453151648 in 'w:\common\components\rtl\Garant\Daily\K453151648.pas'
 , K453164226 in 'w:\common\components\rtl\Garant\Daily\K453164226.pas'
 , K293279996 in 'w:\common\components\rtl\Garant\Daily\K293279996.pas'
 , K321986755 in 'w:\common\components\rtl\Garant\Daily\K321986755.pas'
 , K358359010 in 'w:\common\components\rtl\Garant\Daily\K358359010.pas'
 , K459284317 in 'w:\common\components\rtl\Garant\Daily\K459284317.pas'
 , K459284359 in 'w:\common\components\rtl\Garant\Daily\K459284359.pas'
 , K459282006 in 'w:\common\components\rtl\Garant\Daily\K459282006.pas'
 {$If NOT Defined(NoVCM)}
 , PageCountTest in 'w:\common\components\gui\Garant\Daily\PageCountTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , K371654285 in 'w:\common\components\rtl\Garant\Daily\K371654285.pas'
 , DailyTest_SandBoxTests_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_SandBoxTests_TestUnit.pas'
 , K460262716 in 'w:\common\components\rtl\Garant\Daily\K460262716.pas'
 , CheckingFilesInFolderTest in 'w:\common\components\rtl\Garant\Abstract_Tests\CheckingFilesInFolderTest.pas'
 , DailyTest_RegExp_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_RegExp_TestUnit.pas'
 , K460275638 in 'w:\common\components\rtl\Garant\Daily\K460275638.pas'
 , RegExpTest in 'w:\common\components\rtl\Garant\Daily\RegExpTest.pas'
 , l3RegEx in 'w:\common\components\rtl\Garant\L3\l3RegEx.pas'
 , l3IniFile in 'w:\common\components\rtl\Garant\L3\l3IniFile.pas'
 , K460275638Suite in 'w:\common\components\rtl\Garant\Daily\K460275638Suite.pas'
 , CustomFolderTestSuite in 'w:\common\components\rtl\Garant\Abstract_Tests\CustomFolderTestSuite.pas'
 , DailyTest_AppConfig_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_AppConfig_TestUnit.pas'
 , DailyTest_7_9_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_9_TestUnit.pas'
 , K462555833 in 'w:\common\components\rtl\Garant\Daily\K462555833.pas'
 , EVDtoEVDEmptyRowAndEmptyTableTest in 'w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowAndEmptyTableTest.pas'
 , K462555833_1 in 'w:\common\components\rtl\Garant\Daily\K462555833_1.pas'
 , K466751465 in 'w:\common\components\rtl\Garant\Daily\K466751465.pas'
 , K462555879 in 'w:\common\components\rtl\Garant\Daily\K462555879.pas'
 , AppConfigBaseTest in 'w:\common\components\rtl\Garant\Daily\AppConfigBaseTest.pas'
 {$If NOT Defined(NoVCM)}
 , EmptyFormTest in 'w:\common\components\gui\Garant\Daily\EmptyFormTest.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , FromWithPanel_Form in 'w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , FromWithPanel_ut_FromWithPanel_UserType in 'w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_ut_FromWithPanel_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVCL)}
 , FromWithPanelKeywordsPack in 'w:\common\components\gui\Garant\Daily\Forms\FromWithPanelKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVCL)
 , ddAppConfigTypes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas'
 , ddConfigStorages in 'w:\common\components\rtl\Garant\dd\ddConfigStorages.pas'
 , ddAppConfigBase in 'w:\common\components\rtl\Garant\dd\ddAppConfigBase.pas'
 , ddAppConfigConst in 'w:\common\components\rtl\Garant\dd\ddAppConfigConst.pas'
 , l3ProtoPersistentRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentRefList.pas'
 , Contnrs {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Contnrs.pas' {$EndIf}
 , ddAppConfigTypesRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas'
 , vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas'
 {$If NOT Defined(NoVCL)}
 , SpinEditWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , vtRadioButton in 'w:\common\components\gui\Garant\VT\vtRadioButton.pas'
 , vtGroupBox in 'w:\common\components\gui\Garant\VT\vtGroupBox.pas'
 , vtButton in 'w:\common\components\gui\Garant\VT\vtButton.pas'
 , eeButton in 'w:\common\components\gui\Garant\VT\eeButton.pas'
 {$If NOT Defined(NoVCL)}
 , CheckLst {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CheckLst.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , CheckListBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , ddAppConfigRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas'
 , ddAppConfigUtils in 'w:\common\components\rtl\Garant\dd\ddAppConfigUtils.pas'
 , ddAppConfigSimpleBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigSimpleBFrame.pas'
 , ddAppConfigStrings in 'w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas'
 , ddAppConfigStringsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas'
 , l3Base64 in 'w:\common\components\rtl\Garant\L3\l3Base64.pas'
 {$If NOT Defined(NoVCL)}
 , FileCtrl {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\FileCtrl.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , MMSystem {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\MMSystem.pas' {$EndIf}
 , ddAppConfigDates in 'w:\common\components\rtl\Garant\dd\ddAppConfigDates.pas'
 , l3TypedIntegerValueMap in 'w:\common\components\rtl\Garant\L3\l3TypedIntegerValueMap.pas'
 , ddAppConfigLists in 'w:\common\components\rtl\Garant\dd\ddAppConfigLists.pas'
 , ddAppConfigDataAdapters in 'w:\common\components\rtl\Garant\dd\ddAppConfigDataAdapters.pas'
 , ddTemporaryStorage in 'w:\common\components\rtl\Garant\dd\ddTemporaryStorage.pas'
 , ddCustomIniStorage in 'w:\common\components\rtl\Garant\dd\ddCustomIniStorage.pas'
 , ddAppConfigListsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigListsRes.pas'
 {$If NOT Defined(Nemesis)}
 , ddIniStorage in 'w:\common\components\rtl\Garant\dd\ddIniStorage.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ConfigStorageStub in 'w:\common\components\rtl\Garant\Daily\ConfigStorageStub.pas'
 , ddAppConfig in 'w:\common\components\rtl\Garant\dd\ddAppConfig.pas'
 , ddAppConfigVersions in 'w:\common\components\rtl\Garant\dd\ddAppConfigVersions.pas'
 , l3RecList in 'w:\common\components\rtl\Garant\L3\l3RecList.pas'
 , l3BaseRecList in 'w:\common\components\rtl\Garant\L3\l3BaseRecList.pas'
 , l3ProtoPtrRecList in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecList.pas'
 , l3RecListWithPartialFind in 'w:\common\components\rtl\Garant\L3\l3RecListWithPartialFind.pas'
 , l3ProtoPtrRecListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas'
 , ddAppConfigWFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigWFrame.pas'
 , ddAppConfigTFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigTFrame.pas'
 , ddAppConfigBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigBFrame.pas'
 , multimon {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\multimon.pas' {$EndIf}
 , vtSizeablePanel in 'w:\common\components\gui\Garant\VT\vtSizeablePanel.pas'
 , K461701432 in 'w:\common\components\rtl\Garant\Daily\K461701432.pas'
 , K471764286 in 'w:\common\components\rtl\Garant\Daily\K471764286.pas'
 , K460279011 in 'w:\common\components\rtl\Garant\Daily\K460279011.pas'
 , K237503145 in 'w:\common\components\rtl\Garant\Daily\K237503145.pas'
 , K481450949 in 'w:\common\components\rtl\Garant\Daily\K481450949.pas'
 , K480822492 in 'w:\common\components\rtl\Garant\Daily\K480822492.pas'
 , K481811864 in 'w:\common\components\rtl\Garant\Daily\K481811864.pas'
 , K483405717 in 'w:\common\components\rtl\Garant\Daily\K483405717.pas'
 , LostNodeAppConfigTest in 'w:\common\components\rtl\Garant\Daily\LostNodeAppConfigTest.pas'
 , K480825135 in 'w:\common\components\rtl\Garant\Daily\K480825135.pas'
 , DailyTest_7_10_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_10_TestUnit.pas'
 , K493868665 in 'w:\common\components\rtl\Garant\Daily\K493868665.pas'
 , K493324121 in 'w:\common\components\rtl\Garant\Daily\K493324121.pas'
 , K494524369 in 'w:\common\components\rtl\Garant\Daily\K494524369.pas'
 , K494528807 in 'w:\common\components\rtl\Garant\Daily\K494528807.pas'
 , K502351620 in 'w:\common\components\rtl\Garant\Daily\K502351620.pas'
 , K103942050 in 'w:\common\components\rtl\Garant\Daily\K103942050.pas'
 , K509706011 in 'w:\common\components\rtl\Garant\Daily\K509706011.pas'
 , EVDtoRTFRender in 'w:\common\components\rtl\Garant\Abstract_Tests\EVDtoRTFRender.pas'
 , eeEVDtoRTF in 'w:\common\components\rtl\Garant\RenderEVD\eeEVDtoRTF.pas'
 {$If Defined(Nemesis)}
 , F1_Schema in 'w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeDocument_Schema in 'w:\common\components\gui\Garant\Everest_Engine\eeDocument_Schema.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , F1_AttrValues in 'w:\common\components\gui\Garant\Everest_Engine\F1_AttrValues.pas'
 {$IfEnd} // Defined(Nemesis)
 , evNestedDocumentEliminator in 'w:\common\components\gui\Garant\Everest\evNestedDocumentEliminator.pas'
 , evCommentDecorator in 'w:\common\components\gui\Garant\Everest\evCommentDecorator.pas'
 , evCommentParaDecorator in 'w:\common\components\gui\Garant\Everest\evCommentParaDecorator.pas'
 , K509706011_1 in 'w:\common\components\rtl\Garant\Daily\K509706011_1.pas'
 , K509706011_2 in 'w:\common\components\rtl\Garant\Daily\K509706011_2.pas'
 , K512248597 in 'w:\common\components\rtl\Garant\Daily\K512248597.pas'
 , K518756624 in 'w:\common\components\rtl\Garant\Daily\K518756624.pas'
 , K519483189 in 'w:\common\components\rtl\Garant\Daily\K519483189.pas'
 , K530839239 in 'w:\common\components\rtl\Garant\Daily\K530839239.pas'
 , K531957202 in 'w:\common\components\rtl\Garant\Daily\K531957202.pas'
 , K531975039 in 'w:\common\components\rtl\Garant\Daily\K531975039.pas'
 , K371639884 in 'w:\common\components\rtl\Garant\Daily\K371639884.pas'
 , K535902713 in 'w:\common\components\rtl\Garant\Daily\K535902713.pas'
 , K537233020 in 'w:\common\components\rtl\Garant\Daily\K537233020.pas'
 , K537234131 in 'w:\common\components\rtl\Garant\Daily\K537234131.pas'
 , K537954167 in 'w:\common\components\rtl\Garant\Daily\K537954167.pas'
 , K537768536 in 'w:\common\components\rtl\Garant\Daily\K537768536.pas'
 , K537249545 in 'w:\common\components\rtl\Garant\Daily\K537249545.pas'
 , K537974930 in 'w:\common\components\rtl\Garant\Daily\K537974930.pas'
 , K537973036 in 'w:\common\components\rtl\Garant\Daily\K537973036.pas'
 , K537974183 in 'w:\common\components\rtl\Garant\Daily\K537974183.pas'
 , K538546220 in 'w:\common\components\rtl\Garant\Daily\K538546220.pas'
 , K538561126 in 'w:\common\components\rtl\Garant\Daily\K538561126.pas'
 , K538560814 in 'w:\common\components\rtl\Garant\Daily\K538560814.pas'
 , K538566131 in 'w:\common\components\rtl\Garant\Daily\K538566131.pas'
 , K538550781 in 'w:\common\components\rtl\Garant\Daily\K538550781.pas'
 , RTFtoEVDWithiddenTextExtractor in 'w:\common\components\rtl\Garant\Daily\RTFtoEVDWithiddenTextExtractor.pas'
 , dd_lcHiddenTextExtractor in 'w:\common\components\rtl\Garant\dd\dd_lcHiddenTextExtractor.pas'
 , K537973358 in 'w:\common\components\rtl\Garant\Daily\K537973358.pas'
 , K540160887 in 'w:\common\components\rtl\Garant\Daily\K540160887.pas'
 , K538550943 in 'w:\common\components\rtl\Garant\Daily\K538550943.pas'
 , K540412066 in 'w:\common\components\rtl\Garant\Daily\K540412066.pas'
 , K540414443 in 'w:\common\components\rtl\Garant\Daily\K540414443.pas'
 , K540414514 in 'w:\common\components\rtl\Garant\Daily\K540414514.pas'
 , K537232046 in 'w:\common\components\rtl\Garant\Daily\K537232046.pas'
 , K540615571 in 'w:\common\components\rtl\Garant\Daily\K540615571.pas'
 , K541116849 in 'w:\common\components\rtl\Garant\Daily\K541116849.pas'
 , K541120799 in 'w:\common\components\rtl\Garant\Daily\K541120799.pas'
 , K541895041 in 'w:\common\components\rtl\Garant\Daily\K541895041.pas'
 , K543433648 in 'w:\common\components\rtl\Garant\Daily\K543433648.pas'
 , K555392182 in 'w:\common\components\rtl\Garant\Daily\K555392182.pas'
 , K558471539 in 'w:\common\components\rtl\Garant\Daily\K558471539.pas'
 , K558957526 in 'w:\common\components\rtl\Garant\Daily\K558957526.pas'
 , K565008782 in 'w:\common\components\rtl\Garant\Daily\K565008782.pas'
 , K565269737 in 'w:\common\components\rtl\Garant\Daily\K565269737.pas'
 , K568147841 in 'w:\common\components\rtl\Garant\Daily\K568147841.pas'
 , K571646843 in 'w:\common\components\rtl\Garant\Daily\K571646843.pas'
 , DailyTest_BadEVD_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_BadEVD_TestUnit.pas'
 , K553427493 in 'w:\common\components\rtl\Garant\Daily\K553427493.pas'
 , BadEVDTest in 'w:\common\components\rtl\Garant\Daily\BadEVDTest.pas'
 , evdBadEVDToEmptyDocumentTranslator in 'w:\common\components\gui\Garant\Everest\evdBadEVDToEmptyDocumentTranslator.pas'
 , k2TagTranslator in 'w:\common\components\rtl\Garant\K2\k2TagTranslator.pas'
 , K553427493_notBad in 'w:\common\components\rtl\Garant\Daily\K553427493_notBad.pas'
 , DailyTest_RenderFormula_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_RenderFormula_TestUnit.pas'
 , K543448591 in 'w:\common\components\rtl\Garant\Daily\K543448591.pas'
 , K554585756 in 'w:\common\components\rtl\Garant\Daily\K554585756.pas'
 , DailyTest_7_11_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_11_TestUnit.pas'
 , K585129079 in 'w:\common\components\rtl\Garant\Daily\K585129079.pas'
 , K585129079_NSRC in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC.pas'
 , K585129079_NSRC_ANSI in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC_ANSI.pas'
 , K585129079_NSRC_EAST_EUROPE in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC_EAST_EUROPE.pas'
 , K585129079_NSRC_KeepExisting in 'w:\common\components\rtl\Garant\Daily\K585129079_NSRC_KeepExisting.pas'
 , K569230238 in 'w:\common\components\rtl\Garant\Daily\K569230238.pas'
 , K569230238_NSRC in 'w:\common\components\rtl\Garant\Daily\K569230238_NSRC.pas'
 , K569230238_EVD2EVD in 'w:\common\components\rtl\Garant\Daily\K569230238_EVD2EVD.pas'
 , K585940757 in 'w:\common\components\rtl\Garant\Daily\K585940757.pas'
 , K570542913 in 'w:\common\components\rtl\Garant\Daily\K570542913.pas'
 , K585940693 in 'w:\common\components\rtl\Garant\Daily\K585940693.pas'
 , K586353041 in 'w:\common\components\rtl\Garant\Daily\K586353041.pas'
 , K586706776 in 'w:\common\components\rtl\Garant\Daily\K586706776.pas'
 , K586173596 in 'w:\common\components\rtl\Garant\Daily\K586173596.pas'
 , K586185519 in 'w:\common\components\rtl\Garant\Daily\K586185519.pas'
 , K522781517 in 'w:\common\components\rtl\Garant\Daily\K522781517.pas'
 , K522781827 in 'w:\common\components\rtl\Garant\Daily\K522781827.pas'
 , K587155634 in 'w:\common\components\rtl\Garant\Daily\K587155634.pas'
 , K588037593 in 'w:\common\components\rtl\Garant\Daily\K588037593.pas'
 , K589860215 in 'w:\common\components\rtl\Garant\Daily\K589860215.pas'
 , K590528525 in 'w:\common\components\rtl\Garant\Daily\K590528525.pas'
 , K590512137 in 'w:\common\components\rtl\Garant\Daily\K590512137.pas'
 , K590541952 in 'w:\common\components\rtl\Garant\Daily\K590541952.pas'
 , K590745463 in 'w:\common\components\rtl\Garant\Daily\K590745463.pas'
 , K590745831 in 'w:\common\components\rtl\Garant\Daily\K590745831.pas'
 , K590774242 in 'w:\common\components\rtl\Garant\Daily\K590774242.pas'
 , K591142760 in 'w:\common\components\rtl\Garant\Daily\K591142760.pas'
 , K590757091 in 'w:\common\components\rtl\Garant\Daily\K590757091.pas'
 , K590758825 in 'w:\common\components\rtl\Garant\Daily\K590758825.pas'
 , K592250384 in 'w:\common\components\rtl\Garant\Daily\K592250384.pas'
 , K592251812 in 'w:\common\components\rtl\Garant\Daily\K592251812.pas'
 , K595456849 in 'w:\common\components\rtl\Garant\Daily\K595456849.pas'
 , K595967367 in 'w:\common\components\rtl\Garant\Daily\K595967367.pas'
 , K595976509 in 'w:\common\components\rtl\Garant\Daily\K595976509.pas'
 , K596385595 in 'w:\common\components\rtl\Garant\Daily\K596385595.pas'
 , K596386207 in 'w:\common\components\rtl\Garant\Daily\K596386207.pas'
 , K596385658 in 'w:\common\components\rtl\Garant\Daily\K596385658.pas'
 , K596385821 in 'w:\common\components\rtl\Garant\Daily\K596385821.pas'
 , K598118986 in 'w:\common\components\rtl\Garant\Daily\K598118986.pas'
 , K598131905 in 'w:\common\components\rtl\Garant\Daily\K598131905.pas'
 , K599800930 in 'w:\common\components\rtl\Garant\Daily\K599800930.pas'
 , K600665073 in 'w:\common\components\rtl\Garant\Daily\K600665073.pas'
 , K600945017 in 'w:\common\components\rtl\Garant\Daily\K600945017.pas'
 , K601206322 in 'w:\common\components\rtl\Garant\Daily\K601206322.pas'
 , K601992686 in 'w:\common\components\rtl\Garant\Daily\K601992686.pas'
 , K602000766 in 'w:\common\components\rtl\Garant\Daily\K602000766.pas'
 , K602940462 in 'w:\common\components\rtl\Garant\Daily\K602940462.pas'
 , K602940495 in 'w:\common\components\rtl\Garant\Daily\K602940495.pas'
 , K601686929 in 'w:\common\components\rtl\Garant\Daily\K601686929.pas'
 , K602703982 in 'w:\common\components\rtl\Garant\Daily\K602703982.pas'
 , K602943932 in 'w:\common\components\rtl\Garant\Daily\K602943932.pas'
 , K601462517 in 'w:\common\components\rtl\Garant\Daily\K601462517.pas'
 , K604494903 in 'w:\common\components\rtl\Garant\Daily\K604494903.pas'
 , K604920400 in 'w:\common\components\rtl\Garant\Daily\K604920400.pas'
 , K603416415 in 'w:\common\components\rtl\Garant\Daily\K603416415.pas'
 , K605147298 in 'w:\common\components\rtl\Garant\Daily\K605147298.pas'
 , K605380857 in 'w:\common\components\rtl\Garant\Daily\K605380857.pas'
 , K604908954 in 'w:\common\components\rtl\Garant\Daily\K604908954.pas'
 , K605843892 in 'w:\common\components\rtl\Garant\Daily\K605843892.pas'
 , K606111976 in 'w:\common\components\rtl\Garant\Daily\K606111976.pas'
 , K606118757 in 'w:\common\components\rtl\Garant\Daily\K606118757.pas'
 , K606129271 in 'w:\common\components\rtl\Garant\Daily\K606129271.pas'
 , K606138650 in 'w:\common\components\rtl\Garant\Daily\K606138650.pas'
 , K588577774 in 'w:\common\components\rtl\Garant\Daily\K588577774.pas'
 , K606634250 in 'w:\common\components\rtl\Garant\Daily\K606634250.pas'
 , K606129412 in 'w:\common\components\rtl\Garant\Daily\K606129412.pas'
 , K606808862 in 'w:\common\components\rtl\Garant\Daily\K606808862.pas'
 , K606808786 in 'w:\common\components\rtl\Garant\Daily\K606808786.pas'
 , K607532057 in 'w:\common\components\rtl\Garant\Daily\K607532057.pas'
 , K607532796 in 'w:\common\components\rtl\Garant\Daily\K607532796.pas'
 , K607532072 in 'w:\common\components\rtl\Garant\Daily\K607532072.pas'
 , K607750753 in 'w:\common\components\rtl\Garant\Daily\K607750753.pas'
 , K607284377 in 'w:\common\components\rtl\Garant\Daily\K607284377.pas'
 , l3IntegerToIntegerMapTest in 'w:\common\components\rtl\Garant\Daily\l3IntegerToIntegerMapTest.pas'
 , l3IntegerToIntegerMap in 'w:\common\components\rtl\Garant\L3\l3IntegerToIntegerMap.pas'
 , l3StringToStringMapTest in 'w:\common\components\rtl\Garant\Daily\l3StringToStringMapTest.pas'
 , l3StringToStringMap in 'w:\common\components\rtl\Garant\L3\l3StringToStringMap.pas'
 , DailyTest_Containers_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_Containers_TestUnit.pas'
 , tfwParserTokenListTest in 'w:\common\components\rtl\Garant\Daily\tfwParserTokenListTest.pas'
 , testCConstDelphiString in 'w:\common\components\rtl\Garant\Daily\testCConstDelphiString.pas'
 , DailyTest_DecorText_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_DecorText_TestUnit.pas'
 , K604929313 in 'w:\common\components\rtl\Garant\Daily\K604929313.pas'
 , K604929290 in 'w:\common\components\rtl\Garant\Daily\K604929290.pas'
 , DailyTest_Unicode_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_Unicode_TestUnit.pas'
 , K605362960 in 'w:\common\components\rtl\Garant\Daily\K605362960.pas'
 , DailyTest_7_12_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_7_12_TestUnit.pas'
 , K607751255 in 'w:\common\components\rtl\Garant\Daily\K607751255.pas'
 , K608627112 in 'w:\common\components\rtl\Garant\Daily\K608627112.pas'
 , K608626880 in 'w:\common\components\rtl\Garant\Daily\K608626880.pas'
 , K598131874 in 'w:\common\components\rtl\Garant\Daily\K598131874.pas'
 , K598136171 in 'w:\common\components\rtl\Garant\Daily\K598136171.pas'
 , K607531290 in 'w:\common\components\rtl\Garant\Daily\K607531290.pas'
 , K608627000 in 'w:\common\components\rtl\Garant\Daily\K608627000.pas'
 , K608627000_Back in 'w:\common\components\rtl\Garant\Daily\K608627000_Back.pas'
 , K607531290_Back in 'w:\common\components\rtl\Garant\Daily\K607531290_Back.pas'
 , K608627000_Restore in 'w:\common\components\rtl\Garant\Daily\K608627000_Restore.pas'
 , UnicodeFormulasToUnicodeConverterTest in 'w:\common\components\rtl\Garant\Daily\UnicodeFormulasToUnicodeConverterTest.pas'
 , evUnicodeFormulasToUnicodeConverter in 'w:\common\components\gui\Garant\Everest\evUnicodeFormulasToUnicodeConverter.pas'
 , K598136171_Restore in 'w:\common\components\rtl\Garant\Daily\K598136171_Restore.pas'
 , K609131924 in 'w:\common\components\rtl\Garant\Daily\K609131924.pas'
 , K607275587 in 'w:\common\components\rtl\Garant\Daily\K607275587.pas'
 , K609886857 in 'w:\common\components\rtl\Garant\Daily\K609886857.pas'
 , K609602166 in 'w:\common\components\rtl\Garant\Daily\K609602166.pas'
 , K609132323 in 'w:\common\components\rtl\Garant\Daily\K609132323.pas'
 , K610084627 in 'w:\common\components\rtl\Garant\Daily\K610084627.pas'
 , K607284891 in 'w:\common\components\rtl\Garant\Daily\K607284891.pas'
 , K138969449 in 'w:\common\components\rtl\Garant\Daily\K138969449.pas'
 , K610503532 in 'w:\common\components\rtl\Garant\Daily\K610503532.pas'
 , K610504218 in 'w:\common\components\rtl\Garant\Daily\K610504218.pas'
 , K610745702 in 'w:\common\components\rtl\Garant\Daily\K610745702.pas'
 , K610745715 in 'w:\common\components\rtl\Garant\Daily\K610745715.pas'
 , K610745778 in 'w:\common\components\rtl\Garant\Daily\K610745778.pas'
 , K610746048 in 'w:\common\components\rtl\Garant\Daily\K610746048.pas'
 , K611827116 in 'w:\common\components\rtl\Garant\Daily\K611827116.pas'
 , K612077455 in 'w:\common\components\rtl\Garant\Daily\K612077455.pas'
 , K611202391 in 'w:\common\components\rtl\Garant\Daily\K611202391.pas'
 , K611189558 in 'w:\common\components\rtl\Garant\Daily\K611189558.pas'
 , K610951982 in 'w:\common\components\rtl\Garant\Daily\K610951982.pas'
 , K612741573 in 'w:\common\components\rtl\Garant\Daily\K612741573.pas'
 , K612548965 in 'w:\common\components\rtl\Garant\Daily\K612548965.pas'
 , K611646760 in 'w:\common\components\rtl\Garant\Daily\K611646760.pas'
 , K612968853 in 'w:\common\components\rtl\Garant\Daily\K612968853.pas'
 , K613289134 in 'w:\common\components\rtl\Garant\Daily\K613289134.pas'
 , K613531272 in 'w:\common\components\rtl\Garant\Daily\K613531272.pas'
 , K613540313 in 'w:\common\components\rtl\Garant\Daily\K613540313.pas'
 , K613740482 in 'w:\common\components\rtl\Garant\Daily\K613740482.pas'
 , K615114722 in 'w:\common\components\rtl\Garant\Daily\K615114722.pas'
 , K615679638 in 'w:\common\components\rtl\Garant\Daily\K615679638.pas'
 , K615706665 in 'w:\common\components\rtl\Garant\Daily\K615706665.pas'
 , K616227557 in 'w:\common\components\rtl\Garant\Daily\K616227557.pas'
 , HTMLtoEVDWithURLTest in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDWithURLTest.pas'
 , K615931438 in 'w:\common\components\rtl\Garant\Daily\K615931438.pas'
 , K616409737 in 'w:\common\components\rtl\Garant\Daily\K616409737.pas'
 , K616228169 in 'w:\common\components\rtl\Garant\Daily\K616228169.pas'
 , RTFtoEVDWithURL in 'w:\common\components\rtl\Garant\Daily\RTFtoEVDWithURL.pas'
 , K616564654 in 'w:\common\components\rtl\Garant\Daily\K616564654.pas'
 , K616562811 in 'w:\common\components\rtl\Garant\Daily\K616562811.pas'
 , K616411367 in 'w:\common\components\rtl\Garant\Daily\K616411367.pas'
 , K615931453 in 'w:\common\components\rtl\Garant\Daily\K615931453.pas'
 , K617055896 in 'w:\common\components\rtl\Garant\Daily\K617055896.pas'
 , K616410378 in 'w:\common\components\rtl\Garant\Daily\K616410378.pas'
 , K617064868 in 'w:\common\components\rtl\Garant\Daily\K617064868.pas'
 , K617316346 in 'w:\common\components\rtl\Garant\Daily\K617316346.pas'
 , HTMLtoEVDWithApplyTextCorrections in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDWithApplyTextCorrections.pas'
 , K618269589 in 'w:\common\components\rtl\Garant\Daily\K618269589.pas'
 , K618678791 in 'w:\common\components\rtl\Garant\Daily\K618678791.pas'
 , HTMLtoEVDFull in 'w:\common\components\rtl\Garant\Daily\HTMLtoEVDFull.pas'
 , K617776885 in 'w:\common\components\rtl\Garant\Daily\K617776885.pas'
 , K617776901 in 'w:\common\components\rtl\Garant\Daily\K617776901.pas'
 , K619321401 in 'w:\common\components\rtl\Garant\Daily\K619321401.pas'
 , EVDtoHTMLWithExternalHyperlinks in 'w:\common\components\rtl\Garant\Daily\EVDtoHTMLWithExternalHyperlinks.pas'
 , K619338871 in 'w:\common\components\rtl\Garant\Daily\K619338871.pas'
 , K619559603 in 'w:\common\components\rtl\Garant\Daily\K619559603.pas'
 , K619320841 in 'w:\common\components\rtl\Garant\Daily\K619320841.pas'
 , K619724818 in 'w:\common\components\rtl\Garant\Daily\K619724818.pas'
 , K619577264 in 'w:\common\components\rtl\Garant\Daily\K619577264.pas'
 , K619577264_1 in 'w:\common\components\rtl\Garant\Daily\K619577264_1.pas'
 , K619577264_2 in 'w:\common\components\rtl\Garant\Daily\K619577264_2.pas'
 , K615938312 in 'w:\common\components\rtl\Garant\Daily\K615938312.pas'
 , K615938312_1 in 'w:\common\components\rtl\Garant\Daily\K615938312_1.pas'
 , K619732685 in 'w:\common\components\rtl\Garant\Daily\K619732685.pas'
 , K619725311 in 'w:\common\components\rtl\Garant\Daily\K619725311.pas'
 , K619725459 in 'w:\common\components\rtl\Garant\Daily\K619725459.pas'
 , K619724818_1 in 'w:\common\components\rtl\Garant\Daily\K619724818_1.pas'
 , K619938529 in 'w:\common\components\rtl\Garant\Daily\K619938529.pas'
 , K620674333 in 'w:\common\components\rtl\Garant\Daily\K620674333.pas'
 , K621258431 in 'w:\common\components\rtl\Garant\Daily\K621258431.pas'
 , K622418668 in 'w:\common\components\rtl\Garant\Daily\K622418668.pas'
 , DailyTest_Diff_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_Diff_TestUnit.pas'
 , DiffTest in 'w:\common\components\rtl\Garant\Daily\DiffTest.pas'
 , l3Diff in 'w:\common\components\rtl\Garant\L3\l3Diff.pas'
 , l3DiffSupport in 'w:\common\components\rtl\Garant\L3\l3DiffSupport.pas'
 , DailyTest_CrossSegments_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_CrossSegments_TestUnit.pas'
 , K619938320 in 'w:\common\components\rtl\Garant\Daily\K619938320.pas'
 , K619938320_1 in 'w:\common\components\rtl\Garant\Daily\K619938320_1.pas'
 , K619938320_2 in 'w:\common\components\rtl\Garant\Daily\K619938320_2.pas'
 , K619944727_D910b0036111 in 'w:\common\components\rtl\Garant\Daily\K619944727_D910b0036111.pas'
 , K619944727_H10900014 in 'w:\common\components\rtl\Garant\Daily\K619944727_H10900014.pas'
 , K619944727_H11000168 in 'w:\common\components\rtl\Garant\Daily\K619944727_H11000168.pas'
 , K619944727_H11000224 in 'w:\common\components\rtl\Garant\Daily\K619944727_H11000224.pas'
 , K619944727_H11000224_1 in 'w:\common\components\rtl\Garant\Daily\K619944727_H11000224_1.pas'
 , K619944727_H11000224_2 in 'w:\common\components\rtl\Garant\Daily\K619944727_H11000224_2.pas'
 , K619944727_R910m0034956 in 'w:\common\components\rtl\Garant\Daily\K619944727_R910m0034956.pas'
 , K620241155_Hk0200166 in 'w:\common\components\rtl\Garant\Daily\K620241155_Hk0200166.pas'
 , K620241155_Hk0200166_1 in 'w:\common\components\rtl\Garant\Daily\K620241155_Hk0200166_1.pas'
 , K620241155_Hk0800412 in 'w:\common\components\rtl\Garant\Daily\K620241155_Hk0800412.pas'
 , K620241155_HK9900295 in 'w:\common\components\rtl\Garant\Daily\K620241155_HK9900295.pas'
 , K620241155_HK9900296 in 'w:\common\components\rtl\Garant\Daily\K620241155_HK9900296.pas'
 , K620241155_Hk0800412_1 in 'w:\common\components\rtl\Garant\Daily\K620241155_Hk0800412_1.pas'
 , K620262073_C20900337 in 'w:\common\components\rtl\Garant\Daily\K620262073_C20900337.pas'
 , K620262073_C20900337_1 in 'w:\common\components\rtl\Garant\Daily\K620262073_C20900337_1.pas'
 , K620262073_D910n0036915 in 'w:\common\components\rtl\Garant\Daily\K620262073_D910n0036915.pas'
 , K620262073_D910n0036950 in 'w:\common\components\rtl\Garant\Daily\K620262073_D910n0036950.pas'
 , K620262073_W210p0293 in 'w:\common\components\rtl\Garant\Daily\K620262073_W210p0293.pas'
 , K620262073_W21328134p in 'w:\common\components\rtl\Garant\Daily\K620262073_W21328134p.pas'
 , K620262073_W21428490p in 'w:\common\components\rtl\Garant\Daily\K620262073_W21428490p.pas'
 , K620262073_W21428490p_1 in 'w:\common\components\rtl\Garant\Daily\K620262073_W21428490p_1.pas'
 , K620262073_C20900337_2 in 'w:\common\components\rtl\Garant\Daily\K620262073_C20900337_2.pas'
 , K620262073_C20900337_3 in 'w:\common\components\rtl\Garant\Daily\K620262073_C20900337_3.pas'
 , K620262073_C20900337_4 in 'w:\common\components\rtl\Garant\Daily\K620262073_C20900337_4.pas'
 , K620262073_W21328134p_1 in 'w:\common\components\rtl\Garant\Daily\K620262073_W21328134p_1.pas'
 , K620262073_W210p0293_1 in 'w:\common\components\rtl\Garant\Daily\K620262073_W210p0293_1.pas'
 , K620665614_B20410989 in 'w:\common\components\rtl\Garant\Daily\K620665614_B20410989.pas'
 , K620665614_C21100713 in 'w:\common\components\rtl\Garant\Daily\K620665614_C21100713.pas'
 , K620665614_H11100322 in 'w:\common\components\rtl\Garant\Daily\K620665614_H11100322.pas'
 , K620665614_H11300096 in 'w:\common\components\rtl\Garant\Daily\K620665614_H11300096.pas'
 , K620665614_H11300096_1 in 'w:\common\components\rtl\Garant\Daily\K620665614_H11300096_1.pas'
 , K620665614_H11400224 in 'w:\common\components\rtl\Garant\Daily\K620665614_H11400224.pas'
 , K620665614_H11400224_1 in 'w:\common\components\rtl\Garant\Daily\K620665614_H11400224_1.pas'
 , K620665614_Hk0900071 in 'w:\common\components\rtl\Garant\Daily\K620665614_Hk0900071.pas'
 , K620665614_W21428490p in 'w:\common\components\rtl\Garant\Daily\K620665614_W21428490p.pas'
 , DailyTest_8_0_TestUnit in 'w:\common\components\rtl\Garant\Daily\DailyTest_8_0_TestUnit.pas'
 , K622402617 in 'w:\common\components\rtl\Garant\Daily\K622402617.pas'
 , K622840683 in 'w:\common\components\rtl\Garant\Daily\K622840683.pas'
 , K623067981 in 'w:\common\components\rtl\Garant\Daily\K623067981.pas'
 , EVDtoHTMLwoCSS in 'w:\common\components\rtl\Garant\Daily\EVDtoHTMLwoCSS.pas'
 , ddProfNewsHTMLWriter in 'w:\common\components\rtl\Garant\dd\ddProfNewsHTMLWriter.pas'
 , ddStyleSegment in 'w:\common\components\rtl\Garant\dd\ddStyleSegment.pas'
 , K623486769 in 'w:\common\components\rtl\Garant\Daily\K623486769.pas'
 , K623486769_1 in 'w:\common\components\rtl\Garant\Daily\K623486769_1.pas'
 , K623486769_2 in 'w:\common\components\rtl\Garant\Daily\K623486769_2.pas'
 , K623486769_3 in 'w:\common\components\rtl\Garant\Daily\K623486769_3.pas'
 , K623486769_4 in 'w:\common\components\rtl\Garant\Daily\K623486769_4.pas'
 , K623486769_5 in 'w:\common\components\rtl\Garant\Daily\K623486769_5.pas'
 , K623486769_6 in 'w:\common\components\rtl\Garant\Daily\K623486769_6.pas'
 , K623486769_7 in 'w:\common\components\rtl\Garant\Daily\K623486769_7.pas'
 , K624074743 in 'w:\common\components\rtl\Garant\Daily\K624074743.pas'
 , K624690924 in 'w:\common\components\rtl\Garant\Daily\K624690924.pas'
 , K624692225 in 'w:\common\components\rtl\Garant\Daily\K624692225.pas'
 , K624709249 in 'w:\common\components\rtl\Garant\Daily\K624709249.pas'
 , K624692225_1 in 'w:\common\components\rtl\Garant\Daily\K624692225_1.pas'
 , K624853474 in 'w:\common\components\rtl\Garant\Daily\K624853474.pas'
 , K627006470 in 'w:\common\components\rtl\Garant\Daily\K627006470.pas'
 , K627385907 in 'w:\common\components\rtl\Garant\Daily\K627385907.pas'
 , K627817772 in 'w:\common\components\rtl\Garant\Daily\K627817772.pas'
 , K628097544 in 'w:\common\components\rtl\Garant\Daily\K628097544.pas'
 , K630212534 in 'w:\common\components\rtl\Garant\Daily\K630212534.pas'
 , K630402726 in 'w:\common\components\rtl\Garant\Daily\K630402726.pas'
 , K631435596 in 'w:\common\components\rtl\Garant\Daily\K631435596.pas'
 , Abstract_Tests_TestLibrary in 'w:\common\components\rtl\Garant\Abstract_Tests\Abstract_Tests_TestLibrary.pas'
 , Abstract_Tests_EditorTests_TestUnit in 'w:\common\components\rtl\Garant\Abstract_Tests\Abstract_Tests_EditorTests_TestUnit.pas'
 , Abstract_Tests_RenderEVD_TestUnit in 'w:\common\components\rtl\Garant\Abstract_Tests\Abstract_Tests_RenderEVD_TestUnit.pas'
 , Abstract_Tests_CheckFilesInFolderTest_TestUnit in 'w:\common\components\rtl\Garant\Abstract_Tests\Abstract_Tests_CheckFilesInFolderTest_TestUnit.pas'
 , Abstract_Archi_Tests_TestLibrary in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\Abstract_Archi_Tests_TestLibrary.pas'
 , Abstract_Archi_Tests_Filters_TestUnit in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\Abstract_Archi_Tests_Filters_TestUnit.pas'
 , Abstract_Archi_Tests_Storage_TestUnit in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\Abstract_Archi_Tests_Storage_TestUnit.pas'
 , Abstract_Archi_Tests_DataBase_TestUnit in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\Abstract_Archi_Tests_DataBase_TestUnit.pas'
 , Archi_Tests_TestLibrary in 'w:\common\components\rtl\Garant\Archi_Tests\Archi_Tests_TestLibrary.pas'
 , Archi_Tests_Tags_TestUnit in 'w:\common\components\rtl\Garant\Archi_Tests\Archi_Tests_Tags_TestUnit.pas'
 , K275780190 in 'w:\common\components\rtl\Garant\Archi_Tests\K275780190.pas'
 , Archi_Tests_Filters_TestUnit in 'w:\common\components\rtl\Garant\Archi_Tests\Archi_Tests_Filters_TestUnit.pas'
 , K294595323 in 'w:\common\components\rtl\Garant\Archi_Tests\K294595323.pas'
 , AACFiltersTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\AACFiltersTest.pas'
 , evEvdWriter in 'w:\common\components\gui\Garant\Everest\evEvdWriter.pas'
 , dd_lcTextFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcTextFormatter.pas'
 , dd_lcBaseFilter in 'w:\common\components\rtl\Garant\dd\dd_lcBaseFilter.pas'
 , ddHeaderFilter in 'w:\common\components\rtl\Garant\dd\ddHeaderFilter.pas'
 , dd_lcSectionEliminator in 'w:\common\components\rtl\Garant\dd\dd_lcSectionEliminator.pas'
 , ddSpaceTrimmer in 'w:\common\components\rtl\Garant\dd\ddSpaceTrimmer.pas'
 , dd_lcTableEliminator in 'w:\common\components\rtl\Garant\dd\dd_lcTableEliminator.pas'
 , evEvdReader in 'w:\common\components\gui\Garant\Everest\evEvdReader.pas'
 , dd_lcPageNumberEliminator in 'w:\common\components\rtl\Garant\dd\dd_lcPageNumberEliminator.pas'
 , dd_lcVASCodeCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcVASCodeCorrector.pas'
 , dd_lcCodeCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcCodeCorrector.pas'
 , dd_lcYearCodeCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcYearCodeCorrector.pas'
 , dd_lcTypeConverter in 'w:\common\components\rtl\Garant\dd\dd_lcTypeConverter.pas'
 , dd_lcBaseDocFilter in 'w:\common\components\rtl\Garant\dd\dd_lcBaseDocFilter.pas'
 , ddDocumentFilter in 'w:\common\components\rtl\Garant\dd\ddDocumentFilter.pas'
 , dd_lcSourceConverter in 'w:\common\components\rtl\Garant\dd\dd_lcSourceConverter.pas'
 , dd_lcVASSourceCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcVASSourceCorrector.pas'
 , dd_lcResolutionFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcResolutionFormatter.pas'
 , dd_lcTextFormatter2 in 'w:\common\components\rtl\Garant\dd\dd_lcTextFormatter2.pas'
 , dd_lcJudgeFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcJudgeFormatter.pas'
 , dd_lcDateNumberFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcDateNumberFormatter.pas'
 , dd_lcCityNameFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcCityNameFormatter.pas'
 , dd_lcTitleFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcTitleFormatter.pas'
 , dd_lcStartDocFormatter in 'w:\common\components\rtl\Garant\dd\dd_lcStartDocFormatter.pas'
 , dd_lcTextStyleCorrector in 'w:\common\components\rtl\Garant\dd\dd_lcTextStyleCorrector.pas'
 , dd_lcTextSplitter in 'w:\common\components\rtl\Garant\dd\dd_lcTextSplitter.pas'
 , K294595323Suite in 'w:\common\components\rtl\Garant\Archi_Tests\K294595323Suite.pas'
 , Archi_Tests_DBTests_TestUnit in 'w:\common\components\rtl\Garant\Archi_Tests\Archi_Tests_DBTests_TestUnit.pas'
 , K327821495 in 'w:\common\components\rtl\Garant\Archi_Tests\K327821495.pas'
 , StgIndexTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\StgIndexTest.pas'
 , m3SplittedFileStream in 'w:\common\components\rtl\Garant\m3\m3SplittedFileStream.pas'
 , m3BaseStream in 'w:\common\components\rtl\Garant\m3\m3BaseStream.pas'
 , m3PrimStream in 'w:\common\components\rtl\Garant\m3\m3PrimStream.pas'
 , m3StorageInterfaces in 'w:\common\components\rtl\Garant\m3\m3StorageInterfaces.pas'
 , m3StorageTypes in 'w:\common\components\rtl\Garant\m3\m3StorageTypes.pas'
 , m2InternalInterfaces in 'w:\common\components\rtl\Garant\L3\m2\m2InternalInterfaces.pas'
 , m2COMLib in 'w:\common\components\rtl\Garant\L3\m2\m2COMLib.pas'
 , ComObj {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas' {$EndIf}
 , m3FileStream in 'w:\common\components\rtl\Garant\m3\m3FileStream.pas'
 , m3FileStreamMapView in 'w:\common\components\rtl\Garant\m3\m3FileStreamMapView.pas'
 , m2AddPrc in 'w:\common\components\rtl\Garant\L3\m2\m2AddPrc.pas'
 , m3StorageIndexAdapter in 'w:\common\components\rtl\Garant\TestsSupport\m3StorageIndexAdapter.pas'
 , m4DBInterfaces in 'w:\common\components\rtl\Garant\m4\m4DBInterfaces.pas'
 , m3Interfaces in 'w:\common\components\rtl\Garant\m3\m3Interfaces.pas'
 , m3DBInterfaces in 'w:\common\components\rtl\Garant\m3\m3DBInterfaces.pas'
 , m3DBTypes in 'w:\common\components\rtl\Garant\m3\m3DBTypes.pas'
 , m4DB in 'w:\common\components\rtl\Garant\m4\m4DB.pas'
 , m3DB in 'w:\common\components\rtl\Garant\m3\m3DB.pas'
 , m3BaseObject in 'w:\common\components\rtl\Garant\m3\m3BaseObject.pas'
 , m3PrimDB in 'w:\common\components\rtl\Garant\m3\m3PrimDB.pas'
 , l3ProxyStream in 'w:\common\components\rtl\Garant\L3\l3ProxyStream.pas'
 , m3BackupTools in 'w:\common\components\rtl\Garant\m3\m3BackupTools.pas'
 , m3StorageTools in 'w:\common\components\rtl\Garant\m3\m3StorageTools.pas'
 , m3StgMgr in 'w:\common\components\rtl\Garant\m3\m3StgMgr.pas'
 , m3ArchiveStorage in 'w:\common\components\rtl\Garant\m3\m3ArchiveStorage.pas'
 , m3NewStorage in 'w:\common\components\rtl\Garant\m3\m3NewStorage.pas'
 , m3CustomNewStorage in 'w:\common\components\rtl\Garant\m3\m3CustomNewStorage.pas'
 , m3NewStoragePrim in 'w:\common\components\rtl\Garant\m3\m3NewStoragePrim.pas'
 , m3CommonStorage in 'w:\common\components\rtl\Garant\m3\m3CommonStorage.pas'
 , m3StoragePrim in 'w:\common\components\rtl\Garant\m3\m3StoragePrim.pas'
 , m3BaseStorage in 'w:\common\components\rtl\Garant\m3\m3BaseStorage.pas'
 , m3BaseStore in 'w:\common\components\rtl\Garant\m3\m3BaseStore.pas'
 , m3TOCHandleList in 'w:\common\components\rtl\Garant\m3\m3TOCHandleList.pas'
 , m3TOCHandle in 'w:\common\components\rtl\Garant\m3\m3TOCHandle.pas'
 , m3Persistent in 'w:\common\components\rtl\Garant\m3\m3Persistent.pas'
 , m3RootStreamManagerPrim in 'w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrim.pas'
 , m3RootStreamManagerPrimPrim in 'w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrimPrim.pas'
 , l3Logger in 'w:\common\components\rtl\Garant\L3\l3Logger.pas'
 , l3ExceptionsLogEx in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLogEx.pas'
 , m3FileRegion in 'w:\common\components\rtl\Garant\m3\m3FileRegion.pas'
 , m3StoreHeaderDataPrim in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderDataPrim.pas'
 , m3Exceptions in 'w:\common\components\rtl\Garant\m3\m3Exceptions.pas'
 , m3BuffStream in 'w:\common\components\rtl\Garant\m3\m3BuffStream.pas'
 , m3CustomStream in 'w:\common\components\rtl\Garant\m3\m3CustomStream.pas'
 , m2S32Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S32Lib.pas'
 , m2S64Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S64Lib.pas'
 , m3Const in 'w:\common\components\rtl\Garant\m3\m3Const.pas'
 , m3CommonStorageStream in 'w:\common\components\rtl\Garant\m3\m3CommonStorageStream.pas'
 , m3StoreHeader in 'w:\common\components\rtl\Garant\m3\m3StoreHeader.pas'
 , m3StorageIndexStreamForIterate in 'w:\common\components\rtl\Garant\m3\m3StorageIndexStreamForIterate.pas'
 , m3StorageIndexStream in 'w:\common\components\rtl\Garant\m3\m3StorageIndexStream.pas'
 , m3NewStorageStream in 'w:\common\components\rtl\Garant\m3\m3NewStorageStream.pas'
 , m3NewStorageStreamPrim in 'w:\common\components\rtl\Garant\m3\m3NewStorageStreamPrim.pas'
 , m3StorageBlock in 'w:\common\components\rtl\Garant\m3\m3StorageBlock.pas'
 , m3StorageTableOfContentsStream in 'w:\common\components\rtl\Garant\m3\m3StorageTableOfContentsStream.pas'
 , m3ReadOnlyRootStreamManager in 'w:\common\components\rtl\Garant\m3\m3ReadOnlyRootStreamManager.pas'
 , m3NewRootStreamManager in 'w:\common\components\rtl\Garant\m3\m3NewRootStreamManager.pas'
 , m3RootStreamManager in 'w:\common\components\rtl\Garant\m3\m3RootStreamManager.pas'
 , m3RootStream in 'w:\common\components\rtl\Garant\m3\m3RootStream.pas'
 , m3BaseHeaderStream in 'w:\common\components\rtl\Garant\m3\m3BaseHeaderStream.pas'
 , m3LinkedStream in 'w:\common\components\rtl\Garant\m3\m3LinkedStream.pas'
 , m2AddDbg in 'w:\common\components\rtl\Garant\L3\m2\m2AddDbg.pas'
 , l3Int64List in 'w:\common\components\rtl\Garant\L3\l3Int64List.pas'
 , l3RevertedInt64List in 'w:\common\components\rtl\Garant\L3\l3RevertedInt64List.pas'
 , m3StoreHeaderData in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderData.pas'
 , m3StoreHeaderDataNew in 'w:\common\components\rtl\Garant\m3\m3StoreHeaderDataNew.pas'
 , m3RootStreamNew in 'w:\common\components\rtl\Garant\m3\m3RootStreamNew.pas'
 , m3TempEnumStatStg in 'w:\common\components\rtl\Garant\m3\m3TempEnumStatStg.pas'
 , m3BaseEnumStatStg in 'w:\common\components\rtl\Garant\m3\m3BaseEnumStatStg.pas'
 , m3StorageService in 'w:\common\components\rtl\Garant\m3\m3StorageService.pas'
 , m3StorageElementIDList in 'w:\common\components\rtl\Garant\m3\m3StorageElementIDList.pas'
 , m3DBProxyWriteStream in 'w:\common\components\rtl\Garant\m3\m3DBProxyWriteStream.pas'
 , m3DBProxyStream in 'w:\common\components\rtl\Garant\m3\m3DBProxyStream.pas'
 , m3DBActions in 'w:\common\components\rtl\Garant\m3\m3DBActions.pas'
 , m3DBDocument in 'w:\common\components\rtl\Garant\m3\m3DBDocument.pas'
 , m3DBDocumentPart in 'w:\common\components\rtl\Garant\m3\m3DBDocumentPart.pas'
 , m3NewVersionStream in 'w:\common\components\rtl\Garant\m3\m3NewVersionStream.pas'
 , l3ForkStream in 'w:\common\components\rtl\Garant\L3\l3ForkStream.pas'
 , m3DBFiler in 'w:\common\components\rtl\Garant\m3\m3DBFiler.pas'
 , K392696007 in 'w:\common\components\rtl\Garant\Archi_Tests\K392696007.pas'
 , MultyOperationTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\MultyOperationTest.pas'
 , DataBaseTester in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\DataBaseTester.pas'
 , Archi_Tests_Storage_TestUnit in 'w:\common\components\rtl\Garant\Archi_Tests\Archi_Tests_Storage_TestUnit.pas'
 , K361038156 in 'w:\common\components\rtl\Garant\Archi_Tests\K361038156.pas'
 , ArchiStorageTest in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTest.pas'
 , K365838449 in 'w:\common\components\rtl\Garant\Archi_Tests\K365838449.pas'
 , ArchiStorageTestWithRename in 'w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTestWithRename.pas'
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
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
