unit evSchemaWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "evSchemaWordsPack" MUID: (54EDDCAC016A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , l3Interfaces
 , tfwAxiomaticsResNameGetter
 , evTypes
 , SysUtils
 , l3Filer
 , l3Memory
 , evEvdRd
 , evdNativeWriter
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evStyleInterfaceEx
 , l3Stream
 , l3Types
 , l3String
 , k2Facade
 , k2Tags
 , evStyleInterface
 , tfwIntegerConstantRegistrator
 , k2Attributes
 , l3Base
 , k2Base
 , l3Variant
 , evdStyles
 , tfwEnumRegistrator
 , evdTypes
 , tfwClassRef
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwRegisterSchema = {final} class
  private
   class procedure RegisterSchema(aSender: TObject);
 end;//TkwRegisterSchema

 TkwCFPDF = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CF:PDF }
  private
   function CF_PDF(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта CF:PDF }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCFPDF

 TkwCFHTML = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CF:HTML }
  private
   function CF_HTML(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта CF:HTML }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCFHTML

 TkwCFXML = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CF:XML }
  private
   function CF_XML(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта CF:XML }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCFXML

 TkwCFEVEREST = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CF:EVEREST }
  private
   function CF_EVEREST(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта CF:EVEREST }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCFEVEREST

 TkwCFRTF = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CF:RTF }
  private
   function CF_RTF(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта CF:RTF }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCFRTF

 TkwCFEVERESTBIN = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CF:EVERESTBIN }
  private
   function CF_EVERESTBIN(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта CF:EVERESTBIN }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCFEVERESTBIN

 TkwStyleTableChanged = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StyleTable:Changed }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleTableChanged

 TkwStyleTableChanging = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StyleTable:Changing }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleTableChanging

 TkwEvdBin2EvdTxt = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EvdBin2EvdTxt }
  private
   function EvdBin2EvdTxt(const aCtx: TtfwContext;
    const aData: Il3CString): Il3CString;
    {* Реализация слова скрипта EvdBin2EvdTxt }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEvdBin2EvdTxt

 TkwStyleTableSaveToFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StyleTable:SaveToFile }
  private
   procedure StyleTable_SaveToFile(const aCtx: TtfwContext;
    const aFileName: AnsiString);
    {* Реализация слова скрипта StyleTable:SaveToFile }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleTableSaveToFile

 TevSchemaWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TevSchemaWordsPackResNameGetter

class procedure TkwRegisterSchema.RegisterSchema(aSender: TObject);
//#UC START# *53C7C3DC0014_53C7C38A011C_var*

 function DoAttr(const anAttr: Tk2Attribute; anIndex: Integer): Boolean;
 begin
  Result := true;
  TtfwIntegerConstantRegistrator.Register('evd::ti_' + anAttr.rName, anAttr.rID);
 end;

 function OutStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
 var
  l_Tag : Tl3Tag;
  l_H   : Integer;
 begin//OutStyle
  Result := true;
  l_Tag := aStyle^;
  l_H := -l_Tag.IntA[k2_tiHandle];
  if (l_H >= Low(StandardNames)) AND (l_H <= High(StandardNames)) then
  begin
   TtfwIntegerConstantRegistrator.Register('evd::sa_' + StandardNames[l_H], -l_H);
  end;//l_H >= Low(StandardNames)
 end;//OutStyle

 function OutStyle1(aStyle: Pl3Variant; Index: Integer): Boolean;
 var
  l_Tag : Tl3Tag;
  l_H   : Integer;
 begin//OutStyle1
  Result := true;
  l_Tag := astyle^;
  l_H := l_Tag.IntA[k2_tiHandle];
  TtfwIntegerConstantRegistrator.Register('evd::стиль:"' + l_Tag.StrA[k2_tiName] + '"', -l_H);
 end;//OutStyle1
  
var
 l_TT : Tk2TypeTable;
 l_Index : Integer;
 l_Type : Tk2Type;
 l_SI : TevStyleInterface;
//#UC END# *53C7C3DC0014_53C7C38A011C_var*
begin
//#UC START# *53C7C3DC0014_53C7C38A011C_impl*
 l_TT := k2.TypeTable;
 TtfwClassRef.Register(l_TT.ClassType);
 for l_Index := 0 to l_TT.MaxTypeID do
 begin
  l_Type := l_TT.TypeByHandle[l_Index];
  if (l_Type <> nil) then
  begin
   TtfwIntegerConstantRegistrator.Register('evd::id_' + l_Type.AsString, l_Type.ID);
   if (l_Type.AtomType <> nil) then
   begin
    if (l_Type.AtomType.Kind = tkEnumeration) then
     TtfwEnumRegistrator.RegisterEnum(l_Type.AtomType);
    if (l_Type.AtomClass <> nil) then
     TtfwClassRef.Register(l_Type.AtomClass);
   end;//l_Type.AtomType <> nil
   if (l_Type.WrapperType <> nil) then
    TtfwClassRef.Register(l_Type.WrapperType);
   if (l_Type.InterfaceFactory <> nil) then
    TtfwClassRef.Register(l_Type.InterfaceFactory.ClassType);
  end;//l_Type <> nil
 end;//for l_Index
 Tk2Attributes.Instance.IterateAllF(l3L2IA(@DoAttr));
 l_SI := TevStyleInterface.Make;
 try
  l_SI.IterateF(l3L2IA(@OutStyle));
  l_SI.IterateF(l3L2IA(@OutStyle1));
 finally
  FreeAndNil(l_SI);
 end;//try..finally
//#UC END# *53C7C3DC0014_53C7C38A011C_impl*
end;//TkwRegisterSchema.RegisterSchema

function TkwCFPDF.CF_PDF(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта CF:PDF }
//#UC START# *5731A85502C3_5731A85502C3_Word_var*
//#UC END# *5731A85502C3_5731A85502C3_Word_var*
begin
//#UC START# *5731A85502C3_5731A85502C3_Word_impl*
 Result := evTypes.CF_PDF;
//#UC END# *5731A85502C3_5731A85502C3_Word_impl*
end;//TkwCFPDF.CF_PDF

class function TkwCFPDF.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF:PDF';
end;//TkwCFPDF.GetWordNameForRegister

function TkwCFPDF.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCFPDF.GetResultTypeInfo

function TkwCFPDF.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCFPDF.GetAllParamsCount

function TkwCFPDF.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCFPDF.ParamsTypes

procedure TkwCFPDF.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(CF_PDF(aCtx));
end;//TkwCFPDF.DoDoIt

function TkwCFHTML.CF_HTML(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта CF:HTML }
//#UC START# *5731A87401CE_5731A87401CE_Word_var*
//#UC END# *5731A87401CE_5731A87401CE_Word_var*
begin
//#UC START# *5731A87401CE_5731A87401CE_Word_impl*
 Result := evTypes.CF_HTML;
//#UC END# *5731A87401CE_5731A87401CE_Word_impl*
end;//TkwCFHTML.CF_HTML

class function TkwCFHTML.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF:HTML';
end;//TkwCFHTML.GetWordNameForRegister

function TkwCFHTML.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCFHTML.GetResultTypeInfo

function TkwCFHTML.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCFHTML.GetAllParamsCount

function TkwCFHTML.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCFHTML.ParamsTypes

procedure TkwCFHTML.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(CF_HTML(aCtx));
end;//TkwCFHTML.DoDoIt

function TkwCFXML.CF_XML(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта CF:XML }
//#UC START# *5731A8840004_5731A8840004_Word_var*
//#UC END# *5731A8840004_5731A8840004_Word_var*
begin
//#UC START# *5731A8840004_5731A8840004_Word_impl*
 Result := evTypes.CF_XML;
//#UC END# *5731A8840004_5731A8840004_Word_impl*
end;//TkwCFXML.CF_XML

class function TkwCFXML.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF:XML';
end;//TkwCFXML.GetWordNameForRegister

function TkwCFXML.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCFXML.GetResultTypeInfo

function TkwCFXML.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCFXML.GetAllParamsCount

function TkwCFXML.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCFXML.ParamsTypes

procedure TkwCFXML.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(CF_XML(aCtx));
end;//TkwCFXML.DoDoIt

function TkwCFEVEREST.CF_EVEREST(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта CF:EVEREST }
//#UC START# *5731A891035F_5731A891035F_Word_var*
//#UC END# *5731A891035F_5731A891035F_Word_var*
begin
//#UC START# *5731A891035F_5731A891035F_Word_impl*
 Result := evTypes.CF_EverestTxt;
//#UC END# *5731A891035F_5731A891035F_Word_impl*
end;//TkwCFEVEREST.CF_EVEREST

class function TkwCFEVEREST.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF:EVEREST';
end;//TkwCFEVEREST.GetWordNameForRegister

function TkwCFEVEREST.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCFEVEREST.GetResultTypeInfo

function TkwCFEVEREST.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCFEVEREST.GetAllParamsCount

function TkwCFEVEREST.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCFEVEREST.ParamsTypes

procedure TkwCFEVEREST.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(CF_EVEREST(aCtx));
end;//TkwCFEVEREST.DoDoIt

function TkwCFRTF.CF_RTF(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта CF:RTF }
//#UC START# *5731A8A201E3_5731A8A201E3_Word_var*
//#UC END# *5731A8A201E3_5731A8A201E3_Word_var*
begin
//#UC START# *5731A8A201E3_5731A8A201E3_Word_impl*
 Result := evTypes.CF_RTF;
//#UC END# *5731A8A201E3_5731A8A201E3_Word_impl*
end;//TkwCFRTF.CF_RTF

class function TkwCFRTF.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF:RTF';
end;//TkwCFRTF.GetWordNameForRegister

function TkwCFRTF.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCFRTF.GetResultTypeInfo

function TkwCFRTF.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCFRTF.GetAllParamsCount

function TkwCFRTF.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCFRTF.ParamsTypes

procedure TkwCFRTF.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(CF_RTF(aCtx));
end;//TkwCFRTF.DoDoIt

function TkwCFEVERESTBIN.CF_EVERESTBIN(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта CF:EVERESTBIN }
//#UC START# *5731A8B30033_5731A8B30033_Word_var*
//#UC END# *5731A8B30033_5731A8B30033_Word_var*
begin
//#UC START# *5731A8B30033_5731A8B30033_Word_impl*
 Result := evTypes.CF_EverestBin;
//#UC END# *5731A8B30033_5731A8B30033_Word_impl*
end;//TkwCFEVERESTBIN.CF_EVERESTBIN

class function TkwCFEVERESTBIN.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF:EVERESTBIN';
end;//TkwCFEVERESTBIN.GetWordNameForRegister

function TkwCFEVERESTBIN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCFEVERESTBIN.GetResultTypeInfo

function TkwCFEVERESTBIN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCFEVERESTBIN.GetAllParamsCount

function TkwCFEVERESTBIN.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCFEVERESTBIN.ParamsTypes

procedure TkwCFEVERESTBIN.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(CF_EVERESTBIN(aCtx));
end;//TkwCFEVERESTBIN.DoDoIt

class function TkwStyleTableChanged.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:Changed';
end;//TkwStyleTableChanged.GetWordNameForRegister

function TkwStyleTableChanged.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwStyleTableChanged.GetResultTypeInfo

function TkwStyleTableChanged.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwStyleTableChanged.GetAllParamsCount

function TkwStyleTableChanged.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwStyleTableChanged.ParamsTypes

procedure TkwStyleTableChanged.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5731CA8500B0_Word_var*
//#UC END# *4DAEEDE10285_5731CA8500B0_Word_var*
begin
//#UC START# *4DAEEDE10285_5731CA8500B0_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5731CA8500B0_Word_impl*
end;//TkwStyleTableChanged.DoDoIt

class function TkwStyleTableChanging.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:Changing';
end;//TkwStyleTableChanging.GetWordNameForRegister

function TkwStyleTableChanging.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwStyleTableChanging.GetResultTypeInfo

function TkwStyleTableChanging.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwStyleTableChanging.GetAllParamsCount

function TkwStyleTableChanging.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwStyleTableChanging.ParamsTypes

procedure TkwStyleTableChanging.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5731CA920303_Word_var*
//#UC END# *4DAEEDE10285_5731CA920303_Word_var*
begin
//#UC START# *4DAEEDE10285_5731CA920303_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5731CA920303_Word_impl*
end;//TkwStyleTableChanging.DoDoIt

function TkwEvdBin2EvdTxt.EvdBin2EvdTxt(const aCtx: TtfwContext;
 const aData: Il3CString): Il3CString;
 {* Реализация слова скрипта EvdBin2EvdTxt }
//#UC START# *5731CAA20015_5731CAA20015_Word_var*
var
 l_InFiler, l_OutFiler : Tl3CustomFiler;
 l_InData: Tl3WString;
 l_InStream: Tl3ConstMemoryStream;
 l_OutStream: Tl3StringStream;
 l_EverestReader : TevEvdReader;
 l_EverestWriter : TevdNativeWriter;
//#UC END# *5731CAA20015_5731CAA20015_Word_var*
begin
//#UC START# *5731CAA20015_5731CAA20015_Word_impl*
 {$IFDEF EverestLite}
 RunnerError(Format('Функция %s не поддерживается в EverestLite!', [GetWordNameForRegister]), aCtx);
 {$ELSE}
 RunnerAssert(aCtx.rEngine.IsTopString, 'Нужна строка', aCtx);
 l_InData := l3PCharLen(aData);
 l_InStream := Tl3ConstMemoryStream.Create(l_InData.S, l_InData.SLen);
 try
  l_OutStream := Tl3StringStream.Create;
  try
   l_InFiler := Tl3CustomFiler.Create;
   try
    l_InFiler.Stream := l_InStream;
    l_OutFiler := Tl3CustomFiler.Create;
    try
     l_OutFiler.Stream := l_OutStream;
     l_EverestReader := TevEvdReader.Create;
     try
      l_EverestWriter := TevdNativeWriter.Create;
      try
       l_EverestReader.Filer := l_InFiler;
       l_EverestWriter.Filer := l_OutFiler;
       l_EverestReader.Generator := l_EverestWriter;
       l_EverestWriter.Binary := False;
       l_EverestReader.Execute;
       Result := l_OutStream as Il3CString;
      finally
       FreeAndNil(l_EverestWriter);
      end;
     finally
      FreeAndNil(l_EverestReader);
     end;
    finally
     FreeAndNil(l_OutFiler);
    end;
   finally
    FreeAndNil(l_InFiler);
   end;
  finally
   FreeAndNil(l_OutStream);
  end;
 finally
  FreeAndNil(l_InStream);
 end;
 {$ENDIF EverestLite}
//#UC END# *5731CAA20015_5731CAA20015_Word_impl*
end;//TkwEvdBin2EvdTxt.EvdBin2EvdTxt

class function TkwEvdBin2EvdTxt.GetWordNameForRegister: AnsiString;
begin
 Result := 'EvdBin2EvdTxt';
end;//TkwEvdBin2EvdTxt.GetWordNameForRegister

function TkwEvdBin2EvdTxt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwEvdBin2EvdTxt.GetResultTypeInfo

function TkwEvdBin2EvdTxt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEvdBin2EvdTxt.GetAllParamsCount

function TkwEvdBin2EvdTxt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwEvdBin2EvdTxt.ParamsTypes

procedure TkwEvdBin2EvdTxt.DoDoIt(const aCtx: TtfwContext);
var l_aData: Il3CString;
begin
 try
  l_aData := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aData: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(EvdBin2EvdTxt(aCtx, l_aData));
end;//TkwEvdBin2EvdTxt.DoDoIt

procedure TkwStyleTableSaveToFile.StyleTable_SaveToFile(const aCtx: TtfwContext;
 const aFileName: AnsiString);
 {* Реализация слова скрипта StyleTable:SaveToFile }
//#UC START# *5731CABE014E_5731CABE014E_Word_var*
var
 l_S : Tl3NamedTextStream;
//#UC END# *5731CABE014E_5731CABE014E_Word_var*
begin
//#UC START# *5731CABE014E_5731CABE014E_Word_impl*
 l_S := Tl3NamedTextStream.Create(aCtx.rCaller.ResolveOutputFilePath(aFileName),
                                  l3_fmWrite);
 try
  with TevStyleInterfaceEx.Make do
   try
    Save(l_S);
   finally
    Free;
   end;//try..finally
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *5731CABE014E_5731CABE014E_Word_impl*
end;//TkwStyleTableSaveToFile.StyleTable_SaveToFile

class function TkwStyleTableSaveToFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:SaveToFile';
end;//TkwStyleTableSaveToFile.GetWordNameForRegister

function TkwStyleTableSaveToFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwStyleTableSaveToFile.GetResultTypeInfo

function TkwStyleTableSaveToFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleTableSaveToFile.GetAllParamsCount

function TkwStyleTableSaveToFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStyleTableSaveToFile.ParamsTypes

procedure TkwStyleTableSaveToFile.DoDoIt(const aCtx: TtfwContext);
var l_aFileName: AnsiString;
begin
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 StyleTable_SaveToFile(aCtx, l_aFileName);
end;//TkwStyleTableSaveToFile.DoDoIt

class function TevSchemaWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'evSchemaWordsPack';
end;//TevSchemaWordsPackResNameGetter.ResName

{$R evSchemaWordsPack.res}

initialization
//#UC START# *53C7C3B90110*
 Tk2TypeTable.AddCreatedListener(TkwRegisterSchema.RegisterSchema);
//#UC END# *53C7C3B90110*
 TkwCFPDF.RegisterInEngine;
 {* Регистрация CF_PDF }
 TkwCFHTML.RegisterInEngine;
 {* Регистрация CF_HTML }
 TkwCFXML.RegisterInEngine;
 {* Регистрация CF_XML }
 TkwCFEVEREST.RegisterInEngine;
 {* Регистрация CF_EVEREST }
 TkwCFRTF.RegisterInEngine;
 {* Регистрация CF_RTF }
 TkwCFEVERESTBIN.RegisterInEngine;
 {* Регистрация CF_EVERESTBIN }
 TkwStyleTableChanged.RegisterInEngine;
 {* Регистрация StyleTable_Changed }
 TkwStyleTableChanging.RegisterInEngine;
 {* Регистрация StyleTable_Changing }
 TkwEvdBin2EvdTxt.RegisterInEngine;
 {* Регистрация EvdBin2EvdTxt }
 TkwStyleTableSaveToFile.RegisterInEngine;
 {* Регистрация StyleTable_SaveToFile }
 TevSchemaWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
