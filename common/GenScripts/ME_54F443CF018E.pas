unit SystemStr;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\SystemStr.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

const
 cMainFormPath = 'Настройки форм/utMainWindow/';
 cFrmIDMainMenu = cMainFormPath + 'utNavigator/';
 cFrmIDConfList = cMainFormPath + 'utConfigurationList/';
 cFrmIDMyDoc = cMainFormPath + 'utFolders/';
 cFrmIDRubTree = cMainFormPath + 'utRubricatorTree/';
 cFrmIDFilter = cMainFormPath + 'utFilters/';
 cFrmIDRedations = cMainFormPath + 'utRedaction/';
 cFrmIDDocUnderControl = cMainFormPath + 'utUnderControl/';
 cFrmIDTaskPanel = cMainFormPath + 'tpMain/';
 cFrmIDDictionaryTerm = cMainFormPath + 'utDiction/';
 casExportTitle = 'Текущее; По умолчанию; Тип; Идентификатор; Название;';
 li_il_Russian = 'Русский';
 li_il_English = 'Английский';
 li_il_German = 'Немецкий';
 li_il_French = 'Французский';
 li_il_Spanish = 'Испанский';
 li_il_Italian = 'Итальянский';
 li_li_Document_CRType0 = 'Все документы';
 li_li_Document_CRType1 = 'Документы';
 li_li_Document_CRType2 = 'Комментарии, разъяснения, схемы';
 li_li_Document_CRType3 = 'Формы документов';
 li_li_Document_CRType4 = 'Проекты законов';
 li_li_Document_CRType5 = 'Судебная практика';
 li_li_Document_CRType6 = 'Международные договоры';
 li_li_Document_CRType7 = 'Не найдено';
 li_li_Document_CRType8 = 'Пользовательский тип';
 ccakFederalLawFull = 'Федеральное законодательство и проекты федеральных законов';
 ccakFederalLawShort = 'Федеральное законодательство';
 ccakJudgePracticeLawFull = 'Судебная и арбитражная практика';
 ccakJudgePracticeLawShort = 'Судебная практика';
 ccakRegionalLaw = 'Региональное законодательство';

implementation

uses
 l3ImplUses
;

end.
