program DbUpdate;

{ $Id: DbUpdate.dpr,v 1.22 2011/12/12 14:06:13 fireton Exp $ }
// $Log: DbUpdate.dpr,v $
// Revision 1.22  2011/12/12 14:06:13  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.21  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//
// Revision 1.20  2006/06/08 15:55:56  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.19.4.1  2006/06/08 09:26:58  fireton
// - перевод User ID на Longword
//
// Revision 1.19  2005/12/12 07:24:48  step
// убран update115 и его содержимое перенесено в update114
//
// Revision 1.18  2005/12/09 14:14:40  step
// добавлен очередной update
//
// Revision 1.17  2005/10/17 09:20:48  step
// обновление 114
//
// Revision 1.16  2005/09/09 16:58:11  step
// ƒобавление в таблицу GUDT новых полей.
// —брос ненужной DICTSOUR.
//
// Revision 1.15  2005/02/25 15:14:16  step
// ƒобавление новой таблицы DT#5E (ver. 112).
//
// Revision 1.14  2005/02/14 15:18:24  step
// ƒобавлены новые таблицы DT#I и LNK#I
//
// Revision 1.13  2005/02/14 13:36:09  step
// исправлени€ WORD->DWRD перенесены на более поздний срок, отсюда и переименование 111,112 -> 120,121
//
// Revision 1.12  2005/01/19 11:29:09  step
// доделаны UpgradeTo111 и UpgradeTo112 (оба касаютс€ изменени€ типа полей WORD --> DWRD)
//
// Revision 1.11  2004/12/02 15:55:23  step
// ѕриведение полей ID и DICT_ID в таблицах DT#* и LNK#* к типу DWRD (ver. 111)
//
// Revision 1.10  2004/10/25 16:12:41  step
// обновление хранилища (ver. 110)
//
// Revision 1.9  2004/10/22 14:37:15  step
// изменение структуры таблицы garant.DT#5 (ver. 109)
//
// Revision 1.8  2004/05/26 09:01:50  step
// изменение структуры таблицы main.FREE
//
// Revision 1.7  2004/05/07 17:37:47  step
// куча мелких исправлений
//
// Revision 1.6  2004/04/20 09:46:07  step
// изменение табл. FREE (ver. 106)
//
// Revision 1.5  2004/03/17 13:00:10  step
// ќчередной update (добавление пол€ PRIVATE к табл. DT#A)
//
// Revision 1.4  2004/03/09 18:40:03  step
// добавлен update є 104 (изменение полей табл. FILE)
//
// Revision 1.3  2004/03/04 18:03:10  step
// исправлен алгоритм сохранени€-восстановлени€
//
// Revision 1.2  2004/03/02 15:47:00  step
// куча мелких изменений
//
// Revision 1.1  2004/03/01 19:04:53  step
// «анесен в CVS
//

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  DT_DbReformer in 'DT_DbReformer.pas',
  DbUpgrade in 'DbUpgrade.pas',
  UpgradeTo101 in 'UpgradeTo101.pas',
  UpdateManager in 'UpdateManager.pas',
  UpgradeTo102 in 'UpgradeTo102.pas',
  UpgradeTo103 in 'UpgradeTo103.pas',
  UpgradeTo104 in 'UpgradeTo104.pas',
  UpgradeTo105 in 'UpgradeTo105.pas',
  UpgradeTo106 in 'UpgradeTo106.pas',
  UpgradeTo107 in 'UpgradeTo107.pas',
  DbInfo in 'DbInfo.pas',
  UpgradeTo108 in 'UpgradeTo108.pas',
  UpgradeTo109 in 'UpgradeTo109.pas',
  UpgradeTo110 in 'UpgradeTo110.pas',
  UpgradeTo111 in 'UpgradeTo111.pas',
  UpgradeTo112 in 'UpgradeTo112.pas',
  UpgradeTo113 in 'UpgradeTo113.pas',
  UpgradeTo114 in 'UpgradeTo114.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ќбновление Ѕƒ "јрхивариуса"';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
