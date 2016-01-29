unit IedRangeWordsPack;

interface

uses
 l3IntfUses
 , evEditorInterfaces
 , nevNavigation
 , nevTools
 , l3Interfaces
 , Windows
 , nevBase
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , IedTableWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopRangeTable = class(TtfwClassLike)
  {* Слово скрипта pop:Range:Table
*Тип результата:* IedTable
*Пример:*
[code]
INTERFACE VAR l_IedTable
 aRange pop:Range:Table >>> l_IedTable
[code]  }
  function Table(const aCtx: TtfwContext;
   const aRange: IedRange): IedTable;
   {* Реализация слова скрипта pop:Range:Table }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeTable
 
 TkwPopRangeHyperlink = class(TtfwClassLike)
  {* Слово скрипта pop:Range:Hyperlink
*Тип результата:* IevHyperlink
*Пример:*
[code]
INTERFACE VAR l_IevHyperlink
 aRange pop:Range:Hyperlink >>> l_IevHyperlink
[code]  }
  function Hyperlink(const aCtx: TtfwContext;
   const aRange: IedRange): IevHyperlink;
   {* Реализация слова скрипта pop:Range:Hyperlink }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeHyperlink
 
 TkwPopRangeCollapsed = class(TtfwClassLike)
  {* Слово скрипта pop:Range:Collapsed
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:Collapsed >>> l_Boolean
[code]  }
  function Collapsed(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* Реализация слова скрипта pop:Range:Collapsed }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeCollapsed
 
 TkwPopRangeTextParagraph = class(TtfwClassLike)
  {* Слово скрипта pop:Range:TextParagraph
*Тип результата:* IedTextParagraph
*Пример:*
[code]
INTERFACE VAR l_IedTextParagraph
 aRange pop:Range:TextParagraph >>> l_IedTextParagraph
[code]  }
  function TextParagraph(const aCtx: TtfwContext;
   const aRange: IedRange): IedTextParagraph;
   {* Реализация слова скрипта pop:Range:TextParagraph }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeTextParagraph
 
 TkwPopRangeDocument = class(TtfwClassLike)
  {* Слово скрипта pop:Range:Document
*Тип результата:* IevDocument
*Пример:*
[code]
INTERFACE VAR l_IevDocument
 aRange pop:Range:Document >>> l_IevDocument
[code]  }
  function Document(const aCtx: TtfwContext;
   const aRange: IedRange): IevDocument;
   {* Реализация слова скрипта pop:Range:Document }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeDocument
 
 TkwPopRangeDeleteChar = class(TtfwClassLike)
  {* Слово скрипта pop:Range:DeleteChar
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:DeleteChar >>> l_Boolean
[code]  }
  function DeleteChar(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* Реализация слова скрипта pop:Range:DeleteChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeDeleteChar
 
 TkwPopRangeInsertParaBreak = class(TtfwClassLike)
  {* Слово скрипта pop:Range:InsertParaBreak
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:InsertParaBreak >>> l_Boolean
[code]  }
  function InsertParaBreak(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* Реализация слова скрипта pop:Range:InsertParaBreak }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeInsertParaBreak
 
 TkwPopRangeInsertString = class(TtfwClassLike)
  {* Слово скрипта pop:Range:InsertString
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aString aRange pop:Range:InsertString >>> l_Boolean
[code]  }
  function InsertString(const aCtx: TtfwContext;
   const aRange: IedRange;
   const aString: Il3CString): Boolean;
   {* Реализация слова скрипта pop:Range:InsertString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeInsertString
 
 TkwPopRangeDelete = class(TtfwClassLike)
  {* Слово скрипта pop:Range:Delete
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aMode aRange pop:Range:Delete >>> l_Boolean
[code]  }
  function Delete(const aCtx: TtfwContext;
   const aRange: IedRange;
   aMode: TevClearMode): Boolean;
   {* Реализация слова скрипта pop:Range:Delete }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeDelete
 
 TkwPopRangeContainsOneLeaf = class(TtfwClassLike)
  {* Слово скрипта pop:Range:ContainsOneLeaf
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:ContainsOneLeaf >>> l_Boolean
[code]  }
  function ContainsOneLeaf(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* Реализация слова скрипта pop:Range:ContainsOneLeaf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeContainsOneLeaf
 
 TkwPopRangeAsString = class(TtfwClassLike)
  {* Слово скрипта pop:Range:AsString
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aRange pop:Range:AsString >>> l_String
[code]  }
  function AsString(const aCtx: TtfwContext;
   const aRange: IedRange): AnsiString;
   {* Реализация слова скрипта pop:Range:AsString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeAsString
 
end.
