unit csAutoSpell;

interface

uses
  ddProgressObj,
  daTypes,
  csProcessTask,
  csAutoSpellTaskPrim
  ;

type
 TcsAutoSpellTask = class(TcsAutoSpellTaskPrim)
 protected
  function GetDescription: AnsiString; override;
 public
  constructor Create(aUserID: TdaUserID); override;
 end;//TcsAutoSpellTask

implementation

uses
  csTaskTypes, ddServerTask;

{
****************************** TcsAutoSpellTask *******************************
}
constructor TcsAutoSpellTask.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType := cs_ttAutoSpellCheck;
end;

function TcsAutoSpellTask.GetDescription: AnsiString;
begin
 Result := 'Автоматическая проверка орфографии';
end;

end.
