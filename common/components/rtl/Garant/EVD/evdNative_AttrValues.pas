unit evdNative_AttrValues;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdNative_AttrValues.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::EVD::Standard::evdNative_AttrValues
//
// Локализуемые значения атрибутов значений тегов таблицы тегов evdNative
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { Локализуемые строки AttrValues }
 str_Frame_Empty_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Frame_Empty_Name_Value'; rValue : 'Empty');
  { Локализуемое значения атрибута Frame_Empty_Name_Value }
 str_Frame_Solid_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Frame_Solid_Name_Value'; rValue : 'Solid');
  { Локализуемое значения атрибута Frame_Solid_Name_Value }
 str_Frame_Down_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Frame_Down_Name_Value'; rValue : 'Down');
  { Локализуемое значения атрибута Frame_Down_Name_Value }
 str_TextStyle_TxtNormalANSI_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtNormalANSI_Name_Value'; rValue : 'Нормальный');
  { Локализуемое значения атрибута TextStyle_TxtNormalANSI_Name_Value }
 str_TextStyle_Object_Font_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Object_Font_Name_Value'; rValue : 'Times New Roman');
  { Локализуемое значения атрибута TextStyle_Object_Font_Name_Value }
 str_TextStyle_Object_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Object_Name_Value'; rValue : 'Объект');
  { Локализуемое значения атрибута TextStyle_Object_Name_Value }
 str_TextStyle_Mistake_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Mistake_Name_Value'; rValue : 'Опечатки');
  { Локализуемое значения атрибута TextStyle_Mistake_Name_Value }
 str_TextStyle_ColorSelection_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ColorSelection_Name_Value'; rValue : 'Цветовое выделение');
  { Локализуемое значения атрибута TextStyle_ColorSelection_Name_Value }
 str_TextStyle_HyperLink_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_HyperLink_Name_Value'; rValue : 'Гипертекстовая ссылка');
  { Локализуемое значения атрибута TextStyle_HyperLink_Name_Value }
 str_TextStyle_Interface_Font_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Interface_Font_Name_Value'; rValue : 'Arial');
  { Локализуемое значения атрибута TextStyle_Interface_Font_Name_Value }
 str_TextStyle_Interface_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Interface_Name_Value'; rValue : 'Интерфейс');
  { Локализуемое значения атрибута TextStyle_Interface_Name_Value }
 str_TextStyle_ActiveHyperLink_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ActiveHyperLink_Name_Value'; rValue : 'Активная гиперссылка');
  { Локализуемое значения атрибута TextStyle_ActiveHyperLink_Name_Value }
 str_TextStyle_NormalTable_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NormalTable_Name_Value'; rValue : 'Нормальный (таблица)');
  { Локализуемое значения атрибута TextStyle_NormalTable_Name_Value }
 str_TextStyle_CenteredTable_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_CenteredTable_Name_Value'; rValue : 'Центрированный (таблица)');
  { Локализуемое значения атрибута TextStyle_CenteredTable_Name_Value }
 str_TextStyle_ColorSelectionForBaseSearch_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ColorSelectionForBaseSearch_Name_Value'; rValue : 'Выделение для Базового Поиска');
  { Локализуемое значения атрибута TextStyle_ColorSelectionForBaseSearch_Name_Value }
 str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_ItalicColorSelectionForBaseSearch_Name_Value'; rValue : 'Выделение для Базового Поиска (курсив)');
  { Локализуемое значения атрибута TextStyle_ItalicColorSelectionForBaseSearch_Name_Value }
 str_TextStyle_Dialogs_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Dialogs_Name_Value'; rValue : 'Текст диалогов');
  { Локализуемое значения атрибута TextStyle_Dialogs_Name_Value }
 str_TextStyle_TOC_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TOC_Name_Value'; rValue : 'Структура документа');
  { Локализуемое значения атрибута TextStyle_TOC_Name_Value }
 str_TextStyle_Attention_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Attention_Name_Value'; rValue : 'Внимание');
  { Локализуемое значения атрибута TextStyle_Attention_Name_Value }
 str_TextStyle_Attention_ShortName_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_Attention_ShortName_Value'; rValue : 'Внимание');
  { Локализуемое значения атрибута TextStyle_Attention_ShortName_Value }
 str_TextStyle_WriteToUs_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_WriteToUs_Name_Value'; rValue : 'Напишите нам');
  { Локализуемое значения атрибута TextStyle_WriteToUs_Name_Value }
 str_TextStyle_AbolishedDocumentLink_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_AbolishedDocumentLink_Name_Value'; rValue : 'Ссылка на утративший силу документ');
  { Локализуемое значения атрибута TextStyle_AbolishedDocumentLink_Name_Value }
 str_TextStyle_NewsConfigStyle_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_NewsConfigStyle_Name_Value'; rValue : 'Текст гиперссылки "Настройка новостной ленты"');
  { Локализуемое значения атрибута TextStyle_NewsConfigStyle_Name_Value }
 str_TextStyle_AACHyperlink_Name_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_AACHyperlink_Name_Value'; rValue : 'Гиперссылка для ЭР-содержания');
  { Локализуемое значения атрибута TextStyle_AACHyperlink_Name_Value }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_Frame_Empty_Name_Value
 str_Frame_Empty_Name_Value.Init;
// Инициализация str_Frame_Solid_Name_Value
 str_Frame_Solid_Name_Value.Init;
// Инициализация str_Frame_Down_Name_Value
 str_Frame_Down_Name_Value.Init;
// Инициализация str_TextStyle_TxtNormalANSI_Name_Value
 str_TextStyle_TxtNormalANSI_Name_Value.Init;
// Инициализация str_TextStyle_Object_Font_Name_Value
 str_TextStyle_Object_Font_Name_Value.Init;
// Инициализация str_TextStyle_Object_Name_Value
 str_TextStyle_Object_Name_Value.Init;
// Инициализация str_TextStyle_Mistake_Name_Value
 str_TextStyle_Mistake_Name_Value.Init;
// Инициализация str_TextStyle_ColorSelection_Name_Value
 str_TextStyle_ColorSelection_Name_Value.Init;
// Инициализация str_TextStyle_HyperLink_Name_Value
 str_TextStyle_HyperLink_Name_Value.Init;
// Инициализация str_TextStyle_Interface_Font_Name_Value
 str_TextStyle_Interface_Font_Name_Value.Init;
// Инициализация str_TextStyle_Interface_Name_Value
 str_TextStyle_Interface_Name_Value.Init;
// Инициализация str_TextStyle_ActiveHyperLink_Name_Value
 str_TextStyle_ActiveHyperLink_Name_Value.Init;
// Инициализация str_TextStyle_NormalTable_Name_Value
 str_TextStyle_NormalTable_Name_Value.Init;
// Инициализация str_TextStyle_CenteredTable_Name_Value
 str_TextStyle_CenteredTable_Name_Value.Init;
// Инициализация str_TextStyle_ColorSelectionForBaseSearch_Name_Value
 str_TextStyle_ColorSelectionForBaseSearch_Name_Value.Init;
// Инициализация str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value
 str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value.Init;
// Инициализация str_TextStyle_Dialogs_Name_Value
 str_TextStyle_Dialogs_Name_Value.Init;
// Инициализация str_TextStyle_TOC_Name_Value
 str_TextStyle_TOC_Name_Value.Init;
// Инициализация str_TextStyle_Attention_Name_Value
 str_TextStyle_Attention_Name_Value.Init;
// Инициализация str_TextStyle_Attention_ShortName_Value
 str_TextStyle_Attention_ShortName_Value.Init;
// Инициализация str_TextStyle_WriteToUs_Name_Value
 str_TextStyle_WriteToUs_Name_Value.Init;
// Инициализация str_TextStyle_AbolishedDocumentLink_Name_Value
 str_TextStyle_AbolishedDocumentLink_Name_Value.Init;
// Инициализация str_TextStyle_NewsConfigStyle_Name_Value
 str_TextStyle_NewsConfigStyle_Name_Value.Init;
// Инициализация str_TextStyle_AACHyperlink_Name_Value
 str_TextStyle_AACHyperlink_Name_Value.Init;

end.