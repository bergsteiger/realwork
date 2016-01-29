unit evCodePageAnalyzer;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evCodePageAnalyzer - }
{ Начат: 23.04.2004 20:34 }
{ $Id: evCodePageAnalyzer.pas,v 1.12 2014/04/08 14:16:55 lulin Exp $ }

// $Log: evCodePageAnalyzer.pas,v $
// Revision 1.12  2014/04/08 14:16:55  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2009/08/18 08:47:31  lulin
// {ReqestLink:158795592}. №2.
//
// Revision 1.10  2009/06/02 17:23:15  lulin
// - удалены ненужные интерфейсы и переопределения типов.
//
// Revision 1.9  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.8.8.1  2007/08/10 19:01:28  lulin
// - cleanup.
//
// Revision 1.8  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.7  2005/03/11 13:04:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.6  2004/06/09 11:08:56  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.5  2004/05/05 12:52:38  law
// - rename method: TevBaseSearcher.Search -> TevBaseSearcher.DoCheckText.
//
// Revision 1.4  2004/04/28 11:33:46  fireton
// - bug fix: корректная отработка case c CP_OEMLite при l3Requires_m0
//
// Revision 1.3  2004/04/26 12:42:38  law
// - bug fix: выделен набор символов, различных для разных кодовых страниц.
//
// Revision 1.2  2004/04/23 17:09:47  law
// - new behavior: _TevCustomMemo.Buffer пытается возвращать строчку в правильной кодировке (пока не доделано).
//
// Revision 1.1  2004/04/23 16:47:29  law
// - new unit: evCodePageAnalyzer.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,

  k2Interfaces,

  nevTools,
  
  evSearch
  ;

type
  TevCodePageAnalyzer = class(TevBaseSearcher)
    private
    // internal fields
      f_CodePage : Integer;
    protected
    // internal methods
      procedure DoStart;
        override;
        {-}
    public
    // public methods
      function DoCheckText(Sender : Tl3Variant;
                           S            : Tl3CustomString;
                           const aSel   : TevPair;
                           out theSel   : TevPair): Bool;
        override;
        {* - определяет критерий отбора параграфа (его фрагмента). }
    public
    // public properties
      property CodePage: Integer
        read f_CodePage;
        {-}
  end;//TevCodePageAnalyzer

implementation

uses
  l3Chars,
  l3String
  ;

// start class TevCodePageAnalyzer

function TevCodePageAnalyzer.DoCheckText(Sender : Tl3Variant;
                                         S            : Tl3CustomString;
                                         const aSel   : TevPair;
                                         out theSel   : TevPair): Bool;
  //override;
  {* - определяет критерий отбора параграфа (его фрагмента). }
begin
 if not S.Empty then
 begin
  if (f_CodePage <> S.CodePage) then
   Case S.CodePage of
    CP_ANSI, CP_OEM, {$IFDEF l3Requires_m0}CP_OEMLite,{$ENDIF} CP_RussianWin, CP_RussianDos:
    begin
    end;//CP_ANSI
    CP_Unicode :
     f_CodePage := CP_Unicode;
    else
    begin
     if (f_CodePage <> CP_Unicode) then
     begin
      if l3CharSetPresent(S.St, S.Len, cc_CodePagesDiff) then
      begin
       if (f_CodePage = CP_DefaultValue) then
        f_CodePage := S.CodePage
       else
        f_CodePage := CP_Unicode;
      end;//l3CharSetPresent(S.St, S.Len, cc_CodePagesDiff)
     end;//f_CodePage = CP_DefaultValue
    end;//else
   end;//Case S.CodePage
 end;//not S.Empty
 Result := false;
end;

procedure TevCodePageAnalyzer.DoStart;
  //override;
  {-}
begin
 inherited;
 f_CodePage := CP_DefaultValue;
end;

end.

