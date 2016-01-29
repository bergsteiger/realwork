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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TTevCustomEditorWordsPackResNameGetter
 
 TkwPopEditorInsertTable = class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertTable
*������:*
[code]
 aColNum aRowNum aEditor pop:Editor:InsertTable
[code]  }
  procedure InsertTable(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   aRowNum: Integer;
   aColNum: Integer);
   {* ���������� ����� ������� pop:Editor:InsertTable }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertTable
 
 TkwPopEditorInsertRow = class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertRow
*������:*
[code]
 aEditor pop:Editor:InsertRow
[code]  }
  procedure InsertRow(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:InsertRow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertRow
 
 TkwPopEditorDeleteRow = class(TtfwClassLike)
  {* ����� ������� pop:Editor:DeleteRow
*������:*
[code]
 aEditor pop:Editor:DeleteRow
[code]  }
  procedure DeleteRow(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:DeleteRow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDeleteRow
 
 TkwPopEditorInsertColumn = class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertColumn
*������:*
[code]
 aEditor pop:Editor:InsertColumn
[code]  }
  procedure InsertColumn(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:InsertColumn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertColumn
 
 TkwPopEditorDeleteColumn = class(TtfwClassLike)
  {* ����� ������� pop:Editor:DeleteColumn
*������:*
[code]
 aEditor pop:Editor:DeleteColumn
[code]  }
  procedure DeleteColumn(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:DeleteColumn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDeleteColumn
 
 TkwPopEditorMergeCells = class(TtfwClassLike)
  {* ����� ������� pop:Editor:MergeCells
*������:*
[code]
 anAlgorytm aEditor pop:Editor:MergeCells
[code]  }
  procedure MergeCells(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   anAlgorytm: TedMergeAlgorythm);
   {* ���������� ����� ������� pop:Editor:MergeCells }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorMergeCells
 
 TkwPopEditorSplitCell = class(TtfwClassLike)
  {* ����� ������� pop:Editor:SplitCell
*������:*
[code]
 aVert aEditor pop:Editor:SplitCell
[code]  }
  procedure SplitCell(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   aVert: Boolean);
   {* ���������� ����� ������� pop:Editor:SplitCell }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSplitCell
 
 TkwPopEditorSplitTable = class(TtfwClassLike)
  {* ����� ������� pop:Editor:SplitTable
*������:*
[code]
 aEditor pop:Editor:SplitTable
[code]  }
  procedure SplitTable(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:SplitTable }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSplitTable
 
 TkwPopEditorMergeTables = class(TtfwClassLike)
  {* ����� ������� pop:Editor:MergeTables
*������:*
[code]
 aEditor pop:Editor:MergeTables
[code]  }
  procedure MergeTables(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:MergeTables }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorMergeTables
 
 TkwPopEditorInsertSectionBreak = class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertSectionBreak
*������:*
[code]
 aPageOrientation aEditor pop:Editor:InsertSectionBreak
[code]  }
  procedure InsertSectionBreak(const aCtx: TtfwContext;
   aEditor: TevCustomEditor;
   aPageOrientation: TevPageOrientation);
   {* ���������� ����� ������� pop:Editor:InsertSectionBreak }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorInsertSectionBreak
 
 TkwPopEditorPrevHyperlink = class(TtfwClassLike)
  {* ����� ������� pop:Editor:PrevHyperlink
*������:*
[code]
 aEditor pop:Editor:PrevHyperlink
[code]  }
  procedure PrevHyperlink(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:PrevHyperlink }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorPrevHyperlink
 
 TkwPopEditorNextHyperlink = class(TtfwClassLike)
  {* ����� ������� pop:Editor:NextHyperlink
*������:*
[code]
 aEditor pop:Editor:NextHyperlink
[code]  }
  procedure NextHyperlink(const aCtx: TtfwContext;
   aEditor: TevCustomEditor);
   {* ���������� ����� ������� pop:Editor:NextHyperlink }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorNextHyperlink
 
 TkwPopEditorRange = class(TtfwClassLike)
  {* ����� ������� pop:Editor:Range
*��� ����������:* IedRange
*������:*
[code]
INTERFACE VAR l_IedRange
 aEditor pop:Editor:Range >>> l_IedRange
[code]  }
  function Range(const aCtx: TtfwContext;
   aEditor: TevCustomEditor): IedRange;
   {* ���������� ����� ������� pop:Editor:Range }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorRange
 
end.
