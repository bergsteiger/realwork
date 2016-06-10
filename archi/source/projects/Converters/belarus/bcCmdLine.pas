unit bcCmdLine;

{ $Id: bcCmdLine.pas,v 1.2 2016/04/12 12:44:21 fireton Exp $ }

interface
uses
 ddCmdLineUtils;

type
 TbcCmdLine = class(TddCmdLine)
  procedure Init; override;
 private
  f_Add: Boolean;
  f_Format: AnsiString;
  f_InFolder: AnsiString;
  f_OutFolder: AnsiString;
 public
  property Add: Boolean read f_Add;
  property Format: AnsiString read f_Format;
  property InFolder: AnsiString read f_InFolder;
  property OutFolder: AnsiString read f_OutFolder;
 end;

implementation

procedure TbcCmdLine.Init;
begin
 inherited;
 AddFolder('I', 'Входная папка (обязательный параметр)', '<путь>', f_InFolder);
 AddFolder('O', 'Папка для результата (обязательный параметр)', '<путь>', f_OutFolder);
 AddString('F', 'Формат выходных данных (N (по умолчанию) - NSRC, E - Everest)', '[N|E]', f_Format);
 //AddBool('A', 'Дополнять документы в папке результата (будут вылиты только новые документы)', '', f_Add);
end;

end.
