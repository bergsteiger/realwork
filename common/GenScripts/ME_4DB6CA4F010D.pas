unit kwCompiledWord;

interface

uses
 l3IntfUses
 , kwRuntimeWordWithCodeExecution
 , tfwDictionary
 , tfwWordRefList
 , tfwDictionaryPrim
 , tfwScriptingInterfaces
 , l3Interfaces
 , l3Variant
;

type
 TkwCompiledWord = class(TkwRuntimeWordWithCodeExecution)
  {* ��������� ���������������� ���� }
 end;//TkwCompiledWord
 
implementation

uses
 l3ImplUses
 , SysUtils
 , tfwStoredValues
 , tfwArray
 , kwLeftParam
 , l3String
;

end.
