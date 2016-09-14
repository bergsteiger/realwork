unit uTypes;

interface

type
  Tl3TokenType = (
                  l3_ttBOF,        {- ������ �����}
                  l3_ttEOF,        {- ����� �����}
                  l3_ttEOL,        {- ����� ������}
                  l3_ttSingleChar, {- ��������� (�����������) ������}
                  l3_ttSymbol,     {- �������������}
                  l3_ttKeyWord,    {- �������� �����}
                  l3_ttString,     {- ������ (� ��������)}
                  l3_ttInteger,    {- ����� �����}
                  l3_ttFloat,      {- ������������ �����}
                  l3_ttComment,    {- �����������}
                  l3_ttDoubleQuotedString, // - ������ � ������� ��������
                  l3_ttUnknown
                 );

{type
 IParsable = interface
  procedure NextToken;
  property TokenString: String;
  property TokenType: Tl3TokenType;
 end;                    }

implementation

end.
