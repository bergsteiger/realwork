unit ddParticipantsUtils;

interface

uses
 l3Interfaces,
 dt_Types,

 SysUtils;

 function StrToParticipantType(const aParticipant: AnsiString): TlcParticipantType; overload;
 function StrToParticipantType(const aParticipant: Il3CString): TlcParticipantType; overload;
 function ParticipantTypeToStr(aType: TlcParticipantType): AnsiString;

function SimilarParticipant(const aParticipant1, aParticipant2: AnsiString): Boolean;

function NormalizeParticipant(const aParticipant: AnsiString): AnsiString; overload;
function NormalizeParticipant(const aParticipant: Il3CString): Il3CString; overload;

implementation

uses
 ddParticipantsConst, StrUtils, l3FileUtils, l3String;

 function StrToParticipantType(const aParticipant: AnsiString): TlcParticipantType;
 var
  i: TlcParticipantType;
  item: Integer;
 begin
  Result:= ptThirdSide;
  for i:= Low(TlcParticipantType) to High(TlcParticipantType) do
   if AnsiSameText(aParticipant, cParticipants[i]) then
   begin
    Result:= i;
    Break;
   end;
 end;

 function StrToParticipantType(const aParticipant: Il3CString): TlcParticipantType;
 var
  i: TlcParticipantType;
 begin
  Result:= ptThirdSide;
  for i:= Low(TlcParticipantType) to High(TlcParticipantType) do
   if l3Same(aParticipant, cParticipants[i], True) then
   begin
    Result:= i;
    Break;
   end;
 end;

 function ParticipantTypeToStr(aType: TlcParticipantType): AnsiString;
 begin
  Result:= cParticipants[aType]
 end;

function SimilarParticipant(const aParticipant1, aParticipant2: AnsiString): Boolean;
begin
 Result := AnsiSameText(NormalizeParticipant(aParticipant1), Normalizeparticipant(aParticipant2));
end;

function NormalizeParticipant(const aParticipant: AnsiString): AnsiString;
begin
 Result:= aParticipant;
 Result:= AnsiReplaceStr(Result, '"', '');
 Result:= AnsiReplaceStr(Result, '�.', '�. ');
 Result:= AnsiReplaceStr(Result, '  ', ' ');
{ TODO : ����� ��������� ���� ������ �� ����� }
 Result:= AnsiReplaceText(Result, '�������������� ���������������', '��');
 Result:= AnsiReplaceText(Result, '�������������� ������� ���������������', '���');
 Result:= AnsiReplaceText(Result, '�������� � ������������ ����������������', 'OOO');
 Result:= AnsiReplaceText(Result, '�������� ����������� ��������', '���');
 Result:= AnsiReplaceText(Result, '�������� ����������� ��������', 'O�O');
 Result:= AnsiReplaceText(Result, '��������� ����������� ��������� ������', '����');
 Result:= AnsiReplaceText(Result, '���������� ����������� ��������� ������', '����');
 Result:= AnsiReplaceText(Result, '������', '��');
 Result:= AnsiReplaceText(Result, '������', '���.');
 Result:= AnsiReplaceText(Result, '������', '���.');
end;

function NormalizeParticipant(const aParticipant: Il3CString): Il3CString;
begin
 Result := l3StringReplace(aParticipant, l3PCharLen('"'), l3PCharLen(''), []);
 Result:= l3StringReplace(Result, l3PCharLen('�.'), l3PCharLen('�. '), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('�������������� ���������������'), l3PCharLen('��'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('�������������� ������� ���������������'), l3PCharLen('���'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('�������� � ������������ ����������������'), l3PCharLen('OOO'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('�������� ����������� ��������'), l3PCharLen('���'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('�������� ����������� ��������'), l3PCharLen('O�O'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('��������� ����������� ��������� ������'),l3PCharLen('����'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('���������� ����������� ��������� ������'),l3PCharLen('����'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('������'), l3PCharLen('��'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('������'), l3PCharLen('���.'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('������'), l3PCharLen('���.'), [rfReplaceAll, rfIgnoreCase]);

 Result := l3Upper(l3Trim(l3DeleteDoubleSpace(Result)));
end;

end.
