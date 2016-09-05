program ArchiTest;
 {* Тесты Арчи }

// Модуль: "w:\archi\source\projects\Archi\ArchiTest.dpr"
// Стереотип: "TestTarget"
// Элемент модели: "Archi" MUID: (4DE4A1D0031E)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , l3ImplUses
 , l3ExceptionsLog in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLog.pas'
 {$If NOT Defined(NoScripts)}
 , ObjectFromstackWords in 'w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwClassLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassLike.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwRegisterableWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwRegisterableWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWordPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingInterfaces.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas'
 , ActiveX {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas' {$EndIf}
 , Windows {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas' {$EndIf}
 , Types
 , l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas'
 , Messages {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas' {$EndIf}
 , Graphics {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas' {$EndIf}
 , Classes {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas' {$EndIf}
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy in 'w:\common\components\rtl\Garant\ScriptEngine\TtfwTypeRegistrator_Proxy.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , TypInfo {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas' {$EndIf}
 {$If NOT Defined(NoScripts)}
 , tfwPropertyLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwPropertyLike.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeInfo in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfo.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingExceptions in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy in 'w:\common\components\rtl\Garant\ScriptEngine\TtfwClassRef_Proxy.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TypeInfoPack in 'w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwGlobalKeyWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwGlobalKeyWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingTypes.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypes.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , tfwIl3CStringPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIteratableParent in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIteratableParentPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParentPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwSafeArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSafeArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArray.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStoredValuesStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPrimPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStoredValues in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledVar in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSourcePointWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSourcePointWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwKeyWordPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeyWordPrim.pas'
 {$If NOT Defined(NoScripts)}
 , tfwWordRefList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwThreadVar in 'w:\common\components\rtl\Garant\ScriptEngine\tfwThreadVar.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwThreadVarPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwThreadVarPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorkerEx.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordWorker.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwAnonimousWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAnonimousWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwCompilingWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompilingWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas'
 , l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas'
 {$If NOT Defined(NoScripts)}
 , kwCompiledWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwRuntimeWordWithCodeExecution in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCodeExecution.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwRuntimeWordWithCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwRuntimeWordWithCode.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwForwardDeclarationHolder in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclarationHolder.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionary.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , Math {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas' {$EndIf}
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwMembersIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwMembersIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIteratorPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineExInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineExInterfaces.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryEx in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryEx.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryExPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPtrList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStreamFactory.pas'
 {$If NOT Defined(NoScripts)}
 , tfwInitCodeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitCodeWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwAutoregisteredDiction in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAutoregisteredDiction.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStandardDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionary.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStandardDictionaries in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaries.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStandardDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStandardDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwCStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringFactory.pas'
 , tfwCStringList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringList.pas'
 , tfwCStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringListPrim.pas'
 , tfwCStringArraySing in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas'
 , tfwCStringArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArray.pas'
 , tfwCStringArraySing2 in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas'
 {$If NOT Defined(NoScripts)}
 , tfwInitedDictionariesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwAxiomaticsResNameGetter in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetter.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwAxiomaticsResNameGetters in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwAxiomaticsResNameGetterList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetterList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryDataIteratorPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryDataIteratorPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwExportedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwExportedDictionariesIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPtrListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrListIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwUsedDictionariesIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwUsedDictionariesIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3DateSt in 'w:\common\components\rtl\Garant\L3\l3DateSt.pas'
 {$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
 , tfwMainDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryCache.pas'
 {$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwMainDictionaryList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwMainDictionary in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionary.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwMainDictionaryWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
 , tfwDictionaryCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCache.pas'
 {$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryCachePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCachePrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwKeywordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeywordsIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwLeftParam in 'w:\common\components\rtl\Garant\ScriptEngine\kwLeftParam.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\kwInteger.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwString in 'w:\common\components\rtl\Garant\ScriptEngine\kwString.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3ParserInterfaces in 'w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas'
 {$If NOT Defined(NoScripts)}
 , kwIntegerFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerFactory.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIntegerArray in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerArray.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIntegerList in 'w:\common\components\rtl\Garant\ScriptEngine\kwIntegerList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStringFactory in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringFactory.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStringList in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStringListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwStringListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , StrUtils {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas' {$EndIf}
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorker.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwTemporaryCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTemporaryCompiledCode.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordWorkerEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerEx.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , m2HasLib in 'w:\common\components\rtl\Garant\L3\m2\m2HasLib.pas'
 {$If NOT Defined(NoScripts)}
 , tfwHash16Table in 'w:\common\components\rtl\Garant\ScriptEngine\tfwHash16Table.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3OneByteCString in 'w:\common\components\rtl\Garant\L3\l3OneByteCString.pas'
 , l3CEmptyStringPrim in 'w:\common\components\rtl\Garant\L3\l3CEmptyStringPrim.pas'
 , l3CEmptyString in 'w:\common\components\rtl\Garant\L3\l3CEmptyString.pas'
 , l3FourByteCString in 'w:\common\components\rtl\Garant\L3\l3FourByteCString.pas'
 {$If NOT Defined(NoScripts)}
 , tfwValueTypesCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesCache.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueTypesList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueTypesListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueTypesWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStandardDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwInitedDictionariesListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesListIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryListIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordsIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , VarWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VarWorkingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwConst in 'w:\common\components\rtl\Garant\ScriptEngine\tfwConst.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwConstLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwConstLike.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwNewWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwNewWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwForwardDeclaration in 'w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclaration.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwClassRef in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassRef.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeModifier in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeModifier.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwModifier in 'w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwRTTIProperty in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTIProperty.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwEnumRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwEnumConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwEnumConstantRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIntegerConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerConstantRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwInteger in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInteger.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwRegisteredEnums in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRegisteredEnums.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwRTTITypeInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTITypeInfoList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIntegerToEnumName in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerToEnumName.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStringToEnumValue in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringToEnumValue.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwInterfaceRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwInterfaceRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStringConstantRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringConstantRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwString.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConstLikeCompiled in 'w:\common\components\rtl\Garant\ScriptEngine\kwConstLikeCompiled.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas'
 , l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas'
 , tfwParserInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas'
 {$If NOT Defined(NoScripts)}
 , tfwWordInfoWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , tfwCS in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCS.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ArrayProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ArrayProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwBeginLikeWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwBeginLikeWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginLikeCompiledCode.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwCloseBracket.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwRevertedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRevertedArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwFilteredArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFilteredArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwLambdedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwLambdedArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwMappedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwMappedArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIteratorFromFunctor in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratorFromFunctor.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwJoinIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwJoinIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTruncatedArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTruncatedArrayView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwSliceView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSliceView.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , BasicsPack in 'w:\common\components\rtl\Garant\ScriptEngine\BasicsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessagesService in 'w:\common\components\rtl\Garant\L3\l3MessagesService.pas'
 {$If NOT Defined(NoScripts)}
 , kwValue in 'w:\common\components\rtl\Garant\ScriptEngine\kwValue.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwWordPtrPushWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrPushWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwWordPtrWorker in 'w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrWorker.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FileProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FileProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SysUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SysUtilsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ContainedActionsWordspack in 'w:\common\components\rtl\Garant\ScriptEngine\ContainedActionsWordspack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ActionListWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ActionListWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ControlsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Menus {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Menus.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MenuWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\MenuWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3ScreenService in 'w:\common\components\rtl\Garant\L3\l3ScreenService.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwBynameControlPush in 'w:\common\components\rtl\Garant\ScriptEngine\kwBynameControlPush.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwControlWord.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 {$If NOT Defined(NoScripts)}
 , FontWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , WinControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinControlsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ScrollingWinControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollingWinControlWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ScrollInfoProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScrollInfoProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwPopControlScrollInfo in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfo.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwScrollInfoWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwScrollInfoWord.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWinControlFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwWinControlFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , kwComponentFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwComponentFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwObjectFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwObjectFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwPopControlScrollInfoMin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMin.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwPopControlScrollInfoMax in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoMax.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwPopControlScrollInfoPageSize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPageSize.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwPopControlScrollInfoPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopControlScrollInfoPosition.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3ObjectList in 'w:\common\components\rtl\Garant\L3\l3ObjectList.pas'
 , l3SimpleDataContainer in 'w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CustomFormProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CustomFormProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 {$If NOT Defined(NoScripts)}
 , tfwWordDeleteListeners in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordDeleteListeners.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ItfwWordListenerList in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwWordListenerList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , WordsRTTIPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsRTTIPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , seWordsInfo in 'w:\common\components\rtl\Garant\ScriptEngine\seWordsInfo.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwCodeIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCodeIterator.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordContainer.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwDualCompiledWordContainer in 'w:\common\components\rtl\Garant\ScriptEngine\kwDualCompiledWordContainer.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordWorkerWordRunner in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordRunner.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordWorkerWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWordWorkerWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIfElse.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledIF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIF.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordBoxPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordBoxPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , KeyWordPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyWordPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordInfoCache in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoCache.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordInfoList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordInfoListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , NewWordDefinitorPack in 'w:\common\components\rtl\Garant\ScriptEngine\NewWordDefinitorPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ItfwKeywordFinderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ItfwCompilerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopClassInherits in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopClassInherits.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3RTTI in 'w:\common\components\rtl\Garant\L3\l3RTTI.pas'
 {$If NOT Defined(NoVCL) AND NOT Defined(XE)}
 , ControlResizeBugFix
 {$IfEnd} // NOT Defined(NoVCL) AND NOT Defined(XE)
 , toK in 'w:\archi\source\projects\Archi\toK.pas'
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner in 'w:\common\components\rtl\Garant\DUnitTuning\KTestRunner.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\BaseTest.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , TestFrameWork in 'w:\common\components\rtl\external\DUnit\src\TestFrameWork.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ITestWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\ITestWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 {$If NOT Defined(NoScripts)}
 , PictureEtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 , ArchiTestRes in 'w:\archi\source\projects\Archi\ArchiTestRes.pas'
 , GUIAppTester in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.pas'
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptDebugger.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
 , afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas'
 , afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas'
 {$If NOT Defined(NoVCL)}
 , ImgList {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas'
 , nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas'
 , k2Interfaces in 'w:\common\components\rtl\Garant\K2\k2Interfaces.pas'
 , k2PureMixIns in 'w:\common\components\rtl\Garant\K2\k2PureMixIns.pas'
 , k2Prim in 'w:\common\components\rtl\Garant\K2\k2Prim.pas'
 , l3ProtoIntegerList in 'w:\common\components\rtl\Garant\L3\l3ProtoIntegerList.pas'
 , k2PropertyArray in 'w:\common\components\rtl\Garant\K2\k2PropertyArray.pas'
 , k2TypeTableCreatedListeners in 'w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas'
 , k2Attributes in 'w:\common\components\rtl\Garant\K2\k2Attributes.pas'
 , k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas'
 , k2Empty_Const in 'w:\common\components\rtl\Garant\K2\k2Empty_Const.pas'
 , k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas'
 , nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas'
 , l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas'
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
 , evTypes in 'w:\common\components\gui\Garant\Everest\evTypes.pas'
 , afwNavigation in 'w:\common\components\gui\Garant\AFW\afwNavigation.pas'
 , nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas'
 , l3CacheableBase in 'w:\common\components\rtl\Garant\L3\l3CacheableBase.pas'
 , nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas'
 , nevShapePrimRefList in 'w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas'
 {$If Defined(k2ForEditor)}
 , evParaTools in 'w:\common\components\gui\Garant\Everest\evParaTools.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , evInternalInterfaces in 'w:\common\components\gui\Garant\Everest\evInternalInterfaces.pas'
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
 , k2TagPointer in 'w:\common\components\rtl\Garant\K2\k2TagPointer.pas'
 , k2ToolPrim in 'w:\common\components\rtl\Garant\K2\k2ToolPrim.pas'
 , k2InterfaceFactory in 'w:\common\components\rtl\Garant\K2\k2InterfaceFactory.pas'
 , k2InterfaceCache in 'w:\common\components\rtl\Garant\K2\k2InterfaceCache.pas'
 , k2InterfaceList in 'w:\common\components\rtl\Garant\K2\k2InterfaceList.pas'
 , k2ToolCacheList in 'w:\common\components\rtl\Garant\K2\k2ToolCacheList.pas'
 , k2ToolPrimList in 'w:\common\components\rtl\Garant\K2\k2ToolPrimList.pas'
 , l3ProtoObjectRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectRefList.pas'
 , evEditorInterfaces in 'w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas'
 , nevNavigation in 'w:\common\components\gui\Garant\Everest\new\nevNavigation.pas'
 , evEditorInterfacesTypes in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesTypes.pas'
 {$If Defined(k2ForEditor)}
 , evCursorTools in 'w:\common\components\gui\Garant\Everest\evCursorTools.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas'
 , evMsgCode in 'w:\common\components\gui\Garant\Everest\evMsgCode.pas'
 , evOp in 'w:\common\components\gui\Garant\Everest\evOp.pas'
 , nevFacade in 'w:\common\components\gui\Garant\Everest\new\nevFacade.pas'
 {$If NOT Defined(NoScripts)}
 , IedTableWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3InterfacedString in 'w:\common\components\rtl\Garant\L3\l3InterfacedString.pas'
 , l3NCString in 'w:\common\components\rtl\Garant\L3\l3NCString.pas'
 , TableCell_Const in 'w:\common\components\gui\Garant\Everest\TableCell_Const.pas'
 , ParaList_Const in 'w:\common\components\gui\Garant\Everest\ParaList_Const.pas'
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
 , TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas'
 , StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas'
 , LeafPara_Const in 'w:\common\components\rtl\Garant\EVD\LeafPara_Const.pas'
 , evdTextStyle_Const in 'w:\common\components\rtl\Garant\EVD\evdTextStyle_Const.pas'
 , Style_Const in 'w:\common\components\rtl\Garant\EVD\Style_Const.pas'
 , ObjectWithHandle_Const in 'w:\common\components\rtl\Garant\EVD\ObjectWithHandle_Const.pas'
 , k2Handle_Const in 'w:\common\components\rtl\Garant\K2\k2Handle_Const.pas'
 , Justification_Const in 'w:\common\components\rtl\Garant\EVD\Justification_Const.pas'
 , Font_Const in 'w:\common\components\rtl\Garant\EVD\Font_Const.pas'
 , k2FontName_Const in 'w:\common\components\rtl\Garant\K2\k2FontName_Const.pas'
 , l3FontManager in 'w:\common\components\rtl\Garant\L3\l3FontManager.pas'
 , l3FontManagerPrim in 'w:\common\components\rtl\Garant\L3\l3FontManagerPrim.pas'
 , l3FontManagerPrimPrim in 'w:\common\components\rtl\Garant\L3\l3FontManagerPrimPrim.pas'
 , l3LogFont in 'w:\common\components\rtl\Garant\L3\l3LogFont.pas'
 , evdStyleContainer in 'w:\common\components\rtl\Garant\EVD\evdStyleContainer.pas'
 , k2DictionaryEx in 'w:\common\components\rtl\Garant\K2\k2DictionaryEx.pas'
 , k2Dictionary in 'w:\common\components\rtl\Garant\K2\k2Dictionary.pas'
 , k2DictionaryPrim in 'w:\common\components\rtl\Garant\K2\k2DictionaryPrim.pas'
 , k2NonOptimizeContext in 'w:\common\components\rtl\Garant\K2\k2NonOptimizeContext.pas'
 , k2Context in 'w:\common\components\rtl\Garant\K2\k2Context.pas'
 , k2OperationContainer in 'w:\common\components\rtl\Garant\K2\k2OperationContainer.pas'
 , k2OpRefList in 'w:\common\components\rtl\Garant\K2\k2OpRefList.pas'
 , k2Op in 'w:\common\components\rtl\Garant\K2\k2Op.pas'
 , k2NilOp in 'w:\common\components\rtl\Garant\K2\k2NilOp.pas'
 , l3IntegerValueMapManager in 'w:\common\components\rtl\Garant\L3\l3IntegerValueMapManager.pas'
 , l3ValueMapManager in 'w:\common\components\rtl\Garant\L3\l3ValueMapManager.pas'
 , l3ValueMapManagerPrim in 'w:\common\components\rtl\Garant\L3\l3ValueMapManagerPrim.pas'
 , l3ValueMap in 'w:\common\components\rtl\Garant\L3\l3ValueMap.pas'
 , l3BaseWithIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDList.pas'
 , l3BaseWithIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithIDListPrim.pas'
 , l3BaseWithID in 'w:\common\components\rtl\Garant\L3\l3BaseWithID.pas'
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
 , afwFacade in 'w:\common\components\gui\Garant\AFW\afwFacade.pas'
 , l3KeyboardLayoutService in 'w:\common\components\rtl\Garant\L3\l3KeyboardLayoutService.pas'
 , afwSettingsImplSing in 'w:\common\components\gui\Garant\AFW\afwSettingsImplSing.pas'
 , afwSettingsImplPersistent in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPersistent.pas'
 , afwSettingsImpl in 'w:\common\components\gui\Garant\AFW\afwSettingsImpl.pas'
 , afwSettingsImplPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrim.pas'
 , afwSettingsImplPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsImplPrimPrim.pas'
 , afwSettingsImplemented in 'w:\common\components\gui\Garant\AFW\afwSettingsImplemented.pas'
 , afwSettings in 'w:\common\components\gui\Garant\AFW\afwSettings.pas'
 , afwSettingsPrimPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsPrimPrim.pas'
 , afwAString in 'w:\common\components\gui\Garant\AFW\afwAString.pas'
 , afwSettingsChangePublisher in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisher.pas'
 , afwSettingsChangePublisherPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisherPrim.pas'
 , IafwSettingListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingListenerPtrList.pas'
 , IafwSettingsReplaceListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingsReplaceListenerPtrList.pas'
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
 {$If NOT Defined(NoScripts)}
 , kwFiltersAndGeneratorsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 , l3Defaults in 'w:\common\components\rtl\Garant\L3\l3Defaults.pas'
 , evdNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeWriter.pas'
 , evdCustomNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriter.pas'
 , evdCustomNativeWriterServices in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriterServices.pas'
 , Bullet_Const in 'w:\common\components\rtl\Garant\EVD\Bullet_Const.pas'
 , SegmentsLayer_Const in 'w:\common\components\rtl\Garant\EVD\SegmentsLayer_Const.pas'
 , TextSegment_Const in 'w:\common\components\rtl\Garant\EVD\TextSegment_Const.pas'
 , Segment_Const in 'w:\common\components\rtl\Garant\EVD\Segment_Const.pas'
 , Position_Const in 'w:\common\components\rtl\Garant\EVD\Position_Const.pas'
 , TabStop_Const in 'w:\common\components\rtl\Garant\EVD\TabStop_Const.pas'
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
 , Formula_Const in 'w:\common\components\gui\Garant\Everest\Formula_Const.pas'
 , DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas'
 , LeafParaDecorationsHolder_Const in 'w:\common\components\gui\Garant\Everest\LeafParaDecorationsHolder_Const.pas'
 , k2Const in 'w:\common\components\rtl\Garant\K2\k2Const.pas'
 , afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
 , afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas'
 , l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas'
 , Consts {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas' {$EndIf}
 , l3MetafileHeader in 'w:\common\components\rtl\Garant\L3\l3MetafileHeader.pas'
 , afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas'
 , l3Canvas in 'w:\common\components\rtl\Garant\L3\l3Canvas.pas'
 , l3CanvasPrim in 'w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas'
 , l3RectList in 'w:\common\components\rtl\Garant\L3\l3RectList.pas'
 , l3Region in 'w:\common\components\rtl\Garant\L3\l3Region.pas'
 , l3CanvasUtils in 'w:\common\components\rtl\Garant\L3\l3CanvasUtils.pas'
 , l3ScreenIC in 'w:\common\components\rtl\Garant\L3\l3ScreenIC.pas'
 , l3FontTools in 'w:\common\components\rtl\Garant\L3\l3FontTools.pas'
 , l3FormattedLines in 'w:\common\components\rtl\Garant\L3\l3FormattedLines.pas'
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
 , l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas'
 {$If NOT Defined(NoImageEn)}
 , imageenio in 'w:\common\components\rtl\external\ImageEn\src\imageenio.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3EtalonsService in 'w:\common\components\rtl\Garant\L3\l3EtalonsService.pas'
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngine.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwStringStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStringStreamFactory.pas'
 , tfwFileStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFileStreamFactory.pas'
 {$If NOT Defined(NoScripts)}
 , kwEmitString in 'w:\common\components\rtl\Garant\ScriptEngine\kwEmitString.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwTryFinally.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDualWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDualWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledTryFinally in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryFinally.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledTryExcept in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledTryExcept.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEND in 'w:\common\components\rtl\Garant\ScriptEngine\kwEND.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwFINALLY in 'w:\common\components\rtl\Garant\ScriptEngine\kwFINALLY.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMedianBacket in 'w:\common\components\rtl\Garant\ScriptEngine\kwMedianBacket.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEXCEPT in 'w:\common\components\rtl\Garant\ScriptEngine\kwEXCEPT.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwMain.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEnginePrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEnginePrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueStack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwSourcePointList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSourcePointList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryStack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwParser in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParser.pas'
 , tfwCachedTokens in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCachedTokens.pas'
 {$If NOT Defined(NoScripts)}
 , ItfwParserWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ItfwParserExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , l3ScriptService in 'w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , seThreadSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seThreadSupport.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ItfwScriptEngineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwScriptEngineWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSystemIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwSystemIncluded.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIncludedPrim in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncludedPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledIncluded.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwCOMStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCOMStreamFactory.pas'
 {$If NOT Defined(NoScripts)}
 , kwCompiledMain in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledMain.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , tfwResourceStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwResourceStreamFactory.pas'
 {$If NOT Defined(NoScripts)}
 , tfwCompiledAxiomaticsRes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCompiledAxiomaticsRes.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypesForRegister in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypesForRegister.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwClassesForRegister in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassesForRegister.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3ClassList in 'w:\common\components\rtl\Garant\L3\l3ClassList.pas'
 {$If NOT Defined(NoScripts)}
 , tfwScriptsRunningAndDebugging in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptsRunningAndDebugging.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwOutToFileScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwOutToFileScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwConsoleScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwConsoleScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDefaultScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDefaultScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDebugScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDebugScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDebugService in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDebugService.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 , l3WinControlCanvas in 'w:\common\components\rtl\Garant\L3\l3WinControlCanvas.pas'
 , l3ControlCanvas in 'w:\common\components\rtl\Garant\L3\l3ControlCanvas.pas'
 {$If NOT Defined(NoVCL)}
 , StdCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RadioButtonWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3Operations in 'w:\common\components\rtl\Garant\L3\l3Operations.pas'
 , l3DropTarget in 'w:\common\components\rtl\Garant\L3\l3DropTarget.pas'
 , l3DropSource in 'w:\common\components\rtl\Garant\L3\l3DropSource.pas'
 , afwVCL in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas'
 , afwFont in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwFont.pas'
 , afwHintManager in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas'
 {$If NOT Defined(NoVCL)}
 , ExtCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PanelProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RadioGroupWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3CustomControlCanvas in 'w:\common\components\rtl\Garant\L3\l3CustomControlCanvas.pas'
 {$If NOT Defined(NoScripts)}
 , evSchemaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evEvdRd in 'w:\common\components\gui\Garant\Everest\evEvdRd.pas'
 {$If NOT Defined(NoScripts)}
 , evParaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , EditorFromStackKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorFromStackKeyWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSelectCellsWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSelectCellsWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas'
 , Table_Const in 'w:\common\components\gui\Garant\Everest\Table_Const.pas'
 , TableRow_Const in 'w:\common\components\gui\Garant\Everest\TableRow_Const.pas'
 {$If NOT Defined(NoScripts)}
 , kwPopEditorWheelScroll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectColumn.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectCellsVertical in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorJumpToHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorRepaintTableLinesAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintTableLinesAndCheckWithEtalon.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorPrintAcnhor in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintAcnhor.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorPrintTableCellsParams in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPrintTableCellsParams.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , kwPopEditorLP2DP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorLP2DP.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorDP2LP in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDP2LP.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorCheckContinueCells in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckContinueCells.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evTableSearch in 'w:\common\components\gui\Garant\EverestCommon\evTableSearch.pas'
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetLeftIndentDelta in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLeftIndentDelta.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaDown.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorFromStackCursorWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackCursorWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaUp.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEnd.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaHome in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaHome.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectTable in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectTable.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorHasComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorHasComment.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorFromStackNextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackNextParaWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorFromStackTextParaWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTextParaWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorDeleteUserComment in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDeleteUserComment.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorCurrentText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCurrentText.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorUpdateCursorFromHotSpot in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpot.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorUpdateCursorFromHotSpotEx in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorUpdateCursorFromHotSpotEx.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorTextToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorTextToFile.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetSelectionText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionText.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetParaByID in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetParaByID.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetSelectionTextInFormat in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionTextInFormat.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evdBlockNameAdder in 'w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas'
 , evdHeaderHyperlinkAdder in 'w:\common\components\gui\Garant\Everest\evdHeaderHyperlinkAdder.pas'
 , ContentsElement_Const in 'w:\common\components\gui\Garant\Everest\ContentsElement_Const.pas'
 {$If NOT Defined(NoScripts)}
 , kwPopEditorBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResize.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwBlockResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwBlockResize.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectCellByMouse in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellByMouse.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSetTextParaStyle in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetTextParaStyle.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSetCursorByPoint in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetCursorByPoint.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorRepaintAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorCopyAndPaste2DocumentBottom in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCopyAndPaste2DocumentBottom.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorResizeTableColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorFromStackTableColumnResize in 'w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackTableColumnResize.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorResizeTableColumnEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumnEX.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckWithEtalon.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCheckWithEtalon.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetLMargin in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetLMargin.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetWrapLimit in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetWrapLimit.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorBlockResizeEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResizeEX.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorPasteRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteRTF.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwInsertFromStreamCommon in 'w:\common\components\rtl\Garant\ScriptEngine\kwInsertFromStreamCommon.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorInsertStream in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertStream.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorPasteEVDTroughClipboard in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteEVDTroughClipboard.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwBeginWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginWaitPrint.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEndWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TevCustomEditorWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TevCustomEditorWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , IedRangeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedRangeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , EditorParaCoordsToScreenPack in 'w:\common\components\rtl\Garant\ScriptEngine\EditorParaCoordsToScreenPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaCoordsToScreen.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwParaCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwParaCoordsToScreen.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaEndCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaEndCoordsToScreen.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorParaMiddleCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaMiddleCoordsToScreen.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorCursorCoordsToScreen in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCursorCoordsToScreen.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , l3NodesKeyWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\l3NodesKeyWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Bits in 'w:\common\components\rtl\Garant\L3\l3Bits.pas'
 {$If NOT Defined(NoScripts)}
 , InterfacedNodeWords in 'w:\common\components\rtl\Garant\ScriptEngine\InterfacedNodeWords.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , afwAnswer in 'w:\common\components\rtl\Garant\L3\afwAnswer.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3AFWExceptions in 'w:\common\components\rtl\Garant\L3\l3AFWExceptions.pas'
 , l3BatchService in 'w:\common\components\rtl\Garant\L3\l3BatchService.pas'
 , l3ModalService in 'w:\common\components\rtl\Garant\L3\l3ModalService.pas'
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtHintWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3FontInfo in 'w:\common\components\rtl\Garant\L3\l3FontInfo.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , vtTreeSource in 'w:\common\components\gui\Garant\VT\vtTreeSource.pas'
 , l3Tree in 'w:\common\components\rtl\Garant\L3\l3Tree.pas'
 , l3ItemsStorage in 'w:\common\components\rtl\Garant\L3\l3ItemsStorage.pas'
 , l3TreeUtils in 'w:\common\components\rtl\Garant\L3\l3TreeUtils.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtOutlinerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3SimpleTree in 'w:\common\components\rtl\Garant\L3\l3SimpleTree.pas'
 , ctFakeBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ctFakeBoxStrings.pas'
 , ComboBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ComboBoxStrings.pas'
 , ctComboBoxStringsItemNode in 'w:\common\components\gui\Garant\VT\ComboTree\ctComboBoxStringsItemNode.pas'
 {$If NOT Defined(NoScripts)}
 , vtComboTreeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboTreeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwKeyWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ComCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeNodeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeNodeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeViewWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TTreeNodeForTestsWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , FolderSupport in 'w:\common\components\rtl\external\DUnit\src\FolderSupport.pas'
 , TestForm4Scripts in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\TestForm4Scripts.pas'
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineEX.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CodeFlowWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeFlowWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , seModalSupport in 'w:\common\components\rtl\Garant\ScriptEngine\seModalSupport.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , seModalWorkerList in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , seModalWorkerListPrim in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerListPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , seModalWorker in 'w:\common\components\rtl\Garant\ScriptEngine\seModalWorker.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CompilationPack in 'w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwFORWARD in 'w:\common\components\rtl\Garant\ScriptEngine\kwFORWARD.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , WordsDefinitionPack in 'w:\common\components\rtl\Garant\ScriptEngine\WordsDefinitionPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\tfwProcedure.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStandardProcedureCloseBracket in 'w:\common\components\rtl\Garant\ScriptEngine\kwStandardProcedureCloseBracket.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledProcedure in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedure.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwKeyValuesPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyValuesPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwKeyValues in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyValues.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledProcedureWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledFunction in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledFunction.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledProcedureWithStackChecking in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwInlinedWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwInlinedWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , IncludesAndUsesPack in 'w:\common\components\rtl\Garant\ScriptEngine\IncludesAndUsesPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwInclude in 'w:\common\components\rtl\Garant\ScriptEngine\kwInclude.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIncludeLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIncludeLike.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIncluded in 'w:\common\components\rtl\Garant\ScriptEngine\kwIncluded.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwUses in 'w:\common\components\rtl\Garant\ScriptEngine\kwUses.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwUsesLike in 'w:\common\components\rtl\Garant\ScriptEngine\kwUsesLike.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , EtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCheckOutputWithInput in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckOutputWithInput.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCheckEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwCheckEtalon.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwTestResolveInputFilePath in 'w:\common\components\rtl\Garant\ScriptEngine\kwTestResolveInputFilePath.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MouseInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\MouseInputPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseLeftDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftDown.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseUpDownSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseUpDownSupport.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSendInputSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwSendInputSupport.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseLeftUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftUp.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseMiddleUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleUp.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseMiddleDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleDown.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseRightUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightUp.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseRightDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightDown.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseSetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseSetCursorPosition.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseGetCursorIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorIndex.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseGetCursorNameByIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorNameByIndex.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseGetCursorPosition in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorPosition.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseWheelUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelUp.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseWheelSupport in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelSupport.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMouseWheelDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelDown.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ModalDialogsKeywordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ModalDialogsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWasWait in 'w:\common\components\rtl\Garant\ScriptEngine\kwWasWait.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWaitNo in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitNo.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWaitOk in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitOk.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWaitYes in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitYes.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWaitCancel in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitCancel.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwWaitChoice in 'w:\common\components\rtl\Garant\ScriptEngine\kwWaitChoice.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , KeyboardInputPack in 'w:\common\components\rtl\Garant\ScriptEngine\KeyboardInputPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwKey in 'w:\common\components\rtl\Garant\ScriptEngine\kwKey.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwHardKey in 'w:\common\components\rtl\Garant\ScriptEngine\kwHardKey.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwKeyDown in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyDown.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwKeyUp in 'w:\common\components\rtl\Garant\ScriptEngine\kwKeyUp.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , CodeBranchingPack in 'w:\common\components\rtl\Garant\ScriptEngine\CodeBranchingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIfElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwIfElse.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwElse in 'w:\common\components\rtl\Garant\ScriptEngine\kwElse.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCASE in 'w:\common\components\rtl\Garant\ScriptEngine\kwCASE.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledCase in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCase.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwDEFAULT in 'w:\common\components\rtl\Garant\ScriptEngine\kwDEFAULT.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwRAISE in 'w:\common\components\rtl\Garant\ScriptEngine\kwRAISE.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwBracketBegin in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketBegin.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwBracketEnd in 'w:\common\components\rtl\Garant\ScriptEngine\kwBracketEnd.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwTypedBeginLikeCompiledCode in 'w:\common\components\rtl\Garant\ScriptEngine\kwTypedBeginLikeCompiledCode.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwBEGIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwBEGIN.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwRULES in 'w:\common\components\rtl\Garant\ScriptEngine\kwRULES.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledRules in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledRules.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ScriptsCompilingAndProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ScriptsCompilingAndProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileAndProcess.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledScriptCompileAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileAndProcess.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMainCodeController in 'w:\common\components\rtl\Garant\ScriptEngine\kwMainCodeController.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwScriptCompileStringAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwScriptCompileStringAndProcess.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledScriptCompileStringAndProcess in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileStringAndProcess.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoWindows)}
 , WinUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinUtilsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoWindows)
 , CommCtrl {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\CommCtrl.pas' {$EndIf}
 , ArchiScriptEngine in 'w:\archi\source\projects\Archi\Archi_Script_Engine\ArchiScriptEngine.pas'
 {$If NOT Defined(NoScripts)}
 , arEditorUtils in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arEditorUtils.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwClickOnCommentHeader in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClickOnCommentHeader.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , arEditorControl in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arEditorControl.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , arArchiTestsAdapter in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arArchiTestsAdapter.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , dt_Types in 'w:\common\components\rtl\Garant\dd\dt_Types.pas'
 , evdDTTypes in 'w:\common\components\rtl\Garant\EVD\evdDTTypes.pas'
 {$If Defined(AppClientSide)}
 , Main in 'w:\archi\source\projects\Archi\Main\Main.pas'
 {$IfEnd} // Defined(AppClientSide)
 , l3ClipboardSpy in 'w:\common\components\rtl\Garant\L3\l3ClipboardSpy.pas'
 {$If Defined(AppClientSide)}
 , DocIntf in 'w:\archi\source\projects\Archi\Editor\DocIntf.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , arTextOfDocument in 'w:\archi\source\projects\Archi\Editor\arTextOfDocument.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , arDocumentContainer in 'w:\archi\source\projects\Archi\Editor\arDocumentContainer.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , arHAFPainer in 'w:\archi\source\projects\Archi\Editor\arHAFPainer.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , arSubImplementation in 'w:\archi\source\projects\Archi\Editor\arSubImplementation.pas'
 {$IfEnd} // Defined(AppClientSide)
 , dt_Const in 'w:\common\components\rtl\Garant\dd\dt_Const.pas'
 , daTypes in 'w:\common\components\rtl\Garant\DA\daTypes.pas'
 , evOutTextParaEliminator in 'w:\common\components\gui\Garant\Everest\evOutTextParaEliminator.pas'
 {$If Defined(AppClientSide)}
 , arSpravkaTextOfDocument in 'w:\archi\source\projects\Archi\Editor\arSpravkaTextOfDocument.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , arSpravkaDocumentContainer in 'w:\archi\source\projects\Archi\Editor\arSpravkaDocumentContainer.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , InsDWin in 'w:\archi\source\projects\Archi\Dlg\InsDWin.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , DictMetaForm in 'w:\archi\source\projects\Archi\MetaForms\DictMetaForm.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , VMailWin in 'w:\archi\source\projects\Archi\Dlg\VMailWin.pas'
 {$IfEnd} // Defined(AppClientSide)
 , vtForm in 'w:\common\components\gui\Garant\VT\vtForm.pas'
 , l3Forms in 'w:\common\components\rtl\Garant\L3\l3Forms.pas'
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
 , l3ClipSpyService in 'w:\common\components\rtl\Garant\L3\l3ClipSpyService.pas'
 , vtClipSpyService in 'w:\common\components\gui\Garant\VT\vtClipSpyService.pas'
 , vtClipSpy in 'w:\common\components\gui\Garant\VT\vtClipSpy.pas'
 {$If Defined(AppClientSide)}
 , Editwin in 'w:\archi\source\projects\Archi\Main\Editwin.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , F_ImageView in 'w:\archi\source\projects\Archi\Frames\F_ImageView.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If NOT Defined(NoImageEn)}
 , imageenview in 'w:\common\components\rtl\external\ImageEn\src\imageenview.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
 , ImageEnPack in 'w:\common\components\rtl\Garant\ScriptEngine\ImageEnPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
 , kwImageEnViewerSaveBitmap in 'w:\common\components\rtl\Garant\ScriptEngine\kwImageEnViewerSaveBitmap.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
 , kwImageEnControl in 'w:\common\components\rtl\Garant\ScriptEngine\kwImageEnControl.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
 , ImageEnViewRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\ImageEnViewRegistrator.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)
 {$If Defined(AppClientSide)}
 , arEditorDebugInfo in 'w:\archi\source\projects\Archi\Main\arEditorDebugInfo.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , CustEditWin in 'w:\archi\source\projects\Archi\Main\CustEditWin.pas'
 {$IfEnd} // Defined(AppClientSide)
 , D_spell in 'w:\archi\source\projects\Common\Dialogs\D_spell.pas'
 {$If NOT Defined(NoScripts)}
 , TSpellCheckDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TSpellCheckDlgWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(AppClientSide)}
 , arHyperLinkProcessor in 'w:\archi\source\projects\Archi\Editor\arHyperLinkProcessor.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If NOT Defined(NoScripts)}
 , tfwArchiHyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArchiHyperlinkScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwHyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwHyperlinkScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , arConst in 'w:\archi\source\projects\Common\Utils\arConst.pas'
 , evCommonUtils in 'w:\archi\source\projects\Common\Utils\evCommonUtils.pas'
 , evCommonTypes in 'w:\common\components\gui\Garant\EverestCommon\evCommonTypes.pas'
 , arCommonTypes in 'w:\archi\source\projects\Common\Utils\arCommonTypes.pas'
 , D_PicSizeEdit in 'w:\archi\source\projects\Common\Dialogs\D_PicSizeEdit.pas'
 {$If NOT Defined(NoScripts)}
 , TPicSizeEditDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TPicSizeEditDlgWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evFacadeGUI in 'w:\common\components\gui\Garant\EverestCommon\evFacadeGUI.pas'
 , ExprEditForm in 'w:\archi\source\projects\Common\Dialogs\ExprEditForm.pas'
 {$If NOT Defined(NoScripts)}
 , TExprEditorWordsPack in 'w:\archi\source\projects\Common\Dialogs\TExprEditorWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evTableTools in 'w:\common\components\gui\Garant\Everest\evTableTools.pas'
 , evCellsWidthCorrecter in 'w:\common\components\gui\Garant\Everest\evCellsWidthCorrecter.pas'
 , evRowAndTableTypeSupport in 'w:\common\components\gui\Garant\Everest\evRowAndTableTypeSupport.pas'
 , evCellsOffsetsPair in 'w:\common\components\gui\Garant\Everest\evCellsOffsetsPair.pas'
 , evCellsCharOffsets in 'w:\common\components\gui\Garant\Everest\evCellsCharOffsets.pas'
 , evOneCharLongIntList in 'w:\common\components\gui\Garant\Everest\evOneCharLongIntList.pas'
 , edCellTypesList in 'w:\common\components\gui\Garant\Everest\edCellTypesList.pas'
 , evCellsOffsetsPairList in 'w:\common\components\gui\Garant\Everest\evCellsOffsetsPairList.pas'
 , evCellWidthCorrecterSpy in 'w:\common\components\gui\Garant\Everest\evCellWidthCorrecterSpy.pas'
 , evCellsOffsetsList in 'w:\common\components\gui\Garant\Everest\evCellsOffsetsList.pas'
 , evCopyTableCellWidth in 'w:\common\components\gui\Garant\Everest\evCopyTableCellWidth.pas'
 , evTabStopsFilter in 'w:\common\components\gui\Garant\Everest\evTabStopsFilter.pas'
 , evdEmptyRowFilter in 'w:\common\components\gui\Garant\Everest\evdEmptyRowFilter.pas'
 , evTableFilter in 'w:\common\components\gui\Garant\Everest\evTableFilter.pas'
 , evTextInTableCorrector in 'w:\common\components\gui\Garant\Everest\evTextInTableCorrector.pas'
 , evFacadeSelection in 'w:\common\components\gui\Garant\EverestCommon\evFacadeSelection.pas'
 , evMemo in 'w:\common\components\gui\Garant\Everest\evMemo.pas'
 {$If NOT Defined(Nemesis)}
 , vtDialogs in 'w:\common\components\gui\Garant\VT\vtDialogs.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , evCommonRes in 'w:\archi\source\projects\Common\Utils\evCommonRes.pas'
 , evFacadeSub in 'w:\common\components\gui\Garant\EverestCommon\evFacadeSub.pas'
 , evStubs in 'w:\common\components\gui\Garant\EverestCommon\evStubs.pas'
 , d_edMSub in 'w:\archi\source\projects\Common\Dialogs\d_edMSub.pas'
 {$If NOT Defined(NoScripts)}
 , TNewSubDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TNewSubDlgWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , arTextUtils in 'w:\archi\source\projects\Common\Utils\arTextUtils.pas'
 , l3SimpleCalc in 'w:\common\components\rtl\Garant\L3\ext\l3SimpleCalc.pas'
 {$If Defined(Archi) AND NOT Defined(Nemesis)}
 , dt_LinkServ in 'w:\common\components\rtl\Garant\DT\dt_LinkServ.pas'
 {$IfEnd} // Defined(Archi) AND NOT Defined(Nemesis)
 , evTableConverter in 'w:\archi\source\projects\Common\Utils\evTableConverter.pas'
 , ddTableConvTypes in 'w:\common\components\rtl\Garant\dd\ddTableConvTypes.pas'
 , ddTableConvParamDlg in 'w:\archi\source\projects\Common\Dialogs\ddTableConvParamDlg.pas'
 , D_Base in 'w:\archi\source\projects\Common\Meta\D_Base.pas'
 {$If NOT Defined(NoScripts)}
 , TTableConvParamDialogWordsPack in 'w:\archi\source\projects\Common\Dialogs\TTableConvParamDialogWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , ddVirtualTable in 'w:\common\components\rtl\Garant\dd\ddVirtualTable.pas'
 , ddTable in 'w:\common\components\rtl\Garant\dd\ddTable.pas'
 , ddTablePrim in 'w:\common\components\rtl\Garant\dd\ddTablePrim.pas'
 , ddDocumentAtom in 'w:\common\components\rtl\Garant\dd\ddDocumentAtom.pas'
 , ddCustomDestination in 'w:\common\components\rtl\Garant\dd\ddCustomDestination.pas'
 , ddRTFProperties in 'w:\common\components\rtl\Garant\dd\ddRTFProperties.pas'
 , RTFtypes in 'w:\common\components\rtl\Garant\dd\RTFtypes.pas'
 , rtfListTable in 'w:\common\components\rtl\Garant\dd\rtfListTable.pas'
 , ddTypes in 'w:\common\components\rtl\Garant\dd\ddTypes.pas'
 , ddRowList in 'w:\common\components\rtl\Garant\dd\ddRowList.pas'
 , ddTableRow in 'w:\common\components\rtl\Garant\dd\ddTableRow.pas'
 , ddCellList in 'w:\common\components\rtl\Garant\dd\ddCellList.pas'
 , ddTableCell in 'w:\common\components\rtl\Garant\dd\ddTableCell.pas'
 , ddCellProperty in 'w:\common\components\rtl\Garant\dd\ddCellProperty.pas'
 , ddPropertyObject in 'w:\common\components\rtl\Garant\dd\ddPropertyObject.pas'
 , ddBorder in 'w:\common\components\rtl\Garant\dd\ddBorder.pas'
 , ddBorderPart in 'w:\common\components\rtl\Garant\dd\ddBorderPart.pas'
 , ddBaseObject in 'w:\common\components\rtl\Garant\dd\ddBaseObject.pas'
 , ddEVDTypesSupport in 'w:\common\components\rtl\Garant\dd\ddEVDTypesSupport.pas'
 , ddBase in 'w:\common\components\rtl\Garant\dd\ddBase.pas'
 , ddTextParagraph in 'w:\common\components\rtl\Garant\dd\ddTextParagraph.pas'
 , ddCharacterProperty in 'w:\common\components\rtl\Garant\dd\ddCharacterProperty.pas'
 , ddParagraphProperty in 'w:\common\components\rtl\Garant\dd\ddParagraphProperty.pas'
 , ddTextSegmentsList in 'w:\common\components\rtl\Garant\dd\ddTextSegmentsList.pas'
 , ddTextSegment in 'w:\common\components\rtl\Garant\dd\ddTextSegment.pas'
 , ddHyperlinkTarget in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTarget.pas'
 , ddHyperlinkTargetList in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTargetList.pas'
 , ddSubsList in 'w:\common\components\rtl\Garant\dd\ddSubsList.pas'
 , ddSub in 'w:\common\components\rtl\Garant\dd\ddSub.pas'
 , ddTextParaString in 'w:\common\components\rtl\Garant\dd\ddTextParaString.pas'
 , ddDocumentAtomList in 'w:\common\components\rtl\Garant\dd\ddDocumentAtomList.pas'
 , ddCellsPropertyList in 'w:\common\components\rtl\Garant\dd\ddCellsPropertyList.pas'
 , ddRowProperty in 'w:\common\components\rtl\Garant\dd\ddRowProperty.pas'
 , ddPicture in 'w:\common\components\rtl\Garant\dd\ddPicture.pas'
 , ddRTFUnits in 'w:\common\components\rtl\Garant\dd\ddRTFUnits.pas'
 , ddHexCharReader in 'w:\common\components\rtl\Garant\dd\ddHexCharReader.pas'
 , l3CharSkipper in 'w:\common\components\rtl\Garant\L3\l3CharSkipper.pas'
 , ddDocument in 'w:\common\components\rtl\Garant\dd\ddDocument.pas'
 , evdAllParaEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllParaEliminator.pas'
 , ddTextToTableConverters in 'w:\common\components\rtl\Garant\dd\ddTextToTableConverters.pas'
 {$If NOT Defined(NoScripts)}
 , archiDocEditorWindowWordsPack in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\archiDocEditorWindowWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(Nemesis)}
 , DictsSup in 'w:\common\components\rtl\Garant\DT\DictsSup.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(AppClientSide) AND NOT Defined(Nemesis)}
 , ddClientBaseEngine in 'w:\common\components\rtl\Garant\cs\ddClientBaseEngine.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(Nemesis)
 , m3StorageHolderList in 'w:\common\components\rtl\Garant\m3\m3StorageHolderList.pas'
 , m3StorageHolderListPrim1 in 'w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim1.pas'
 , m3StorageHolderListPrim in 'w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim.pas'
 , m3StorageHolder in 'w:\common\components\rtl\Garant\m3\m3StorageHolder.pas'
 , m3StorageInterfaces in 'w:\common\components\rtl\Garant\m3\m3StorageInterfaces.pas'
 , m3StorageTypes in 'w:\common\components\rtl\Garant\m3\m3StorageTypes.pas'
 , m3CommonStorage in 'w:\common\components\rtl\Garant\m3\m3CommonStorage.pas'
 , m3StoragePrim in 'w:\common\components\rtl\Garant\m3\m3StoragePrim.pas'
 , m3BaseStorage in 'w:\common\components\rtl\Garant\m3\m3BaseStorage.pas'
 , m3BaseStore in 'w:\common\components\rtl\Garant\m3\m3BaseStore.pas'
 , m2InternalInterfaces in 'w:\common\components\rtl\Garant\L3\m2\m2InternalInterfaces.pas'
 , m2COMLib in 'w:\common\components\rtl\Garant\L3\m2\m2COMLib.pas'
 , ComObj {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas' {$EndIf}
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
 , m3BaseStream in 'w:\common\components\rtl\Garant\m3\m3BaseStream.pas'
 , m3PrimStream in 'w:\common\components\rtl\Garant\m3\m3PrimStream.pas'
 , m2S32Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S32Lib.pas'
 , m2S64Lib in 'w:\common\components\rtl\Garant\L3\m2\m2S64Lib.pas'
 , m3Const in 'w:\common\components\rtl\Garant\m3\m3Const.pas'
 , m3CommonStorageStream in 'w:\common\components\rtl\Garant\m3\m3CommonStorageStream.pas'
 {$If Defined(AppClientSide)}
 , archiHTInit in 'w:\archi\source\projects\Archi\Main\archiHTInit.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If NOT Defined(Nemesis)}
 , dt_Mail in 'w:\common\components\rtl\Garant\DT\dt_Mail.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(NoScripts)}
 , kwEditorDblClickOnSub in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorDblClickOnSub.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwDeleteSub in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDeleteSub.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwDocEditorSetModified in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDocEditorSetModified.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwAddBlock in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwAddBlock.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorSetTOC in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorSetTOC.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwGotoSub in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwGotoSub.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEndAddSubByMouse in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEndAddSubByMouse.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , DragData in 'w:\common\components\gui\Garant\VT\DragData.pas'
 , vtDragDataTypes in 'w:\common\components\gui\Garant\VT\vtDragDataTypes.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwVTControlsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwVTControlsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , arArchiTestAdapter2 in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arArchiTestAdapter2.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSetExpiredStyle in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSetExpiredStyle.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , arDialogsPack in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arDialogsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwOpenInsDWin in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwOpenInsDWin.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMakeChangeDoc in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMakeChangeDoc.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwInsertDocChanges in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwInsertDocChanges.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIniRecSetZoom in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwIniRecSetZoom.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIniRecGetZoom in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwIniRecGetZoom.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CommonArchiWords in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\CommonArchiWords.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwArchiNewDocument in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiNewDocument.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCreateNewFile in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwCreateNewFile.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwClearDataBase in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearDataBase.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , arDBUtils in 'w:\archi\source\projects\Common\Utils\arDBUtils.pas'
 , JclMiscel {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\source\windows\JclMiscel.pas' {$EndIf}
 , ddZipUtils in 'w:\common\components\rtl\Garant\dd\ddZipUtils.pas'
 {$If NOT Defined(Nemesis)}
 , dt_Jour in 'w:\common\components\rtl\Garant\DT\dt_Jour.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(NoScripts)}
 , kwArchiCloseDocument in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiCloseDocument.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwArchiOpenDocument in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiOpenDocument.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwArchiNewDocumentPrim in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiNewDocumentPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwGetActiveEditorPageName in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwGetActiveEditorPageName.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwArchiNewEmptyDocument in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiNewEmptyDocument.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSetActivePage in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSetActivePage.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwShowMailMessage in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwShowMailMessage.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , kwDocumentSpravka in 'w:\archi\source\projects\Archi\Archi_Script_Engine\kwDocumentSpravka.pas'
 {$If NOT Defined(NoScripts)}
 , kwEditorKeyWordsPack in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorKeyWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorEditFormula in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorEditFormula.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorAlignCellsBoundary in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorAlignCellsBoundary.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSetStyle2Block in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorSetStyle2Block.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorInsertFormula in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorInsertFormula.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPushMainForm in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPushMainForm.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSetStyle2Table in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorSetStyle2Table.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwCommonArchiWords in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwCommonArchiWords.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwMainFormFindDocuments in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormFindDocuments.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwBaseExport in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwBaseExport.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 , SewerPipe in 'w:\common\components\rtl\Garant\dd\PipeOut\SewerPipe.pas'
 , dt_AttrSchema in 'w:\common\components\rtl\Garant\dd\dt_AttrSchema.pas'
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwBaseRelCorrecter in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwBaseRelCorrecter.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwPreview in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPreview.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwSearchWinSaveDocumentList in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSearchWinSaveDocumentList.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwMainFormClearHistory in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormClearHistory.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwEditorTextSaveAs in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorTextSaveAs.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwClearTemplateStorage in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearTemplateStorage.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwMainFormFormClose in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormFormClose.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwDialogsLockDocumentGetSkipMode in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDialogsLockDocumentGetSkipMode.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwDialogsLockDocumentSetSkipMode in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDialogsLockDocumentSetSkipMode.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , AttributeExplorerWordsPack in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\AttributeExplorerWordsPack.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 {$If Defined(AppClientSide)}
 , F_AttrExplorer in 'w:\archi\source\projects\Archi\Frames\F_AttrExplorer.pas'
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwClearConfig in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearConfig.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(NoScripts)
 , l3CustomSortIntegerList in 'w:\common\components\rtl\Garant\L3\l3CustomSortIntegerList.pas'
 , l3CustomOtherListView in 'w:\common\components\rtl\Garant\L3\l3CustomOtherListView.pas'
 , l3CustomLongintListView in 'w:\common\components\rtl\Garant\L3\l3CustomLongintListView.pas'
 , l3LongintListReverseSorter in 'w:\common\components\rtl\Garant\L3\l3LongintListReverseSorter.pas'
 , l3EventedRecListView in 'w:\common\components\rtl\Garant\L3\l3EventedRecListView.pas'
 , l3CustomRecListView in 'w:\common\components\rtl\Garant\L3\l3CustomRecListView.pas'
 , l3ProtoPtrRecListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas'
 , k2TagByHandleView in 'w:\common\components\rtl\Garant\K2\k2TagByHandleView.pas'
 , k2CustomTagView in 'w:\common\components\rtl\Garant\K2\k2CustomTagView.pas'
 {$If NOT Defined(NoScripts)}
 , ArchiAutoTestSuite in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiAutoTestSuite.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ArchiAutoTest in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiAutoTest.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiInsiderTest.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
 {$If NOT Defined(NoScripts)}
 , kwArchiEverestWordsPack in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiEverestWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwDisableMergedCellFilter in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDisableMergedCellFilter.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwClearFindDialog in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearFindDialog.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , D_TxSrch in 'w:\archi\source\projects\Common\Dialogs\D_TxSrch.pas'
 {$If NOT Defined(NoScripts)}
 , TTextSearchDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TTextSearchDlgWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwAutoCompleteClear in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwAutoCompleteClear.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(k2ForEditor)}
 , evAutoComplete in 'w:\common\components\gui\Garant\Everest\evAutoComplete.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , l3ComponentInfoHelper in 'w:\common\components\rtl\Garant\L3\l3ComponentInfoHelper.pas'
 {$If NOT Defined(NoVCL)}
 , l3FormatActionInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatActionInfoHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3HugeMessageDlgWithWikiHelper in 'w:\common\components\rtl\Garant\L3\l3HugeMessageDlgWithWikiHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3GetComponentFromPointHelper in 'w:\common\components\rtl\Garant\L3\l3GetComponentFromPointHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3FormatObjectInfoHelper in 'w:\common\components\rtl\Garant\L3\l3FormatObjectInfoHelper.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3IterateComponentParents in 'w:\common\components\rtl\Garant\L3\l3IterateComponentParents.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , toKT in 'w:\archi\source\projects\Archi\toKT.pas'
 , ArchiInsiderTests_TestLibrary in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_TestLibrary.pas'
 , ArchiInsiderTests_EditorTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_EditorTests_TestUnit.pas'
 , K264902382 in 'w:\archi\source\projects\Archi\Tests\K264902382.pas'
 , K266421641 in 'w:\archi\source\projects\Archi\Tests\K266421641.pas'
 , K271754614 in 'w:\archi\source\projects\Archi\Tests\K271754614.pas'
 , K200902504 in 'w:\archi\source\projects\Archi\Tests\K200902504.pas'
 , K280007486 in 'w:\archi\source\projects\Archi\Tests\K280007486.pas'
 , K280010450 in 'w:\archi\source\projects\Archi\Tests\K280010450.pas'
 , K227478574 in 'w:\archi\source\projects\Archi\Tests\K227478574.pas'
 , K296094711 in 'w:\archi\source\projects\Archi\Tests\K296094711.pas'
 , K296621183 in 'w:\archi\source\projects\Archi\Tests\K296621183.pas'
 , K296094716 in 'w:\archi\source\projects\Archi\Tests\K296094716.pas'
 , K297698018 in 'w:\archi\source\projects\Archi\Tests\K297698018.pas'
 , K313754442 in 'w:\archi\source\projects\Archi\Tests\K313754442.pas'
 , K224788683 in 'w:\archi\source\projects\Archi\Tests\K224788683.pas'
 , K210436431 in 'w:\archi\source\projects\Archi\Tests\K210436431.pas'
 , K294603661 in 'w:\archi\source\projects\Archi\Tests\K294603661.pas'
 , K325258836 in 'w:\archi\source\projects\Archi\Tests\K325258836.pas'
 , K329649989 in 'w:\archi\source\projects\Archi\Tests\K329649989.pas'
 , K330139532 in 'w:\archi\source\projects\Archi\Tests\K330139532.pas'
 , K330704233 in 'w:\archi\source\projects\Archi\Tests\K330704233.pas'
 , K342861821 in 'w:\archi\source\projects\Archi\Tests\K342861821.pas'
 , K344130696 in 'w:\archi\source\projects\Archi\Tests\K344130696.pas'
 , K345637305 in 'w:\archi\source\projects\Archi\Tests\K345637305.pas'
 , K352455870 in 'w:\archi\source\projects\Archi\Tests\K352455870.pas'
 , K358976702 in 'w:\archi\source\projects\Archi\Tests\K358976702.pas'
 , K358976074 in 'w:\archi\source\projects\Archi\Tests\K358976074.pas'
 , K371636355 in 'w:\archi\source\projects\Archi\Tests\K371636355.pas'
 , K380045677 in 'w:\archi\source\projects\Archi\Tests\K380045677.pas'
 , K377750479 in 'w:\archi\source\projects\Archi\Tests\K377750479.pas'
 , K338003978 in 'w:\archi\source\projects\Archi\Tests\K338003978.pas'
 , ArchiInsiderTests_DialogTest_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_DialogTest_TestUnit.pas'
 , K273595400 in 'w:\archi\source\projects\Archi\Tests\K273595400.pas'
 , K323059794 in 'w:\archi\source\projects\Archi\Tests\K323059794.pas'
 , K327812385 in 'w:\archi\source\projects\Archi\Tests\K327812385.pas'
 , K330141531 in 'w:\archi\source\projects\Archi\Tests\K330141531.pas'
 , K356070765 in 'w:\archi\source\projects\Archi\Tests\K356070765.pas'
 , K358976777 in 'w:\archi\source\projects\Archi\Tests\K358976777.pas'
 , K389942714 in 'w:\archi\source\projects\Archi\Tests\K389942714.pas'
 , K330705088 in 'w:\archi\source\projects\Archi\Tests\K330705088.pas'
 , K434737002 in 'w:\archi\source\projects\Archi\Tests\K434737002.pas'
 , K437125222 in 'w:\archi\source\projects\Archi\Tests\K437125222.pas'
 , K480809940 in 'w:\archi\source\projects\Archi\Tests\K480809940.pas'
 , K481449280 in 'w:\archi\source\projects\Archi\Tests\K481449280.pas'
 , K522796828 in 'w:\archi\source\projects\Archi\Tests\K522796828.pas'
 , ArchiInsiderTests_FilterTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_FilterTests_TestUnit.pas'
 , K235876114 in 'w:\archi\source\projects\Archi\Tests\K235876114.pas'
 , K280859299 in 'w:\archi\source\projects\Archi\Tests\K280859299.pas'
 , K330140819 in 'w:\archi\source\projects\Archi\Tests\K330140819.pas'
 , K339869830 in 'w:\archi\source\projects\Archi\Tests\K339869830.pas'
 , K356063074 in 'w:\archi\source\projects\Archi\Tests\K356063074.pas'
 , K384434990 in 'w:\archi\source\projects\Archi\Tests\K384434990.pas'
 , K392695706 in 'w:\archi\source\projects\Archi\Tests\K392695706.pas'
 , K397291894 in 'w:\archi\source\projects\Archi\Tests\K397291894.pas'
 , K401511110 in 'w:\archi\source\projects\Archi\Tests\K401511110.pas'
 , K407745210 in 'w:\archi\source\projects\Archi\Tests\K407745210.pas'
 , K419695643 in 'w:\archi\source\projects\Archi\Tests\K419695643.pas'
 , K425284919 in 'w:\archi\source\projects\Archi\Tests\K425284919.pas'
 , K452392846 in 'w:\archi\source\projects\Archi\Tests\K452392846.pas'
 , K448463392 in 'w:\archi\source\projects\Archi\Tests\K448463392.pas'
 , K458072971 in 'w:\archi\source\projects\Archi\Tests\K458072971.pas'
 , K466751170 in 'w:\archi\source\projects\Archi\Tests\K466751170.pas'
 , K449678171 in 'w:\archi\source\projects\Archi\Tests\K449678171.pas'
 , K466752657 in 'w:\archi\source\projects\Archi\Tests\K466752657.pas'
 , K466752604 in 'w:\archi\source\projects\Archi\Tests\K466752604.pas'
 , K474154467 in 'w:\archi\source\projects\Archi\Tests\K474154467.pas'
 , K161121021 in 'w:\archi\source\projects\Archi\Tests\K161121021.pas'
 , K144575411 in 'w:\archi\source\projects\Archi\Tests\K144575411.pas'
 , K475464074 in 'w:\archi\source\projects\Archi\Tests\K475464074.pas'
 , K477643230 in 'w:\archi\source\projects\Archi\Tests\K477643230.pas'
 , K281519812 in 'w:\archi\source\projects\Archi\Tests\K281519812.pas'
 , K120718860 in 'w:\archi\source\projects\Archi\Tests\K120718860.pas'
 , K479402089 in 'w:\archi\source\projects\Archi\Tests\K479402089.pas'
 , K441354827 in 'w:\archi\source\projects\Archi\Tests\K441354827.pas'
 , K479402974 in 'w:\archi\source\projects\Archi\Tests\K479402974.pas'
 , K479402808 in 'w:\archi\source\projects\Archi\Tests\K479402808.pas'
 , ArchiInsiderTests_MacrosTest_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_MacrosTest_TestUnit.pas'
 , K278843000 in 'w:\archi\source\projects\Archi\Tests\K278843000.pas'
 , K430740658 in 'w:\archi\source\projects\Archi\Tests\K430740658.pas'
 , K447393371 in 'w:\archi\source\projects\Archi\Tests\K447393371.pas'
 , ArchiInsiderTests_ContentsTree_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_ContentsTree_TestUnit.pas'
 , K269080484 in 'w:\archi\source\projects\Archi\Tests\K269080484.pas'
 , K271189977 in 'w:\archi\source\projects\Archi\Tests\K271189977.pas'
 , K271190109 in 'w:\archi\source\projects\Archi\Tests\K271190109.pas'
 , K271752866 in 'w:\archi\source\projects\Archi\Tests\K271752866.pas'
 , K300027413 in 'w:\archi\source\projects\Archi\Tests\K300027413.pas'
 , K300028777 in 'w:\archi\source\projects\Archi\Tests\K300028777.pas'
 , K296094705 in 'w:\archi\source\projects\Archi\Tests\K296094705.pas'
 , K296620708 in 'w:\archi\source\projects\Archi\Tests\K296620708.pas'
 , K331186226 in 'w:\archi\source\projects\Archi\Tests\K331186226.pas'
 , K356063519 in 'w:\archi\source\projects\Archi\Tests\K356063519.pas'
 , K367198557 in 'w:\archi\source\projects\Archi\Tests\K367198557.pas'
 , K522096709 in 'w:\archi\source\projects\Archi\Tests\K522096709.pas'
 , ArchiInsiderTests_SBSTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_SBSTests_TestUnit.pas'
 , K309168151 in 'w:\archi\source\projects\Archi\Tests\K309168151.pas'
 , K109904163 in 'w:\archi\source\projects\Archi\Tests\K109904163.pas'
 , K310673720 in 'w:\archi\source\projects\Archi\Tests\K310673720.pas'
 , K320743144 in 'w:\archi\source\projects\Archi\Tests\K320743144.pas'
 , ArchiInsiderTests_TableTools_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_TableTools_TestUnit.pas'
 , K104434922 in 'w:\archi\source\projects\Archi\Tests\K104434922.pas'
 , K290947845 in 'w:\archi\source\projects\Archi\Tests\K290947845.pas'
 , K290951663 in 'w:\archi\source\projects\Archi\Tests\K290951663.pas'
 , K290951686 in 'w:\archi\source\projects\Archi\Tests\K290951686.pas'
 , K297703832 in 'w:\archi\source\projects\Archi\Tests\K297703832.pas'
 , K323061070 in 'w:\archi\source\projects\Archi\Tests\K323061070.pas'
 , K330140470 in 'w:\archi\source\projects\Archi\Tests\K330140470.pas'
 , K330140904 in 'w:\archi\source\projects\Archi\Tests\K330140904.pas'
 , K333550210 in 'w:\archi\source\projects\Archi\Tests\K333550210.pas'
 , K336137132 in 'w:\archi\source\projects\Archi\Tests\K336137132.pas'
 , K336137156 in 'w:\archi\source\projects\Archi\Tests\K336137156.pas'
 , K336659951 in 'w:\archi\source\projects\Archi\Tests\K336659951.pas'
 , K336660676 in 'w:\archi\source\projects\Archi\Tests\K336660676.pas'
 , K235864238 in 'w:\archi\source\projects\Archi\Tests\K235864238.pas'
 , K235864247 in 'w:\archi\source\projects\Archi\Tests\K235864247.pas'
 , K341838531 in 'w:\archi\source\projects\Archi\Tests\K341838531.pas'
 , K342862858 in 'w:\archi\source\projects\Archi\Tests\K342862858.pas'
 , K349116289 in 'w:\archi\source\projects\Archi\Tests\K349116289.pas'
 , K354255065 in 'w:\archi\source\projects\Archi\Tests\K354255065.pas'
 , K358354724 in 'w:\archi\source\projects\Archi\Tests\K358354724.pas'
 , K358365470 in 'w:\archi\source\projects\Archi\Tests\K358365470.pas'
 , K370383707 in 'w:\archi\source\projects\Archi\Tests\K370383707.pas'
 , K380044630 in 'w:\archi\source\projects\Archi\Tests\K380044630.pas'
 , K390585154 in 'w:\archi\source\projects\Archi\Tests\K390585154.pas'
 , K395647218 in 'w:\archi\source\projects\Archi\Tests\K395647218.pas'
 , K395658761 in 'w:\archi\source\projects\Archi\Tests\K395658761.pas'
 , K395654924 in 'w:\archi\source\projects\Archi\Tests\K395654924.pas'
 , K395659375 in 'w:\archi\source\projects\Archi\Tests\K395659375.pas'
 , K400531159 in 'w:\archi\source\projects\Archi\Tests\K400531159.pas'
 , K407150344 in 'w:\archi\source\projects\Archi\Tests\K407150344.pas'
 , K410628348 in 'w:\archi\source\projects\Archi\Tests\K410628348.pas'
 , K431359667 in 'w:\archi\source\projects\Archi\Tests\K431359667.pas'
 , ArchiInsiderTests_OEMTextTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_OEMTextTests_TestUnit.pas'
 , K336658853 in 'w:\archi\source\projects\Archi\Tests\K336658853.pas'
 , K362130404 in 'w:\archi\source\projects\Archi\Tests\K362130404.pas'
 , K370384889 in 'w:\archi\source\projects\Archi\Tests\K370384889.pas'
 , K377749722 in 'w:\archi\source\projects\Archi\Tests\K377749722.pas'
 , ArchiInsiderTests_BlockTest_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_BlockTest_TestUnit.pas'
 , K341082326 in 'w:\archi\source\projects\Archi\Tests\K341082326.pas'
 , K340165072 in 'w:\archi\source\projects\Archi\Tests\K340165072.pas'
 , K340176143 in 'w:\archi\source\projects\Archi\Tests\K340176143.pas'
 , K349118532 in 'w:\archi\source\projects\Archi\Tests\K349118532.pas'
 , K358353189 in 'w:\archi\source\projects\Archi\Tests\K358353189.pas'
 , K358355183 in 'w:\archi\source\projects\Archi\Tests\K358355183.pas'
 , K358355026 in 'w:\archi\source\projects\Archi\Tests\K358355026.pas'
 , K358975645 in 'w:\archi\source\projects\Archi\Tests\K358975645.pas'
 , K336667714 in 'w:\archi\source\projects\Archi\Tests\K336667714.pas'
 , K358975616 in 'w:\archi\source\projects\Archi\Tests\K358975616.pas'
 , K358353966 in 'w:\archi\source\projects\Archi\Tests\K358353966.pas'
 , K365831268 in 'w:\archi\source\projects\Archi\Tests\K365831268.pas'
 , K365844614 in 'w:\archi\source\projects\Archi\Tests\K365844614.pas'
 , K371644395 in 'w:\archi\source\projects\Archi\Tests\K371644395.pas'
 , K379250166 in 'w:\archi\source\projects\Archi\Tests\K379250166.pas'
 , K380604713 in 'w:\archi\source\projects\Archi\Tests\K380604713.pas'
 , K382408648 in 'w:\archi\source\projects\Archi\Tests\K382408648.pas'
 , K409747548 in 'w:\archi\source\projects\Archi\Tests\K409747548.pas'
 , K435460780 in 'w:\archi\source\projects\Archi\Tests\K435460780.pas'
 , K439979342 in 'w:\archi\source\projects\Archi\Tests\K439979342.pas'
 , K447392400 in 'w:\archi\source\projects\Archi\Tests\K447392400.pas'
 , K449024991 in 'w:\archi\source\projects\Archi\Tests\K449024991.pas'
 , ArchiInsiderTests_ScrollTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_ScrollTests_TestUnit.pas'
 , K159367236 in 'w:\archi\source\projects\Archi\Tests\K159367236.pas'
 , K289276523 in 'w:\archi\source\projects\Archi\Tests\K289276523.pas'
 , K299140051 in 'w:\archi\source\projects\Archi\Tests\K299140051.pas'
 , K342866806 in 'w:\archi\source\projects\Archi\Tests\K342866806.pas'
 , K343640765 in 'w:\archi\source\projects\Archi\Tests\K343640765.pas'
 , K370383768 in 'w:\archi\source\projects\Archi\Tests\K370383768.pas'
 , K382421131 in 'w:\archi\source\projects\Archi\Tests\K382421131.pas'
 , K407150878 in 'w:\archi\source\projects\Archi\Tests\K407150878.pas'
 , K407736033 in 'w:\archi\source\projects\Archi\Tests\K407736033.pas'
 , K404361004 in 'w:\archi\source\projects\Archi\Tests\K404361004.pas'
 , K421123801 in 'w:\archi\source\projects\Archi\Tests\K421123801.pas'
 , K423593340 in 'w:\archi\source\projects\Archi\Tests\K423593340.pas'
 , K425036023 in 'w:\archi\source\projects\Archi\Tests\K425036023.pas'
 , ArchiInsiderTests_SelectionTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_SelectionTests_TestUnit.pas'
 , K271754328 in 'w:\archi\source\projects\Archi\Tests\K271754328.pas'
 , K338005013 in 'w:\archi\source\projects\Archi\Tests\K338005013.pas'
 , K233734230 in 'w:\archi\source\projects\Archi\Tests\K233734230.pas'
 , K356060358 in 'w:\archi\source\projects\Archi\Tests\K356060358.pas'
 , K358976247 in 'w:\archi\source\projects\Archi\Tests\K358976247.pas'
 , K382407838 in 'w:\archi\source\projects\Archi\Tests\K382407838.pas'
 , K390586769 in 'w:\archi\source\projects\Archi\Tests\K390586769.pas'
 , K395662507 in 'w:\archi\source\projects\Archi\Tests\K395662507.pas'
 , K395658792 in 'w:\archi\source\projects\Archi\Tests\K395658792.pas'
 , K407150397 in 'w:\archi\source\projects\Archi\Tests\K407150397.pas'
 , K407150049 in 'w:\archi\source\projects\Archi\Tests\K407150049.pas'
 , K407740554 in 'w:\archi\source\projects\Archi\Tests\K407740554.pas'
 , K421123924 in 'w:\archi\source\projects\Archi\Tests\K421123924.pas'
 , K421111320 in 'w:\archi\source\projects\Archi\Tests\K421111320.pas'
 , K423605014 in 'w:\archi\source\projects\Archi\Tests\K423605014.pas'
 , K425035996 in 'w:\archi\source\projects\Archi\Tests\K425035996.pas'
 , K425264440 in 'w:\archi\source\projects\Archi\Tests\K425264440.pas'
 , K425273666 in 'w:\archi\source\projects\Archi\Tests\K425273666.pas'
 , K382406560 in 'w:\archi\source\projects\Archi\Tests\K382406560.pas'
 , K515524193 in 'w:\archi\source\projects\Archi\Tests\K515524193.pas'
 , ArchiInsiderTests_KeyWordsTest_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_KeyWordsTest_TestUnit.pas'
 , K342859055 in 'w:\archi\source\projects\Archi\Tests\K342859055.pas'
 , ArchiInsiderTests_Drawing_Tests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_Drawing_Tests_TestUnit.pas'
 , K281520291 in 'w:\archi\source\projects\Archi\Tests\K281520291.pas'
 , K344138247 in 'w:\archi\source\projects\Archi\Tests\K344138247.pas'
 , K356072821 in 'w:\archi\source\projects\Archi\Tests\K356072821.pas'
 , K333553224 in 'w:\archi\source\projects\Archi\Tests\K333553224.pas'
 , K370389917 in 'w:\archi\source\projects\Archi\Tests\K370389917.pas'
 , K371196695 in 'w:\archi\source\projects\Archi\Tests\K371196695.pas'
 , K375849907 in 'w:\archi\source\projects\Archi\Tests\K375849907.pas'
 , K382420133 in 'w:\archi\source\projects\Archi\Tests\K382420133.pas'
 , ArchiInsiderTests_Text2TableTests_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_Text2TableTests_TestUnit.pas'
 , K265412031 in 'w:\archi\source\projects\Archi\Tests\K265412031.pas'
 , K271754425 in 'w:\archi\source\projects\Archi\Tests\K271754425.pas'
 , K347635743 in 'w:\archi\source\projects\Archi\Tests\K347635743.pas'
 , K347636295 in 'w:\archi\source\projects\Archi\Tests\K347636295.pas'
 , K360481669 in 'w:\archi\source\projects\Archi\Tests\K360481669.pas'
 , K363564248 in 'w:\archi\source\projects\Archi\Tests\K363564248.pas'
 , K363571851 in 'w:\archi\source\projects\Archi\Tests\K363571851.pas'
 , K103940427 in 'w:\archi\source\projects\Archi\Tests\K103940427.pas'
 , K363570808 in 'w:\archi\source\projects\Archi\Tests\K363570808.pas'
 , K105579791 in 'w:\archi\source\projects\Archi\Tests\K105579791.pas'
 , K370384999 in 'w:\archi\source\projects\Archi\Tests\K370384999.pas'
 , K409757935 in 'w:\archi\source\projects\Archi\Tests\K409757935.pas'
 , ArchiInsiderTests_TableBoundariesAlignment_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_TableBoundariesAlignment_TestUnit.pas'
 , K362973200 in 'w:\archi\source\projects\Archi\Tests\K362973200.pas'
 , K362975266 in 'w:\archi\source\projects\Archi\Tests\K362975266.pas'
 , K330140756 in 'w:\archi\source\projects\Archi\Tests\K330140756.pas'
 , K200087275 in 'w:\archi\source\projects\Archi\Tests\K200087275.pas'
 , K206078013 in 'w:\archi\source\projects\Archi\Tests\K206078013.pas'
 , K365824453 in 'w:\archi\source\projects\Archi\Tests\K365824453.pas'
 , K380606923 in 'w:\archi\source\projects\Archi\Tests\K380606923.pas'
 , K425040715 in 'w:\archi\source\projects\Archi\Tests\K425040715.pas'
 , K437519082 in 'w:\archi\source\projects\Archi\Tests\K437519082.pas'
 , K437519085 in 'w:\archi\source\projects\Archi\Tests\K437519085.pas'
 , K437519128 in 'w:\archi\source\projects\Archi\Tests\K437519128.pas'
 , K437519159 in 'w:\archi\source\projects\Archi\Tests\K437519159.pas'
 , K453149163 in 'w:\archi\source\projects\Archi\Tests\K453149163.pas'
 , ArchiInsiderTests_InnerTable_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_InnerTable_TestUnit.pas'
 , K400523879 in 'w:\archi\source\projects\Archi\Tests\K400523879.pas'
 , K425273506 in 'w:\archi\source\projects\Archi\Tests\K425273506.pas'
 , K425263512 in 'w:\archi\source\projects\Archi\Tests\K425263512.pas'
 , ArchiInsiderTests_ColumnResize_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_ColumnResize_TestUnit.pas'
 , K409758383 in 'w:\archi\source\projects\Archi\Tests\K409758383.pas'
 , K424381826 in 'w:\archi\source\projects\Archi\Tests\K424381826.pas'
 , ArchiInsiderTests_TableResize_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_TableResize_TestUnit.pas'
 , K437519030 in 'w:\archi\source\projects\Archi\Tests\K437519030.pas'
 , K358976813 in 'w:\archi\source\projects\Archi\Tests\K358976813.pas'
 , ArchiInsiderTests_DataBaseSave_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_DataBaseSave_TestUnit.pas'
 , ArchiInsiderTests_LoadText_TestUnit in 'w:\archi\source\projects\Archi\Tests\ArchiInsiderTests_LoadText_TestUnit.pas'
 , K480819960 in 'w:\archi\source\projects\Archi\Tests\K480819960.pas'
 , K480817440 in 'w:\archi\source\projects\Archi\Tests\K480817440.pas'
 , K482752570 in 'w:\archi\source\projects\Archi\Tests\K482752570.pas'
 , K482767115 in 'w:\archi\source\projects\Archi\Tests\K482767115.pas'
 , K517791575 in 'w:\archi\source\projects\Archi\Tests\K517791575.pas'
 , Tasks_TestLibrary in 'w:\archi\source\projects\Archi\Tests\Tasks_TestLibrary.pas'
 , Tasks_Registering_TestUnit in 'w:\archi\source\projects\Archi\Tests\Tasks_Registering_TestUnit.pas'
 , RegisteredTasksTest in 'w:\archi\source\projects\Archi\Tests\RegisteredTasksTest.pas'
 {$If NOT Defined(Nemesis)}
 , ddServerTask in 'w:\common\components\rtl\Garant\cs\ddServerTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ddTaskItemPrim in 'w:\common\components\rtl\Garant\EVD\ddTaskItemPrim.pas'
 , evdTaskTypes in 'w:\common\components\rtl\Garant\EVD\evdTaskTypes.pas'
 , csTaskListening in 'w:\common\components\rtl\Garant\EVD\csTaskListening.pas'
 , Task_Const in 'w:\common\components\rtl\Garant\EVD\Task_Const.pas'
 , DateTimeNotNull_Const in 'w:\common\components\rtl\Garant\EVD\DateTimeNotNull_Const.pas'
 , DateTime_Const in 'w:\common\components\rtl\Garant\EVD\DateTime_Const.pas'
 , ULong_Const in 'w:\common\components\rtl\Garant\EVD\ULong_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ddTaskClassManager in 'w:\common\components\rtl\Garant\cs\ddTaskClassManager.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddTaskRecordList in 'w:\common\components\rtl\Garant\cs\ddTaskRecordList.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddTaskRecord in 'w:\common\components\rtl\Garant\cs\ddTaskRecord.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes in 'w:\common\components\rtl\Garant\cs\csTaskTypes.pas'
 {$IfEnd} // NOT Defined(Nemesis)
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
  m4WordList,
  arDocObjectMixer in 'w:\archi\source\projects\Common\Utils\arDocObjectMixer.pas',
  arFoundSelectionFilter in 'w:\archi\source\projects\Common\Utils\arFoundSelectionFilter.pas'

 //#UC END# *4DE4A1D0031Emanualuses*
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

{$If Defined(nsTest) AND Defined(InsiderTest)}
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
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
 if CheckRunCondition then
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
