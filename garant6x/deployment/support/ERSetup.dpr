program ERSetup;

{$APPTYPE GUI}
{$R *.RES}

uses
 SysUtils
 , Windows
 ;

const
 c_Caption: string = '�������� �������� ���������';
var
 l_Message: string;
begin
 l_Message := Format('������� �������� ��������� ������� � �����������:'#10#10'%s', [GetCommandLine]);
 //
 MessageBox(HWND(0), PChar(l_Message), PChar(c_Caption), MB_ICONINFORMATION+MB_OK);
end.

