program AutoPipeServerTest;
 {* Тесты Сервера автоматизации Архивариуса }

// Модуль: "w:\archi\source\projects\PipeInAuto\AutoPipeServerTest.dpr"
// Стереотип: "TestTarget"
// Элемент модели: "AutoPipeServer" MUID: (52F24F6103AB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

{$If Defined(AppServerSide)}
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
 , ActiveX in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas'
 , Windows in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas'
 , Types
 , l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas'
 , Messages in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas'
 , Graphics in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas'
 , Classes in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas'
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy in 'w:\common\components\rtl\Garant\ScriptEngine\TtfwTypeRegistrator_Proxy.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , TypInfo in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas'
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
 , RTLConsts in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\RTLConsts.pas'
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
 , SyncObjs in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\SyncObjs.pas'
 , l3TwoByteCString in 'w:\common\components\rtl\Garant\L3\l3TwoByteCString.pas'
 {$If NOT Defined(NoScripts)}
 , tfwIl3CStringPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwIteratableParent in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas'
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
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryPrimPrimPrim in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrimPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , Math in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Math.pas'
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
 , tfwStoredValues in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledVar in 'w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwArray in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArray.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwValueList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwValueList.pas'
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
 , StrUtils in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas'
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
 , tfwArrayView in 'w:\common\components\rtl\Garant\ScriptEngine\tfwArrayView.pas'
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
 , l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas'
 , l3ProgressComponent in 'w:\common\components\rtl\Garant\L3\l3ProgressComponent.pas'
 , l3InterfacedComponent in 'w:\common\components\rtl\Garant\L3\l3InterfacedComponent.pas'
 , l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas'
 , l3StringIDEx in 'w:\common\components\rtl\Garant\L3\l3StringIDEx.pas'
 , l3ConstStrings in 'w:\common\components\rtl\Garant\L3\l3ConstStrings.pas'
 , l3ConstStrings1 in 'w:\common\components\rtl\Garant\L3\l3ConstStrings1.pas'
 , l3FileUtils in 'w:\common\components\rtl\Garant\L3\l3FileUtils.pas'
 , l3Stream in 'w:\common\components\rtl\Garant\L3\l3Stream.pas'
 {$If NOT Defined(NoScripts)}
 , SysUtilsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SysUtilsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3TabService in 'w:\common\components\rtl\Garant\L3\l3TabService.pas'
 , l3SysUtils in 'w:\common\components\rtl\Garant\L3\l3SysUtils.pas'
 , JclSysInfo in 'w:\common\components\rtl\external\JEDI\source\common\JclSysInfo.pas'
 , DateUtils in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\DateUtils.pas'
 {$If NOT Defined(NoVCL)}
 , Forms in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Forms.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Controls.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ActnList in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ActnList.pas'
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
 , Menus in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Menus.pas'
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
 , Clipbrd in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Clipbrd.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Utils in 'w:\common\components\rtl\Garant\L3\l3Utils.pas'
 , l3CStringDataObject in 'w:\common\components\rtl\Garant\L3\l3CStringDataObject.pas'
 , l3StorableDataObject in 'w:\common\components\rtl\Garant\L3\l3StorableDataObject.pas'
 , l3DataObject in 'w:\common\components\rtl\Garant\L3\l3DataObject.pas'
 , l3LongintList in 'w:\common\components\rtl\Garant\L3\l3LongintList.pas'
 , l3LongintListPrim in 'w:\common\components\rtl\Garant\L3\l3LongintListPrim.pas'
 , l3StringList in 'w:\common\components\rtl\Garant\L3\l3StringList.pas'
 , l3StringList2 in 'w:\common\components\rtl\Garant\L3\l3StringList2.pas'
 , l3StringList1 in 'w:\common\components\rtl\Garant\L3\l3StringList1.pas'
 , l3StringListPrim in 'w:\common\components\rtl\Garant\L3\l3StringListPrim.pas'
 , l3ProtoPersistentDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas'
 , l3DataObjectEnum in 'w:\common\components\rtl\Garant\L3\l3DataObjectEnum.pas'
 , ShlObj in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShlObj.pas'
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
 {$If NOT Defined(NoVCL)}
 , ControlResizeBugFix
 {$IfEnd} // NOT Defined(NoVCL)
 , AutoPipeServerTestsRunner in 'w:\archi\source\projects\PipeInAuto\AutoPipeServerTestsRunner.pas'
 {$If Defined(nsTest)}
 , GUIAppTester in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , KTestRunner in 'w:\common\components\rtl\Garant\DUnitTuning\KTestRunner.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest in 'w:\common\components\rtl\Garant\DUnitTuning\BaseTest.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest)}
 , TestFrameWork in 'w:\common\components\rtl\external\DUnit\src\TestFrameWork.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ITestWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\ITestWordsPack.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3CardinalList in 'w:\common\components\rtl\Garant\L3\l3CardinalList.pas'
 , l3ImageUtils in 'w:\common\components\rtl\Garant\L3\l3ImageUtils.pas'
 {$If Defined(nsTest) AND Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)}
 , KBridge in 'w:\common\components\rtl\Garant\DUnitTuning\KBridge.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , orb_int in 'w:\common\components\rtl\external\MTDOrb\src\orbint\orb_int.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , SecuritySrv_int in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv_int.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , CosNaming_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming_int.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , Contents_int in 'w:\common\components\rtl\Garant\ServerGate\Contents_int.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , GarORBInitializerImpl in 'w:\common\components\rtl\Garant\GarORB\GarORBInitializerImpl.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , pi in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , pi_int in 'w:\common\components\rtl\external\MTDOrb\src\idl\pi_int.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , orb in 'w:\common\components\rtl\external\MTDOrb\src\orb\orb.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , GarClientSecurity in 'w:\common\components\rtl\Garant\GarORB\GarClientSecurity.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , orbtypes in 'w:\common\components\rtl\external\MTDOrb\src\orb\orbtypes.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , pi_impl in 'w:\common\components\rtl\external\MTDOrb\src\orb\pi_impl.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , CosNaming in 'w:\common\components\rtl\external\MTDOrb\src\idl\CosNaming.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , SecuritySrv in 'w:\common\components\rtl\external\MTDOrb\build\SecuritySrv.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
 , Contents in 'w:\common\components\rtl\Garant\ServerGate\Contents.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , tfwKConst in 'w:\common\components\rtl\Garant\DUnitTuning\tfwKConst.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
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
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , TestNameList in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameList.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , TestNameString in 'w:\common\components\rtl\Garant\DUnitTuning\TestNameString.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest)}
 , TextTestRunner in 'w:\common\components\rtl\external\DUnit\src\TextTestRunner.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , ExcludedTests in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTests.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , ExcludedTestsFolders in 'w:\common\components\rtl\Garant\DUnitTuning\ExcludedTestsFolders.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , TestDocumentList in 'w:\common\components\rtl\Garant\DUnitTuning\TestDocumentList.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 , vtVerInf in 'w:\common\components\rtl\Garant\L3\vtVerInf.pas'
 , l3VersionInfoService in 'w:\common\components\rtl\Garant\L3\l3VersionInfoService.pas'
 , JwaWinBase in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas'
 , JwaNtStatus in 'w:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas'
 , JwaWinNT in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas'
 , JwaWinType in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , tfwScriptDebugger in 'w:\common\components\rtl\Garant\DUnitTuning\tfwScriptDebugger.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 {$If Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(InsiderTest)}
 , evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest)
 , afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas'
 , afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas'
 {$If NOT Defined(NoVCL)}
 , ImgList in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas'
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
 , Dialogs in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas'
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
 {$If Defined(nsTest)}
 , afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
 {$IfEnd} // Defined(nsTest)
 , afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas'
 , l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas'
 , Consts in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas'
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
 , tfwParserService in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserService.pas'
 , IniFiles in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\IniFiles.pas'
 {$If NOT Defined(NoScripts)}
 , ItfwParserWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ItfwParserExWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwStoredValuesStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas'
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
 {$If Defined(nsTest)}
 , GUITestRunner in 'w:\common\components\rtl\external\DUnit\src\GUITestRunner.pas'
 {$IfEnd} // Defined(nsTest)
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
 , StdCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas'
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
 , ExtCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas'
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
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , kwPopEditorRepaintAndCheckWithEtalon in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
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
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , kwBeginWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwBeginWaitPrint.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , kwEndWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
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
 , Printers in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Printers.pas'
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
 , ShellAPI in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShellAPI.pas'
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
 {$If Defined(nsTest)}
 , PrintRowHeightsSpy in 'w:\common\components\gui\Garant\Everest\new\PrintRowHeightsSpy.pas'
 {$IfEnd} // Defined(nsTest)
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
 , Themes in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Themes.pas'
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
 {$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwKeyWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ComCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeNodeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeNodeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeViewWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TTreeNodeForTestsWordsPack in 'w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If Defined(nsTest)}
 , FolderSupport in 'w:\common\components\rtl\external\DUnit\src\FolderSupport.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , TestForm4Scripts in 'w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\TestForm4Scripts.pas'
 {$IfEnd} // Defined(nsTest)
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
 , CommCtrl in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\CommCtrl.pas'
 , toK in 'w:\archi\source\projects\PipeInAuto\toK.pas'
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , ArchiAutoTestSuite in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiAutoTestSuite.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , ArchiAutoTest in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiAutoTest.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , ArchiInsiderTest in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiInsiderTest.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 , l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwArchiEverestWordsPack in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiEverestWordsPack.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwDisableMergedCellFilter in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDisableMergedCellFilter.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 , evCommonUtils in 'w:\archi\source\projects\Common\Utils\evCommonUtils.pas'
 , evCommonTypes in 'w:\common\components\gui\Garant\EverestCommon\evCommonTypes.pas'
 , arCommonTypes in 'w:\archi\source\projects\Common\Utils\arCommonTypes.pas'
 , dt_Types in 'w:\common\components\rtl\Garant\dd\dt_Types.pas'
 , evdDTTypes in 'w:\common\components\rtl\Garant\EVD\evdDTTypes.pas'
 , daTypes in 'w:\common\components\rtl\Garant\DA\daTypes.pas'
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
 , dt_Const in 'w:\common\components\rtl\Garant\dd\dt_Const.pas'
 {$If Defined(Archi) AND NOT Defined(Nemesis)}
 , dt_LinkServ in 'w:\common\components\rtl\Garant\DT\dt_LinkServ.pas'
 {$IfEnd} // Defined(Archi) AND NOT Defined(Nemesis)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwClearFindDialog in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearFindDialog.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 , D_TxSrch in 'w:\archi\source\projects\Common\Dialogs\D_TxSrch.pas'
 {$If NOT Defined(NoScripts)}
 , TTextSearchDlgWordsPack in 'w:\archi\source\projects\Common\Dialogs\TTextSearchDlgWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwAutoCompleteClear in 'w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwAutoCompleteClear.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
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
 {$If Defined(nsTest) AND Defined(InsiderTest)}
 , Tasks_TestLibrary in 'w:\archi\source\projects\Archi\Tests\Tasks_TestLibrary.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
 {$If Defined(nsTest) AND Defined(InsiderTest)}
 , Tasks_Registering_TestUnit in 'w:\archi\source\projects\Archi\Tests\Tasks_Registering_TestUnit.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
 {$If Defined(nsTest) AND Defined(InsiderTest)}
 , RegisteredTasksTest in 'w:\archi\source\projects\Archi\Tests\RegisteredTasksTest.pas'
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
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
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_TestLibrary in 'w:\archi\source\projects\PipeInAuto\Tests\Low_Level_Tests_TestLibrary.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_TasksProcessing_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Processing\Low_Level_Tests_TasksProcessing_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K515862135 in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Processing\K515862135.pas'
 {$IfEnd} // Defined(InsiderTest)
 , ddAppConfig in 'w:\common\components\rtl\Garant\dd\ddAppConfig.pas'
 , ddAppConfigTypes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas'
 , ddConfigStorages in 'w:\common\components\rtl\Garant\dd\ddConfigStorages.pas'
 , ddAppConfigConst in 'w:\common\components\rtl\Garant\dd\ddAppConfigConst.pas'
 , ddAppConfigBase in 'w:\common\components\rtl\Garant\dd\ddAppConfigBase.pas'
 , l3ProtoPersistentRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentRefList.pas'
 , vtLabel in 'w:\common\components\gui\Garant\VT\vtLabel.pas'
 , l3GraphicControlCanvas in 'w:\common\components\rtl\Garant\L3\l3GraphicControlCanvas.pas'
 , Contnrs in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Contnrs.pas'
 , ddAppConfigTypesRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas'
 , vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SpinEditWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , vtRadioButton in 'w:\common\components\gui\Garant\VT\vtRadioButton.pas'
 , vtGroupBox in 'w:\common\components\gui\Garant\VT\vtGroupBox.pas'
 , vtPanel in 'w:\common\components\gui\Garant\VT\vtPanel.pas'
 , afwTextControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControl.pas'
 , afwTextControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControlPrim.pas'
 , vtButton in 'w:\common\components\gui\Garant\VT\vtButton.pas'
 , eeButton in 'w:\common\components\gui\Garant\VT\eeButton.pas'
 , vtCheckBox in 'w:\common\components\gui\Garant\VT\vtCheckBox.pas'
 , eeCheckBox in 'w:\common\components\gui\Garant\VT\eeCheckBox.pas'
 {$If NOT Defined(NoVCL)}
 , CheckLst in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CheckLst.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CheckListBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ddAppConfigRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas'
 , ddAppConfigStrings in 'w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas'
 , ddAppConfigStringsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas'
 , l3Base64 in 'w:\common\components\rtl\Garant\L3\l3Base64.pas'
 {$If NOT Defined(NoVCL)}
 , FileCtrl in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\FileCtrl.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , MMSystem in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\MMSystem.pas'
 , ddAppConfigVersions in 'w:\common\components\rtl\Garant\dd\ddAppConfigVersions.pas'
 , l3RecList in 'w:\common\components\rtl\Garant\L3\l3RecList.pas'
 , l3BaseRecList in 'w:\common\components\rtl\Garant\L3\l3BaseRecList.pas'
 , l3ProtoPtrRecList in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecList.pas'
 , l3RecListWithPartialFind in 'w:\common\components\rtl\Garant\L3\l3RecListWithPartialFind.pas'
 , l3ProtoPtrRecListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas'
 , ddAppConfigWFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigWFrame.pas'
 , ddAppConfigDataAdapters in 'w:\common\components\rtl\Garant\dd\ddAppConfigDataAdapters.pas'
 , ddAppConfigUtils in 'w:\common\components\rtl\Garant\dd\ddAppConfigUtils.pas'
 , ddAppConfigSimpleBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigSimpleBFrame.pas'
 , ddAppConfigDates in 'w:\common\components\rtl\Garant\dd\ddAppConfigDates.pas'
 , l3TypedIntegerValueMap in 'w:\common\components\rtl\Garant\L3\l3TypedIntegerValueMap.pas'
 , ddAppConfigLists in 'w:\common\components\rtl\Garant\dd\ddAppConfigLists.pas'
 , ddAppConfigListsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigListsRes.pas'
 {$If NOT Defined(Nemesis)}
 , ddIniStorage in 'w:\common\components\rtl\Garant\dd\ddIniStorage.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ddAppConfigTFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigTFrame.pas'
 , ddAppConfigBFrame in 'w:\common\components\rtl\Garant\dd\ddAppConfigBFrame.pas'
 , multimon in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\multimon.pas'
 , vtSizeablePanel in 'w:\common\components\gui\Garant\VT\vtSizeablePanel.pas'
 , AutoPipeServerForm in 'w:\archi\source\projects\PipeInAuto\AutoPipeServerForm.pas'
 , alcuServer in 'w:\archi\source\projects\PipeInAuto\Server\alcuServer.pas'
 , alcuAutoPipeServer in 'w:\archi\source\projects\PipeInAuto\Server\alcuAutoPipeServer.pas'
 {$If Defined(MDPSyncIntegrated)}
 , alcuDictChangeMDPSynchronizator in 'w:\archi\source\projects\PipeInAuto\Server\alcuDictChangeMDPSynchronizator.pas'
 {$IfEnd} // Defined(MDPSyncIntegrated)
 {$If NOT Defined(Nemesis)}
 , dt_DictTypes in 'w:\common\components\rtl\Garant\DT\dt_DictTypes.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Mutex in 'w:\common\components\rtl\Garant\L3\l3Mutex.pas'
 , alcuTaskManager in 'w:\archi\source\projects\PipeInAuto\Server\alcuTaskManager.pas'
 {$If Defined(ServerTasks)}
 , alcuServerAsyncExecutionInterfaces in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuServerAsyncExecutionInterfaces.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csProcessTask in 'w:\common\components\rtl\Garant\cs\csProcessTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim in 'w:\common\components\rtl\Garant\cs\ddProcessTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , evdTasksHelpers in 'w:\common\components\rtl\Garant\EVD\evdTasksHelpers.pas'
 , k2SizedMemoryPool in 'w:\common\components\rtl\Garant\K2\k2SizedMemoryPool.pas'
 , k2MemoryPoolAdapter in 'w:\common\components\rtl\Garant\K2\k2MemoryPoolAdapter.pas'
 , k2MemoryStream in 'w:\common\components\rtl\Garant\K2\k2MemoryStream.pas'
 , l3TempMemoryStream in 'w:\common\components\rtl\Garant\L3\l3TempMemoryStream.pas'
 , ComObj in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas'
 , TaskID_Const in 'w:\common\components\rtl\Garant\EVD\TaskID_Const.pas'
 , ddProgressObj in 'w:\common\components\rtl\Garant\dd\ddProgressObj.pas'
 , ProcessTask_Const in 'w:\common\components\rtl\Garant\EVD\ProcessTask_Const.pas'
 , csTaskResult in 'w:\common\components\rtl\Garant\EVD\csTaskResult.pas'
 , TaskResult_Const in 'w:\common\components\rtl\Garant\EVD\TaskResult_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuDeliveryInterfaces in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuDeliveryInterfaces.pas'
 {$IfEnd} // Defined(ServerTasks)
 , ddServerTaskManagerPrim in 'w:\archi\source\projects\PipeInAuto\Server\ddServerTaskManagerPrim.pas'
 {$If Defined(ServerTasks)}
 , alcuDetachedExecutorPool in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuDetachedExecutorPool.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuDetachedExecutorList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuDetachedExecutorList.pas'
 {$IfEnd} // Defined(ServerTasks)
 , l3MultiThreadSortedIntegerList in 'w:\common\components\rtl\Garant\L3\l3MultiThreadSortedIntegerList.pas'
 , l3MultiThreadIntegerList in 'w:\common\components\rtl\Garant\L3\l3MultiThreadIntegerList.pas'
 {$If Defined(ServerTasks)}
 , alcuSubmitterWorkPool in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuSubmitterWorkPool.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuSubmitterWorkThreadList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuSubmitterWorkThreadList.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuAsyncSubmitter in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAsyncSubmitter.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuAsyncTaskFinishedNotifierList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAsyncTaskFinishedNotifierList.pas'
 {$IfEnd} // Defined(ServerTasks)
 , daInterfaces in 'w:\common\components\rtl\Garant\DA\daInterfaces.pas'
 , l3Languages in 'w:\common\components\rtl\Garant\L3\l3Languages.pas'
 , daDataProvider in 'w:\common\components\rtl\Garant\DA\daDataProvider.pas'
 , alcuBaseEngineHolder in 'w:\archi\source\projects\PipeInAuto\Server\alcuBaseEngineHolder.pas'
 , alcuBaseEngine in 'w:\archi\source\projects\PipeInAuto\Server\alcuBaseEngine.pas'
 {$If Defined(ServerTasks)}
 , alcuTaskList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskList.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuSortedTaskList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuSortedTaskList.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuTaskListBase in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListBase.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuTaskListBasePrim in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListBasePrim.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuTaskListPrim in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListPrim.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuNotSortedTaskList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuNotSortedTaskList.pas'
 {$IfEnd} // Defined(ServerTasks)
 , alcuAsyncSubmitterManager in 'w:\archi\source\projects\PipeInAuto\Server\alcuAsyncSubmitterManager.pas'
 , alcuTaskExecutingList in 'w:\archi\source\projects\PipeInAuto\Server\alcuTaskExecutingList.pas'
 {$If NOT Defined(Nemesis)}
 , CsNotification in 'w:\common\components\rtl\Garant\cs\CsNotification.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , daUtils in 'w:\common\components\rtl\Garant\DA\daUtils.pas'
 {$If Defined(ServerTasks)}
 , alcuGetReadyToDeliveryTasksExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuGetReadyToDeliveryTasksExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuExecutorWithTaskList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuExecutorWithTaskList.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces in 'w:\common\components\rtl\Garant\cs\ncsMessageInterfaces.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsCommon in 'w:\common\components\rtl\Garant\cs\CsCommon.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , IdGlobal in 'w:\common\components\rtl\external\Indy\Source\System\IdGlobal.pas'
 , daDataProviderParams in 'w:\common\components\rtl\Garant\DA\daDataProviderParams.pas'
 , l3IniFile in 'w:\common\components\rtl\Garant\L3\l3IniFile.pas'
 , DataProviderParams_Const in 'w:\common\components\rtl\Garant\EVD\DataProviderParams_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsMessage in 'w:\common\components\rtl\Garant\cs\ncsMessage.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , evdNcsTypes in 'w:\common\components\rtl\Garant\EVD\evdNcsTypes.pas'
 , csMessage_Const in 'w:\common\components\rtl\Garant\EVD\csMessage_Const.pas'
 , csDIsconnect_Const in 'w:\common\components\rtl\Garant\EVD\csDIsconnect_Const.pas'
 , csMessageWithReply_Const in 'w:\common\components\rtl\Garant\EVD\csMessageWithReply_Const.pas'
 , csDIsconnectReply_Const in 'w:\common\components\rtl\Garant\EVD\csDIsconnectReply_Const.pas'
 , csReply_Const in 'w:\common\components\rtl\Garant\EVD\csReply_Const.pas'
 {$If NOT Defined(Nemesis)}
 , csIdIOHandlerAbstractAdapter in 'w:\common\components\rtl\Garant\cs\csIdIOHandlerAbstractAdapter.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csIdIOHandlerAbstractAdapterPrim in 'w:\common\components\rtl\Garant\cs\csIdIOHandlerAbstractAdapterPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsObject in 'w:\common\components\rtl\Garant\cs\CsObject.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasks in 'w:\common\components\rtl\Garant\cs\ncsGetReadyToDeliveryTasks.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csGetReadyToDeliveryTasks_Const in 'w:\common\components\rtl\Garant\EVD\csGetReadyToDeliveryTasks_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasksReply in 'w:\common\components\rtl\Garant\cs\ncsGetReadyToDeliveryTasksReply.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csGetReadyToDeliveryTasksReply_Const in 'w:\common\components\rtl\Garant\EVD\csGetReadyToDeliveryTasksReply_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuGetTaskDescriptionExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuGetTaskDescriptionExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescription in 'w:\common\components\rtl\Garant\cs\ncsGetTaskDescription.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csGetTaskDescription_Const in 'w:\common\components\rtl\Garant\EVD\csGetTaskDescription_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescriptionReply in 'w:\common\components\rtl\Garant\cs\ncsGetTaskDescriptionReply.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsFileDescHelper in 'w:\common\components\rtl\Garant\cs\ncsFileDescHelper.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , FileDesc_Const in 'w:\common\components\rtl\Garant\EVD\FileDesc_Const.pas'
 , csGetTaskDescriptionReply_Const in 'w:\common\components\rtl\Garant\EVD\csGetTaskDescriptionReply_Const.pas'
 {$If NOT Defined(Nemesis)}
 , csExport in 'w:\common\components\rtl\Garant\cs\csExport.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csExportTaskPrim in 'w:\common\components\rtl\Garant\cs\csExportTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ExportTask_Const in 'w:\common\components\rtl\Garant\EVD\ExportTask_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsFileDesc in 'w:\common\components\rtl\Garant\cs\ncsFileDesc.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ddFileIterator in 'w:\common\components\rtl\Garant\dd\ddFileIterator.pas'
 , l3CRCUtils in 'w:\common\components\rtl\Garant\L3\l3CRCUtils.pas'
 {$If Defined(ServerTasks)}
 , alcuTaskProgressExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskProgressExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsTaskProgress in 'w:\common\components\rtl\Garant\cs\ncsTaskProgress.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csTaskProgress_Const in 'w:\common\components\rtl\Garant\EVD\csTaskProgress_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuDeliveryResultExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuDeliveryResultExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsDeliveryResult in 'w:\common\components\rtl\Garant\cs\ncsDeliveryResult.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csDeliveryResult_Const in 'w:\common\components\rtl\Garant\EVD\csDeliveryResult_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuGetFilePartExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuGetFilePartExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsGetFilePart in 'w:\common\components\rtl\Garant\cs\ncsGetFilePart.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csGetFilePart_Const in 'w:\common\components\rtl\Garant\EVD\csGetFilePart_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsGetFilePartReply in 'w:\common\components\rtl\Garant\cs\ncsGetFilePartReply.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csGetFilePartReply_Const in 'w:\common\components\rtl\Garant\EVD\csGetFilePartReply_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsPushFilePart in 'w:\common\components\rtl\Garant\cs\ncsPushFilePart.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csPushFilePart_Const in 'w:\common\components\rtl\Garant\EVD\csPushFilePart_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsProfile in 'w:\common\components\rtl\Garant\cs\ncsProfile.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , l3StopWatch in 'w:\common\components\rtl\Garant\L3\l3StopWatch.pas'
 {$If Defined(ServerTasks)}
 , alcuSendTaskExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuSendTaskExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuExecutorWithIncomingTaskList in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuExecutorWithIncomingTaskList.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ddServerTaskList in 'w:\common\components\rtl\Garant\cs\ddServerTaskList.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddServerTaskListPrim in 'w:\common\components\rtl\Garant\cs\ddServerTaskListPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsSendTask in 'w:\common\components\rtl\Garant\cs\ncsSendTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csSendTask_Const in 'w:\common\components\rtl\Garant\EVD\csSendTask_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsSendTaskReply in 'w:\common\components\rtl\Garant\cs\ncsSendTaskReply.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csSendTaskReply_Const in 'w:\common\components\rtl\Garant\EVD\csSendTaskReply_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuTaskFileTransferServices in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskFileTransferServices.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsGetPartialTaskDescription in 'w:\common\components\rtl\Garant\cs\ncsGetPartialTaskDescription.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csGetPartialTaskDescription_Const in 'w:\common\components\rtl\Garant\EVD\csGetPartialTaskDescription_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsOneFileDeliverer in 'w:\common\components\rtl\Garant\cs\ncsOneFileDeliverer.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsTaskedFileDesc in 'w:\common\components\rtl\Garant\cs\ncsTaskedFileDesc.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , TaskedFileDesc_Const in 'w:\common\components\rtl\Garant\EVD\TaskedFileDesc_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ncsMessageExecutorFactory in 'w:\common\components\rtl\Garant\cs\ncsMessageExecutorFactory.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsExecutorFactoryList in 'w:\common\components\rtl\Garant\cs\ncsExecutorFactoryList.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(ServerTasks)}
 , alcuCorrectFolderExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuCorrectFolderExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ncsCorrectFolder in 'w:\common\components\rtl\Garant\cs\ncsCorrectFolder.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , csCorrectFolder_Const in 'w:\common\components\rtl\Garant\EVD\csCorrectFolder_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuDetachedExecutor in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuDetachedExecutor.pas'
 {$IfEnd} // Defined(ServerTasks)
 , alcuProcessingEnabledService in 'w:\archi\source\projects\PipeInAuto\Server\alcuProcessingEnabledService.pas'
 , l3ProcessingEnabledService in 'w:\common\components\rtl\Garant\L3\l3ProcessingEnabledService.pas'
 , alcuMdpSyncIntf in 'w:\archi\source\projects\PipeInAuto\Process\alcuMdpSyncIntf.pas'
 {$If NOT Defined(Nemesis)}
 , dtIntf in 'w:\common\components\rtl\Garant\DT\dtIntf.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_DictConst in 'w:\common\components\rtl\Garant\DT\dt_DictConst.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Sab in 'w:\common\components\rtl\Garant\DT\dt_Sab.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , daSchemeConsts in 'w:\common\components\rtl\Garant\DA\daSchemeConsts.pas'
 {$If NOT Defined(Nemesis)}
 , dt_Dict in 'w:\common\components\rtl\Garant\DT\dt_Dict.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , l3XMLWriter in 'w:\common\components\rtl\Garant\L3\l3XMLWriter.pas'
 {$If Defined(ServerTasks)}
 , alcuMdpSyncDicts in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuMdpSyncDicts.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csMdpSyncDicts in 'w:\common\components\rtl\Garant\cs\csMdpSyncDicts.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMdpSyncPrim in 'w:\common\components\rtl\Garant\cs\csMdpSyncPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , mdpSync_Const in 'w:\common\components\rtl\Garant\EVD\mdpSync_Const.pas'
 , mdpSyncDicts_Const in 'w:\common\components\rtl\Garant\EVD\mdpSyncDicts_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuMdpSyncParamUtils in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuMdpSyncParamUtils.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(MDPSyncIntegrated)}
 , alcuMdpDocImporter in 'w:\archi\source\projects\PipeInAuto\Server\alcuMdpDocImporter.pas'
 {$IfEnd} // Defined(MDPSyncIntegrated)
 {$If Defined(ServerTasks)}
 , alcuMdpImportDocs in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuMdpImportDocs.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csMdpImportDocs in 'w:\common\components\rtl\Garant\cs\csMdpImportDocs.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , mdpImportDocs_Const in 'w:\common\components\rtl\Garant\EVD\mdpImportDocs_Const.pas'
 , alcuServerTaskManagerFactory in 'w:\archi\source\projects\PipeInAuto\Server\alcuServerTaskManagerFactory.pas'
 {$If Defined(ServerTasks)}
 , alcuMdpSyncStages in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuMdpSyncStages.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csMdpSyncStages in 'w:\common\components\rtl\Garant\cs\csMdpSyncStages.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , mdpSyncStages_Const in 'w:\common\components\rtl\Garant\EVD\mdpSyncStages_Const.pas'
 , alcuMdpStagesSyncronizer in 'w:\archi\source\projects\PipeInAuto\Process\alcuMdpStagesSyncronizer.pas'
 , alcuMdpDatedSyncronizer in 'w:\archi\source\projects\PipeInAuto\Process\alcuMdpDatedSyncronizer.pas'
 , alcuMdpProtoSyncronizer in 'w:\archi\source\projects\PipeInAuto\Process\alcuMdpProtoSyncronizer.pas'
 {$If NOT Defined(Nemesis)}
 , dt_Serv in 'w:\common\components\rtl\Garant\DT\dt_Serv.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(ServerTasks)}
 , alcuMdpSyncImport in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuMdpSyncImport.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csMdpSyncImport in 'w:\common\components\rtl\Garant\cs\csMdpSyncImport.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , mdpSyncImport_Const in 'w:\common\components\rtl\Garant\EVD\mdpSyncImport_Const.pas'
 , alcuMdpImportSyncronizer in 'w:\archi\source\projects\PipeInAuto\Process\alcuMdpImportSyncronizer.pas'
 , alcuStrings in 'w:\archi\source\projects\PipeInAuto\Core\alcuStrings.pas'
 , alcuTaskChangeHelper in 'w:\archi\source\projects\PipeInAuto\Server\alcuTaskChangeHelper.pas'
 {$If NOT Defined(Nemesis)}
 , csTaskChangeHelper in 'w:\common\components\rtl\Garant\cs\csTaskChangeHelper.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuMailServer in 'w:\archi\source\projects\PipeInAuto\Server\alcuMailServer.pas'
 , alcuTypes in 'w:\archi\source\projects\PipeInAuto\Core\alcuTypes.pas'
 {$If Defined(InsiderTest)}
 , ddServerTaskManagerForTests in 'w:\archi\source\projects\PipeInAuto\Tests\ddServerTaskManagerForTests.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K578892941 in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Processing\K578892941.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_TaskSaveLoad_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\Low_Level_Tests_TaskSaveLoad_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddTaskItem in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddTaskItem.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TCheckSaveToStream in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TCheckSaveToStream.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddProcessTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddProcessTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddRequestTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddRequestTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csRequestTask in 'w:\common\components\rtl\Garant\cs\csRequestTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsDataPipe in 'w:\common\components\rtl\Garant\cs\CsDataPipe.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsDataPipePrim in 'w:\common\components\rtl\Garant\cs\CsDataPipePrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , IdIOHandler in 'w:\common\components\rtl\external\Indy\Source\Core\IdIOHandler.pas'
 {$If NOT Defined(Nemesis)}
 , csIdIOHandlerAdapter in 'w:\common\components\rtl\Garant\cs\csIdIOHandlerAdapter.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , RequestTask_Const in 'w:\common\components\rtl\Garant\EVD\RequestTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TddClientMessage in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddClientMessage.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csClientMessageRequest in 'w:\common\components\rtl\Garant\cs\csClientMessageRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddClientMessagePrim in 'w:\common\components\rtl\Garant\cs\ddClientMessagePrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ClientMessage_Const in 'w:\common\components\rtl\Garant\EVD\ClientMessage_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TddCommonDataRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddCommonDataRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csCommonDataRequest in 'w:\common\components\rtl\Garant\cs\csCommonDataRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddCommonDataRequestPrim in 'w:\common\components\rtl\Garant\cs\ddCommonDataRequestPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , CommonDataRequest_Const in 'w:\common\components\rtl\Garant\EVD\CommonDataRequest_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TddBaseStatusRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddBaseStatusRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csBaseStatusRequest in 'w:\common\components\rtl\Garant\cs\csBaseStatusRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(InsiderTest)}
 , K517772970_TddServerStatusRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddServerStatusRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csServerStatusRequest in 'w:\common\components\rtl\Garant\cs\csServerStatusRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddServerStatusRequestPrim in 'w:\common\components\rtl\Garant\cs\ddServerStatusRequestPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ServerStatusRequest_Const in 'w:\common\components\rtl\Garant\EVD\ServerStatusRequest_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TaskRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TaskRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csTaskRequest in 'w:\common\components\rtl\Garant\cs\csTaskRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddGetTaskRequestPrim in 'w:\common\components\rtl\Garant\cs\ddGetTaskRequestPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , askRequest in 'w:\common\components\rtl\Garant\cs\askRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , GetTaskRequest_Const in 'w:\common\components\rtl\Garant\EVD\GetTaskRequest_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ddTaskResultRequestPrim in 'w:\common\components\rtl\Garant\cs\ddTaskResultRequestPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , TaskResultRequest_Const in 'w:\common\components\rtl\Garant\EVD\TaskResultRequest_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TddTaskResultRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddTaskResultRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddGetTaskRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddGetTaskRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsExportResultRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsExportResultRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csExportResultRequest in 'w:\common\components\rtl\Garant\cs\csExportResultRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(InsiderTest)}
 , K517772970_TcsLineRequest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsLineRequest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csLineRequest in 'w:\common\components\rtl\Garant\cs\csLineRequest.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csLineRequestPrim in 'w:\common\components\rtl\Garant\cs\csLineRequestPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , LineRequest_Const in 'w:\common\components\rtl\Garant\EVD\LineRequest_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAutoClassTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAutoClassTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuAutoClassifier in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoClassifier.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csAutoClassTask in 'w:\common\components\rtl\Garant\cs\csAutoClassTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , AutoClassTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoClassTask_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuAutoClassTaskResult in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoClassTaskResult.pas'
 {$IfEnd} // Defined(ServerTasks)
 , AutoClassTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AutoClassTaskResult_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TcsExport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsExport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsImportTaskItem in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsImportTaskItem.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csImport in 'w:\common\components\rtl\Garant\cs\csImport.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csImportTaskPrim in 'w:\common\components\rtl\Garant\cs\csImportTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csTasksHelpers in 'w:\common\components\rtl\Garant\cs\csTasksHelpers.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , PlainFile_Const in 'w:\common\components\rtl\Garant\EVD\PlainFile_Const.pas'
 , File_Const in 'w:\common\components\rtl\Garant\EVD\File_Const.pas'
 , evNSRCConst in 'w:\common\components\rtl\Garant\dd\evNSRCConst.pas'
 , ddSegmentScanner in 'w:\common\components\rtl\Garant\dd\ddSegmentScanner.pas'
 , ddNSRCSegments in 'w:\common\components\rtl\Garant\dd\ddNSRCSegments.pas'
 , segTargetList in 'w:\common\components\rtl\Garant\dd\segTargetList.pas'
 , segTarget in 'w:\common\components\rtl\Garant\dd\segTarget.pas'
 , ddNSRCStackItemList in 'w:\common\components\rtl\Garant\dd\ddNSRCStackItemList.pas'
 , segObjectList in 'w:\common\components\rtl\Garant\dd\segObjectList.pas'
 , segHyperLinkList in 'w:\common\components\rtl\Garant\dd\segHyperLinkList.pas'
 , segSegList in 'w:\common\components\rtl\Garant\dd\segSegList.pas'
 , ImportTask_Const in 'w:\common\components\rtl\Garant\EVD\ImportTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuRegionAutoExportTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuRegionAutoExportTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuRegionAutoExportTask in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuRegionAutoExportTask.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuRegionAutoExportTaskPrim in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuRegionAutoExportTaskPrim.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuAutoExportTask in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoExportTask.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuAutoExportTaskPrim in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoExportTaskPrim.pas'
 {$IfEnd} // Defined(ServerTasks)
 , AutoExportTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoExportTask_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuAutoExportTaskResult in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoExportTaskResult.pas'
 {$IfEnd} // Defined(ServerTasks)
 , AutoExportTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AutoExportTaskResult_Const.pas'
 , RegionAutoExportTask_Const in 'w:\common\components\rtl\Garant\EVD\RegionAutoExportTask_Const.pas'
 , FTPBrowser_Const in 'w:\common\components\rtl\Garant\EVD\FTPBrowser_Const.pas'
 , alcuFTPBrowser in 'w:\archi\source\projects\PipeInAuto\Process\alcuFTPBrowser.pas'
 , alcuFTPBrowserParams in 'w:\archi\source\projects\PipeInAuto\Process\alcuFTPBrowserParams.pas'
 , IdAssignedNumbers in 'w:\common\components\rtl\external\Indy\Source\Core\IdAssignedNumbers.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAutoSpellTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAutoSpellTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuAutoSpell in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoSpell.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csAutoSpell in 'w:\common\components\rtl\Garant\cs\csAutoSpell.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csAutoSpellTaskPrim in 'w:\common\components\rtl\Garant\cs\csAutoSpellTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , AutoSpellTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoSpellTask_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuAutoSpellTaskResult in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoSpellTaskResult.pas'
 {$IfEnd} // Defined(ServerTasks)
 , AutoSpellTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AutoSpellTaskResult_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TddRunCommandTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddRunCommandTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csServerTaskTypes in 'w:\common\components\rtl\Garant\cs\csServerTaskTypes.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csDictEditQueryPrim in 'w:\common\components\rtl\Garant\cs\csDictEditQueryPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , DictEditQuery_Const in 'w:\common\components\rtl\Garant\EVD\DictEditQuery_Const.pas'
 {$If NOT Defined(Nemesis)}
 , csDeleteDocsQueryPrim in 'w:\common\components\rtl\Garant\cs\csDeleteDocsQueryPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , DeleteDocsQuery_Const in 'w:\common\components\rtl\Garant\EVD\DeleteDocsQuery_Const.pas'
 {$If NOT Defined(Nemesis)}
 , csUserEditQueryPrim in 'w:\common\components\rtl\Garant\cs\csUserEditQueryPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , UserEditQuery_Const in 'w:\common\components\rtl\Garant\EVD\UserEditQuery_Const.pas'
 {$If NOT Defined(Nemesis)}
 , ddRunCommandTaskPrim in 'w:\common\components\rtl\Garant\cs\ddRunCommandTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , RunCommandTask_Const in 'w:\common\components\rtl\Garant\EVD\RunCommandTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAnnotationTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAnnotationTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuAnnotationTask in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAnnotationTask.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , csAnnotationTask in 'w:\common\components\rtl\Garant\cs\csAnnotationTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , AnnotationTask_Const in 'w:\common\components\rtl\Garant\EVD\AnnotationTask_Const.pas'
 {$If Defined(ServerTasks)}
 , alcuAnnotationTaskResult in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAnnotationTaskResult.pas'
 {$IfEnd} // Defined(ServerTasks)
 , AnnotationTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\AnnotationTaskResult_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TUserEditQuery in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TUserEditQuery.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAutoExportTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAutoExportTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TDeleteDocsQuery in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TDeleteDocsQuery.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TDictEditQuery in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TDictEditQuery.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsAutoAnnoExport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsAutoAnnoExport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csAutoAnnoExport in 'w:\common\components\rtl\Garant\cs\csAutoAnnoExport.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csAutoAnnoExportPrim in 'w:\common\components\rtl\Garant\cs\csAutoAnnoExportPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , AutoAnnoExportTask_Const in 'w:\common\components\rtl\Garant\EVD\AutoAnnoExportTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TddCaseCodeTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddCaseCodeTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , ddCaseCodeMaker in 'w:\archi\source\projects\PipeInAuto\Tasks\ddCaseCodeMaker.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If NOT Defined(Nemesis)}
 , ddCaseCodeTaskPrim in 'w:\common\components\rtl\Garant\cs\ddCaseCodeTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , CaseCodeTask_Const in 'w:\common\components\rtl\Garant\EVD\CaseCodeTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuExport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuExport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuExport in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuExport.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAnoncedExport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuAnoncedExport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuAnoncedExport in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAnoncedExport.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuAnoncedExportPrim in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuAnoncedExportPrim.pas'
 {$IfEnd} // Defined(ServerTasks)
 , AnoncedExportTask_Const in 'w:\common\components\rtl\Garant\EVD\AnoncedExportTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuHavanskyExportTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuHavanskyExportTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuHavanskyExportTask in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuHavanskyExportTask.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks) AND Defined(HavanskyExport)}
 , alcuHavanskyExportTaskPrim in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuHavanskyExportTaskPrim.pas'
 {$IfEnd} // Defined(ServerTasks) AND Defined(HavanskyExport)
 , HavanskyExportTask_Const in 'w:\common\components\rtl\Garant\EVD\HavanskyExportTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TGetDictEditQuery in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TGetDictEditQuery.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuImport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuImport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuImport in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuImport.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuImportTaskResult in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuImportTaskResult.pas'
 {$IfEnd} // Defined(ServerTasks)
 , ImportTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\ImportTaskResult_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TalcuRelPublishTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TalcuRelPublishTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(ServerTasks)}
 , alcuRelCorrector in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuRelCorrector.pas'
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(ServerTasks)}
 , alcuRelPublishTaskResult in 'w:\archi\source\projects\PipeInAuto\Tasks\alcuRelPublishTaskResult.pas'
 {$IfEnd} // Defined(ServerTasks)
 , RelPublishTaskResult_Const in 'w:\common\components\rtl\Garant\EVD\RelPublishTaskResult_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TcsAACImport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsAACImport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csAACImport in 'w:\common\components\rtl\Garant\cs\csAACImport.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , AACImport_Const in 'w:\common\components\rtl\Garant\EVD\AACImport_Const.pas'
 , CourtDecisionSabCheckerParams_Const in 'w:\common\components\rtl\Garant\EVD\CourtDecisionSabCheckerParams_Const.pas'
 , CourtDescription_Const in 'w:\common\components\rtl\Garant\EVD\CourtDescription_Const.pas'
 , CourtDecisionPhrase_Const in 'w:\common\components\rtl\Garant\EVD\CourtDecisionPhrase_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TcsSpellCorrectTask in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsSpellCorrectTask.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csSpellCorrectTask in 'w:\common\components\rtl\Garant\cs\csSpellCorrectTask.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csSpellCorrectTaskPrim in 'w:\common\components\rtl\Garant\cs\csSpellCorrectTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , SpellCorrectTask_Const in 'w:\common\components\rtl\Garant\EVD\SpellCorrectTask_Const.pas'
 {$If Defined(InsiderTest)}
 , K517772970_TcsUserDefinedExport in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsUserDefinedExport.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csUserDefinedExport in 'w:\common\components\rtl\Garant\cs\csUserDefinedExport.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csUserDefinedExportTaskPrim in 'w:\common\components\rtl\Garant\cs\csUserDefinedExportTaskPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , UserDefinedExportTask_Const in 'w:\common\components\rtl\Garant\EVD\UserDefinedExportTask_Const.pas'
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_AbstractImportTasks_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Import\Abstract\Low_Level_Tests_AbstractImportTasks_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_AbstractTasksSaveLoadWithDefault_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\Abstract\Low_Level_Tests_AbstractTasksSaveLoadWithDefault_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_ConcreteImportTasks_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Import\Low_Level_Tests_ConcreteImportTasks_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517789752 in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Import\K517789752.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , alcuImportTest in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\Import\Abstract\alcuImportTest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , csLoopBack in 'w:\common\components\rtl\Garant\cs\csLoopBack.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsQueryTypes in 'w:\common\components\rtl\Garant\cs\CsQueryTypes.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsQueryRequester in 'w:\common\components\rtl\Garant\cs\CsQueryRequester.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsQueryRequesterTool in 'w:\common\components\rtl\Garant\cs\CsQueryRequesterTool.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsConst in 'w:\common\components\rtl\Garant\cs\CsConst.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsReplyProceduresPrim in 'w:\common\components\rtl\Garant\cs\CsReplyProceduresPrim.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsProcWithIdList in 'w:\common\components\rtl\Garant\cs\CsProcWithIdList.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsProcWithId in 'w:\common\components\rtl\Garant\cs\CsProcWithId.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsReplyTool in 'w:\common\components\rtl\Garant\cs\CsReplyTool.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsErrors in 'w:\common\components\rtl\Garant\cs\CsErrors.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_TasksSaveLoadWithDefault_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\Low_Level_Tests_TasksSaveLoadWithDefault_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddTaskItemDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddTaskItemDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TCheckSaveToStreamDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\Abstract\K517772970_TCheckSaveToStreamDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAnnotationTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAnnotationTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAnoncedExportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAnoncedExportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAutoClassTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAutoClassTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuExportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuExportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuHavanskyExportTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuHavanskyExportTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuImportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuImportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuRelPublishTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuRelPublishTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TaskRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TaskRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsAACImportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsAACImportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsAutoAnnoExportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsAutoAnnoExportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAutoSpellTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAutoSpellTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsExportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsExportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsExportResultRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsExportResultRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsImportTaskItemDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsImportTaskItemDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsLineRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsLineRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuAutoExportTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAutoExportTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddBaseStatusRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddBaseStatusRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddCaseCodeTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddCaseCodeTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddClientMessageDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddClientMessageDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddCommonDataRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddCommonDataRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddGetTaskRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddGetTaskRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddProcessTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddProcessTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TalcuRegionAutoExportTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuRegionAutoExportTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddRequestTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddRequestTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddRunCommandTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddRunCommandTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddServerStatusRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddServerStatusRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TddTaskResultRequestDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddTaskResultRequestDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TDeleteDocsQueryDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TDeleteDocsQueryDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TDictEditQueryDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TDictEditQueryDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TGetDictEditQueryDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TGetDictEditQueryDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TUserEditQueryDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TUserEditQueryDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsSpellCorrectTaskDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsSpellCorrectTaskDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , K517772970_TcsUserDefinedExportDefault in 'w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsUserDefinedExportDefault.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , Low_Level_Tests_TasksRegistering_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\Low_Level_Tests_TasksRegistering_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , RegisteredRepliesTest in 'w:\archi\source\projects\PipeInAuto\Tests\RegisteredRepliesTest.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(Nemesis)}
 , CsReplyProcedures in 'w:\common\components\rtl\Garant\cs\CsReplyProcedures.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsReplyProceduresWithRegistering in 'w:\common\components\rtl\Garant\cs\CsReplyProceduresWithRegistering.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(InsiderTest)}
 , New_Actions_Test_TestLibrary in 'w:\archi\source\projects\PipeInAuto\Tests\New_Actions_Test_TestLibrary.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , New_Actions_Test_Tasked_Actions_TestUnit in 'w:\archi\source\projects\PipeInAuto\Tests\NewActions\Export\New_Actions_Test_Tasked_Actions_TestUnit.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(InsiderTest)}
 , archiExportActionTest in 'w:\archi\source\projects\PipeInAuto\Tests\NewActions\Export\archiExportActionTest.pas'
 {$IfEnd} // Defined(InsiderTest)
 //#UC START# *52F24F6103ABmanualuses*
  ,
  alcuCloseQueryDlg in 'alcuCloseQueryDlg.pas' {alcuCloseQueryDlgForm},
{$IFDEF MDPSyncIntegrated}
  alcuMDP in 'Process\alcuMDP.pas',
  GarDocsUnit in 'W:\MDProcess\ArchiAdapterLib\GarDocsUnit.pas',
  ArchiAdapter in 'W:\MDProcess\ArchiAdapter\ArchiAdapter.pas',
{$ENDIF MDPSyncIntegrated}
{$IFDEF AAC}
  alcuAACImportTaskResult in 'Tasks\alcuAACImportTaskResult.pas',
  alcuAACImport in 'Tasks\alcuAACImport.pas',
{$ENDIF AAC}
  alcuAutoAnnoExportTaskPrim in 'Tasks\alcuAutoAnnoExportTaskPrim.pas',
  alcuAutoAnnoExportTask in 'Tasks\alcuAutoAnnoExportTask.pas',
  alcuCourtDecisionSubChecker in 'Process\alcuCourtDecisionSubChecker.pas',
  alcuFTPUtils in 'Server\alcuFTPUtils.pas',
  alcuUtils in 'Server\alcuUtils.pas',
  alcuConfig in 'Server\alcuConfig.pas',
  alcuAutoLinkUpdater in 'Process\alcuAutoLinkUpdater.pas',
  alcuCourtDecision in 'Process\alcuCourtDecision.pas',
  alcuSpellChecker in 'Process\alcuSpellChecker.pas',
  alcuAutoExport in 'Process\alcuAutoExport.pas',
  alcuZipUtils in 'Process\alcuZipUtils.pas',
  alcuPrime in 'Process\alcuPrime.pas',
  alcuRegionImportTaskResult in 'Tasks\alcuRegionImportTaskResult.pas',
  alcuRegionImportTaskPrim in 'Tasks\alcuRegionImportTaskPrim.pas',
  alcuRegionImportTask in 'Tasks\alcuRegionImportTask.pas',
  alcuSpellCorrectTask in 'Tasks\alcuSpellCorrectTask.pas'
 //#UC END# *52F24F6103ABmanualuses*
;
{$IfEnd} // Defined(AppServerSide)

{$If Defined(AppServerSide)}
{$IfEnd} // Defined(AppServerSide)
{$R AutoPipeServerTest.res}

//#UC START# *52F24F6103ABmanualres*
{$R versioninfo.res} // включаем Version Info

{$IFDEF Service}
Для сборки приложения нужно выключить директиву Service в ProjectDefine.inc
{$ENDIF}

//#UC END# *52F24F6103ABmanualres*

begin
 {$IfDef nsTest}
 g_CVSPath := 'w:\archi\source\projects\PipeInAuto';
 {$EndIf nsTest}
 //#UC START# *52F24F6103ABCVSPath*
 //#UC END# *52F24F6103ABCVSPath*
 //#UC START# *52F24F6103ABmanualcode*
  Application.Initialize;
  {$IFDEF Region}
  Application.Title := 'Сервер автоматизации. "Архивариус" (рег)';
  {$ELSE}
  Application.Title := 'Сервер автоматизации. "Архивариус"';
  {$ENDIF}
  Application.HelpFile := '';
  Application.CreateForm(TArchiServerForm, ArchiServerForm);
  TArchiAutoTestSuite.Register;
  TAutoPipeServerTestsRunner.ReadyToRun;
  Application.Run;
 //#UC END# *52F24F6103ABmanualcode*
end.
