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
 Result:= AnsiReplaceStr(Result, 'г.', 'г. ');
 Result:= AnsiReplaceStr(Result, '  ', ' ');
{ TODO : Нужно загружать этот список из файла }
 Result:= AnsiReplaceText(Result, 'индивидуальный предприниматель', 'ИП');
 Result:= AnsiReplaceText(Result, 'индивидуальный частный предприниматель', 'ИЧП');
 Result:= AnsiReplaceText(Result, 'общество с ограниченной ответственностью', 'OOO');
 Result:= AnsiReplaceText(Result, 'закрытое акционерное общество', 'ЗАО');
 Result:= AnsiReplaceText(Result, 'открытое акционерное общество', 'OАO');
 Result:= AnsiReplaceText(Result, 'инспекция федеральной налоговой службы', 'ИФНС');
 Result:= AnsiReplaceText(Result, 'управление федеральной налоговой службы', 'УФНС');
 Result:= AnsiReplaceText(Result, 'россии', 'РФ');
 Result:= AnsiReplaceText(Result, 'округу', 'окр.');
 Result:= AnsiReplaceText(Result, 'округа', 'окр.');
end;

function NormalizeParticipant(const aParticipant: Il3CString): Il3CString;
begin
 Result := l3StringReplace(aParticipant, l3PCharLen('"'), l3PCharLen(''), []);
 Result:= l3StringReplace(Result, l3PCharLen('г.'), l3PCharLen('г. '), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('индивидуальный предприниматель'), l3PCharLen('ИП'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('индивидуальный частный предприниматель'), l3PCharLen('ИЧП'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('общество с ограниченной ответственностью'), l3PCharLen('OOO'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('закрытое акционерное общество'), l3PCharLen('ЗАО'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('открытое акционерное общество'), l3PCharLen('OАO'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('инспекция федеральной налоговой службы'),l3PCharLen('ИФНС'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('управление федеральной налоговой службы'),l3PCharLen('УФНС'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('россии'), l3PCharLen('РФ'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('округу'), l3PCharLen('окр.'), [rfReplaceAll, rfIgnoreCase]);
 Result:= l3StringReplace(Result,l3PCharLen('округа'), l3PCharLen('окр.'), [rfReplaceAll, rfIgnoreCase]);

 Result := l3Upper(l3Trim(l3DeleteDoubleSpace(Result)));
end;

end.
