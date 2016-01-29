unit m3IndexInterfaces;
{* Интерфейсы индексатора. }

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3IndexInterfaces - }
{ Начат: 20.11.2001 15:39 }
{ $Id: m3IndexInterfaces.pas,v 1.4 2009/03/19 16:28:30 lulin Exp $ }

// $Log: m3IndexInterfaces.pas,v $
// Revision 1.4  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.3  2008/02/05 12:49:28  lulin
// - упрощаем базовые объекты.
//
// Revision 1.2  2007/02/09 14:40:03  voba
// - buf fix (Шура чото наменял)
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.4  2002/02/20 12:42:36  law
// - new units: первая реализация индексации документов.
//
// Revision 1.3  2001/12/11 14:27:22  law
// - new method versions: Im3ParaIndexBuilder.AddPara.
//
// Revision 1.2  2001/11/20 14:29:41  law
// - new unit: m3ParaIndexBuilder.
//
// Revision 1.1  2001/11/20 12:40:49  law
// - new units.
//

{$I m3Define.inc}

interface

uses
  l3Interfaces,
  l3Types,
  l3Base
  ;

type
  Im3ParaIndexBuilder = interface(IUnknown)
   {* Построитель индекса для потока параграфов. }
    ['{E79F96FD-967C-4117-853A-10DAAECFE047}']
    // public methods
      procedure AddPara(aPara : Tl3PrimString);
        overload;
        {* - добавить параграф в индекс. }
      procedure AddPara(aParaNum : Long;
                        aPara    : Tl3PrimString);
        overload;
        {* - добавить параграф в индекс. }
      procedure AddPara(aParaNum    : Long;
                        const aPara : Tl3WString);
        overload;
        {* - добавить параграф в индекс. }
  end;//Im3ParaIndexBuilder

implementation

end.

