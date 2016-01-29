unit evRange;

interface

uses
 l3IntfUses
 , k2ProcTagTool
 , evEditorInterfaces
 , nevTools
 , nevBase
 , nevNavigation
 , l3Interfaces
 , Windows
;

type
 TedRangeImplementation = class(Tk2ProcTagTool, IedRange)
  {* ���������� ���������� IedRange }
  procedure Create(const aView: InevView;
   const aLoc: InevLocation;
   const aProcessor: InevProcessor;
   const aTextParagraph: IedTextParagraph);
  function Make(const aView: InevView;
   const aLoc: InevLocation;
   const aProcessor: InevProcessor;
   const aTextParagraph: IedTextParagraph): IedRange;
  function Collapse: Boolean;
  procedure Iterate;
   {* �������� �� ��������� ���������� }
  function Paragraph: IedParagraph;
   {* �������� ����������� �������� � ���������, ���� �� � ���� ������ }
  function Table: IedTable;
   {* �������� ������� � ���������, ���� ��� � ���� ������ }
  function Hyperlink: IevHyperlink;
   {* �������� ����������� � ���������, ���� ��� � ���� ������ }
  function Collapsed: Boolean;
   {* ��������� ��� ����� }
  function TextParagraph: IedTextParagraph;
   {* "���������" �������� � ��������� }
  function Part: IedRange;
   {* ����� ��������� }
  function Document: IevDocument;
   {* �������� }
  function ContainsOneLeaf: Boolean;
   {* ��������� �������� �� �������� ������ ���� ��������� �������� }
  function AsString(aFormat: Tl3ClipboardFormat): AnsiString;
   {* �������� ����� � ��������� }
  function Delete(aMode: TevClearMode): Boolean;
   {* ������� ���������� ��������� }
  function InsertData(aFormat: Tl3ClipboardFormat;
   aData: THandle;
   aNeedClearOld: Boolean): Boolean;
   {* �������� ������ �� ������ � ������� aFormat }
  procedure InsertFrom(const aTextSource: InevTagReader;
   const aFilters: InevTagGenerator);
   {* �������� ������ �� ������� ��������� ������ }
  function InsertString(const aSt: Tl3PCharLenPrim;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* �������� ������ aSt � ������� ������� �������.
         |* ������ ������������� ������ InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - � ������� ������� ������� ����������� ������ 'Hello word!' � ��������� CP_ANSI.
          !end;
         |* }
  function InsertString(const aSt: AnsiString;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* �������� ������ aSt � ������� ������� �������.
         |* ������ ������������� ������ InsertString.
          !begin
          ! CurrentEditor.Range.InsertString('Hello world!');
          ! // - � ������� ������� ������� ����������� ������ 'Hello word!' � ��������� CP_ANSI.
          !end;
         |* }
  function InsertParaBreak: Boolean;
   {* ��������� ������ ���������� }
  function DeleteChar: Boolean;
   {* ������� ������� ������ }
  function Save(aFormat: Tl3ClipboardFormat;
   const outPool: IStream;
   const aFilters: InevTagGenerator;
   anInternal: Boolean;
   ChildrenOnly: Boolean): Boolean;
   {* ��������� ��������� }
 end;//TedRangeImplementation
 
 TedRange = class(TedRangeImplementation)
  {* ���������� ���������� IedRange. ��� ��������� ������������� }
 end;//TedRange
 
implementation

uses
 l3ImplUses
 , ParaList_Const
 , Table_Const
 , SysUtils
 , evParaUtilClasses
 , l3Memory
 , l3Base
 , evTypes
 , nevFacade
 , evOp
 , evEditorInterfacesMisc
 , Messages
 , evBitmapReader
 , evExcept
 , l3String
 , l3Chars
 , evMsgCode
 , evdInterfaces
 , evUsialParagraph
;

end.
