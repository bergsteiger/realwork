Unit Dt_EGen;

{ $Id: Dt_EGen.pas,v 1.122 2016/04/18 11:48:05 lukyanets Exp $ }

// $Log: Dt_EGen.pas,v $
// Revision 1.122  2016/04/18 11:48:05  lukyanets
// Готовимся переводить UserManager
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.121  2016/03/25 12:41:40  lukyanets
// cleanup
//
// Revision 1.120  2015/11/23 11:37:15  lukyanets
// Заготовки Renum
//
// Revision 1.119  2015/11/12 07:21:12  fireton
// - Нормальная диагностика ошибок при экспорте
// - Считаем пустые документы, справки и аннотации правильно
//
// Revision 1.118  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.117  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.116  2014/09/04 12:12:53  dinishev
// {Requestlink:564750095}. Перенес интерфейсы листнетов в ddTypes
//
// Revision 1.115  2014/09/04 11:01:31  dinishev
// {Requestlink:564750095}
//
// Revision 1.114  2014/07/01 10:42:52  voba
//  k:236721575 (Атрибуты в EVD) Убрал лишнюю загрузку атрибутов
//
// Revision 1.113  2014/05/08 11:48:18  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.112  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.111  2014/04/04 06:58:50  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.110  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.109  2013/10/18 15:38:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.108  2013/07/18 07:29:09  voba
// - bug fix. Ошибка с подсчетом количества документов для выливки
//
// Revision 1.107  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.106  2013/02/05 10:06:45  voba
// - замена типа у  function di_Get_Name : Tl3PCharLenPrim;
//
// Revision 1.105  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.104  2012/10/02 08:07:54  narry
// Начало перехода на ISab вместо SAB
//
// Revision 1.103  2012/04/20 15:20:01  lulin
// {RequestLink:283610570}
//
// Revision 1.102  2012/04/12 10:26:49  narry
// Падение на номере справки 0
//
// Revision 1.101  2012/03/29 07:17:55  narry
// Экпортировать только справки (352453562)
//
// Revision 1.100  2012/03/27 09:04:24  voba
// - k : 344753123
//
// Revision 1.99  2011/11/17 04:56:53  narry
// Не собиралось
//
// Revision 1.98  2011/11/16 13:20:34  voba
// - k : 298683144
//
// Revision 1.97  2011/10/26 12:48:55  voba
// - bug fix
//
// Revision 1.96  2011/10/13 07:42:31  narry
// Неправильно возвращалось количество аннотаций
//
// Revision 1.95  2011/10/05 11:05:15  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.94  2011/09/16 13:05:47  narry
// - обновление
//
// Revision 1.93  2011/06/10 12:49:03  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.92  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.91  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.90  2010/03/10 14:09:47  narry
// - не собиралось
//
// Revision 1.89  2009/12/23 08:33:43  voba
// - bug fix : проблемы с захватом семейства (таблица ctrl)
//
// Revision 1.88  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.87  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.86  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.85  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.84  2009/04/09 06:05:38  voba
// - cc
//
// Revision 1.83  2009/03/31 09:02:58  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.82  2009/03/19 08:47:41  voba
// - перенес процедур экспорта словарей в отдельный модуль dt_DictExport
//
// Revision 1.81  2009/03/04 16:26:03  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.80  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.79  2009/01/14 14:06:53  narry
// - татары
//
// Revision 1.78.4.1  2008/12/26 15:22:05  fireton
// - полностью избавляемся от ссылок на DT_Srch
//
// Revision 1.78  2008/09/17 14:47:47  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.77  2008/05/08 13:35:54  voba
// no message
//
// Revision 1.76  2008/05/07 16:00:50  voba
// - Refact. function .GetRelImportNum и GetINumber убил, вместо нех использовать GetExtDocID
//
// Revision 1.75  2008/04/04 14:49:23  narry
// - не собиралось
//
// Revision 1.74  2008/03/07 13:13:55  voba
// - bug fix : неправильно искались адреса гипессылок для справок
//
// Revision 1.73  2008/02/22 18:26:35  lulin
// - доперевёл списки на модель.
//
// Revision 1.72  2008/02/12 13:20:01  voba
// - заточки для быстрой выливки справок без документов
//
// Revision 1.71  2007/11/26 09:40:27  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.70  2007/10/09 08:53:53  voba
// - merge with b_archi_export_refact2
//
// Revision 1.69.8.1  2007/09/14 15:45:58  voba
// no message
//
// Revision 1.69  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.68  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.67.4.2  2007/08/20 06:31:29  voba
// no message
//
// Revision 1.67.4.1  2007/07/25 11:37:06  voba
// no message
//
// Revision 1.67  2007/06/28 11:16:25  voba
// - refact. убрал из function TAbstractList.GetItem второй параметр
//
// Revision 1.66  2007/06/28 10:43:51  narry
// - не компилировалось
//
// Revision 1.65  2007/05/18 12:23:40  fireton
// - реорганизация Большого Брата:
//   * логика перенесена из вызывающего кода в ББ
//   * изничтожен OperationHandle
//
// Revision 1.64  2007/03/09 12:22:13  voba
// - bug fix
//
// Revision 1.63  2007/03/09 07:32:18  voba
// - cc
//
// Revision 1.62  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.61  2006/11/17 15:21:18  voba
// - refactoring procedure TDocExportGenerator.ExportKeyWordData
//
// Revision 1.60  2006/10/04 08:31:12  voba
// - remove tdSingle
//
// Revision 1.59  2006/04/14 12:48:56  narry
// - изменение: обновление словаря ключевых слов перед экспортом
//
// Revision 1.58  2005/03/30 09:26:52  narry
// - экспорт важности для специальных Аннотаций
//
// Revision 1.57  2005/03/16 08:39:07  voba
// - improve заменил PAnsiChar на AnsiString
// - убрал перекодировку строк в OEM, этим занимается файлер
//
// Revision 1.56  2005/03/14 11:08:33  narry
// - update: экспорт аннотаций
//
// Revision 1.55  2005/03/04 15:53:26  narry
// - новинка: реализация импорта Пучин-нср
//
// Revision 1.54  2005/03/02 16:04:09  narry
// - исправление: запрет выливки SortDate для аннотаций
//
// Revision 1.53  2005/02/25 14:34:53  voba
// - при конвертации ID во внешние (fReNumTbl.GetINumber) выключил forced режим
//
// Revision 1.52  2005/02/24 11:50:01  step
// исправлена ProcessDocAndRel (руками Гарри)
//
// Revision 1.51  2005/02/22 15:38:17  step
// new: TDocExportGenerator.ProcessAnnos, TDocExportGenerator.ProcessDocs
//
// Revision 1.50  2005/02/22 15:10:07  step
// начинаем обработку аннотаций
//
// Revision 1.49  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.48  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.47  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.46  2004/07/23 16:44:18  step
// подправлена WriteDocHeader - учитываются кривые Related
//
// Revision 1.45  2004/07/22 14:19:49  voba
// - rename fPriceLevel_Fld ->  fStatus_Fld  PriceLevel ->  Status, который выполняет функцию набора флагов состояния документа (см.dstatChargeFree, dstatNotTM   в  Dt_Const)
//
// Revision 1.44  2004/05/06 12:38:16  narry
// - update: поддержка типа документа DictEntry
//
// Revision 1.43  2004/03/05 16:52:23  step
// чистка кода
//
// Revision 1.42  2003/08/19 18:06:38  step
// В словари добавлено поле NameE и удалено поле NameLen
//
// Revision 1.41  2003/04/16 09:20:34  voba
// - improvement:  у TDocExportGenerator флаг Renum выставлен по-умолчанию
//
// Revision 1.40  2003/03/31 13:48:59  demon
// - new: увеличен размер буферов, выделяемых по умолчанию с 64кб до 8Мб
//
// Revision 1.39  2003/03/13 09:48:57  demon
// - new: добавлена обработка нового поля в данных документа - VerLink
//
// Revision 1.38  2003/03/12 10:32:56  demon
// - del: Внесены изменения в связи с удалением полей
// NoActive и PreActive из таблицы File
//
// Revision 1.37  2003/02/11 10:04:38  voba
// - rename proc: l3NodeActionL2FA -> l3L2IA.
//
// Revision 1.36  2003/01/29 13:54:59  narry
// - bug fix: дублирование ссылок в справках
//
// Revision 1.34  2002/03/15 14:56:20  demon
// - new behavior: exportDictTree now has additional options
//
// Revision 1.33  2002/03/15 09:40:44  demon
// - some fix
//
// Revision 1.32  2002/02/11 14:30:50  voba
// -lib sincro : change some m0 modules to m2
//
// Revision 1.31  2001/11/21 12:50:31  demon
// - new: add new doc attribute - _dictionary #F (dlAccGroups)
//
// Revision 1.30  2001/10/18 07:06:28  demon
// - new behavior: function ExportKeyWordData now has new parametr WithoutAbolished, default value - False
//
// Revision 1.29  2001/09/17 06:52:18  demon
// - byg fix: before unlock family all other tbls now closed, and after unlock all opened
//
// Revision 1.28  2001/08/23 10:27:44  demon
// - add new Type - TDocType its replaced some constants
//
// Revision 1.27  2001/06/04 09:43:15  demon
// - new behavior: TDiapasonRec.Typ = tdSearch now required TSrchServer in OBJ field
// also now from search list exports only filtered documents.
//
// Revision 1.26  2001/01/11 10:59:57  demon
// fix some Delphi Warnings
//
// Revision 1.25  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

{.$DEFINE OnlySpr}

Interface
Uses SysUtils,
     Classes,

     k2Reader,
     l3Types, l3DatLst,

     daTypes,
     HT_Const,
     ddTypes,
     dtIntf, 
     DT_Sab,
     Dt_Types, Dt_Const, dt_AttrSchema,
     Dt_List,
     DT_ReNum,
     Dt_Dict;

Type     
 TDocExportGenerator = Class(Tk2CustomReader)
  private
   f_Listner: Pointer;
   FSpecialAnnotation: Boolean;
   f_AnsiCodePage: Integer;
   f_DoubleRelated: Tl3DataList;
   f_ProcessAnnos: Boolean;
   f_ProcessDocs: Boolean;
   f_ProcessRels: Boolean;
   function pm_GetDocSab: ISab;
   procedure pm_SetDocSab(const Value: ISab);
  protected
   fFamily        : TFamilyID;
   fIsLock        : Boolean;
   fCurValDocSab  : ISab;
   fCurDocSAB     : ISab;
   fCurDocID      : TDocID;
   fReNum         : Boolean;
   fRelated       : Boolean;
   fBreakFlag     : Boolean;

   Function    GetLockFlag : Boolean;
   Procedure   SetLockFlag(aVal : Boolean);
   Procedure   SetReNum(aVal : Boolean);
   Function    GetDocCount : LongInt;
   Function    GetDocIDs : ISAB;

   Procedure   ClearExportData;

   Procedure   GetDoubleRelatedList;
   Function    MayExportRelated(aRelID : LongInt) : Boolean;

   Procedure   GetDictList(aDictTbl : TDictionaryTbl;aTitle : ShortString;
                           aFile : TFileName;aProgress : Tl3ProgressProc);

   Procedure   Cleanup; override;
   Function    IsRelatedDoubled(RelID : LongInt) : Boolean;
   //procedure   PutDocNumbers(aOutStream : Tl3FileStream);

  public
   Constructor Create(anOwner : TComponent; aFamily : TFamilyID); reintroduce;

   Procedure   Read; override;

   //Function    IsRelatedDoubled(RelID : LongInt) : Boolean;

   Procedure   ExportKeyWordData(aFile : TFileName; aProgress : Tl3ProgressProc;
                                 aEmpty : Boolean; WithoutAbolished : Boolean = False);
   Procedure   ExportPriority(aFile : TFileName;aProgress : Tl3ProgressProc);
   Procedure   ExportDictionary(aDictType : TdaDictionaryType; aFile : TFileName;
                                aProgress : Tl3ProgressProc);
   procedure   ExportDictWithLink(aAttrID : TdtAttribute;
                                  aFile     : TFileName;
                                  aProgress : Tl3ProgressProc;
                                  aEmpty    : Boolean;
                                  WithoutAbolished : Boolean);

   procedure LinkListner(const aListner: IddDocumentListner);
   procedure UnLinkListner(const aListner: IddDocumentListner);

   procedure ExportAnnoClassData(aFile : TFileName; aProgress : Tl3ProgressProc; aEmpty : Boolean; WithoutAbolished : Boolean = False);
   function GetRelatedIDs: ISab;
   function RelatedCount(out aAnnoCount: Integer): Integer;

   property AnsiCodePage: Integer read f_AnsiCodePage write f_AnsiCodePage;
   property  CurDocID : TDocID read fCurDocID;
   {Текущий выливаемый документ, используется в TExportFilter, для выяснения от какого дока эта справка}
   {Lock Family, private access to base, while export
         default False}
   Property    LockFamily : Boolean read GetLockFlag write SetLockFlag;
   {Renumerate, from Internal IDs to External IDs,
         default True}
   Property    ReNum      : Boolean read fReNum write SetReNum;

   {Count of Export documents}
   Property    DocCount   : LongInt read GetDocCount;
   {SAB of Export documents IDs}
   Property    DocIDList  : ISab read GetDocIDs;
   {Break Process flag, default False}
   property    BreakFlag  : Boolean read fBreakFlag write fBreakFlag;
   property DocSab: ISab read pm_GetDocSab write pm_SetDocSab;
   property    DoubleRelated: Tl3DataList read f_DoubleRelated write f_DoubleRelated;
   property    ProcessAnnos: Boolean read f_ProcessAnnos write f_ProcessAnnos;
   property    ProcessDocs: Boolean read f_ProcessDocs write f_ProcessDocs;
   property ProcessRels: Boolean read f_ProcessRels write f_ProcessRels;
   property SpecialAnnotation: Boolean
   { SpecialAnnotation - если установлен, то для аннотаций дополнительно выливаются
                         Имя документа, Важность и Информация о регистрации в Минюсте }
     read FSpecialAnnotation
     write FSpecialAnnotation;
 end;

Implementation
Uses
     HT_Dll,
     WinTypes,
     l3Base, l3RecList, l3Chars, l3Tree_TLB, l3Nodes, l3Stream,  l3TreeInterfaces,
     k2Tags,
     m2xltlib,
     daInterfaces,
     daDataProvider,
     dt_ImpExpTypes,
     Dt_Doc, Dt_Link, Dt_LinkServ, Dt_Err, dt_Log, Dt_Lock,
     l3String, l3Date,
     Dt_Prior, Dt_User,
     dt_DictExport,
     l3FieldSortRecList
     , l3Interfaces, l3languages,

     AnnoTopic_Const,
     DictEntry_Const,
     Document_Const
     , dt_DictConst, dt_DictIntf, l3LongintList, l3LongintListPrim;
Const
 ExportFldCount = 14;
 ExportFldArr : Array[1..ExportFldCount] of SmallInt =
                               (fId_Fld,fType_Fld,fSName_Fld,fFName_Fld,
                                fStatus_Fld,fPriority_fld,fSDate_Fld,
                                fUserType_Fld,fRelated_fld,fPriorFlag_fld,
                                fVerLink_fld, fHasAnno_fld, fUrgency_fld, fComment_fld);
Type
 PGetExpRec = ^TGetExpRec;
 TGetExpRec = Record
               ID            : LongInt;
               InternalType  : Byte;
               ShortName     : TShortNameStr;
               FullName      : TFullNameStr;
               Status        : Word;
               Priority      : Word;
               SortDate      : TStDate;
               Flag          : Byte;
               Related       : TDocID;
               PriorFlag     : Boolean;
               VerLink       : TDocID;
               HasAnno       : Boolean;
               Urgency       : Byte;
               Comment       : TDocCommentStr;
              end;

Constructor TDocExportGenerator.Create(anOwner : TComponent;
                                       aFamily : TFamilyID);
Begin
 Inherited Create(anOwner);
 fFamily:=aFamily;
 fCurDocID:=cUndefDocID;
 fBreakFlag:=False;
 fRelated:=False;
 f_DoubleRelated:=Tl3DataList.CreateSize(SizeOf(TDocID));
 ReNum:=True;
end;

Procedure TDocExportGenerator.Cleanup;
Begin
 f_Listner := nil;
 ClearExportData;
 L3Free(f_DoubleRelated);
 Inherited;
end;

Procedure TDocExportGenerator.ClearExportData;
Begin
 fCurDocSAB := nil;
 fCurValDocSab := nil;
 fCurDocID:=cUndefDocID;
 fRelated:=False;
 fBreakFlag:=False;
 f_DoubleRelated.Clear;
end;

Function TDocExportGenerator.GetLockFlag : Boolean;
Begin
 Result:=fIsLock;
end;

procedure TDocExportGenerator.SetLockFlag(aVal : Boolean);
begin
 if aVal then
 begin
  if not fIsLock then
   fIsLock := LockServer.LockFamily(fFamily);
 end
 else
 begin
  if fIsLock then
   LockServer.UnLockFamily(fFamily);
  fIsLock := False;
 end;
end;

procedure TDocExportGenerator.SetReNum(aVal : Boolean);
Begin
 fReNum := aVal;
end;

function TDocExportGenerator.GetDocCount : LongInt;
Begin
 Result := fCurDocSAB.Count;
end;

function TDocExportGenerator.GetDocIDs : ISAB;
begin
 Result := fCurValDocSAB;
end;

procedure TDocExportGenerator.GetDoubleRelatedList;
var
 lSab  : ISab;
 lRAProcStub : TdtRecAccessProc;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  if PDocID(aItemPtr)^ <> 0 then
   f_DoubleRelated.Add(aItemPtr);
 end;

begin
 lSab := MakeSabCopy(fCurDocSAB);
 lSab.ValuesOfKeyByCount(fRelated_fld);

 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  lSab.IterateRecords(lRAProcStub, []);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;
end;

function TDocExportGenerator.MayExportRelated(aRelID : LongInt) : Boolean;
var
 lIndex : Longint;
begin
 Result := True;
 if (f_DoubleRelated = nil) or (f_DoubleRelated.Count = 0) then Exit;

 lIndex := f_DoubleRelated.IndexOfData(aRelID, f_DoubleRelated.DataSize, 0);
 if lIndex <> -1 then
  if f_DoubleRelated.Select[lIndex] then
   Result := False
  else
   f_DoubleRelated.Select[lIndex] := True;
end;

function TDocExportGenerator.IsRelatedDoubled(RelID : LongInt) : Boolean;
var
 TmpIndex : Longint;
begin
 Result := False;
 if (f_DoubleRelated = nil) or (f_DoubleRelated.Count = 0) then Exit;

 TmpIndex := f_DoubleRelated.IndexOfData(RelID, f_DoubleRelated.DataSize,0);
 if TmpIndex <> -1 then
  Result := f_DoubleRelated.Select[TmpIndex];
end;

procedure TDocExportGenerator.Read;
const
 cCodePageConv : array[boolean] of Integer = (CP_OEM, CP_ANSI);
var
 lDocRec : PGetExpRec;
 //TmpCardRec : TExpCardRec;
 RelID      : TDocID;
 I          : LongInt;
 TmpSize    : Word;
 lStr       : Tl3PCharLen;

 procedure WriteDocHeader;
 var
  lExtID : TDocID;
 begin
  Generator.AddIntegerAtom(k2_tiInternalHandle,fCurDocID);

  lExtID := LinkServer(fFamily).Renum.GetExtDocID(fCurDocID);

  if lExtID <> cUndefDocID then
   Generator.AddIntegerAtom(k2_tiExternalHandle, lExtID);

  if lDocRec.InternalType <> Ord(dtDictEntry) then
   Generator.AddIntegerAtom(k2_tiType,lDocRec.InternalType);

  if TUserType(lDocRec.Flag)<>utNone then
   Generator.AddIntegerAtom(k2_tiUserType,lDocRec.Flag);

  if lDocRec.InternalType <> Ord(dtDictEntry) then
  begin
   lStr := l3ArrayToPCharLen(lDocRec.ShortName, SizeOf(lDocRec.ShortName));
   if lStr.SLen > 0 then
    Generator.AddStringAtom(k2_tiShortName, lStr);
  end;

  lStr := l3ArrayToPCharLen(lDocRec.FullName, SizeOf(lDocRec.FullName));
  if lStr.SLen > 0 then
   Generator.AddStringAtom(k2_tiName, lStr);

  Generator.AddIntegerAtom(k2_tiPriceLevel,lDocRec.Status);
  if lDocRec.PriorFlag then
   Generator.AddIntegerAtom(k2_tiPriority,lDocRec.Priority);
  if lDocRec.SortDate<>0 then
   Generator.AddIntegerAtom(k2_tiSortDate,lDocRec.SortDate);

  if lDocRec.Related <> 0 then
  begin
   RelID := lDocRec.Related;
   if fReNum then
    lDocRec.Related := LinkServer(fFamily).Renum.GetExtDocID(lDocRec.Related);

   if lDocRec.Related <> cUndefDocID then
    Generator.AddIntegerAtom(k2_tiRelExternalHandle,lDocRec.Related)
   else
    RelID := cUndefDocID;
  end;
  if lDocRec.VerLink <> 0 then
  begin
   if fReNum then
    lDocRec.VerLink := LinkServer(fFamily).Renum.GetExtDocID(lDocRec.VerLink);
   if lDocRec.VerLink <> cUndefDocID then
    Generator.AddIntegerAtom(k2_tiExternalVerLink,lDocRec.VerLink);
  end;
  if lDocRec.Urgency <> 0 then
   Generator.AddIntegerAtom(k2_tiUrgency, lDocRec.Urgency);

  lStr := l3ArrayToPCharLen(lDocRec.Comment, SizeOf(lDocRec.Comment));
  if lStr.SLen > 0 then
   Generator.AddStringAtom(k2_tiNameComment, lStr);
 end;

 procedure WriteAnnoHeader;
 var
  lExtID : TDocID;
 begin
  Generator.AddIntegerAtom(k2_tiInternalHandle, fCurDocID);
  Generator.AddIntegerAtom(k2_tiType, Integer(dtAnnotation));

  lExtID := LinkServer(fFamily).Renum.GetExtDocID(fCurDocID);
  if lExtID <> cUndefDocID then
   Generator.AddIntegerAtom(k2_tiExternalHandle, lExtID);

  if SpecialAnnotation then
  begin
   lStr := l3ArrayToPCharLen(lDocRec.FullName, SizeOf(lDocRec.FullName));
   if lStr.SLen > 0 then
    Generator.AddStringAtom(k2_tiName, lStr);
   if lDocRec.PriorFlag or SpecialAnnotation then
    Generator.AddIntegerAtom(k2_tiPriority, lDocRec.Priority);
  end; // SpecialAnnotation
 end;

 procedure WriteRelHeader;
 var
  lExtID : TDocID;
 begin
  if RelID > 0 then
  begin
   Generator.AddIntegerAtom(k2_tiInternalHandle, RelID);
   Generator.AddIntegerAtom(k2_tiType, Integer(dtRelText));
   if fReNum then
   begin
    RelID := LinkServer(fFamily).Renum.GetExtDocID(RelID);
    lExtID := RelID;
   end
   else
    lExtID := LinkServer(fFamily).Renum.GetExtDocID(fCurDocID);

   if lExtID <> cUndefDocID then
    Generator.AddIntegerAtom(k2_tiExternalHandle, lExtID);
  end; // RelID > 0
 end;

 procedure ProcessDocAndRel;
 begin
  if f_ProcessAnnos and lDocRec.HasAnno and not(TUserType(lDocRec.Flag) in [utEdition]) then
  begin
   Generator.StartChild(k2_typAnnoTopic);
   try
    WriteAnnoHeader;
   finally
    Generator.Finish;
   end;
  end;

  if f_ProcessDocs or f_ProcessRels then
  begin
   try
   if f_ProcessDocs then
   begin
    if (lDocRec.InternalType = Ord(dtDictEntry)) then
     Generator.StartChild(k2_typDictEntry)
    else
     Generator.StartChild(k2_typDocument);
    try
     WriteDocHeader;
    finally
     Generator.Finish;
    end;
   end; // f_ProcessDocs

   if f_ProcessRels then
   begin
    if not f_ProcessDocs then
    begin
     RelID := lDocRec.Related;
     if lDocRec.Related <> 0 then
     begin
      if fReNum then
       lDocRec.Related := LinkServer(fFamily).Renum.GetExtDocID(lDocRec.Related);
     end; // lDocRec.Related <> 0
    end; // not f_ProcessDocs
    if (RelID > 0) and (RelID <> cUndefDocID) and MayExportRelated(RelID) then
    begin
     Generator.StartChild(k2_typDocument);
     try
      WriteRelHeader;
     finally
      Generator.Finish;
     end;
    end; // (RelID <> cUndefDocID) and MayExportRelated(RelID)
   end; // f_ProcessRels
   except
    on E: Exception do
    begin
     l3System.Exception2Log(E);
     if f_Listner <> nil then
      IddDocumentListner(f_Listner).NeedDeleteFileData;
    end;
   end;
  end; // f_ProcessDocs or f_ProcessRels
 end; // ProcessDocAndRel

var
 lSabCursor : ISabCursor;
begin
 fCurDocSAB.Sort(docIdFld);
 lSabCursor := fCurDocSAB.MakeSabCursor(ExportFldArr, cmForward);
 for I := 0 to Pred(lSabCursor.Count) do
  begin
   if fBreakFlag then Break;
   RelID := cUndefDocID;
   lDocRec := lSabCursor.GetItem(I);
   fCurDocID  := lDocRec^.ID;

   ProcessDocAndRel;
  end;
end;

procedure TDocExportGenerator.ExportKeyWordData(aFile     : TFileName;
                                                aProgress : Tl3ProgressProc;
                                                aEmpty    : Boolean;
                                                WithoutAbolished : Boolean);
begin
 ExportDictWithLink(atKeyWords, aFile, aProgress, aEmpty, WithoutAbolished);
end;

procedure TDocExportGenerator.ExportAnnoClassData(aFile     : TFileName;
                                                aProgress : Tl3ProgressProc;
                                                aEmpty    : Boolean;
                                                WithoutAbolished : Boolean);
begin
 ExportDictWithLink(atAnnoClasses, aFile, aProgress, aEmpty, WithoutAbolished);
end;


procedure TDocExportGenerator.ExportDictWithLink(aAttrID : TdtAttribute;
                                                  aFile     : TFileName;
                                                  aProgress : Tl3ProgressProc;
                                                  aEmpty    : Boolean;
                                                  WithoutAbolished : Boolean);

procedure PutDocNumbers(aOutStream : Tl3FileStream);
 const
  lComma : AnsiString = ';';
  lEOL   = #13#10;
 var
  lSab : ISab;
  lRAProcStub : TdtRecAccessProc;
  lStr : AnsiString;
  //lFirst : Boolean;

  function lRecAccessProc(aItemPtr : Pointer) : Boolean;
  begin
   Result := True;
   lStr := IntToStr(PInteger(aItemPtr)^);
   //if not lFirst then
   aOutStream.Write(lComma[1], 1);
   //lFirst := False;
   aOutStream.Write(lStr[1], Length(lStr));
  end;

 begin
  lSab := MakeSabCopy(fCurValDocSab);
  lSab.TransferToPhoto(rnRealID_fld, LinkServer(fFamily).Renum);
  lSab.RecordsByKey;
  lSab.ValuesOfkey(rnImportID_fld);

  //lFirst := True;
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
  aOutStream.Write(lEOL, 2);
 end;

type
 PLinkRec = ^TLinkRec;
 TLinkRec = record
  rDictID : TDictID;
  rDocID  : TDocID;
  rSubID  : TSubID;
 end;
 {запись с переставленными полями, так как она лежит в lLinkRecList}

Var
 lOutStream : Tl3FileStream;

 KWLinkSab,
 TmpSab,
 TmpSab1,
 SortSab   : Sab;

 ProgInd  {, I}         : LongInt;
 SortCount : SmallInt;
 lOutString : AnsiString;

 lLinkRecList : Tl3FieldSortRecList;
 lSaveParentNode : Il3Node;

 lSubLinkDicts : boolean;

 procedure lWriteStringLN(var lOutStr : AnsiString);
 var
  lOutStrLen : Integer;
 begin
  lOutStr :=lOutStr + #13#10;
  lOutStrLen := Length(lOutStr);
  m2XLTConvertBuff(PAnsiChar(lOutStr), lOutStrLen, Cm2XLTANSI2OEM);
  lOutStream.Write(lOutStr[1], Length(lOutStr));
 end;

 //DictionCommands[cAttrPassport[aAttrID].rDict]

 function IterHandlerForEmpty(CurNode : Il3Node) : Boolean;
 var
  lHandle : Longint;
  lIndex  : Integer;
 begin
  if Assigned(aProgress) then
  begin
   aProgress(piCurrent, ProgInd, '');
   Inc(ProgInd);
  end;

  if CurNode.HasChild then
   lOutString := DictionCommands[cAttrPassport[aAttrID].rDict]+' ' + l3PCharLen2String(CurNode.Text)
  else
   lOutString := '     ' + l3PCharLen2String(CurNode.Text);

  lWriteStringLN(lOutString);

  Result := False;
 end;

 function IterHandler(CurNode : Il3Node) : Boolean;
 var
  lHandle : Longint;
  lIndex  : Integer;
  lDocId  : TDocID;
 begin
  if Assigned(aProgress) then
  begin
   aProgress(piCurrent,ProgInd,'');
   Inc(ProgInd);
  end;

  if CurNode.HasChild then
   lSaveParentNode := CurNode
  else
  begin
   lHandle := (CurNode as Il3HandleNode).Handle;
   if lLinkRecList.FindPart(lHandle, 1, lIndex) then
   begin
    // Выводим !KEY
    if lSaveParentNode <> nil then
    begin
     lOutString := DictionCommands[cAttrPassport[aAttrID].rDict]+' ' + l3PCharLen2String(lSaveParentNode.Text); // (lSaveParentNode as IDictItem).Name.AsString;
     lWriteStringLN(lOutString);
     lSaveParentNode := nil;
    end;

    lOutString := '     ' + l3PCharLen2String(CurNode.Text) + ':';

    // добавляем список адресов в строку
    while lIndex < lLinkRecList.Count do
     with PLinkRec(lLinkRecList.ItemSlot(lIndex))^ do
      if rDictID = lHandle then
      begin
       lDocID := rDocID;
       if fReNum then
        lDocID := LinkServer(fFamily).Renum.GetExtDocID(lDocID);

       if lSubLinkDicts and (rSubID > 0) then
        lOutString := lOutString + Format(' %d.%d', [lDocID, rSubID])
       else
        lOutString := lOutString + Format(' %d', [lDocID]);
       Inc(lIndex);
      end
      else
       Break;

    lWriteStringLN(lOutString);
   end;
  end;

  Result := False;
 end;
var
 lFldArr : TSmallIntArray;
 lDictSab : ISab;
 lLogSab  : ISab;
const
 lAction : TLogActionType = acAbolished;
Begin
 lSubLinkDicts := cAttrPassport[aAttrID].rDict in sSubLinkDicts;

 lOutStream := Tl3FileStream.Create(aFile, l3_fmCreateReadWrite);
 Try
  If fReNum then LinkServer(fFamily).Renum.Buffered:=True;
  Try
   DictServer(fFamily).ReloadDict(cAttrPassport[aAttrID].rDict);

   if not aEmpty then
    begin
     lDictSab := MakeSabCopy(fCurValDocSab);
     lDictSab.TransferToPhoto(lnkDocIDFld, LinkServer(fFamily)[aAttrID]);
     lDictSab.RecordsByKey;

     if WithoutAbolished then
     begin
      lLogSab := MakeSab(LinkServer(fFamily).LogBook);
      lLogSab.Select(lgAction_key, lAction);
      lLogSab.ValuesOfKey(lgDocID_Key);
      lLogSab.RecordsByKey(lnkDocIDFld, lDictSab);
      lDictSab.SubtractSab(lLogSab);
     end;

     lDictSab.Sort([lnkDictIDFld, lnkDocIDFld, lnkSubIDfld]);


     lLinkRecList := dtMakeRecListBySab(lDictSab, [lnkDictIDFld, lnkDocIDFld, lnkSubIDfld], [1,2,3]);
     try
      if Assigned(aProgress) then
       aProgress(piStart, DictServer(fFamily).DictTbl[cAttrPassport[aAttrID].rDict].ItemList.Count, Format('Экспорт "%s"', [cAttrPassport[aAttrID].rName]));

      PutDocNumbers(lOutStream);
      ProgInd := 1;
      l3IterateSubTreeF(DictServer(fFamily).DictRootNode[cAttrPassport[aAttrID].rDict],l3L2NA(@IterHandler),0);

      if Assigned(aProgress) then
       aProgress(piEnd, 0, '');
     finally
      l3Free(lLinkRecList);
     end;
    end //if not aEmpty then
    else
    begin
     if Assigned(aProgress) then
      aProgress(piStart, DictServer(fFamily).DictTbl[cAttrPassport[aAttrID].rDict].ItemList.Count, Format('Экспорт "%s"', [cAttrPassport[aAttrID].rName]));

     ProgInd := 1;
     l3IterateSubTreeF(DictServer(fFamily).DictRootNode[cAttrPassport[aAttrID].rDict], l3L2NA(@IterHandlerForEmpty), 0);

     if Assigned(aProgress) then
      aProgress(piEnd, 0, '');
    end;
  finally
   If fReNum then LinkServer(fFamily).Renum.Buffered := False;
  end;
 finally
  l3Free(lOutStream);
 end;
end;

Procedure TDocExportGenerator.ExportPriority(aFile : TFileName;aProgress : Tl3ProgressProc);
Var
 tmpPrior : TPriorTbl;
Begin
 tmpPrior:=TPriorTbl.Create(fFamily);
 Try
  tmpPrior.ExportPriorityToFile(aFile,aProgress);
 finally
  l3Free(tmpPrior);
 end;
end;

procedure TDocExportGenerator.GetDictList(aDictTbl : TDictionaryTbl; aTitle : ShortString;
                                          aFile : TFileName; aProgress : Tl3ProgressProc);
const
 Suffix   : Array [1..2] of AnsiChar = #13#10;
 Perforat : AnsiChar = #9;
var
 lOutStream : Tl3FileStream;
 ProgInd  : LongInt;
 TmpID    : TDictID;
 TmpStr   : ShortString;
 TmpName  : PAnsiChar;
 lAllRecSab : Sab;
Begin
 ProgInd := 1;

 lOutStream := Tl3FileStream.Create(aFile, l3_fmCreateReadWrite);
 Try
  lAllRecSab := aDictTbl.MakeAllRecordsSab;
  try
   If lAllRecSab.gFoundCnt=0 then
     exit;

   If Assigned(aProgress) then
    aProgress(piStart,lAllRecSab.gFoundCnt,aTitle);

   Ht(htOpenResults(lAllRecSab,ROPEN_BODY,Nil,0));
   Try
    While htReadResults(lAllRecSab,
                        aDictTbl.FullRecord,
                        aDictTbl.RecSize)<>0 do
     Begin
      If Assigned(aProgress)
       then
        Begin
         aProgress(piCurrent,ProgInd,'');
         Inc(ProgInd)
        end;

      aDictTbl.GetFromFullRec(dtIDFld,TmpID);
      TmpStr:=IntToStr(TmpID);
      lOutStream.Write(TmpStr[1],Length(TmpStr));
      lOutStream.Write(Perforat,1);
      If (aDictTbl.DictType = da_dlBases) or
         (aDictTbl.DictType = da_dlAccGroups) then
       Begin
        aDictTbl.GetFromFullRec(dtShNameFld,TmpName);
        Try
         m2XLTConvertBuff(TmpName,StrLen(TmpName),Cm2XLTANSI2OEM);
         lOutStream.Write(TmpName^,StrLen(TmpName));
         lOutStream.Write(Perforat,1);
        finally
         l3StrDispose(TmpName);
        end;
       end;
      aDictTbl.GetFromFullRec(dtNameRFld,TmpName);
      Try
       m2XLTConvertBuff(TmpName,StrLen(TmpName),Cm2XLTANSI2OEM);
       lOutStream.Write(TmpName^,StrLen(TmpName));
      finally
       l3StrDispose(TmpName);
      end;
      lOutStream.Write(Suffix, 2);
     end;
   finally
    htCloseResults(lAllRecSab);
   end;
  finally
    htClearResults(lAllRecSab);
  end;
 finally
  If Assigned(aProgress) then
   aProgress(piEnd, 0, '');

  l3Free(lOutStream);
 end;
end;

Procedure TDocExportGenerator.ExportDictionary(aDictType : TdaDictionaryType;
                                               aFile : TFileName;
                                               aProgress : Tl3ProgressProc);
begin
 Case aDictType of
  da_dlSources :
   ExportDictTree(DictServer(ffamily), aDictType,aFile,False,aProgress,'Экспорт Исходящих органов');
  da_dlTypes :
   ExportDictTree(DictServer(ffamily), aDictType,aFile,False,aProgress,'Экспорт Типов');
  da_dlClasses :
   ExportDictTree(DictServer(ffamily), aDictType,aFile,False,aProgress,'Экспорт Классификатора');
  da_dlBases :
   GetDictList(DictServer(ffamily).DictTbl[aDictType],'Экспорт Групп документов',aFile,aProgress);
  da_dlCorSources :
   GetDictList(DictServer(ffamily).DictTbl[aDictType],'Экспорт Источников публикаций',aFile,aProgress);
  da_dlPrefixes :
   ExportDictTree(DictServer(ffamily), aDictType,aFile,False,aProgress,'Экспорт Prefix');
  da_dlTerritories :
   ExportDictTree(DictServer(ffamily), aDictType,aFile,False,aProgress,'Экспорт Территорий');
  da_dlNorms :
   GetDictList(DictServer(ffamily).DictTbl[aDictType],'Экспорт Норм права',aFile,aProgress);
  da_dlAccGroups :
   GetDictList(DictServer(ffamily).DictTbl[aDictType],'Экспорт Групп доступа',aFile,aProgress);
 end;
end;

function TDocExportGenerator.GetRelatedIDs: ISab;
var
 lVal: Integer;
begin
 Result := MakeSabCopy(fCurDocSAB);
 lVal:= 0;
 Result.SubSelect(fRelated_fld, lVal, NOT_EQUAL);
 Result.ValuesOfKey(fRelated_fld);
end;

function TDocExportGenerator.pm_GetDocSab: ISab;
begin
 Result := fCurDocSAB;
end;

procedure TDocExportGenerator.pm_SetDocSab(const Value: ISab);
begin
 if Value.IsValid then
 begin
  fCurDocSAB := MakeSabCopy(Value);
  // принудительно переводим на таблицу File
  fCurDocSAB.TransferToPhoto(docIdFld, DocumentServer.FileTbl);
  fCurDocSAB.RecordsByKey(docIdFld);

  fCurValDocSAB := MakeSabCopy(fCurDocSAB);
  fCurValDocSAB.ValuesOfkey(docIdFld);

  GetDoubleRelatedList;
  GlobalDataProvider.Journal.LogExport(fFamily, fCurDocSAB.Count);
 end; 
end;

function TDocExportGenerator.RelatedCount(out aAnnoCount: Integer): Integer;
var
 lSab : ISab;
 lVal : Integer;
begin
 lSab := MakeSabCopy(fCurDocSAB);
 lVal:= 0;
 lSab.SubSelect(fRelated_fld, lVal, NOT_EQUAL);
 lSab.ValuesOfKey(fRelated_fld);
 Result := lSab.Count;

 lSab := MakeSabCopy(fCurDocSAB);
 lVal := 0;
 lSab.SubSelect(fHasAnno_fld, lVal, GREAT);

 lVal := Byte(utEdition);
 lSab.SubSelect(fUserType_Fld, lVal, NOT_EQUAL);
 aAnnoCount := lSab.Count;
end;

procedure TDocExportGenerator.LinkListner(
  const aListner: IddDocumentListner);
begin
 f_Listner := Pointer(aListner);
end;

procedure TDocExportGenerator.UnLinkListner(
  const aListner: IddDocumentListner);
begin
 f_Listner := nil;
end;

end.
