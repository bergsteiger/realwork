unit ddSpellInterfaces;

{ Библиотека ""           }
{ Автор: Люлин А.В. ©     }
{ Модуль: ddSpellInterfaces - }
{ Начат: 29.10.2002 13:04 }
{ $Id: ddSpellInterfaces.pas,v 1.13 2014/05/27 12:03:57 lulin Exp $ }

// $Log: ddSpellInterfaces.pas,v $
// Revision 1.13  2014/05/27 12:03:57  lulin
// - чистка кода.
//
// Revision 1.12  2014/04/25 10:28:17  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/08 14:16:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2013/04/17 14:19:22  lulin
// - портируем.
//
// Revision 1.9  2013/01/29 11:25:17  fireton
// - передаём кодировку в проверку орфографии
//
// Revision 1.8  2011/05/18 13:40:50  fireton
// - опция "считать точку разделителем слов при проверке орфографии"
//
// Revision 1.7  2011/05/17 13:56:03  fireton
// - возможность отключения проверки орфографии в коротких словах
//
// Revision 1.6  2008/02/06 11:44:37  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.5  2007/08/30 19:41:21  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.4  2005/03/28 12:00:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.3  2005/03/11 16:28:58  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.2  2004/06/02 08:33:15  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.1  2002/10/29 11:08:04  law
// - new directive: evDualSpell.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Interfaces,
  l3StringList,

  k2Interfaces
  ;

type
  TddFilterWordEvent = function(const aString: Tl3WString): Bool of object;
   {-}
  IddSpeller = interface(IUnknown)
    // property methods
      procedure pm_SetFilter(aValue: TddFilterWordEvent);
        {-}
      function pm_GetMinWordLength: Integer;
      procedure pm_SetMinWordLength(const Value: Integer);
        {-}
      function pm_GetDotIsWordSeparator: Boolean;
      procedure pm_SetDotIsWordSeparator(const Value: Boolean);
    // public methods
      function AddWord(const aStr : Tl3PCharLen): Bool;
        {-}
      procedure CreateAltvForms(aList : Tl3StringList;
                                aBuff : PAnsiChar;
                                aSize : LongInt;
                                aOemCp: LongBool);

        {* - возвращает список альтернатив. }
      function  SearchEvent(Sender : Tl3Variant;
                            aString      : Tl3CustomString;
                            aBegPos      : Long;
                            aEndPos      : Long;
                            var aBegRes  : Long;
                            var aEndRes  : Long): Bool;
        {* - проверяет строку. }
    // public properties
      property Filter: TddFilterWordEvent
        write pm_SetFilter;
        {-}
      property DotIsWordSeparator: Boolean
        read pm_GetDotIsWordSeparator
        write pm_SetDotIsWordSeparator;
        {-}
      property MinWordLength: Integer
        read  pm_GetMinWordLength
        write pm_SetMinWordLength;
        {-}
  end;//IddSpeller

implementation

end.

