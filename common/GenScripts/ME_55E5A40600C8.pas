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
  {* ����� ������� pop:Range:Table
*��� ����������:* IedTable
*������:*
[code]
INTERFACE VAR l_IedTable
 aRange pop:Range:Table >>> l_IedTable
[code]  }
  function Table(const aCtx: TtfwContext;
   const aRange: IedRange): IedTable;
   {* ���������� ����� ������� pop:Range:Table }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeTable
 
 TkwPopRangeHyperlink = class(TtfwClassLike)
  {* ����� ������� pop:Range:Hyperlink
*��� ����������:* IevHyperlink
*������:*
[code]
INTERFACE VAR l_IevHyperlink
 aRange pop:Range:Hyperlink >>> l_IevHyperlink
[code]  }
  function Hyperlink(const aCtx: TtfwContext;
   const aRange: IedRange): IevHyperlink;
   {* ���������� ����� ������� pop:Range:Hyperlink }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeHyperlink
 
 TkwPopRangeCollapsed = class(TtfwClassLike)
  {* ����� ������� pop:Range:Collapsed
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:Collapsed >>> l_Boolean
[code]  }
  function Collapsed(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* ���������� ����� ������� pop:Range:Collapsed }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeCollapsed
 
 TkwPopRangeTextParagraph = class(TtfwClassLike)
  {* ����� ������� pop:Range:TextParagraph
*��� ����������:* IedTextParagraph
*������:*
[code]
INTERFACE VAR l_IedTextParagraph
 aRange pop:Range:TextParagraph >>> l_IedTextParagraph
[code]  }
  function TextParagraph(const aCtx: TtfwContext;
   const aRange: IedRange): IedTextParagraph;
   {* ���������� ����� ������� pop:Range:TextParagraph }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeTextParagraph
 
 TkwPopRangeDocument = class(TtfwClassLike)
  {* ����� ������� pop:Range:Document
*��� ����������:* IevDocument
*������:*
[code]
INTERFACE VAR l_IevDocument
 aRange pop:Range:Document >>> l_IevDocument
[code]  }
  function Document(const aCtx: TtfwContext;
   const aRange: IedRange): IevDocument;
   {* ���������� ����� ������� pop:Range:Document }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeDocument
 
 TkwPopRangeDeleteChar = class(TtfwClassLike)
  {* ����� ������� pop:Range:DeleteChar
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:DeleteChar >>> l_Boolean
[code]  }
  function DeleteChar(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* ���������� ����� ������� pop:Range:DeleteChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeDeleteChar
 
 TkwPopRangeInsertParaBreak = class(TtfwClassLike)
  {* ����� ������� pop:Range:InsertParaBreak
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:InsertParaBreak >>> l_Boolean
[code]  }
  function InsertParaBreak(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* ���������� ����� ������� pop:Range:InsertParaBreak }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeInsertParaBreak
 
 TkwPopRangeInsertString = class(TtfwClassLike)
  {* ����� ������� pop:Range:InsertString
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aString aRange pop:Range:InsertString >>> l_Boolean
[code]  }
  function InsertString(const aCtx: TtfwContext;
   const aRange: IedRange;
   const aString: Il3CString): Boolean;
   {* ���������� ����� ������� pop:Range:InsertString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeInsertString
 
 TkwPopRangeDelete = class(TtfwClassLike)
  {* ����� ������� pop:Range:Delete
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aMode aRange pop:Range:Delete >>> l_Boolean
[code]  }
  function Delete(const aCtx: TtfwContext;
   const aRange: IedRange;
   aMode: TevClearMode): Boolean;
   {* ���������� ����� ������� pop:Range:Delete }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeDelete
 
 TkwPopRangeContainsOneLeaf = class(TtfwClassLike)
  {* ����� ������� pop:Range:ContainsOneLeaf
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRange pop:Range:ContainsOneLeaf >>> l_Boolean
[code]  }
  function ContainsOneLeaf(const aCtx: TtfwContext;
   const aRange: IedRange): Boolean;
   {* ���������� ����� ������� pop:Range:ContainsOneLeaf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeContainsOneLeaf
 
 TkwPopRangeAsString = class(TtfwClassLike)
  {* ����� ������� pop:Range:AsString
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aRange pop:Range:AsString >>> l_String
[code]  }
  function AsString(const aCtx: TtfwContext;
   const aRange: IedRange): AnsiString;
   {* ���������� ����� ������� pop:Range:AsString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopRangeAsString
 
end.
