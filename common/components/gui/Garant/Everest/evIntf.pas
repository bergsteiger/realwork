unit evIntf;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evIntf -        }
{ Начат: 28.04.2006 15:23 }
{ $Id: evIntf.pas,v 1.258 2007/12/04 12:47:02 lulin Exp $ }

// $Log: evIntf.pas,v $
// Revision 1.258  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.237.2.29  2006/04/28 11:46:04  lulin
// - bug fix: не собиралась библиотека.
//

{$Include evDefine.inc }

interface

uses
  evCustomFont,
  evFont
  ;

type
  TevCustomFont = evCustomFont.TevCustomFont;
  TevFont = evFont.TevFont;  

implementation

end.

