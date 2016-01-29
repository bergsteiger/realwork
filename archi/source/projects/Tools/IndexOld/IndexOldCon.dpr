program IndexOldCon;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  
  l3Types,

  m4OldIndexTools
  ;

procedure FilesProcessed(aSender: TObject; aCurrentID: Long);
begin
 WriteLn('File processed: ', aCurrentID);
end;

procedure FilesProcessedEx(Sender     : TObject;
                           aCurrentID : Long;
                           aMaxID     : Long;
                           aTime      : TDateTime);
begin
 WriteLn('File processed: ', aCurrentID,
         ' time: ', TimeToStr(aTime),
         ' done ', aCurrentID * 100 div aMaxID, '%');
end;

var
 l_Elapsed : TDateTime;
begin
 if (ParamCount < 1) then
  WriteLn('Usage: IndexOldCon <BaseName>')
 else begin
  m4BuildIndexEx(ParamStr(1), nil, FilesProcessedEx, @l_Elapsed);
  WriteLn('Time: ', TimeToStr(l_Elapsed));
  ReadLn;
 end;
end.
