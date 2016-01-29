program MakeCO;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/MakeCO/MakeCO.dpr"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ExeTarget::Category>> Shared Delphi Low Level::MakeCO
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\MakeCO\MakeCO.inc}

{$APPTYPE CONSOLE}

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  ObjectFromstackWords in 'w:\common\components\rtl\Garant\ScriptEngine\ObjectFromstackWords.pas'
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwIl3CStringPack in 'w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3String in 'w:\common\components\rtl\Garant\L3\l3String.pas',
  Types,
  Windows {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Windows.pas' {$EndIf},
  ActiveX {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\ActiveX.pas' {$EndIf},
  Messages {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Win\Messages.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  ComponentsProcessingPack in 'w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas'
  {$IfEnd} //not NoScripts
  ,
  TypInfo {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\TypInfo.pas' {$EndIf}
  {$If not defined(NoScripts)}
  ,
  TypeInfoPack in 'w:\common\components\rtl\Garant\ScriptEngine\TypeInfoPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3Units in 'w:\common\components\rtl\Garant\L3\l3Units.pas',
  l3PureMixIns in 'w:\common\components\rtl\Garant\L3\l3PureMixIns.pas'
  {$If not defined(NoScripts)}
  ,
  FontWordsPack in 'w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas'
  {$IfEnd} //not NoScripts
  ,
  l3IID in 'w:\common\components\rtl\Garant\L3\l3IID.pas',
  l3InterfacesMisc in 'w:\common\components\rtl\Garant\L3\l3InterfacesMisc.pas',
  l3ProtoObjectWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas',
  l3SimpleObject in 'w:\common\components\rtl\Garant\L3\l3SimpleObject.pas',
  l3_Base in 'w:\common\components\rtl\Garant\L3\l3_Base.pas',
  l3Except in 'w:\common\components\rtl\Garant\L3\l3Except.pas',
  RTLConsts {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Rtl\Common\RTLConsts.pas' {$EndIf},
  l3MinMax in 'w:\common\components\rtl\Garant\L3\l3MinMax.pas',
  l3ObjectRefList1 in 'w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas',
  l3Const in 'w:\common\components\rtl\Garant\L3\l3Const.pas',
  k2BaseTypes in 'w:\common\components\rtl\Garant\L3\k2BaseTypes.pas',
  l3CastablePersistent in 'w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas',
  l3DataContainerWithoutIUnknownPrim in 'w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknownPrim.pas',
  l3Variants in 'w:\common\components\rtl\Garant\L3\l3Variants.pas',
  l3Chars in 'w:\common\components\rtl\Garant\L3\l3Chars.pas',
  l3Date in 'w:\common\components\rtl\Garant\L3\l3Date.pas',
  l3Variant in 'w:\common\components\rtl\Garant\L3\l3Variant.pas',
  l3BMSearch in 'w:\common\components\rtl\Garant\L3\l3BMSearch.pas',
  l3StringEx in 'w:\common\components\rtl\Garant\L3\l3StringEx.pas',
  l3StringAdapter in 'w:\common\components\rtl\Garant\L3\l3StringAdapter.pas',
  l3CustomString in 'w:\common\components\rtl\Garant\L3\l3CustomString.pas',
  l3_String in 'w:\common\components\rtl\Garant\L3\l3_String.pas',
  l3CProtoObject in 'w:\common\components\rtl\Garant\L3\l3CProtoObject.pas',
  Refcounted in 'w:\common\components\rtl\Garant\L3\Refcounted.pas',
  l3MemorySizeUtilsPrim in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtilsPrim.pas',
  l3MemorySizeUtils in 'w:\common\components\rtl\Garant\L3\l3MemorySizeUtils.pas',
  l3Interlocked in 'w:\common\components\rtl\Garant\L3\l3Interlocked.pas',
  l3MemUtils in 'w:\common\components\rtl\Garant\L3\l3MemUtils.pas',
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
  l3Base in 'w:\common\components\rtl\Garant\L3\l3Base.pas',
  l3CastableObject in 'w:\common\components\rtl\Garant\L3\l3CastableObject.pas',
  l3ProtoObject in 'w:\common\components\rtl\Garant\L3\l3ProtoObject.pas',
  l3ProtoDataContainer in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainer.pas'
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
  l3Parser in 'w:\common\components\rtl\Garant\L3\l3Parser.pas'
  {$If not defined(NoScripts)}
  ,
  tfwScriptingExceptions in 'w:\common\components\rtl\Garant\ScriptEngine\tfwScriptingExceptions.pas'
  {$IfEnd} //not NoScripts
  ,
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
  tfwKeywordsIterator in 'w:\common\components\rtl\Garant\ScriptEngine\tfwKeywordsIterator.pas'
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
  l3ConstStrings1 in 'w:\common\components\rtl\Garant\L3\l3ConstStrings1.pas',
  l3ConstStrings in 'w:\common\components\rtl\Garant\L3\l3ConstStrings.pas',
  l3StringIDEx in 'w:\common\components\rtl\Garant\L3\l3StringIDEx.pas'
  {$If not defined(NoVCL)}
  ,
  Dialogs {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Dialogs.pas' {$EndIf}
  {$IfEnd} //not NoVCL
  ,
  Pl3StringIDExList in 'w:\common\components\rtl\Garant\L3\Pl3StringIDExList.pas',
  Pl3MessageIDListPrim in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDListPrim.pas',
  Pl3MessageIDList in 'w:\common\components\rtl\Garant\L3\Pl3MessageIDList.pas',
  l3MessageID in 'w:\common\components\rtl\Garant\L3\l3MessageID.pas',
  l3FilerRes in 'w:\common\components\rtl\Garant\L3\l3FilerRes.pas',
  l3Filer in 'w:\common\components\rtl\Garant\L3\l3Filer.pas'
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
  l3SimpleDataContainer in 'w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas',
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
  l3Stream in 'w:\common\components\rtl\Garant\L3\l3Stream.pas',
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
  ,
  l3PrinterInterfaces in 'w:\common\components\rtl\Garant\L3\l3PrinterInterfaces.pas',
  l3InternalInterfaces in 'w:\common\components\rtl\Garant\L3\l3InternalInterfaces.pas',
  l3BaseStream in 'w:\common\components\rtl\Garant\L3\l3BaseStream.pas',
  l3ProtoDataContainerWithCOMQI in 'w:\common\components\rtl\Garant\L3\l3ProtoDataContainerWithCOMQI.pas',
  l3Memory in 'w:\common\components\rtl\Garant\L3\l3Memory.pas'
  {$If not defined(NoScripts)}
  ,
  tfwWordRefList in 'w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas'
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
  ,
  Graphics {$IfNDef XE} in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Graphics.pas' {$EndIf},
  l3Core in 'w:\common\components\rtl\Garant\L3\l3Core.pas',
  l3Types in 'w:\common\components\rtl\Garant\L3\l3Types.pas',
  l3Interfaces in 'w:\common\components\rtl\Garant\L3\l3Interfaces.pas',
  l3EtalonsWorking in 'w:\common\components\rtl\Garant\L3\l3EtalonsWorking.pas'
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
  SysUtils,
  tfwCachedTokens in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCachedTokens.pas',
  tfwParser in 'w:\common\components\rtl\Garant\ScriptEngine\tfwParser.pas',
  tfwFileStreamFactory in 'w:\common\components\rtl\Garant\ScriptEngine\tfwFileStreamFactory.pas',
  tfwCOMaker in 'w:\common\components\rtl\Garant\ScriptEngine\tfwCOMaker.pas',
  MakeCORunner in 'MakeCORunner.pas'
//#UC START# *55C1F4C100FBmanualuses*
//#UC END# *55C1F4C100FBmanualuses*
  ;

//#UC START# *55C1F4C100FBmanualres*
//#UC END# *55C1F4C100FBmanualres*

begin
 //#UC START# *55C1F4C100FBmanualcode*
 TMakeCORunner.Run;
 //#UC END# *55C1F4C100FBmanualcode*
end.