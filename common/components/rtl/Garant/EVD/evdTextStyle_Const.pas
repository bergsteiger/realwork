unit evdTextStyle_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdTextStyle_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::TextStyle
//
// Стиль оформления текста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TextStyle - "Стиль оформления текста".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema,
  evdStyles
  ;

const
 k2_idTextStyle = 39;

function k2_typTextStyle_Header: TextStyle_Header_Tag;

function k2_typTextStyle_Footer: TextStyle_Footer_Tag;

function k2_attrJustification: Integer;

function k2_attrVisible: Integer;

function k2_attrApply2Para: Integer;

function k2_attrLeftIndent: Integer;

function k2_attrRightIndent: Integer;

function k2_attrFirstIndent: Integer;

function k2_attrFirstLineIndent: Integer;

function k2_attrWidth: Integer;

function k2_attrSpaceBefore: Integer;

function k2_attrSpaceAfter: Integer;

function k2_attrAllowHyphen: Integer;

function k2_attrCollapsable: Integer;

function k2_attrHeader: Integer;

function k2_attrFooter: Integer;

function k2_attrHeaderHasOwnSpace: Integer;

function k2_attrLineSpacing: Integer;

function k2_attrIsChangeableFont: Integer;

function k2_attrVisibleToUser: Integer;

function k2_attrVisibleToBlock: Integer;

function k2_attrFont: Integer;

function k2_attrShortName: Integer;

function k2_attrFrame: Integer;
function k2_typTextStyle: TextStyleTag;

const
 evd_saTxtNormalANSI = evdStyles.ev_saTxtNormalANSI;
  { Нормальный } 
 evd_saObject = evdStyles.ev_saObject;
  { псевдо-стиль, для объектных сегментов } 
 evd_saMistake = evdStyles.ev_saMistake;
  { Слово с опечаткой } 
 evd_saColorSelection = evdStyles.ev_saColorSelection;
  { Цветовое выделение } 
 evd_saHyperLink = evdStyles.ev_saHyperLink;
  { Гипертекстовая ссылка } 
 evd_saInterface = evdStyles.ev_saInterface;
  { Стиль для интерфейсных элементов } 
 evd_saActiveHyperLink = evdStyles.ev_saActiveHyperlink;
  { Активная гиперссылка } 
 evd_saNormalTable = evdStyles.ev_saNormalTable;
  { Нормальный для таблиц } 
 evd_saCenteredTable = evdStyles.ev_saCenteredTable;
  { Центрированный в таблице } 
 evd_saColorSelectionForBaseSearch = evdStyles.ev_saColorSelectionForBaseSearch;
  { Выделение для Базового Поиска } 
 evd_saItalicColorSelectionForBaseSearch = evdStyles.ev_saItalicColorSelectionForBaseSearch;
  { Выделение для Базового Поиска (курсив) } 
 evd_saDialogs = evdStyles.ev_saDialogs;
  { Текст диалогов } 
 evd_saTOC = evdStyles.ev_saTOC;
  {  } 
 evd_saAttention = evdStyles.ev_saAttention;
  { Внимание } 
 evd_saWriteToUs = evdStyles.ev_saWriteToUs;
  { Напишите нам } 
 evd_saAbolishedDocumentLink = evdStyles.ev_saAbolishedDocumentLink;
  {  } 
 evd_saNewsConfigStyle = evdStyles.ev_saNewsConfigHyperlink;
  { Стиль для оснонвого текста для ссылки на настройку новостной ленты. } 
 evd_saAACHyperlink = evdStyles.ev_saAACLeftHyperlink;
  {  } 

//#UC START# *484D2CBA0213const_intf*
const
 evd_saGUI =
  {$IfDef Archi}
  evd_saInterface
  {$Else  Archi}
  //evd_saTxtNormalANSI
  evd_saInterface
  // http://mdp.garant.ru/pages/viewpage.action?pageId=96475831
  {$EndIf Archi};
//#UC END# *484D2CBA0213const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TextStyle : TextStyleTag = nil;

// start class TextStyleTag

function k2_typTextStyle: TextStyleTag;
begin
 if (g_TextStyle = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_TextStyle := TevdNativeSchema(Tk2TypeTable.GetInstance).t_TextStyle;
 end;//g_TextStyle = nil
 Result := g_TextStyle;
end;
var
 g_k2_attrJustification: Integer = -1;

function k2_attrJustification: Integer;
begin
 if (g_k2_attrJustification = -1) then
  g_k2_attrJustification :=  Tk2Attributes.Instance.CheckIDByName('Justification');
 Result := g_k2_attrJustification;
end;

var
 g_k2_attrVisible: Integer = -1;

function k2_attrVisible: Integer;
begin
 if (g_k2_attrVisible = -1) then
  g_k2_attrVisible :=  Tk2Attributes.Instance.CheckIDByName('Visible');
 Result := g_k2_attrVisible;
end;

var
 g_k2_attrApply2Para: Integer = -1;

function k2_attrApply2Para: Integer;
begin
 if (g_k2_attrApply2Para = -1) then
  g_k2_attrApply2Para :=  Tk2Attributes.Instance.CheckIDByName('Apply2Para');
 Result := g_k2_attrApply2Para;
end;

var
 g_k2_attrLeftIndent: Integer = -1;

function k2_attrLeftIndent: Integer;
begin
 if (g_k2_attrLeftIndent = -1) then
  g_k2_attrLeftIndent :=  Tk2Attributes.Instance.CheckIDByName('LeftIndent');
 Result := g_k2_attrLeftIndent;
end;

var
 g_k2_attrRightIndent: Integer = -1;

function k2_attrRightIndent: Integer;
begin
 if (g_k2_attrRightIndent = -1) then
  g_k2_attrRightIndent :=  Tk2Attributes.Instance.CheckIDByName('RightIndent');
 Result := g_k2_attrRightIndent;
end;

var
 g_k2_attrFirstIndent: Integer = -1;

function k2_attrFirstIndent: Integer;
begin
 if (g_k2_attrFirstIndent = -1) then
  g_k2_attrFirstIndent :=  Tk2Attributes.Instance.CheckIDByName('FirstIndent');
 Result := g_k2_attrFirstIndent;
end;

var
 g_k2_attrFirstLineIndent: Integer = -1;

function k2_attrFirstLineIndent: Integer;
begin
 if (g_k2_attrFirstLineIndent = -1) then
  g_k2_attrFirstLineIndent :=  Tk2Attributes.Instance.CheckIDByName('FirstLineIndent');
 Result := g_k2_attrFirstLineIndent;
end;

var
 g_k2_attrWidth: Integer = -1;

function k2_attrWidth: Integer;
begin
 if (g_k2_attrWidth = -1) then
  g_k2_attrWidth :=  Tk2Attributes.Instance.CheckIDByName('Width');
 Result := g_k2_attrWidth;
end;

var
 g_k2_attrSpaceBefore: Integer = -1;

function k2_attrSpaceBefore: Integer;
begin
 if (g_k2_attrSpaceBefore = -1) then
  g_k2_attrSpaceBefore :=  Tk2Attributes.Instance.CheckIDByName('SpaceBefore');
 Result := g_k2_attrSpaceBefore;
end;

var
 g_k2_attrSpaceAfter: Integer = -1;

function k2_attrSpaceAfter: Integer;
begin
 if (g_k2_attrSpaceAfter = -1) then
  g_k2_attrSpaceAfter :=  Tk2Attributes.Instance.CheckIDByName('SpaceAfter');
 Result := g_k2_attrSpaceAfter;
end;

var
 g_k2_attrAllowHyphen: Integer = -1;

function k2_attrAllowHyphen: Integer;
begin
 if (g_k2_attrAllowHyphen = -1) then
  g_k2_attrAllowHyphen :=  Tk2Attributes.Instance.CheckIDByName('AllowHyphen');
 Result := g_k2_attrAllowHyphen;
end;

var
 g_k2_attrCollapsable: Integer = -1;

function k2_attrCollapsable: Integer;
begin
 if (g_k2_attrCollapsable = -1) then
  g_k2_attrCollapsable :=  Tk2Attributes.Instance.CheckIDByName('Collapsable');
 Result := g_k2_attrCollapsable;
end;

var
 g_k2_attrHeader: Integer = -1;

function k2_attrHeader: Integer;
begin
 if (g_k2_attrHeader = -1) then
  g_k2_attrHeader :=  Tk2Attributes.Instance.CheckIDByName('Header');
 Result := g_k2_attrHeader;
end;

var
 g_k2_attrFooter: Integer = -1;

function k2_attrFooter: Integer;
begin
 if (g_k2_attrFooter = -1) then
  g_k2_attrFooter :=  Tk2Attributes.Instance.CheckIDByName('Footer');
 Result := g_k2_attrFooter;
end;

var
 g_k2_attrHeaderHasOwnSpace: Integer = -1;

function k2_attrHeaderHasOwnSpace: Integer;
begin
 if (g_k2_attrHeaderHasOwnSpace = -1) then
  g_k2_attrHeaderHasOwnSpace :=  Tk2Attributes.Instance.CheckIDByName('HeaderHasOwnSpace');
 Result := g_k2_attrHeaderHasOwnSpace;
end;

var
 g_k2_attrLineSpacing: Integer = -1;

function k2_attrLineSpacing: Integer;
begin
 if (g_k2_attrLineSpacing = -1) then
  g_k2_attrLineSpacing :=  Tk2Attributes.Instance.CheckIDByName('LineSpacing');
 Result := g_k2_attrLineSpacing;
end;

var
 g_k2_attrIsChangeableFont: Integer = -1;

function k2_attrIsChangeableFont: Integer;
begin
 if (g_k2_attrIsChangeableFont = -1) then
  g_k2_attrIsChangeableFont :=  Tk2Attributes.Instance.CheckIDByName('IsChangeableFont');
 Result := g_k2_attrIsChangeableFont;
end;

var
 g_k2_attrVisibleToUser: Integer = -1;

function k2_attrVisibleToUser: Integer;
begin
 if (g_k2_attrVisibleToUser = -1) then
  g_k2_attrVisibleToUser :=  Tk2Attributes.Instance.CheckIDByName('VisibleToUser');
 Result := g_k2_attrVisibleToUser;
end;

var
 g_k2_attrVisibleToBlock: Integer = -1;

function k2_attrVisibleToBlock: Integer;
begin
 if (g_k2_attrVisibleToBlock = -1) then
  g_k2_attrVisibleToBlock :=  Tk2Attributes.Instance.CheckIDByName('VisibleToBlock');
 Result := g_k2_attrVisibleToBlock;
end;

var
 g_k2_attrFont: Integer = -1;

function k2_attrFont: Integer;
begin
 if (g_k2_attrFont = -1) then
  g_k2_attrFont :=  Tk2Attributes.Instance.CheckIDByName('Font');
 Result := g_k2_attrFont;
end;

var
 g_k2_attrShortName: Integer = -1;

function k2_attrShortName: Integer;
begin
 if (g_k2_attrShortName = -1) then
  g_k2_attrShortName :=  Tk2Attributes.Instance.CheckIDByName('ShortName');
 Result := g_k2_attrShortName;
end;

var
 g_k2_attrFrame: Integer = -1;

function k2_attrFrame: Integer;
begin
 if (g_k2_attrFrame = -1) then
  g_k2_attrFrame :=  Tk2Attributes.Instance.CheckIDByName('Frame');
 Result := g_k2_attrFrame;
end;


var
 g_TextStyle_Header : TextStyle_Header_Tag = nil;

// start class TevdHeader

function k2_typTextStyle_Header: TextStyle_Header_Tag;
begin
 if (g_TextStyle_Header = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_TextStyle_Header := TevdNativeSchema(Tk2TypeTable.GetInstance).t_TextStyle_Header;
 end;//g_TextStyle = nil
 Result := g_TextStyle_Header;
end;

var
 g_TextStyle_Footer : TextStyle_Footer_Tag = nil;

// start class TevdFooter

function k2_typTextStyle_Footer: TextStyle_Footer_Tag;
begin
 if (g_TextStyle_Footer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_TextStyle_Footer := TevdNativeSchema(Tk2TypeTable.GetInstance).t_TextStyle_Footer;
 end;//g_TextStyle = nil
 Result := g_TextStyle_Footer;
end;


end.