unit kwFiltersAndGeneratorsPack;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
 , Classes
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , k2EVDReaderService
 , k2EVDWriterService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwFiltersAndGeneratorsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TkwFiltersAndGeneratorsPackResNameGetter
 
 TkwGeneratorsExecute = class(TtfwClassLike)
  {* ����� ������� generators:Execute
[panel]���� �� ����� ��� ��� �������� ����� (EVD) � ��������� (��� �������). ����� ������ ����� � ��������� ����� �� ����.[panel]
*������:*
[code]
 aFileName aTagGenerator generators:Execute
[code]  }
  procedure generators_Execute(const aCtx: TtfwContext;
   const aTagGenerator: Ik2TagGenerator;
   const aFileName: AnsiString);
   {* ���������� ����� ������� generators:Execute }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGeneratorsExecute
 
 TkwGeneratorsLink = class(TtfwClassLike)
  {* ����� ������� generators:Link
[panel]���� �� ����� ��� ���������� � ������ �� ��� �������. � ���������� �� ����� ������� ���� ��������� (� �������� �������� ������)[panel]
*��� ����������:* Ik2TagGenerator
*������:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 aGenHead aTagGenerator generators:Link >>> l_Ik2TagGenerator
[code]  }
  function generators_Link(const aCtx: TtfwContext;
   const aTagGenerator: Ik2TagGenerator;
   const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
   {* ���������� ����� ������� generators:Link }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGeneratorsLink
 
end.
