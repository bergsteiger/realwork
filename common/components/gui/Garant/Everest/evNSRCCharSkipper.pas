unit evNSRCCharSkipper;

{ Библиотека "Эверест"        }
{ Автор: Люлин А.В. ©         }
{ Модуль: evNSRCCharSkipper - }
{ Начат: 03.05.2001 17:40     }
{ $Id: evNSRCCharSkipper.pas,v 1.7 2013/04/05 12:02:15 lulin Exp $ }

// $Log: evNSRCCharSkipper.pas,v $
// Revision 1.7  2013/04/05 12:02:15  lulin
// - портируем.
//
// Revision 1.6  2010/08/11 09:05:17  dinishev
// [$182452385]. Вернул, т.к. в Немезисе и в модели разъехалось - недоглядел. :-(
//
// Revision 1.4  2010/08/11 06:48:44  dinishev
// [$182452385]
//
// Revision 1.4  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.2  2006/10/12 15:17:37  lulin
// - переехали в общую папку.
//
// Revision 1.1.2.1  2006/10/12 15:15:01  lulin
// - переехали в общую папку.
//
// Revision 1.2  2003/07/02 15:05:06  law
// - bug fix: были моменты, когда экспорт в NSRC входил в бесконечный цикл.
//
// Revision 1.1  2001/05/04 11:02:12  law
// - new behavior: сделан учет спецсимволов при выливке таблиц в NSRC и txt.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3CharSkipper
  ;

type
  TevNSRCCharSkipper = class(Tl3CharSkipper)
    private
    //internal fields
      f_HyperlinkCharCount : Long;
    protected
    //internal methods
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      // Il3CharSkipper
      function  GetChar: AnsiChar;
        override;
        {-}
  end;//TevNSRCCharSkipper

implementation

uses
  l3Chars,
  
  evNSRCConst
  ;

procedure TevNSRCCharSkipper.Cleanup;
  //override;
  {-}
begin
 f_HyperlinkCharCount := 0;
 inherited;
end;

function TevNSRCCharSkipper.GetChar: AnsiChar;
  //override;
  {-}
begin
 repeat
  Result := inherited GetChar;
  if (Result = cc_Null) then
   break;
  if (Result = ev_NSRCHyperlink) then begin
   Inc(f_HyperlinkCharCount);
   Case f_HyperlinkCharCount of
    1,2 : Result := ev_NSRCHyperlinkCont;
    3   : begin
     f_HyperlinkCharCount := 0;
     Result := ev_NSRCHyperlinkCont;
    end;//3
   end;//Case f_HyperlinkCharCount
   //Result = ev_NSRCHyperlink
  end else if (f_HyperlinkCharCount = 2) then
   Result := ev_NSRCHyperlinkCont;
 until not(Result in ev_NSRCSimple);
end;

end.

