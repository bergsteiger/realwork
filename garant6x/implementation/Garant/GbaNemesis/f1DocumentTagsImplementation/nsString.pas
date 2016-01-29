unit nsString;

// $Id: nsString.pas,v 1.2 2012/09/14 13:55:37 kostitsin Exp $

// $Log: nsString.pas,v $
// Revision 1.2  2012/09/14 13:55:37  kostitsin
// [$394529442] - TnsNewString теперь реализует метод DoSetAsPCharLen
//
// Revision 1.1  2010/11/23 12:38:51  lulin
// {RequestLink:238945411}.
// - выделяем отдельный и наводим порядок.
//
// Revision 1.1  2010/08/17 12:04:58  lulin
// {RequestLink:232100720}.
// - рисуем скелет реализации.
//
// Revision 1.7  2009/07/23 08:14:57  lulin
// - вычищаем ненужное использование процессора операций.
//
// Revision 1.6  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.5.4.1  2007/11/20 11:39:01  oman
// Перепиливаем на новый адаптер
//
// Revision 1.5  2007/02/16 15:36:08  lulin
// - cleanup.
//
// Revision 1.4  2007/02/06 15:20:41  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.3  2007/02/02 14:31:35  lulin
// - добавлены функции преобразования к константной строке.
//
// Revision 1.2  2007/01/30 15:24:04  lulin
// - текст ноды - теперь более простого типа.
//
// Revision 1.1  2007/01/22 14:03:18  lulin
// - выделен класс-обертка над интерфейсом строки адаптера.
//

{$Include nsDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,

  IOUnit
  ;

type
  TnsNewString = class(Tl3CustomString, Il3CString)
    private
    // internal fields
      f_String : IString;
    protected
    // internal methods
      class function IsCacheable: Bool;
        override;
        {-}
      function  GetAsPCharLen: Tl3PCharLenPrim;
        override;
        {-}
      procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aString: IString);
        reintroduce;
        {-}
      procedure Insert(const aSt       : Tl3PCharLenPrim;
                       aPos            : Long;
                       aRepeat         : Long = 1);
        override;
        {* - вставляет строку aSt в позицию aPos, aRepeat раз. }
  end;//TnsNewString

  TnsNewConstString = class(TnsNewString)
    public
    // public methods
      class function MakeI(const aStr: IString): Il3CString;
        {-}
  end;//TnsNewConstString

implementation

uses
  l3String,

  nsTypes
  ;

// start class TnsNewString

constructor TnsNewString.Create(const aString: IString);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_String := aString;
end;

procedure TnsNewString.Insert(const aSt       : Tl3PCharLenPrim;
                              aPos            : Long;
                              aRepeat         : Long = 1);
  //override;
  {* - вставляет строку aSt в позицию aPos, aRepeat раз. }
begin
 Assert(false);
end;

procedure TnsNewString.Cleanup;
  //override;
  {-}
begin
 f_String := nil;
 inherited;
end;

class function TnsNewString.IsCacheable: Bool;
  //override;
  {-}
begin
 Result := true;
end;

function TnsNewString.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 Result:= nsWStr(f_String);
end;

procedure TnsNewString.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 f_String := nsIStr(Value);
end;

class function TnsNewConstString.MakeI(const aStr: IString): Il3CString;
  {-}
var
 l_S : TnsNewConstString;
begin
 l_S := Create(aStr);
 try
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

end.
