unit F1_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/F1_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi For F1::Everest Engine::EVD::F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  evdTypes,
  evdStyles,
  Graphics,
  Everest_Schema,
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a}
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

type
 TF1Schema = class(TEverestSchema)
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TF1Schema

{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3Const,
  l3Canvas,
  eeDocument_Schema,
  F1_AttrValues,
  f1TextStyle_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  eeTextPara_InterfaceFactory,
  eeDocument_InterfaceFactory,
  evdTextStyle_Const,
  TextPara_Const,
  DecorTextPara_Const,
  Document_Const,
  BitmapPara_Const,
  evTextStyle_Const,
  k2List {a},
  k2NonOptimizeContext {a}
  ;
{$IfEnd} //Nemesis


{$If defined(Nemesis)}

// start class TF1Schema

constructor TF1Schema.Create;
begin
 inherited;
 // TextStyle
 with t_TextStyle do
 begin
  Recalc;
  // Моноширинный
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -12;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ANSIDOS_Name_Value.AsStr;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itPreformatted);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Сравнение редакций
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65534;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_CompareEditionsText_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrBold, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Удалённый текст
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -65534;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -42;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_DeletedText_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrStrikeout, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок собственного сообщения
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -43;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChatHeaderSender_Name_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок полученного сообщения
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -44;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChatHeaderRecipient_Name_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Добавленный текст
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -65534;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -41;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_AddedText_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := Ord(clAqua);
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Основное меню
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65531;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NewSchoolMainMenu_Name_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Основное меню
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -29;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenu_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenu_Font_Name_Value.AsStr;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 8;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовки основного меню
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -29;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -33;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuHeader_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $00A95800;
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := Ord(clBtnFace);
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // шрифт основного меню, постоянная часть
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -29;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -31;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuConstPath_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Шрифт основного меню, постоянная часть 2009
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -65531;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65532;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NewSchoolMainMenuConstPath_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NewSchoolMainMenuConstPath_Font_Name_Value.AsStr;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $00A95800;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовки основного меню 2009
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -65531;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65533;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NewSchoolMainMenuHeader_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := Ord(clBlack);
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := Ord(clWhite);
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 11;
     StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NewSchoolMainMenuHeader_Font_Name_Value.AsStr;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // шрифт основного меню, переменная часть
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -29;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -32;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuChangePath_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // заголовки основного меню, являющиеся гипперссылками
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -33;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -34;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuInteractiveHeader_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Обзор изменений документа 1
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65530;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Changes1_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itCenter);
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := true;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := Ord(clPurple);
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Обзор изменений документа 2
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -65530;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65529;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Changes2_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок приложения
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saEnclosureHeader);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_EnclosureHeader_Name_Value.AsStr;
    BoolW[k2_attrApply2Para, Tk2NonOptimizeContext.Instance] := true;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itRight);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Интервал действия редакции
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saEditionInterval);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_EditionInterval_Name_Value.AsStr;
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Редакция
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saEdition);
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 370;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Edition_Name_Value.AsStr;
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Номер редакции
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := f1_saEditionInterval;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saEditionNumber);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_EditionNumber_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := Ord(clSilver);
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := false;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Дочерний элемент списка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saSnippet);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Snippet_Name_Value.AsStr;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 11;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $818386;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Посещенный документ (в списке)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saVisitedDocumentInList);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_VisitedDocumentInList_Name_Value.AsStr;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $8b1a55;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Посещенный дочерний элемент списка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := f1_saSnippet;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saVisitedSnippetInList);
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_VisitedSnippetInList_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $8b1a55;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Технический комментарий
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saTechComment);
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TechComment_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := Ord(clYellow);
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
 end;//TextStyle
 // TextPara
 with t_TextPara do
 begin
  InterfaceFactoryType := TeeTextParaInterfaceFactory;
 end;//TextPara
 // Document
 with t_Document do
 begin
  InterfaceFactoryType := TeeDocumentInterfaceFactory;
 end;//Document
 // DecorTextPara
 with t_DecorTextPara do
 begin
  InterfaceFactoryType := TeeTextParaInterfaceFactory;
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   DefaultValue := f1_saTechComment;
  end;//Style
 end;//DecorTextPara
 // BitmapPara
 with t_BitmapPara do
 begin
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   Stored := false;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrHeight]) do
  begin
   Stored := true;
  end;//Height
 end;//BitmapPara
 t_TextStyle.Recalc;
 t_TextPara.Recalc;
 t_Document.Recalc;
 t_DecorTextPara.Recalc;
 t_BitmapPara.Recalc;
end;

// определяем стандартные методы схемы


procedure TF1Schema.Cleanup;
begin
 inherited;
end;

{$IfEnd} //Nemesis


initialization
{$If defined(Nemesis)}
 TF1Schema.SetAsDefault;
{$IfEnd} //Nemesis


end.