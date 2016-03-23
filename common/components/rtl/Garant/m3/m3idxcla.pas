unit m3IdxCla;
{* Реализация некоторых интерфейсов индексатора. }

// $Id: m3idxcla.pas,v 1.59 2015/10/13 12:59:26 lulin Exp $

// $Log: m3idxcla.pas,v $
// Revision 1.59  2015/10/13 12:59:26  lulin
// - убираем Assert.
//
// Revision 1.58  2015/10/13 12:58:23  lulin
// - убираем Assert.
//
// Revision 1.57  2015/09/21 14:45:11  lulin
// - так правильнее.
//
// Revision 1.56  2015/09/21 10:06:42  lulin
// {RequestLink:565257504}
//
// Revision 1.55  2015/06/04 13:21:47  voba
// - k:580708782
//
// Revision 1.54  2014/12/08 13:07:44  lulin
// - рисуем на модели.
//
// Revision 1.53  2014/12/05 14:09:37  lulin
// - чистим код.
//
// Revision 1.52  2014/12/05 13:52:06  lulin
// - рисуем на модели.
//
// Revision 1.51  2014/12/05 13:23:08  lulin
// - рисуем на модели.
//
// Revision 1.50  2014/12/05 12:34:00  lulin
// - рисуем на модели.
//
// Revision 1.49  2014/12/04 17:44:57  lulin
// - рисуем на модели.
//
// Revision 1.48  2014/12/04 16:15:43  lulin
// - рисуем на модели буферизованный поток.
//
// Revision 1.47  2014/11/07 17:30:36  lulin
// {RequestLink:571638581}.
//
// Revision 1.46  2014/11/06 17:05:11  lulin
// - перетряхиваем код.
//
// Revision 1.44  2014/11/06 13:33:17  lulin
// - перетряхиваем код.
//
// Revision 1.43  2014/11/06 12:16:33  lulin
// - перетряхиваем код.
//
// Revision 1.42  2014/11/06 11:53:39  lulin
// - перетряхиваем код.
//
// Revision 1.41  2014/11/05 16:59:31  lulin
// - перетряхиваем код.
//
// Revision 1.40  2014/11/05 12:28:57  lulin
// - перетряхиваем код.
//
// Revision 1.38  2014/10/31 14:14:30  lulin
// - перетряхиваем код.
//
// Revision 1.37  2014/10/30 13:43:54  lulin
// - перетряхиваем код.
//
// Revision 1.36  2014/09/23 16:59:33  lulin
// - переносим на модель.
//
// Revision 1.35  2014/09/23 16:20:31  lulin
// - переносим на модель.
//
// Revision 1.34  2014/09/23 13:30:28  lulin
// - не делаем "пустышку".
//
// Revision 1.33  2014/09/23 12:59:53  lulin
// - "выживаем" в условиях Assert'ов.
//
// Revision 1.32  2014/09/16 10:43:22  lulin
// - возвращаем старую реализацию хранилища.
//
// Revision 1.31  2014/09/10 16:02:08  lulin
// - где возможно, там используем эксклюзивный доступ.
//
// Revision 1.30  2014/09/01 15:48:44  lulin
// - вычищаем мусор.
//
// Revision 1.29  2014/09/01 14:51:04  lulin
// - вычищаем мусор.
//
// Revision 1.28  2014/09/01 14:30:33  lulin
// - вычищаем мусор.
//
// Revision 1.27  2014/08/29 11:22:08  lulin
// - заменяем условную директиву на переменную.
//
// Revision 1.26  2014/08/28 16:52:03  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.25  2014/08/28 16:37:59  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.24  2014/08/28 15:51:03  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.23  2014/08/28 14:06:35  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.22  2014/08/28 13:17:55  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.21  2014/08/28 11:26:46  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.20  2014/08/28 10:30:01  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.19  2014/08/27 13:27:48  lulin
// - выпиливаем Tm3CustomHeaderStream в отдельный файл.
//
// Revision 1.18  2014/05/28 07:06:55  lulin
// - чистим код.
//
// Revision 1.17  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.16  2012/11/01 09:43:31  lulin
// - забыл точку с запятой.
//
// Revision 1.15  2012/11/01 07:45:58  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.14  2012/01/19 11:17:19  lulin
// {RequestLink:327821495}
//
// Revision 1.13  2011/12/28 09:29:10  lulin
// {RequestLink:325257155}
// - чистим код.
//
// Revision 1.12  2011/05/19 10:36:12  lulin
// {RequestLink:266409354}.
//
// Revision 1.11  2010/11/30 11:47:20  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.10  2009/07/21 15:10:22  lulin
// - bug fix: не собирался и не работал Архивариус в ветке.
//
// Revision 1.9  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.8  2008/02/29 08:24:14  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.7  2007/02/19 15:20:03  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.6  2005/05/24 11:07:42  lulin
// - cleanup.
//
// Revision 1.5  2005/04/28 15:04:14  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.4.4.1  2005/04/26 14:30:59  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.4  2005/02/14 15:12:01  lulin
// - изменены сигнатуры методов.
//
// Revision 1.3  2004/11/03 17:30:28  voba
// - bug fix: не компилировалось.
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - _Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:49  law
// - cleanup.
//
// Revision 1.49  2004/08/18 12:27:24  law
// - перевел процедуру m4BuildIndexNew на использование m3IterateDocuments.
//
// Revision 1.48  2004/06/02 14:45:56  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке _1252.
//
// Revision 1.47  2004/06/01 07:41:54  law
// - переменные (содержащие указатели на менеджеры памяти) перенесены из интерфейсной секции в секцию реализации.
//
// Revision 1.46  2003/07/30 16:34:24  law
// - change: попытка ускорить индексатор за счет увеличения размера кусков выделяемой памяти.
//
// Revision 1.45  2003/06/26 11:31:44  law
// - bug fix: временно открутил использование Tm3LiveSearcherResult - так как при поиске двух одинаковых слов не удавалось по второму разу открыть поток.
//
// Revision 1.44  2003/02/19 14:11:13  law
// - new class: Tm3LiveSearcherResult.
//
// Revision 1.43  2002/09/05 12:54:49  voba
// - bug fix: при поиске слов с маской.
//
// Revision 1.42  2002/09/05 12:42:43  law
// - bug fix: не всегда искались выражения с маской.
//
// Revision 1.41  2002/09/04 13:11:13  law
// - cleanup.
//
// Revision 1.40  2002/09/04 13:06:18  law
// - change proc: m2MSKCompare -> l3MaskCompare.
//
// Revision 1.39  2002/06/17 13:44:46  law
// - new const: m3_saRead, m3_saReadWrite, m3_saCreate.
//
// Revision 1.38  2002/04/25 12:46:15  law
// - optimization.
//
// Revision 1.37  2002/04/25 10:55:10  law
// - optimization: немного уменьшено время поиска.
//
// Revision 1.36  2002/04/25 10:48:02  law
// - cleanup.
//
// Revision 1.35  2002/04/25 10:26:54  law
// - bug fix: неправильная функция сравнения элементов.
// - cleanup: переформатированы участки текста.
//
// Revision 1.34  2002/04/17 11:55:27  law
// - class alias: Tm3Hash = Tm3HashHandleList.
//
// Revision 1.33  2002/04/17 08:20:57  law
// - new behavior: менеджеры памяти теперь инициализируются при создании хеша.
//
// Revision 1.32  2002/04/15 14:29:23  law
// - change: сделана возможность задавать класс объектов хранящих информацию о слове словаря.
//
// Revision 1.31  2002/04/15 12:20:21  law
// - new method: GetFlags.
//
// Revision 1.30  2002/04/12 11:31:13  law
// - cleanup.
//
// Revision 1.29  2002/04/11 14:35:43  law
// - new param: UseAlternate.
// - new method: IsAlternate.
//
// Revision 1.28  2002/04/05 12:53:07  law
// - change: расширен интерфейс Im3IndexedStorage.
//
// Revision 1.27  2002/04/01 16:04:32  law
// - bug fix: обработка ошибок открытия потока.
//
// Revision 1.26  2002/03/28 16:51:12  law
// - bug fix: несовпадение прямого и обратного индексов.
//
// Revision 1.25  2002/03/18 16:49:14  law
// - new directive: _m3UseSTSorter.
//
// Revision 1.24  2002/03/11 15:51:35  law
// - new behavior: изменен алгоритм загрузки индекса.
//
// Revision 1.23  2002/03/11 15:09:37  law
// - new directive: m3MultiThreadIndex.
//
// Revision 1.22  2002/03/04 09:59:37  law
// - new behavior: временно отключена загрузка индекса.
//
// Revision 1.21  2002/02/28 14:23:08  law
// - new behavior: по другому пишем концевой ноль.
//
// Revision 1.20  2002/02/27 17:06:24  law
// - optimization: попытка оптимизации путем применения менеджера памяти, выделяющего большие блоки.
//
// Revision 1.19  2002/02/26 15:48:10  law
// - optimization: попытка оптимизации путем уменьшения фрагментации выделяемой памяти.
//
// Revision 1.18  2002/02/26 08:31:54  law
// - new method: Im3NormalizaterResult.Reset.
// - bug fix: Catastrophic Fail при загрузке индекса.
//
// Revision 1.17  2002/02/22 10:30:53  law
// - optimization: используем интерфейс Im3IndexedStorage.
//
// Revision 1.16  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.15  2002/02/20 15:43:29  law
// - new behavior: пытаемся оптимизировать выделение памяти индексатором.
//
// Revision 1.14  2002/01/30 14:24:04  law
// - new interface: Im3IndexedStorage.
//
// Revision 1.13  2002/01/29 12:51:54  law
// - new behavior: сделан доступ к хешу по индексу.
//
// Revision 1.12  2002/01/17 18:41:33  law
// - new behavior: сделал логику _Tm3BaseHandleList более похожей на Tl3VList.
//
// Revision 1.11  2001/12/26 14:28:32  law
// - reformatting.
//
// Revision 1.10  2001/12/26 13:33:41  law
// - new behavior: попытка уменьшить время жизни корневого хранилища.
//
// Revision 1.9  2001/12/24 14:44:57  voba
// - bug fix: подключили новый индексатор к Архивариусу.
//
// Revision 1.8  2001/12/21 13:12:42  law
// - new behavior: сделан поиск с учетом масок * и ?.
//
// Revision 1.7  2001/12/03 15:07:10  law
// - cleanup: переформатирован исходный текст.
//
// Revision 1.6  2001/12/03 08:39:35  law
// - bug fix: не читался индекс из пакованного файла.
//
// Revision 1.5  2001/11/29 15:46:17  law
// - bug fix: исправляем некорректное поведение индексатора после прикручивания архивирования потоков. Временная копия. Пока не работает.
//
// Revision 1.4  2001/11/21 13:18:30  law
// - bug fix: писались не все проиндексированные слова.
//
// Revision 1.3  2001/11/20 09:12:36  law
// - comments: xHelpGen.
//
// Revision 1.2  2001/11/20 07:37:28  law
// - comments: xHelpGen.
//

 {$I m3Define.inc}

interface


uses
         Windows,
        SysUtils,

         ActiveX,
          COMObj,
  Classes,

         l3Types,
          l3Base,
  l3Memory,
  l3Interfaces,
  l3SimpleMM,
  l3CProtoObject,

        m2AddPrc,
        m2S32Lib,
        m2DTFLib,
        m2MEMLib,
        m2HASLib,
        m2COMLib,

  m3StorageInterfaces,
        m3StgMgr,
        m3SorInt,
        m3IdxInt,
  m3BaseHashInfoStream,
  m3BranchHandlePrim,
  m3BranchHandle,
  m3BranchHandleList,
  m3HashHandle,
  m3HashHandleListPrim,
  m3FileStreamMapView,
  m3FileStream
  ;

type
        Rm3BranchHandle = class of Tm3BranchHandle;

        Tm3IdxClaBranchItem=      packed array [$0000..$ffff] of AnsiChar;

        Pm3IdxClaUpdateItem=      ^Tm3IdxClaUpdateItem;
        Tm3IdxClaUpdateItem=      packed record
                                   BranchHandle : Tm3BranchHandlePrim;
                                   BranchItem   : Tm3IdxClaBranchItem;
                                  end;

        Tm3IdxClaSearchInfo=      packed record

                                   RStream: IStream;
                                   RItem: Pointer;

                                   RNeedLoad: LongBool;

                                  end;

        Tm3IdxClaSearchInfoArray= packed array of Tm3IdxClaSearchInfo;

  Tm3SearchWordFlag = (m3_swfNew, m3_swfPseudo, m3_swfAlternate, m3_swfError);
  Tm3SearchWordFlags = set of Tm3SearchWordFlag;
  Pm3SearchWordFlags = ^Tm3SearchWordFlags;

  Tm3HashHandleList = class(Tm3HashHandleListPrim)
    private
      _Status:                LongWord;
    private
    // internal methods
          function          InitProc00000001    (const ABitMask: LongWord;
                                                 const AHashCount: Word
                                                ): LongWord;

          procedure         DoneProc00000001    (
                                                );


          function          InitProc00000002    (const ABitMask: LongWord;
                                                 const AHashSize: LongInt
                                                ): LongWord;

          procedure         DoneProc00000002    (
                                                );


          function          InitProc00000004    (const ABitMask: LongWord;
                                                 const AHashVersion: Word
                                                ): LongWord;

          procedure         DoneProc00000004    (
                                                );


          function          InitProc00000008    (const ABitMask: LongWord
                                                ): LongWord;

          procedure         DoneProc00000008    (
                                                );


    private
      FHashCount:             Word;
      FHashSize:              LongInt;
      FHashVersion:           Word;
      f_ExHandleClass : Rm3BranchHandle;        
    protected
      class function          MakeHash            (const AValue: WideString;
                                                   const AHashCount: Word;
                                                   const AHashSize: LongInt;
                                                   const AHashVersion: Word
                                                  ): Word;


    public


          constructor       Create              (anExHandleClass : Rm3BranchHandle = nil;
                                                 const AHashCount: Word = Cm2HASDefCount;
                                                 const AHashSize: LongInt = Cm2HASDefSize;
                                                 const AHashVersion: Word = Cm2HASVersion
                                                );

          procedure Cleanup;
            override;
            {-}


      function SearchBranchHandle(const AValue        : WideString;
                                  const ANormalizater : Im3Normalizater;
                                  theFlags            : Pm3SearchWordFlags = nil): Tm3BranchHandlePrim;
        {-}                          
  end;//Tm3HashHandleList

  Tm3Hash = Tm3HashHandleList;

        Tm3HashInfoStream = class(Tm3BaseHashInfoStream)
        end;//Tm3HashInfoStream


        Tm3IndexUpdater = class(Tl3CProtoObject, Im3IndexUpdater, Il3ProgressSource)
         {* Построитель индекса. }
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AIndexStorageManager: Im3IndexStorageManager
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


                function          InitProc00000002    (const ABitMask: LongWord;
                                                       const AIndexComparer: Im3IndexComparer
                                                      ): LongWord;

                procedure         DoneProc00000002    (
                                                      );


                function          InitProc00000004    (const ABitMask: LongWord;
                                                       const AIndexReader: Im3IndexReader
                                                      ): LongWord;

                procedure         DoneProc00000004    (
                                                      );


                function          InitProc00000008    (const ABitMask: LongWord;
                                                       const AIndexWriter: Im3IndexWriter
                                                      ): LongWord;

                procedure         DoneProc00000008    (
                                                      );


                function          InitProc00000010    (const ABitMask: LongWord;
                                                       const ANormalizater: Im3Normalizater
                                                      ): LongWord;

                procedure         DoneProc00000010    (
                                                      );


                function          InitProc00000020    (const ABitMask: LongWord;
                                                       const AItemSize: LongInt
                                                      ): LongWord;

                procedure         DoneProc00000020    (
                                                      );


                function          InitProc00000040    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000040    (
                                                      );


                function          InitProc00000100    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000100    (
                                                      );


                function          InitProc00000200    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000200    (
                                                      );


                function          InitProc00000400    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000400    (
                                                      );


                function          InitProc00000800    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000800    (
                                                      );


                function          InitProc00001000    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00001000    (
                                                      );


                function          InitProc00002000    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00002000    (
                                                      );


         private


          {$IfDef m3MultiThreadIndex}
          FRTLCriticalSection:    TRTLCriticalSection;
          {$EndIf m3MultiThreadIndex}

          FItemSize:              LongInt;

          FIndexStorageManager:   Im3IndexStorageManager;

          FIndexComparer:         Im3IndexComparer;

          FIndexReader:           Im3IndexReader;
          FIndexWriter:           Im3IndexWriter;

          FNormalizater:          Im3Normalizater;

          FSorter:                Im3Sorter;

          FRootStorage:           Im3IndexedStorage;

          FHashInfoStream:        Tm3HashInfoStream;

          //FStopListStorage:       Im3IndexedStorage;

          FHashHandleList:        Tm3HashHandleList;

          f_ItemBuffers : Pl3MemoryChain;
      f_Progress : Il3Progress;
      f_Tm3NormalFormsManagerLocked : Boolean;
      f_Tm3WideStringManagerLocked : Boolean;
    private
    // event fields
      f_OnSortFinished : TNotifyEvent;


                procedure         LoadIndex           (
                                                      );

                procedure         SaveIndex           (
                                                      );


                function          pm_GetHashCount     (
                                                      ): Word;


                function          pm_HashSize         (
                                                      ): LongInt;


                function          pm_HashVersion      (
                                                      ): Word;


         protected
           // Il3ProgressSource
      function  pm_GetProgress: Il3Progress;
      procedure pm_SetProgress(const aValue: Il3Progress);
        {-}


                property          HashCount: Word read pm_GetHashCount;

                property          HashSize: LongInt read pm_HashSize;
                property          HashVersion: Word read pm_HashVersion;


          class function          HashDataName        (
                                                      ): WideString;

          class function          HashInfoName        (
                                                      ): WideString;

         public


          class function          MakeInterface       (const AIndexStorageManager: Im3IndexStorageManager;
                                                       const AIndexComparer: Im3IndexComparer;
                                                       const AIndexReader: Im3IndexReader;
                                                       const AIndexWriter: Im3IndexWriter;
                                                       const ANormalizater: Im3Normalizater;
                                                       const AItemSize: LongInt;
                                                       anOnSortFinished : TNotifyEvent = nil;
                                                       const aProgress  : Il3Progress = nil
                                                      ): Im3IndexUpdater;
            {* - создает индексатор. }

                constructor       Create              (const AIndexStorageManager: Im3IndexStorageManager;
                                                       const AIndexComparer: Im3IndexComparer;
                                                       const AIndexReader: Im3IndexReader;
                                                       const AIndexWriter: Im3IndexWriter;
                                                       const ANormalizater: Im3Normalizater;
                                                       const AItemSize: LongInt
                                                      );
            {* - создает индексатор. }

                procedure InitAfterAlloc;
                  override;
                  {-}
                procedure Cleanup;
                  override;
                  {-}
                procedure AfterDestroyCalled;
                  override;
                  {-}
                function          GetNormalizater     (const ANormalizaterType: Tm3NormalizaterType
                                                      ): Im3Normalizater;


                procedure         AddMainValue        (const ANormalizater: Im3Normalizater;
                                                       const AValue: WideString;
                                                       const AItem: Pointer;
                                                       const AItemSize: LongInt
                                                      );
                procedure AddKey(aWord               : Tm3BranchHandlePrim;
                                 const AItem         : Pointer;
                                 const AItemSize     : LongInt);


         end;


  Tm3IndexSearcher = class(Tl3CProtoObject,Im3IndexSearcher)
   {* Поисковая машина. }
    private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AIndexStorageManager: Im3IndexStorageManager
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


                function          InitProc00000002    (const ABitMask: LongWord;
                                                       const AIndexComparer: Im3IndexComparer
                                                      ): LongWord;

                procedure         DoneProc00000002    (
                                                      );


                function          InitProc00000004    (const ABitMask: LongWord;
                                                       const AIndexReader: Im3IndexReader
                                                      ): LongWord;

                procedure         DoneProc00000004    (
                                                      );


                function          InitProc00000008    (const ABitMask: LongWord;
                                                       const AIndexWriter: Im3IndexWriter
                                                      ): LongWord;

                procedure         DoneProc00000008    (
                                                      );


                function          InitProc00000010    (const ABitMask: LongWord;
                                                       const ANormalizater: Im3Normalizater
                                                      ): LongWord;

                procedure         DoneProc00000010    (
                                                      );


                function          InitProc00000020    (const ABitMask: LongWord;
                                                       const AItemSize: LongInt
                                                      ): LongWord;

                procedure         DoneProc00000020    (
                                                      );


                function          InitProc00000040    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000040    (
                                                      );


    private
    // internal fields
      FItemSize:              LongInt;

      FIndexStorageManager :   Im3IndexStorageManager;

      FIndexComparer:         Im3IndexComparer;

      FIndexReader:           Im3IndexReader;
      FIndexWriter:           Im3IndexWriter;

      FNormalizater:          Im3Normalizater;

      FFileStreamMapView   : Tm3FileStreamMapView;
      FVersion             : Int64;

      f_HasDataLoaded      : Bool;
      f_HashCount          : Word;
      f_HashSize           : LongInt;
      f_HashVersion        : Word;

      f_HashDataStorage    : Im3IndexedStorage;
    private
    // internal methods
      function  GetFileStreamMapView: Tm3FileStreamMapView;
        {-}
    protected
    // internal methods
      class function HashDataName: WideString;
        {-}
      class function HashInfoName: WideString;
        {-}
    public
    // public methods
          class function          MakeInterface       (const AIndexStorageManager: Im3IndexStorageManager;
                                                       const AIndexComparer: Im3IndexComparer;
                                                       const AIndexReader: Im3IndexReader;
                                                       const AIndexWriter: Im3IndexWriter;
                                                       const ANormalizater: Im3Normalizater;
                                                       const AItemSize: LongInt
                                                      ): Im3IndexSearcher;
            {* - создает поисковую машину. }

                constructor       Create              (const AIndexStorageManager: Im3IndexStorageManager;
                                                       const AIndexComparer: Im3IndexComparer;
                                                       const AIndexReader: Im3IndexReader;
                                                       const AIndexWriter: Im3IndexWriter;
                                                       const ANormalizater: Im3Normalizater;
                                                       const AItemSize: LongInt
                                                      );
            {* - создает поисковую машину. }

                procedure Cleanup;
                  override;
                  {-}
                function          GetNormalizater     (const ANormalizaterType: Tm3NormalizaterType
                                                      ): Im3Normalizater;


                function          GetResult           (const ANormalizater: Im3Normalizater;
                                                       const AValue: WideString
                                                      ): Im3IndexSearcherResult;
            function GetWordsByMask(const aMask: WideString): Im3NormalizaterResult;
              {* - возвращает список слов по маске. }
  end;//Tm3IndexSearcher

        Tm3IndexSearcherResult=   class(Tl3CProtoObject,Im3IndexSearcherResult)
         {* Результат поиска. }
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AFileStream: Tm3FileStream
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


                function          InitProc00000002    (const ABitMask: LongWord;
                                                       const AItemSize: LongInt
                                                      ): LongWord;

                procedure         DoneProc00000002    (
                                                      );


                function          InitProc00000004    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000004    (
                                                      );


         private


          FItemSize:              LongInt;

          FFileStreamMapView:     Tm3FileStreamMapView;

          FItemBegPtr:            Pointer;
          FItemEndPtr:            Pointer;


         protected


         public


          class function          MakeInterface       (const AFileStream: Tm3FileStream;
                                                       const AItemSize: LongInt
                                                      ): Im3IndexSearcherResult;

                constructor       Create              (const AFileStream: Tm3FileStream;
                                                       const AItemSize: LongInt
                                                      );

                procedure Cleanup;
                  override;
                  {-}
                procedure         Reset               (
                                                      );


                function          GetCount            (
                                                      ): LongInt;


                function          Get                 (const AItem: Pointer;
                                                       const AItemSize: LongInt
                                                      ): LongBool;


         end;

implementation

uses
  l3Chars,
  l3String,

  m2AddDbg,
  
  m3IndexConst,
  m3StorageTools,
  m3STSort,
  m3LiveSearcherResult,
  m3WideStringManager,
  m3NormalFormsManager,
  m3BuffStream,
  m3TempStream,
  m3Exceptions
  ;

type
        TValueNormalArray = packed array of WideString;


        TSorterComparer=          class(Tl3CProtoObject,Im3SorterComparer)
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AIndexComparer: Im3IndexComparer
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


                function          InitProc00000002    (const ABitMask: LongWord;
                                                       const AItemSize: LongInt
                                                      ): LongWord;

                procedure         DoneProc00000002    (
                                                      );


         private


          FItemSize:              LongInt;

          FIndexComparer:         Im3IndexComparer;


         protected


         public


          class function          MakeInterface       (const AIndexComparer: Im3IndexComparer;
                                                       const AItemSize: LongInt
                                                      ): Im3SorterComparer;

                constructor       Create              (const AIndexComparer: Im3IndexComparer;
                                                       const AItemSize: LongInt
                                                      );

                procedure Cleanup;
                  override;
                  {-}
                function          Compare             (const AVal1: Pointer;
                                                       const AVal2: Pointer;
                                                       const ASize: LongInt
                                                      ): Integer;


         end;


        TNormalizater = class(Tl3CProtoObject)
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AFileStreamMapView: Tm3FileStreamMapView
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


         private


          FFileStreamMapView:     Tm3FileStreamMapView;


         protected


         public

                constructor       Create              (const AFileStreamMapView: Tm3FileStreamMapView
                                                      );

                procedure Cleanup;
                  override;
                  {-}
           function GetWordsByMask(const AValue: WideString): Im3NormalizaterResult;
             {-}
        end;//TNormalizater


        TNormalizaterResult = class(Tl3CProtoObject,Im3NormalizaterResult)
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AValueNormalArray: TValueNormalArray
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


         private


          FValueNormalArray:      TValueNormalArray;
          FValueNormalArrayIndex: Integer;


         protected


         public


          class function          MakeInterface       (const AValueNormalArray: TValueNormalArray
                                                      ): Im3NormalizaterResult;

                constructor       Create              (const AValueNormalArray: TValueNormalArray
                                                      );

                procedure Cleanup;
                  override;
                  {-}
      function GetFlags: Tm3NormFlags;
        {* - флаги результата нормализации. }
                function          GetCount            (
                                                      ): Integer;

                function          GetValue            (
                                                      ): WideString;


                procedure Reset;
                  {-}
        end;//TNormalizaterResult


// TSorterComparer.private

 function    TSorterComparer.InitProc00000001(const ABitMask: LongWord;
                                              const AIndexComparer: Im3IndexComparer
                                             ): LongWord;
 begin

  with Self do
   begin

    FIndexComparer:=AIndexComparer;

   end;

  Result:=ABitMask;

 end;

 procedure   TSorterComparer.DoneProc00000001(
                                             );
 begin

  with Self do
   begin

    FIndexComparer:=nil;

   end;

 end;

 function    TSorterComparer.InitProc00000002(const ABitMask: LongWord;
                                              const AItemSize: LongInt
                                             ): LongWord;
 begin

  with Self do
   begin

    FItemSize:=AItemSize;

   end;

  Result:=ABitMask;

 end;

 procedure   TSorterComparer.DoneProc00000002(
                                             );
 begin

  with Self do
   begin
   end;

 end;

// TSorterComparer.protected

// TSorterComparer.public

 class
 function    TSorterComparer.MakeInterface(const AIndexComparer: Im3IndexComparer;
                                           const AItemSize: LongInt
                                          ): Im3SorterComparer;
 var
  l_I : TSorterComparer;
 begin

   l_I := Create(AIndexComparer,AItemSize);
   try

    Result:= l_I;

   finally

    FreeAndNil(l_I);

   end;

 end;

 constructor TSorterComparer.Create(const AIndexComparer: Im3IndexComparer;
                                    const AItemSize: LongInt
                                   );
 begin

  inherited Create;

  m2InitOperation(_Status,InitProc00000001($00000001,AIndexComparer));
  m2InitOperation(_Status,InitProc00000002($00000002,AItemSize));

 end;

procedure TSorterComparer.Cleanup;
begin
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 inherited;
end;

function TSorterComparer.Compare(const AVal1: Pointer;
                                 const AVal2: Pointer;
                                 const ASize: LongInt): Integer;
begin
 Result := m2S32Compare(LongInt(Pm3IdxClaUpdateItem(aVal1)^.BranchHandle.Data.Hash),
                        LongInt(Pm3IdxClaUpdateItem(aVal2)^.BranchHandle.Data.Hash));
 if (Result = 0) then begin
  Result:=m2S32Compare(LongInt(Pm3IdxClaUpdateItem(aVal1)^.BranchHandle),
                       LongInt(Pm3IdxClaUpdateItem(aVal2)^.BranchHandle));
  if (Result = 0) then
   Result:=FIndexComparer.Compare(@Pm3IdxClaUpdateItem(aVal1)^.BranchItem,
                                  @Pm3IdxClaUpdateItem(aVal2)^.BranchItem,
                                  FItemSize);
 end;//Result = 0                                 
end;

// TSorterComparer.end


// TNormalizater.private

 function    TNormalizater.InitProc00000001(const ABitMask: LongWord;
                                            const AFileStreamMapView: Tm3FileStreamMapView
                                           ): LongWord;
 begin

  with Self do
   begin

    FFileStreamMapView:=AFileStreamMapView.Use;

   end;

  Result:=ABitMask;

 end;

 procedure   TNormalizater.DoneProc00000001(
                                           );
 begin

  with Self do
   begin
   
    FreeAndNil(FFileStreamMapView);

   end;

 end;

// TNormalizater.protected

// TNormalizater.public

 constructor TNormalizater.Create(const AFileStreamMapView: Tm3FileStreamMapView
                                 );
 begin

  inherited Create;

  m2InitOperation(_Status,InitProc00000001($00000001,AFileStreamMapView));

 end;

procedure TNormalizater.Cleanup;
begin
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 inherited;
end;

function TNormalizater.GetWordsByMask(const AValue: WideString): Im3NormalizaterResult;
  {-}

 function __GetValueNormalArray: TValueNormalArray;
 var
  LBegPtr : PWideChar;
  LEndPtr : PWideChar;
  LString : WideString;
 begin//__GetValueNormalArray
  SetLength(Result,0);
  if (FFileStreamMapView <> nil) then
  begin
   with FFileStreamMapView do
   begin
    LBegPtr:=PWideChar(MemBase);
    LEndPtr:=PWideChar(LongInt(LBegPtr)+MemSize);
    while (LBegPtr <> LEndPtr) do
    begin
     LString:=WideString(LBegPtr);
     if l3MaskCompare(LString, aValue) then
     begin
      SetLength(Result,Succ(Length(Result)));
      Result[Pred(Length(Result))]:=LString;
     end;
     Inc(LongInt(LBegPtr),Succ(Length(LString))*SizeOf(WideChar));
    end;//LBegPtr <> LEndPtr
   end;//with AFileStreamMapView
  end;//AFileStreamMapView <> nil
 end;//__GetValueNormalArray

begin//GetWordsByMask
 Result := TNormalizaterResult.MakeInterface(__GetValueNormalArray);
end;//GetWordsByMask

// TNormalizaterResult.private

 function    TNormalizaterResult.InitProc00000001(const ABitMask: LongWord;
                                                  const AValueNormalArray: TValueNormalArray
                                                 ): LongWord;
 begin

  with Self do
   begin

    FValueNormalArray:=AValueNormalArray;

   end;

  Result:=ABitMask;

 end;

 procedure   TNormalizaterResult.DoneProc00000001(
                                                 );
 begin

  with Self do
   begin

    SetLength(FValueNormalArray,0);

   end;

 end;

// TNormalizaterResult.protected

// TNormalizaterResult.public

class function TNormalizaterResult.MakeInterface(const AValueNormalArray: TValueNormalArray): Im3NormalizaterResult;
var
 l_I : TNormalizaterResult;
begin
  l_I := Create(AValueNormalArray);
  try
   Result:=l_I;
  finally
   FreeAndNil(l_I);
  end;
end;

constructor TNormalizaterResult.Create(const AValueNormalArray: TValueNormalArray);
begin
 FValueNormalArrayIndex := 0;
 inherited Create;
 m2InitOperation(_Status,InitProc00000001($00000001,AValueNormalArray));
end;

procedure TNormalizaterResult.Cleanup;
begin
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 inherited;
end;

function TNormalizaterResult.GetFlags: Tm3NormFlags;
  {* - флаги результата нормализации. }
begin
 Result := [];
end;

function TNormalizaterResult.GetCount: Integer;
begin
 Result:=Length(FValueNormalArray);
end;

function TNormalizaterResult.GetValue: WideString;
begin
 if (FValueNormalArrayIndex < Length(FValueNormalArray)) then begin
  Result:=FValueNormalArray[FValueNormalArrayIndex];
  Inc(FValueNormalArrayIndex);
 end else
  Result:='';
end;

procedure TNormalizaterResult.Reset;
  {-}
begin
 FValueNormalArrayIndex := 0;
end;
  
// Tm3HashHandleList.private

 function    Tm3HashHandleList.InitProc00000001(const ABitMask: LongWord;
                                                const AHashCount: Word
                                               ): LongWord;
 begin

  with Self do
   begin

    FHashCount:=AHashCount;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3HashHandleList.DoneProc00000001(
                                               );
 begin

  with Self do
   begin
   end;

 end;

 function    Tm3HashHandleList.InitProc00000002(const ABitMask: LongWord;
                                                const AHashSize: LongInt
                                               ): LongWord;
 begin

  with Self do
   begin

    FHashSize:=AHashSize;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3HashHandleList.DoneProc00000002(
                                               );
 begin

  with Self do
   begin
   end;

 end;

 function    Tm3HashHandleList.InitProc00000004(const ABitMask: LongWord;
                                                const AHashVersion: Word
                                               ): LongWord;
 begin

  with Self do
   begin

    FHashVersion:=AHashVersion;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3HashHandleList.DoneProc00000004(
                                               );
 begin

  with Self do
   begin
   end;

 end;

 function    Tm3HashHandleList.InitProc00000008(const ABitMask: LongWord
                                               ): LongWord;
 begin

  with Self do
   begin

    Count:=LongInt(FHashCount);

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3HashHandleList.DoneProc00000008(
                                               );
 begin

  with Self do
   begin
   end;

 end;

// Tm3HashHandleList.protected

 class
 function    Tm3HashHandleList.MakeHash(const AValue: WideString;
                                        const AHashCount: Word;
                                        const AHashSize: LongInt;
                                        const AHashVersion: Word
                                       ): Word;
 begin
  Result:=LongInt(m2HASUpdate16(0,PAnsiChar(AValue),m2S32Min(Length(AValue)*SizeOf(WideChar),AHashSize),AHashVersion) and Pred(AHashCount));
 end;

constructor Tm3HashHandleList.Create(anExHandleClass : Rm3BranchHandle;
                                     const AHashCount: Word;
                                     const AHashSize: LongInt;
                                     const AHashVersion: Word
                                    );
begin
 inherited Create;
 if (anExHandleClass = nil) then
  f_ExHandleClass := Tm3BranchHandle
 else
  f_ExHandleClass := anExHandleClass;
 m2InitOperation(_Status,InitProc00000001($00000001,AHashCount));
 m2InitOperation(_Status,InitProc00000002($00000002,AHashSize));
 m2InitOperation(_Status,InitProc00000004($00000004,AHashVersion));
 m2InitOperation(_Status,InitProc00000008($00000008));
end;

procedure Tm3HashHandleList.Cleanup;
begin
 m2DoneOperation(_Status,$00000008,DoneProc00000008);
 m2DoneOperation(_Status,$00000004,DoneProc00000004);
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 inherited;
end;

function Tm3HashHandleList.SearchBranchHandle(const AValue        : WideString;
                                              const ANormalizater : Im3Normalizater;
                                              theFlags            : Pm3SearchWordFlags = nil): Tm3BranchHandlePrim;
var
 LHash         : Word;
 LIndex        : LongInt;
 LBranchHandle : Tm3BranchHandlePrim;
 l_Result      : Im3NormalizaterResult;
 l_Count       : Long;
 l_Flags       : Tm3SearchWordFlags;
begin
 LHash := MakeHash(AValue,FHashCount,FHashSize,FHashVersion);
 with Items[LongInt(LHash)].BranchHandleList do
 begin
  if FindItemByKey(Tm3WideString_C(AValue), LIndex) then
  begin
   Result := Items[LIndex];
   if (theFlags <> nil) then
    theFlags^ := [];
  end//FindItemByKey
  else
  begin
   if (theFlags <> nil) then
    theFlags^ := [m3_swfNew];
   if (aNormalizater = nil) then
   begin
    LBranchHandle := Tm3BranchHandlePrim.Create;
    l_Count := 0;
    //Assert(false);
    // - нельзя это, индексатор падает
    //   надо детально разбираться, как мы сюда попадаем
   end//aNormalizater = nil
   else
   begin
    l_Result := ANormalizater.GetResult(AValue);
    if (l_Result = nil) then
    begin
     LBranchHandle := Tm3BranchHandlePrim.Create;
    end
    else
    begin
     if (theFlags <> nil) then
     begin
      if (m3_nfPseudo in l_Result.GetFlags) then
       Include(theFlags^, m3_swfPseudo);
      if (m3_nfAlternate in l_Result.GetFlags) then
       Include(theFlags^, m3_swfAlternate);
      if (m3_nfError in l_Result.GetFlags) then
       Include(theFlags^, m3_swfError);
     end;//theFlags <> nil
     l_Count := l_Result.GetCount;
     if (l_Count = 0) then
     begin
      l_Result := nil;
      LBranchHandle := Tm3BranchHandlePrim.Create;
     end//l_Count = 0
     else
     if (l_Count = 1) then
     begin
      if (WideCompareStr(aValue, l_Result.GetValue) = 0) then
      begin
       l_Result := nil;
       LBranchHandle := Tm3BranchHandlePrim.Create;
      end
      else
      begin
       l_Result.Reset;
       LBranchHandle := f_ExHandleClass.Create;
      end;//WideCompareStr
     end//l_Count = 1
     else
      LBranchHandle := f_ExHandleClass.Create;
    end;//l_Result = nil
   end;
   try
    with LBranchHandle.Data do
    begin
     Hash := LHash;
     Value := Tm3WideStringManager.Instance.AllocString(aValue);
    end;//with LBranchHandle.Data
    Insert(LIndex, Pointer(LBranchHandle));
    if (l_Result <> nil) then
    begin
     with Tm3BranchHandle(LBranchHandle) do
     begin
      with l_Result do
      begin
       Tm3NormalFormsManager.Instance.AllocItem(NormalForms, l_Count);
       if (theFlags = nil) then
        for LIndex := 0 to Pred(l_Count) do
         Pm3BranchHandlePrim(PAnsiChar(NormalForms) +
                             LIndex * SizeOf(Tm3BranchHandlePrim))^ :=
                              SearchBranchHandle(GetValue, aNormalizater)
       else
       begin
        for LIndex := 0 to Pred(l_Count) do
         Pm3BranchHandlePrim(PAnsiChar(NormalForms) +
                             LIndex * SizeOf(Tm3BranchHandlePrim))^ :=
                              SearchBranchHandle(GetValue, aNormalizater, @l_Flags);
        if (m3_swfError in l_Flags) then
         Include(theFlags^, m3_swfError);
       end;//theFlags = nil
      end;//l_Result
     end;//with LBranchHandle
    end;//l_Result <> nil
   finally
    Result := lBranchHandle.Free;
   end;//try..finally
  end;//FindItemByKey
 end;//with Items[LongInt(LHash)].BranchHandleList
end;

// Tm3IndexUpdater

 function    Tm3IndexUpdater.InitProc00000001(const ABitMask: LongWord;
                                              const AIndexStorageManager: Im3IndexStorageManager
                                             ): LongWord;
 begin

  with Self do
   begin

    FIndexStorageManager:=AIndexStorageManager;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000001(
                                             );
 begin

  with Self do
   begin

    FIndexStorageManager:=nil;

   end;

 end;

 function    Tm3IndexUpdater.InitProc00000002(const ABitMask: LongWord;
                                              const AIndexComparer: Im3IndexComparer
                                             ): LongWord;
 begin

  with Self do
   begin

    FIndexComparer:=AIndexComparer;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000002(
                                             );
 begin

  with Self do
   begin

    FIndexComparer:=nil;

   end;

 end;

 function    Tm3IndexUpdater.InitProc00000004(const ABitMask: LongWord;
                                              const AIndexReader: Im3IndexReader
                                             ): LongWord;
 begin

  with Self do
   begin

    FIndexReader:=AIndexReader;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000004(
                                             );
 begin

  with Self do
   begin

    FIndexReader:=nil;

   end;

 end;

 function    Tm3IndexUpdater.InitProc00000008(const ABitMask: LongWord;
                                              const AIndexWriter: Im3IndexWriter
                                             ): LongWord;
 begin

  with Self do
   begin

    FIndexWriter:=AIndexWriter;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000008(
                                             );
 begin

  with Self do
   begin

    FIndexWriter:=nil;

   end;

 end;

 function    Tm3IndexUpdater.InitProc00000010(const ABitMask: LongWord;
                                              const ANormalizater: Im3Normalizater
                                             ): LongWord;
 begin

  with Self do
   begin

    FNormalizater:=ANormalizater;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000010(
                                             );
 begin

  with Self do
   begin

    FNormalizater:=nil;

   end;

 end;

 function    Tm3IndexUpdater.InitProc00000020(const ABitMask: LongWord;
                                              const AItemSize: LongInt
                                             ): LongWord;
 begin

  with Self do
   begin

    FItemSize:=AItemSize;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000020(
                                             );
 begin

  with Self do
   begin
   end;

 end;

 function    Tm3IndexUpdater.InitProc00000040(const ABitMask: LongWord
                                             ): LongWord;
 begin

  with Self do
   begin

    FRootStorage:=FIndexStorageManager.GetRootStorage(False);

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexUpdater.DoneProc00000040(
                                             );
 begin

  with Self do
   begin

    FRootStorage:=nil;

   end;

 end;

 function    Tm3IndexUpdater.InitProc00000100(const ABitMask: LongWord
                                             ): LongWord;
 const
  CStatStgFullMode = STGM_READ or STGM_SHARE_EXCLUSIVE;
 var
  l_Stream : IStream;
 begin
  if l3IOk(m3COMSafeOpenStream(FRootStorage,
                               l3PCharLen(HashInfoName),
                               CStatStgFullMode,
                               false,
                               l_Stream)) AND
     (l_Stream <> nil) then
   try
    FHashInfoStream:=Tm3HashInfoStream.Create(l_Stream,
                                              m2COMModeAccess(CStatStgFullMode));
   finally
    l_Stream := nil
   end
  else
  begin
   FHashInfoStream := nil;
(*   try
    FHashInfoStream := Tm3HashInfoStream.Create(Tm3TempStream.MakeInterface{nil},
                                             m2COMModeAccess(CStatStgFullMode));
   except
    on Em2InvalidValue do
     ;
   end;//try..except*)
  end;//else
  Result:=ABitMask;
 end;

 procedure   Tm3IndexUpdater.DoneProc00000100(
                                             );
 begin
  l3Free(FHashInfoStream);
 end;

 function    Tm3IndexUpdater.InitProc00000200(const ABitMask: LongWord
                                             ): LongWord;
 begin
  Result:=ABitMask;
 end;

 procedure   Tm3IndexUpdater.DoneProc00000200(
                                             );
 begin

 end;

 function    Tm3IndexUpdater.InitProc00000400(const ABitMask: LongWord
                                             ): LongWord;
 begin
  {$IfDef m3MultiThreadIndex}
  InitializeCriticalSection(FRTLCriticalSection);
  {$EndIf m3MultiThreadIndex}
  Result:=ABitMask;
 end;

 procedure   Tm3IndexUpdater.DoneProc00000400(
                                             );
 begin
  {$IfDef m3MultiThreadIndex}
  DeleteCriticalSection(FRTLCriticalSection);
  {$EndIf m3MultiThreadIndex}
 end;

function Tm3IndexUpdater.InitProc00000800(const ABitMask: LongWord): LongWord;
begin
 FSorter:=Tm3Sorter.MakeInterface(FItemSize+SizeOf(Tm3IdxClaUpdateItem)-SizeOf(Tm3IdxClaBranchItem)*SizeOf(AnsiChar),
                                  TSorterComparer.MakeInterface(FIndexComparer,FItemSize));
 Result:=ABitMask;
end;

procedure Tm3IndexUpdater.DoneProc00000800;
begin
 FSorter:=nil;
end;

function Tm3IndexUpdater.InitProc00001000(const ABitMask: LongWord): LongWord;
begin
 FHashHandleList:=Tm3HashHandleList.Create(nil, HashCount,HashSize,HashVersion);
 Result:=ABitMask;
end;

procedure Tm3IndexUpdater.DoneProc00001000;
begin
 l3Free(FHashHandleList);
end;

function Tm3IndexUpdater.InitProc00002000(const ABitMask: LongWord): LongWord;
begin
 LoadIndex;
 Result:=ABitMask;
end;

procedure Tm3IndexUpdater.DoneProc00002000;
begin
 try
  SaveIndex;
 except
  on E: Exception do begin
   {$If Declared(Gm0EXCLibDefSrv)}
   Gm0EXCLibDefSrv.ShowSaveMessage(Cm0EXCLibINF, E);
   {$IfEnd}
   raise;
  end;//on E: Exception
 end;//try..except
end;

procedure Tm3IndexUpdater.LoadIndex;

  procedure   __Load(const AStorage: Im3IndexedStorage);

   function __Forward(const AItemPtr : PPointer;
                      const AIndex   : LongInt): Boolean;

    function __OpenStorage(const AStorage : Im3IndexedStorage;
                           anIndex        : Long): Im3IndexedStorage;
    const
     CStatStgReadMode = STGM_READ or
                        STGM_SHARE_EXCLUSIVE or
                        STGM_DIRECT;
    var
     l_Result  : hResult;
    begin//__OpenStorage
     l_Result := m3COMSafeOpenStorage(aStorage,
                                      anIndex,
                                      CStatStgReadMode,
                                      false,
                                      Result);
     if (l_Result = STG_E_FILENOTFOUND) then
      Result := nil
     else
      OleCheck(l_Result);
    end;//__OpenStorage

    function __OpenStream(const AStorage : Im3IndexedStorage;
                          const AName    : PWideChar): IStream;
    const
     CStatStgReadMode = STGM_READ or
                        STGM_SHARE_EXCLUSIVE or
                        STGM_DIRECT;
    begin//__OpenStream
     Result := m3COMOpenStream(AStorage,l3PCharLen(AName),CStatStgReadMode,False);
    end;//__OpenStream

   var
    LBranchHandle : Tm3BranchHandlePrim;
    LItemData     : Pointer;
    LEnumStatStg  : IEnumStatStg;
    LResult       : LongInt;
    LStatStg      : TStatStg;
    LStorage      : Im3IndexedStorage;
    LStream       : IStream;
   begin//__Forward
    Result:=True;
    //with Data do
    begin
     with Tm3HashHandle(AItemPtr^).BranchHandleList do
     begin
      LStorage := __OpenStorage(aStorage, aIndex);
      if (LStorage = nil) then
       Exit;
      f_ItemBuffers.AllocItem(lItemData);
      try
       OleCheck(LStorage.EnumElements(0,nil,0,LEnumStatStg));
       repeat
        OleCheck(LEnumStatStg.Next(1,LStatStg,@LResult));
        if (LResult = 0) then
         Break;
        with LStatStg do
        begin
         try
          LBranchHandle := FHashHandleList.SearchBranchHandle(pwcsName, FNormalizater);
          LStream := __OpenStream(LStorage, pwcsName);
          while FIndexReader.Get(LStream,LItemData,FItemSize) do
           AddKey(LBranchHandle, lItemData, FItemSize);
         finally
          m2MEMCoTaskFree(Pointer(pwcsName));
         end;//try..finally
        end;//with LStatStg
       until False;
      finally
       f_ItemBuffers.FreeItem(LItemData);
      end;//try..finally
     end;//with BranchHandleList
    end;//with Tm3HashHandle(AItemPtr^).Data
   end;//__Forward
  begin//__Load
   FHashHandleList.IterateAllF(l3L2IA(@__Forward));
  end;//__Load

var
 l_Storage : Im3IndexedStorage;
begin//LoadIndex
 Exit; // !!! &&& !!!
 if l3IOk(m3COMSafeOpenStorage(FRootStorage,
                               l3PCharLen(HashDataName),
                               STGM_READ or STGM_SHARE_EXCLUSIVE,
                               false,
                               l_Storage)) then
 try
  __Load(l_Storage);
 finally
  l_Storage := nil;
 end;//try..finally
end;//LoadIndex

procedure Tm3IndexUpdater.SaveIndex;

  procedure __Save(const AHashDataStorage : Im3IndexedStorage;
                   const AStream          : IStream);

   function __OpenStorage(const AStorage : Im3IndexedStorage;
                          anIndex        : Long): Im3IndexedStorage;
   begin
    Result := m3COMOpenStorage(aStorage, anIndex, m3_saReadWrite, true);
   end;

   function __CreateStream(const AStorage : Im3IndexedStorage;
                           const AName    : Tl3WString): IStream;
   begin
    Result := m3COMOpenStream(aStorage, aName, m3_saReadWrite, true);
   end;

  var
   LBranchHandle : Tm3BranchHandlePrim;
   LHash         : Word;
   LItemData     : Pointer;
   LItemSize     : LongInt;
   LStorage      : Im3IndexedStorage;
   LStream       : IStream;
   l_Count       : Int64;
   l_Current     : Int64;
  begin//__Save
   if Assigned(f_OnSortFinished) then
    f_OnSortFinished(Self);
   LBranchHandle:=nil;
   LHash:=Word(-1);
   LItemSize:=FSorter.GetItemSize;
   f_ItemBuffers.AllocItem(LItemData,LItemSize);
   try
    l_Count := FSorter.GetCount;
    if (f_Progress <> nil) then
     f_Progress.Start(l_Count, l3CStr('Запись индекса'));
    try
     while FSorter.Get(LItemData, LItemSize, @l_Current) do
     begin
      l_Current := l_Count - l_Current;
      if (l_Current mod 1000 = 0) AND (f_Progress <> nil) then
       f_Progress.Progress(l_Current);
      with Pm3IdxClaUpdateItem(LItemData)^ do
      begin
 //      if not(__IsStopValue(AStopListStorage,BranchHandle.Data.Value)) then begin
        if (m2S32Compare(LongInt(BranchHandle),LongInt(LBranchHandle)) <> 0) then
        begin
         LBranchHandle := BranchHandle;
         with LBranchHandle.Data do
         begin
//          NormalForms := nil; // - нам нормальные формы уже не нужны
          if (m2S32Compare(LongInt(Hash),LongInt(LHash)) <> 0) then
          begin
           LHash:=Hash;
           LStorage:=__OpenStorage(AHashDataStorage,LHash);
          end;//m2S32Compare(..
          //with g_WideStringManager do
          begin
           try
            LStream:=__CreateStream(LStorage, Tm3WideStringManager.StringAsPCharLen(Value));
           except
            on E: EOleError do begin
             {$If Declared(Gm0EXCLibDefSrv)}
             Gm0EXCLibDefSrv.SaveException(E);
             Gm0EXCLibDefSrv.SaveMessage(Cm0EXCLibINF,
                                         'Имя потока ' +
                                         l3PCharLen2String(Tm3WideStringManager.StringAsPCharLen(Value), CP_ANSI));
             {$IfEnd}                            
             LStream := nil;
            end;//EOleError
           end;//try..except
           if (LStream <> nil) then begin
            m2COMWriteBuffer(AStream,Value^,Tm3WideStringManager.ItemLength(Value)*SizeOf(WideChar));
            m2COMWriteBuffer(AStream,cc_NullVar,SizeOf(WideChar));
           end;//LStream <> nil
          end;//with g_WideStringManager
         end;//with LBranchHandle.Data
        end;//m2S32Compare(..
        if (LStream <> nil) then
         FIndexWriter.Put(LStream,@BranchItem,FItemSize);
 //      end;//not(__IsStopValue(..
      end;//with Pm3IdxClaUpdateItem(LItemData)^
     end;//while FSorter.Get(..
    finally
     if (f_Progress <> nil) then
      f_Progress.Finish;
    end;//try..finally
   finally
    f_ItemBuffers.FreeItem(LItemData);
   end;//try..finally
  end;//__Save

var
 l_Storage : Im3IndexedStorage;
 l_Version : Int64;
begin//SaveIndex
 if (FHashInfoStream = nil) then
  l_Version := Tm3BaseHashInfoStream.DefaultHeaderValue.RVersion
 else
  l_Version := FHashInfoStream.HeaderData.RVersion;
 l3Free(FHashInfoStream);
 FRootStorage.DestroyElement(PWideChar(HashInfoName));
 FHashInfoStream := Tm3HashInfoStream.Create(
                     m3COMOpenStream(FRootStorage,
                                     l3PCharLen(HashInfoName),
                                     m3_saReadWrite,
                                     true),
                     m2COMModeAccess(m3_saReadWrite));
 with FHashInfoStream.HeaderData do
 begin
  RVersion := l_Version;
  if (RVersion = High(Int64)) then 
   RVersion:=Low(Int64)
  else
   Inc(RVersion)
 end;//with FHashInfoStream...
 l_Storage := m3COMOpenStorage(FRootStorage,
                               l3PCharLen(HashDataName),
                               m3_saReadWrite,
                               true);
 try
  l_Storage.SetIndexParam(16, 16);
  l_Storage.ClearAll;
  __Save(l_Storage, {FStopListStorage, }FHashInfoStream);
 finally
  l_Storage := nil;
 end;//try..finally
end;//SaveIndex

function Tm3IndexUpdater.pm_GetHashCount: Word;
begin
 if (FHashInfoStream = nil) then
  Result := Tm3BaseHashInfoStream.DefaultHeaderValue.RHashCount
 else
  Result := FHashInfoStream.HeaderData.RHashCount;
end;

function Tm3IndexUpdater.pm_HashSize: LongInt;
begin
 if (FHashInfoStream = nil) then
  Result := Tm3BaseHashInfoStream.DefaultHeaderValue.RHashSize
 else
  Result := FHashInfoStream.HeaderData.RHashSize;
end;

function Tm3IndexUpdater.pm_HashVersion: Word;
begin
 if (FHashInfoStream = nil) then
  Result := Tm3BaseHashInfoStream.DefaultHeaderValue.RHashVersion
 else
  Result := FHashInfoStream.HeaderData.RHashVersion;
end;

function Tm3IndexUpdater.pm_GetProgress: Il3Progress;
  {-}
begin
 Result := f_Progress;
end;

procedure Tm3IndexUpdater.pm_SetProgress(const aValue: Il3Progress);
  {-}
begin
 f_Progress := aValue;
end;

class function Tm3IndexUpdater.HashDataName: WideString;
begin
 Result := m3HashDataName;
end;

class function Tm3IndexUpdater.HashInfoName: WideString;
begin
 Result := m3HashInfoName;
end;

// Tm3IndexUpdater.public

class
function    Tm3IndexUpdater.MakeInterface(const AIndexStorageManager: Im3IndexStorageManager;
                                          const AIndexComparer: Im3IndexComparer;
                                          const AIndexReader: Im3IndexReader;
                                          const AIndexWriter: Im3IndexWriter;
                                          const ANormalizater: Im3Normalizater;
                                          const AItemSize: LongInt;
                                          anOnSortFinished : TNotifyEvent = nil;
                                          const aProgress  : Il3Progress = nil
                                         ): Im3IndexUpdater;
var
 l_I : Tm3IndexUpdater;                                         
begin
  l_I := Create(AIndexStorageManager,AIndexComparer,AIndexReader,AIndexWriter,ANormalizater,AItemSize);
  try
   l_I.f_OnSortFinished := anOnSortFinished;
   l_I.f_Progress := aProgress;
   Result:=l_I;
  finally
   FreeAndNil(l_I);
  end;
end;

procedure Tm3IndexUpdater.InitAfterAlloc;
begin
 if not f_Tm3WideStringManagerLocked then
 begin
  Tm3WideStringManager.Instance.LockFree;
  f_Tm3WideStringManagerLocked := true;
 end;//not f_Tm3WideStringManagerLocked
 if not f_Tm3NormalFormsManagerLocked then
 begin
  Tm3NormalFormsManager.Instance.LockFree;
  f_Tm3NormalFormsManagerLocked := true;
 end;//not f_Tm3NormalFormsManagerLocked 
 inherited;
end;
 
constructor Tm3IndexUpdater.Create(const AIndexStorageManager: Im3IndexStorageManager;
                                   const AIndexComparer: Im3IndexComparer;
                                   const AIndexReader: Im3IndexReader;
                                   const AIndexWriter: Im3IndexWriter;
                                   const ANormalizater: Im3Normalizater;
                                   const AItemSize: LongInt
                                  );
begin
 inherited Create;
 m2InitOperation(_Status,InitProc00000001($00000001,AIndexStorageManager));
 m2InitOperation(_Status,InitProc00000002($00000002,AIndexComparer));
 m2InitOperation(_Status,InitProc00000004($00000004,AIndexReader));
 m2InitOperation(_Status,InitProc00000008($00000008,AIndexWriter));
 m2InitOperation(_Status,InitProc00000010($00000010,ANormalizater));
 m2InitOperation(_Status,InitProc00000020($00000020,AItemSize));
 m2InitOperation(_Status,InitProc00000040($00000040));
 m2InitOperation(_Status,InitProc00000100($00000100));
 m2InitOperation(_Status,InitProc00000200($00000200));
 m2InitOperation(_Status,InitProc00000400($00000400));
 m2InitOperation(_Status,InitProc00000800($00000800));
 m2InitOperation(_Status,InitProc00001000($00001000));
 if (f_ItemBuffers = nil) then
  f_ItemBuffers := l3NewMemoryChain(FSorter.GetItemSize);
 m2InitOperation(_Status,InitProc00002000($00002000));
end;

procedure Tm3IndexUpdater.Cleanup;
begin
 m2DoneOperation(_Status,$00002000,DoneProc00002000);
 m2DoneOperation(_Status,$00001000,DoneProc00001000);
 m2DoneOperation(_Status,$00000800,DoneProc00000800);
 m2DoneOperation(_Status,$00000400,DoneProc00000400);
 m2DoneOperation(_Status,$00000200,DoneProc00000200);
 m2DoneOperation(_Status,$00000100,DoneProc00000100);
 m2DoneOperation(_Status,$00000040,DoneProc00000040);
 m2DoneOperation(_Status,$00000020,DoneProc00000020);
 m2DoneOperation(_Status,$00000010,DoneProc00000010);
 m2DoneOperation(_Status,$00000008,DoneProc00000008);
 m2DoneOperation(_Status,$00000004,DoneProc00000004);
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 f_Progress := nil;
 inherited;
end;

procedure Tm3IndexUpdater.AfterDestroyCalled;
begin
 inherited;
 if f_Tm3NormalFormsManagerLocked then
 begin
  f_Tm3NormalFormsManagerLocked := false;
  if Tm3NormalFormsManager.Exists then
   Tm3NormalFormsManager.Instance.UnlockFree;
 end;//f_Tm3NormalFormsManager
 if f_Tm3WideStringManagerLocked then
 begin
  f_Tm3WideStringManagerLocked := false;
  if Tm3WideStringManager.Exists then
   Tm3WideStringManager.Instance.UnlockFree;
 end;//f_Tm3WideStringManager
end;

function Tm3IndexUpdater.GetNormalizater(const ANormalizaterType: Tm3NormalizaterType
                                         ): Im3Normalizater;
begin
 case ANormalizaterType of
  Cm3NormalizaterInternal:
   Result:=FNormalizater;
  else
   OleError(STG_E_INVALIDFUNCTION);
 end;//case ANormalizaterType
end;

procedure Tm3IndexUpdater.AddKey(aWord               : Tm3BranchHandlePrim;
                                 const AItem         : Pointer;
                                 const AItemSize     : LongInt);
var                                 
 LItemData : Pm3IdxClaUpdateItem;
 LItemSize : LongInt;
 l_Hi      : Long;
 l_Lo      : Long;
 l_Index   : Long;
begin
 LItemSize := FSorter.GetItemSize;
 f_ItemBuffers.AllocItem(Pointer(LItemData),LItemSize);
 try
  m2MEMCopy(@LItemData^.BranchItem, aItem, FItemSize);
  if (aWord Is Tm3BranchHandle) then
   with Tm3BranchHandle(aWord) do
   begin
    l_Lo := 0;
    l_Hi := Pred(Tm3NormalFormsManager.ItemLength(NormalForms));
    if (l_Hi < l_Lo) then
    begin
     LItemData^.BranchHandle := aWord;
     FSorter.Put(LItemData, LItemSize);
    end
    else
     for l_Index := l_Lo to l_Hi do
     begin
      LItemData^.BranchHandle := Pm3BranchHandlePrim(PAnsiChar(NormalForms) +
                                                     l_Index * SizeOf(Tm3BranchHandlePrim))^;
      FSorter.Put(LItemData, LItemSize);
     end;//for l_Index
   end//with Tm3BranchHandle(aWord)
  else begin
   LItemData^.BranchHandle := aWord;
   FSorter.Put(LItemData, LItemSize);
  end;//aWord Is Tm3BranchHandle
 finally
  f_ItemBuffers.FreeItem(Pointer(LItemData));
 end;//try..finally
end;

procedure   Tm3IndexUpdater.AddMainValue(const ANormalizater : Im3Normalizater;
                                         const AValue        : WideString;
                                         const AItem         : Pointer;
                                         const AItemSize     : LongInt);
begin
 Assert(FItemSize = AItemSize);
 {$IfDef m3MultiThreadIndex}
 EnterCriticalSection(FRTLCriticalSection);
 try
 {$EndIf m3MultiThreadIndex}
  AddKey(FHashHandleList.SearchBranchHandle(AValue, ANormalizater), aItem, aItemSize);
 {$IfDef m3MultiThreadIndex}
 finally
  LeaveCriticalSection(FRTLCriticalSection);
 end;//try..finally
 {$EndIf m3MultiThreadIndex}
end;

// Tm3IndexUpdater.end


// Tm3IndexSearcher.private

 function    Tm3IndexSearcher.InitProc00000001(const ABitMask: LongWord;
                                               const AIndexStorageManager: Im3IndexStorageManager
                                              ): LongWord;
 begin
  FIndexStorageManager:=AIndexStorageManager;
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000001(
                                              );
 begin
  FIndexStorageManager:=nil;
 end;

 function    Tm3IndexSearcher.InitProc00000002(const ABitMask: LongWord;
                                               const AIndexComparer: Im3IndexComparer
                                              ): LongWord;
 begin
  FIndexComparer:=AIndexComparer;
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000002(
                                              );
 begin
  FIndexComparer:=nil;
 end;

 function    Tm3IndexSearcher.InitProc00000004(const ABitMask: LongWord;
                                               const AIndexReader: Im3IndexReader
                                              ): LongWord;
 begin
  FIndexReader:=AIndexReader;
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000004(
                                              );
 begin
  FIndexReader:=nil;
 end;

 function    Tm3IndexSearcher.InitProc00000008(const ABitMask: LongWord;
                                               const AIndexWriter: Im3IndexWriter
                                              ): LongWord;
 begin
  FIndexWriter:=AIndexWriter;
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000008(
                                              );
 begin
  FIndexWriter:=nil;
 end;

 function    Tm3IndexSearcher.InitProc00000010(const ABitMask: LongWord;
                                               const ANormalizater: Im3Normalizater
                                              ): LongWord;
 begin
  FNormalizater:=ANormalizater;
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000010(
                                              );
 begin
  FNormalizater:=nil;
 end;

 function    Tm3IndexSearcher.InitProc00000020(const ABitMask: LongWord;
                                               const AItemSize: LongInt
                                              ): LongWord;
 begin
  FItemSize:=AItemSize;
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000020(
                                              );
 begin
 end;

 function    Tm3IndexSearcher.InitProc00000040(const ABitMask: LongWord
                                              ): LongWord;
 begin
  Result:=ABitMask;
 end;

 procedure   Tm3IndexSearcher.DoneProc00000040(
                                              );
 begin
  FreeAndNil(FFileStreamMapView);
 end;

 function    Tm3IndexSearcher.GetFileStreamMapView(
                                                  ): Tm3FileStreamMapView;

  function    __OpenStream(const AStorage: Im3IndexedStorage;
                           var   AVersion: Int64
                          ): IStream;
  const
        CStatStgReadMode=         STGM_READ or
                                  STGM_SHARE_EXCLUSIVE or
                                  STGM_DIRECT;
  var
        LHashInfoStream:          Tm3HashInfoStream;
  begin

   try
    LHashInfoStream:=Tm3HashInfoStream.Create(m3COMOpenStream(AStorage, l3PCharLen(HashInfoName), CStatStgReadMode, False), m2COMModeAccess(CStatStgReadMode));
   except
    on Em3NilStream do
     raise Em3NoIndex.Create('Отсутствует поисковый индекс');
   end;//try..except
    try

     with LHashInfoStream.HeaderData do
      begin

       AVersion:=RVersion;

      end;

     Result:=LHashInfoStream;

    finally

     FreeAndNil(LHashInfoStream);

    end;

  end;

 var
        LStream:                  IStream;
        LTempStream:              Tm3TempStream;
        LVersion:                 Int64;
 begin

  LStream:=__OpenStream(FIndexStorageManager.GetRootStorage(True),LVersion);

  if ((FVersion <> LVersion) or (FFileStreamMapView = nil))
   then
    begin

     FreeAndNil(FFileStreamMapView);
     FFileStreamMapView:=nil;

     LTempStream:=Tm3TempStream.Create;
      try

       m2COMCopyData(LTempStream,LStream);

       FFileStreamMapView:=LTempStream.CreateMapView(PAGE_READONLY,FILE_MAP_READ);
       FVersion:=LVersion;

      finally

       FreeAndNil(LTempStream);

      end;

    end;

  Result:=FFileStreamMapView;

 end;

// Tm3IndexSearcher.protected

 class
 function    Tm3IndexSearcher.HashDataName(
                                          ): WideString;
 begin

  Result:=Tm3IndexUpdater.HashDataName;

 end;

 class
 function    Tm3IndexSearcher.HashInfoName(
                                          ): WideString;
 begin

  Result:=Tm3IndexUpdater.HashInfoName;

 end;

// Tm3IndexSearcher.public

 class
 function    Tm3IndexSearcher.MakeInterface(const AIndexStorageManager: Im3IndexStorageManager;
                                            const AIndexComparer: Im3IndexComparer;
                                            const AIndexReader: Im3IndexReader;
                                            const AIndexWriter: Im3IndexWriter;
                                            const ANormalizater: Im3Normalizater;
                                            const AItemSize: LongInt
                                           ): Im3IndexSearcher;
 var
  l_I : Tm3IndexSearcher;                                          
 begin

   l_I := Create(AIndexStorageManager,AIndexComparer,AIndexReader,AIndexWriter,ANormalizater,AItemSize);
   try

    Result:=l_I;

   finally

    FreeAndNil(l_I);

   end;

 end;

 constructor Tm3IndexSearcher.Create(const AIndexStorageManager: Im3IndexStorageManager;
                                     const AIndexComparer: Im3IndexComparer;
                                     const AIndexReader: Im3IndexReader;
                                     const AIndexWriter: Im3IndexWriter;
                                     const ANormalizater: Im3Normalizater;
                                     const AItemSize: LongInt
                                    );
 begin

  inherited Create;

  m2InitOperation(_Status,InitProc00000001($00000001,AIndexStorageManager));
  m2InitOperation(_Status,InitProc00000002($00000002,AIndexComparer));
  m2InitOperation(_Status,InitProc00000004($00000004,AIndexReader));
  m2InitOperation(_Status,InitProc00000008($00000008,AIndexWriter));
  m2InitOperation(_Status,InitProc00000010($00000010,ANormalizater));
  m2InitOperation(_Status,InitProc00000020($00000020,AItemSize));
  m2InitOperation(_Status,InitProc00000040($00000040));

 end;

procedure Tm3IndexSearcher.Cleanup;
begin
 f_HashDataStorage := nil;
 m2DoneOperation(_Status,$00000040,DoneProc00000040);
 m2DoneOperation(_Status,$00000020,DoneProc00000020);
 m2DoneOperation(_Status,$00000010,DoneProc00000010);
 m2DoneOperation(_Status,$00000008,DoneProc00000008);
 m2DoneOperation(_Status,$00000004,DoneProc00000004);
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 inherited;
end;

function Tm3IndexSearcher.GetNormalizater(const ANormalizaterType: Tm3NormalizaterType): Im3Normalizater;
  {-}
begin
 case ANormalizaterType of
  Cm3NormalizaterInternal:
   Result:=FNormalizater;
  else
   OleError(STG_E_INVALIDFUNCTION);
 end;//case ANormalizaterType
end;

function Tm3IndexSearcher.GetResult(const ANormalizater : Im3Normalizater;
                                    const AValue        : WideString): Im3IndexSearcherResult;

 function __GetHashDataStorage(const ARootStorage: Im3IndexedStorage): Im3IndexedStorage;
 const
  CStatStgReadMode = STGM_READ or
                     STGM_SHARE_EXCLUSIVE or
                     STGM_DIRECT;
 begin
  Result := m3COMOpenStorage(ARootStorage, l3PCharLen(HashDataName), CStatStgReadMode, false);
 end;

 function __GetHashDataStream(const AHashDataStorage : Im3IndexedStorage;
                              const AValue           : WideString;
                              const AHashCount       : Word;
                              const AHashSize        : LongInt;
                              const AHashVersion     : Word): IStream;

  function __MakeHash(const AValue       : WideString;
                      const AHashCount   : Word;
                      const AHashSize    : LongInt;
                      const AHashVersion : Word): Word;
  begin
   l3System.Msg2Log('__MakeHash:' + aValue);
   l3System.Msg2Log('AHashCount:' + IntToStr(AHashCount));
   l3System.Msg2Log('AHashSize:' + IntToStr(AHashSize));
   l3System.Msg2Log('AHashVersion' + IntToStr(AHashVersion));
   Result:=Tm3HashHandleList.MakeHash(AValue,AHashCount,AHashSize,AHashVersion);
  end;

  function    __OpenStorage(const AStorage : Im3IndexedStorage;
                            anIndex        : Long): Im3IndexedStorage;
  const
   CStatStgReadMode = STGM_READ or
                      STGM_SHARE_EXCLUSIVE or
                      STGM_DIRECT;
  begin
   l3System.Msg2Log('Индекс хеша: ' + IntToStr(anIndex));
   Result := m3COMOpenStorage(aStorage, anIndex, CStatStgReadMode, false);
   Assert(Result <> nil, 'Не открыли хэш');
  end;

  function __OpenStream(const AStorage : Im3IndexedStorage;
                        const AName    : Tl3WString): IStream;
  const
   CStatStgReadMode = STGM_READ or
                      STGM_SHARE_EXCLUSIVE or
                      STGM_DIRECT;
  begin
   Result := m3COMOpenStream(aStorage, aName, CStatStgReadMode, false);
  end;

 begin//__GetHashDataStream
  try
   Assert(AHashDataStorage <> nil);
   Result:=__OpenStream(__OpenStorage(AHashDataStorage,__MakeHash(AValue,AHashCount,AHashSize,AHashVersion)),l3PCharLen(AValue));
   if (Result = nil) then
    l3System.Msg2Log('nil: ' + aValue)
   else
    l3System.Msg2Log('Found: ' + aValue);
  except
   on E: EOleSysError do
    if (E.ErrorCode = STG_E_FILENOTFOUND) then
    begin
     l3System.Msg2Log('Not found: ' + aValue);
     Result:=nil
    end 
    else
     raise;
  end;//try..except
 end;//__GetHashDataStream

 procedure __GetHashInfo(const ARootStorage : Im3IndexedStorage;
                         var   AHashCount   : Word;
                         var   AHashSize    : LongInt;
                         var   AHashVersion : Word);
 const
  CStatStgReadMode = STGM_READ or
                     STGM_SHARE_EXCLUSIVE or
                     STGM_DIRECT;
 begin//__GetHashInfo
  with Tm3HashInfoStream.Create(m3COMOpenStream(ARootStorage,
                                                l3PCharLen(HashInfoName),
                                                CStatStgReadMode,False),
                                m2COMModeAccess(CStatStgReadMode)) do
   try
    with HeaderData do
    begin
     AHashCount:=RHashCount;
     AHashSize:=RHashSize;
     AHashVersion:=RHashVersion;
    end;//with HeaderData
   finally
    Free;
   end;
 end;//__GetHashInfo

 function __MergeHashData(var ASearchInfoArray: Tm3IdxClaSearchInfoArray): Im3IndexSearcherResult;

  function __Compare(const aItem1 : Pointer;
                     const aItem2 : Pointer;
                     const ASize  : LongInt): Integer;
  begin//__Compare
   if (aItem1 = nil) then begin
    if (aItem2 = nil) then
     Result := 0
    else
     Result := 1;
   end else begin
    if (aItem2 = nil) then
     Result := -1
    else
     Result:=FIndexComparer.Compare(AItem1, AItem2, aSize);
   end;//aItem1 = nil
  end;//__Compare

 var
  LBuffStream : Tm3BuffStream;
  LIndex      : Integer;
  LItem       : Pointer;
  LFound      : Integer;
  LTempStream : Tm3TempStream;
 begin//__MergeHashData
  LTempStream:=Tm3TempStream.Create;
  try
   l3System.Msg2Log('LTempStream:=Tm3TempStream.Create;');
   LBuffStream:=Tm3BuffStream.Create(LTempStream);
   try
    l3System.Msg2Log('LBuffStream:=Tm3BuffStream.Create(LTempStream);');
    repeat
     LItem:=nil;
     LFound:=-1;
     for LIndex:=0 to Pred(Length(ASearchInfoArray)) do begin
      with ASearchInfoArray[LIndex] do begin
        Assert(rStream <> nil);
        if (RStream <> nil) then begin
         if RNeedLoad then begin
          if FIndexReader.Get(RStream,RItem,FItemSize) then
          begin
           l3System.Msg2Log('FIndexReader.Get(RStream,RItem,FItemSize)');
           RNeedLoad := false;
          end
          else begin
           RStream := nil;
           Continue;
          end;//FIndexReader.Get
         end;//RNeedLoad
         case __Compare(RItem,LItem,FItemSize) of
          -1: begin
           LItem:=RItem;
           LFound:=LIndex;
          end;//-1
          00: RNeedLoad:=True;
         end;//case __Compare
        end;//RStream <> nil
      end;//with ASearchInfoArray[LIndex]
     end;//for LIndex
     if (LItem <> nil) then
      with ASearchInfoArray[LFound] do begin
       RNeedLoad:=True;
       FIndexWriter.Put(LBuffStream, RItem, FItemSize);
       l3System.Msg2Log('FIndexWriter.Put(LBuffStream, RItem, FItemSize);');
      end//with ASearchInfoArray[LFound]
     else
       Break;
    until False;
   finally
    l3Free(LBuffStream);
   end;//try..finally
   Result:=Tm3IndexSearcherResult.MakeInterface(LTempStream,FItemSize);
  finally
   l3Free(LTempStream);
  end;//try..finally
 end;//__MergeHashData

var
 LIndex           : Integer;
 LRootStorage     : Im3IndexedStorage;
 LSearchBuff      : Pointer;
 LSearchInfoArray : Tm3IdxClaSearchInfoArray;
 l_Count          : Long;
begin//GetResult
 LRootStorage:=FIndexStorageManager.GetRootStorage(True);
 try
  if (f_HashDataStorage = nil) then
   f_HashDataStorage := __GetHashDataStorage(LRootStorage);
  if not f_HasDataLoaded then begin
   __GetHashInfo(LRootStorage, f_HashCount, f_HashSize, f_HashVersion);
   f_HasDataLoaded := true;
  end;//not f_HasDataLoaded
  LRootStorage := nil; // - здесь корень уже можно освободить
  if (aNormalizater = nil) then
  begin
   Result := Tm3LiveSearcherResult.Make(__GetHashDataStream(f_HashDataStorage,
                                        aValue,
                                        f_HashCount, f_HashSize, f_HashVersion),
                                        FItemSize);
  end//aNormalizater = nil
  else
  begin
   with ANormalizater.GetResult(AValue) do
   begin
    l_Count := GetCount;
(*    if (l_Count = 1) then begin
     // - цепочка одна - значит ничего не надо объединять
     Result := Tm3LiveSearcherResult.Make(__GetHashDataStream(f_HashDataStorage,
                                          GetValue,
                                          f_HashCount, f_HashSize, f_HashVersion),
                                          FItemSize);
    end else *)begin
     m2MEMAlloc(LSearchBuff, l_Count * FItemSize);
     try
      SetLength(LSearchInfoArray, l_Count);
      try
       for LIndex := Low(LSearchInfoArray) to High(LSearchInfoArray) do
       begin
        with LSearchInfoArray[LIndex] do
        begin
         RStream:=__GetHashDataStream(f_HashDataStorage,
                                      GetValue,
                                      f_HashCount, f_HashSize, f_HashVersion);
         RItem:=Pointer(LongInt(LSearchBuff)+(LIndex*FItemSize));
         RNeedLoad := True;
        end;//with LSearchInfoArray[LIndex]
       end;//for LIndex
       Result := __MergeHashData(LSearchInfoArray);
      finally
       LSearchInfoArray := nil;
      end;//try..finally
     finally
      m2MEMFree(LSearchBuff);
     end;//try..finally
    end;//l_Count = 1
   end;//with ANormalizater.GetResult
  end;//aNormalizater = nil 
 finally
  LRootStorage:=nil;
 end;// try..finally
end;//GetResult

function Tm3IndexSearcher.GetWordsByMask(const aMask: WideString): Im3NormalizaterResult;
  {* - возвращает список слов по маске. }
var
 l_Normalizater : TNormalizater;
begin
 l_Normalizater := TNormalizater.Create(GetFileStreamMapView);
 try
  Result := l_Normalizater.GetWordsByMask(WideUpperCase(aMask))
 finally
  l3Free(l_Normalizater);
 end;//try..finally
end;
  
// Tm3IndexSearcherResult

 function    Tm3IndexSearcherResult.InitProc00000001(const ABitMask: LongWord;
                                                     const AFileStream: Tm3FileStream
                                                    ): LongWord;
 begin

  with Self do
   begin

    FFileStreamMapView:=AFileStream.CreateMapView(PAGE_READONLY,FILE_MAP_READ);

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexSearcherResult.DoneProc00000001(
                                                    );
 begin
  FreeAndNil(FFileStreamMapView);
 end;

 function    Tm3IndexSearcherResult.InitProc00000002(const ABitMask: LongWord;
                                                     const AItemSize: LongInt
                                                    ): LongWord;
 begin

  with Self do
   begin

    FItemSize:=AItemSize;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexSearcherResult.DoneProc00000002(
                                                    );
 begin

  with Self do
   begin
   end;

 end;

 function    Tm3IndexSearcherResult.InitProc00000004(const ABitMask: LongWord
                                                    ): LongWord;
 begin

  with Self do
   begin

    Reset;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3IndexSearcherResult.DoneProc00000004(
                                                    );
 begin

  with Self do
   begin

    Reset;

   end;

 end;

 class
 function    Tm3IndexSearcherResult.MakeInterface(const AFileStream: Tm3FileStream;
                                                  const AItemSize: LongInt
                                                 ): Im3IndexSearcherResult;
 var
  l_I : Tm3IndexSearcherResult;
 begin

   l_I := Create(AFileStream,AItemSize);
   try

    Result:=l_I;

   finally

    FreeAndNil(l_I);

   end;

 end;

 constructor Tm3IndexSearcherResult.Create(const AFileStream: Tm3FileStream;
                                           const AItemSize: LongInt
                                          );
 begin

  inherited Create;

  m2InitOperation(_Status,InitProc00000001($00000001,AFileStream));
  m2InitOperation(_Status,InitProc00000002($00000002,AItemSize));
  m2InitOperation(_Status,InitProc00000004($00000004));

 end;

procedure Tm3IndexSearcherResult.Cleanup;
begin
 m2DoneOperation(_Status,$00000004,DoneProc00000004);
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 inherited;
end;

 procedure   Tm3IndexSearcherResult.Reset(
                                         );
 begin

  if (FFileStreamMapView <> nil)
   then
    begin

     with FFileStreamMapView do
      begin

       FItemBegPtr:=MemBase;
       FItemEndPtr:=Pointer(LongInt(FItemBegPtr)+MemSize);

      end;

    end;

 end;

 function    Tm3IndexSearcherResult.GetCount(
                                            ): LongInt;
 begin

  if (FFileStreamMapView <> nil)
   then
    begin

     with FFileStreamMapView do
      begin

       Result:=MemSize div FItemSize;

      end;

    end
   else
    begin

     Result:=0;

    end;

 end;

 function    Tm3IndexSearcherResult.Get(const AItem: Pointer;
                                        const AItemSize: LongInt
                                       ): LongBool;
 begin

  Assert(FItemSize = AItemSize);

  Result:=(LongInt(FItemBegPtr) <> LongInt(FItemEndPtr));

  if Result
   then
    begin

     m2MEMCopy(AItem,FItemBegPtr,FItemSize);
     Inc(LongInt(FItemBegPtr),FItemSize);

    end;

 end;

end.

