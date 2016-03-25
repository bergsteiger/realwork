unit evNative_AttrValues;
 {* Локализуемые значения атрибутов значений тегов таблицы тегов evNative }

// Модуль: "w:\common\components\gui\Garant\Everest\evNative_AttrValues.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evNative_AttrValues" MUID: (060E2B49C828)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки AttrValues }
 str_TextStyle_ToLeft_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ToLeft_Name_Value'; rValue : 'Прижатый влево');
  {* Локализуемое значения атрибута TextStyle_ToLeft_Name_Value }
 str_TextStyle_TxtHeader1_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader1_Name_Value'; rValue : 'Заголовок 1');
  {* Локализуемое значения атрибута TextStyle_TxtHeader1_Name_Value }
 str_TextStyle_TxtHeader2_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader2_Name_Value'; rValue : 'Заголовок 2');
  {* Локализуемое значения атрибута TextStyle_TxtHeader2_Name_Value }
 str_TextStyle_TxtHeader3_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader3_Name_Value'; rValue : 'Заголовок 3');
  {* Локализуемое значения атрибута TextStyle_TxtHeader3_Name_Value }
 str_TextStyle_TxtHeader4_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader4_Name_Value'; rValue : 'Заголовок 4');
  {* Локализуемое значения атрибута TextStyle_TxtHeader4_Name_Value }
 str_TextStyle_NormalNote_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NormalNote_Name_Value'; rValue : 'Нормальный (справка)');
  {* Локализуемое значения атрибута TextStyle_NormalNote_Name_Value }
 str_TextStyle_TxtComment_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_Name_Value'; rValue : 'Комментарий');
  {* Локализуемое значения атрибута TextStyle_TxtComment_Name_Value }
 {$If NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Garant_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_ShortName_D_Garant_Value'; rValue : 'ГАРАНТ:');
  {* Локализуемое значения атрибута TextStyle_TxtComment_ShortName_D_Garant_Value }
 {$IfEnd} // NOT Defined(Archi)
 {$If Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Archi_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_ShortName_D_Archi_Value'; rValue : ' ');
  {* Локализуемое значения атрибута TextStyle_TxtComment_ShortName_D_Archi_Value }
 {$IfEnd} // Defined(Archi)
 {$If Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_DailyTests_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtComment_ShortName_D_DailyTests_Value'; rValue : 'Комментарий ГАРАНТа:');
  {* Локализуемое значения атрибута TextStyle_TxtComment_ShortName_D_DailyTests_Value }
 {$IfEnd} // Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)
 str_TextStyle_VersionInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VersionInfo_Name_Value'; rValue : 'Информация о версии');
  {* Локализуемое значения атрибута TextStyle_VersionInfo_Name_Value }
 {$If NOT Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VersionInfo_ShortName_Value'; rValue : 'Информация об изменениях:');
  {* Локализуемое значения атрибута TextStyle_VersionInfo_ShortName_Value }
 {$IfEnd} // NOT Defined(Archi)
 {$If Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_D_Archi_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_VersionInfo_ShortName_D_Archi_Value'; rValue : ' ');
  {* Локализуемое значения атрибута TextStyle_VersionInfo_ShortName_D_Archi_Value }
 {$IfEnd} // Defined(Archi)
 str_TextStyle_PromptTree_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_PromptTree_Name_Value'; rValue : 'Подсказки для контекста');
  {* Локализуемое значения атрибута TextStyle_PromptTree_Name_Value }
 str_TextStyle_HLE1_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE1_Name_Value'; rValue : 'Необходимые документы');
  {* Локализуемое значения атрибута TextStyle_HLE1_Name_Value }
 str_TextStyle_HLE1_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE1_ShortName_Value'; rValue : 'Необходимые документы');
  {* Локализуемое значения атрибута TextStyle_HLE1_ShortName_Value }
 str_TextStyle_HLE2_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE2_Name_Value'; rValue : 'Куда обратиться?');
  {* Локализуемое значения атрибута TextStyle_HLE2_Name_Value }
 str_TextStyle_HLE2_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE2_ShortName_Value'; rValue : 'Куда обратиться?');
  {* Локализуемое значения атрибута TextStyle_HLE2_ShortName_Value }
 str_TextStyle_HLE3_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE3_Name_Value'; rValue : 'Внимание: недобросовестность!');
  {* Локализуемое значения атрибута TextStyle_HLE3_Name_Value }
 str_TextStyle_HLE3_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE3_ShortName_Value'; rValue : 'Внимание: недобросовестность!');
  {* Локализуемое значения атрибута TextStyle_HLE3_ShortName_Value }
 str_TextStyle_HLE4_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE4_Name_Value'; rValue : 'Внимание: криминал!!');
  {* Локализуемое значения атрибута TextStyle_HLE4_Name_Value }
 str_TextStyle_HLE4_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE4_ShortName_Value'; rValue : 'Внимание: криминал!!');
  {* Локализуемое значения атрибута TextStyle_HLE4_ShortName_Value }
 str_TextStyle_HLE5_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE5_Name_Value'; rValue : 'Примечание.');
  {* Локализуемое значения атрибута TextStyle_HLE5_Name_Value }
 str_TextStyle_HLE5_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE5_ShortName_Value'; rValue : 'Примечание.');
  {* Локализуемое значения атрибута TextStyle_HLE5_ShortName_Value }
 str_TextStyle_HLE6_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE6_Name_Value'; rValue : 'Пример.');
  {* Локализуемое значения атрибута TextStyle_HLE6_Name_Value }
 str_TextStyle_HLE6_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HLE6_ShortName_Value'; rValue : 'Пример');
  {* Локализуемое значения атрибута TextStyle_HLE6_ShortName_Value }
 str_TextStyle_HeaderForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HeaderForChangesInfo_Name_Value'; rValue : 'Заголовок для информации об изменениях');
  {* Локализуемое значения атрибута TextStyle_HeaderForChangesInfo_Name_Value }
 str_TextStyle_FooterForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_FooterForChangesInfo_Name_Value'; rValue : 'Подвал для информации об изменениях');
  {* Локализуемое значения атрибута TextStyle_FooterForChangesInfo_Name_Value }
 str_TextStyle_TextForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TextForChangesInfo_Name_Value'; rValue : 'Текст информации об изменениях');
  {* Локализуемое значения атрибута TextStyle_TextForChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Header_HeaderC_Text_Value'; rValue : '(информация об изменениях >>)');
  {* Локализуемое значения атрибута TextStyle_ChangesInfo_Header_HeaderC_Text_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value'; rValue : 'Открыть справку к документу');
  {* Локализуемое значения атрибута TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value'; rValue : 'script:оп::Документ_Справка_к_документу');
  {* Локализуемое значения атрибута TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Footer_FooterC_Text_Value'; rValue : 'Подробнее см. в справке к документу');
  {* Локализуемое значения атрибута TextStyle_ChangesInfo_Footer_FooterC_Text_Value }
 str_TextStyle_ChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_Name_Value'; rValue : 'Информация об изменениях');
  {* Локализуемое значения атрибута TextStyle_ChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ChangesInfo_ShortName_Value'; rValue : 'С изменениями и дополнениями от:');
  {* Локализуемое значения атрибута TextStyle_ChangesInfo_ShortName_Value }
 str_TextStyle_SubHeaderForChangesInfo_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_SubHeaderForChangesInfo_Name_Value'; rValue : 'Подзаголовок для информации об изменениях');
  {* Локализуемое значения атрибута TextStyle_SubHeaderForChangesInfo_Name_Value }
 str_TextStyle_ControlsBlockHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ControlsBlockHeader_Name_Value'; rValue : 'Заголовок группы контролов');
  {* Локализуемое значения атрибута TextStyle_ControlsBlockHeader_Name_Value }
 str_TextStyle_CloakHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_CloakHeader_Name_Value'; rValue : 'Заголовок распахивающейся части диалога');
  {* Локализуемое значения атрибута TextStyle_CloakHeader_Name_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value'; rValue : 'Официальная копия графической публикации (Интернет-ссылка)');
  {* Локализуемое значения атрибута TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value'; rValue : 'script:оп::Документ_Графическая_копия_официальной_публикации');
  {* Локализуемое значения атрибута TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Header_FooterC_Text_Value'; rValue : 'См. графическую копию официальной публикации');
  {* Локализуемое значения атрибута TextStyle_LinkToPublication_Header_FooterC_Text_Value }
 str_TextStyle_LinkToPublication_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_LinkToPublication_Name_Value'; rValue : 'Ссылка на официальную публикацию');
  {* Локализуемое значения атрибута TextStyle_LinkToPublication_Name_Value }
 str_TextStyle_UnderlinedText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_UnderlinedText_Name_Value'; rValue : 'Подчёркнутый текст');
  {* Локализуемое значения атрибута TextStyle_UnderlinedText_Name_Value }
 str_TextStyle_NodeGroupHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NodeGroupHeader_Name_Value'; rValue : 'Заголовок группы редакций');
  {* Локализуемое значения атрибута TextStyle_NodeGroupHeader_Name_Value }
 str_TextStyle_TxtNormalAACSeeAlso_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtNormalAACSeeAlso_Name_Value'; rValue : 'Текст ЭР (см. также)');
  {* Локализуемое значения атрибута TextStyle_TxtNormalAACSeeAlso_Name_Value }
 str_TextStyle_HeaderAACLeftWindow_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HeaderAACLeftWindow_Name_Value'; rValue : 'Заголовок ЭР (левое окно)');
  {* Локализуемое значения атрибута TextStyle_HeaderAACLeftWindow_Name_Value }
 str_TextStyle_HeaderAACRightWindow_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HeaderAACRightWindow_Name_Value'; rValue : 'Заголовок ЭР (правое окно)');
  {* Локализуемое значения атрибута TextStyle_HeaderAACRightWindow_Name_Value }
 str_TextStyle_ContextAACRightWindows_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ContextAACRightWindows_Name_Value'; rValue : 'ЭР-содержание (правое окно)');
  {* Локализуемое значения атрибута TextStyle_ContextAACRightWindows_Name_Value }
 str_TextStyle_FormulaInAAC_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_FormulaInAAC_Name_Value'; rValue : 'Формула');
  {* Локализуемое значения атрибута TextStyle_FormulaInAAC_Name_Value }
 str_TextStyle_TwoColorTable_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TwoColorTable_Name_Value'; rValue : 'Таблица с полосатой заливкой');
  {* Локализуемое значения атрибута TextStyle_TwoColorTable_Name_Value }
 str_TextStyle_BoldSelection_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_BoldSelection_Name_Value'; rValue : 'Выделение жирным');
  {* Локализуемое значения атрибута TextStyle_BoldSelection_Name_Value }
 str_TextStyle_ExpandedText_Header_HeaderC_Text_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ExpandedText_Header_HeaderC_Text_Value'; rValue : 'Разворачиваемый текст >>');
  {* Локализуемое значения атрибута TextStyle_ExpandedText_Header_HeaderC_Text_Value }
 str_TextStyle_ExpandedText_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ExpandedText_Name_Value'; rValue : 'Разворачиваемый текст');
  {* Локализуемое значения атрибута TextStyle_ExpandedText_Name_Value }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_TextStyle_ToLeft_Name_Value.Init;
 {* Инициализация str_TextStyle_ToLeft_Name_Value }
 str_TextStyle_TxtHeader1_Name_Value.Init;
 {* Инициализация str_TextStyle_TxtHeader1_Name_Value }
 str_TextStyle_TxtHeader2_Name_Value.Init;
 {* Инициализация str_TextStyle_TxtHeader2_Name_Value }
 str_TextStyle_TxtHeader3_Name_Value.Init;
 {* Инициализация str_TextStyle_TxtHeader3_Name_Value }
 str_TextStyle_TxtHeader4_Name_Value.Init;
 {* Инициализация str_TextStyle_TxtHeader4_Name_Value }
 str_TextStyle_NormalNote_Name_Value.Init;
 {* Инициализация str_TextStyle_NormalNote_Name_Value }
 str_TextStyle_TxtComment_Name_Value.Init;
 {* Инициализация str_TextStyle_TxtComment_Name_Value }
{$If NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Garant_Value.Init;
 {* Инициализация str_TextStyle_TxtComment_ShortName_D_Garant_Value }
{$IfEnd} // NOT Defined(Archi)
{$If Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_Archi_Value.Init;
 {* Инициализация str_TextStyle_TxtComment_ShortName_D_Archi_Value }
{$IfEnd} // Defined(Archi)
{$If Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)}
 str_TextStyle_TxtComment_ShortName_D_DailyTests_Value.Init;
 {* Инициализация str_TextStyle_TxtComment_ShortName_D_DailyTests_Value }
{$IfEnd} // Defined(nsTest) AND Defined(Nemesis) AND NOT Defined(InsiderTest) AND NOT Defined(Archi)
 str_TextStyle_VersionInfo_Name_Value.Init;
 {* Инициализация str_TextStyle_VersionInfo_Name_Value }
{$If NOT Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_Value.Init;
 {* Инициализация str_TextStyle_VersionInfo_ShortName_Value }
{$IfEnd} // NOT Defined(Archi)
{$If Defined(Archi)}
 str_TextStyle_VersionInfo_ShortName_D_Archi_Value.Init;
 {* Инициализация str_TextStyle_VersionInfo_ShortName_D_Archi_Value }
{$IfEnd} // Defined(Archi)
 str_TextStyle_PromptTree_Name_Value.Init;
 {* Инициализация str_TextStyle_PromptTree_Name_Value }
 str_TextStyle_HLE1_Name_Value.Init;
 {* Инициализация str_TextStyle_HLE1_Name_Value }
 str_TextStyle_HLE1_ShortName_Value.Init;
 {* Инициализация str_TextStyle_HLE1_ShortName_Value }
 str_TextStyle_HLE2_Name_Value.Init;
 {* Инициализация str_TextStyle_HLE2_Name_Value }
 str_TextStyle_HLE2_ShortName_Value.Init;
 {* Инициализация str_TextStyle_HLE2_ShortName_Value }
 str_TextStyle_HLE3_Name_Value.Init;
 {* Инициализация str_TextStyle_HLE3_Name_Value }
 str_TextStyle_HLE3_ShortName_Value.Init;
 {* Инициализация str_TextStyle_HLE3_ShortName_Value }
 str_TextStyle_HLE4_Name_Value.Init;
 {* Инициализация str_TextStyle_HLE4_Name_Value }
 str_TextStyle_HLE4_ShortName_Value.Init;
 {* Инициализация str_TextStyle_HLE4_ShortName_Value }
 str_TextStyle_HLE5_Name_Value.Init;
 {* Инициализация str_TextStyle_HLE5_Name_Value }
 str_TextStyle_HLE5_ShortName_Value.Init;
 {* Инициализация str_TextStyle_HLE5_ShortName_Value }
 str_TextStyle_HLE6_Name_Value.Init;
 {* Инициализация str_TextStyle_HLE6_Name_Value }
 str_TextStyle_HLE6_ShortName_Value.Init;
 {* Инициализация str_TextStyle_HLE6_ShortName_Value }
 str_TextStyle_HeaderForChangesInfo_Name_Value.Init;
 {* Инициализация str_TextStyle_HeaderForChangesInfo_Name_Value }
 str_TextStyle_FooterForChangesInfo_Name_Value.Init;
 {* Инициализация str_TextStyle_FooterForChangesInfo_Name_Value }
 str_TextStyle_TextForChangesInfo_Name_Value.Init;
 {* Инициализация str_TextStyle_TextForChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value.Init;
 {* Инициализация str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value.Init;
 {* Инициализация str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value.Init;
 {* Инициализация str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value.Init;
 {* Инициализация str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value }
 str_TextStyle_ChangesInfo_Name_Value.Init;
 {* Инициализация str_TextStyle_ChangesInfo_Name_Value }
 str_TextStyle_ChangesInfo_ShortName_Value.Init;
 {* Инициализация str_TextStyle_ChangesInfo_ShortName_Value }
 str_TextStyle_SubHeaderForChangesInfo_Name_Value.Init;
 {* Инициализация str_TextStyle_SubHeaderForChangesInfo_Name_Value }
 str_TextStyle_ControlsBlockHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_ControlsBlockHeader_Name_Value }
 str_TextStyle_CloakHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_CloakHeader_Name_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value.Init;
 {* Инициализация str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value.Init;
 {* Инициализация str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value }
 str_TextStyle_LinkToPublication_Header_FooterC_Text_Value.Init;
 {* Инициализация str_TextStyle_LinkToPublication_Header_FooterC_Text_Value }
 str_TextStyle_LinkToPublication_Name_Value.Init;
 {* Инициализация str_TextStyle_LinkToPublication_Name_Value }
 str_TextStyle_UnderlinedText_Name_Value.Init;
 {* Инициализация str_TextStyle_UnderlinedText_Name_Value }
 str_TextStyle_NodeGroupHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_NodeGroupHeader_Name_Value }
 str_TextStyle_TxtNormalAACSeeAlso_Name_Value.Init;
 {* Инициализация str_TextStyle_TxtNormalAACSeeAlso_Name_Value }
 str_TextStyle_HeaderAACLeftWindow_Name_Value.Init;
 {* Инициализация str_TextStyle_HeaderAACLeftWindow_Name_Value }
 str_TextStyle_HeaderAACRightWindow_Name_Value.Init;
 {* Инициализация str_TextStyle_HeaderAACRightWindow_Name_Value }
 str_TextStyle_ContextAACRightWindows_Name_Value.Init;
 {* Инициализация str_TextStyle_ContextAACRightWindows_Name_Value }
 str_TextStyle_FormulaInAAC_Name_Value.Init;
 {* Инициализация str_TextStyle_FormulaInAAC_Name_Value }
 str_TextStyle_TwoColorTable_Name_Value.Init;
 {* Инициализация str_TextStyle_TwoColorTable_Name_Value }
 str_TextStyle_BoldSelection_Name_Value.Init;
 {* Инициализация str_TextStyle_BoldSelection_Name_Value }
 str_TextStyle_ExpandedText_Header_HeaderC_Text_Value.Init;
 {* Инициализация str_TextStyle_ExpandedText_Header_HeaderC_Text_Value }
 str_TextStyle_ExpandedText_Name_Value.Init;
 {* Инициализация str_TextStyle_ExpandedText_Name_Value }

end.
