unit StrShop;

{ $Id: StrShop.pas,v 1.63 2015/10/06 13:49:46 voba Exp $ }

interface
 uses
  Classes;

  Const
   sidBase  = 56000;
  {Question}
   {sidLinkQst        = sidBase + 100;}
   //sidDelQst         = sidBase + 101;
   //sidDelNumQst      = sidBase + 102;
   //sidPutHomeQst     = sidBase + 103;
   //sidPutHomeNumQst  = sidBase + 104;
   //sidLinkDocQst     = sidBase + 105;
   //sidLinkDocNumQst  = sidBase + 106;

  {Information}
   //sidDontInitInf    = sidBase + 1000;
   //sidDontOpenInf    = sidBase + 1001;
   //sidDontDelInf     = sidBase + 1002;

  {Attention}
   //sidDocAlreadyEdited = sidBase + 2000;
   //sidNoSelectItems    = sidBase + 2001;
   //sidNoSelectPrizn    = sidBase + 2002;
   //sidNoPresentPrizn   = sidBase + 2003;

  {Error}
   //sidNoActiveFamily = sidBase + 3000;

  {DataNumRecConst}
//   NumOfDNStr = 6;
//   sidFirstDataNumRec = sidBase + 4000;

  {LogJrnlTypeConst}
//   NumOfLJStr = 9;
//   sidLogJrnlType = sidBase + 4000 + NumOfDNStr;


   sidBaseII = sidBase + 4100;

  ResourceString
   sidDelQst         ='�� ������������� ������ �������'^M'"%S"?';
   //sidDelNumQst      ='�� ������������� ������ �������'^M'%D ����������?'^C;
   //sidPutHomeQst     ='�� ������������� ������ ���������'^M'"%S" � ������ �������?'^C;
   //sidPutHomeNumQst  ='�� ������������� ������ ��������� %d ���������� � ������ ������?'^C;
   //sidLinkDocQst     ='�� ������������� ������ ���������'^M'"%S"'^M'� "%S"?'^C;
   //sidLinkDocNumQst  ='�� ������������� ������ ��������� %D ����������'^M'� "%S"?'^C;

   {
 sidDontInitInf, "��� ������� � �������.\n���������� ��� ���������� ��������� ������.\003"
 sidDontDelInf, "�� ���� ������� ��������\n\042%S\042\n�������� �� �������������.\003"
 sidDontOpenInf, "�� ���� ������� ��������\n\042%S\042\n�������� �� ��� �������������.\003"
}

{
 sidDocAlreadyEdited, "�������� \042%S\042\n��� �������������.\003"
 sidNoPresentPrizn, "�������� ��������� �� ��������� �������.\003"
 sidNoActiveFamily, "���� ���������� ����������� ��� ����������.\003"
 sidNoSelectItems, "��� ���������� ����������.\003"
 sidNoSelectPrizn, "��� ���������� ���������.\003"
}

   {Error}

   sidProcessDone  = '������� ������� ��������.';
   sidProcessDoneFmt  = '������� %s ������� ��������.';

   sidCannotAddHyperLink = '�� ������� �������� ������. :(';

   sidDocumentWithNumber = '�������� � %d';

   sidChangeGroupQst    = '�������� ������ ��������� ��������� "%S"';

   sidEWDocPlugged      = ' �������� ���������';
   sidEWDocUnPlugged    = ' �������� �� ���������';
   sidEWJurUnpower      = '���� �������� ��� ������� ����������� ����.';
   sidEWOpenOtherUser   = '���� ������ ������ �������������.';
   sidEWNotUniq         = '�� ���������� �������� %S.';
   sidFieldEmptyErr     = '���� "%S" �� ����� ���� ������.';
   sidXFieldEmptyErr    = '���� �� ����� ���� ������.';
   sidCanNotBeEmpty     = '%S �� ����� ���� ������.';
   sidNotIncludedWarning = '�������� �� ���������.'^M'����������?';

   sidFindEnd           = '������ ��������� ���� ���.';
   sidNoFindAnother     = '������� ������� �� ������.';
   //sidNoSuchDoc         = '���������� �� �������.';
   sidNoSuchDoc         =  '�� ������� �� ������ ���������.';
   sidNoSubSelected     = '������� �������� �����.';
   sidNoDocPresent      = '�������� � ID = %d �����������.';
   sidWrongDocID        = '������ ����������� ����������� ������ ��������� %d.';
   sidDocPresent        = '�������� � ID = %d ��� ����������.';
   sidDocLoadFault      = '�� ������� ��������� �������� � ID = %d.'^M'������: %s.';
   sidMakeCopyFault     = '����� �� ���������';
   sidEmptyReference    = '���������� ��� ������ �����������.';
   sidDocsAdded         = '��������� %d ���������.';
   sidNotCompatibleData = '������������� ���� ������.';
   sidNotValidHyperAddress = '������������ ����� ����������� %d.%d.';
   sidSprForbidden      = '� ���������� ����� ���� ������� �� ������';

   sidRecordIsDoublet         = '����� ������ ��� ����������.';
   
   sidDoubletHyperAddress     = '����������� ��� ��������� �� ����� %d.%d.';
   sidQstDelDoublet           = '������� ������?';
   sidQstContinue             = '����������?';
   sidEmptyHyperAddress       = '����� ����������� �� �����.';
   sidSetRefConfirm           = '�� ��� ��� ������ ���������� �����������?';
   sidDeleteHLinkInSelectQst  = '�� ������������� ������ ������� ��� ������ � ���������� ���������?';

   sidBlockInTableDeny  = '������ �������� ���� � �������';


   sidBlockAttrWillLost = '�������� ����� (RTF-�����) ����� �������. ����������?';
   sidLinkedSubDelQst   = '�� ����� ���������. �� ��� ����� ������ ������� ��?';
   sidLinkedDocDelQst   = '�� �������� ���������. �� ��� ����� ������ ������� ���?';
   sidReadOnlyText      = '����� ������ ������ �� ������.'^M+'���������� ���������� �����.';
   sidHLinkInProcess    = '������� ������������ ������ �� �������.';
   sidDocNumberFmt      = '(���������� ID : %D, ID ������� : %D)';
   sidAssMaskDeny       = '�������� ����� ������ �� ���������� ������������� : ';
   sidSprAbout          = '������� �';
   sidSaveDocSetAsk     = '������� "%S" ���� ���������������.'^M'��������?';
   sidDelDocAsk         = '�� ������������� ������ ������� ��������'^M'"%S"?';
   sidDelDocSetAsk      = '�� ������������� ������ ������� �������'^M'"%S"?';
   sidSomeDelAsk        = '�� ������������� ������ ������� %S?';
   sidDeleteDenied      = '�������� ����������: %s';
   sidDocLockDeny       = '� ������ ������ �������� ��������� �� ��������������.'^M+
                          '���������� ��������� �������� �����.';
   sidAccessDeny        = '��� ���� �������';

   sidWarnAddNotSure    = '�� �������� ��������� ����������� � ������� ������������� � ���������� ���������';
   sidAlienSpr          = 'ID - ����� ������������ �������.'^M+
                          '�� ������ ������� ������ ������� � ����������?';
   sidNonDefProp        = '���� "%S" �� ���������.';
   sidOverSizeProp      = '���� "%S" �������� ������� ������� ������.';
   sidDocIdNonDef       = 'DocID Not defined.';
   sidSprLoadError      = '�� ������� ��������� �������.'^M+
                          '������� �����?';

   sidNoEqItems         = '��� "%S" ������������� ���.';

   sidQstDelAllBlocks   = '�� ������������� ������ ������������� ��� ����� � �����?';
   sidQstAutoClassification  = '�� ������������� ������ ��������� ��������� �� �����������������?';
   sidQstacceptAutoclasses  = '�� ������������� ������ ������� ����������?';

   sidQstRunSetMOJNotReg  = '�� ������������� ������ ��������� ������ "%s"';

   sidMakeRefProcess     = '��������� ������ : "%s"';

   sidDictItemNotLeaf    = '������� ������� �������� ���������.';

   sidDelWrongSprAsk     = '�������� ����� �������, ������� �� ���������� ��������� ������ ����. ������� ����� �������.';

   sidOperationConfirm   = '�� ������������� ������ ��������� ��������'^M'"%s"?';

   sidOp_SubNameCorrect  = '����������� ���� �����';

   sidWrongPageDiapason  = '�������� �������� �������. �� ���� �������� �� �������� � ��������.'^M'���� : "%s"';
   sidDefDiapasonErr     = 'TfrmImgViewer: ������ � ����������� ��������� ������� ("%s").'^M'���� : "%s"';
   sidTIFFFormatErr      = '������������ ���� TIFF : "%s"';

   {Macro}
   sidMacroDocNotPublish = '����� %s ���������� ����������� �� ���';

   scFmtFuterCounter     = '%d �� %d';
   scFmtCounter          = '(%d/%d)';
   scFmtFuterID          = 'ID = %d';
   scFmtFuterID2         = '  ID : %d (������ ID : %d)';

   scDocID               = 'ID ���������';
   scSprID               = 'ID �������';
   scShortName           = '�������� ��������';
   scFullName            = '������ ��������';

   sidUserInputModify = '������� ���������';

   sidUserInputModify2 = '� ��������� �������� ������� ��������� ���������� �����������:';

   sidUserModifyShortSrch = '(� ���. � ���. �� ';
   sidUserModifyShortSrch2 = '(� ����������� � ������������)'; {!! ������ Dt_EditionFltr StripNameSuffix.sidUserModifyShortSrch2}
   sidUserModifyFullSrch    = '(� ����������� �� ';
   sidUserModifyFullRegSrch = '\(� ����������� �� .+\)';
   sidUserOldEditNamePrefix = '���������� �� ';

   //��� �����|*.*|�������� �������|*.evd|ANSI (Windows) �����|*.doc|OEM (DOS) �����|*.txt|Rich text format|*.rtf
   sidTXTDlgFilter = 'ANSI (Windows) �����|*.txt';
   sidLSTDlgFilter = '������ ����������|*.lst';
   sidEvdDlgFilter = '�������� �������|*.evd';
   sidTextOutDlgFilter = '�������� �������|*.evd|ANSI (Windows) �����|*.doc|OEM (DOS) �����|*.txt|Rich text format|*.rtf';
   sidDocImageDlgFilter = '����� ���������|*.tif;*.jpg;*.gif;*.png;*.bmp;*.htm;*.html;*.xml;*.pdf;*.txt;*.chm;*.doc;*xls|��� �����|*.*';

   sidVerLinkCycle = '������������������ �������� ���������';
   sidVerLinkNonFutureEdition = '�������� ������������������ ��������';

   sidIDOlEditionNotDefined = 'ID ��������� ������ �������� �� �����';
   sidBadDocStructure = '�������� ���������. ����� ������ ��������.';
   sidAACLeftBlockNotPresent = '��� ����������������� ������� ��� ������ �����.';
   sidAACRightBlockNotPresent = '��� ����������������� ������� ��� ������� �����.';
 //function SSLoadStr(Ident: Word): string;
 //function GetAssMaskStr(aMask : Longint) : String;
 //function GetAssGroupName(piAssGroupID : integer) : String;

// procedure LoadStringList(Lst : TStrings; NumOfString : Integer; FirstID : Word);

implementation
 Uses SysUtils;

// {$R PromStr.res}
 {PromStr.rc}

(* procedure LoadStringList(Lst : TStrings; NumOfString : Integer; FirstID : Word);
  var
   I : Word;
  begin
   For I := FirstID to FirstID + Pred(NumOfString) do
    Lst.Add(LoadStr(I));
  end;

 function SSLoadStr(Ident: Word): string;
  begin
   If Ident < sidBaseII
    then LoadStr(Ident);
  end;
 *)

end.
