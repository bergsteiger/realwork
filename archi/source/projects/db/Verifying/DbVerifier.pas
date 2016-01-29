unit DbVerifier;

{ $Id: DbVerifier.pas,v 1.1 2005/09/26 14:23:35 step Exp $ }
// $Log: DbVerifier.pas,v $
// Revision 1.1  2005/09/26 14:23:35  step
// занесено в cvs
//

interface

uses
 l3Base,
 DbReformer,
 DbInfo;

type
 TDbVerifier = class(Tl3Base)
 private
 protected
  procedure CleanUp; override;
 public
  constructor Create(aDbInfo: TDbInfo;
                     aFamilyName: string;
                     aShowToUserProc: TShowToUserProc = nil); reintroduce;
  procedure Execute(aDoRepair: Boolean = False);
 end;


implementation

uses
 Forms, SysUtils;

const
 c_ReferencesAmount = 46;
 c_AllRefrerences: array [0 .. c_ReferencesAmount - 1] of record
  FolderFrom: TFamilyFolder;
  TableFrom : string;
  FieldFrom : Smallint;
  FolderTo  : TFamilyFolder;
  TableTo   : string;
  FieldTo   : Smallint;
  RepairKind: TRepairKind;
 end = (
//  —сылки на SUB001 не провер€ютс€

 // DT#B001
  (FolderFrom: ffGarant; TableFrom: 'DT#B001';  FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#A001';  FieldTo:   1; RepairKind:  rkClearRef),

 // LNK#1001
  (FolderFrom: ffGarant; TableFrom: 'LNK#1001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#1001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#1001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#2001
  (FolderFrom: ffGarant; TableFrom: 'LNK#2001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#2001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#2001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#6001
  (FolderFrom: ffGarant; TableFrom: 'LNK#6001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#6001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#6001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#7001
  (FolderFrom: ffGarant; TableFrom: 'LNK#7001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#7001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#7001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#8001
  (FolderFrom: ffGarant; TableFrom: 'LNK#8001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#8001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#8001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#9001
  (FolderFrom: ffGarant; TableFrom: 'LNK#9001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#9001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#9001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#B001
  (FolderFrom: ffGarant; TableFrom: 'LNK#B001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#B001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#B001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#C001
  (FolderFrom: ffGarant; TableFrom: 'LNK#C001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#C001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#C001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#D001
  (FolderFrom: ffGarant; TableFrom: 'LNK#D001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#D001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#D001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#E001
  (FolderFrom: ffGarant; TableFrom: 'LNK#E001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#E001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#E001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#F001
  (FolderFrom: ffGarant; TableFrom: 'LNK#F001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#F001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#F001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#I001
  (FolderFrom: ffGarant; TableFrom: 'LNK#I001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#I001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#I001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // PRIOR
  (FolderFrom: ffGarant; TableFrom: 'PRIOR001'; FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'DT#1001';  FieldTo:   1; RepairKind:  rkIgnore),

  (FolderFrom: ffGarant; TableFrom: 'PRIOR001'; FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#2001';  FieldTo:   1; RepairKind:  rkIgnore),

 // DT#9001
  (FolderFrom: ffGarant; TableFrom: 'DT#9001';  FieldFrom: 3;
   FolderTo:   ffGarant; TableTo:   'DT#B001';  FieldTo:   1; RepairKind:  rkClearRef),

 // RENUM001 - не провер€етс€

// // LOG001
  (FolderFrom: ffGarant; TableFrom: 'LOG001';    FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';   FieldTo:   1; RepairKind:  rkDeleteLink),

 // STAGE001
  (FolderFrom: ffGarant; TableFrom: 'STAGE001';  FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';   FieldTo:   1; RepairKind:  rkDeleteLink),

 // ALARM001
  (FolderFrom: ffGarant; TableFrom: 'ALARM001';  FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';   FieldTo:   1; RepairKind:  rkDeleteLink),

 // ACTIV001
  (FolderFrom: ffGarant; TableFrom: 'ACTIV001';  FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';   FieldTo:   1; RepairKind:  rkDeleteLink),

 // FILE001
  (FolderFrom: ffGarant; TableFrom: 'FILE001';   FieldFrom: 14;
   FolderTo:   ffGarant; TableTo:   'FILE001';   FieldTo:   1; RepairKind:  rkIgnore),

 // HLINK001
  (FolderFrom: ffGarant; TableFrom: 'HLINK001';   FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'FILE001';    FieldTo:   1; RepairKind:  rkDeleteLink),

//  (FolderFrom: ffGarant; TableFrom: 'HLINK001'; FieldFrom: 3;  - ¬ован сказал - не провер€ть
//   FolderTo:   ffGarant; TableTo:   'FILE001';  FieldTo:   1),

 // SUB001
  (FolderFrom: ffGarant; TableFrom: 'SUB001';     FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';    FieldTo:   1; RepairKind:  rkDeleteLink),

 // LNK#5001
  (FolderFrom: ffGarant; TableFrom: 'LNK#5001';   FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#5001';    FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#5001';   FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';    FieldTo:   1; RepairKind:  rkDeleteLink),

 // DT#5E001 - не провер€ем (да пол€ там разного типа)

 // LNK#3001
  (FolderFrom: ffGarant; TableFrom: 'LNK#3001';   FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#3001';    FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#3001';   FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';    FieldTo:   1; RepairKind:  rkDeleteLink),

//  (FolderFrom: ffGarant; TableFrom: 'LNK#3001'; FieldFrom: 3;
//   FolderTo:   ffGarant; TableTo:   'SUB001';   FieldTo:   2),

 // LNK#H001
  (FolderFrom: ffGarant; TableFrom: 'LNK#H001';   FieldFrom: 2;
   FolderTo:   ffGarant; TableTo:   'DT#3001';    FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffGarant; TableFrom: 'LNK#H001';   FieldFrom: 1;
   FolderTo:   ffGarant; TableTo:   'FILE001';    FieldTo:   1; RepairKind:  rkDeleteLink),

 // DT#GE001 - не провер€ем (да пол€ там разного типа)

 // DT#3E001 - не провер€ем (да пол€ там разного типа)

// Main
 // GULNK
  (FolderFrom: ffMain; TableFrom: 'GULNK'; FieldFrom: 1;
   FolderTo:   ffMain; TableTo:   'USERS'; FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffMain; TableFrom: 'GULNK'; FieldFrom: 2;
   FolderTo:   ffMain; TableTo:   'GUDT';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // GULNK

  (FolderFrom: ffMain; TableFrom: 'ACCESS2'; FieldFrom: 1;
   FolderTo:   ffMain; TableTo:   'GUDT';    FieldTo:   1; RepairKind:  rkDeleteLink),

  (FolderFrom: ffMain;   TableFrom: 'ACCESS2';  FieldFrom: 3;
   FolderTo:   ffGarant; TableTo:   'DT#F001';  FieldTo:   1; RepairKind:  rkDeleteLink),

 // PASS
  (FolderFrom: ffMain; TableFrom: 'PASS';    FieldFrom: 3;
   FolderTo:   ffMain; TableTo:   'USERS';   FieldTo:   1; RepairKind:  rkIgnore)

 );

var
 g_DbReformer: TDbReformer;

{ TDbVerifier }

procedure TDbVerifier.CleanUp;
begin
 g_DbReformer.CloseHt;
 g_DbReformer.DeleteHlkFiles;
 g_DbReformer.CloseLog;

 FreeAndNil(g_DbReformer);

 inherited;
end;

constructor TDbVerifier.Create(aDbInfo: TDbInfo;
                             aFamilyName: string;
                             aShowToUserProc: TShowToUserProc = nil);
begin
 inherited Create;

 g_DbReformer := TDbReformer.Create(aDbInfo, aFamilyName, aShowToUserProc);
 g_DbReformer.InitLog;
 g_DbReformer.InitHt;
end;

procedure TDbVerifier.Execute(aDoRepair: Boolean = False);
var
 I: Integer;
 l_RepairKind: TRepairKind;
 l_Caption: string;
begin
 if aDoRepair then
  l_Caption := 'ѕочинка'
 else
  l_Caption := 'ѕроверка';

 g_DbReformer.Log('================== ' + l_Caption + '  ' + DateToStr(Date) + ' ==================');

 for I := 0 to c_ReferencesAmount - 1 do
  with c_AllRefrerences[I] do
   try
    if aDoRepair then
     l_RepairKind := RepairKind
    else
     l_RepairKind := rkIgnore;

    g_DbReformer.VerifyReferences(FolderFrom, TableFrom, FieldFrom,
                                  FolderTo, TableTo, FieldTo,
                                  l_RepairKind);
    Application.ProcessMessages;
   except
    on E: Exception do
     g_DbReformer.Log('ѕроблема с проверкой ссылки ' + TableFrom + ' --> ' + TableTo + '  (' + E.Message + ')');
   end;

 g_DbReformer.Log('================== ' + l_Caption + ' завершена ==================');
end;

end.
