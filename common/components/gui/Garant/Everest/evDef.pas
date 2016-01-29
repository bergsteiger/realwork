unit evDef;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evDef - значения свойств по умолчанию}
{ Начат: 18.03.1997 10:41 }
{ $Id: evDef.pas,v 1.38 2013/05/31 12:25:32 dinishev Exp $ }

// $Log: evDef.pas,v $
// Revision 1.38  2013/05/31 12:25:32  dinishev
// Размер шрифта по умолчанию для EverestLite.
//
// Revision 1.37  2012/11/01 09:41:35  lulin
// - забыл точку с запятой.
//
// Revision 1.36  2012/11/01 07:42:57  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.35  2009/04/14 18:11:54  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.34  2008/09/15 12:17:58  lulin
// - переносим на модель.
//
// Revision 1.33  2008/09/09 15:40:08  lulin
// - удалены ненужные свойства.
//
// Revision 1.32  2008/08/07 13:29:21  lulin
// - <K>: 96484675.
//
// Revision 1.31  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.30  2008/06/16 13:55:03  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.29  2008/06/09 14:03:27  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.28  2008/06/04 13:12:09  lulin
// - переименованы константы.
//
// Revision 1.27  2008/06/04 10:08:42  lulin
// - переносим на модель.
//
// Revision 1.26  2008/06/03 14:16:27  lulin
// - переносим на модель.
//
// Revision 1.25  2008/05/16 14:01:10  lulin
// - переносим на модель.
//
// Revision 1.24  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.20.8.5  2007/07/18 15:07:18  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.20.8.4  2006/12/11 12:25:06  lulin
// - cleanup.
//
// Revision 1.20.8.3  2006/12/04 13:43:56  oman
// - fix: Константа для определения минимальной печатной области
//  вынесена в l3/ev (cq23103)
//
// Revision 1.20.8.2  2005/08/25 14:35:17  lulin
// - bug fix: использовалась неинициализированная константа.
//
// Revision 1.20.8.1  2005/05/24 14:50:01  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.20  2005/03/31 15:47:23  lulin
// - new methods: InevPara._LockFormatting, UnlockFormatting, Unformat.
//
// Revision 1.19  2005/02/22 14:53:53  lulin
// - параметрам страницы добавлены отступы сверху/снизу, справа/слева.
//
// Revision 1.18  2004/11/29 15:28:26  lulin
// - bug fix: не обрабатывали значение Default у ForeColor.
//
// Revision 1.17  2003/05/12 12:51:26  law
// - new behavior: в режиме отображения спецсимволов сделана отрисовка табуляции в виде стрелочки.
//
// Revision 1.16  2003/04/15 13:26:43  law
// - new unit: evUnits.
//
// Revision 1.15  2002/07/09 12:02:19  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.14  2001/09/10 11:38:31  law
// - split unit: evDef -> evDef + l3Defaults.
//
// Revision 1.13  2001/04/20 14:03:52  law
// - cleanup: def_cm* => def_inch*, evCm2Pixel -> l3Cm2Inch.
//
// Revision 1.12  2001/04/20 12:23:28  law
// - cleanup: const -> resourcestring.
//
// Revision 1.11  2001/04/20 11:17:47  law
// - new const: добавлены константы ev_inch*.
//
// Revision 1.10  2001/04/17 17:01:13  law
// - bug fix: поправлена ошибка точности при вычислении числа символов на линейке.
//
// Revision 1.9  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Graphics,
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  Controls,
  StdCtrls,
  {$EndIf l3ConsoleApp}
  l3Chars,
  l3Types,
  l3Defaults,

  evdTypes,
  evdStyles,

  evTypes,
  evConst
  ;

const
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  def_ScrollStyle     = ssBoth;
  {$EndIf l3ConsoleApp}
  def_TabStop         = true;
  def_IsOpen          = false;
  def_Ctl3D           = true;
  def_Zoom            = l3Defaults.def_Zoom;
  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  def_EditorCursor    = crIBeam;
  {$EndIf l3ConsoleApp}

  def_FontColor       = clDefault;//clBlack;
  def_BackColor       = clDefault;
  def_InvisibleColor  = clSilver;
  {$IFDEF EverestLite}
  def_FontSize        = 12;
  {$ELSE}
  def_FontSize        = 10;
  {$ENDIF EverestLite}
  def_FontPitch       = Ord(fpDefault);
  def_FontBold        = 0;
  def_FontItalic      = 0;
  def_FontUnderline   = 0;
  def_FontStrikeOut   = 0;
  def_FontIndex       = Ord(Low(Tl3FontIndex));

resourcestring
  def_ArialFontName     = 'Arial';
  def_SymbolFontName    = 'Symbol';
  def_SmallFontName     = 'Small Fonts';
  def_FontName          = 'Arial CYR';

const
  def_SmallFontSize    = 4;
  def_CharWidth        = 10;

  def_cmPaperWidth     = l3Defaults.def_cmPaperWidth;
  def_cmPaperHeight    = l3Defaults.def_cmPaperHeight;
  def_cmPaperLeft      = l3Defaults.def_cmPaperLeft;
  def_cmPaperRight     = l3Defaults.def_cmPaperRight;
  def_cmPaperTop       = l3Defaults.def_cmPaperTop;
  def_cmPaperBottom    = l3Defaults.def_cmPaperBottom;
  def_cmPrintableWidth = l3Defaults.def_cmPrintableWidth;
  def_cmMinPrintArea   = l3Defaults.def_cmMinPrintArea;

  def_cmParaWidth      = def_cmPrintableWidth; // - 08.06.2000

  def_cmSBSWidth       = def_cmParaWidth;
  def_cmSBSFirstI      = 0;
  def_cmSBSIndent      = 30;

  def_cmMemoWidth     = 100000;

  def_LMargin         = 0;
  def_RMargin         = 0;

  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  def_EditScrollStyle = ssNone;
  {$EndIf l3ConsoleApp}

  {$IfDef l3ConsoleApp}
  {$Else  l3ConsoleApp}
  def_MemoScrollStyle = ssVertical;
  {$EndIf l3ConsoleApp}
  def_DefaultStyle    = ev_saTxtNormalANSI;

var
  def_inchSBSWidth       : Long = 0;
  def_inchSBSFirstI      : Long = 0;
  def_inchSBSIndent      : Long = 0;
  def_inchMemoWidth      : Long = 0;
  def_inchMinPrintArea   : Integer = 0;

implementation

uses
  l3UnitsTools
  ;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evDef.pas initialization enter'); {$EndIf}
  def_inchSBSWidth := l3Cm2Inch(def_cmSBSWidth);
  def_inchSBSFirstI := l3Cm2Inch(def_cmSBSFirstI);
  def_inchSBSIndent := l3Cm2Inch(def_cmSBSIndent);
  def_inchMemoWidth := l3Cm2Inch(def_cmMemoWidth);
  def_inchMinPrintArea := l3Cm2Inch(def_cmMinPrintArea);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evDef.pas initialization leave'); {$EndIf}
end.

