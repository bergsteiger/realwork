unit ddDocumentCopy;
{ Объект для создания недействующей копии документа }

{ $Id: ddDocumentCopy.pas,v 1.64 2015/10/27 07:32:05 lukyanets Exp $ }

// $Log: ddDocumentCopy.pas,v $
// Revision 1.64  2015/10/27 07:32:05  lukyanets
// Подставляем пользователя от задачи
//
// Revision 1.63  2015/05/20 14:02:21  lulin
// - рисуем на модели.
//
// Revision 1.62  2015/03/31 14:09:09  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.61  2014/09/05 11:51:50  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.60  2014/05/21 14:35:39  voba
// - cc
//
// Revision 1.59  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.58  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.57  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.56  2010/07/09 12:21:16  voba
// k: 217685769
//
// Revision 1.55  2010/04/12 07:44:28  voba
// - [K:175966641]
//
// Revision 1.54  2009/12/18 08:34:04  voba
// - копируем Stage при переворачивании редакций
//
// Revision 1.53  2009/09/14 13:13:53  voba
// - [$83036660]
//
// Revision 1.52  2009/09/07 10:17:45  voba
// - opt. Убрали ненужную буфферизацию бинарных данных
//
// Revision 1.51  2009/08/28 14:36:26  voba
// - убрал utFullFeatureDocTypesEx
//
// Revision 1.50  2009/06/08 13:23:22  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.49  2009/02/11 07:41:29  voba
// - bug fix
//
// Revision 1.48  2009/01/11 08:21:02  voba
// - bug fix
//
// Revision 1.47  2008/04/30 06:30:41  voba
// no message
//
// Revision 1.46  2007/10/12 12:34:37  voba
// - bug fix
//
// Revision 1.45  2007/10/09 08:54:06  voba
// - merge with b_archi_export_refact2
//
// Revision 1.44.4.2  2007/09/17 10:53:15  voba
// no message
//
// Revision 1.44.4.1  2007/09/14 15:49:44  voba
// no message
//
// Revision 1.44  2007/09/10 13:51:35  voba
// - bug fix
//
// Revision 1.43  2007/08/21 11:08:38  voba
// no message
//
// Revision 1.42  2007/08/14 14:30:05  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.41  2007/08/13 14:17:35  voba
// - add TAddDocAttributeFilter..AddDocID
//
// Revision 1.40.2.4  2007/09/11 15:07:11  voba
// no message
//
// Revision 1.40.2.3  2007/09/11 14:11:32  voba
// no message
//
// Revision 1.40.2.2  2007/08/27 13:12:50  voba
// no message
//
// Revision 1.40.2.1  2007/08/20 06:31:10  voba
// no message
//
// Revision 1.40  2007/07/19 07:18:54  voba
// - add ReverseHlinkRenum
//
// Revision 1.39.2.2  2007/07/17 15:53:23  voba
// no message
//
// Revision 1.39.2.1  2007/07/13 14:38:54  voba
// no message
//
// Revision 1.39  2007/04/10 11:04:35  voba
// - bug fix от Дудко
//
// Revision 1.38  2007/04/03 12:57:37  narry
// - новые методы: сохранение/чтение из файла
//
// Revision 1.37  2007/01/11 08:27:28  voba
// no message
//
// Revision 1.36  2006/12/11 14:53:22  voba
// - use utFullFeatureDocTypes
//
// Revision 1.35  2006/10/05 09:55:18  voba
// - убрал режимы импорта
//
// Revision 1.34  2006/08/23 14:48:20  voba
// - cleanup
//
// Revision 1.33  2006/06/05 13:56:25  voba
// - _move CdtNextEditionAttributes, CdtOldEditionAttributes to ddDocumentCopy
//
// Revision 1.32  2005/07/25 13:07:18  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.31  2005/05/24 08:38:56  lulin
// - bug fix: не компилировалось.
//
// Revision 1.30  2005/05/16 11:01:13  voba
// -add askAllAttributeswoAnno
//
// Revision 1.29  2005/04/18 13:34:31  voba
// -bug fix: при копировании документа у всех подвисал Архивариус
//
// Revision 1.28  2005/04/12 11:14:47  narry
// - update: борьба с залочками
//
// Revision 1.27  2005/02/25 09:53:37  narry
// - update: изменение параметров вызова событий
//
// Revision 1.26  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.25  2004/10/13 12:14:11  voba
// - bug fix при utNone справка съедалась
//
// Revision 1.24  2004/08/30 12:15:40  step
// TAddDocAttributeFilter получил новое свойство RecalcHyperLinks
//
// Revision 1.23  2004/08/30 10:58:54  law
// - remove class: TmgBasePackageTagFilter.
// - new unit: m3DocumentInfoFilter.
//
// Revision 1.22  2004/08/27 15:13:30  voba
// - merge with B_New_Text_Base
//
// Revision 1.21.4.2  2004/08/25 16:36:24  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.21.4.1  2004/08/25 16:11:39  law
// - постепенно отказываемся от прямого использования старого хранилища.
//
// Revision 1.21  2004/05/31 13:59:16  narry
// no message
//
// Revision 1.20  2004/05/14 17:27:04  law
// - remove unit: evStrGen.
//
// Revision 1.19  2003/12/29 12:41:16  voba
// -tuning
//
// Revision 1.18  2003/12/24 16:00:49  voba
// -parameter tuning
//
// Revision 1.17  2003/12/02 08:18:32  voba
// no message
//
// Revision 1.16  2003/11/25 14:32:58  voba
// no message
//
// Revision 1.15  2003/10/31 17:21:25  voba
// - rename const
//
// Revision 1.14  2003/10/30 09:20:31  voba
// - new behavior : более гибкая настройка параметров для фильтрации атрибутов
//
// Revision 1.13  2003/10/02 13:49:27  voba
// no message
//
// Revision 1.12  2003/09/22 13:52:32  voba
// -enhance: procedure MakeCopy добавил параметр; aAttrSetKind - указывает на набор параметров, которые необходимо копировать
//
// Revision 1.11  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.10  2003/04/10 12:15:16  narry
// - add: процедура прогресса
// - change: замена SetFilter на ImportFilter
//
// Revision 1.9  2003/04/09 12:31:50  voba
// no message
//
// Revision 1.8  2003/04/09 12:06:50  voba
// no message
//
// Revision 1.7  2003/04/09 11:03:59  narry
// - update
//
// Revision 1.6  2003/04/07 14:27:14  narry
// - cleanup
// - add: команды лога
//

{$I ddDefine.inc }

{$Define Filter}

interface

Uses
 l3Base, l3Filer, l3Types,
 evdWriter, evEvdRd,
 dt_Types, Dt_Const,
 m3DBInterfaces;

type
 TddAttrSetKind = (askAllAttributes, askAllAttributeswoAnno, askMakeNextEdition, askMakeOldEdition, askCopyToOldEdition);

 TddDocumentCopier = class(Tl3Base)
 {* Объект для создания недействующей копии документа }
 private
  f_Family: TFamilyID;
  f_UserID: TDictID;
  f_CustomID: Longint;
  f_evWriter: TevdNativeWriter;
  f_Reader: TevEvdReader;
  f_Filer: Tl3CustomFiler;
  f_ProgressProc: Tl3ProgressProc;
  procedure WriteIDSwitch(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
  function GenerateID(Sender: TObject): Tm3DBStreamIndex;
  procedure ReadIDSwitch(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
 public
  constructor Create; override;
  procedure MakeCopy(aInternalSourceID, aInternalDestinationID: Integer;
                     aAttrSetKind : TddAttrSetKind;
                     aReverseHlinkRenum : boolean = false;
                     aCopyType : TUserType = utEdition;
                     aAddAttrDocID : TDocID = 0);
  {* - Процедура создания копии документа
        InternalSourceID - внутренний номер исходного документа
        ExternalDestinationID - внешний номер создаваемой копии;
        aAttrSetKind - тип набора копируемых атрибутов
        aCopyType - тип документа-копии }

  procedure WriteToFile(aInternalSourceID, aInternalCopyID : TDocID;
                        aAttrSetKind: TddAttrSetKind;
                        aFileName: AnsiString;
                        aCopyType: TUserType = utEdition);

  procedure ReadFromFile(const aFileName: AnsiString);
 public
  property Family: TFamilyID
  {* семейство }
   read f_Family
   write f_Family;
  property UserID: TDictID
  {* идентификатор пользователя, от имени которого создается копия.
     По умолчанию - текущий}
   read f_UserID
   write f_UserID;
  property ProgressProc: Tl3ProgressProc
  {* процедура выполнения процесса  }
   read f_ProgressProc
   write f_ProgressProc;
 end;

implementation
Uses
 daDataProvider,
 dt_AttrSchema,
 dt_User, dt_EditionFltr, dt_IFltr,
 dt_Serv, dt_EGen, dt_EFltr, ddFixFilter,
 evExportGenerator,  evHndFlt,
 SysUtils,
 k2TagGen,
 l3Prg,
 m3DB, m3StorageInterfaces
 {$IfDef Filter}
 ,
 m3DocumentInfoFilter
 {$EndIf Filter}
 ,
 m3DBFiler
 , daInterfaces;

const
 (* Атрибуты, которые нужно прочесть при создании будущей редакции документа *)
 CdtNextEditionAttributes  = CdtAllFilterAttributes - [atRelated,
                             atActiveIntervals, atLogRecords,
                             atKeyWords, atClasses, atPrefixes,
                             atStages, atVerLink,
                             atPublisheds,
                             atServiceInfo,
                             {atPriority,} // поремлено по просьбе И. Гросс 10.01.2007
                             atNotTM];

 (* Атрибуты, которые нужно прочесть при создании прошлой редакции документа *)
 CdtOldEditionAttributes  = [atShortName, atFullName, atBases, atActiveIntervals,
                             atAccGroups, atVerLink, atDateNums, atNotTM,
                             atHLink, atSub];

 (* Атрибуты, которые нужно прочесть при копировании текущей редакции документа в прошлую при "переворачивании" версий *)
 CdtCopyDocToOldEditionAttributes  = [atShortName, atFullName, atBases, atActiveIntervals,
                                      atAccGroups, atVerLink, atDateNums, atNotTM, atLogRecords,
                                      atStages,
                                      atHLink, atSub];


 (* Атрибуты, которые нужно СЛОЖИТЬ при создании текущей редакции из будущей *)
 CdtAddedAttributes = [atClasses, atPrefixes, atKeyWords, atPublisheds, atServiceInfo];

{ TddDocumentCopier }
constructor TddDocumentCopier.Create;
begin
 inherited;
 f_Family:= 1;
 f_UserID:= GlobalDataProvider.ImpersonatedUserID;
end;

procedure TddDocumentCopier.MakeCopy(aInternalSourceID, aInternalDestinationID: Integer;
                                     aAttrSetKind : TddAttrSetKind;
                                     aReverseHlinkRenum : boolean = false;
                                     aCopyType : TUserType = utEdition;
                                     aAddAttrDocID : TDocID = 0);

function lNeedAttributeRec_NoChDate(aAttr : TdtAttribute; var aRec) : boolean;
begin
 Result := True;
 if aAttr = atDateNums then
  Result := TexpDNDictRec(aRec).rType <> dnChangerDate;
end;

function lNeedAttributeRec_OnlyChDate(aAttr : TdtAttribute; var aRec) : boolean;
begin
 Result := True;
 if aAttr = atDateNums then
  Result := TexpDNDictRec(aRec).rType = dnChangerDate;
end;

var
 // Выливной отрезок
 l_DemonDocGen: TStartDocumentGenerator;
 l_ExpGen: TevExportGenerator;
 l_FixFilter: TddWrongTagFixFilter;
 l_OutFilter: TExportFilter; //TAddDocAttributeFilter;
 // перенумератор
 l_Renumer: TCloneDocumentFilter;
 // Заливной отрезок
 //l_InFilter : TSaveDocAttributeFilter;
 l_InFilter: TImportFilter;
 l_Switcher: TevTopicSwitcher;
 l_BaseFiler: Tm3DBFiler;
 {$IfDef Filter}
 l_mgFilter: Tm3DocumentInfoFilter;
 {$EndIf Filter}
 l_Base : Im3DB;
 l_FilterAttrs : TdtFilterAttributesSet;

 lAttrTestStub : TTestNeedAttributeRecProc;

// l_Dummy: Tk2TagGenerator;
begin
//l_Dummy:= Tk2TagGenerator.Create(nil);
//try
 // выливной участок
 l_DemonDocGen:= TStartDocumentGenerator.Create(nil);
 try
  l_DemonDocGen.InternalDocID:= aInternalSourceID;
  l_Base := dtGetDB(Family, nil, f_ProgressProc);
  try
    l_ExpGen:= TevExportGenerator.Create(nil);
    try
     l_ExpGen.OnInitTopic:= ReadIDSwitch;
     f_Reader:= TevEvdReader.Create(nil);
     try
      l_FixFilter:= TddWrongTagFixFilter.Create(nil);
      try
       f_Filer:= Tm3DBFiler.Create(l_Base);
       try
        l_OutFilter:= TExportFilter.Create(f_Family);
        //l_OutFilter:= TAddDocAttributeFilter.Create(nil, f_Family);
        try
         lAttrTestStub := nil;
         //l_OutFilter.AddDocID := aAddAttrDocID;
         if aAddAttrDocID > 0 then
         begin
          l_OutFilter.AddedDocID := aAddAttrDocID;
          l_OutFilter.AddedAttrs := CdtAddedAttributes;
         end;

         //l_OutFilter.RecalcHyperLinks := True;
         l_OutFilter.NeedDictNames := False;
         l_OutFilter.NeedHeaderAttr := True;
         l_OutFilter.NeedHeaderMainRec := True;
         case aAttrSetKind of
          askMakeNextEdition :
          begin
           l_OutFilter.Attributes := CdtNextEditionAttributes;
           lAttrTestStub := L2TestNeedAttributeRecProc(@lNeedAttributeRec_NoChDate);
           l_OutFilter.TestAttrProc := lAttrTestStub;
          end;

          askMakeOldEdition :
          begin
           l_OutFilter.Attributes := CdtOldEditionAttributes;
           lAttrTestStub := L2TestNeedAttributeRecProc(@lNeedAttributeRec_OnlyChDate);
           l_OutFilter.TestAttrProc := lAttrTestStub;
          end;

          askCopyToOldEdition :
          begin
           l_OutFilter.Attributes := CdtCopyDocToOldEditionAttributes;
           lAttrTestStub := L2TestNeedAttributeRecProc(@lNeedAttributeRec_OnlyChDate);
           l_OutFilter.TestAttrProc := lAttrTestStub;
          end;
          askAllAttributes,
          askAllAttributeswoAnno :
           begin
            if ACopyType in utDocTypesHasSpr then
             l_FilterAttrs:= CdtAllFilterAttributes - [atPriority]
            else
             l_FilterAttrs := CdtAllFilterAttributes - [atRelated,atPriority];

            //if aAttrSetKind = askAllAttributeswoAnno then
            // l_FilterAttrs := l_FilterAttrs - [atAnnoLogInfo];

            l_OutFilter.Attributes := l_FilterAttrs;
           end;
         end;

         f_Reader.Filer:= f_Filer;
         f_Reader.Generator:= l_FixFilter;
         l_FixFilter.Generator:= l_ExpGen;
         l_DemonDocGen.Generator:= l_ExpGen;
         l_ExpGen.Generator:=  l_OutFilter;
         // Выливной участок закончился
         // перенумератор
         l_Renumer:= TCloneDocumentFilter.Create(nil, f_Family);
         try
          with l_Renumer do
          begin
           InternalEditionID := aInternalDestinationID;
           StripName := aAttrSetKind in [{askNextEdition,} askMakeOldEdition, askCopyToOldEdition];
           ReplaceUserType := True;
           NewUserType := aCopyType;
           ReverseHlinkRenum := aReverseHlinkRenum;
          end;
          // заливной участок
          //l_InFilter:= TSaveDocAttributeFilter.Create(nil, 1);
          l_InFilter:= TImportFilter.Create(nil);
          try
           with l_InFilter do
           begin
            Family:= f_Family;
            //ImportType:= ietPacked;
            InternalFormat := True;
            CheckDocuments := False;
            //AddAtOnce:= False;
            AddNewAs:= acNew;
            ExcludeAttr := []; //по умолчанию KW не перетираем, а это не правильно
           end;

           l_InFilter.MasterUser:= f_UserID;
           l_Switcher:= TevTopicSwitcher.Create(nil);
           try
            f_evWriter:= TevdNativeWriter.Create(nil);
            try
             f_evWriter.Binary:= True;
              l_BaseFiler:= Tm3DBFiler.Create(l_Base);
              try
               l_Base := nil;
               {$IfDef Filter}
               l_mgFilter:= Tm3DocumentInfoFilter.Create(l_BaseFiler);
               {$EndIf Filter}
               try
                { Выставляем значения }
                l_OutFilter.Generator:= l_Renumer;
                {
                l_Renumer.Generator:= l_InFilter;
                l_InFilter.Generator:= l_Switcher;
                l_Switcher.Generator:= l_mgFilter;
                }
                l_REnumer.Generator:= l_InFilter;
                l_InFilter.Generator:= l_Switcher;
                {$IfDef Filter}
                l_Switcher.Generator:= l_mgFilter;

                l_mgFilter.Generator := f_evWriter;
                {$Else  Filter}
                l_Switcher.Generator := f_evWriter;
                {$EndIf Filter}
                l_Switcher.Filer:= l_BaseFiler;
                l_Switcher.OnInitTopic:= WriteIDSwitch;
                l_Switcher.OnGenerateTopicID:= GenerateID;
                f_evWriter.Filer:= l_BaseFiler;
                // Выполнение
                l_DemonDocGen.Execute
               finally
                {$IfDef Filter}
                l3Free(l_mgFilter);
                {$EndIf Filter}
               end; { l_mgFilter }
              finally
               l3Free(l_BaseFiler);
              end; { l_BaseFiler}
            finally
             l3Free(f_evWriter);
            end; {f_evWriter}
           finally
            l3Free(l_Switcher);
           end; { l_Switcher }
          finally
           l3Free(l_InFilter);
          end; // l_InFilter
         finally
          l3Free(l_Renumer);
         end; // l_Renumer
        finally
         FreeTestNeedAttributeRecProc(lAttrTestStub);
         l3Free(l_OutFilter);
        end; // l_OutFilter
       finally
        l3Free(f_Filer);
       end; // f_Filer
      finally
       l3Free(l_FixFilter);
      end; // l_FixFilter
     finally
      l3Free(f_Reader);
     end; // f_Reader
    finally
     l3FRee(l_ExpGen);
    end; // l_ExpGen
  finally
   l_Base := nil;
  end; // l_OutPack
 finally
  l3Free(l_DemonDocGen);
 end; // l_DemonDocGen
//finally
// l3Free(l_Dummy);
//end;
end;

// Запись
procedure TddDocumentCopier.WriteIDSwitch(Sender: TObject; const Handle:
    Tm3DBStreamIndex; Filer: Tl3CustomFiler);
begin
 Filer.Handle := Handle.rID;
 if Filer.Opened then
  f_evWriter.AfterStreamOpened;
end;

function TddDocumentCopier.GenerateID(Sender: TObject): Tm3DBStreamIndex;
begin
 Result.rID:= f_CustomID;
 Inc(f_CustomID);
end;

procedure TddDocumentCopier.WriteToFile(aInternalSourceID, aInternalCopyID : TDocID;
                                        aAttrSetKind: TddAttrSetKind;
                                        aFileName: AnsiString;
                                        aCopyType: TUserType = utEdition);

function lNeedAttributeRec_NoChDate(aAttr : TdtAttribute; var aRec) : boolean;
begin
 Result := True;
 if aAttr = atDateNums then
  Result := TexpDNDictRec(aRec).rType <> dnChangerDate;
end;

function lNeedAttributeRec_OnlyChDate(aAttr : TdtAttribute; var aRec) : boolean;
begin
 Result := True;
 if aAttr = atDateNums then
  Result := TexpDNDictRec(aRec).rType = dnChangerDate;
end;

var
 // Выливной отрезок
 l_DemonDocGen: TStartDocumentGenerator;
 l_ExpGen: TevExportGenerator;
 l_FixFilter: TddWrongTagFixFilter;
 l_OutFilter: TExportFilter; //TAddDocAttributeFilter;
 // перенумератор
 l_Renumer: TCloneDocumentFilter;
 // Заливной отрезок
 //l_InFilter : TSaveDocAttributeFilter;
 l_BaseFiler: Tm3DBFiler;
 {$IfDef Filter}
 l_mgFilter: Tm3DocumentInfoFilter;
 {$EndIf Filter}
 l_Base : Im3DB;
 l_FilterAttrs : TdtFilterAttributesSet;
 l_Filer: Tl3DOSFiler;
 lAttrTestStub : TTestNeedAttributeRecProc;
begin
 // выливной участок
 l_DemonDocGen:= TStartDocumentGenerator.Create(nil);
 try
  l_DemonDocGen.InternalDocID:= aInternalSourceID;
  l_Base := dtGetDB(Family, nil, f_ProgressProc);
  try
    l_ExpGen:= TevExportGenerator.Create(nil);
    try
     l_ExpGen.OnInitTopic:= ReadIDSwitch;
     f_Reader:= TevEvdReader.Create(nil);
     try
      l_FixFilter:= TddWrongTagFixFilter.Create(nil);
      try
       f_Filer:= Tm3DBFiler.Create(l_Base);
       try
        l_OutFilter:= TExportFilter.Create(f_Family);
        //l_OutFilter:= TAddDocAttributeFilter.Create(nil, f_Family);
        try
         //l_OutFilter.RecalcHyperLinks := True;
         l_OutFilter.NeedDictNames := False;
         l_OutFilter.NeedHeaderAttr := True;
         l_OutFilter.NeedHeaderMainRec := True;
         case aAttrSetKind of
          askMakeNextEdition :
          begin
           l_OutFilter.Attributes := CdtNextEditionAttributes;
           lAttrTestStub := L2TestNeedAttributeRecProc(@lNeedAttributeRec_NoChDate);
           l_OutFilter.TestAttrProc := lAttrTestStub;
          end;

          askMakeOldEdition :
          begin
           l_OutFilter.Attributes := CdtOldEditionAttributes;
           lAttrTestStub := L2TestNeedAttributeRecProc(@lNeedAttributeRec_OnlyChDate);
           l_OutFilter.TestAttrProc := lAttrTestStub;
          end;

          askCopyToOldEdition :
          begin
           l_OutFilter.Attributes := CdtCopyDocToOldEditionAttributes;
           lAttrTestStub := L2TestNeedAttributeRecProc(@lNeedAttributeRec_OnlyChDate);
           l_OutFilter.TestAttrProc := lAttrTestStub;
          end;

          askAllAttributes,
          askAllAttributeswoAnno :
           begin
            if ACopyType in utDocTypesHasSpr then
             l_FilterAttrs:= CdtAllFilterAttributes - [atPriority]
            else
             l_FilterAttrs := CdtAllFilterAttributes - [atRelated,atPriority];

            if aAttrSetKind = askAllAttributeswoAnno then
             l_FilterAttrs := l_FilterAttrs - [atLogRecords];

            l_OutFilter.Attributes := l_FilterAttrs;
           end;
         end;

         f_Reader.Filer:= f_Filer;
         f_Reader.Generator:= l_FixFilter;
         l_FixFilter.Generator:= l_ExpGen;
         l_DemonDocGen.Generator:= l_ExpGen;
         l_ExpGen.Generator:=  l_OutFilter;
         // Выливной участок закончился
         // перенумератор
         l_Renumer:= TCloneDocumentFilter.Create(nil, f_Family);
         try
          with l_Renumer do
          begin
           InternalEditionID := aInternalCopyID;
           StripName := aAttrSetKind in [{askNextEdition,} askMakeOldEdition, askCopyToOldEdition];
           ReplaceUserType := True;
           NewUserType := aCopyType;
          end;
          f_evWriter:= TevdNativeWriter.Create(nil);
          try
           f_evWriter.Binary := True;
            l_Filer:= Tl3DOSFiler.Make(aFileName, l3_fmWrite);
            try
             l_Base := nil;
              { Выставляем значения }
              l_OutFilter.Generator:= l_Renumer;
              l_Renumer.Generator:= f_evWriter;
              f_evWriter.Filer:= l_Filer;
              // Выполнение
              l_DemonDocGen.Execute;
            finally
             l3Free(l_Filer);
            end; { l_Filer}
          finally
           l3Free(f_evWriter);
          end; {f_evWriter}
         finally
          l3Free(l_Renumer);
         end; // l_Renumer
        finally
         FreeTestNeedAttributeRecProc(lAttrTestStub);
         l3Free(l_OutFilter);
        end; // l_OutFilter
       finally
        l3Free(f_Filer);
       end; // f_Filer
      finally
       l3Free(l_FixFilter);
      end; // l_FixFilter
     finally
      l3Free(f_Reader);
     end; // f_Reader
    finally
     l3FRee(l_ExpGen);
    end; // l_ExpGen
  finally
   l_Base := nil;
  end; // l_OutPack
 finally
  l3Free(l_DemonDocGen);
 end; // l_DemonDocGen
//finally
// l3Free(l_Dummy);
//end;
end;

procedure TddDocumentCopier.ReadFromFile(const aFileName: AnsiString);
var
 l_Switcher: TevTopicSwitcher;
 l_BaseFiler: Tm3DBFiler;
 {$IfDef Filter}
 l_mgFilter: Tm3DocumentInfoFilter;
 {$EndIf Filter}
 l_Base : Im3DB;
 l_FilterAttrs : TdtFilterAttributesSet;
 l_InFilter: TImportFilter;
 l_Filer: Tl3DOSFiler;
begin
 // выливной участок
  l_Base := dtGetDB(Family, nil, f_ProgressProc);
  try
     f_Reader:= TevEvdReader.Create(nil);
     try
       l_Filer:= Tl3DOSFiler.Make(aFileName, l3_fmRead, false);
       try
         f_Reader.Filer:= l_Filer;
         // Выливной участок закончился
          // заливной участок
          //l_InFilter:= TSaveDocAttributeFilter.Create(nil, 1);
          l_InFilter:= TImportFilter.Create(nil);
          try
           with l_InFilter do
           begin
            Family:= f_Family;
            //ImportType:= ietPacked;
            InternalFormat := True;
            CheckDocuments := False;
            //AddAtOnce:= False;
            AddNewAs := acNew;
            ExcludeAttr := []; //по умолчанию KW не перетираем, а это не правильно
           end;

           l_InFilter.MasterUser:= f_UserID;

           l_Switcher:= TevTopicSwitcher.Create(nil);
           try
            f_evWriter:= TevdNativeWriter.Create(nil);
            try
             f_evWriter.Binary:= True;
              l_BaseFiler:= Tm3DBFiler.Create(l_Base);
              try
               l_Base := nil;
               {$IfDef Filter}
               l_mgFilter:= Tm3DocumentInfoFilter.Create(l_BaseFiler);
               {$EndIf Filter}
               try
                { Выставляем значения }
                f_Reader.Generator:= l_InFilter;
                l_InFilter.Generator:= l_Switcher;
                {$IfDef Filter}
                l_Switcher.Generator:= l_mgFilter;

                l_mgFilter.Generator := f_evWriter;
                {$Else  Filter}
                l_Switcher.Generator := f_evWriter;
                {$EndIf Filter}
                l_Switcher.Filer:= l_BaseFiler;
                l_Switcher.OnInitTopic:= WriteIDSwitch;
                l_Switcher.OnGenerateTopicID:= GenerateID;
                f_evWriter.Filer:= l_BaseFiler;
                // Выполнение
                f_Reader.Execute
               finally
                {$IfDef Filter}
                l3Free(l_mgFilter);
                {$EndIf Filter}
               end; { l_mgFilter }
              finally
               l3Free(l_BaseFiler);
              end; { l_BaseFiler}
            finally
             l3Free(f_evWriter);
            end; {f_evWriter}
           finally
            l3Free(l_Switcher);
           end; { l_Switcher }
          finally
           l3Free(l_InFilter);
          end; // l_InFilter
       finally
        l3Free(l_Filer);
       end; // f_Filer
     finally
      l3Free(f_Reader);
     end; // f_Reader
 finally
  l_Base := nil;
 end;
end;


// Чтение
procedure TddDocumentCopier.ReadIDSwitch(Sender: TObject; const Handle:
    Tm3DBStreamIndex; Filer: Tl3CustomFiler);
var
 l_StartLevel : Longint;
begin
 try
  f_Filer.Handle:= Handle.rID;
  l_StartLevel := f_Reader.Generator.CurrentStartLevel;
  try
   f_Reader.Execute;
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    with f_Reader.Generator do
     while (CurrentStartLevel > l_StartLevel) do
      Finish(true);
   end;//on E: Exception
  end;//try..except
 except
  on E: Exception do l3System.Exception2Log(E);
 end;//try..except
end;

end.
