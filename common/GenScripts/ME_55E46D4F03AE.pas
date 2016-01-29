unit TevCustomEditorWordsPack;

interface

uses
 l3IntfUses
 , evCustomEditor
 , evEditorInterfaces
 , evdTypes
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3Interfaces
 , IedRangeWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TTevCustomEditorWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TTevCustomEditorWordsPackResNameGetter
 
 TkwPopEditorInsertTable = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertTable
*Пример:*
[code]
 aColNum aRowNum aEditor pop:Editor:InsertTable
[code]  }
  procedure InsertTable(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   aRowNum: Integer;
   aColNum: Integer);
   {* Реализация слова скрипта pop:Editor:InsertTable }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertTable
 
 TkwPopEditorInsertRow = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertRow
*Пример:*
[code]
 aEditor pop:Editor:InsertRow
[code]  }
  procedure InsertRow(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:InsertRow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertRow
 
 TkwPopEditorDeleteRow = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:DeleteRow
*Пример:*
[code]
 aEditor pop:Editor:DeleteRow
[code]  }
  procedure DeleteRow(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:DeleteRow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDeleteRow
 
 TkwPopEditorInsertColumn = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertColumn
*Пример:*
[code]
 aEditor pop:Editor:InsertColumn
[code]  }
  procedure InsertColumn(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:InsertColumn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertColumn
 
 TkwPopEditorDeleteColumn = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:DeleteColumn
*Пример:*
[code]
 aEditor pop:Editor:DeleteColumn
[code]  }
  procedure DeleteColumn(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:DeleteColumn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDeleteColumn
 
 TkwPopEditorMergeCells = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:MergeCells
*Пример:*
[code]
 anAlgorytm aEditor pop:Editor:MergeCells
[code]  }
  procedure MergeCells(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   anAlgorytm: TedMergeAlgorythm);
   {* Реализация слова скрипта pop:Editor:MergeCells }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorMergeCells
 
 TkwPopEditorSplitCell = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SplitCell
*Пример:*
[code]
 aVert aEditor pop:Editor:SplitCell
[code]  }
  procedure SplitCell(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   aVert: Boolean);
   {* Реализация слова скрипта pop:Editor:SplitCell }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSplitCell
 
 TkwPopEditorSplitTable = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SplitTable
*Пример:*
[code]
 aEditor pop:Editor:SplitTable
[code]  }
  procedure SplitTable(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:SplitTable }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSplitTable
 
 TkwPopEditorMergeTables = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:MergeTables
*Пример:*
[code]
 aEditor pop:Editor:MergeTables
[code]  }
  procedure MergeTables(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:MergeTables }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorMergeTables
 
 TkwPopEditorInsertSectionBreak = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertSectionBreak
*Пример:*
[code]
 aPageOrientation aEditor pop:Editor:InsertSectionBreak
[code]  }
  procedure InsertSectionBreak(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   aPageOrientation: TevPageOrientation);
   {* Реализация слова скрипта pop:Editor:InsertSectionBreak }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertSectionBreak
 
 TkwPopEditorPrevHyperlink = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:PrevHyperlink
*Пример:*
[code]
 aEditor pop:Editor:PrevHyperlink
[code]  }
  procedure PrevHyperlink(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:PrevHyperlink }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorPrevHyperlink
 
 TkwPopEditorNextHyperlink = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:NextHyperlink
*Пример:*
[code]
 aEditor pop:Editor:NextHyperlink
[code]  }
  procedure NextHyperlink(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* Реализация слова скрипта pop:Editor:NextHyperlink }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorNextHyperlink
 
 TkwPopEditorRange = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:Range
*Тип результата:* IedRange
*Пример:*
[code]
INTERFACE VAR l_IedRange
 aEditor pop:Editor:Range >>> l_IedRange
[code]  }
  function Range(const aCtx: TtfwContext;
   aEditor: TevCustomEditor): IedRange;
   {* Реализация слова скрипта pop:Editor:Range }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorRange
 
end.
