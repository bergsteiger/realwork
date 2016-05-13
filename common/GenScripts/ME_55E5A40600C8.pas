unit IedRangeWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\IedRangeWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "IedRangeWordsPack" MUID: (55E5A40600C8)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evEditorInterfaces
 , nevNavigation
 , nevTools
 , l3Interfaces
 , Windows
 , nevBase
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , IedTableWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopRangeTable = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:Table }
  private
   function Table(const aCtx: TtfwContext;
    const aRange: IedRange): IedTable;
    {* Реализация слова скрипта pop:Range:Table }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeTable

 TkwPopRangeHyperlink = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:Hyperlink }
  private
   function Hyperlink(const aCtx: TtfwContext;
    const aRange: IedRange): IevHyperlink;
    {* Реализация слова скрипта pop:Range:Hyperlink }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeHyperlink

 TkwPopRangeCollapsed = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:Collapsed }
  private
   function Collapsed(const aCtx: TtfwContext;
    const aRange: IedRange): Boolean;
    {* Реализация слова скрипта pop:Range:Collapsed }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeCollapsed

 TkwPopRangeTextParagraph = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:TextParagraph }
  private
   function TextParagraph(const aCtx: TtfwContext;
    const aRange: IedRange): IedTextParagraph;
    {* Реализация слова скрипта pop:Range:TextParagraph }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeTextParagraph

 TkwPopRangeDocument = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:Document }
  private
   function Document(const aCtx: TtfwContext;
    const aRange: IedRange): IevDocument;
    {* Реализация слова скрипта pop:Range:Document }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeDocument

 TkwPopRangeDeleteChar = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:DeleteChar }
  private
   function DeleteChar(const aCtx: TtfwContext;
    const aRange: IedRange): Boolean;
    {* Реализация слова скрипта pop:Range:DeleteChar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeDeleteChar

 TkwPopRangeInsertParaBreak = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:InsertParaBreak }
  private
   function InsertParaBreak(const aCtx: TtfwContext;
    const aRange: IedRange): Boolean;
    {* Реализация слова скрипта pop:Range:InsertParaBreak }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeInsertParaBreak

 TkwPopRangeInsertString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:InsertString }
  private
   function InsertString(const aCtx: TtfwContext;
    const aRange: IedRange;
    const aString: Il3CString): Boolean;
    {* Реализация слова скрипта pop:Range:InsertString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeInsertString

 TkwPopRangeDelete = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:Delete }
  private
   function Delete(const aCtx: TtfwContext;
    const aRange: IedRange;
    aMode: TevClearMode): Boolean;
    {* Реализация слова скрипта pop:Range:Delete }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeDelete

 TkwPopRangeContainsOneLeaf = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:ContainsOneLeaf }
  private
   function ContainsOneLeaf(const aCtx: TtfwContext;
    const aRange: IedRange): Boolean;
    {* Реализация слова скрипта pop:Range:ContainsOneLeaf }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeContainsOneLeaf

 TkwPopRangeAsString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Range:AsString }
  private
   function AsString(const aCtx: TtfwContext;
    const aRange: IedRange): AnsiString;
    {* Реализация слова скрипта pop:Range:AsString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRangeAsString

function TkwPopRangeTable.Table(const aCtx: TtfwContext;
 const aRange: IedRange): IedTable;
 {* Реализация слова скрипта pop:Range:Table }
//#UC START# *55E5A42D01DD_55E5A42D01DD_48E38399034C_Word_var*
//#UC END# *55E5A42D01DD_55E5A42D01DD_48E38399034C_Word_var*
begin
//#UC START# *55E5A42D01DD_55E5A42D01DD_48E38399034C_Word_impl*
 Result := aRange.Table;
//#UC END# *55E5A42D01DD_55E5A42D01DD_48E38399034C_Word_impl*
end;//TkwPopRangeTable.Table

class function TkwPopRangeTable.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:Table';
end;//TkwPopRangeTable.GetWordNameForRegister

function TkwPopRangeTable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedTable);
end;//TkwPopRangeTable.GetResultTypeInfo

function TkwPopRangeTable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeTable.GetAllParamsCount

function TkwPopRangeTable.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeTable.ParamsTypes

procedure TkwPopRangeTable.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Table(aCtx, l_aRange), TypeInfo(IedTable));
end;//TkwPopRangeTable.DoDoIt

function TkwPopRangeHyperlink.Hyperlink(const aCtx: TtfwContext;
 const aRange: IedRange): IevHyperlink;
 {* Реализация слова скрипта pop:Range:Hyperlink }
//#UC START# *55E5A43E00EE_55E5A43E00EE_48E38399034C_Word_var*
//#UC END# *55E5A43E00EE_55E5A43E00EE_48E38399034C_Word_var*
begin
//#UC START# *55E5A43E00EE_55E5A43E00EE_48E38399034C_Word_impl*
 Result := aRange.Hyperlink;
//#UC END# *55E5A43E00EE_55E5A43E00EE_48E38399034C_Word_impl*
end;//TkwPopRangeHyperlink.Hyperlink

class function TkwPopRangeHyperlink.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:Hyperlink';
end;//TkwPopRangeHyperlink.GetWordNameForRegister

function TkwPopRangeHyperlink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IevHyperlink);
end;//TkwPopRangeHyperlink.GetResultTypeInfo

function TkwPopRangeHyperlink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeHyperlink.GetAllParamsCount

function TkwPopRangeHyperlink.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeHyperlink.ParamsTypes

procedure TkwPopRangeHyperlink.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Hyperlink(aCtx, l_aRange), TypeInfo(IevHyperlink));
end;//TkwPopRangeHyperlink.DoDoIt

function TkwPopRangeCollapsed.Collapsed(const aCtx: TtfwContext;
 const aRange: IedRange): Boolean;
 {* Реализация слова скрипта pop:Range:Collapsed }
//#UC START# *55E5A44D01A4_55E5A44D01A4_48E38399034C_Word_var*
//#UC END# *55E5A44D01A4_55E5A44D01A4_48E38399034C_Word_var*
begin
//#UC START# *55E5A44D01A4_55E5A44D01A4_48E38399034C_Word_impl*
 Result := aRange.Collapsed;
//#UC END# *55E5A44D01A4_55E5A44D01A4_48E38399034C_Word_impl*
end;//TkwPopRangeCollapsed.Collapsed

class function TkwPopRangeCollapsed.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:Collapsed';
end;//TkwPopRangeCollapsed.GetWordNameForRegister

function TkwPopRangeCollapsed.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRangeCollapsed.GetResultTypeInfo

function TkwPopRangeCollapsed.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeCollapsed.GetAllParamsCount

function TkwPopRangeCollapsed.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeCollapsed.ParamsTypes

procedure TkwPopRangeCollapsed.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Collapsed(aCtx, l_aRange));
end;//TkwPopRangeCollapsed.DoDoIt

function TkwPopRangeTextParagraph.TextParagraph(const aCtx: TtfwContext;
 const aRange: IedRange): IedTextParagraph;
 {* Реализация слова скрипта pop:Range:TextParagraph }
//#UC START# *55E5A45F032F_55E5A45F032F_48E38399034C_Word_var*
//#UC END# *55E5A45F032F_55E5A45F032F_48E38399034C_Word_var*
begin
//#UC START# *55E5A45F032F_55E5A45F032F_48E38399034C_Word_impl*
 Result := aRange.TextParagraph;
//#UC END# *55E5A45F032F_55E5A45F032F_48E38399034C_Word_impl*
end;//TkwPopRangeTextParagraph.TextParagraph

class function TkwPopRangeTextParagraph.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:TextParagraph';
end;//TkwPopRangeTextParagraph.GetWordNameForRegister

function TkwPopRangeTextParagraph.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedTextParagraph);
end;//TkwPopRangeTextParagraph.GetResultTypeInfo

function TkwPopRangeTextParagraph.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeTextParagraph.GetAllParamsCount

function TkwPopRangeTextParagraph.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeTextParagraph.ParamsTypes

procedure TkwPopRangeTextParagraph.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(TextParagraph(aCtx, l_aRange), TypeInfo(IedTextParagraph));
end;//TkwPopRangeTextParagraph.DoDoIt

function TkwPopRangeDocument.Document(const aCtx: TtfwContext;
 const aRange: IedRange): IevDocument;
 {* Реализация слова скрипта pop:Range:Document }
//#UC START# *55E5A4F70193_55E5A4F70193_48E38399034C_Word_var*
//#UC END# *55E5A4F70193_55E5A4F70193_48E38399034C_Word_var*
begin
//#UC START# *55E5A4F70193_55E5A4F70193_48E38399034C_Word_impl*
 Result := aRange.Document;
//#UC END# *55E5A4F70193_55E5A4F70193_48E38399034C_Word_impl*
end;//TkwPopRangeDocument.Document

class function TkwPopRangeDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:Document';
end;//TkwPopRangeDocument.GetWordNameForRegister

function TkwPopRangeDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IevDocument);
end;//TkwPopRangeDocument.GetResultTypeInfo

function TkwPopRangeDocument.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeDocument.GetAllParamsCount

function TkwPopRangeDocument.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeDocument.ParamsTypes

procedure TkwPopRangeDocument.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Document(aCtx, l_aRange), TypeInfo(IevDocument));
end;//TkwPopRangeDocument.DoDoIt

function TkwPopRangeDeleteChar.DeleteChar(const aCtx: TtfwContext;
 const aRange: IedRange): Boolean;
 {* Реализация слова скрипта pop:Range:DeleteChar }
//#UC START# *55E5A51201C5_55E5A51201C5_48E38399034C_Word_var*
//#UC END# *55E5A51201C5_55E5A51201C5_48E38399034C_Word_var*
begin
//#UC START# *55E5A51201C5_55E5A51201C5_48E38399034C_Word_impl*
 Result := aRange.DeleteChar;
//#UC END# *55E5A51201C5_55E5A51201C5_48E38399034C_Word_impl*
end;//TkwPopRangeDeleteChar.DeleteChar

class function TkwPopRangeDeleteChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:DeleteChar';
end;//TkwPopRangeDeleteChar.GetWordNameForRegister

function TkwPopRangeDeleteChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRangeDeleteChar.GetResultTypeInfo

function TkwPopRangeDeleteChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeDeleteChar.GetAllParamsCount

function TkwPopRangeDeleteChar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeDeleteChar.ParamsTypes

procedure TkwPopRangeDeleteChar.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(DeleteChar(aCtx, l_aRange));
end;//TkwPopRangeDeleteChar.DoDoIt

function TkwPopRangeInsertParaBreak.InsertParaBreak(const aCtx: TtfwContext;
 const aRange: IedRange): Boolean;
 {* Реализация слова скрипта pop:Range:InsertParaBreak }
//#UC START# *55E5A525018D_55E5A525018D_48E38399034C_Word_var*
//#UC END# *55E5A525018D_55E5A525018D_48E38399034C_Word_var*
begin
//#UC START# *55E5A525018D_55E5A525018D_48E38399034C_Word_impl*
 Result := aRange.InsertParaBreak;
//#UC END# *55E5A525018D_55E5A525018D_48E38399034C_Word_impl*
end;//TkwPopRangeInsertParaBreak.InsertParaBreak

class function TkwPopRangeInsertParaBreak.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:InsertParaBreak';
end;//TkwPopRangeInsertParaBreak.GetWordNameForRegister

function TkwPopRangeInsertParaBreak.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRangeInsertParaBreak.GetResultTypeInfo

function TkwPopRangeInsertParaBreak.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeInsertParaBreak.GetAllParamsCount

function TkwPopRangeInsertParaBreak.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeInsertParaBreak.ParamsTypes

procedure TkwPopRangeInsertParaBreak.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(InsertParaBreak(aCtx, l_aRange));
end;//TkwPopRangeInsertParaBreak.DoDoIt

function TkwPopRangeInsertString.InsertString(const aCtx: TtfwContext;
 const aRange: IedRange;
 const aString: Il3CString): Boolean;
 {* Реализация слова скрипта pop:Range:InsertString }
//#UC START# *55E5A54A0108_55E5A54A0108_48E38399034C_Word_var*
//#UC END# *55E5A54A0108_55E5A54A0108_48E38399034C_Word_var*
begin
//#UC START# *55E5A54A0108_55E5A54A0108_48E38399034C_Word_impl*
 Result := aRange.InsertString(aString.AsWStr);
//#UC END# *55E5A54A0108_55E5A54A0108_48E38399034C_Word_impl*
end;//TkwPopRangeInsertString.InsertString

class function TkwPopRangeInsertString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:InsertString';
end;//TkwPopRangeInsertString.GetWordNameForRegister

function TkwPopRangeInsertString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRangeInsertString.GetResultTypeInfo

function TkwPopRangeInsertString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopRangeInsertString.GetAllParamsCount

function TkwPopRangeInsertString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange), @tfw_tiString]);
end;//TkwPopRangeInsertString.ParamsTypes

procedure TkwPopRangeInsertString.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
var l_aString: Il3CString;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(InsertString(aCtx, l_aRange, l_aString));
end;//TkwPopRangeInsertString.DoDoIt

function TkwPopRangeDelete.Delete(const aCtx: TtfwContext;
 const aRange: IedRange;
 aMode: TevClearMode): Boolean;
 {* Реализация слова скрипта pop:Range:Delete }
//#UC START# *55E5A5710018_55E5A5710018_48E38399034C_Word_var*
//#UC END# *55E5A5710018_55E5A5710018_48E38399034C_Word_var*
begin
//#UC START# *55E5A5710018_55E5A5710018_48E38399034C_Word_impl*
 Result := aRange.Delete(aMode);
//#UC END# *55E5A5710018_55E5A5710018_48E38399034C_Word_impl*
end;//TkwPopRangeDelete.Delete

class function TkwPopRangeDelete.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:Delete';
end;//TkwPopRangeDelete.GetWordNameForRegister

function TkwPopRangeDelete.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRangeDelete.GetResultTypeInfo

function TkwPopRangeDelete.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopRangeDelete.GetAllParamsCount

function TkwPopRangeDelete.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange), TypeInfo(TevClearMode)]);
end;//TkwPopRangeDelete.ParamsTypes

procedure TkwPopRangeDelete.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
var l_aMode: TevClearMode;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMode := TevClearMode(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMode: TevClearMode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Delete(aCtx, l_aRange, l_aMode));
end;//TkwPopRangeDelete.DoDoIt

function TkwPopRangeContainsOneLeaf.ContainsOneLeaf(const aCtx: TtfwContext;
 const aRange: IedRange): Boolean;
 {* Реализация слова скрипта pop:Range:ContainsOneLeaf }
//#UC START# *55E5A59300AD_55E5A59300AD_48E38399034C_Word_var*
//#UC END# *55E5A59300AD_55E5A59300AD_48E38399034C_Word_var*
begin
//#UC START# *55E5A59300AD_55E5A59300AD_48E38399034C_Word_impl*
 Result := aRange.ContainsOneLeaf;
//#UC END# *55E5A59300AD_55E5A59300AD_48E38399034C_Word_impl*
end;//TkwPopRangeContainsOneLeaf.ContainsOneLeaf

class function TkwPopRangeContainsOneLeaf.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:ContainsOneLeaf';
end;//TkwPopRangeContainsOneLeaf.GetWordNameForRegister

function TkwPopRangeContainsOneLeaf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRangeContainsOneLeaf.GetResultTypeInfo

function TkwPopRangeContainsOneLeaf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeContainsOneLeaf.GetAllParamsCount

function TkwPopRangeContainsOneLeaf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeContainsOneLeaf.ParamsTypes

procedure TkwPopRangeContainsOneLeaf.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(ContainsOneLeaf(aCtx, l_aRange));
end;//TkwPopRangeContainsOneLeaf.DoDoIt

function TkwPopRangeAsString.AsString(const aCtx: TtfwContext;
 const aRange: IedRange): AnsiString;
 {* Реализация слова скрипта pop:Range:AsString }
//#UC START# *55E5A5B70005_55E5A5B70005_48E38399034C_Word_var*
//#UC END# *55E5A5B70005_55E5A5B70005_48E38399034C_Word_var*
begin
//#UC START# *55E5A5B70005_55E5A5B70005_48E38399034C_Word_impl*
 Result := aRange.AsString;
//#UC END# *55E5A5B70005_55E5A5B70005_48E38399034C_Word_impl*
end;//TkwPopRangeAsString.AsString

class function TkwPopRangeAsString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Range:AsString';
end;//TkwPopRangeAsString.GetWordNameForRegister

function TkwPopRangeAsString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopRangeAsString.GetResultTypeInfo

function TkwPopRangeAsString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRangeAsString.GetAllParamsCount

function TkwPopRangeAsString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedRange)]);
end;//TkwPopRangeAsString.ParamsTypes

procedure TkwPopRangeAsString.DoDoIt(const aCtx: TtfwContext);
var l_aRange: IedRange;
begin
 try
  l_aRange := IedRange(aCtx.rEngine.PopIntf(IedRange));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRange: IedRange : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(AsString(aCtx, l_aRange));
end;//TkwPopRangeAsString.DoDoIt

initialization
 TkwPopRangeTable.RegisterInEngine;
 {* Регистрация pop_Range_Table }
 TkwPopRangeHyperlink.RegisterInEngine;
 {* Регистрация pop_Range_Hyperlink }
 TkwPopRangeCollapsed.RegisterInEngine;
 {* Регистрация pop_Range_Collapsed }
 TkwPopRangeTextParagraph.RegisterInEngine;
 {* Регистрация pop_Range_TextParagraph }
 TkwPopRangeDocument.RegisterInEngine;
 {* Регистрация pop_Range_Document }
 TkwPopRangeDeleteChar.RegisterInEngine;
 {* Регистрация pop_Range_DeleteChar }
 TkwPopRangeInsertParaBreak.RegisterInEngine;
 {* Регистрация pop_Range_InsertParaBreak }
 TkwPopRangeInsertString.RegisterInEngine;
 {* Регистрация pop_Range_InsertString }
 TkwPopRangeDelete.RegisterInEngine;
 {* Регистрация pop_Range_Delete }
 TkwPopRangeContainsOneLeaf.RegisterInEngine;
 {* Регистрация pop_Range_ContainsOneLeaf }
 TkwPopRangeAsString.RegisterInEngine;
 {* Регистрация pop_Range_AsString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedRange));
 {* Регистрация типа IedRange }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedTable));
 {* Регистрация типа IedTable }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IevHyperlink));
 {* Регистрация типа IevHyperlink }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedTextParagraph));
 {* Регистрация типа IedTextParagraph }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IevDocument));
 {* Регистрация типа IevDocument }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevClearMode));
 {* Регистрация типа TevClearMode }
{$IfEnd} // NOT Defined(NoScripts)

end.
