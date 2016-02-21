unit Design_AttrValues;
 {* Локализуемые значения атрибутов значений тегов таблицы тегов Design }

// Модуль: "w:\common\components\gui\Garant\Everest\Design_AttrValues.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
{$If Defined(DesignTimeLibrary)}
 {* Локализуемые строки AttrValues }
 str_TextStyle_MainMenu_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenu_Font_Name_Value'; rValue : 'Verdana');
  {* Локализуемое значения атрибута TextStyle_MainMenu_Font_Name_Value }
 str_TextStyle_MainMenu_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenu_Name_Value'; rValue : 'Основное меню');
  {* Локализуемое значения атрибута TextStyle_MainMenu_Name_Value }
 str_TextStyle_MainMenuConstPath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuConstPath_Name_Value'; rValue : 'Постоянная часть');
  {* Локализуемое значения атрибута TextStyle_MainMenuConstPath_Name_Value }
 str_TextStyle_MainMenuChangePath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuChangePath_Name_Value'; rValue : 'Переменная часть');
  {* Локализуемое значения атрибута TextStyle_MainMenuChangePath_Name_Value }
 str_TextStyle_MainMenuHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuHeader_Name_Value'; rValue : 'Заголовок');
  {* Локализуемое значения атрибута TextStyle_MainMenuHeader_Name_Value }
 str_TextStyle_MainMenuInteractiveHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuInteractiveHeader_Name_Value'; rValue : 'Интерактивный');
  {* Локализуемое значения атрибута TextStyle_MainMenuInteractiveHeader_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenu_Font_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenu_Font_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenu_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenu_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuConstPath_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuConstPath_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuChangePath_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuChangePath_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuHeader_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuInteractiveHeader_Name_Value.Init;
 {* Инициализация str_TextStyle_MainMenuInteractiveHeader_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)

end.
