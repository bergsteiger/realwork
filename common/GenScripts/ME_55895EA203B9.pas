unit NewWordDefinitorPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , kwCompiledVar
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

type
 TkwGlobalVar = class(TkwCompiledVar)
 end;//TkwGlobalVar
 
implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopNewWordDefinitorCheckWord = class(TtfwClassLike)
  {* ����� ������� pop:NewWordDefinitor:CheckWord
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aNewWordDefinitor pop:NewWordDefinitor:CheckWord >>> l_TtfwKeyWord
[code]  }
  function CheckWord(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor;
   const aName: Il3CString): TtfwKeyWord;
   {* ���������� ����� ������� pop:NewWordDefinitor:CheckWord }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorCheckWord
 
 TkwPopNewWordDefinitorCheckVar = class(TtfwClassLike)
  {* ����� ������� pop:NewWordDefinitor:CheckVar
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aName aLocal aNewWordDefinitor pop:NewWordDefinitor:CheckVar >>> l_TtfwWord
[code]  }
  function CheckVar(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor;
   aLocal: Boolean;
   const aName: Il3CString): TtfwWord;
   {* ���������� ����� ������� pop:NewWordDefinitor:CheckVar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorCheckVar
 
 TkwPopNewWordDefinitorDefineInParameter = class(TtfwClassLike)
  {* ����� ������� pop:NewWordDefinitor:DefineInParameter
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aStereo aParamName aNewWordDefinitor pop:NewWordDefinitor:DefineInParameter >>> l_TtfwWord
[code]  }
  function DefineInParameter(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor;
   const aParamName: Il3CString;
   aStereo: TtfwWord): TtfwWord;
   {* ���������� ����� ������� pop:NewWordDefinitor:DefineInParameter }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorDefineInParameter
 
 TkwPopNewWordDefinitorKeywordFinder = class(TtfwPropertyLike)
  {* ����� ������� pop:NewWordDefinitor:KeywordFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aNewWordDefinitor pop:NewWordDefinitor:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  function KeywordFinder(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor): TtfwKeywordFinder;
   {* ���������� ����� ������� pop:NewWordDefinitor:KeywordFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorKeywordFinder
 
end.
