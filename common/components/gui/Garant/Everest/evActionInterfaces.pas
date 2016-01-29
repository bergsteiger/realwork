unit evActionInterfaces;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evActionInterfaces - }
{ Начат: 04.10.2001 10:57 }
{ $Id: evActionInterfaces.pas,v 1.4 2001/12/28 12:31:07 law Exp $ }

// $Log: evActionInterfaces.pas,v $
// Revision 1.4  2001/12/28 12:31:07  law
// - new prop: в описание операции добавлено свойство ShortCut.
//
// Revision 1.3  2001/10/10 10:56:39  law
// - new behavior: заточка под Action от Delphi 6.0.
//
// Revision 1.2  2001/10/04 12:42:36  law
// - new behavior: сделан котнроль за сохранением свойств Category и AutoCheck.
//
// Revision 1.1  2001/10/04 09:57:07  law
// - new behavior: сделана возможность определения парамеров операций по умолчанию.
//

{$I evDefine.inc }

interface

uses
  Classes,
  
  l3Types
  ;

type
  IevExtActionDescriptor = interface(IUnknown)
    ['{56C53192-60C6-4B33-A816-05B361065209}']
    // property methods
      function pm_GetHint: String;
        {-}
      function pm_GetCaption: String;
        {-}
      function pm_GetAutoCheck: Bool;
        {-}
      function pm_GetGroupIndex: Integer;
        {-}
      function pm_GetShortCut: TShortCut;
        {-}
    // public properties
      property Hint: String
        read pm_GetHint;
        {-}
      property Caption: String
        read pm_GetCaption;
        {-}
      property AutoCheck: Bool
        read pm_GetAutoCheck;
        {-}
      property GroupIndex: Integer
        read pm_GetGroupIndex;
        {-}
      property ShortCut: TShortCut
        read pm_GetShortCut;
        {-}
  end;//IevExtActionDescriptor

implementation

end.

