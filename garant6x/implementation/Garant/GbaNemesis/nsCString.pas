unit nsCString;

// $Id: nsCString.pas,v 1.3 2007/03/01 11:52:40 lulin Exp $

// $Log: nsCString.pas,v $
// Revision 1.3  2007/03/01 11:52:40  lulin
// - выделены родные классы для реализации интерфейса константной строки.
//
// Revision 1.2  2007/02/28 16:17:01  lulin
// - корректнее обрабатываем юникодные строки.
//
// Revision 1.1  2007/02/02 14:31:35  lulin
// - добавлены функции преобразования к константной строке.
//

{$Include nsDefine.inc }

interface

uses
  l3Interfaces,
  l3Base
  ;

type
  TnsCString = class(Tl3String, Il3CString)
    public
    // public methods
      class function MakeI(const aStr: Tl3WString): Il3CString;
        {-}
  end;//TnsCString

  TnsCDelphiString = class(Tl3CDelphiString)
  end;//TnsCDelphiString

  TnsCWideString = class(Tl3CWideString)
  end;//TnsCWideString

implementation

uses
  l3String
  ;

// start class TnsCString

class function TnsCString.MakeI(const aStr: Tl3WString): Il3CString;
  {-}
var
 l_S : TnsCString;
begin
 l_S := Make(aStr);
 try
  Result := l_S;
 finally
  l3Free(l_S);
 end;//try..finally
end;

end.
