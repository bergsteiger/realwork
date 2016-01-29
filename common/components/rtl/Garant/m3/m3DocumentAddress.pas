unit m3DocumentAddress;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3DocumentAddress -            }
{ Начат: 05.03.2002 17:51 }
{ $Id: m3DocumentAddress.pas,v 1.4 2009/03/19 16:28:30 lulin Exp $ }

// $Log: m3DocumentAddress.pas,v $
// Revision 1.4  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.3  2007/08/14 14:30:17  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.2  2005/02/21 09:40:20  lulin
// - выводим отладочное сообщение для поиска ошибки.
//
// Revision 1.1  2004/09/02 08:09:47  law
// - cleanup.
//
// Revision 1.4  2002/09/09 11:11:19  voba
// - bug fix: не сортировался список документов.
//
// Revision 1.3  2002/04/16 15:02:23  law
// - _move const: m3StopWordAddress переехала в m3DocumentAddress.
//
// Revision 1.2  2002/03/11 12:48:42  law
// - new behavior: сделан поиск по сложным формулам (без учета расстояния).
//
// Revision 1.1  2002/03/05 16:12:39  law
// - new behavior: реализован простейший поиск по полной базе документов.
//

{$I m3Define.inc}

interface

uses
  l3Types,
  m3Index
  ;

type
  Tm3DocumentAddress = packed object(Tm3WordAddress)
    public
    // public fields
      rDocument : Long;
    public
    // public methods
      function CaseCompare(const aValue: Tm3DocumentAddress): Integer;
        {* - сравнивает два адреса. Возвращает (-1, 0, +1). }
      function Compare(const aValue: Tm3DocumentAddress): Integer;
        {* - сравнивает два адреса. }
  end;//Tm3DocumentAddress
  Pm3DocumentAddress = ^Tm3DocumentAddress;

const
  m3NullDocumentAddress : Tm3DocumentAddress = (rPara     : -1;
                                                rWord     : 0;
                                                rDocument : -1);
  m3StopWordAddress : Tm3DocumentAddress = (rPara     : Pred(High(Longint));
                                            rWord     : 0;
                                            rDocument : Pred(High(Longint)));


implementation

uses
  SysUtils,
  
  Math,

  l3Base
  ;

// start object Tm3DocumentAddress

function Tm3DocumentAddress.CaseCompare(const aValue: Tm3DocumentAddress): Integer;
  {* - сравнивает два адреса. Возвращает (-1, 0, +1). }
begin
 try
  Result := rDocument - aValue.rDocument;
 except
  l3System.Msg2Log(Format('!!! %d %d', [rDocument, aValue.rDocument]));
  raise;
 end;//try..except
 if (Result = 0) then
  Result := inherited CaseCompare(aValue)
 else
  Result := Sign(Result);
end;

function Tm3DocumentAddress.Compare(const aValue: Tm3DocumentAddress): Integer;
  {* - сравнивает два адреса. }
begin
 Result := rDocument - aValue.rDocument;
 if (Result = 0) then
  Result := inherited Compare(aValue);
end;

end.

