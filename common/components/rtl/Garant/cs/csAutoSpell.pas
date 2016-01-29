unit csAutoSpell;

interface

uses
  ddProgressObj,
  DT_Types,
  csProcessTask,
  csAutoSpellTaskPrim
  ;

type
 TcsAutoSpellTask = class(TcsAutoSpellTaskPrim)
 protected
  function GetDescription: AnsiString; override;
 public
  constructor Create(aUserID: TUserID); override;
 end;//TcsAutoSpellTask

implementation

uses
  csTaskTypes, ddServerTask;

{
****************************** TcsAutoSpellTask *******************************
}
constructor TcsAutoSpellTask.Create(aUserID: TUserID);
begin
 inherited;
 //TaskType := cs_ttAutoSpellCheck;
end;

function TcsAutoSpellTask.GetDescription: AnsiString;
begin
 Result := 'Автоматическая проверка орфографии';
end;

end.
