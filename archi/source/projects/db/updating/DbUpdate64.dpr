program DbUpdate64;

{ $Id: DbUpdate64.dpr,v 1.5 2011/12/12 14:06:13 fireton Exp $}

// $Log: DbUpdate64.dpr,v $
// Revision 1.5  2011/12/12 14:06:13  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.4  2011/07/28 08:30:14  fireton
// - включаем version info отдельным ресурсом
//
// Revision 1.3  2011/07/27 10:44:48  fireton
// - version info в ночных сборках
//
// Revision 1.2  2007/06/19 09:47:25  fireton
// - Doc Update to 127
//
// Revision 1.1  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  DbUpgrade in 'DbUpgrade.pas',
  UpdateManager in 'UpdateManager.pas',
  UpgradeTo115 in 'UpgradeTo115.pas',
  UpgradeFamilyTo127 in 'UpgradeFamilyTo127.pas';

{$R *.res}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Initialize;
  Application.Title := 'Обновление БД "Архивариуса"';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
