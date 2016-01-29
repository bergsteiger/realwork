program ArchiService;

uses
  SvcMgr,
  evdSchema,
  alcuService in 'alcuService.pas' {aluService};

{$R *.RES}

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}
{$IFNDEF Service}
Для сборки службы нужно определить директиву Service в ProjectDefine.inc
{$ENDIF}

begin
  Application.Initialize;
  Application.CreateForm(TaluService, aluService);
  Application.Run;
end.
