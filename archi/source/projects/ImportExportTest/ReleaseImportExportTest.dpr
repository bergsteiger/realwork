program ReleaseImportExportTest;
 {*  (релизный вариант) }

// Модуль: "w:\archi\source\projects\ImportExportTest\ReleaseImportExportTest.dpr"
// Стереотип: "TestTarget"
// Элемент модели: "ReleaseImportExport" MUID: (36C7C32193CF)

{$Include w:\archi\source\projects\ImportExportTest.inc}

uses
 l3IntfUses
 , l3ImplUses
 , l3ExceptionsLog in 'w:\common\components\rtl\Garant\L3\l3ExceptionsLog.pas'
 {$If NOT Defined(NoScripts)}
 , ObjectFromstackWords in 'w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas'
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
 , l3ProtoDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas'
 , l3ProtoObject in 'w:\common\components\rtl\Garant\L3\l3ProtoObject.pas'
 , l3CastableObject in 'w:\common\components\rtl\Garant\L3\l3CastableObject.pas'
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
 , ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
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
 , l3Types in 'w:\common\components\rtl\Garant\L3\l3Types.pas'
 , l3PureMixIns in 'w:\common\components\rtl\Garant\L3\l3PureMixIns.pas'
 , l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas'
 , tfwParserInterfaces in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas'
 , l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas'
 , l3ProtoPersistent in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas'
 , l3CastablePersistent in 'w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas'
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
 , TypInfo in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas'
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
 {$If NOT Defined(NoScripts)}
 , tfwScriptingTypes in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingTypes.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingExceptions in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeInfo in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfo.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TypeInfoPack in 'w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwGlobalKeyWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwGlobalKeyWord.pas'
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
 , tfwTypeRegistrator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeRegistrator.pas'
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
 , tfwTypeModifier in 'w:\common\components\rtl\Garant\ScriptEngine\tfwTypeModifier.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwModifier in 'w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwClassRef in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClassRef.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , StrUtils in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\StrUtils.pas'
 {$If NOT Defined(NoScripts)}
 , tfwRTTIProperty in 'w:\common\components\rtl\Garant\ScriptEngine\tfwRTTIProperty.pas'
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
 , kwConstLikeCompiled in 'w:\common\components\rtl\Garant\ScriptEngine\kwConstLikeCompiled.pas'
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
 , tfwPropertyLike in 'w:\common\components\rtl\Garant\ScriptEngine\tfwPropertyLike.pas'
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
 , l3Math in 'w:\common\components\rtl\Garant\L3\l3Math.pas'
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
 , l3MessageID in 'w:\common\components\rtl\Garant\L3\l3MessageID.pas'
 {$If NOT Defined(NoVCL)}
 , Dialogs in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 , Pl3StringIDExList in 'w:\common\components\rtl\Garant\L3\Pl3StringIDExList.pas'
 , Pl3MessageIDList in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDList.pas'
 , Pl3MessageIDListPrim in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDListPrim.pas'
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
 , WinControlsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\WinControlsProcessingPack.pas'
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy in 'w:\common\components\rtl\Garant\ScriptEngine\TtfwClassRef_Proxy.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 , ControlResizeBugFix
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
 , afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas'
 , afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas'
 {$If NOT Defined(NoVCL)}
 , ImgList in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas'
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
 , l3ProtoIntegerList in 'w:\common\components\rtl\Garant\L3\l3ProtoIntegerList.pas'
 , l3FrameLinesSpy in 'w:\common\components\rtl\Garant\L3\l3FrameLinesSpy.pas'
 {$If NOT Defined(NoVCL)}
 , StdCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RadioButtonWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 , ExtCtrls in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas'
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PanelProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RadioGroupWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 , l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas'
 , evdTypes in 'w:\common\components\rtl\Garant\EVD\evdTypes.pas'
 , evdStyles in 'w:\common\components\rtl\Garant\EVD\evdStyles.pas'
 , evConst in 'w:\common\components\gui\Garant\Everest\evConst.pas'
 , l3Tree_TLB in 'w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas'
 , evdInterfaces in 'w:\common\components\rtl\Garant\EVD\evdInterfaces.pas'
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
 , evdNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeWriter.pas'
 , evdCustomNativeWriter in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriter.pas'
 , evdCustomNativeWriterServices in 'w:\common\components\rtl\Garant\EVD\evdCustomNativeWriterServices.pas'
 , Bullet_Const in 'w:\common\components\rtl\Garant\EVD\Bullet_Const.pas'
 , SegmentsLayer_Const in 'w:\common\components\rtl\Garant\EVD\SegmentsLayer_Const.pas'
 , TextSegment_Const in 'w:\common\components\rtl\Garant\EVD\TextSegment_Const.pas'
 , Segment_Const in 'w:\common\components\rtl\Garant\EVD\Segment_Const.pas'
 , Position_Const in 'w:\common\components\rtl\Garant\EVD\Position_Const.pas'
 , TabStop_Const in 'w:\common\components\rtl\Garant\EVD\TabStop_Const.pas'
 {$If NOT Defined(NoScripts)}
 , evSchemaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwRegisterSchema in 'w:\common\components\rtl\Garant\ScriptEngine\kwRegisterSchema.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStyleTableSaveToFile in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableSaveToFile.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStyleTableChanging in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanging.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwStyleTableChanged in 'w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableChanged.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEvdBin2EvdTxt in 'w:\common\components\rtl\Garant\ScriptEngine\kwEvdBin2EvdTxt.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwSysUtilsWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwSysUtilsWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evEvdRd in 'w:\common\components\gui\Garant\Everest\evEvdRd.pas'
 {$If NOT Defined(NoScripts)}
 , kwCFHTML in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFHTML.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwClipboardFormatWord in 'w:\common\components\rtl\Garant\ScriptEngine\tfwClipboardFormatWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCFXML in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFXML.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCFEVEREST in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFEVEREST.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCFRTF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFRTF.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCFEVERESTBIN in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFEVERESTBIN.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCFPDF in 'w:\common\components\rtl\Garant\ScriptEngine\kwCFPDF.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , evParaWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\evParaWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas'
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
 {$If NOT Defined(NoScripts)}
 , kwPopEditorWheelScroll in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectColumn.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , kwPopEditorSelectCellsVertical in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorJumpToHyperlink in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorJumpToHyperlink.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nevNavigation in 'w:\common\components\gui\Garant\Everest\new\nevNavigation.pas'
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
 {$If NOT Defined(NoScripts)}
 , IedTableWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , Formula_Const in 'w:\common\components\gui\Garant\Everest\Formula_Const.pas'
 , DecorTextPara_Const in 'w:\common\components\gui\Garant\Everest\DecorTextPara_Const.pas'
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
 {$If NOT Defined(NoImageEn)}
 , imageenio in 'w:\common\components\rtl\external\ImageEn\src\imageenio.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
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
 , nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas'
 , nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas'
 , nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas'
 , nevShapePrimRefList in 'w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas'
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
 {$If Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(InsiderTest)}
 , evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest)
 {$If Defined(nsTest)}
 , afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
 {$IfEnd} // Defined(nsTest)
 , afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas'
 , l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas'
 , Consts in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas'
 , l3MetafileHeader in 'w:\common\components\rtl\Garant\L3\l3MetafileHeader.pas'
 , afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas'
 , l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas'
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
 , LeafParaDecorationsHolder_Const in 'w:\common\components\gui\Garant\Everest\LeafParaDecorationsHolder_Const.pas'
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
 {$If NOT Defined(NoScripts)}
 , l3ScriptService in 'w:\common\components\rtl\Garant\ScriptEngine\l3ScriptService.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , vtHintWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , vtTreeSource in 'w:\common\components\gui\Garant\VT\vtTreeSource.pas'
 , l3Tree in 'w:\common\components\rtl\Garant\L3\l3Tree.pas'
 , l3ItemsStorage in 'w:\common\components\rtl\Garant\L3\l3ItemsStorage.pas'
 , l3TreeUtils in 'w:\common\components\rtl\Garant\L3\l3TreeUtils.pas'
 {$If NOT Defined(NoScripts)}
 , vtOutlinerWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtOutlinerWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , l3SimpleTree in 'w:\common\components\rtl\Garant\L3\l3SimpleTree.pas'
 , ctFakeBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ctFakeBoxStrings.pas'
 , ComboBoxStrings in 'w:\common\components\gui\Garant\VT\ComboTree\ComboBoxStrings.pas'
 , ctComboBoxStringsItemNode in 'w:\common\components\gui\Garant\VT\ComboTree\ctComboBoxStringsItemNode.pas'
 {$If NOT Defined(NoScripts)}
 , vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , vcmInsiderTest in 'w:\common\components\rtl\Garant\DUnitTuning\vcmInsiderTest.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
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
 , tfwStoredValuesStack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas'
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
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , AutoTestsSuite in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestsSuite.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , AutoTestSuiteWithDUnitSupport in 'w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestSuiteWithDUnitSupport.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , CustomAutoTestsSuite in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , DailyAutoTest in 'w:\common\components\rtl\Garant\DUnit_Script_Support\DailyAutoTest.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , AutoTest in 'w:\common\components\rtl\Garant\ScriptTestLibrary\AutoTest.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , CustomInsiderScripter in 'w:\common\components\rtl\Garant\ScriptTestLibrary\CustomInsiderScripter.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
 , l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
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
 {$If Defined(nsTest)}
 , ImportExportTestLibrary_TestLibrary in 'w:\archi\source\projects\ImportExportTest\ImportExportTestLibrary_TestLibrary.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , K455105826 in 'w:\archi\source\projects\ImportExportTest\K455105826.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ietBaseTest in 'w:\archi\source\projects\ImportExportTest\ietBaseTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , archiDBTest in 'w:\archi\source\projects\ImportExportTest\ArchiDBTests\archiDBTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If NOT Defined(Nemesis)}
 , dt_Sab in 'w:\common\components\rtl\Garant\DT\dt_Sab.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dtIntf in 'w:\common\components\rtl\Garant\DT\dtIntf.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 , ZipForge in 'w:\common\components\rtl\external\ZipForge\Source\ZipForge.pas'
 , ddHTinit in 'w:\common\components\rtl\Garant\dd\ddHTinit.pas'
 , dt_Const in 'w:\common\components\rtl\Garant\dd\dt_Const.pas'
 , dt_Types in 'w:\common\components\rtl\Garant\dd\dt_Types.pas'
 , evdDTTypes in 'w:\common\components\rtl\Garant\EVD\evdDTTypes.pas'
 , l3IniFile in 'w:\common\components\rtl\Garant\L3\l3IniFile.pas'
 {$If Defined(AppClientSide) AND NOT Defined(Nemesis)}
 , ddClientBaseEngine in 'w:\common\components\rtl\Garant\cs\ddClientBaseEngine.pas'
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(Nemesis)
 , m3StorageHolderList in 'w:\common\components\rtl\Garant\m3\m3StorageHolderList.pas'
 , m3StorageHolderListPrim1 in 'w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim1.pas'
 , m3StorageHolderListPrim in 'w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim.pas'
 , m3StorageHolder in 'w:\common\components\rtl\Garant\m3\m3StorageHolder.pas'
 , m3StorageInterfaces in 'w:\common\components\rtl\Garant\m3\m3StorageInterfaces.pas'
 , m3CommonStorage in 'w:\common\components\rtl\Garant\m3\m3CommonStorage.pas'
 , m3StoragePrim in 'w:\common\components\rtl\Garant\m3\m3StoragePrim.pas'
 , m3BaseStorage in 'w:\common\components\rtl\Garant\m3\m3BaseStorage.pas'
 , m3BaseStore in 'w:\common\components\rtl\Garant\m3\m3BaseStore.pas'
 , m2InternalInterfaces in 'w:\common\components\rtl\Garant\L3\m2\m2InternalInterfaces.pas'
 , m2COMLib in 'w:\common\components\rtl\Garant\L3\m2\m2COMLib.pas'
 , ComObj in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas'
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
 , ddImportPipe in 'w:\common\components\rtl\Garant\dd\PipeIn\ddImportPipe.pas'
 , ExportPipe in 'w:\common\components\rtl\Garant\dd\PipeOut\ExportPipe.pas'
 , dt_AttrSchema in 'w:\common\components\rtl\Garant\dd\dt_AttrSchema.pas'
 {$If Defined(Archi) AND NOT Defined(Nemesis)}
 , dt_LinkServ in 'w:\common\components\rtl\Garant\DT\dt_LinkServ.pas'
 {$IfEnd} // Defined(Archi) AND NOT Defined(Nemesis)
 , ddPipeOutInterfaces in 'w:\common\components\rtl\Garant\dd\ddPipeOutInterfaces.pas'
 {$If NOT Defined(Nemesis)}
 , dt_Renum in 'w:\common\components\rtl\Garant\DT\dt_Renum.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Jour in 'w:\common\components\rtl\Garant\DT\dt_Jour.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_IFltr in 'w:\common\components\rtl\Garant\DT\dt_IFltr.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Lock in 'w:\common\components\rtl\Garant\DT\dt_Lock.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Doc in 'w:\common\components\rtl\Garant\DT\dt_Doc.pas'
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , K465700807 in 'w:\archi\source\projects\ImportExportTest\K465700807.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , SimpleTests_TestLibrary in 'w:\archi\source\projects\ImportExportTest\SimpleTests_TestLibrary.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ExportToSeparateNSRTest in 'w:\archi\source\projects\ImportExportTest\ExportToSeparateNSRTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ExportPipeTestPrim in 'w:\archi\source\projects\ImportExportTest\ExportPipeTestPrim.pas'
 {$IfEnd} // Defined(nsTest)
 , ddFileIterator in 'w:\common\components\rtl\Garant\dd\ddFileIterator.pas'
 {$If Defined(nsTest)}
 , ExportToSingleNSRTest in 'w:\archi\source\projects\ImportExportTest\ExportToSingleNSRTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ExportSeparatedByMainTest in 'w:\archi\source\projects\ImportExportTest\ExportSeparatedByMainTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ExportSeparatedBySizeTest in 'w:\archi\source\projects\ImportExportTest\ExportSeparatedBySizeTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ExportByMainRelNamedTest in 'w:\archi\source\projects\ImportExportTest\ExportByMainRelNamedTest.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , ExportBySizeAndMain in 'w:\archi\source\projects\ImportExportTest\ExportBySizeAndMain.pas'
 {$IfEnd} // Defined(nsTest)
;

{$R ReleaseImportExportTest.res}

begin
 {$IfDef nsTest}
 g_CVSPath := 'w:\archi\source\projects\ImportExportTest';
 {$EndIf nsTest}
 //#UC START# *36C7C32193CFCVSPath*
 //#UC END# *36C7C32193CFCVSPath*
 TAutoTestsSuite.Register;
 try
  if KTestRunner.NeedKTestRunner([]) then
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
