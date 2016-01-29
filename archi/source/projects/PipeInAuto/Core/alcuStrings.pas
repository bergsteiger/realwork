unit alcuStrings;

{ ������ ��������� �������� }

{ $Id: alcuStrings.pas,v 1.9 2015/10/01 12:56:31 lukyanets Exp $ }

// $Log: alcuStrings.pas,v $
// Revision 1.9  2015/10/01 12:56:31  lukyanets
// ��������� ����
//
// Revision 1.8  2014/12/26 12:58:43  lukyanets
// ������������ �� ������������
//
// Revision 1.7  2014/12/23 08:42:47  fireton
// - ��������� ������� ����������� ���� �� ���� ������
//
// Revision 1.6  2014/09/26 07:24:50  lukyanets
// {RequestLink:565502566}
//
// Revision 1.5  2014/09/18 10:05:59  lukyanets
// {RequestLink:565263723}
//
// Revision 1.4  2014/09/04 11:52:09  lukyanets
// ������ ������ ������� �����
//
// Revision 1.3  2014/08/29 10:07:40  lukyanets
// Cleanup
//
// Revision 1.2  2014/08/19 12:20:12  lukyanets
// ������������� ��������
//
// Revision 1.1  2014/07/28 15:18:18  lukyanets
// {Requestlink:557844282}. ���������� ���������� ProjectDefine.inc
//
// Revision 1.12  2013/11/07 06:58:40  fireton
// - ������� ���������� � ������� ��������������� ������
//
// Revision 1.11  2012/04/12 10:33:44  narry
// ����������� ��������
//
// Revision 1.10  2012/03/12 13:52:39  narry
// ���������� ��������� � ������ ���������� ����� �� �����
// ������������� ���������
//
// Revision 1.9  2012/03/11 07:03:31  narry
// ����������
//
// Revision 1.8  2011/10/13 09:22:16  narry
// ������������ ���������
//
// Revision 1.7  2011/05/31 14:07:41  narry
// ������� ������
//
// Revision 1.6  2010/07/20 14:21:25  narry
// �214599203
//
// Revision 1.5  2010/02/25 06:38:10  narry
// - �������� ����������� �������� �� �����
// - ���������� ��������� ������� ������� �� ����� ������������� ����������
//
// Revision 1.4  2009/05/27 12:29:20  narry
// - ����������
//
// Revision 1.3  2009/01/28 15:34:11  narry
// - ����������
//
// Revision 1.2  2008/03/13 14:01:03  narry
// - ���������� ������ ��������
//
// Revision 1.1  2008/03/04 11:34:27  narry
// - ��������� ��������� �������� � ��������� ������
//


interface

resourcestring
// START resource string wizard section
  SalcuRequestService_Anno = 'anno_';
  SalcuRequestService_Annotation = 'Annotation';

  SalcuRequestService_AnnoFolder = 'AnnoFolder';
  SalcuRequestService_AnnoDocFolder = 'AnnoDocFolder';
  SalcuRequestService_AnnoDocListFile = 'AnnoDocListFile';
  SalcuRequestService_AnnoInfoList = 'AnnoInfoList';
  SalcuRequestService_HNn = 'h:nn';
  SalcuRequestService_Nsr = '.nsr';

  SalcuRequestService_BaseIni = 'base.ini';
  SalcuRequestService_Eksportannotaciy = '������� ���������';
  SalcuRequestService_ExportDate = 'ExportDate';
  SalcuRequestService_ob_emdokumentov = '  - ����� ���������� %s';
  SalcuRequestService_Query = '.query';
  SalcuRequestService_Speshuuvedomit_toannotaciikolies = '����� ���������, ��� ��������� ����������� %d ���� ������� �������������� � %s';
  SalcuRequestService_Spriskorbiemsoobtshayutonebyloek = '� ����������� �������, ��� �� ���� �������������� �� ����� ���������.';
  SalcuRequestService_SS = 'SS';
  SalcuRequestService_YyyyMmDd = 'yyyy-mm-dd';
  SalcuRequestService_Zdravstvuytedorogiepol_zovateli = '������������, ������� ������������!'#13#10;

// END resource string wizard section

  SalcuRequestService_ExportDone = '�������������� %s �� %s';
// START resource string wizard section
  rsCount = 'Count';

  rsDdMmmYyyyHhNnSs = 'dd mmm yyyy, hh:nn:ss';
  rsDublirovaniezadaniya = '������������ �������';
  rsEksportpolzovatelya = '������� ������������ %s';
  rsEksportpolzovatelyazavershen = '������� ������������ %s ��������';
  rsEstoshibki = '���� ������';
  rsExport = 'Export\';
  rsfayldokumentov = '  - ���� ���������� "%s"';
  rsFaylysohranenyvpapke = '����� ��������� � ����� %s';
  rsformat = '  - ������ "%s"';
  rsImportCommentsLog = 'Import comments.log';
  rsImportirovaniefaylovKW = '�������������� ������ KW';
  rsImportKwfaylazavershensoshibkoy = '������ kw-����� �������� � �������';
  rsImportKwfaylazavershenuspeshno = '������ kw-����� �������� �������';
  rsImportName = 'ImportName';
  rsImportzavershen = '������ ��������. ';
  rsImportzavershilsyauspeshno = '������ ���������� �������';
  rsInformaciyaobokonaniieksportadop = '���������� �� ��������� �������� �� ������������ �� �����';
  rskazhdyydokumentotdelno = '  - ������ �������� ��������';
  rsklevyeslovav = '  - �������� ����� � "%s"';
  rsKsozhaleniVashezadanienaavtoklas = '� ��������� ���� ������� �� ����������������� ��������� ����������';
  rsLastImport = 'LastImport';

  rsNaaloobrabotkioeredizadaniy = '������ ��������� ������� �������';
  rsNiodindokumentnebylavtoklassific = '�� ���� �������� �� ��� �������������������.'#13#10;
  rsOeredzadaniyobrabotana = '������� ������� ����������';
  rsOshibkaimporta = '������ ������� (%s)';
  rsOshibkaotpravkipismapolzovatelID = '������ �������� ������ ������������ %s (ID %d)';
  rsOshibkaotpravkisoobtsheniyapolzo = '������ �������� ��������� ������������ %s';
  rsOshibkasozdaniyatrubyeksporta = '������ �������� ����� ��������';
  
  rsAutoclassifyTaskCreateError = '������ �������� ������� �� �����������������';
  rsOtpravkasoobtsheniyaoboshibkedli = '�������� ��������� �� ������ ������ %d ����';
  rspapka = '  - ����� "%s"';
  rsPismootpravleno = '������ ����������';
  rsPolzovatel = '----- ������������ %s (%s)'#13#10;
  rsPosylaempismodlinoybayt = '�������� ������ ������ %d ����';
  rsPosylshtatnogosoobtsheniya = '����� �������� ��������� ';
  rsProverkaunikalnostikataloga = '�������� ������������ ��������';
  rsrazmerasti = '  - ������ ����� %s';
  rsRezultatyavtoklassifikacii = '���������� ����������������� - ';
  rsSborkasoobtsheniyadokumentotsuts = '������ ��������� - �������� %d ����������� � ����';
  rsSborkavyborkidokumentov = '������ ������� ����������';

  rsSpisokdokumentovproshedshihavtok = '������ ����������, ��������� �����������������, ��������� � ����������'#13#10;
  rsUserIni = 'user.ini';
  rsVashezadanienaavtoklassifikacivy = '���� ������� �� ����������������� �����������';
  rsVashezadanienaeksportvypolnyaets = '���� ������� (%s\%s) �� ������� �����������';
  rsVashezadanienahoditsyavoeredipod = '���� ������� ��������� � ������� ��� ������� %d';
  rsVashezadanienaimportvypolnyaetsy = '���� ������� �� ������ �����������';
  rsVovremyaeksportaproizoshlaoshibk = '�� ����� �������� ��������� ������';
  rsVozmozhnonekotoryedokumentysoder = '�������� ��������� ��������� �������� ������. ';
  rsYyyyMmDdHhNnSsZzz = 'yyyy-mm-dd hh-nn-ss-zzz';
  rsZadanienaavtoklassifikacivypolne = '������� �� ����������������� ���������';
  rsZadanienaavtoklassifikacivypolny = '������� �� ����������������� �����������';
  rszadaniyostatsyanabudutshee = '%d ������� �������� �� �������';
  rsZapislogakommentariev = '������ ���� ������������';

// END resource string wizard section

 rsSavedTaskList = 'SavedTaskList';
 rsDelayedTaskList = 'DelayedTaskList';
 rsExportQueryDeleted = '���� ������� �� ������� (%s � %s � %s) '#10'������� �� �������';
 rsImportQueryDeleted = '���� ������� �� ������ ������� �� �������';
 rsAlreadyAdded = '���� ������� ��� ��������� � �������';
 rsErrorQuery   = '���������� � ����� ������� ��������';
 rsExportQuery  = '������ ������ �� ������� �� %s (%s)';
 rsImportQuery  = '������ �� ������ �� %s';
 rsQueryAdded   = '���� ������� ��������� � ������� ��� ������� %d';
 srErrorAtExport = '�� ����� ���������� ������ ������� �� ������� ��������� ������';

 rsQueryFound = '������� ������� ������������ %s';
 rsQueryListEmpty = '  - ������� �����';
 rsProcessNQueries = '  - ���� ��������� %d ��������';
 rsAddedByIndex = '���� ������� ��������� � ������� ��� ������� %d';
 rsBadImportFound = '������� �������, ���������� �������� ������� � ����. ��������� � �������?';

 sStartStream = '<?xml version="1.0" encoding="windows-1251"?>'#13#10'<list>'#13#10;
 sFinishStream = '</list>'#13#10;


  SAutoPipeServerForm_BackupRoot = 'BackupRoot';
  SAutoPipeServerForm_Dannayaoperaciyaprivedetkotklyue = '������ �������� �������� � ���������� ���� �������������. ����������?';
  SAutoPipeServerForm_imyakomp_yuteraopredelit_neudalo = '��� ���������� ���������� �� �������';
  SAutoPipeServerForm_ishodnyedannyedlyapostroeniyaDel = '�������� ������ ��� ���������� "������" ���� �� ������';
  SAutoPipeServerForm_IsLocalBase = 'IsLocalBase';
  SAutoPipeServerForm_LocalBasePath = 'LocalBasePath';
  SAutoPipeServerForm_Nakomp_yutererabotaet = '�� ���������� "%s" �������� %s';
  SAutoPipeServerForm_Podtverzhdenie = '�������������';
  SAutoPipeServerForm_Poiskpol_zovatelyapoimenikomp_yu = '����� ������������ �� ����� ����������';
  SAutoPipeServerForm_Scheduler = 'Scheduler';
  SAutoPipeServerForm_Ukazhiteimyakomp_yutera = '������� ��� ����������';
  SAutoPipeServerForm_UNCBasePath = 'UNCBasePath';
  SAutoPipeServerForm_VsegotovodlyapostroeniyaDel_ty = '��� ������ ��� ���������� "������"';
  SAutoPipeServerForm_ConfirmExit = '�� �������, ��� ������ ��������� ������?';
  SAutoPipeServerForm_YyyyMmDd = 'yyyy-mm-dd';

  rsOshibka = '������!';
  rs = ') ';
  rs1 = '?? ??? ???? ??:?? <- %s';
  rsAvtoklassifikaciya = '����������������� (';
  rsDannayaoperaciyaotklitVSEHpolzov = '������ �������� �������� ������������ ��� ��������������� ��������������. ����������?';
  rsDdMmmYyyyHhNn = 'dd mmm yyyy hh:nn';
  rsDdMmYyHhNn = 'dd/mm/yy hh:nn';
  rsEksport = '������� (';
  rseksport1 = '�������';
  rsFamilyConst = 'FamilyConst';
  rsFamilyPath = 'FamilyPath';
  rsFormirovaniesoobtsheniya = '������������ ���������...';
  rsIdetimport = '���� ������...';
  rsImport = '������ (';
  rsimport1 = '������';
  rsIndeksaciyanazvaniydokumentov = '���������� �������� ����������...';
  rsInicializaciya = '�������������';
  rsInkognito = '���������';
  rsiz = '%d �� %d';
  rsklassifikaciya = '�������������';
  rsnaydeno = '������� %d';
  rsOered = '�������: %d';
  rsOibkainicializaciibazydannyhPopr = '������ ������������� ���� ������. ��������� ���� � ���� ������ � ���������� ��� ���.';
  rsOtlozheno = '��������';
  rsOzhidaniezadaniy = '�������� �������';
  rsPodgotovkaavtoklassifikacii = '���������� �����������������...';
  rsPodgotovkaeksporta = '���������� ��������...';
  rsPoiskoeredi = '����� �������...';
  rsPolzovateli = '������������ (%d)';
  rsPostoyannayabaza = '���������� ���� (%s)';
  rsProverkatekstovoybazy = '�������� ��������� ����...';
  rsSessiyaostanovlenaDDMMYYYYvHhNn = '������ ����������� DD.MM.YYYY � hh:nn';
  rsSessiyazaputshenaDdMmYyyyvHhNn = '������ �������� dd.mm.yyyy � hh:nn';
  rsSozdaniekopiibazy = '�������� ����� ����...';
  rsSozdaniepolnoykopiibazy = '�������� ������ ����� ����...';
  rsumenyadlyavasplohayanovostvperem = '� ���� ��� ��� ������ ������� - � ���������� ����� ���������� �����-�����.';
  rsSaveUnfinishedTaskList = '� ������� ���� �������������� �������. �� ������ �� ���������?';
  rsVosstanovleniebazy = '�������������� ����...';
  rsVosstanovleniepolnoybazy = '�������������� ������ ����...';
  rsVovremyapodgotovkiDeltyproizolao = '�� ����� ���������� "������" ��������� ������';
  rsVremennayabaza = '��������� ���� (%s)';
  rsZadaniya = '������� (%d/%d)';
  rsZagruzkaDelty = '�������� "������"...';
  rsZagruzkafaylaklevyhslov = '�������� ����� �������� ����...';
  rsZagruzkaNSRCfaylov = '�������� NSRC-������...';
  rsZamorozheno = '����������';

// END resource string wizard section

  SDeleted = '�������';
  SRun = '�����������';
  SDone = '���������';
  SWaiting = '��������';
  SalcuAutoPipeServer_AddDeltaCreator = 'AddDeltaCreator';
  SalcuAutoPipeServer_ArchiLogFileName = 'ArchiLogFileName';
  SalcuAutoPipeServer_Arhivsklyuaminesozdan = '����� � ������� �� ������';
  SalcuAutoPipeServer_Arhivsklyuamisozdan = '����� � ������� ������';
  SalcuAutoPipeServer_BackupCount = 'BackupCount';
  SalcuAutoPipeServer_BackupRoot = 'BackupRoot';
  SalcuAutoPipeServer_BadImportDir = 'BadImportDir';
  SalcuAutoPipeServer_BaseDocPath = 'BaseDocPath';
  SalcuAutoPipeServer_BazaArhivariusaotkrytadlyaraboty = '���� "�����������" ������� ��� ������.';
  SalcuAutoPipeServer_Bazazakrytanavremyavypolneniyapr = '���� ������� �� ����� ���������� ���������������� �����.';
  SalcuAutoPipeServer_BS = ' /B /S > ';
  SalcuAutoPipeServer_Bserv001 = 'bserv001';
  SalcuAutoPipeServer_Bserv001Ext = 'bserv001.ext';
  SalcuAutoPipeServer_CheckLogFile = 'CheckLogFile';
  SalcuAutoPipeServer_Cmd = 'cmd';
  SalcuAutoPipeServer_ComKw = 'com.kw';
  SalcuAutoPipeServer_ComRar = 'com.rar';
  SalcuAutoPipeServer_DateOfBaseTxt = 'Date Of Base.txt';
  SalcuAutoPipeServer_Dd17076352 = 'dd17076352';
  SalcuAutoPipeServer_DdNnnnnnnnnnnnYyyy = 'dd nnnnnnnnnnnn yyyy';
  SalcuAutoPipeServer_DeltaCreator = 'DeltaCreator';
  SalcuAutoPipeServer_Dir = 'dir ';
  SalcuAutoPipeServer_Dobropozhalovat_vArhivarius = '����� ���������� � "����������"';
  SalcuAutoPipeServer_DoDictEntryIndex = 'DoDictEntryIndex';
  SalcuAutoPipeServer_DoEverydayUpdate = 'DoEverydayUpdate';
  SalcuAutoPipeServer_DoEveryweekUpdate = 'DoEveryweekUpdate';
  SalcuAutoPipeServer_DoFullBackup = 'DoFullBackup';
  SalcuAutoPipeServer_DoHeaderIndex = 'DoHeaderIndex';
  SalcuAutoPipeServer_DoHolidayBase = 'DoHolidayBase';
  SalcuAutoPipeServer_DoImportKW = 'DoImportKW';
  SalcuAutoPipeServer_DoMakeDelta = 'DoMakeDelta';
  SalcuAutoPipeServer_doprevysheniepredelaostalos_Mbay = '%s, �� ���������� ������� �������� %s';
  SalcuAutoPipeServer_DoUpdateBase = 'DoUpdateBase';
  SalcuAutoPipeServer_DoUpdateIndex = 'DoUpdateIndex';
  SalcuAutoPipeServer_DoUpdateText = 'DoUpdateText';
  SalcuAutoPipeServer_DoUpdateTextIndex = 'DoUpdateTextIndex';
  SalcuAutoPipeServer_Email = 'email';
  SalcuAutoPipeServer_ErrorsYYYYMMDDLog = '"Errors - "YYYY-MM-DD."log"';
  SalcuAutoPipeServer_EverydayBackupCount = 'EverydayBackupCount';
  SalcuAutoPipeServer_Export = 'Export';
  SalcuAutoPipeServer_Ezhednevnayaproceduraobnovleniya = '���������� ��������� ���������� ���� ���������';
  SalcuAutoPipeServer_Ezhenedel_noeobnovleniezavershen = '������������ ���������� ���������';
  SalcuAutoPipeServer_FamilyBackup = 'FamilyBackup';
  SalcuAutoPipeServer_FamilyConst = 'FamilyConst';
  SalcuAutoPipeServer_FamilyPath = 'FamilyPath';
  SalcuAutoPipeServer_Fayl = '���� ';
  SalcuAutoPipeServer_Fayletapovotsutstvuet = '���� ������ �����������';
  SalcuAutoPipeServer_Faylklyuevyhslov = '���� �������� ����';
  SalcuAutoPipeServer_Faylklyuevyhslovneimportirovan = '���� �������� ���� �� ������������';
  SalcuAutoPipeServer_Faylklyuevyhslovneimportirovanin = '���� �������� ���� �� ������������ � �� ��������� � �����.';
  SalcuAutoPipeServer_Faylklyuevyhslovnenayden = '���� �������� ���� (%s) �� ������';
  SalcuAutoPipeServer_Faylklyuevyhslovskopirovanuspesh = '���� �������� ���� ���������� �������';
  SalcuAutoPipeServer_Faylklyuevyhslovuspeshnoimportir = '���� �������� ���� ������� ������������.';
  SalcuAutoPipeServer_FaylneotpravlenvTver_ = '���� �� ��������� � �����.';
  SalcuAutoPipeServer_FaylotpravlenvTver_ = '���� ��������� � �����.';
  SalcuAutoPipeServer_FreeSpaceLimit = 'FreeSpaceLimit';
  SalcuAutoPipeServer_FullBackup = 'FullBackup';
  SalcuAutoPipeServer_FullBackupAtDays = 'FullBackupAtDays';
  SalcuAutoPipeServer_Garant = '\garant\*.*';
  SalcuAutoPipeServer_Garant1 = '\garant\';
  SalcuAutoPipeServer_Garant2 = '\garant';
  SalcuAutoPipeServer_GarDocDir = 'GarDocDir';
  SalcuAutoPipeServer_HolidayFolder = 'HolidayFolder';
  SalcuAutoPipeServer_Idx = '*.idx';
  SalcuAutoPipeServer_ImageBaseListCmd = 'ImageBaseList.cmd';
  SalcuAutoPipeServer_ImageBaseListTxt = 'ImageBaseList.txt';
  SalcuAutoPipeServer_ImageStoragePath = 'ImageStoragePath';
  SalcuAutoPipeServer_importekvivalentnyhklassov = '������ ������������� �������';
  SalcuAutoPipeServer_importekvivalentnyhklassovzavers = '������ ������������� ������� ��������';
  SalcuAutoPipeServer_importezhenedel_noyraznicydokume = '������ ������������ ������� ����������';
  SalcuAutoPipeServer_importNSRCfaylovifaylaklyuevyhsl = '������ NSRC-������ � ����� �������� ���� ��������';
  SalcuAutoPipeServer_IP = '%s (IP:%s)';
  SalcuAutoPipeServer_IsLocalBase = 'IsLocalBase';
  SalcuAutoPipeServer_itogkopirovaniyaKodoshibki = '���� ����������� : ��� ������ %d (%s)';
  SalcuAutoPipeServer_izostalos_ = '%s �� %s (�������� %s)';
  SalcuAutoPipeServer_Kompilyaciyaslovareyzavershena = '���������� �������� ���������';
  SalcuAutoPipeServer_Kopirovaniebazyzaversheno = '����������� ���� ���������';
  SalcuAutoPipeServer_Kopirovaniefaylaetapov = '����������� ����� ������';
  SalcuAutoPipeServer_Kopirovaniefaylaetapovzaversheno = '����������� ����� ������ ���������';
  SalcuAutoPipeServer_KopirovaniefaylaklyuevyhslovsFTP = '����������� ����� �������� ���� � FTP';
  SalcuAutoPipeServer_Kopiyafayla = '����� ����� ';
  SalcuAutoPipeServer_Kopiyaotliaetsyaotoriginala = '����� (%s) ���������� �� ��������� (%s):';
  SalcuAutoPipeServer_KWfaylskopirovanneverno = 'KW-���� ���������� �������';
  SalcuAutoPipeServer_KWFileName = 'KWFileName';
  SalcuAutoPipeServer_LocalBasePath = 'LocalBasePath';
  SalcuAutoPipeServer_Logfaylraznicydokumentovetsheneg = '���-���� ������� ���������� ��� �� �����. ����������?';
  SalcuAutoPipeServer_Logfaylraznicydokumentovetsheneg1 = '���-���� ������� ���������� ��� �� �����. ������ ������������ ������� ������������� �� 30 �����';
  SalcuAutoPipeServer_MaxArchiLogFileSize = 'MaxArchiLogFileSize';
  SalcuAutoPipeServer_MaxExportAge = 'MaxExportAge';
  SalcuAutoPipeServer_MertvyedushineobnaruzhenyVypolni = '������� ���� �� ����������. ��������� ������ "������"?';
  SalcuAutoPipeServer_NaaloimportaNSRCfaylovifaylaklyu = '������ ������� NSRC-������ � ����� �������� ����';
  SalcuAutoPipeServer_Naalokompilyaciislovarey = '������ ���������� ��������';
  SalcuAutoPipeServer_Naalokopirovaniyabazy = '������ ����������� ����';
  SalcuAutoPipeServer_Naaloobnovleniyabazy = '������ ���������� ����';
  SalcuAutoPipeServer_Naaloobnovleniyatekstovogoindeks = '������ ���������� ���������� �������';
  SalcuAutoPipeServer_Naaloobnovleniyatekstovoyasti = '������ ���������� ��������� �����';
  SalcuAutoPipeServer_Naalopolnogokopirovaniyabazy = '������ ������� ����������� ����';
  SalcuAutoPipeServer_Naalovosstanovleniyabazy = '������ �������������� ����';
  SalcuAutoPipeServer_Naalovypolneniyaprofilaktieskogo = '������ ���������� ����������������� ����������';
  SalcuAutoPipeServer_NarryOitPuGarant = '.narry.oit.pu.garant';
  SalcuAutoPipeServer_Naydenyzadaniyaostavshiesyaspros = '������� �������, ���������� � ������� ������. ��������� �� ���������?';
  SalcuAutoPipeServer_Neudalos_opredelit_svobodnoemest = '�� ������� ���������� ��������� ����� �� ����� � �����. ';
  SalcuAutoPipeServer_Neudalos_skopirovat_faylklyuevyh = '�� ������� ����������� ���� �������� ����';
  SalcuAutoPipeServer_Nevozmozhnoskopirovat_faylklyuev = '���������� ����������� ���� �������� ���� � FTP - ';
  SalcuAutoPipeServer_Nevsepol_zovatelipokinuliArhivar = '�� ��� ������������ �������� "����������"';
  SalcuAutoPipeServer_NotifyAddress = 'NotifyAddress';
  SalcuAutoPipeServer_Obnovleniebazydannyhnevypoleneno = '���������� ���� ������ �� ���������';
  SalcuAutoPipeServer_Obnovleniebazyzaversheno = '���������� ���� ���������';
  SalcuAutoPipeServer_Obnovlenieindeksazagolovkovnevyp = '���������� ������� ���������� �� ���������';
  SalcuAutoPipeServer_Obnovlenietablic = '���������� ������';
  SalcuAutoPipeServer_Obnovlenietabliczakonilos_soshib = '���������� ������ ����������� � �������';
  SalcuAutoPipeServer_Obnovlenietabliczaversheno = '���������� ������ ���������';
  SalcuAutoPipeServer_Obnovlenietekstovogoindeksanevyp = '���������� ���������� ������� �� ���������';
  SalcuAutoPipeServer_Obnovlenietekstovogoindeksazaver = '���������� ���������� ������� ���������';
  SalcuAutoPipeServer_Obnovlenietekstovoyastizavershen = '���������� ��������� ����� ���������';
  SalcuAutoPipeServer_Oerednayaversiyafaylaklyuevyhslo = '��������� ������ ����� �������� ����';
  SalcuAutoPipeServer_PurgingExportsFolder = '������� ����� ��������';
  SalcuAutoPipeServer_PurgingExportsFolderComplete = '������� ����� �������� ���������';
  SalcuAutoPipeServer_Oshibkaimportaekvivalentnyhklass = '������ ������� ������������� ������� %s';
  SalcuAutoPipeServer_Oshibkaimportaetalonnoytablicyva = '������ ������� ��������� ������� ��������';
  SalcuAutoPipeServer_OshibkaimportaNSRCfaylov = '������ ������� NSRC-������';
  SalcuAutoPipeServer_Oshibkakompilyaciislovarey = '������ ���������� ��������';
  SalcuAutoPipeServer_Oshibkakopirovaniya = '������ ����������� - ';
  SalcuAutoPipeServer_Oshibkakopirovaniyabazy = '������ ����������� ����';
  SalcuAutoPipeServer_Oshibkaobnovleniyabazy = '������ ���������� ����';
  SalcuAutoPipeServer_Oshibkapostroeniyaindeksaslovarn = '������ ���������� ������� ��������� ������';
  SalcuAutoPipeServer_Oshibkapostroeniyaindeksazagolov = '������ ���������� ������� ����������';
  SalcuAutoPipeServer_OshibkasozdaniyaBazyvyhodnogodny = '������ �������� "���� ��������� ���"';
  SalcuAutoPipeServer_Oshibkasozdaniyafaylasspiskomgra = '������ �������� ����� � ������� ����������� �������';
  SalcuAutoPipeServer_Oshibkasozdaniyapolnoykopiibazy = '������ �������� ������ ����� ���� %s';
  SalcuAutoPipeServer_Oshibkaudaleniyafayla = '������ �������� ����� ';
  SalcuAutoPipeServer_Oshibkavosstanovleniyabazy = '������ �������������� ����';
  SalcuAutoPipeServer_Oshibkazapisilogaoshibokimporta = '������ ������ ���� ������ �������';
  SalcuAutoPipeServer_Ostalos_ = '�������� %s';
  SalcuAutoPipeServer_ostanovkamehanizmadostupakbazeda = '��������� ��������� ������� � ���� ������';
  SalcuAutoPipeServer_Otklyueniepol_zovateley = '���������� %d �������������:';
  SalcuAutoPipeServer_Otklyueniepol_zovatelya = '���������� ������������:';
  SalcuAutoPipeServer_Otliaetsyaotoriginala = ' ���������� �� ���������';
  SalcuAutoPipeServer_otsutstvuet = ' �����������';
  SalcuAutoPipeServer_Pereklyuenienapostoyannuyubazu = '������������ �� ���������� ����';
  SalcuAutoPipeServer_Pereklyuenienavremennuyubazu = '������������ �� ��������� ����';
  SalcuAutoPipeServer_PictureFolder = 'PictureFolder';
  SalcuAutoPipeServer_Polnaya = '������ ';
  SalcuAutoPipeServer_Postroenieindeksaslovarnyhstatey = '���������� ������� ��������� ������';
  SalcuAutoPipeServer_Postroenieindeksaslovarnyhstatey1 = '���������� ������� ��������� ������ ���������';
  SalcuAutoPipeServer_Postroenieindeksazagolovkov = '���������� ������� ����������';
  SalcuAutoPipeServer_Postroenieindeksazagolovkovzaver = '���������� ������� ���������� ���������';
  SalcuAutoPipeServer_PotomVysmozheteotmenit_vosstanov = '����� �� ������� �������� ��������������.';
  SalcuAutoPipeServer_prevysheniepredelanaMbayt = '%s - ���������� ������� �� %s';
  SalcuAutoPipeServer_AbortProcessing = '�������������� ���������� ���� ��������';
  SalcuAutoPipeServer_StopProcessing = '��������� ��������� ����� ��������';
  SalcuAutoPipeServer_PriorityFileName = 'PriorityFileName';
  SalcuAutoPipeServer_Profilaktieskoeobnovleniezaversh = '���������������� ���������� ���������';
  SalcuAutoPipeServer_Programmanastroenanarabotuslokal = '��������� ��������� �� ������ � ���������� ������. ������������� �� ����������?';
  SalcuAutoPipeServer_Proverkatonostikopii = '�������� �������� �����';
  SalcuAutoPipeServer_Proverkazavershenauspeshno = '�������� ��������� �������';
  SalcuAutoPipeServer_Prover_teparametrLokal_nyyput_kb = '��������� �������� "��������� ���� � ���� ������".';
  SalcuAutoPipeServer_Rasetvazhnostidokumentov = '������ �������� ����������.';
  SalcuAutoPipeServer_Rasetvazhnostidokumentovzakonen = '������ �������� ���������� ��������.';
  SalcuAutoPipeServer_SafeDirName  = 'SafeDirName';
  SalcuAutoPipeServer_MaxImportAge = 'MaxImportAge';
  SalcuAutoPipeServer_Scheduler = 'Scheduler';
  SalcuAutoPipeServer_ShowSplash = 'ShowSplash';
  SalcuAutoPipeServer_Snyatiezamkovsbazyzavershilos_so = '������ "������" � ���� ����������� � �������: %d';
  SalcuAutoPipeServer_Sostoyanieobnovleniya = '��������� ���������� = ';
  SalcuAutoPipeServer_SourceFolder = 'SourceFolder';
  SalcuAutoPipeServer_SozdanieBazyvyhodnogodnya = '�������� "���� ��������� ���"';
  SalcuAutoPipeServer_SozdanieBazyvyhodnogodnyazaversh = '�������� "���� ��������� ���" ���������';
  SalcuAutoPipeServer_Sozdaniepolnoykopiibazyzavershen = '�������� ������ ����� ���� ���������';
  SalcuAutoPipeServer_Tom = 'tom';
  SalcuAutoPipeServer_TverKW = 'TverKW';
  SalcuAutoPipeServer_udalen = ' ������';
  SalcuAutoPipeServer_Udalenie = '�������� ';
  SalcuAutoPipeServer_Udalenierezervnyhkopiy = '�������� ��������� �����...';
  SalcuAutoPipeServer_Udalenierezervnyhkopiyzaversheno = '�������� ��������� ����� ���������';
  SalcuAutoPipeServer_Udaleniestaryhindeksov = '�������� ������ ��������';
  SalcuAutoPipeServer_Udaleniestaryhrezervnyhkopiy = '�������� ������ ��������� �����';
  SalcuAutoPipeServer_Udaleniestaryhverashnihkopiy = '�������� ������ "���������" �����';
  SalcuAutoPipeServer_UNCBasePath = 'UNCBasePath';
  SalcuAutoPipeServer_UndoRestore = 'UndoRestore';
  SalcuAutoPipeServer_Unitozhenoudalennyhdokumentov = '���������� %d ��������� ����������';
  SalcuAutoPipeServer_Usr = 'Usr#*';
  SalcuAutoPipeServer_Verashnyayakopiyaneobnaruzhena = '��������� ����� �� ����������';
  SalcuAutoPipeServer_Versiidokumentovvosnovnomirezerv = '������ ���������� � �������� � ��������� ���������� ���������';
  SalcuAutoPipeServer_Versiinekotoryhdokumentovvosnovn = '������ ��������� ���������� � �������� � ��������� ���������� �����������';
  SalcuAutoPipeServer_Vkopiiotsutstvuetfayl = '� ����� ����������� ���� ';
  SalcuAutoPipeServer_Vnimanieerezminutnanutsyaprofila = '��������! ����� %d ����� �������� ���������������� ������.'^M;
  SalcuAutoPipeServer_Vosstanovleniebazyzaversheno = '�������������� ���� ���������';
  SalcuAutoPipeServer_Vovremyaimportaproizoshlaoshibka = '�� ����� ������� ��������� ������';
  SalcuAutoPipeServer_Vremennaya = '��������� ';
  SalcuAutoPipeServer_Vremyaisteklo = '����� �������';
  SalcuAutoPipeServer_VremyapodgotovkiDel_tyisteklo = '����� ���������� "������" �������';
  SalcuAutoPipeServer_VremyavyshloDerzhat_syabol_shene = '����� �����. "��������� ������ ���� ���..."';
  SalcuAutoPipeServer_Vsepol_zovatelibudutotklyuenyZav = '��� ������������ ����� ���������. ��������� ���� ������ �� ��������� %d �����.';
  SalcuAutoPipeServer_Vydeystvitel_nohotiteotmenit_vos = '�� ������������� ������ �������� �������������� ���������?';
  SalcuAutoPipeServer_Vydeystvitel_nohotitevosstanovit = '�� ������������� ������ ������������ ���������?'#10;
  SalcuAutoPipeServer_WaitTime = 'WaitTime';
  SalcuAutoPipeServer_WorkDayStart = 'WorkDayStart';
  SalcuAutoPipeServer_YyyyMmDd = 'yyyy-mm-dd';
  SalcuAutoPipeServer_Zabytyepol_zovateli = '"�������" ������������:';
  SalcuAutoPipeServer_Zamkisbazysnyatyuspeshno = '"�����" � ���� ����� �������';
  SalcuAutoPipeServer_Zapuskmehanizmadostupakbazedanny = '������ ��������� ������� � ���� ������';

// END resource string wizard section

  rsCheckStorageDone = '��������� �������� ���������';
  rsStorageAbsent = '��������� ��������� �����������';
  rsCheckStorage = '��������� ��������';
  rsHolidayMask = '"���������� �������� ����������� ����� ������������� � ���������� %s';
  SalcuAutoPipeServer_DeltaNotStarted = '��������� ���������� � ������� "������" �� ��������!'#10'�� ���� �������� ������������';
  SalcuAutoPipeServer_StageNotCopied = '���� ������ �� ����������, ��� ��� �� ��� ������������ �������� "����������"';
  SalcuAutoPipeServer_IndexNotUpdate = '��������� ������ �� ��������, ��� ��� �� ��� ������������ �������� "����������"';
  SalcuAutoPipeServer_KWNotLoaded = '�������� ����� �� �������������, ��� ��� �� ��� ������������ �������� "����������"';
  rsNotEnoughSpace = '�� ����� �������� %s';
  rsAdditionalCreatedSuccessful = '�������������� ������ ������� �������';
  rsErrorCreateAdditional = '������ %d �������� �������������� ������';
  rsUpdateTextBaseError = '������ ���������� ���������� �����';
  rsStartBuildTextIndex = '������ ������� ������������ ���������� �������';
  rsTextIndexBuilded = '������������ ���������� ������� ���������';
  rsStartTextUpdate = '������ ���������� ���������� �����';
  rsTextUpdateDone = '���������� ���������� ����� ���������';
  rsPleaseQuit = '����������, ��������� ������ � "������������"';
  rsUserNotQuit = '������������ %s �� �������(�) ����������';
  rsDeltaCreateError = '�� ����� ���������� "������" ��������� ������ #%d';
  rsDeltaCreated = '"������" ������������ �������';
  rsSpravkiFileName = '\\archi\archi\incoming\spravki\diff.lst';


 rsErrorSendMessage = '������ �������� ��������� ������������ %s';
 rsEveryDayUpdate = '���������� ��������� ���������� ����';
 rsResetArchiLogError = '������ �������������� ����� ���� �����������';
 rsPrepareDelta = '���������� ������ "������"';
 rsSpravki = '�� ��� ������� ������ � ������ ����������. ������ ���������� ��������� �� ��������.';
 rsCopyBackupToVersion = '������� �� ������ � ���������� �����';
 rsCopyVersionToBackup = '������� �� ���������� ����� � �����';

 cServiceName = 'ArchiService';
 cServiceDisplayName = '������ ������������� �����������';

 cExecutorLogName = 'alcu_%s.log';

implementation

end.
