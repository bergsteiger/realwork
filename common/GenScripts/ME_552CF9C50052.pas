unit AutolinkFilterWordsPack;

interface

uses
 l3IntfUses
 , l3Variant
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3AutolinkService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwFilterAutolinkFilter = class(TtfwGlobalKeyWord)
  {* ����� ������� filter:AutolinkFilter
[panel]������ �� ����� ������ TddAutolinkFilter (� ���� Ik2TagGenerator).[panel]
*��� ����������:* Ik2TagGenerator
*������:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 filter:AutolinkFilter >>> l_Ik2TagGenerator
[code]  }
  function filter_AutolinkFilter(const aCtx: TtfwContext): Ik2TagGenerator;
   {* ���������� ����� ������� filter:AutolinkFilter }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFilterAutolinkFilter
 
 TkwFilterCleanAutolinkFilter = class(TtfwGlobalKeyWord)
  {* ����� ������� filter:CleanAutolinkFilter
[panel]��������� TddAutolinkFilter �������� ���� �� �� ����������, �� ���� ����� �������� Generator ����� �������������. � ����� ������� ���������� � ����� ������ ������ ������.[panel]
*������:*
[code]
 filter:CleanAutolinkFilter
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFilterCleanAutolinkFilter
 
end.
