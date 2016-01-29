unit evSolidParaCursorPair;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evSolidParaCursorPair - }
{ Начат: 17.12.2002 12:58 }
{ $Id: evSolidParaCursorPair.pas,v 1.12 2009/07/14 14:56:28 lulin Exp $ }

// $Log: evSolidParaCursorPair.pas,v $
// Revision 1.12  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.11  2008/11/11 11:09:23  lulin
// - <K>: 122672539.
//
// Revision 1.10  2008/05/28 07:58:23  lulin
// - <CQ>: 29146.
//
// Revision 1.9  2008/04/11 12:26:08  lulin
// - <K>: 89100752.
//
// Revision 1.8  2008/04/11 12:01:31  lulin
// - <K>: 89100701.
//
// Revision 1.7  2008/04/11 11:29:58  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.6  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.5.8.1  2005/07/20 18:21:14  lulin
// - убран переходный интерфейс.
//
// Revision 1.5  2005/03/31 09:27:10  lulin
// - new unit: k2TagTool.
//
// Revision 1.4  2004/12/21 15:38:05  lulin
// - используем интерфейсы вместо объектов.
//
// Revision 1.3  2004/05/21 12:41:20  law
// - bug fix: не печаталась (не сохранялась) картика, когда выделение заканчивалось ею (CQ OIT5-7020).
//
// Revision 1.2  2003/10/16 15:46:57  law
// - new unit: evLeafParaCursorPair.
//
// Revision 1.1  2002/12/17 10:03:26  law
// - new unit: evSolidParaCursorPair.
//

{$I evDefine.inc }

interface

uses
  l3Types,

  evLeafParaCursorPair,

  nevTools
  ;

type  
  TevSolidParaCursorPair = class(TevLeafParaCursorPair)
    protected
    // internal methods
      function  IsSolid(const aView: InevView): Bool;
        override;
        {-}
      function  GetContainsEnd(const aView: InevView): Bool;
        override;
        {-}
  end;//TevSolidParaCursorPair

implementation

// start class TevSolidParaCursorPair

function TevSolidParaCursorPair.IsSolid(const aView: InevView): Bool;
  //override;
  {-}
var
 SC, FC : InevBasePoint;
begin
 GetBorderPoints(SC, FC);
 Result := (SC = nil) OR (FC = nil);
 if not Result then
  Result := (SC.Compare(FC) = 0);
end;

function TevSolidParaCursorPair.GetContainsEnd(const aView: InevView): Bool;
  //override;
  {-}
begin
 Result := IsSolid(aView);
end;
  
end.

