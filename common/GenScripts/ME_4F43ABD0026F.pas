unit WordsDefinitionPack;

interface

uses
 l3IntfUses
 , tfwProcedure
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
 , l3Interfaces
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , kwCompiledFunction
 , SysUtils
 , l3Base
;

type
 TkwFUNCTION = class(TtfwProcedure)
 end;//TkwFUNCTION
 
 TkwNewWord = class(TtfwProcedure)
  {* ����������� ����� ����. ������: 
[code]
: Hello
 3 FOR
  'Hello' .
 NEXT
;
[code] }
 end;//TkwNewWord
 
 TkwOPERATOR = class(TtfwProcedure)
  {* ���������� ���������, ������� ����� ��������� ����� ��� �����, ��� � ������ }
 end;//TkwOPERATOR
 
 TkwWordWorker = class(TtfwProcedure)
  {* ���������� �����, ������� ����� �������� �� ������ ���������� �� ��� ��������������� � ����. �������� ��� @ }
 end;//TkwWordWorker
 
end.
