program Nemesis;
 {* ГАРАНТ. Оболочка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Nemesis.dpr"
// Стереотип: "VCMGUI"
// Элемент модели: "Nemesis" MUID: (4F7EBBE70147)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ImplUses
 {$If Defined(Nemesis)}
 , nsApplication
 {$IfEnd} // Defined(Nemesis)
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
 , l3StringList in 'w:\common\components\rtl\Garant\L3\l3StringList.pas'
 , l3StringList2 in 'w:\common\components\rtl\Garant\L3\l3StringList2.pas'
 , l3StringList1 in 'w:\common\components\rtl\Garant\L3\l3StringList1.pas'
 , l3StringListPrim in 'w:\common\components\rtl\Garant\L3\l3StringListPrim.pas'
 , l3ProtoPersistentDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas'
 , l3DataObjectEnum in 'w:\common\components\rtl\Garant\L3\l3DataObjectEnum.pas'
 , ShlObj {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ShlObj.pas' {$EndIf}
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
 , NemesisRes in 'w:\garant6x\implementation\Garant\GbaNemesis\NemesisRes.pas'
 , PrimNemesisRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimNemesisRes.pas'
 , ShellAndMonitoringsRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsRes.pas'
 , PrimF1Res in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimF1Res.pas'
 , F1LikeRes in 'w:\common\components\gui\Garant\VCM\View\F1LikeRes.pas'
 {$If NOT Defined(NoVCM)}
 , OfficeLikeRes in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmApplication in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmApplication.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces in 'w:\common\components\gui\Garant\VCM\vcmExternalInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces in 'w:\common\components\gui\Garant\AFW\afwInterfaces.pas'
 , afwTypes in 'w:\common\components\gui\Garant\AFW\afwTypes.pas'
 {$If NOT Defined(NoVCL)}
 , ImgList {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ImgList.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces in 'w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas'
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationState in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationState.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule in 'w:\common\components\gui\Garant\VCM\implementation\vcmModule.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase in 'w:\common\components\gui\Garant\VCM\implementation\vcmBase.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmStringIDExHelper in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringIDExHelper.pas'
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
 , l3VCLStrings in 'w:\common\components\rtl\Garant\L3\l3VCLStrings.pas'
 , l3VCLStringsItems in 'w:\common\components\rtl\Garant\L3\l3VCLStringsItems.pas'
 , l3CastableStrings in 'w:\common\components\rtl\Garant\L3\l3CastableStrings.pas'
 , afwSettingsChangePublisher in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisher.pas'
 , afwSettingsChangePublisherPrim in 'w:\common\components\gui\Garant\AFW\afwSettingsChangePublisherPrim.pas'
 , IafwSettingListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingListenerPtrList.pas'
 , IafwSettingsReplaceListenerPtrList in 'w:\common\components\gui\Garant\AFW\IafwSettingsReplaceListenerPtrList.pas'
 , l3CClassList in 'w:\common\components\rtl\Garant\L3\l3CClassList.pas'
 , l3ClassList in 'w:\common\components\rtl\Garant\L3\l3ClassList.pas'
 {$If NOT Defined(NoVCM)}
 , vcmMakeParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmMakeParams.pas'
 {$IfEnd} // NOT Defined(NoVCM)
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
 , OvcCmd in 'w:\common\components\rtl\external\Orpheus\OvcCmd.pas'
 , OvcController in 'w:\common\components\rtl\external\Orpheus\OvcController.pas'
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
 , l3ProtoObjectRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectRefList.pas'
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , tfwModuleOperationWordEx in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWordEx.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , tfwModuleOperationWord in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWord.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
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
 {$If NOT Defined(NoVCL)}
 , Dialogs {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID in 'w:\common\components\rtl\Garant\L3\l3MessageID.pas'
 , Pl3StringIDExList in 'w:\common\components\rtl\Garant\L3\Pl3StringIDExList.pas'
 , Pl3MessageIDList in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDList.pas'
 , Pl3MessageIDListPrim in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDListPrim.pas'
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
 , vcmDialogs in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDialogs.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)
 , evCustomEditorWindow in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindow.pas'
 , evCustomEditorWindowPrim in 'w:\common\components\gui\Garant\Everest\evCustomEditorWindowPrim.pas'
 , nevControl in 'w:\common\components\gui\Garant\Everest\nevControl.pas'
 , afwControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControl.pas'
 , afwBaseControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwBaseControl.pas'
 , afwControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwControlPrim.pas'
 , OvcBase in 'w:\common\components\rtl\external\Orpheus\OvcBase.pas'
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
 , StdCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\StdCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RadioButtonWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtComboBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtComboBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 , nevTools in 'w:\common\components\gui\Garant\Everest\new\nevTools.pas'
 , k2Interfaces in 'w:\common\components\rtl\Garant\K2\k2Interfaces.pas'
 , k2PureMixIns in 'w:\common\components\rtl\Garant\K2\k2PureMixIns.pas'
 , k2Prim in 'w:\common\components\rtl\Garant\K2\k2Prim.pas'
 , k2PropertyArray in 'w:\common\components\rtl\Garant\K2\k2PropertyArray.pas'
 , k2TypeTableCreatedListeners in 'w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas'
 , k2Attributes in 'w:\common\components\rtl\Garant\K2\k2Attributes.pas'
 , k2Tags in 'w:\common\components\rtl\Garant\K2\k2Tags.pas'
 , k2Empty_Const in 'w:\common\components\rtl\Garant\K2\k2Empty_Const.pas'
 , k2BaseHack in 'w:\common\components\rtl\Garant\K2\k2BaseHack.pas'
 , nevBase in 'w:\common\components\gui\Garant\Everest\new\nevBase.pas'
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
 , nevGUIInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas'
 , evMultiSelection in 'w:\common\components\gui\Garant\Everest\evMultiSelection.pas'
 , nevSelection in 'w:\common\components\gui\Garant\Everest\nevSelection.pas'
 , evBlockCursor in 'w:\common\components\gui\Garant\Everest\evBlockCursor.pas'
 , evWindowCursor in 'w:\common\components\gui\Garant\Everest\evWindowCursor.pas'
 , evCursorController in 'w:\common\components\gui\Garant\Everest\evCursorController.pas'
 , evMsgCode in 'w:\common\components\gui\Garant\Everest\evMsgCode.pas'
 , evOp in 'w:\common\components\gui\Garant\Everest\evOp.pas'
 , k2TagGen in 'w:\common\components\rtl\Garant\K2\k2TagGen.pas'
 , k2VariantImpl in 'w:\common\components\rtl\Garant\K2\k2VariantImpl.pas'
 , k2Long_Const in 'w:\common\components\rtl\Garant\K2\k2Long_Const.pas'
 {$If NOT Defined(NoScripts)}
 , kwFiltersAndGeneratorsPack in 'w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , k2EVDReaderService in 'w:\common\components\rtl\Garant\K2\k2EVDReaderService.pas'
 , k2CustomFileReader in 'w:\common\components\rtl\Garant\K2\k2CustomFileReader.pas'
 , k2CustomReader in 'w:\common\components\rtl\Garant\K2\k2CustomReader.pas'
 , k2CustomStackGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomStackGenerator.pas'
 , k2BaseStackGenerator in 'w:\common\components\rtl\Garant\K2\k2BaseStackGenerator.pas'
 , k2EVDWriterService in 'w:\common\components\rtl\Garant\K2\k2EVDWriterService.pas'
 , k2CustomFileGenerator in 'w:\common\components\rtl\Garant\K2\k2CustomFileGenerator.pas'
 , k2CustomStackGeneratorEx in 'w:\common\components\rtl\Garant\K2\k2CustomStackGeneratorEx.pas'
 , evDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest\evDocumentPartGenerator.pas'
 , evDocumentPartGeneratorPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPartGeneratorPrim.pas'
 , evHighLevelDocumentGenerator in 'w:\common\components\gui\Garant\Everest\evHighLevelDocumentGenerator.pas'
 , k2DocumentGenerator in 'w:\common\components\rtl\Garant\K2\k2DocumentGenerator.pas'
 , evGeneratorsInterfaces in 'w:\common\components\gui\Garant\Everest\evGeneratorsInterfaces.pas'
 , nevNavigation in 'w:\common\components\gui\Garant\Everest\new\nevNavigation.pas'
 , LeafPara_Const in 'w:\common\components\rtl\Garant\EVD\LeafPara_Const.pas'
 , Para_Const in 'w:\common\components\rtl\Garant\EVD\Para_Const.pas'
 , k2Tag_Const in 'w:\common\components\rtl\Garant\K2\k2Tag_Const.pas'
 , k2Bool_Const in 'w:\common\components\rtl\Garant\K2\k2Bool_Const.pas'
 , k2Enum_Const in 'w:\common\components\rtl\Garant\K2\k2Enum_Const.pas'
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
 , evEditorInterfaces in 'w:\common\components\gui\Garant\Everest\evEditorInterfaces.pas'
 , evEditorInterfacesTypes in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesTypes.pas'
 {$If Defined(k2ForEditor)}
 , evCursorTools in 'w:\common\components\gui\Garant\Everest\evCursorTools.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , k2OpMisc in 'w:\common\components\rtl\Garant\K2\k2OpMisc.pas'
 , nevFacade in 'w:\common\components\gui\Garant\Everest\new\nevFacade.pas'
 {$If NOT Defined(NoScripts)}
 , IedTableWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , TableCell_Const in 'w:\common\components\gui\Garant\Everest\TableCell_Const.pas'
 , ParaList_Const in 'w:\common\components\gui\Garant\Everest\ParaList_Const.pas'
 , TextPara_Const in 'w:\common\components\gui\Garant\Everest\TextPara_Const.pas'
 , StyledLeafPara_Const in 'w:\common\components\gui\Garant\Everest\StyledLeafPara_Const.pas'
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
 , evFontInterface in 'w:\common\components\gui\Garant\Everest\evFontInterface.pas'
 , l3Nodes in 'w:\common\components\rtl\Garant\L3\l3Nodes.pas'
 , k2SimpleTagList in 'w:\common\components\rtl\Garant\K2\k2SimpleTagList.pas'
 , k2TagList in 'w:\common\components\rtl\Garant\K2\k2TagList.pas'
 , k2TagListPrim in 'w:\common\components\rtl\Garant\K2\k2TagListPrim.pas'
 , k2ListTag in 'w:\common\components\rtl\Garant\K2\k2ListTag.pas'
 , k2NonAtomicTag in 'w:\common\components\rtl\Garant\K2\k2NonAtomicTag.pas'
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
 , afwCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaret.pas'
 , afwCaretPair in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaretPair.pas'
 , afwSingleCaret in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwSingleCaret.pas'
 , afwCustomCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCaretType.pas'
 , afwInsCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwInsCaretType.pas'
 , afwOvrCaretType in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwOvrCaretType.pas'
 , nevBasePointList in 'w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas'
 , evRange in 'w:\common\components\gui\Garant\Everest\evRange.pas'
 , k2ProcTagTool in 'w:\common\components\rtl\Garant\K2\k2ProcTagTool.pas'
 , Table_Const in 'w:\common\components\gui\Garant\Everest\Table_Const.pas'
 , TableRow_Const in 'w:\common\components\gui\Garant\Everest\TableRow_Const.pas'
 , evEditorInterfacesMisc in 'w:\common\components\gui\Garant\Everest\evEditorInterfacesMisc.pas'
 , evBitmapReader in 'w:\common\components\gui\Garant\Everest\evBitmapReader.pas'
 {$If Defined(k2ForEditor)}
 , evUsialParagraph in 'w:\common\components\gui\Garant\Everest\evUsialParagraph.pas'
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evParaFrame in 'w:\common\components\gui\Garant\Everest\evParaFrame.pas'
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoScripts)}
 , IedRangeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\IedRangeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evSelectConst in 'w:\common\components\gui\Garant\Everest\evSelectConst.pas'
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
 , ContentsElement_Const in 'w:\common\components\gui\Garant\Everest\ContentsElement_Const.pas'
 , nevRangeListTools in 'w:\common\components\gui\Garant\Everest\new\nevRangeListTools.pas'
 , evRangeTools in 'w:\common\components\gui\Garant\Everest\new\evRangeTools.pas'
 {$If Defined(k2ForEditor)}
 , evTableCellUtils in 'w:\common\components\gui\Garant\Everest\evTableCellUtils.pas'
 {$IfEnd} // Defined(k2ForEditor)
 , ObjectSegment_Const in 'w:\common\components\rtl\Garant\EVD\ObjectSegment_Const.pas'
 , SegmentWithChildren_Const in 'w:\common\components\rtl\Garant\EVD\SegmentWithChildren_Const.pas'
 , evMultiSelectEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evMultiSelectEditorWindowHotSpot.pas'
 , evEditorWindowHotSpot in 'w:\common\components\gui\Garant\Everest\evEditorWindowHotSpot.pas'
 , l3Tool in 'w:\common\components\rtl\Garant\L3\l3Tool.pas'
 , evDataObject in 'w:\common\components\gui\Garant\Everest\evDataObject.pas'
 {$If NOT Defined(NoScripts)}
 , TevCustomEditorWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TevCustomEditorWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evCustomTextSource in 'w:\common\components\gui\Garant\Everest\evCustomTextSource.pas'
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
 , nevDocumentFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevDocumentFormatInfo.pas'
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
 , nevTableCellFormatInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas'
 , evSectionPara in 'w:\common\components\gui\Garant\Everest\new\evSectionPara.pas'
 , nevRubberCellsRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevRubberCellsRenderInfo.pas'
 , nevTableRowRenderInfo in 'w:\common\components\gui\Garant\Everest\new\nevTableRowRenderInfo.pas'
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
 , l3PrinterIC in 'w:\common\components\rtl\Garant\L3\l3PrinterIC.pas'
 , Printers {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Printers.pas' {$EndIf}
 , l3Printer in 'w:\common\components\rtl\Garant\L3\l3Printer.pas'
 , Consts {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Consts.pas' {$EndIf}
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
 , Mark_Const in 'w:\common\components\rtl\Garant\EVD\Mark_Const.pas'
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
 , afwFont in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwFont.pas'
 , evStyleHeaderAdder in 'w:\common\components\gui\Garant\Everest\evStyleHeaderAdder.pas'
 , evdNativeUnpackedWriter in 'w:\common\components\rtl\Garant\EVD\evdNativeUnpackedWriter.pas'
 , evDocumentPreview in 'w:\common\components\gui\Garant\Everest\evDocumentPreview.pas'
 , evDocumentPreviewPrim in 'w:\common\components\gui\Garant\Everest\evDocumentPreviewPrim.pas'
 , l3TimeEstimation in 'w:\common\components\rtl\Garant\L3\l3TimeEstimation.pas'
 , nevRealTools in 'w:\common\components\gui\Garant\Everest\new\nevRealTools.pas'
 , nevViewInterfaces in 'w:\common\components\gui\Garant\Everest\new\nevViewInterfaces.pas'
 , afwPreviewCanvas in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewCanvas.pas'
 , afwPreviewPageList in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageList.pas'
 , l3BaseWithLargeIDList in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDList.pas'
 , l3BaseWithLargeIDListPrim in 'w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDListPrim.pas'
 , afwPreviewPage in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPage.pas'
 , l3Metafile in 'w:\common\components\rtl\Garant\L3\l3Metafile.pas'
 , l3MetafileHeader in 'w:\common\components\rtl\Garant\L3\l3MetafileHeader.pas'
 , l3DataCache in 'w:\common\components\rtl\Garant\L3\l3DataCache.pas'
 {$If Defined(nsTest)}
 , afwPreviewPageSpy in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwPreviewPageSpy.pas'
 {$IfEnd} // Defined(nsTest)
 , evPreviewProcessor in 'w:\common\components\gui\Garant\Everest\evPreviewProcessor.pas'
 , evNotifiedProcessor in 'w:\common\components\gui\Garant\Everest\evNotifiedProcessor.pas'
 , evParaDrawTools in 'w:\common\components\gui\Garant\Everest\evParaDrawTools.pas'
 , evdBlockNameAdder in 'w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas'
 , evdHeaderHyperlinkAdder in 'w:\common\components\gui\Garant\Everest\evdHeaderHyperlinkAdder.pas'
 , nevDocumentProvider in 'w:\common\components\gui\Garant\Everest\nevDocumentProvider.pas'
 , evPreviewForTestsTuning in 'w:\common\components\gui\Garant\Everest\evPreviewForTestsTuning.pas'
 {$If Defined(nsTest)}
 , PrintRowHeightsSpy in 'w:\common\components\gui\Garant\Everest\new\PrintRowHeightsSpy.pas'
 {$IfEnd} // Defined(nsTest)
 {$If Defined(InsiderTest)}
 , evCustomPrintDataSaver in 'w:\common\components\gui\Garant\Everest\evCustomPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest)
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
 , nevBaseView in 'w:\common\components\gui\Garant\Everest\new\nevBaseView.pas'
 , nevShapesPainted in 'w:\common\components\gui\Garant\Everest\new\nevShapesPainted.pas'
 , nevShapePrim in 'w:\common\components\gui\Garant\Everest\new\nevShapePrim.pas'
 , nevShapePrimRefList in 'w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas'
 , nevShapesPaintedSpy in 'w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas'
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
 {$If NOT Defined(NoVCL)}
 , ExtCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ExtCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PanelProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PanelProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RadioGroupWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 , l3CustomControlCanvas in 'w:\common\components\rtl\Garant\L3\l3CustomControlCanvas.pas'
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
 , vtComboBoxQS in 'w:\common\components\gui\Garant\VT\vtComboBoxQS.pas'
 , l3Operations in 'w:\common\components\rtl\Garant\L3\l3Operations.pas'
 , l3DropTarget in 'w:\common\components\rtl\Garant\L3\l3DropTarget.pas'
 , l3DropSource in 'w:\common\components\rtl\Garant\L3\l3DropSource.pas'
 , afwVCL in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas'
 , afwHintManager in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas'
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
 , ddPicturePathListner in 'w:\common\components\rtl\Garant\dd\ddPicturePathListner.pas'
 , l3PicturePathService in 'w:\common\components\rtl\Garant\L3\l3PicturePathService.pas'
 {$If NOT Defined(NoScripts)}
 , PictureEtalonsWorkingPack in 'w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , ddConst in 'w:\common\components\rtl\Garant\dd\ddConst.pas'
 , ddUtils in 'w:\common\components\rtl\Garant\dd\ddUtils.pas'
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetSelectionText in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionText.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetParaByID in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetParaByID.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopEditorGetSelectionTextInFormat in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionTextInFormat.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwPrintDataSaver in 'w:\common\components\rtl\Garant\ScriptEngine\kwPrintDataSaver.pas'
 {$IfEnd} // Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND NOT Defined(NoScripts)}
 , kwEndWaitPrint in 'w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas'
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
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
 , nevView in 'w:\common\components\gui\Garant\Everest\new\nevView.pas'
 , nevBaseDrawView in 'w:\common\components\gui\Garant\Everest\new\nevBaseDrawView.pas'
 , nevObjectList in 'w:\common\components\gui\Garant\Everest\new\nevObjectList.pas'
 , l3ProcessMessagesManager in 'w:\common\components\rtl\Garant\L3\l3ProcessMessagesManager.pas'
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
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
 , VGSceneWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGSceneWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
 , VGSceneAndWinControlPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGSceneAndWinControlPack.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoVGScene)}
 , vg_controls in 'w:\common\components\rtl\external\VGScene\vg_controls.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoScripts)}
 , VGComboBoxPack in 'w:\common\components\rtl\Garant\ScriptEngine\VGComboBoxPack.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoScripts)
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
 , l3VCLFormPtrList in 'w:\common\components\rtl\Garant\L3\l3VCLFormPtrList.pas'
 {$If NOT Defined(NoVCM)}
 , vcmSettings in 'w:\common\components\gui\Garant\VCM\implementation\vcmSettings.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtCheckBox in 'w:\common\components\gui\Garant\VT\vtCheckBox.pas'
 , eeCheckBox in 'w:\common\components\gui\Garant\VT\eeCheckBox.pas'
 , nscSimpleEditorForDialogs in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogs.pas'
 , nscSimpleEditor in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditor.pas'
 , nscSimpleEditorForDialogsTextSource in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsTextSource.pas'
 , nscSimpleEditorForDialogsContainer in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsContainer.pas'
 , vtFocusLabel in 'w:\common\components\gui\Garant\VT\vtFocusLabel.pas'
 , afwTextControl in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControl.pas'
 , afwTextControlPrim in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControlPrim.pas'
 , l3FormCanvas in 'w:\common\components\rtl\Garant\L3\l3FormCanvas.pas'
 , vtUtils in 'w:\common\components\gui\Garant\VT\vtUtils.pas'
 {$If NOT Defined(NoVCM)}
 , vcmLayoutImplementation in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmLayoutImplementation.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers in 'w:\common\components\gui\Garant\VCM\vcmControllers.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , VCMFormsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\VCMFormsProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoTB97)}
 , tb97WordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\tb97WordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoTB97)
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
 , ComCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ComCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeNodeWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeNodeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeViewWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 , l3DispatcherHelper in 'w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas'
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , VCMApllicationSettingsPack in 'w:\common\components\rtl\Garant\ScriptEngine\VCMApllicationSettingsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormsUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormsUtils.pas'
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
 , vcmFormsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Components\vcmFormsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationsManager in 'w:\common\components\gui\Garant\VCM\vcmOperationsManager.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmCustomHelpers in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomHelpers.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwEntityOperation in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperation.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwEntityOperationPrim in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwEntityOperationTest in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationTest.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwOperationsRegistrar in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationsRegistrar.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , VCMWordsPack in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmDispatcherLock in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLock.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes in 'StdRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmDispatcherUnlock in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlock.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmDispatcherBeginOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherBeginOp.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmDispatcherEndOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherEndOp.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryGetBackCount in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackCount.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryGetBackItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackItem.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryGetForwardCount in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardCount.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryGetForwardItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardItem.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpEnabled in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpEnabled.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwOperationParamWord in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWord.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwOperationParamWordPrim in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationParamWordPrim.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpVisible in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpVisible.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpChecked in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpChecked.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpDefault in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpDefault.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpCaption in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpCaption.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpHint in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpHint.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpImageIndex in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpImageIndex.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpShortcut in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpShortcut.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmOpLongHint in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpLongHint.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , RegisterVcmControls in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\RegisterVcmControls.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigator in 'w:\common\components\gui\Garant\VT\vtNavigator.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , ElPgCtlConsts in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtlConsts.pas'
 , vtCustomCommonPanel in 'w:\common\components\gui\Garant\VT\vtCustomCommonPanel.pas'
 , ElPgCtl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElPgCtl.pas'
 , ElXPThemedControl in 'w:\common\components\gui\Garant\VT\elClone\Source\ElXPThemedControl.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PageControlWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\PageControlWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
 , ReminderWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\ReminderWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
 , RemindersLineWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\RemindersLineWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryDeleteBackItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteBackItem.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmFindForm in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmFindForm.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryClear in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryClear.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmHistoryDeleteForwardItem in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryDeleteForwardItem.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwTryFocusOnForm in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwTryFocusOnForm.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwObjectCreate in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwObjectCreate.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmDispatcherLockInOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLockInOp.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , kwVcmDispatcherUnlockInOp in 'w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlockInOp.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister in 'w:\common\components\gui\Garant\VCM\vcmOperationsForRegister.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister in 'w:\common\components\gui\Garant\VCM\vcmOperationStatesForRegister.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister in 'w:\common\components\gui\Garant\VCM\vcmModulesForRegister.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister in 'w:\common\components\gui\Garant\VCM\vcmModuleOperationsForRegister.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , moToolbarMenu in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\moToolbarMenu.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimToolbarMenu_Module in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\PrimToolbarMenu_Module.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , VCMCustomization_Customization_Contracts in 'w:\common\components\gui\Garant\VCM\View\VCMCustomization_Customization_Contracts.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces in 'w:\common\components\gui\Garant\VCM\vcmTaskPanelInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmCustomizeAvailableToolbarOps in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomizeAvailableToolbarOps.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , CustomizeTools_Form in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimCustomizeTools_Form in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\PrimCustomizeTools_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , eeShortCutEdit in 'w:\common\components\gui\Garant\Everest_Engine\eeShortCutEdit.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , CustomizeTools_ut_CustomizeTools_UserType in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_ut_CustomizeTools_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CustomizeToolsKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeToolsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , tfwControlString in 'w:\common\components\rtl\Garant\ScriptEngine\tfwControlString.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , OfficeLikeMain_Form in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeMain_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoVCM)}
 , moTasksPanelMenu in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\moTasksPanelMenu.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTasksPanelMenu_Module in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\PrimTasksPanelMenu_Module.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , CustomizeTasksPanel_Form in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimCustomizeTasksPanel_Form in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\PrimCustomizeTasksPanel_Form.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , vtCtrls in 'w:\common\components\gui\Garant\VT\vtCtrls.pas'
 , vtButton in 'w:\common\components\gui\Garant\VT\vtButton.pas'
 , eeButton in 'w:\common\components\gui\Garant\VT\eeButton.pas'
 , vtGroupBox in 'w:\common\components\gui\Garant\VT\vtGroupBox.pas'
 , eeTreeView in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeView.pas'
 , eeInterfaces in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas'
 , eeConst in 'w:\common\components\gui\Garant\Everest_Engine\eeConst.pas'
 , eeTreeViewExport in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeViewExport.pas'
 , vtOutlinerWithDragDrop in 'w:\common\components\gui\Garant\VT\vtOutlinerWithDragDrop.pas'
 , vtOutlinerWithDragDropRes in 'w:\common\components\gui\Garant\VT\vtOutlinerWithDragDropRes.pas'
 , eeInterfacesEx in 'w:\common\components\gui\Garant\Everest_Engine\eeInterfacesEx.pas'
 , eeNode in 'w:\common\components\gui\Garant\Everest_Engine\eeNode.pas'
 , eeNodeUtils in 'w:\common\components\gui\Garant\Everest_Engine\eeNodeUtils.pas'
 {$If NOT Defined(NoVCM)}
 , CustomizeTasksPanelRes in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\CustomizeTasksPanelRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmCustOpsRepGroupList in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\vcmCustOpsRepGroupList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CustomizeTasksPanelKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanelKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moParentAndChild in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\moParentAndChild.pas'
 , ParentAndChildPrim_Module in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentAndChildPrim_Module.pas'
 , F1Like_Contracts in 'w:\common\components\gui\Garant\VCM\View\F1Like_Contracts.pas'
 , Parent_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Parent_Form.pas'
 , PrimParent_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_Form.pas'
 , PrimParent_utHistory_UserType in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_utHistory_UserType.pas'
 , F1Like_FormDefinitions_Controls in 'w:\common\components\gui\Garant\VCM\View\F1Like_FormDefinitions_Controls.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ParentKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\ParentKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Child_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Child_Form.pas'
 , PrimChild_Form in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_Form.pas'
 , F1Like_InternalOperations_Controls in 'w:\common\components\gui\Garant\VCM\View\F1Like_InternalOperations_Controls.pas'
 {$If Defined(Nemesis)}
 , nscFormsPageControl in 'w:\common\components\gui\Garant\Nemesis\nscFormsPageControl.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsFormUtils in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsFormUtils.pas'
 , PresentationInterfaces in 'w:\common\components\gui\Garant\VCM\View\PresentationInterfaces.pas'
 , vtProportionalPanel in 'w:\common\components\gui\Garant\VT\vtProportionalPanel.pas'
 , PrimChild_cutUsual_UserType in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutUsual_UserType.pas'
 , PrimChild_cutForDiction_UserType in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutForDiction_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChildKeywordsPack in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\ChildKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , MainPrim_Form in 'w:\common\components\gui\Garant\VCM\View\MainPrim_Form.pas'
 {$If NOT Defined(NoVCM)}
 , OfficeLike_System_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_System_Controls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscStatusBar in 'w:\common\components\gui\Garant\Nemesis\nscStatusBar.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscNewInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscNewInterfaces.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscSizeGripPanel in 'w:\common\components\gui\Garant\Nemesis\nscSizeGripPanel.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , StatusBarUtils in 'w:\common\components\gui\Garant\Nemesis\StatusBarUtils.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarButton in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarButton.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis) AND NOT Defined(NoScripts)}
 , StatusBarButtonWords in 'w:\common\components\rtl\Garant\ScriptEngine\StatusBarButtonWords.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)
 {$If Defined(Nemesis)}
 , nscStatusBarPanel in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarPanel.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarSep in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarSep.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis) AND NOT Defined(NoScripts)}
 , StatusBarWords in 'w:\common\components\rtl\Garant\ScriptEngine\StatusBarWords.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)
 , vtSizeablePanel in 'w:\common\components\gui\Garant\VT\vtSizeablePanel.pas'
 {$If Defined(Nemesis)}
 , nscNavigator in 'w:\common\components\gui\Garant\Nemesis\nscNavigator.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , nsWindowsList in 'w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowsList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , nsWindowsListPrim in 'w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowsListPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLikeAppInterfaces in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeAppInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerFormDispatcher.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerForm.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmChromeLikeTabbedContainerForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabbedContainerForm.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmChromeLikeTabbedContainerFormPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabbedContainerFormPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmGlassForm in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassForm.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmGlassFrame in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmGlassFrame.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , FormFrameDecorator in 'w:\common\components\gui\Garant\ChromeLikeControls\FormFrameDecorator.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeFormFramePainter in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormFramePainter.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeWindowCaptionButtonsRes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeWindowCaptionButtonsRes.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeFormCaptionData in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormCaptionData.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeWinUtils in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeWinUtils.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTypes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTypes.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeBaseWindowCaptionButton in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseWindowCaptionButton.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 , UxTheme {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\UxTheme.pas' {$EndIf}
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeLegacyWindowCaptionButtons in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeLegacyWindowCaptionButtons.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeThemedWindowCaptionButtons in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeThemedWindowCaptionButtons.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeBaseThemedWindowCaptionButton in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseThemedWindowCaptionButton.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetControl in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControl.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetControlPrim in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlPrim.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetTypes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetTypes.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 , GDIPOBJ {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\GDIPLUS\GDIPOBJ.pas' {$EndIf}
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeDrawingContext in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeDrawingContext.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetUtils in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetUtils.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeInterfaces in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeInterfaces.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeBaseVisualObjectPrim in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObjectPrim.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeBaseVisualObject in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObject.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeBaseVisualObjectList in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObjectList.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetAnimationManager in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetAnimationManager.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 , MMSystem {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\MMSystem.pas' {$EndIf}
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetStyles in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetStyles.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 , GDIPUTIL {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\GDIPLUS\GDIPUTIL.pas' {$EndIf}
 , GDIPAPI {$IfNDef XE4} in 'w:\common\components\rtl\external\JEDI\GDIPLUS\GDIPAPI.pas' {$EndIf}
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabParams in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabParams.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetControlRes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlRes.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetRes in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetRes.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmMainMenuStripForChromeLike in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmMainMenuStripForChromeLike.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmBaseMenuForChromeLike in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmBaseMenuForChromeLike.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmMenuForChromeLikeItems in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmMenuForChromeLikeItems.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmMainMenuForChromeLikeTypes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmMainMenuForChromeLikeTypes.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
 , vcmTabbedMenuWordsPack in 'w:\common\components\gui\Garant\VCM\vcmTabbedMenuWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmDropDownMenuForChromeLike in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmDropDownMenuForChromeLike.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCL)}
 , ShadowWnd {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\ShadowWnd.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , multimon {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\multimon.pas' {$EndIf}
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmPopupControlWindowService in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmPopupControlWindowService.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerRes in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerRes.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmFormSetHistory in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistory.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmFormSetFormHistoryItemList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetFormHistoryItemList.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmFormSetHistoryStepList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistoryStepList.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmFormSetHistoryItemList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistoryItemList.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmFormSetHistoryStepItemList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistoryStepItemList.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM)}
 , vcmIEntityFormList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetContainerRegistry in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetContainerRegistry.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmAggregate in 'w:\common\components\gui\Garant\VCM\implementation\vcmAggregate.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmTabbedContainersService in 'w:\common\components\gui\Garant\VCM\vcmTabbedContainersService.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
 , vcmTabsWordsPack in 'w:\common\components\gui\Garant\VCM\vcmTabsWordsPack.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcherUtils in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainerFormDispatcherUtils.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM)}
 , vcmHistory in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistory.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmHistoryItemList in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistoryItemList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmIEntityFormPtrList in 'w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormPtrList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmHistoryFormNode in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistoryFormNode.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmHistoryRes in 'w:\common\components\gui\Garant\VCM\implementation\vcmHistoryRes.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabsHistoryService in 'w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabsHistoryService.pas'
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM)}
 , vcmHistoryService in 'w:\common\components\gui\Garant\VCM\vcmHistoryService.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmAggregateContainerRegistry in 'w:\common\components\gui\Garant\VCM\implementation\vcmAggregateContainerRegistry.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityFormsIterable in 'w:\common\components\gui\Garant\VCM\implementation\vcmEntityFormsIterable.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeFormTabParamsList in 'w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormTabParamsList.pas'
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM)}
 , nsWindowNode in 'w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowNode.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmStringList in 'w:\common\components\gui\Garant\VCM\implementation\vcmStringList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , nsSettingsConst in 'w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsSettingsConst.pas'
 , nsQueryInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsQueryInterfaces.pas'
 , BaseTreeSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTreeSupportUnit.pas'
 , IOUnit in 'w:\shared\GCI\IOUnit.pas'
 , BaseTypesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BaseTypesUnit.pas'
 , ContextSearchSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ContextSearchSupportUnit.pas'
 , DynamicTreeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeUnit.pas'
 , SearchDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchDefinesUnit.pas'
 , DynamicTreeDefinesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicTreeDefinesUnit.pas'
 , FiltersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FiltersUnit.pas'
 , SearchUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchUnit.pas'
 , DynamicDocListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DynamicDocListUnit.pas'
 , DocumentUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DocumentUnit.pas'
 , FoldersUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\FoldersUnit.pas'
 , UnderControlUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UnderControlUnit.pas'
 , ExternalObjectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalObjectUnit.pas'
 , SearchProgressIndicatorUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SearchProgressIndicatorUnit.pas'
 , ProgressIndicatorSupportUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ProgressIndicatorSupportUnit.pas'
 , nsTypes in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\nsTypes.pas'
 , nsTypesNew in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\nsTypesNew.pas'
 , SearchInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\SearchInterfaces.pas'
 , TreeInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Tree\TreeInterfaces.pas'
 , SimpleListInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\List\SimpleListInterfaces.pas'
 , SearchDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\SearchDomainInterfaces.pas'
 , PrimCommon_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\PrimCommon_Module.pas'
 , F1_Application_Template_InternalOperations_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Application_Template_InternalOperations_Controls.pas'
 , ShutDown_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\ShutDown_Form.pas'
 , PrimShutDown_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimShutDown_Form.pas'
 , DataAdapter in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\DataAdapter.pas'
 , DataAdapterInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\DataAdapterInterfaces.pas'
 , AdminDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\AdminDomainInterfaces.pas'
 , nsQuestionsWithChoices in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\nsQuestionsWithChoices.pas'
 , nsLoginUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsLoginUtils.pas'
 , f1NotificationManager in 'w:\garant6x\implementation\Garant\GbaNemesis\View\f1NotificationManager.pas'
 , PrimShutDown_sftNone_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ShutDownKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\ShutDownKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Login_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Login_Form.pas'
 , PrimLogin_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimLogin_Form.pas'
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly in 'w:\common\components\gui\Garant\Nemesis\nscComboBoxWithReadOnly.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscComboBox in 'w:\common\components\gui\Garant\Nemesis\nscComboBox.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsStartupSupport in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsStartupSupport.pas'
 , nsUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUtils.pas'
 {$If NOT Defined(NoScripts)}
 , F1ShellWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\F1ShellWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsExternalObjectPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsExternalObjectPrim.pas'
 , ddHTMLWriter in 'w:\common\components\rtl\Garant\dd\ddHTMLWriter.pas'
 , ddDocument in 'w:\common\components\rtl\Garant\dd\ddDocument.pas'
 , evdAllParaEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllParaEliminator.pas'
 , ddTextParagraph in 'w:\common\components\rtl\Garant\dd\ddTextParagraph.pas'
 , ddDocumentAtom in 'w:\common\components\rtl\Garant\dd\ddDocumentAtom.pas'
 , ddCustomDestination in 'w:\common\components\rtl\Garant\dd\ddCustomDestination.pas'
 , ddRTFProperties in 'w:\common\components\rtl\Garant\dd\ddRTFProperties.pas'
 , RTFtypes in 'w:\common\components\rtl\Garant\dd\RTFtypes.pas'
 , rtfListTable in 'w:\common\components\rtl\Garant\dd\rtfListTable.pas'
 , ddTypes in 'w:\common\components\rtl\Garant\dd\ddTypes.pas'
 , ddCharacterProperty in 'w:\common\components\rtl\Garant\dd\ddCharacterProperty.pas'
 , ddParagraphProperty in 'w:\common\components\rtl\Garant\dd\ddParagraphProperty.pas'
 , ddTextSegmentsList in 'w:\common\components\rtl\Garant\dd\ddTextSegmentsList.pas'
 , ddTextSegment in 'w:\common\components\rtl\Garant\dd\ddTextSegment.pas'
 , ddHyperlinkTarget in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTarget.pas'
 , ddBaseObject in 'w:\common\components\rtl\Garant\dd\ddBaseObject.pas'
 , ddEVDTypesSupport in 'w:\common\components\rtl\Garant\dd\ddEVDTypesSupport.pas'
 , ddHyperlinkTargetList in 'w:\common\components\rtl\Garant\dd\ddHyperlinkTargetList.pas'
 , ddSubsList in 'w:\common\components\rtl\Garant\dd\ddSubsList.pas'
 , ddSub in 'w:\common\components\rtl\Garant\dd\ddSub.pas'
 , ddTextParaString in 'w:\common\components\rtl\Garant\dd\ddTextParaString.pas'
 , ddHTMLWriterRes in 'w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas'
 , nsExternalObjectModelPart in 'w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsExternalObjectModelPart.pas'
 , nsExternalObject in 'w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsExternalObject.pas'
 , nsBrowserInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsBrowserInfo.pas'
 , nsRegistryHelper in 'w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsRegistryHelper.pas'
 , l3WinVersionHelper in 'w:\common\components\rtl\Garant\L3\l3WinVersionHelper.pas'
 , nsDocumentStreamList in 'w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsDocumentStreamList.pas'
 , bsInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\bsInterfaces.pas'
 , ExternalOperationUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ExternalOperationUnit.pas'
 , SettingsUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SettingsUnit.pas'
 , SecurityUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\SecurityUnit.pas'
 , bsTypes in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\bsTypes.pas'
 , nsFlashWindow in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFlashWindow.pas'
 , SearchRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\SearchRes.pas'
 , nsConst in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsConst.pas'
 , Login_ut_Login_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Login_ut_Login_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LoginKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LoginKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , LongProcess_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcess_Form.pas'
 , PrimLongProcess_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimLongProcess_Form.pas'
 , vtGradientWaitbar in 'w:\common\components\gui\Garant\VT\vtGradientWaitbar.pas'
 , l3AsincMessageWindowRes in 'w:\common\components\rtl\Garant\L3\l3AsincMessageWindowRes.pas'
 , LongProcess_ut_LongProcess_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcess_ut_LongProcess_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LongProcessKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcessKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , nsPrimCachedEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsPrimCachedEvent.pas'
 , nsLogEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEvent.pas'
 , LoggingWrapperInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\LoggingWrapperInterfaces.pas'
 , LoggingUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\LoggingUnit.pas'
 , nsLogEventData in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEventData.pas'
 , bsConvert in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\bsConvert.pas'
 , nsLogManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogManager.pas'
 , nsLoggingTestService in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLoggingTestService.pas'
 {$If NOT Defined(NoScripts)}
 , LoggingWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\LoggingWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsCachedEventsProcessor in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsCachedEventsProcessor.pas'
 , nsPrimCachedEventsProcessor in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsPrimCachedEventsProcessor.pas'
 , LoggingInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\LoggingInterfaces.pas'
 , InsDefferedEventList in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\InsDefferedEventList.pas'
 , moLiteSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\moLiteSearch.pas'
 , LiteSearch_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\LiteSearch_Module.pas'
 , SearchLite_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_Strange_Controls.pas'
 , PrimAttributeSelect_utAttributeSelect_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas'
 , TreeAttributeSelect_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttributeSelect_Form.pas'
 , PrimTreeAttributeSelectOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelectOptions_Form.pas'
 , PrimTreeAttributeSelect_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_Form.pas'
 , TreeAttribute_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttribute_Form.pas'
 , L10nInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\L10nInterfaces.pas'
 {$If Defined(Nemesis)}
 , nscContextFilter in 'w:\common\components\gui\Garant\Nemesis\nscContextFilter.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscContextFilterRes in 'w:\common\components\gui\Garant\Nemesis\nscContextFilterRes.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck in 'w:\common\components\gui\Garant\Nemesis\nscTreeViewHotTruck.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeView in 'w:\common\components\gui\Garant\Nemesis\nscTreeView.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Text_Controls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Tree_Controls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscTreeViewRes in 'w:\common\components\gui\Garant\Nemesis\nscTreeViewRes.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmDefaultOperations in 'w:\common\components\gui\Garant\VCM\vcmDefaultOperations.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , afwConsts in 'w:\common\components\gui\Garant\AFW\afwConsts.pas'
 , PrimTreeAttributeSelect_astOneLevel_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astOneLevel_UserType.pas'
 , PrimTreeAttributeSelect_astNone_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas'
 , nsLogicOperationToFlags in 'w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsLogicOperationToFlags.pas'
 , nsAttrBranchStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttrBranchStruct.pas'
 , nsAttributeOneLevelTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeOneLevelTreeStruct.pas'
 , nsOneLevelTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsOneLevelTreeStruct.pas'
 , nsDataResetTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsDataResetTreeStruct.pas'
 , nsFilterableTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsFilterableTreeStruct.pas'
 , nsTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsTreeStruct.pas'
 , nsRootManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsRootManager.pas'
 , nsINodeWrapBase in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeWrapBase.pas'
 , nsINodeRootWrap in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeRootWrap.pas'
 , nsINodeWrap in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeWrap.pas'
 , l3TreeFilters in 'w:\common\components\rtl\Garant\L3\l3TreeFilters.pas'
 , nsAdapterFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsAdapterFilters.pas'
 , nsContextFilterParams in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsContextFilterParams.pas'
 , Il3ContextFilterParamsNotifierPtrList in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\Il3ContextFilterParamsNotifierPtrList.pas'
 , nsINodeOneLevelRootWrap in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeOneLevelRootWrap.pas'
 , nsINodeOneLevelWrap in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeOneLevelWrap.pas'
 , nsAttributeTreeFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeTreeFilters.pas'
 , nsAttributeTreeCacheNew in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeTreeCacheNew.pas'
 , l3InterfacedStringList in 'w:\common\components\rtl\Garant\L3\l3InterfacedStringList.pas'
 , GblAdapter
 , bsUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\bsUtils.pas'
 , nsSelectedAttributesIterators in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsSelectedAttributesIterators.pas'
 , nsTreeAttributeNodesNew in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\nsTreeAttributeNodesNew.pas'
 , nsAttributeTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeTreeStruct.pas'
 , nsValueMaps in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsValueMaps.pas'
 , nsIntegerValueMapFactory in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsIntegerValueMapFactory.pas'
 , nsStringValueMapFactory in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsStringValueMapFactory.pas'
 , nsStringValueMapFactoryRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsStringValueMapFactoryRes.pas'
 , nsValueMapsIDs in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsValueMapsIDs.pas'
 , nsFirstLevelStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsFirstLevelStruct.pas'
 , dsTreeAttributeSelect in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTreeAttributeSelect.pas'
 , nsNewCachableNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNewCachableNode.pas'
 , deSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\deSearch.pas'
 , nsQuery in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\nsQuery.pas'
 , SearchLite_FormDefinitions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_FormDefinitions_Controls.pas'
 , tasSaveLoadProxy in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\tasSaveLoadProxy.pas'
 {$If Defined(Nemesis)}
 , nscContextFilterState in 'w:\common\components\gui\Garant\Nemesis\nscContextFilterState.pas'
 {$IfEnd} // Defined(Nemesis)
 , PrimTreeAttributeSelect_astFirstLevel_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astFirstLevel_UserType.pas'
 , PrimTreeAttributeSelect_astTaxesPublishSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas'
 , PrimTreeAttributeSelect_astPharmPublishSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas'
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Result_Controls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeAttributeSelectKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttributeSelectKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , AttributeSelect_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\AttributeSelect_Form.pas'
 , PrimAttributeSelectOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelectOptions_Form.pas'
 , PrimAttributeSelect_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_Form.pas'
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls in 'w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_ResultEx_Controls.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimAttributeSelect_utSingleSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utSingleSearch_UserType.pas'
 , nsNodes in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodes.pas'
 , nsBaseNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsBaseNode.pas'
 , nsPrimCacheableNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsPrimCacheableNode.pas'
 , nsPrimAdapterNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsPrimAdapterNode.pas'
 , nsPrimNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsPrimNode.pas'
 , eeVirtualNode in 'w:\common\components\gui\Garant\Everest_Engine\eeVirtualNode.pas'
 , l3VirtualNode in 'w:\common\components\rtl\Garant\L3\l3VirtualNode.pas'
 , nsWrapperNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsWrapperNode.pas'
 , OldTreeInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\OldTreeInterfaces.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AttributeSelectKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\AttributeSelectKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , SelectedAttributes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\SelectedAttributes_Form.pas'
 , PrimSelectedAttributesOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributesOptions_Form.pas'
 , PrimSelectedAttributes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributes_Form.pas'
 , nscTreeViewWithAdapterDragDrop in 'w:\garant6x\implementation\Garant\GbaNemesis\Components\nscTreeViewWithAdapterDragDrop.pas'
 , nsEntitiesTreeDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Components\nsEntitiesTreeDataObject.pas'
 , evNodeData in 'w:\common\components\gui\Garant\EverestCommon\evNodeData.pas'
 , evNodeDataObject in 'w:\common\components\gui\Garant\Everest\evNodeDataObject.pas'
 , evNodeStorable in 'w:\common\components\gui\Garant\Everest\evNodeStorable.pas'
 , evStringStorable in 'w:\common\components\gui\Garant\Everest\evStringStorable.pas'
 , evStorable in 'w:\common\components\gui\Garant\Everest\evStorable.pas'
 , evPersistentDataObjectEx in 'w:\common\components\gui\Garant\Everest\evPersistentDataObjectEx.pas'
 , evPersistentDataObject in 'w:\common\components\gui\Garant\Everest\evPersistentDataObject.pas'
 , evFormats in 'w:\common\components\gui\Garant\Everest\evFormats.pas'
 , l3TreeConst in 'w:\common\components\rtl\Garant\L3\l3TreeConst.pas'
 , ddRTFWriter in 'w:\common\components\rtl\Garant\dd\ddRTFWriter.pas'
 , ddRTFExpandedTextWriter in 'w:\common\components\rtl\Garant\dd\ddRTFExpandedTextWriter.pas'
 , ddRTFSegmentWriter in 'w:\common\components\rtl\Garant\dd\ddRTFSegmentWriter.pas'
 , ddTextSegmentQueue in 'w:\common\components\rtl\Garant\dd\ddTextSegmentQueue.pas'
 , ddHyperlink in 'w:\common\components\rtl\Garant\dd\ddHyperlink.pas'
 , ddPicture in 'w:\common\components\rtl\Garant\dd\ddPicture.pas'
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
 , ddRTFUnits in 'w:\common\components\rtl\Garant\dd\ddRTFUnits.pas'
 , l3ImageUtils in 'w:\common\components\rtl\Garant\L3\l3ImageUtils.pas'
 , ddHexCharReader in 'w:\common\components\rtl\Garant\dd\ddHexCharReader.pas'
 , l3CharSkipper in 'w:\common\components\rtl\Garant\L3\l3CharSkipper.pas'
 , ddPictureSegment in 'w:\common\components\rtl\Garant\dd\ddPictureSegment.pas'
 , ddObjectSegment in 'w:\common\components\rtl\Garant\dd\ddObjectSegment.pas'
 , ddFormulaSegment in 'w:\common\components\rtl\Garant\dd\ddFormulaSegment.pas'
 , nsNodeDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Components\nsNodeDataObject.pas'
 , nsNodeStorable in 'w:\garant6x\implementation\Garant\GbaNemesis\Components\nsNodeStorable.pas'
 , nsNodeBaseList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\nsNodeBaseList.pas'
 , nsSelectedTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\nsSelectedTreeStruct.pas'
 , PrimSelectedAttributes_utSelectedAttributes_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributes_utSelectedAttributes_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SelectedAttributesKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\SelectedAttributesKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moRealCommon in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\moRealCommon.pas'
 , DebugStr in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\DebugStr.pas'
 {$If Defined(Nemesis)}
 , F1_Schema in 'w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas'
 {$IfEnd} // Defined(Nemesis)
 , Everest_Schema in 'w:\common\components\gui\Garant\Everest\Everest_Schema.pas'
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
 {$If Defined(Nemesis)}
 , eeDocument_Schema in 'w:\common\components\gui\Garant\Everest_Engine\eeDocument_Schema.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , F1_AttrValues in 'w:\common\components\gui\Garant\Everest_Engine\F1_AttrValues.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsSettings in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\nsSettings.pas'
 , InsUserSettingsListenerPtrList in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\InsUserSettingsListenerPtrList.pas'
 , InsUserSettingsEditListenerPtrList in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\InsUserSettingsEditListenerPtrList.pas'
 , nsContextFilterEventListener in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsContextFilterEventListener.pas'
 , nsContextFilterEventDataList in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsContextFilterEventDataList.pas'
 , evdSchema in 'w:\common\components\gui\Garant\Everest\evdSchema.pas'
 {$If Defined(Archi)}
 , evArchi_Schema in 'w:\common\components\gui\Garant\Everest\evArchi_Schema.pas'
 {$IfEnd} // Defined(Archi)
 {$If Defined(evMyEditor)}
 , My_Schema in 'w:\common\components\gui\Garant\Everest\My_Schema.pas'
 {$IfEnd} // Defined(evMyEditor)
 {$If Defined(DesignTimeLibrary)}
 , Design_Schema in 'w:\common\components\gui\Garant\Everest\Design_Schema.pas'
 {$IfEnd} // Defined(DesignTimeLibrary)
 , Design_AttrValues in 'w:\common\components\gui\Garant\Everest\Design_AttrValues.pas'
 , Logo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Logo_Form.pas'
 , Logo_ut_Logo_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Logo_ut_Logo_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LogoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LogoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , nsAppTitleData in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsAppTitleData.pas'
 , f1StartupCompletedService in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\f1StartupCompletedService.pas'
 , StartUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\StartUnit.pas'
 , BannerUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\BannerUnit.pas'
 , SPHTMLHelp in 'w:\common\components\gui\Garant\AFW\SPHTMLHelp.pas'
 , PrimMain_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimMain_Form.pas'
 , nsCustomStyleProcessor in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCustomStyleProcessor.pas'
 , evCustomStyleManager in 'w:\common\components\gui\Garant\Everest\evCustomStyleManager.pas'
 , nscDocumentHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\Components\nscDocumentHistory.pas'
 , PrimMainOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimMainOptions_Form.pas'
 , ConfigInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\ConfigInterfaces.pas'
 , moCommonSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\moCommonSearch.pas'
 , CommonSearch_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\CommonSearch_Module.pas'
 , SaveLoad_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\SaveLoad_Form.pas'
 , PrimSaveLoadOptionsWithUserTypes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsWithUserTypes_Form.pas'
 , PrimSaveLoadOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptions_Form.pas'
 , PrimSaveLoad_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoad_Form.pas'
 , PrimBaseSearchInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimBaseSearchInterfaces.pas'
 , Search_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search_Strange_Controls.pas'
 , PrimPrimListInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimPrimListInterfaces.pas'
 , PrimWorkJournalInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimWorkJournalInterfaces.pas'
 {$If NOT Defined(NoVCM)}
 , vcmItems in 'w:\common\components\gui\Garant\VCM\implementation\vcmItems.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , FoldersDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\FoldersDomainInterfaces.pas'
 , nsFolders in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsFolders.pas'
 , nsbQueryUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsbQueryUtils.pas'
 , nsFolderFilterInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsFolderFilterInfo.pas'
 , Search_FormDefinitions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search_FormDefinitions_Controls.pas'
 , nsTabbedInterfaceTypes in 'w:\garant6x\implementation\Garant\GbaNemesis\TabInterface\nsTabbedInterfaceTypes.pas'
 , TabbedContainerRes in 'w:\garant6x\implementation\Garant\GbaNemesis\TabInterface\TabbedContainerRes.pas'
 , nsQueryUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsQueryUtils.pas'
 , ContextHistoryInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\ContextHistoryInterfaces.pas'
 , nsQueryAttribute in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsQueryAttribute.pas'
 , l3CObjectRefList in 'w:\common\components\rtl\Garant\L3\l3CObjectRefList.pas'
 , BaseSearchInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\BaseSearchInterfaces.pas'
 , evControlParaTools in 'w:\common\components\gui\Garant\Everest\qf\evControlParaTools.pas'
 , nsContextUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsContextUtils.pas'
 , nsVerifyValue in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsVerifyValue.pas'
 , nsTreeUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsTreeUtils.pas'
 {$If Defined(Nemesis)}
 , eeTreeMisc in 'w:\common\components\gui\Garant\Everest_Engine\eeTreeMisc.pas'
 {$IfEnd} // Defined(Nemesis)
 , SystemStr in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\SystemStr.pas'
 , nsSearchClasses in 'w:\garant6x\implementation\Garant\GbaNemesis\QueryCardProcessing\nsSearchClasses.pas'
 , MonitoringUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\MonitoringUnit.pas'
 , nsQueryExecuteProgressIndicator in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\nsQueryExecuteProgressIndicator.pas'
 , nsManagers in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsManagers.pas'
 {$If Defined(vcmUseProfilers)}
 , ProfilersInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\ProfilersInterfaces.pas'
 {$IfEnd} // Defined(vcmUseProfilers)
 , nsQuestions in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\nsQuestions.pas'
 , nsContextHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsContextHistory.pas'
 , nsInpharmContextHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsInpharmContextHistory.pas'
 , nsInpharmContextHistoryPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsInpharmContextHistoryPrim.pas'
 , InsContextSearchHistoryNotifierList in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\InsContextSearchHistoryNotifierList.pas'
 , nsDocumentContextHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsDocumentContextHistory.pas'
 , nsDocumentContextHistoryPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsDocumentContextHistoryPrim.pas'
 , nsDataExchangeProxy in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDataExchangeProxy.pas'
 , ConsultingUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ConsultingUnit.pas'
 , nsPostingsTreeSingle in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPostingsTreeSingle.pas'
 , nsPostingsLine in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPostingsLine.pas'
 , nsPrimeNode in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsPrimeNode.pas'
 , PrimeDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimeDomainInterfaces.pas'
 , PrimeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\PrimeUnit.pas'
 , PrimSaveLoadUserTypes_slqtAttribute_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtAttribute_UserType.pas'
 , PrimSaveLoadUserTypes_slqtKW_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtKW_UserType.pas'
 , PrimSaveLoadUserTypes_slqtOldKW_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtOldKW_UserType.pas'
 , PrimSaveLoadUserTypes_slqtPublishSource_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPublishSource_UserType.pas'
 , PrimSaveLoadUserTypes_slqtFilters_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtFilters_UserType.pas'
 , PrimSaveLoadUserTypes_slqtLegislationReview_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas'
 , PrimSaveLoadUserTypes_slqtPostingOrder_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPostingOrder_UserType.pas'
 , PrimSaveLoadUserTypes_slqtConsult_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtConsult_UserType.pas'
 , PrimSaveLoadUserTypes_slqtInpharmSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SaveLoadKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\SaveLoadKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , QueryCard_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\QueryCard_Form.pas'
 , PrimQueryCardOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCardOptions_Form.pas'
 , PrimQueryCard_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_Form.pas'
 , QueryCardInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\QueryCardInterfaces.pas'
 , evQueryCardEditor in 'w:\common\components\gui\Garant\Everest\evQueryCardEditor.pas'
 , evEditor in 'w:\common\components\gui\Garant\Everest\evEditor.pas'
 , evTunedEditor in 'w:\common\components\gui\Garant\Everest\evTunedEditor.pas'
 , evQueryCardEditorHotSpot in 'w:\common\components\gui\Garant\Everest\evQueryCardEditorHotSpot.pas'
 , evQueryCardSelection in 'w:\common\components\gui\Garant\Everest\evQueryCardSelection.pas'
 {$If NOT Defined(NoScripts)}
 , QueryCardProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\QueryCardProcessingPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeSetWithLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetWithLogicOperation.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwQueryCardFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwQueryCardFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , evReqIterator in 'w:\common\components\gui\Garant\Everest\evReqIterator.pas'
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardSetAttribute in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardSetAttribute.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeSetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetCollapsed.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeSetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetFocus.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeGetFocus in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetFocus.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeGetCollapsed in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetCollapsed.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeGetLogicOperation in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetLogicOperation.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardAttributeIsLogicOperationEnabled in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeIsLogicOperationEnabled.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPopQueryCardGetCurrentReqName in 'w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardGetCurrentReqName.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimQueryCard_utqcSendConsultation_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcSendConsultation_UserType.pas'
 , PrimQueryCard_utqcLegislationReview_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcLegislationReview_UserType.pas'
 , PrimQueryCard_utqcPostingOrder_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcPostingOrder_UserType.pas'
 , PrimQueryCard_utqcAttributeSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcAttributeSearch_UserType.pas'
 , PrimQueryCard_utqcInpharmSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcInpharmSearch_UserType.pas'
 , evControlContainerEX in 'w:\common\components\gui\Garant\Everest\qf\evControlContainerEX.pas'
 , evControlContainer in 'w:\common\components\gui\Garant\Everest\qf\evControlContainer.pas'
 , evCustomControlTool in 'w:\common\components\gui\Garant\Everest\qf\evCustomControlTool.pas'
 , evQueryGroupList in 'w:\common\components\gui\Garant\Everest\qf\evQueryGroupList.pas'
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
 , MainMenuNewRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenuNewRes.pas'
 , f1QueryDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\QueryCardProcessing\f1QueryDocumentContainer.pas'
 , evQueryDocumentContainer in 'w:\common\components\gui\Garant\Everest\qf\evQueryDocumentContainer.pas'
 , evQueryCardProcessor in 'w:\common\components\gui\Garant\Everest\qf\evQueryCardProcessor.pas'
 , evControlGenerator in 'w:\common\components\gui\Garant\Everest\qf\evControlGenerator.pas'
 , k2IUnknownTag in 'w:\common\components\rtl\Garant\K2\k2IUnknownTag.pas'
 {$If NOT Defined(NoScripts)}
 , PrimQueryCardWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrimQueryCardWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , kwFormFromControlWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwFormFromControlWord.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , nsDocumentPreview in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDocumentPreview.pas'
 , evEvdDataObject in 'w:\common\components\gui\Garant\Everest\evEvdDataObject.pas'
 , evReaderDataObject in 'w:\common\components\gui\Garant\Everest\evReaderDataObject.pas'
 , evStreamedDataObject in 'w:\common\components\gui\Garant\Everest\evStreamedDataObject.pas'
 , nsHAFPainter in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsHAFPainter.pas'
 , nsHAFPainterPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsHAFPainterPrim.pas'
 , nsFixedHAFMacroReplacer in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsFixedHAFMacroReplacer.pas'
 {$If Defined(Nemesis)}
 , eeDocumentContainer in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainer.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeDocumentContainerPrim in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainerPrim.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeProcessor in 'w:\common\components\gui\Garant\Everest_Engine\eeProcessor.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeDocumentPartGenerator in 'w:\common\components\gui\Garant\Everest_Engine\eeDocumentPartGenerator.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeSubExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubExport.pas'
 {$IfEnd} // Defined(Nemesis)
 , evCommentParaDecorator in 'w:\common\components\gui\Garant\Everest\evCommentParaDecorator.pas'
 , evLeafParaDecorationsHolderEliminator in 'w:\common\components\gui\Garant\EverestCommon\evLeafParaDecorationsHolderEliminator.pas'
 , evBlocksEliminator in 'w:\common\components\gui\Garant\EverestCommon\evBlocksEliminator.pas'
 , evUserCommentFilter in 'w:\common\components\gui\Garant\Everest\evUserCommentFilter.pas'
 , evCommentDecorator in 'w:\common\components\gui\Garant\Everest\evCommentDecorator.pas'
 , evNestedDocumentEliminator in 'w:\common\components\gui\Garant\Everest\evNestedDocumentEliminator.pas'
 , evCommentParaAdder in 'w:\common\components\gui\Garant\Everest\evCommentParaAdder.pas'
 , evPageBreakEliminator in 'w:\common\components\gui\Garant\Everest\evPageBreakEliminator.pas'
 , evControlParaFilter in 'w:\common\components\gui\Garant\Everest\evControlParaFilter.pas'
 , evBlocksButNotCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evBlocksButNotCommentsEliminator.pas'
 , evStrictContentsElementEliminator in 'w:\common\components\gui\Garant\EverestCommon\evStrictContentsElementEliminator.pas'
 , ComObj {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\ComObj.pas' {$EndIf}
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , QueryCardKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\QueryCardKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Preview_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\Preview_Form.pas'
 , PrimPreview_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_Form.pas'
 , Search_ScalingSupport_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search_ScalingSupport_Controls.pas'
 {$If Defined(Nemesis)}
 , nscPreviewPanel in 'w:\common\components\gui\Garant\Nemesis\nscPreviewPanel.pas'
 {$IfEnd} // Defined(Nemesis)
 , eePreviewPanel in 'w:\common\components\gui\Garant\Everest_Engine\eePreviewPanel.pas'
 , vtCustomPreviewPanel in 'w:\common\components\gui\Garant\VT\vtCustomPreviewPanel.pas'
 , nsTrialSupport in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsTrialSupport.pas'
 , PrimPreview_utPrintPreview_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PreviewFormKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PreviewFormKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , PageSetup_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PageSetup_Form.pas'
 , PrimPageSetupOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetupOptions_Form.pas'
 , PrimPageSetup_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetup_Form.pas'
 {$If Defined(Nemesis)}
 , nscPageControl in 'w:\common\components\gui\Garant\Nemesis\nscPageControl.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsPageSetup in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsPageSetup.pas'
 , PrimPageSetup_pstNone_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetup_pstNone_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PageSetupKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PageSetupKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , PrintDialog_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrintDialog_Form.pas'
 , PrimPrintDialogOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPrintDialogOptions_Form.pas'
 , PrimPrintDialog_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPrintDialog_Form.pas'
 , vtRadioButton in 'w:\common\components\gui\Garant\VT\vtRadioButton.pas'
 , vtSpinEdit in 'w:\common\components\gui\Garant\VT\vtSpinEdit.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SpinEditWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , PreviewInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\PreviewInterfaces.pas'
 , l3RangeManager in 'w:\common\components\rtl\Garant\L3\l3RangeManager.pas'
 , PrintDialog_ut_PrintDialog_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrintDialog_ut_PrintDialog_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PrintDialogKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrintDialogKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , tasSaveLoadRealization in 'w:\garant6x\implementation\Garant\GbaNemesis\View\tasSaveLoadRealization.pas'
 , ShellAndMonitoringsMain_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsMain_Form.pas'
 , MedicMainMenuRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MedicMainMenuRes.pas'
 , nsHooks in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsHooks.pas'
 , MainWindow_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainWindow_Form.pas'
 , MainWithReminders_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainWithReminders_Form.pas'
 , Main_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Main_Form.pas'
 , MainOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainOptions_Form.pas'
 , NemesisMain_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\NemesisMain_Form.pas'
 , F1_Without_Usecases_System_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_System_Controls.pas'
 , nsUnderControlNotificationManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUnderControlNotificationManager.pas'
 , MainWindowInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\MainWindowControllers\MainWindowInterfaces.pas'
 , DocumentAndListInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\Common\DocumentAndListInterfaces.pas'
 , AdapterFacade in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\AdapterFacade.pas'
 , PrimListInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\PrimListInterfaces.pas'
 , DocumentInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessingInterfaces\DocumentInterfaces.pas'
 , bsTypesNew in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\bsTypesNew.pas'
 , F1TagDataProviderInterface in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\F1TagDataProviderInterface.pas'
 , DocTreeUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\DocTreeUnit.pas'
 , resWarnImages in 'w:\garant6x\implementation\Garant\GbaNemesis\View\resWarnImages.pas'
 , nsForwardEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsForwardEvent.pas'
 , nsBackEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsBackEvent.pas'
 , sdsMainWindow in 'w:\garant6x\implementation\Garant\GbaNemesis\MainWindowControllers\sdsMainWindow.pas'
 , dsWarning in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsWarning.pas'
 , WarningUserTypes_Warning_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes_Warning_UserType.pas'
 , BaloonWarningUserTypes_Fake_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_Fake_UserType.pas'
 , BaloonWarningUserTypes_WarnJuror_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnJuror_UserType.pas'
 , BaloonWarningUserTypes_WarnPreActive_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnPreActive_UserType.pas'
 , BaloonWarningUserTypes_WarnIsAbolished_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnIsAbolished_UserType.pas'
 , BaloonWarningUserTypes_WarnOnControl_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnOnControl_UserType.pas'
 , BaloonWarningUserTypes_WarnInactualDocument_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnInactualDocument_UserType.pas'
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineOn_UserType.pas'
 , BaloonWarningUserTypes_WarnRedaction_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnRedaction_UserType.pas'
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas'
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineException_UserType.pas'
 , BaloonWarningUserTypes_remListModified_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remListModified_UserType.pas'
 , BaloonWarningUserTypes_remListFiltered_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remListFiltered_UserType.pas'
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remTimeMachineWarning_UserType.pas'
 , BaloonWarningUserTypes_remUnreadConsultations_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remUnreadConsultations_UserType.pas'
 , BaloonWarningUserTypes_remOnlineDead_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remOnlineDead_UserType.pas'
 , BaloonWarningUserTypes_TrialModeWarning_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_TrialModeWarning_UserType.pas'
 , BaloonWarningUserTypes_OldBaseWarning_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_OldBaseWarning_UserType.pas'
 , BaloonWarningUserTypes_ControlledChangingWarning_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_ControlledChangingWarning_UserType.pas'
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceRef.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarOperationDefsList.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarOperationDef.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarItemDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarItemDef.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsChangeFontSizeEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsChangeFontSizeEvent.pas'
 , nsSettingsUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsSettingsUtils.pas'
 , nsStyleEditor in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsStyleEditor.pas'
 , nsPrimaryMonitorResolutionEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsPrimaryMonitorResolutionEvent.pas'
 , nsDPIEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsDPIEvent.pas'
 , nsFontSizeEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFontSizeEvent.pas'
 , NemesisMain_utMainWindow_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\NemesisMain_utMainWindow_UserType.pas'
 {$If Defined(Nemesis)}
 , nscRemindersLine in 'w:\common\components\gui\Garant\Nemesis\nscRemindersLine.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineWithState in 'w:\common\components\gui\Garant\VT\vgRemindersLineWithState.pas'
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If Defined(Nemesis)}
 , nscReminder in 'w:\common\components\gui\Garant\Nemesis\nscReminder.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsIntegrationSupport in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsIntegrationSupport.pas'
 {$If NOT Defined(NoScripts)}
 , IntegrationWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\Integration\Implementation\IntegrationWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsIntegrationModelPart in 'w:\garant6x\implementation\Garant\GbaNemesis\Integration\Implementation\nsIntegrationModelPart.pas'
 , Registry {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Registry.pas' {$EndIf}
 , LocaleMessages in 'w:\garant6x\implementation\Garant\GbaNemesis\Integration\Implementation\LocaleMessages.pas'
 , nsBaseMainMenuTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsBaseMainMenuTree.pas'
 , nsDataResetTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsDataResetTree.pas'
 , nsRubricatorCache in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsRubricatorCache.pas'
 , nsMainMenuNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsMainMenuNode.pas'
 , MainMenuDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\MainMenuDomainInterfaces.pas'
 , nsOpenUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsOpenUtils.pas'
 , MainMenuUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\MainMenuUnit.pas'
 , Common_FormDefinitions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common_FormDefinitions_Controls.pas'
 , Common_Rubricator_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common_Rubricator_Controls.pas'
 , nsNotificationManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsNotificationManager.pas'
 , nsBaseSearcher in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearcher.pas'
 , nsFiltersContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersContainer.pas'
 , nsFiltersInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersInterfaces.pas'
 , nsFiltersContainerPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersContainerPrim.pas'
 , nsFiltersTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersTree.pas'
 , nsFiltersNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersNode.pas'
 , nsFiltersListenersDocManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersDocManager.pas'
 , nsFiltersListenersManagerPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersManagerPrim.pas'
 , nsFiltersListenersList in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersList.pas'
 , nsFiltersListenersDrugsManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersDrugsManager.pas'
 , nsFiltersRootNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersRootNode.pas'
 , nsBaseSearchClasses in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchClasses.pas'
 , nsBaseSearchClassList in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchClassList.pas'
 , nsBaseSearchServiceImpl in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchServiceImpl.pas'
 , nsBaseSearchService in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchService.pas'
 , nsBaseSearcherWindowData in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearcherWindowData.pas'
 , nsBaseSearchWindowDataListenerList in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchWindowDataListenerList.pas'
 , MemoryUsage_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsage_Form.pas'
 , MemoryUsagePrim_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsagePrim_Form.pas'
 , F1_Without_Usecases_DocumentsCacheOperations_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_DocumentsCacheOperations_Controls.pas'
 , evMemo in 'w:\common\components\gui\Garant\Everest\evMemo.pas'
 , MemoryUsage_ut_MemoryUsage_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsage_ut_MemoryUsage_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MemoryUsageKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsageKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , l3AsincMessageWindow in 'w:\common\components\rtl\Garant\L3\l3AsincMessageWindow.pas'
 , IntegrationProjectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\IntegrationProjectUnit.pas'
 , HelpIntfs {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\HelpIntfs.pas' {$EndIf}
 , vtVerInf in 'w:\common\components\rtl\Garant\L3\vtVerInf.pas'
 , nsConfiguration in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsConfiguration.pas'
 , f1StartupCompletedServiceImpl in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\f1StartupCompletedServiceImpl.pas'
 , PrimMonitorings_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrimMonitorings_Module.pas'
 , Autoreferat_InternalOperations_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Autoreferat_InternalOperations_Controls.pas'
 , PostingOrder_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_Strange_Controls.pas'
 , sdsAutoreferat in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\sdsAutoreferat.pas'
 , AutoreferatInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\AutoreferatInterfaces.pas'
 , dsAutoreferat in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\dsAutoreferat.pas'
 , WorkWithListInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\WorkWithListInterfaces.pas'
 , WorkWithDocumentInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\WorkWithDocumentInterfaces.pas'
 , DocInfoInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\DocInfoInterfaces.pas'
 , BaseDocumentWithAttributesInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\BaseDocumentWithAttributesInterfaces.pas'
 , nsDocumentLikeStateHolder in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentLikeStateHolder.pas'
 , UnderControlInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlInterfaces.pas'
 , nsAutoreferatDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\nsAutoreferatDocumentContainer.pas'
 , nsF1DocumentTagNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsF1DocumentTagNode.pas'
 , nsDocumentTagNodeBase in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsDocumentTagNodeBase.pas'
 , nsOwnedDocumentTagNodePrim in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsOwnedDocumentTagNodePrim.pas'
 , nsDocumentTagNodePrim in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsDocumentTagNodePrim.pas'
 , nsBlockNodePrim in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsBlockNodePrim.pas'
 , nsParaListNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParaListNode.pas'
 , nsParaListNodeModelPart in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParaListNodeModelPart.pas'
 , nsParentedTagNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagNode.pas'
 , nsTagNodePrim in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodePrim.pas'
 , nsTagNodePrimPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodePrimPrim.pas'
 , nsBaseTagNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsBaseTagNode.pas'
 , k2HugeTagObject in 'w:\common\components\rtl\Garant\K2\k2HugeTagObject.pas'
 , l3BitArr in 'w:\common\components\rtl\Garant\L3\l3BitArr.pas'
 , l3BoxMemoryManagerPrim in 'w:\common\components\rtl\Garant\L3\l3BoxMemoryManagerPrim.pas'
 , l3BaseBoxMemoryManager in 'w:\common\components\rtl\Garant\L3\l3BaseBoxMemoryManager.pas'
 , nsTagString in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagString.pas'
 , nsString in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsString.pas'
 , evdVer in 'w:\common\components\rtl\Garant\EVD\evdVer.pas'
 , nsStyleParser in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsStyleParser.pas'
 , k2InPlaceGenerator in 'w:\common\components\rtl\Garant\K2\k2InPlaceGenerator.pas'
 , evNestedCommentsEliminator in 'w:\common\components\gui\Garant\Everest\evNestedCommentsEliminator.pas'
 , nsLeafParaNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsLeafParaNode.pas'
 , f1AtomChecker in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1AtomChecker.pas'
 , nsSubNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsSubNode.pas'
 , nsSectionBreakNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsSectionBreakNode.pas'
 , nsTextParaNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTextParaNode.pas'
 , nsControlParaNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsControlParaNode.pas'
 , nsBitmapParaNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsBitmapParaNode.pas'
 , evBitmapPara_Wrap in 'w:\common\components\gui\Garant\Everest\evBitmapPara_Wrap.pas'
 , evPara_Wrap in 'w:\common\components\rtl\Garant\EVD\evPara_Wrap.pas'
 , k2Tag_Wrap in 'w:\common\components\rtl\Garant\K2\k2Tag_Wrap.pas'
 , Persistent_Wrap in 'w:\common\components\rtl\Garant\K2\Persistent_Wrap.pas'
 , Object_Wrap in 'w:\common\components\rtl\Garant\K2\Object_Wrap.pas'
 , k2SizedMemoryPool in 'w:\common\components\rtl\Garant\K2\k2SizedMemoryPool.pas'
 , k2MemoryPoolAdapter in 'w:\common\components\rtl\Garant\K2\k2MemoryPoolAdapter.pas'
 , k2MemoryStream in 'w:\common\components\rtl\Garant\K2\k2MemoryStream.pas'
 , l3TempMemoryStream in 'w:\common\components\rtl\Garant\L3\l3TempMemoryStream.pas'
 , nsReqCellNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsReqCellNode.pas'
 , nsReqRowNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsReqRowNode.pas'
 , nsBlockNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsBlockNode.pas'
 , nsNativeCommentPara in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsNativeCommentPara.pas'
 , nsLeafParaDecorationsHolder in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsLeafParaDecorationsHolder.pas'
 , f1ChildMaker in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1ChildMaker.pas'
 , nsCommentStorer in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCommentStorer.pas'
 , evCommentPara_Wrap in 'w:\common\components\gui\Garant\Everest\evCommentPara_Wrap.pas'
 , nsCommentMemoryStream in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCommentMemoryStream.pas'
 , LegalDomain_DocumentNotifications_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\LegalDomain_DocumentNotifications_Controls.pas'
 , f1DocumentTagDataFromDTP in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1DocumentTagDataFromDTP.pas'
 , f1TagDataFromDTP in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataFromDTP.pas'
 , nsCommentModifier in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCommentModifier.pas'
 , nsParaModifier in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParaModifier.pas'
 , f1TagDataFromDTPFactory in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataFromDTPFactory.pas'
 , f1LeafTagDataFromDTP in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1LeafTagDataFromDTP.pas'
 , f1ListTagDataFromDTP in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1ListTagDataFromDTP.pas'
 , f1DocumentTagDataFromDTPHandle in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1DocumentTagDataFromDTPHandle.pas'
 , AutoreferatDocument_Const in 'w:\common\components\gui\Garant\Everest\AutoreferatDocument_Const.pas'
 , nsAnnotationHeaderTagNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\nsAnnotationHeaderTagNode.pas'
 , nsAnnotationHeaderTagData in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\nsAnnotationHeaderTagData.pas'
 , nsF1AutoreferatDocumentTagNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\nsF1AutoreferatDocumentTagNode.pas'
 , nsIDocumentDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsIDocumentDataObject.pas'
 , evHolderDataObject in 'w:\common\components\gui\Garant\Everest\evHolderDataObject.pas'
 , nsDocumentToolsNew in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentToolsNew.pas'
 , nsDocumentPrintEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentPrintEvent.pas'
 , deDocInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\deDocInfo.pas'
 , deBase in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\deBase.pas'
 , bsBase in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\bsBase.pas'
 , bsDataContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\bsDataContainer.pas'
 , nsDocInfoHAFMacroReplacer in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocInfoHAFMacroReplacer.pas'
 , dsNewsLine in 'w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\dsNewsLine.pas'
 , dBaseDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocument.pas'
 , PrimNewsLine_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLine_Form.pas'
 , PrimeInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\PrimeInterfaces.pas'
 , Base_Operations_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Strange_Controls.pas'
 , Base_Operations_Editions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Editions_Controls.pas'
 , nscTreeViewForNewsLine in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Tree\nscTreeViewForNewsLine.pas'
 , nsNewsLine in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\nsNewsLine.pas'
 , DocumentUserTypes_dftAutoreferat_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferat_UserType.pas'
 , DocumentUserTypes_dftMedDictEntry_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedDictEntry_UserType.pas'
 , DocumentUserTypes_dftTips_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTips_UserType.pas'
 , DocumentUserTypes_dftAnnotationSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAnnotationSynchroView_UserType.pas'
 , DocumentUserTypes_dftTranslation_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTranslation_UserType.pas'
 , DocumentUserTypes_dftConsultation_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftConsultation_UserType.pas'
 , DocumentUserTypes_dftAutoreferatAfterSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferatAfterSearch_UserType.pas'
 , DocumentUserTypes_dftAnnotation_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAnnotation_UserType.pas'
 , DocumentUserTypes_dftDictSubEntry_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDictSubEntry_UserType.pas'
 , DocumentUserTypes_dftDictEntry_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDictEntry_UserType.pas'
 , DocumentUserTypes_dftRelatedSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedSynchroView_UserType.pas'
 , DocumentUserTypes_dftDocSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDocSynchroView_UserType.pas'
 , DocumentUserTypes_dftRelatedDoc_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedDoc_UserType.pas'
 , DocumentUserTypes_dftDocument_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDocument_UserType.pas'
 , DocumentUserTypes_dftNone_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftNone_UserType.pas'
 {$If NOT Defined(NoScripts)}
 , PrimMonitoringsWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrimMonitoringsWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimNewsLine_nltMain_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLine_nltMain_UserType.pas'
 , CommonPost_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\CommonPost_Module.pas'
 , PostingOrder_FormDefinitions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_FormDefinitions_Controls.pas'
 {$If NOT Defined(NoVCL)}
 , FileCtrl {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\FileCtrl.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , nsFindSelectDialog in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\nsFindSelectDialog.pas'
 , PostingsList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PostingsList_Form.pas'
 , PrimPostingsListOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsListOptions_Form.pas'
 , PrimPostingsList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_Form.pas'
 , vtSaveDialog in 'w:\common\components\gui\Garant\VT\vtSaveDialog.pas'
 , PrimPostingsList_MyPostingList_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_MyPostingList_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PostingsListKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PostingsListKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , NewsLine_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NewsLine_Form.pas'
 , PrimNewsLineOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLineOptions_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , NewsLineKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NewsLineKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsAutoreferat in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsAutoreferat.pas'
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactory.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactoryPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParamsList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetRefreshParamsList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormsCollection in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormsCollectionPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormsCollectionPrimPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionPrimPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormsCollectionItemPrim in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemPrim.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormsCollectionItemModelPart in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemModelPart.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFormsCollectionItem in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItem.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSet in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSet.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshDataParamsList in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefreshDataParamsList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParams in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefreshParams.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetDataSource in 'w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryFacade in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactoryFacade.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormDataSourceList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmZoneTypeList in 'w:\common\components\gui\Garant\VCM\implementation\vcmZoneTypeList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , fsAutoreferatAfterSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsAutoreferatAfterSearch.pas'
 , Base_Operations_F1Services_Contracts in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_F1Services_Contracts.pas'
 , ChatTypes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChatTypes.pas'
 , ChatInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChatInterfaces.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainWindowKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainWindowKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , WorkJournalInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournalInterfaces.pas'
 , UserJournalUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\UserJournalUnit.pas'
 , EditionsInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\EditionsInterfaces.pas'
 , DocumentDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Model\DocumentDomainInterfaces.pas'
 , ConsultationDomainInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\ConsultationDomainInterfaces.pas'
 , moCompareEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moCompareEditions.pas'
 , BaseEditions_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\BaseEditions_Module.pas'
 , sdsCompareEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\sdsCompareEditions.pas'
 , dsEditionsContainerData in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsEditionsContainerData.pas'
 , dsRightEdition in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsRightEdition.pas'
 , nsEditionNodes in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsEditionNodes.pas'
 , evNodePainter in 'w:\common\components\gui\Garant\Everest\evNodePainter.pas'
 , nevNodeView in 'w:\common\components\gui\Garant\Everest\nevNodeView.pas'
 {$If Defined(Nemesis)}
 , f1TextStyle_Const in 'w:\common\components\gui\Garant\Everest_Engine\f1TextStyle_Const.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsEditionFromDTPDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsEditionFromDTPDocumentContainer.pas'
 , nsF1DocumentContainerPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsF1DocumentContainerPrim.pas'
 , nsTagNodeToolsNew in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodeToolsNew.pas'
 , nsTagNodeTools in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodeTools.pas'
 , nsDocumentContainerSub in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainerSub.pas'
 , nsSubPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsSubPrim.pas'
 , dsLeftEdition in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\dsLeftEdition.pas'
 , nsEditionDiffData in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsEditionDiffData.pas'
 , nsCompareEditionsInfoPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsCompareEditionsInfoPrim.pas'
 , nsRedactionCurrentPara in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsRedactionCurrentPara.pas'
 , nsEditionsContainerData in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsEditionsContainerData.pas'
 , sdsCompareEditionsState in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\sdsCompareEditionsState.pas'
 , dsEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsEditions.pas'
 , nsCompareEditionsInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsCompareEditionsInfo.pas'
 , LeftEdition_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\LeftEdition_Form.pas'
 , PrimLeftEdition_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimLeftEdition_Form.pas'
 , DiffOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\DiffOptions_Form.pas'
 , Diff_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\Diff_Form.pas'
 , CompareEditions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\CompareEditions_Controls.pas'
 , NavigationInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\View\NavigationInterfaces.pas'
 {$If Defined(Nemesis)}
 , nscEditor in 'w:\common\components\gui\Garant\Nemesis\nscEditor.pas'
 {$IfEnd} // Defined(Nemesis)
 , eeEditor in 'w:\common\components\gui\Garant\Everest_Engine\eeEditor.pas'
 , eeEditorExport in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExport.pas'
 , eeEditorExportModelPart in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorExportModelPart.pas'
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
 , Base_Operations_View_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_View_Controls.pas'
 , Base_Operations_F1Specific_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_F1Specific_Controls.pas'
 {$If Defined(Nemesis)}
 , nscTextSource in 'w:\common\components\gui\Garant\Nemesis\nscTextSource.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeTextSource in 'w:\common\components\gui\Garant\Everest_Engine\eeTextSource.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsFoundBlocksList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFoundBlocksList.pas'
 , evSubWaiter in 'w:\common\components\gui\Garant\Everest\new\evSubWaiter.pas'
 , DocumentRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\DocumentRes.pas'
 {$If NOT Defined(NoScripts)}
 , DiffFormWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\DiffFormWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsHyperLinkProcessor in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsHyperLinkProcessor.pas'
 , bsHyperLinkProcessorPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\View\bsHyperLinkProcessorPrim.pas'
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
 , IniFiles {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\IniFiles.pas' {$EndIf}
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
 , l3EtalonsService in 'w:\common\components\rtl\Garant\L3\l3EtalonsService.pas'
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
 , l3CardinalList in 'w:\common\components\rtl\Garant\L3\l3CardinalList.pas'
 {$If NOT Defined(NoScripts)}
 , tfwDebugScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDebugScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDebugService in 'w:\common\components\rtl\Garant\ScriptEngine\tfwDebugService.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwF1HyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwF1HyperlinkScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwHyperlinkScriptCaller in 'w:\common\components\rtl\Garant\ScriptEngine\tfwHyperlinkScriptCaller.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , bsDocumentMissingMessage in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\bsDocumentMissingMessage.pas'
 , nsExternalObjectData in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsExternalObjectData.pas'
 , nsENOIntegration in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsENOIntegration.pas'
 , WarningConst in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WarningConst.pas'
 , nsHyperlinkProcessorTypes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsHyperlinkProcessorTypes.pas'
 , bsHyperlinkProcessorContainerMaker in 'w:\garant6x\implementation\Garant\GbaNemesis\View\bsHyperlinkProcessorContainerMaker.pas'
 , nsOpenDocumentFromLinkEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsOpenDocumentFromLinkEvent.pas'
 , nsTryingToOpenMissingDocumentFromLinkEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsTryingToOpenMissingDocumentFromLinkEvent.pas'
 {$If NOT Defined(NoScripts)}
 , F1ScriptEngine in 'w:\garant6x\implementation\Garant\GbaNemesis\ScriptEngine\F1ScriptEngine.pas'
 {$IfEnd} // NOT Defined(NoScripts)
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
 {$If NOT Defined(NoScripts)}
 , kwAttributeSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwAttributeSearch.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwMainMenu in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwMainMenu.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwOk in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwOk.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwOpenDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwOpenDocument.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , f1WordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\f1WordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwDocumentsCacheClear in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwDocumentsCacheClear.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwTimeMachineSetDate in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwTimeMachineSetDate.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwExportHelp in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwExportHelp.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwFiltersList in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwFiltersList.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwF1BaseDate in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwF1BaseDate.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwF1ComplectName in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwF1ComplectName.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwF1ComplectOwner in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwF1ComplectOwner.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwRestoreSettings in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwRestoreSettings.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsConfigurationList in 'w:\garant6x\implementation\Garant\GbaNemesis\Config\nsConfigurationList.pas'
 {$If NOT Defined(NoScripts)}
 , kwClearDocumentContextSearchHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwClearDocumentContextSearchHistory.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwClearContextSearchHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwClearContextSearchHistory.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwClearPharmContextSearchHistory in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwClearPharmContextSearchHistory.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIsPharmPermanentFilterExists in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIsPharmPermanentFilterExists.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwPermanentFilterExists in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwPermanentFilterExists.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIsLegalPermanentFilterExists in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIsLegalPermanentFilterExists.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIsMyDocumentsEmpty in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIsMyDocumentsEmpty.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationsGetCount in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsGetCount.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationsWord in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationsGetConfiguration in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsGetConfiguration.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationGetName in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationGetName.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationWord in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationGetType in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationGetType.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationsGetActiveConfiguration in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsGetActiveConfiguration.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationActivate in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationActivate.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwConfigurationGetID in 'w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationGetID.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsTabbedContainerUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\TabInterface\nsTabbedContainerUtils.pas'
 , nsExportToFileEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsExportToFileEvent.pas'
 , nsExportToWordEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsExportToWordEvent.pas'
 , nsSendDocumentByEMailEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsSendDocumentByEMailEvent.pas'
 , nsDocumentPrintPreviewEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsDocumentPrintPreviewEvent.pas'
 , nsBaseTextOperationsConst in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsBaseTextOperationsConst.pas'
 , f1MultilinkResolver in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\f1MultilinkResolver.pas'
 , nsSaveDialogExecutor in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSaveDialogExecutor.pas'
 , nsSaveDialog in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSaveDialog.pas'
 {$If Defined(Nemesis)}
 , eeGroupBox in 'w:\common\components\gui\Garant\Nemesis\eeGroupBox.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , CommDlg {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CommDlg.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , nsSaveDialogImpl in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSaveDialogImpl.pas'
 {$IfEnd} // Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SaveDialogWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\SaveDialogWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(Nemesis)}
 , eeParaTools in 'w:\common\components\gui\Garant\Everest_Engine\eeParaTools.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsDocumentTools in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsDocumentTools.pas'
 , nsDocumentPreviewWithoutBlockNames in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDocumentPreviewWithoutBlockNames.pas'
 , nsToMSWordOp in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\nsToMSWordOp.pas'
 , Common_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common_Strange_Controls.pas'
 , bsDocumentContextSearcher in 'w:\garant6x\implementation\Garant\GbaNemesis\View\bsDocumentContextSearcher.pas'
 , nsContextSearchParams in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsContextSearchParams.pas'
 , nsFindIteratorNew in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNew.pas'
 , l3ProtoObjectForTie in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectForTie.pas'
 , nsFindIteratorNewFindPositionList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNewFindPositionList.pas'
 , nsFindIteratorNewForAutoreferat in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNewForAutoreferat.pas'
 , nsFindIteratorNewForDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNewForDiction.pas'
 , nsFindPositionListList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindPositionListList.pas'
 , DictEntry_Const in 'w:\common\components\gui\Garant\Everest\DictEntry_Const.pas'
 , DictEntryBlock_Const in 'w:\common\components\gui\Garant\Everest\DictEntryBlock_Const.pas'
 , nsContextListForSearchViaEverestOwnSearcher in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsContextListForSearchViaEverestOwnSearcher.pas'
 , nsFragmentListForSearchViaEverestOwnSearcher in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFragmentListForSearchViaEverestOwnSearcher.pas'
 , nsFoundRangeCollector in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsFoundRangeCollector.pas'
 , nsSearchInDocumentEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentEvent.pas'
 , nsSearchInDocumentDoneEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentDoneEvent.pas'
 , nsSearchInDocumentNextEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentNextEvent.pas'
 , nsSearchInDocumentPrevEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsSearchInDocumentPrevEvent.pas'
 , nsSearchWindowManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\nsSearchWindowManager.pas'
 , EditionsRes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsRes_Form.pas'
 , PrimEditionsRes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsRes_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , EditionsResKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsResKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , nsEditionsUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsEditionsUtils.pas'
 , PrimLeftEdition_utLeftEdition_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimLeftEdition_utLeftEdition_UserType.pas'
 , CompareEditions_FormDefinitions_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\CompareEditions_FormDefinitions_Controls.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LeftEditionKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\LeftEditionKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , RightEdition_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\RightEdition_Form.pas'
 , PrimRightEdition_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimRightEdition_Form.pas'
 , PrimRightEdition_utRightEdition_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RightEditionKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\RightEditionKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , EditionsContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsContainer_Form.pas'
 , PrimEditionsContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsContainer_Form.pas'
 , PrimEditionsContainer_utEditionsContainer_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsContainer_utEditionsContainer_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , EditionsContainerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsContainerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsCompareEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\fsCompareEditions.pas'
 , moInternetAgent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moInternetAgent.pas'
 , PrimInternetAgent_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\PrimInternetAgent_Module.pas'
 , sdsInternetAgent in 'w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\sdsInternetAgent.pas'
 , InternetAgentInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\InternetAgentInterfaces.pas'
 , dsInternetAgent in 'w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\dsInternetAgent.pas'
 , InternetAgent_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\InternetAgent_Form.pas'
 , PrimInternetAgent_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\PrimInternetAgent_Form.pas'
 , nsWebBrowser in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\nsWebBrowser.pas'
 , nsWebBrowserPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\nsWebBrowserPrim.pas'
 , shdocvw {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Internet\shdocvw.pas' {$EndIf}
 {$If NOT Defined(NoVCL)}
 , OleCtrls {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\OleCtrls.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 , nsWebBrowserHelper in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\nsWebBrowserHelper.pas'
 , Variants
 , UrlMon {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\UrlMon.pas' {$EndIf}
 {$If Defined(Nemesis)}
 , nsInternetUtils in 'w:\common\components\gui\Garant\Nemesis\nsInternetUtils.pas'
 {$IfEnd} // Defined(Nemesis)
 , l3RegEx in 'w:\common\components\rtl\Garant\L3\l3RegEx.pas'
 , PrimInternetAgent_utInternetAgent_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\PrimInternetAgent_utInternetAgent_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , InternetAgentKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\InternetAgentKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsInternetAgent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\fsInternetAgent.pas'
 , moFolders in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moFolders.pas'
 , PrimFolders_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\PrimFolders_Module.pas'
 , FoldersInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Folders\FoldersInterfaces.pas'
 , PrimFoldersTree_utSaveOpen_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utSaveOpen_UserType.pas'
 , PrimFoldersTree_utFoldersTree_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas'
 , Folders_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Strange_Controls.pas'
 , sdsFolders in 'w:\garant6x\implementation\Garant\GbaNemesis\Folders\sdsFolders.pas'
 , dsFolders in 'w:\garant6x\implementation\Garant\GbaNemesis\Folders\dsFolders.pas'
 , dsFoldersTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Folders\dsFoldersTree.pas'
 , bsConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\bsConsultation.pas'
 , dsFolderElement in 'w:\garant6x\implementation\Garant\GbaNemesis\Folders\dsFolderElement.pas'
 , deSaveObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Folders\deSaveObject.pas'
 , nsFormCoordinates in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\nsFormCoordinates.pas'
 , Folders_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\Folders_Form.pas'
 , PrimFoldersOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersOptions_Form.pas'
 , PrimFolders_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFolders_Form.pas'
 , Folders_Result_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Result_Controls.pas'
 , PrimFolders_utFolders_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFolders_utFolders_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FoldersKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsFolders in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\fsFolders.pas'
 , PrimFoldersElementInfo_utFoldersProperty_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfo_utFoldersProperty_UserType.pas'
 , FoldersInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersInfo_Form.pas'
 , PrimFoldersInfoOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfoOptions_Form.pas'
 , PrimFoldersInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfo_Form.pas'
 , PrimFoldersInfo_utFoldersInfoContainer_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfo_utFoldersInfoContainer_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FoldersInfoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersInfoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , FoldersTree_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersTree_Form.pas'
 , PrimFoldersTreeOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTreeOptions_Form.pas'
 , PrimFoldersTree_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_Form.pas'
 , FoldersRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\FoldersRes.pas'
 , nsFolderNodes in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsFolderNodes.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FoldersTreeKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersTreeKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , FoldersElementInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersElementInfo_Form.pas'
 , PrimFoldersElementInfoOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfoOptions_Form.pas'
 , PrimFoldersElementInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfo_Form.pas'
 , eeMemoWithEditOperations in 'w:\common\components\gui\Garant\Everest_Engine\eeMemoWithEditOperations.pas'
 , eeMemo in 'w:\common\components\gui\Garant\Everest_Engine\eeMemo.pas'
 , nsSaveQueryEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\nsSaveQueryEvent.pas'
 , nsSaveDocumentToFoldersEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\nsSaveDocumentToFoldersEvent.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FoldersElementInfoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersElementInfoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moChat in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moChat.pas'
 , BaseChat_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\BaseChat_Module.pas'
 , PrimContactList_chatAddContact_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatAddContact_UserType.pas'
 , PrimContactList_chatContacts_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatContacts_UserType.pas'
 , BaseHistoryWindow_utChatHistory_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseHistoryWindow_utChatHistory_UserType.pas'
 , BaseChatWindow_cwChat_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_cwChat_UserType.pas'
 , bsChatDispatcher in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\bsChatDispatcher.pas'
 , bsChatDispatcherPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\bsChatDispatcherPrim.pas'
 , nsChatWindowList in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatWindowList.pas'
 , nsBaseChatWindowList in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsBaseChatWindowList.pas'
 , nsUserIDList in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsUserIDList.pas'
 , nsChatHistoryList in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatHistoryList.pas'
 , nsBaseChatHistoryList in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsBaseChatHistoryList.pas'
 , nsContactListNotifiers in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsContactListNotifiers.pas'
 , nsCounterEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsCounterEvent.pas'
 , ChatInterfacesUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ChatInterfacesUnit.pas'
 , NotifyUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\NotifyUnit.pas'
 , nsChatTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatTreeStruct.pas'
 , nsUserTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserTreeStruct.pas'
 , nsUserFlagsFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserFlagsFilters.pas'
 , nsUserFlagsFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserFlagsFilter.pas'
 , nsGroupFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsGroupFilter.pas'
 , nsChatMessages in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatMessages.pas'
 , nsChatMessage in 'w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatMessage.pas'
 , nsNotifiers in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsNotifiers.pas'
 , ContactList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ContactList_Form.pas'
 , PrimContactListOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactListOptions_Form.pas'
 , PrimContactList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_Form.pas'
 , Base_Operations_Chat_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Chat_Controls.pas'
 , ChatRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ChatRes.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ContactListKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ContactListKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ChatWindow_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatWindow_Form.pas'
 , BaseChatWindowOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindowOptions_Form.pas'
 , BaseChatWindow_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_Form.pas'
 , AbstractHistory_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\AbstractHistory_Form.pas'
 {$If Defined(Nemesis)}
 , nscChatMemo in 'w:\common\components\gui\Garant\Nemesis\nscChatMemo.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscCustomChatMemo in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemo.pas'
 {$IfEnd} // Defined(Nemesis)
 , evCustomChatMemo in 'w:\common\components\gui\Garant\Everest\evCustomChatMemo.pas'
 {$If Defined(Nemesis)}
 , nscCustomChatMemoTextSource in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoTextSource.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscCustomChatMemoContainer in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoContainer.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscCustomChatMemoDocumentPartGenerator in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoDocumentPartGenerator.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscCustomChatMemoProcessor in 'w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoProcessor.pas'
 {$IfEnd} // Defined(Nemesis)
 , evdAllDocumentSubsEliminator in 'w:\common\components\rtl\Garant\EVD\evdAllDocumentSubsEliminator.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChatWindowKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatWindowKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ChatHistory_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatHistory_Form.pas'
 , BaseHistoryWindow_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseHistoryWindow_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChatHistoryKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatHistoryKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moWorkJournal in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moWorkJournal.pas'
 , BaseWorkJournal_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\BaseWorkJournal_Module.pas'
 , PrimWorkJournal_utWorkJournal_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_utWorkJournal_UserType.pas'
 , bsWorkJournal in 'w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\bsWorkJournal.pas'
 , bsWorkJournalPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\bsWorkJournalPrim.pas'
 , nsWorkJournalListeners in 'w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\nsWorkJournalListeners.pas'
 , nsJournalTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\nsJournalTreeStruct.pas'
 , WorkJournal_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\WorkJournal_Form.pas'
 , PrimWorkJournalOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournalOptions_Form.pas'
 , PrimWorkJournal_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_Form.pas'
 , WorkJournal_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal_Strange_Controls.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , WorkJournalKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\WorkJournalKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moMonitorings in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moMonitorings.pas'
 , moCommon in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moCommon.pas'
 , PrimF1Common_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\PrimF1Common_Module.pas'
 , PrimTasksPanel_tpMain_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas'
 , NavigatorUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\NavigatorUtils.pas'
 , RememberPassword_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPassword_Form.pas'
 , PrimRememberPassword_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimRememberPassword_Form.pas'
 , RememberPassword_ut_RememberPassword_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPassword_ut_RememberPassword_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RememberPasswordKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPasswordKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ProgressIndicator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\ProgressIndicator_Form.pas'
 , PrimProgressIndicator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimProgressIndicator_Form.pas'
 , PrimProgressIndicator_utProgressIndicator_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimProgressIndicator_utProgressIndicator_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ProgressIndicatorKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\ProgressIndicatorKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , EULA_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_Form.pas'
 , PrimEULA_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimEULA_Form.pas'
 , EULA_ut_EULA_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_ut_EULA_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , EULAKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULAKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , About_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\About_Form.pas'
 , ComplectUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\ComplectUnit.pas'
 , About_ut_About_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\About_ut_About_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AboutKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\AboutKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , CompInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_Form.pas'
 , PrimCompInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimCompInfo_Form.pas'
 , nsComplectInfoTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsComplectInfoTreeStruct.pas'
 , nsComplectInfoRootNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsComplectInfoRootNode.pas'
 , nsComplectInfoNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsComplectInfoNode.pas'
 , ComplectInfoRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\ComplectInfoRes.pas'
 , Gauges {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Samples\Gauges.pas' {$EndIf}
 , vtGauge in 'w:\common\components\gui\Garant\VT\vtGauge.pas'
 , CompInfo_ut_CompInfo_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_ut_CompInfo_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CompInfoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Registration_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\Registration_Form.pas'
 , PrimRegistration_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimRegistration_Form.pas'
 , RegistrationForm_ut_RegistrationForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RegistrationForm_ut_RegistrationForm_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RegistrationFormKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RegistrationFormKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , TasksPanel_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TasksPanel_Form.pas'
 , PrimTasksPanel_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_Form.pas'
 {$If Defined(Nemesis)}
 , nscTasksPanelView in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelView.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscInterfaces.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscHideField in 'w:\common\components\gui\Garant\Nemesis\nscHideField.pas'
 {$IfEnd} // Defined(Nemesis)
 , vtHideField in 'w:\common\components\gui\Garant\VT\vtHideField.pas'
 , vtHideFieldTypes in 'w:\common\components\gui\Garant\VT\vtHideFieldTypes.pas'
 , vtHideFieldUtils in 'w:\common\components\gui\Garant\VT\vtHideFieldUtils.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtHideFieldWords in 'w:\common\components\rtl\Garant\ScriptEngine\vtHideFieldWords.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , vtSpeedButton in 'w:\common\components\gui\Garant\VT\vtSpeedButton.pas'
 {$If Defined(Nemesis)}
 , nscTasksPanelRootNode in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelRootNode.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTaskPanelInterfaces in 'w:\common\components\gui\Garant\Nemesis\nscTaskPanelInterfaces.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelActionLink in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelActionLink.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelOperationNode in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelOperationNode.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscArrangeGridCell in 'w:\common\components\gui\Garant\Nemesis\nscArrangeGridCell.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTabTableCell in 'w:\common\components\gui\Garant\Nemesis\nscTabTableCell.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscArrangeGrid in 'w:\common\components\gui\Garant\Nemesis\nscArrangeGrid.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTabTable in 'w:\common\components\gui\Garant\Nemesis\nscTabTable.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
 , TaskPanelWords in 'w:\common\components\rtl\Garant\ScriptEngine\TaskPanelWords.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TasksPanelKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TasksPanelKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Navigator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\Navigator_Form.pas'
 , PrimNavigatorOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigatorOptions_Form.pas'
 , PrimNavigator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigator_Form.pas'
 , NavigatorRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\NavigatorRes.pas'
 , nsNavigatorTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsNavigatorTreeStruct.pas'
 , PrimNavigator_utNavigator_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigator_utNavigator_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , NavigatorKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\NavigatorKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , TurnOffTimeMachine_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachine_Form.pas'
 , PrimTurnOffTimeMachineOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTurnOffTimeMachineOptions_Form.pas'
 , PrimTurnOffTimeMachine_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTurnOffTimeMachine_Form.pas'
 , TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TurnOffTimeMachineKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachineKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , nsDataExchangeRealization in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDataExchangeRealization.pas'
 , deListSet in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deListSet.pas'
 , deDocumentList in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deDocumentList.pas'
 , deList in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\deList.pas'
 , deSearchInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\deSearchInfo.pas'
 , moDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moDocument.pas'
 , Document_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Document_Module.pas'
 , Document_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document_Strange_Controls.pas'
 , DocumentShowChangesInfoSettingRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\DocumentShowChangesInfoSettingRes.pas'
 , stDocumentShowChangesInfoItem in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\stDocumentShowChangesInfoItem.pas'
 , ddAppConfigTypes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypes.pas'
 , ddConfigStorages in 'w:\common\components\rtl\Garant\dd\ddConfigStorages.pas'
 , ddAppConfigConst in 'w:\common\components\rtl\Garant\dd\ddAppConfigConst.pas'
 , ddAppConfigBase in 'w:\common\components\rtl\Garant\dd\ddAppConfigBase.pas'
 , l3ProtoPersistentRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentRefList.pas'
 , Contnrs {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Contnrs.pas' {$EndIf}
 , ddAppConfigTypesRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas'
 {$If NOT Defined(NoVCL)}
 , CheckLst {$IfNDef XE4} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\CheckLst.pas' {$EndIf}
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CheckListBoxWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ddAppConfigRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas'
 , sdsDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.pas'
 , dDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\dDocument.pas'
 , bsUserCRListInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\bsUserCRListInfo.pas'
 , bsFrozenNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\bsFrozenNode.pas'
 , dsDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocument.pas'
 , nsF1DocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsF1DocumentContainer.pas'
 , nsMedicContentsTree in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsMedicContentsTree.pas'
 , nsContentsTree in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsContentsTree.pas'
 , nsContentsNode in 'w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsContentsNode.pas'
 , evdHyperlinkInfo in 'w:\common\components\rtl\Garant\EVD\evdHyperlinkInfo.pas'
 , dsDocumentListCRToPart in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\dsDocumentListCRToPart.pas'
 , dsDocumentListCR in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentListCR.pas'
 , ListRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\ListRes.pas'
 , bsConst in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\bsConst.pas'
 , nsAddToListEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsAddToListEvent.pas'
 , nsListSortEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsListSortEvent.pas'
 , nsFindContextInListEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsFindContextInListEvent.pas'
 , nsINodesClipboardDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsINodesClipboardDataObject.pas'
 , nsIListDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsIListDataObject.pas'
 , nsDocumentStreamWrapper in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentStreamWrapper.pas'
 , evMultiDocumentPreview in 'w:\common\components\gui\Garant\Everest\evMultiDocumentPreview.pas'
 , afwMultiDocumentPreview in 'w:\common\components\gui\Garant\AFW\implementation\Visual\afwMultiDocumentPreview.pas'
 , afwDocumentPreviewList in 'w:\common\components\gui\Garant\AFW\implementation\afwDocumentPreviewList.pas'
 , evHTMLDataObject in 'w:\common\components\gui\Garant\Everest\evHTMLDataObject.pas'
 , ddHTMLReader in 'w:\common\components\rtl\Garant\dd\ddHTMLReader.pas'
 , nsSuperComplexDocumentPreview in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSuperComplexDocumentPreview.pas'
 , bsListTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\bsListTreeStruct.pas'
 , bsListDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\bsListDataObject.pas'
 , nsNodesDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsNodesDataObject.pas'
 , nsNodesInterfacedDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsNodesInterfacedDataObject.pas'
 , bsListTreeData in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\bsListTreeData.pas'
 , nsListHAFMacroReplacer in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsListHAFMacroReplacer.pas'
 , nsListPrintEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsListPrintEvent.pas'
 , nsTreeMultiDocumentPreviewContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsTreeMultiDocumentPreviewContainer.pas'
 , nsListExceptions in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsListExceptions.pas'
 , nsFiltersUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersUtils.pas'
 , nsDocumentWithSnippetList in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentWithSnippetList.pas'
 , nsDocumentWithSnippetNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentWithSnippetNode.pas'
 , deDocumentListCR in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deDocumentListCR.pas'
 , dsContents in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsContents.pas'
 , dsBaseContentsRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContentsRes.pas'
 , ControlStatusUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\ControlStatusUtils.pas'
 , nsDocumentWarningGenerator in 'w:\garant6x\implementation\Garant\GbaNemesis\PrimListAndDocumentControllers\nsDocumentWarningGenerator.pas'
 , dsTranslationWarning in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\dsTranslationWarning.pas'
 , dsCRWarning in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\dsCRWarning.pas'
 , nsListWarningGenerator in 'w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.pas'
 , dsDocumentList in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.pas'
 , dsAnnotation in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsAnnotation.pas'
 , dsChildDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsChildDocument.pas'
 , nsChildDocInfoHAFMacroReplacer in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsChildDocInfoHAFMacroReplacer.pas'
 , dsDocumentWithFlash in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentWithFlash.pas'
 , dsTranslation in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsTranslation.pas'
 , dsRelatedDoc in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsRelatedDoc.pas'
 , dsChronology in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsChronology.pas'
 , nsChronologyDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsChronologyDocumentContainer.pas'
 , dsAttributes in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsAttributes.pas'
 , nsDocAttributeTreeStruct in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsDocAttributeTreeStruct.pas'
 , sdsDocumentWithFlash in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocumentWithFlash.pas'
 , nsOpenDocOnNumberData in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsOpenDocOnNumberData.pas'
 , DocumentWithFlash_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocumentWithFlash_Form.pas'
 , PrimDocumentWithFlashOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlashOptions_Form.pas'
 , PrimDocumentWithFlash_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlash_Form.pas'
 {$If NOT Defined(NoFlash)}
 , vtShockwaveFlashEx in 'w:\common\components\gui\Garant\VT\vtShockwaveFlashEx.pas'
 {$IfEnd} // NOT Defined(NoFlash)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , vtFlashWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\vtFlashWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Hypertext_Controls_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\Hypertext_Controls_Controls.pas'
 , DocumentWithFlashUserTypes_dwftSynchro_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftSynchro_UserType.pas'
 , DocumentWithFlashUserTypes_dwftMain_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftMain_UserType.pas'
 , FlashUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\FlashUtils.pas'
 , nsDocumentFromListNavigationEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsDocumentFromListNavigationEvent.pas'
 {$If Defined(Nemesis)}
 , nscStatusBarDelimiterDef in 'w:\common\components\gui\Garant\Nemesis\nscStatusBarDelimiterDef.pas'
 {$IfEnd} // Defined(Nemesis)
 , DocumentUtil in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUtil.pas'
 , evConstStringData in 'w:\common\components\gui\Garant\EverestCommon\evConstStringData.pas'
 , evConstStringDataObject in 'w:\common\components\gui\Garant\Everest\evConstStringDataObject.pas'
 , evConstStringStorable in 'w:\common\components\gui\Garant\Everest\evConstStringStorable.pas'
 , evdTextToFirstParaAdder in 'w:\common\components\rtl\Garant\EVD\evdTextToFirstParaAdder.pas'
 , nsHyperlinkToDocumentProducerConst in 'w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\nsHyperlinkToDocumentProducerConst.pas'
 , evBitmapDataObject in 'w:\common\components\gui\Garant\Everest\evBitmapDataObject.pas'
 , nsObjectPreview in 'w:\garant6x\implementation\Garant\GbaNemesis\Printing\nsObjectPreview.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DocumentWithFlashKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocumentWithFlashKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Text_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Text_Form.pas'
 , ExTextOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\ExTextOptions_Form.pas'
 , ExText_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\ExText_Form.pas'
 , Document_F1Lite_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document_F1Lite_Controls.pas'
 , DictionInterfacesPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\DictionInterfacesPrim.pas'
 , InpharmInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\InpharmInterfaces.pas'
 , nevContainers in 'w:\common\components\gui\Garant\Everest\nevContainers.pas'
 , eeSubPanel in 'w:\common\components\gui\Garant\Everest_Engine\eeSubPanel.pas'
 , eeSubPanelExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubPanelExport.pas'
 , evSubPanel in 'w:\common\components\gui\Garant\Everest\evSubPanel.pas'
 , l3ProtoPersistentWithHandle in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandle.pas'
 , l3ProtoPersistentWithHandleRefList in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandleRefList.pas'
 , l3ProtoPersistentWithHandleRefListPrim in 'w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandleRefListPrim.pas'
 , evSubPanelSub in 'w:\common\components\gui\Garant\Everest\evSubPanelSub.pas'
 , evLinkedToolPanel in 'w:\common\components\gui\Garant\Everest\evLinkedToolPanel.pas'
 , evToolPanel in 'w:\common\components\gui\Garant\Everest\evToolPanel.pas'
 , evVisualInterfaces in 'w:\common\components\gui\Garant\Everest\evVisualInterfaces.pas'
 , evSubPanelSubCollection in 'w:\common\components\gui\Garant\Everest\evSubPanelSubCollection.pas'
 , evSubPanelSubCollectionPrim in 'w:\common\components\gui\Garant\Everest\evSubPanelSubCollectionPrim.pas'
 , evSubPanelSubArray in 'w:\common\components\gui\Garant\Everest\evSubPanelSubArray.pas'
 , evSubPanelSubArrayPrim in 'w:\common\components\gui\Garant\Everest\evSubPanelSubArrayPrim.pas'
 , evSubPanelTools in 'w:\common\components\gui\Garant\Everest\evSubPanelTools.pas'
 , l3ProtoObjectWithHandle in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithHandle.pas'
 , evFont in 'w:\common\components\gui\Garant\Everest\evFont.pas'
 , l3ObjectWithHandleRefListPrim in 'w:\common\components\rtl\Garant\L3\l3ObjectWithHandleRefListPrim.pas'
 , evSubPn in 'w:\common\components\gui\Garant\Everest\evSubPn.pas'
 {$If NOT Defined(NoScripts)}
 , SubPanelWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\SubPanelWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIterateSubDescriptors in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDescriptors.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubPanelFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubPanelFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubdescriptorGetDrawType in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetDrawType.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubDescriptorFromStackWord in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubDescriptorFromStackWord.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubdescriptorGetBitmapIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetBitmapIndex.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubdescriptorGetBlockBitmapIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetBlockBitmapIndex.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubdescriptorGetDocumentBitmapIndex in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetDocumentBitmapIndex.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubdescriptorGetVisible in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetVisible.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubdescriptorGetColumn in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetColumn.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIterateSubDecriptorsOnSubPanel in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanel.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwIterateSubDecriptorsOnSubPanelEX in 'w:\common\components\rtl\Garant\ScriptEngine\kwIterateSubDecriptorsOnSubPanelEX.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwSubPanelGetPopupMenuForSub in 'w:\common\components\rtl\Garant\ScriptEngine\kwSubPanelGetPopupMenuForSub.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If Defined(Nemesis)}
 , eeSubDescriptorsExport in 'w:\common\components\gui\Garant\Everest_Engine\eeSubDescriptorsExport.pas'
 {$IfEnd} // Defined(Nemesis)
 , DocumentUserTypes_dftChronology_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftChronology_UserType.pas'
 , DocumentUserTypes_dftAACContentsRight_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsRight_UserType.pas'
 , DocumentUserTypes_dftAACContentsLeft_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsLeft_UserType.pas'
 , DocumentUserTypes_dftAACRight_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACRight_UserType.pas'
 , DocumentUserTypes_dftAACLeft_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACLeft_UserType.pas'
 , DocumentUserTypes_dftDrugSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrugSynchroView_UserType.pas'
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas'
 , DocumentUserTypes_dftMedicFirm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirm_UserType.pas'
 , DocumentUserTypes_dftDrug_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrug_UserType.pas'
 , bsChangeRedationWorker in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\bsChangeRedationWorker.pas'
 , nsSwitchVersionCommentsEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsSwitchVersionCommentsEvent.pas'
 , nsTextTabActivateEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsTextTabActivateEvent.pas'
 , nsUseDocumentSubPanelOperationEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsUseDocumentSubPanelOperationEvent.pas'
 , deSimpleTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deSimpleTree.pas'
 , nsInternalPictureData in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsInternalPictureData.pas'
 , Base_Operations_AAC_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_AAC_Controls.pas'
 , AACTextContainerPrim_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACTextContainerPrim_Form.pas'
 , AACContainerPrim_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_Form.pas'
 , AACContainerPrim_AACContainer_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContainer_UserType.pas'
 , AACContainerPrim_AACContentsContainer_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContentsContainer_UserType.pas'
 {$If NOT Defined(NoScripts)}
 , ExTextFormWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\ExTextFormWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , nsTimeMachineOffEvent in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\nsTimeMachineOffEvent.pas'
 , bsUtilsConst in 'w:\garant6x\implementation\Garant\GbaNemesis\Document\bsUtilsConst.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TextKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TextKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Redactions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Redactions_Form.pas'
 , PrimRedactionsOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimRedactionsOptions_Form.pas'
 , PrimRedactions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimRedactions_Form.pas'
 , RedactionsUserTypes_utRedaction_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes_utRedaction_UserType.pas'
 , nsEditionTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsEditionTree.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RedactionsKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\RedactionsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Contents_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Contents_Form.pas'
 , PrimContentsOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimContentsOptions_Form.pas'
 , PrimContents_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimContents_Form.pas'
 , ContentsUserTypes_utDrugContents_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utDrugContents_UserType.pas'
 , ContentsUserTypes_utContents_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utContents_UserType.pas'
 , nsContentsTreeStorable in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsContentsTreeStorable.pas'
 , evTreeStorable in 'w:\common\components\gui\Garant\Everest\evTreeStorable.pas'
 {$If Defined(Nemesis)}
 , nscTasksPanel in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanel.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmTasksPanel in 'w:\common\components\gui\Garant\VCM\implementation\vcmTasksPanel.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscTasksPanelGroupDescList in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupDescList.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelGroupsIterator in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupsIterator.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelGroup in 'w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroup.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsContentsListForFiltering in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsContentsListForFiltering.pas'
 , nevFlatSubsList in 'w:\common\components\gui\Garant\Everest\new\nevFlatSubsList.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ContentsKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\ContentsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\fsDocument.pas'
 , fsAbstractDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\View\fsAbstractDocument.pas'
 , AttributesUserTypes_fDocAttribute_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fDocAttribute_UserType.pas'
 , ListUserTypes_lftRespondent_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondent_UserType.pas'
 , ListUserTypes_lftNone_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftNone_UserType.pas'
 , ListUserTypes_lftCorrespondent_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCorrespondent_UserType.pas'
 , ListUserTypes_lftSimilarDocuments_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocuments_UserType.pas'
 , ListUserTypes_lftConsultation_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftConsultation_UserType.pas'
 , ListUserTypes_lftUserCR2_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCR2_UserType.pas'
 , ListUserTypes_lftUserCR1_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCR1_UserType.pas'
 , ListUserTypes_lftCToPart_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCToPart_UserType.pas'
 , ListUserTypes_lftSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSynchroView_UserType.pas'
 , ListUserTypes_lftRToPart_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRToPart_UserType.pas'
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas'
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftProducedDrugsSynchroForm_UserType.pas'
 , ListUserTypes_lftProducedDrugs_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftProducedDrugs_UserType.pas'
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugInternationalNameSynonyms_UserType.pas'
 , ListUserTypes_lftDrugList_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugList_UserType.pas'
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList2_SynchorForm_UserType.pas'
 , ListUserTypes_lftUserCRList1_SynchorForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList1_SynchorForm_UserType.pas'
 , ListUserTypes_lftRespondentsSynchroForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondentsSynchroForm_UserType.pas'
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCorrespondentsSynchroForm_UserType.pas'
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocumentsSynchroView_UserType.pas'
 , ListUserTypes_lftSimilarDocumentsToFragment_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocumentsToFragment_UserType.pas'
 , fsDocumentWithFlash in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\fsDocumentWithFlash.pas'
 , Picture_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Picture_Form.pas'
 , PrimPictureOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureOptions_Form.pas'
 , PrimPicture_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_Form.pas'
 {$If NOT Defined(NoImageEn)}
 , imageenproc in 'w:\common\components\rtl\external\ImageEn\src\imageenproc.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , giflzw in 'w:\common\components\rtl\external\ImageEn\src\giflzw.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 , PrimPicture_pfImage_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_pfImage_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PictureKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , PictureInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_Form.pas'
 , PrimPictureInfoOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureInfoOptions_Form.pas'
 , PrimPictureInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureInfo_Form.pas'
 , PictureInfo_ut_PictureInfo_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_ut_PictureInfo_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PictureInfoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , DocNumberQuery_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQuery_Form.pas'
 , PrimDocNumberQueryOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocNumberQueryOptions_Form.pas'
 , PrimDocNumberQuery_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocNumberQuery_Form.pas'
 , DocNumberQuery_ut_DocNumberQuery_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQuery_ut_DocNumberQuery_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DocNumberQueryKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQueryKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Warning_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Warning_Form.pas'
 , PrimDockedWarning_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDockedWarning_Form.pas'
 , PrimWarningOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningOptions_Form.pas'
 , PrimWarning_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarning_Form.pas'
 , nsWarningDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\View\nsWarningDocumentContainer.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , WarningKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\WarningKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Attributes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Attributes_Form.pas'
 , PrimAttributesOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimAttributesOptions_Form.pas'
 , PrimAttributes_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimAttributes_Form.pas'
 , nsSingleAttributeData in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSingleAttributeData.pas'
 , nsSingleAttributeDataObject in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSingleAttributeDataObject.pas'
 , nsSingleAttributeStorable in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSingleAttributeStorable.pas'
 , AttributesUserTypes_fAttributeSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fAttributeSynchroView_UserType.pas'
 , evTreeDataObject in 'w:\common\components\gui\Garant\Everest\evTreeDataObject.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AttributesKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\AttributesKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , SynchroView_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroView_Form.pas'
 , PrimSynchroViewOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimSynchroViewOptions_Form.pas'
 , PrimSynchroView_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimSynchroView_Form.pas'
 , SynchroViewUserTypes_svSynchroView_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes_svSynchroView_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SynchroViewKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroViewKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , TurnOnTimeMachine_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_Form.pas'
 , PrimTurnOnTimeMachineOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimTurnOnTimeMachineOptions_Form.pas'
 , PrimTurnOnTimeMachine_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimTurnOnTimeMachine_Form.pas'
 , TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TurnOnTimeMachineKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachineKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , WarningBaloon_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\WarningBaloon_Form.pas'
 , PrimWarningBaloonOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningBaloonOptions_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , WarningBaloonKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\WarningBaloonKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , SynchroView_WarningBaloon_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroView_WarningBaloon_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SynchroView_WarningBaloonKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroView_WarningBaloonKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Translation_WarningBaloon_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Translation_WarningBaloon_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , Translation_WarningBaloonKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Translation_WarningBaloonKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , UserCR1_WarningBaloon_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR1_WarningBaloon_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UserCR1_WarningBaloonKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR1_WarningBaloonKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , UserCR2_WarningBaloon_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR2_WarningBaloon_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UserCR2_WarningBaloonKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR2_WarningBaloonKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moList.pas'
 , List_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\List_Module.pas'
 , bsOpenListInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\bsOpenListInfo.pas'
 , ListInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\ListInterfaces.pas'
 , nsListEvents in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\nsListEvents.pas'
 , sdsList in 'w:\garant6x\implementation\Garant\GbaNemesis\List\sdsList.pas'
 , dsSynchroView in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsSynchroView.pas'
 , dsListInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsListInfo.pas'
 , dsMainList in 'w:\garant6x\implementation\Garant\GbaNemesis\List\dsMainList.pas'
 , dsFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\List\dsFilters.pas'
 , deFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\List\deFilter.pas'
 , dList in 'w:\garant6x\implementation\Garant\GbaNemesis\List\dList.pas'
 , dsListAnalize in 'w:\garant6x\implementation\Garant\GbaNemesis\List\dsListAnalize.pas'
 , dsSynchroViewWarning in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsSynchroViewWarning.pas'
 , dsSynchroViewDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\List\dsSynchroViewDocument.pas'
 , nsAACDocumentSynchroViewContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsAACDocumentSynchroViewContainer.pas'
 , nsAACDocumentContainerPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsAACDocumentContainerPrim.pas'
 , List_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\List_Form.pas'
 , PrimListOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListOptions_Form.pas'
 , PrimList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimList_Form.pas'
 , WorkWithList_StatusBar_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_StatusBar_Controls.pas'
 , WorkWithList_ListOperations_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_ListOperations_Controls.pas'
 , nscDocumentListTreeView in 'w:\garant6x\implementation\Garant\GbaNemesis\Components\nscDocumentListTreeView.pas'
 , vtStyledFocusLabel in 'w:\common\components\gui\Garant\VT\vtStyledFocusLabel.pas'
 , nsListSortTypeMap in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\nsListSortTypeMap.pas'
 {$If NOT Defined(NoScripts)}
 , nscTreeViewForDocumentListWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\nscTreeViewForDocumentListWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ListInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListInfo_Form.pas'
 , PrimListInfoOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListInfoOptions_Form.pas'
 , PrimListInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListInfo_Form.pas'
 , ListInfoUserTypes_liListInfo_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes_liListInfo_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListInfoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListInfoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ListAnalizer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizer_Form.pas'
 , PrimListAnalizer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalizer_Form.pas'
 , PrimListAnalizer_listAnalize_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalizer_listAnalize_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListAnalizerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\fsList.pas'
 , FiltersUserTypes_utFilters_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas'
 , ListAnalizeUserTypes_Analize_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes_Analize_UserType.pas'
 , fstList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\fstList.pas'
 , ListAnalize_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalize_Form.pas'
 , PrimListAnalize_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalize_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListAnalizeKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizeKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moDiction.pas'
 , Diction_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Diction_Module.pas'
 , nsLangToContextMap in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLangToContextMap.pas'
 , DictionInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\DictionInterfaces.pas'
 , CommonDictionInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\CommonDictionInterfaces.pas'
 , nsLangList in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLangList.pas'
 {$If Defined(Nemesis)}
 , InscContextFilterStateList in 'w:\common\components\gui\Garant\Nemesis\InscContextFilterStateList.pas'
 {$IfEnd} // Defined(Nemesis)
 , sdsDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\sdsDiction.pas'
 , dsDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\dsDiction.pas'
 , deDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\deDiction.pas'
 , deCommonDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\deCommonDiction.pas'
 , dsDictionDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\dsDictionDocument.pas'
 , nsDictionDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\DictionLikeDocumentProcessing\nsDictionDocumentContainer.pas'
 , dDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\dDiction.pas'
 , l3InterfaceList in 'w:\common\components\rtl\Garant\L3\l3InterfaceList.pas'
 , dsSaveLoad in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSaveLoad.pas'
 , dsChild in 'w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsChild.pas'
 , dCommonDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.pas'
 , nsDictionTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictionTree.pas'
 , nsDictListChild in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictListChild.pas'
 , nsLayeredTreeFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLayeredTreeFilters.pas'
 , nsLayerFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsLayerFilter.pas'
 , nsDictCache in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictCache.pas'
 , nsDictCachePrim in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictCachePrim.pas'
 , nsMedicDictCache in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsMedicDictCache.pas'
 , nsDayTipsDictCache in 'w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDayTipsDictCache.pas'
 , Diction_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\Diction_Form.pas'
 , PrimDictionOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDictionOptions_Form.pas'
 , PrimDiction_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_Form.pas'
 , Diction_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction_Strange_Controls.pas'
 , DictionRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\DictionRes.pas'
 , PrimDiction_utDiction_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_utDiction_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DictionKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\DictionKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\fsDiction.pas'
 , DictionContainerUserTypes_slqtDiction_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtDiction_UserType.pas'
 , DictionContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\DictionContainer_Form.pas'
 , PrimDictionContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDictionContainer_Form.pas'
 , DictionContainerUserTypes_slqtMedicDiction_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtMedicDiction_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DictionContainerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\DictionContainerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , CommonDiction_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\CommonDiction_Form.pas'
 , PrimCommonDictionOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDictionOptions_Form.pas'
 , PrimCommonDiction_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_Form.pas'
 , PrimCommonDiction_utTips_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utTips_UserType.pas'
 , PrimCommonDiction_utMedicDiction_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utMedicDiction_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CommonDictionKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\CommonDictionKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moTips in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moTips.pas'
 , DayTips_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\DayTips_Module.pas'
 , nsStartupTips in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\nsStartupTips.pas'
 , DayTipsInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\DayTipsInterfaces.pas'
 , deTips in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\deTips.pas'
 , sdsTips in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\sdsTips.pas'
 , sdsCommonDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.pas'
 , dsTipsDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\dsTipsDocument.pas'
 , nsTipsDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\nsTipsDocumentContainer.pas'
 , dsTips in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\dsTips.pas'
 , nsTipsTree in 'w:\garant6x\implementation\Garant\GbaNemesis\DayTips\nsTipsTree.pas'
 , fsTips in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\fsTips.pas'
 , StartupTips_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\StartupTips_Form.pas'
 , PrimStartupTips_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\PrimStartupTips_Form.pas'
 {$If Defined(evUseVisibleCursors)}
 , evCursorShapeMisc in 'w:\common\components\gui\Garant\Everest\evCursorShapeMisc.pas'
 {$IfEnd} // Defined(evUseVisibleCursors)
 , StartupTips_ut_StartupTips_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\StartupTips_ut_StartupTips_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StartupTipsKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\StartupTipsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moInpharm in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moInpharm.pas'
 , Inpharm_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Inpharm_Module.pas'
 , InpharmMainMenu_ut_mmmMain_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\InpharmMainMenu_ut_mmmMain_UserType.pas'
 , PrimMedicFirmList_mflMain_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmList_mflMain_UserType.pas'
 , sdsInpharmMainMenu in 'w:\garant6x\implementation\Garant\GbaNemesis\InpharmControllers\sdsInpharmMainMenu.pas'
 , dsInpharmMainMenu in 'w:\garant6x\implementation\Garant\GbaNemesis\InpharmControllers\dsInpharmMainMenu.pas'
 , sdsMedicFirmList in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmList.pas'
 , MedicInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\MedicInterfaces.pas'
 , dMedicFirmList in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmList.pas'
 , dsMedicFirmList in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicFirmList.pas'
 , nsMedicFirmsTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsTree.pas'
 , nsMedicFirmsTreeBase in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsTreeBase.pas'
 , nsMedicFirmListFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmListFilters.pas'
 , nsCountryFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsCountryFilter.pas'
 , PharmFirmListUnit in 'w:\garant6x\implementation\Garant\GblAdapterLib\PharmFirmListUnit.pas'
 , nsMedicFirmsCountryFilterTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsCountryFilterTree.pas'
 , nsMedicFirmsCountryFilterTreeBase in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsCountryFilterTreeBase.pas'
 , nsMedicFirmsSubscribersList in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsSubscribersList.pas'
 , deMedicFirmList in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\deMedicFirmList.pas'
 , dsMedicFirmSynchroView in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicFirmSynchroView.pas'
 , dsMedicFirmDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicFirmDocument.pas'
 , dsDrugList in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsDrugList.pas'
 , sdsDrugDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsDrugDocument.pas'
 , dsBaseContents in 'w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseContents.pas'
 , dsDrugDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsDrugDocument.pas'
 , dDrugDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\dDrugDocument.pas'
 , sdsDrugList in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\sdsDrugList.pas'
 , dsDrugListSynchroView in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\dsDrugListSynchroView.pas'
 , dDrugList in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\dDrugList.pas'
 , dsMainDrugList in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\dsMainDrugList.pas'
 , dsDrugListDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Drug\dsDrugListDocument.pas'
 , sdsMedicDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicDiction.pas'
 , dsMedicDictionDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicDictionDocument.pas'
 , dsMedicDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicDiction.pas'
 , deMedicDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\deMedicDiction.pas'
 , nsMedicDictionTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicDictionTree.pas'
 , nsMedicDictionTreeBase in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicDictionTreeBase.pas'
 , sdsMedicFirmDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.pas'
 , dMedicFirmDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmDocument.pas'
 , fsMedicDiction in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicDiction.pas'
 , fsMedicFirmDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicFirmDocument.pas'
 , fsDrugDocument in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsDrugDocument.pas'
 , fsDrugList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsDrugList.pas'
 , PrimMedicListSynchroView_mlsfDrugList_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfDrugList_UserType.pas'
 , fsMedicFirmList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicFirmList.pas'
 , PrimMedicListSynchroView_mlsfMedicFirm_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas'
 , MedicMainMenu_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicMainMenu_Form.pas'
 , InpharmMainMenu_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\InpharmMainMenu_Form.pas'
 , PrimMainMenu_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenu_Form.pas'
 , nsMainMenuNew in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\nsMainMenuNew.pas'
 , nsQueryNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsQueryNode.pas'
 , nsLastOpenDocTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsLastOpenDocTree.pas'
 , nsHistoryTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsHistoryTree.pas'
 , nsJournalBookmarkNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsJournalBookmarkNode.pas'
 , mmmMainFeatures in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmMainFeatures.pas'
 , mmmTree in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmTree.pas'
 , nsDocumentMainMenuNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsDocumentMainMenuNode.pas'
 , mmmReferencePharmaceuticalInformation in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmReferencePharmaceuticalInformation.pas'
 , mmmRegulatoryInformation in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmRegulatoryInformation.pas'
 , mmmReferencesAndDictionaries in 'w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmReferencesAndDictionaries.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MedicMainMenuKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicMainMenuKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , MedicFirmList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicFirmList_Form.pas'
 , PrimMedicFirmListOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmListOptions_Form.pas'
 , PrimMedicFirmList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmList_Form.pas'
 , Inpharm_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm_Strange_Controls.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MedicFirmListKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicFirmListKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , MedicListSynchroView_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicListSynchroView_Form.pas'
 , PrimMedicListSynchroView_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MedicListSynchroViewKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicListSynchroViewKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsInpharmMainMenu in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsInpharmMainMenu.pas'
 , moRubricator in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moRubricator.pas'
 , Rubricator_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Rubricator_Module.pas'
 , Rubricator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\Rubricator_Form.pas'
 , PrimRubricator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\PrimRubricator_Form.pas'
 , Rubricator_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator_Strange_Controls.pas'
 , RubricatorRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\RubricatorRes.pas'
 , RubricatorInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Rubricator\RubricatorInterfaces.pas'
 , nsRubricatorList in 'w:\garant6x\implementation\Garant\GbaNemesis\Rubricator\nsRubricatorList.pas'
 , PrimRubricator_utRubricatorList_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\PrimRubricator_utRubricatorList_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RubricatorKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\RubricatorKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moSettings in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moSettings.pas'
 , Settings_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Settings_Module.pas'
 , PrimStyleEditorExample_utStyleEditorExample_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorExample_utStyleEditorExample_UserType.pas'
 , SelfInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_Form.pas'
 , PrimSelfInfo_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimSelfInfo_Form.pas'
 , nsUserProperty in 'w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserProperty.pas'
 , SelfInfo_ut_SelfInfo_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_ut_SelfInfo_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SelfInfoKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfoKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , StyleEditorContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorContainer_Form.pas'
 , PrimStyleEditorContainerOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorContainerOptions_Form.pas'
 , PrimStyleEditorContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorContainer_Form.pas'
 , Settings_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings_Strange_Controls.pas'
 , PrimStyleEditorContainer_utStyleEditorContainer_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorContainer_utStyleEditorContainer_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StyleEditorContainerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorContainerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , StyleEditorFont_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_Form.pas'
 , PrimStyleEditorFont_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorFont_Form.pas'
 , vtColorBox in 'w:\common\components\gui\Garant\VT\vtColorBox.pas'
 , vtColorBoxStrings in 'w:\common\components\gui\Garant\VT\vtColorBoxStrings.pas'
 , StyleEditorFont_ut_StyleEditorFont_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_ut_StyleEditorFont_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StyleEditorFontKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFontKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , StyleEditorNavigator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorNavigator_Form.pas'
 , PrimStyleEditorNavigator_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_Form.pas'
 , StyleTableRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Config\StyleTableRes.pas'
 , PrimStyleEditorNavigator_utStyleEditorNavigator_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StyleEditorNavigatorKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorNavigatorKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , ConfigurationList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\ConfigurationList_Form.pas'
 , PrimConfigurationList_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_Form.pas'
 , ConfigurationListRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Config\ConfigurationListRes.pas'
 {$If NOT Defined(NoScripts)}
 , PrimConfigurationListWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\PrimConfigurationListWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimConfigurationList_utConfigurationList_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_utConfigurationList_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ConfigurationListKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\ConfigurationListKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , Settings_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\Settings_Form.pas'
 , PrimSettings_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimSettings_Form.pas'
 , nsAppConfig in 'w:\garant6x\implementation\Garant\GbaNemesis\Config\nsAppConfig.pas'
 , ddAppConfig in 'w:\common\components\rtl\Garant\dd\ddAppConfig.pas'
 , ddAppConfigStrings in 'w:\common\components\rtl\Garant\dd\ddAppConfigStrings.pas'
 , ddAppConfigStringsRes in 'w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas'
 , l3Base64 in 'w:\common\components\rtl\Garant\L3\l3Base64.pas'
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
 , nsAppConfigRes in 'w:\garant6x\implementation\Garant\GbaNemesis\Config\nsAppConfigRes.pas'
 , nsConfigurationProperties in 'w:\garant6x\implementation\Garant\GbaNemesis\Config\nsConfigurationProperties.pas'
 , PrimSettings_cutSettings_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimSettings_cutSettings_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SettingsKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SettingsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , StyleEditorExample_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorExample_Form.pas'
 , PrimStyleEditorExample_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorExample_Form.pas'
 , eeEditorWithoutOperations in 'w:\common\components\gui\Garant\Everest_Engine\eeEditorWithoutOperations.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StyleEditorExampleKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorExampleKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moMainMenu in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moMainMenu.pas'
 , MainMenu_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenu_Module.pas'
 , MainMenuChangeableMainMenuTypeSettingRes in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuChangeableMainMenuTypeSettingRes.pas'
 , stMainMenuChangeableMainMenuTypeItem in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\stMainMenuChangeableMainMenuTypeItem.pas'
 {$If NOT Defined(NoScripts)}
 , MainMenuProcessingWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuProcessingWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , MainMenuNew_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuNew_Form.pas'
 , PrimMainMenuNew_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuNew_Form.pas'
 , PrimLegalMainMenu_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimLegalMainMenu_Form.pas'
 , MainMenuWithBaseSearchSupport_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuWithBaseSearchSupport_Form.pas'
 , nsMainMenuFormGUIDFactory in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\nsMainMenuFormGUIDFactory.pas'
 {$If NOT Defined(NoVCM)}
 , vcmFormGUIDFromMainFormList in 'w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormGUIDFromMainFormList.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 , smLawNewsTree in 'w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smLawNewsTree.pas'
 , smTree in 'w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smTree.pas'
 , nsMainMenu2011Node in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsMainMenu2011Node.pas'
 , smNewSchoolReferencesTree in 'w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smNewSchoolReferencesTree.pas'
 {$If Defined(Nemesis)}
 , nscFocusLabel in 'w:\common\components\gui\Garant\Nemesis\nscFocusLabel.pas'
 {$IfEnd} // Defined(Nemesis)
 , PrimMainMenuNew_utMainMenuNew_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuNew_utMainMenuNew_UserType.pas'
 {$If Defined(Nemesis)}
 , nscFixedHeightControlCell in 'w:\common\components\gui\Garant\Nemesis\nscFixedHeightControlCell.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscFixedWidthControlCell in 'w:\common\components\gui\Garant\Nemesis\nscFixedWidthControlCell.pas'
 {$IfEnd} // Defined(Nemesis)
 , smChangeableTree in 'w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smChangeableTree.pas'
 {$If NOT Defined(NoImageEn)}
 , iemview in 'w:\common\components\rtl\external\ImageEn\src\iemview.pas'
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainMenuNewKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuNewKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , MainMenuWithProfNews_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuWithProfNews_Form.pas'
 , PrimMainMenuWithProfNews_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuWithProfNews_Form.pas'
 {$If Defined(Nemesis)}
 , nscComboLabel in 'w:\common\components\gui\Garant\Nemesis\nscComboLabel.pas'
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscImageLabel in 'w:\common\components\gui\Garant\Nemesis\nscImageLabel.pas'
 {$IfEnd} // Defined(Nemesis)
 , PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType.pas'
 , smSectionTree in 'w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smSectionTree.pas'
 , nsMainMenuSectionNode in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsMainMenuSectionNode.pas'
 , smMainMenuTree2016 in 'w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smMainMenuTree2016.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainMenuWithProfNewsKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuWithProfNewsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moConsultations in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moConsultations.pas'
 , Consultation_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Consultation_Module.pas'
 , sdsConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsConsultation.pas'
 , dsConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultation.pas'
 , nsConsultationDocumentContainerNew in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\nsConsultationDocumentContainerNew.pas'
 , nsConsultationHAFPainterImages_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\nsConsultationHAFPainterImages_Form.pas'
 , dsConsultationMark in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultationMark.pas'
 , dsConsultationList in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsConsultationList.pas'
 , bsConsultationManager in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\bsConsultationManager.pas'
 , sdsSendConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsSendConsultation.pas'
 , sdsQuery in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsQuery.pas'
 , ConsultationInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\ConsultationInterfaces.pas'
 , dsQuery in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsQuery.pas'
 , dsSendConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsSendConsultation.pas'
 , fsSendConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsSendConsultation.pas'
 , fsConsultation in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\fsConsultation.pas'
 , PrimConsultationMark_utcmMain_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMark_utcmMain_UserType.pas'
 , ConsultationMark_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\ConsultationMark_Form.pas'
 , PrimConsultationMarkOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMarkOptions_Form.pas'
 , PrimConsultationMark_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMark_Form.pas'
 {$If NOT Defined(NoScripts)}
 , ConsultationWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\ConsultationWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ConsultationMarkKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\ConsultationMarkKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moBaseSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moBaseSearch.pas'
 , BaseSearch_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\BaseSearch_Module.pas'
 , PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType.pas'
 , BaseSearchCard_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCard_Form.pas'
 , PrimBaseSearchCard_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearchCard_Form.pas'
 {$If Defined(Nemesis)}
 , nscLister in 'w:\common\components\gui\Garant\Nemesis\nscLister.pas'
 {$IfEnd} // Defined(Nemesis)
 , BaseSearchCard_ut_BaseSearchCard_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCard_ut_BaseSearchCard_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , BaseSearchCardKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCardKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , NewBaseSearch_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NewBaseSearch_Form.pas'
 , NewBaseSearchForDFM_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NewBaseSearchForDFM_Form.pas'
 , PrimBaseSearchOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearchOptions_Form.pas'
 , PrimBaseSearch_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearch_Form.pas'
 , BaseSearch_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch_Controls.pas'
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
 , nscConst in 'w:\common\components\gui\Garant\Nemesis\nscConst.pas'
 {$IfEnd} // Defined(Nemesis)
 , nsBaseSearchFormGUIDFactory in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\nsBaseSearchFormGUIDFactory.pas'
 , PrimBaseSearch_BaseSearch_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearch_BaseSearch_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , NewBaseSearchKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NewBaseSearchKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , BaseSearchContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchContainer_Form.pas'
 , PrimBaseSearchContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearchContainer_Form.pas'
 , PrimSaveLoadOptionsForBaseSearch_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , BaseSearchContainerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchContainerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moFilters in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moFilters.pas'
 , Filters_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Filters_Module.pas'
 , PrimCreateFilter_cfRename_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfRename_UserType.pas'
 , PrimCreateFilter_cfCreate_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas'
 , dsCreateFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\dsCreateFilter.pas'
 , FiltersInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\Filters\FiltersInterfaces.pas'
 , Filters_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\Filters_Form.pas'
 , PrimFiltersOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimFiltersOptions_Form.pas'
 , PrimFilters_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimFilters_Form.pas'
 , Filters_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters_Strange_Controls.pas'
 , nsIFilterFromQueryList in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\nsIFilterFromQueryList.pas'
 {$If NOT Defined(NoScripts)}
 , InsFilterNodeWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\InsFilterNodeWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FiltersProcessingWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\FiltersProcessingWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FiltersKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\FiltersKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , CreateFilter_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\CreateFilter_Form.pas'
 , PrimCreateFilter_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CreateFilterKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\CreateFilterKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moUnderControl in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moUnderControl.pas'
 , UnderControl_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\UnderControl_Module.pas'
 , UnderControl_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\UnderControl_Form.pas'
 , PrimUnderControlOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControlOptions_Form.pas'
 , PrimUnderControl_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControl_Form.pas'
 , PrimUnderControl_utUnderControl_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControl_utUnderControl_UserType.pas'
 , UnderControl_Strange_Controls in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl_Strange_Controls.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UnderControlKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\UnderControlKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moDocumentListFromFile in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moDocumentListFromFile.pas'
 , PrimDocumentListFromFile_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentListFromFile\PrimDocumentListFromFile_Module.pas'
 , nsOpenDialog in 'w:\garant6x\implementation\Garant\GbaNemesis\Common\nsOpenDialog.pas'
 , moChangesBetweenEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moChangesBetweenEditions.pas'
 , ChangesBetweenEditions_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\ChangesBetweenEditions_Module.pas'
 , sdsChangesBetweenEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\sdsChangesBetweenEditions.pas'
 , ChangesBetweenEditionsInterfaces in 'w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\ChangesBetweenEditionsInterfaces.pas'
 , dsChangesBetweenEditions in 'w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\dsChangesBetweenEditions.pas'
 , nsChangesBetweenEditionsDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\nsChangesBetweenEditionsDocumentContainer.pas'
 , sdsChangesBetweenEditionsData in 'w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\sdsChangesBetweenEditionsData.pas'
 , nsChangesBetweenEditionsInfo in 'w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\nsChangesBetweenEditionsInfo.pas'
 , fsViewChangedFragments in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\fsViewChangedFragments.pas'
 , ChangesBetweenEditons_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\ChangesBetweenEditons_Form.pas'
 , PrimChangesBetweenEditons_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_Form.pas'
 , PrimChangesBetweenEditons_DocumentChanges_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_DocumentChanges_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ChangesBetweenEditonsKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\ChangesBetweenEditonsKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moSearch.pas'
 , Search_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Search_Module.pas'
 {$If NOT Defined(NoScripts)}
 , SearchModuleWordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\SearchModuleWordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts)
 , sdsSituation in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\sdsSituation.pas'
 , dsSelectedAttributes in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSelectedAttributes.pas'
 , deSelectedAttributes in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\deSelectedAttributes.pas'
 , dsTreeAttributeFirstLevel in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTreeAttributeFirstLevel.pas'
 , dsAttributeSelect in 'w:\garant6x\implementation\Garant\GbaNemesis\Search\dsAttributeSelect.pas'
 , fsSituationSearch in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsSituationSearch.pas'
 , PrimTreeAttributeFirstLevel_flSituation_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas'
 , fsSituationFilter in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\fsSituationFilter.pas'
 , DefineSearchDate_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_Form.pas'
 , PrimDefineSearchDate_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimDefineSearchDate_Form.pas'
 , DefineSearchDateUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\DefineSearchDateUtils.pas'
 , DefineSearchDate_ut_DefineSearchDate_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_ut_DefineSearchDate_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DefineSearchDateKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDateKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , OldSituationSearch_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\OldSituationSearch_Form.pas'
 , PrimOldSituationSearchOptions_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearchOptions_Form.pas'
 , PrimOldSituationSearch_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearch_Form.pas'
 , PrimOldSituationSearch_cutOldKeyWord_UserType in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearch_cutOldKeyWord_UserType.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , OldSituationSearchKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\OldSituationSearchKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , TreeAttributeFirstLevel_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\TreeAttributeFirstLevel_Form.pas'
 , PrimTreeAttributeFirstLevel_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeAttributeFirstLevelKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\TreeAttributeFirstLevelKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , moAAC in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moAAC.pas'
 , AACPrim_Module in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACPrim_Module.pas'
 , sdsAAC in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\sdsAAC.pas'
 , dsAACContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACContainer.pas'
 , dsAACDocumentLeft in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACDocumentLeft.pas'
 , dsAACDocumentPrim in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACDocumentPrim.pas'
 , nsAACLeftDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\nsAACLeftDocumentContainer.pas'
 , dsAACDocumentRight in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACDocumentRight.pas'
 , nsAACRightDocumentContainer in 'w:\garant6x\implementation\Garant\GbaNemesis\AAC\nsAACRightDocumentContainer.pas'
 , AACContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainer_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AACContainerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , AACContentsContainer_Form in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContentsContainer_Form.pas'
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AACContentsContainerKeywordsPack in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContentsContainerKeywordsPack.pas'
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 , fsAACContents in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\fsAACContents.pas'
 , fsAAC in 'w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\fsAAC.pas'
 , moCommonPost in 'w:\garant6x\implementation\Garant\GbaNemesis\View\moCommonPost.pas'
 {$If NOT Defined(XE)}
 , F1Test in 'w:\garant6x\implementation\Garant\GbaNemesis\F1Test.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , F1Test_Tree_TestUnit in 'w:\garant6x\implementation\Garant\GbaNemesis\F1Test_Tree_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , nsDocumentsList_p in 'w:\garant6x\implementation\Garant\GbaNemesis\nsDocumentsList_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , TestDocListUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\TestDocListUtils.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , MessageOnDesktop in 'w:\garant6x\implementation\Garant\GbaNemesis\MessageOnDesktop.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , TestStringUtils in 'w:\garant6x\implementation\Garant\GbaNemesis\TestStringUtils.pas'
 {$IfEnd} // NOT Defined(XE)
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
 {$If NOT Defined(XE)}
 , EverestTest in 'w:\common\components\gui\Garant\Everest\EverestTest.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , EverestTest_Editors_TestUnit in 'w:\common\components\gui\Garant\Everest\EverestTest_Editors_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , nevSelection_p in 'w:\common\components\gui\Garant\Everest\nevSelection_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , afwCaret_p in 'w:\common\components\gui\Garant\Everest\afwCaret_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , evTunedEditor_p in 'w:\common\components\gui\Garant\Everest\evTunedEditor_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , afwCustomCaretType_p in 'w:\common\components\gui\Garant\Everest\afwCustomCaretType_p.pas'
 {$IfEnd} // NOT Defined(XE)
 , tc5OpenApp
 , tc6OpenApp
 {$If NOT Defined(XE)}
 , VTTest in 'w:\common\components\gui\Garant\VT\VTTest.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , VTTest_ComboTree_TestUnit in 'w:\common\components\gui\Garant\VT\VTTest_ComboTree_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , FakeBox_p in 'w:\common\components\gui\Garant\VT\FakeBox_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , SubTree_p in 'w:\common\components\gui\Garant\VT\SubTree_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , VTTest_NewReminders_TestUnit in 'w:\common\components\gui\Garant\VT\VTTest_NewReminders_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , vgRemindersLine_p in 'w:\common\components\gui\Garant\VT\vgRemindersLine_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , vgReminder_p in 'w:\common\components\gui\Garant\VT\vgReminder_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM)}
 , VCMTest in 'w:\common\components\gui\Garant\VCM\VCMTest.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM)}
 , VCMTest_Profilers_TestUnit in 'w:\common\components\gui\Garant\VCM\VCMTest_Profilers_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM)}
 , vcmProfilersCollection_p in 'w:\common\components\gui\Garant\VCM\vcmProfilersCollection_p.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmProfilersCollection in 'w:\common\components\gui\Garant\VCM\implementation\vcmProfilersCollection.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmProfiler in 'w:\common\components\gui\Garant\VCM\implementation\vcmProfiler.pas'
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , VCMTest_ChromeLike_TestUnit in 'w:\common\components\gui\Garant\VCM\VCMTest_ChromeLike_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , vcmBaseMenuForChromeLike_p in 'w:\common\components\gui\Garant\VCM\vcmBaseMenuForChromeLike_p.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , vcmMenuForChromeLikeItemWrap in 'w:\common\components\gui\Garant\VCM\vcmMenuForChromeLikeItemWrap.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , RectWrap in 'w:\common\components\gui\Garant\VCM\RectWrap.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTabSetControl_p in 'w:\common\components\gui\Garant\VCM\ChromeLikeTabSetControl_p.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeTab_p in 'w:\common\components\gui\Garant\VCM\ChromeLikeTab_p.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , NemesisTest in 'w:\common\components\gui\Garant\Nemesis\NemesisTest.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , NemesisTest_Navigator_TestUnit in 'w:\common\components\gui\Garant\Nemesis\NemesisTest_Navigator_TestUnit.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , nscNavigatorPageControl_p in 'w:\common\components\gui\Garant\Nemesis\nscNavigatorPageControl_p.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , NemesisTest_Tree_TestUnit in 'w:\common\components\gui\Garant\Nemesis\NemesisTest_Tree_TestUnit.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , eeTreeViewExport_p in 'w:\common\components\gui\Garant\Nemesis\eeTreeViewExport_p.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , NemesisTest_Editor_TestUnit in 'w:\common\components\gui\Garant\Nemesis\NemesisTest_Editor_TestUnit.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If Defined(Nemesis) AND NOT Defined(XE)}
 , nscSimpleEditor_p in 'w:\common\components\gui\Garant\Nemesis\nscSimpleEditor_p.pas'
 {$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)
 {$If NOT Defined(XE)}
 , AFWTest in 'w:\common\components\gui\Garant\AFW\AFWTest.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , AFWTest_VCL_TestUnit in 'w:\common\components\gui\Garant\AFW\AFWTest_VCL_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , MenuItem_p in 'w:\common\components\gui\Garant\AFW\MenuItem_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , Menu_p in 'w:\common\components\gui\Garant\AFW\Menu_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , Control_p in 'w:\common\components\gui\Garant\AFW\Control_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , WinControl_p in 'w:\common\components\gui\Garant\AFW\WinControl_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , AFWTest_Rtl_TestUnit in 'w:\common\components\gui\Garant\AFW\AFWTest_Rtl_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE)}
 , Component_p in 'w:\common\components\gui\Garant\AFW\Component_p.pas'
 {$IfEnd} // NOT Defined(XE)
 {$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
 , VGSceneTest in 'w:\common\components\rtl\external\VGScene\VGSceneTest.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)
 {$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
 , VGSceneTest_Impl_TestUnit in 'w:\common\components\rtl\external\VGScene\VGSceneTest_Impl_TestUnit.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)
 {$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
 , vgVisualObject_p in 'w:\common\components\rtl\external\VGScene\vgVisualObject_p.pas'
 {$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)
 , l3MouseWheelHelper in 'w:\common\components\rtl\Garant\L3\l3MouseWheelHelper.pas'
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$R Nemesis.res}
{$R main_icon2.res} // вторая иконка приложения

begin
 StdRes.TvcmApplicationRunner.Run(str_NemesisTitle, 'F1Shell.chm');
end.
