unit nsContextFilterParamsConst;

(*-----------------------------------------------------------------------------
 Название:   nsContextFilterParams
 Автор:      Лукьянец Р. В.
 Назначение: Хранилище для параметров контекстной фильтрации;
             Описание контекстных фильтров хранящихся в настройках.
 Версия:
   $Id: nsContextFilterParamsConst.pas,v 1.4 2012/01/19 14:09:20 lulin Exp $
 История:
   $Log: nsContextFilterParamsConst.pas,v $
   Revision 1.4  2012/01/19 14:09:20  lulin
   {RequestLink:327825257}

   Revision 1.3  2011/04/13 14:33:53  lulin
   {RequestLink:258607641}.

   Revision 1.2  2009/04/17 09:04:26  oman
   - new: Показываем группу в свойствах пользователя - [$127762671]

   Revision 1.1  2008/10/29 17:14:00  lulin
   - <K>: 121159661.

   Revision 1.8  2008/04/09 11:26:42  mmorozov
   - параметры контекстной фильтрации для списка препартов.

   Revision 1.7  2008/04/03 11:19:11  oman
   - new: Документ-препарат - параметры контекстной фильтрации (cq28562)

   Revision 1.6  2008/03/31 12:58:46  oman
   - new: Список фирм-производителей - параметры контекстной фильтрации

   Revision 1.5  2008/03/06 10:49:32  oman
   - new: Заготовка для словаря медицинских терминов - параметры контекстной фильтрации

   Revision 1.4  2008/02/19 07:45:23  oman
   - new: Параметры контекстной фильтрации для советов дня (cq28223, 16723)

   Revision 1.3  2007/03/21 11:54:56  oman
   - выделил фабричную функцию для производства параметров
     контекстной фильтрации

   Revision 1.2  2007/03/21 10:30:54  oman
   - new: Выделил хранителя параметров контекстной фильтрации

   Revision 1.1  2007/03/20 10:52:54  oman
   - fix: Параметры контекстнйо фильтрации определяем без
    nscContextParams


-----------------------------------------------------------------------------*)

interface

uses
 l3TreeInterfaces,

 afwInterfaces,

 nsConst,

 DynamicTreeUnit
 ;

const
 SupportedContextsFilterRoots: array [0..25] of String = (
  gi_cpKeywordSerch,
  gi_cpPublishSource,
  gi_cpDiction,
  gi_cpNavigator,
  gi_cpType,
  AT_CLASS,
  AT_Source,
  gi_cpRegNumber,
  gi_cpMURegNumber,
  gi_cpMURegStatus,
  gi_cpStatus,
  gi_cpNorm,
  AT_PREFIX,
  gi_cpTerritory,
  gi_cpBases,
  gi_cpContents,
  gi_cpUserList,
  gi_cpDayTips,
  gi_cpDrugContents,
  gi_cpMedicDiction,
  gi_cpMedicFirms,
  gi_cpDrugList,
  gi_cpGroupList,
  AT_PREFIX_REVIEW,
  AT_CLASS_REVIEW,
  AT_SOURCE_REVIEW
 );

implementation

end.
