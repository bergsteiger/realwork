unit alcuStat;

{ ������ ��������� ���������� �� ��������� ����� }

interface

uses
 classes;

procedure CollectAutoClassInfo(aReport: TStrings);

implementation

Uses
 ddAppConfig, ddFileIterator,
 l3FileUtils,
 SysUtils;

procedure CollectAutoClassInfo(aReport: TStrings);
var
 l_Root: String;
 i: Integer;
 function lp_MakeFileInfo(aFileName: String): Boolean;

 begin
  Result:= True;
  aReport.Add(Format('%35s %12d %20s', [Copy(aFileName, Length(l_Root)+1, 255),
                      SizeOfFile(aFileName),
                      DateTimeToStr(FileDateTime(aFileName))]));
 end;

begin
 aReport.Add('���������� � ������� �����������������'#13#10);
 aReport.Add(Format('%35s %12s %20s', ['��� ������', '������', '���� ��������']));
 with ddAppConfiguration do
 begin
  l_Root:= ExtractFilePath(AsString['ac_Builder']);
  with TddFileIterator.Make(l_Root, '*.*', nil, True) do
  try
   for i:= 0 to Pred(FileList.Count) do
    lp_MakeFileInfo(FileList[i]);
  finally
   Free;
  end;
 end;
end;

end.
