unit eeBaseInterfaces;
{* Интерфейсы для внешнего использования библиотеки Эверест. }

{$WEAKPACKAGEUNIT ON}

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeBaseInterfaces - }
{ Начат: 18.04.2003 13:20 }
{ $Id: eeBaseInterfaces.pas,v 1.5 2015/04/24 14:37:02 lulin Exp $ }

// $Log: eeBaseInterfaces.pas,v $
// Revision 1.5  2015/04/24 14:37:02  lulin
// - правильный define.
//
// Revision 1.4  2015/04/24 14:34:27  lulin
// - правильный define.
//
// Revision 1.3  2014/02/26 14:34:29  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.2  2014/02/24 09:41:37  lulin
// {RequestLink:518429676}
//
// Revision 1.1  2014/02/05 13:16:43  lulin
// - выделяем GUIAppTester.
//
// Revision 1.19  2013/10/21 15:42:59  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.18  2011/07/18 15:45:24  lulin
// {RequestLink:228688745}.
// - приклеиваем изменения к заголовку.
// - не трогаем комментарии юристов в таблицах.
//
// Revision 1.17  2011/07/15 17:30:36  lulin
// {RequestLink:269058433}.
//
// Revision 1.16  2007/12/04 12:47:33  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.14.8.6  2007/08/10 19:17:22  lulin
// - cleanup.
//
// Revision 1.14.8.5  2007/08/09 14:55:22  lulin
// - избавляемся от излишнего использования интерфейсов.
//
// Revision 1.14.8.4  2007/08/02 19:15:33  lulin
// - cleanup.
//
// Revision 1.14.8.3  2007/08/02 18:50:39  lulin
// - cleanup.
//
// Revision 1.14.8.2  2005/07/08 09:24:10  lulin
// - bug fix: размеры параметров синхронизированы с C++.
//
// Revision 1.14.8.1  2005/05/24 14:50:04  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.14  2005/03/01 10:34:48  lulin
// - добавлена директива WEAKPACKAGEUNIT.
//
// Revision 1.13  2004/10/28 09:46:34  lulin
// - new methods: IeeGenerator.StartDefaultChild, _AddTransparentAtom.
// - remove method: IeeGenerator.Char2Inch.
//
// Revision 1.12  2003/12/16 17:26:56  law
// - bug fix: забыл GUID.
//
// Revision 1.11  2003/12/16 17:23:17  law
// - new interface: IeeGeneratorWithHyperlinkCB.
// - new class: TeeGeneratorWithHyperlinkCB
//
// Revision 1.10  2003/12/01 12:39:12  law
// - new method: _TeeHyperlinkFilter.SetFilter.
// - new method: TevCustomEvdReader.SetReader.
// - new field: TeeAddress.rRevision.
//
// Revision 1.9  2003/11/29 15:36:21  law
// - new class: _TeeHyperlinkFilter.
// - new proc: eeSetHyperlinkFilter.
//
// Revision 1.8  2003/10/14 13:11:56  law
// - new method: IeeGenerator._AddRawData.
//
// Revision 1.7  2003/05/22 14:59:35  law
// - new proc: eeGetCBGenerator.
//
// Revision 1.6  2003/05/19 11:43:59  law
// - new method: IeeGenerator.Char2Inch.
//
// Revision 1.5  2003/05/13 08:14:28  law
// - new methods: IeeGenerator._AddStreamAtom, IeeGenerator.AddMemAtom.
//
// Revision 1.4  2003/04/24 14:29:45  law
// - новая сборка dll.
// - изменилися формат вызова eeGetGenerator, eeGetFileGenerator.
//
// Revision 1.3  2003/04/18 12:40:47  law
// - bug fix: не собирался пример.
// - new: добавлен пример генерации.
//
// Revision 1.2  2003/04/18 11:12:35  law
// - new unit: eeGeneratorEx.
//
// Revision 1.1  2003/04/18 09:30:59  law
// - new unit: eeBaseInterfaces.
//

{.$I evDefine.inc }

interface

uses
  ActiveX,
  Windows
  ;

const
  CP_ANSI = CP_ACP;
  CP_OEM = CP_OEMCP;

type
(*  TeeAddress = record
   rDocID    : Integer;
   rSubID    : Integer;
   rRevision : Integer;
   rType     : Integer;
  end;//TeeAddress
  PeeAddress = ^TeeAddress;*)

  TeeTagID = Longint;
  TeeCodePage = Longint;

implementation

end.

