unit bsTypesNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/bsTypesNew.pas"
// �����: 22.03.2010 15:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Model::nsTypes::bsTypesNew
//
// ���� ������ ������. ����� �� bsTypes. �� ����� ���� ������� �������. ����� ���� ��������� ����
// ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  eeInterfaces
  ;

type
 TDocumentPositionType = (
  {* ���� ���������������� � ��������� }
   dptNone
 , dptSub
 , dptMarker
 , dptBookmark
 , dptPara
 , dptMark
 , dptDocumentPlace
 );//TDocumentPositionType

 TbsDocPos = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rRefType : TDocumentPositionType;
   rPos : Longword;
   rPara : IeePara;
 public
    function EQ(const anOther: TbsDocPos): Boolean;
 end;//TbsDocPos

function TbsDocPos_C(aType: TDocumentPositionType;
     aPos: Longword): TbsDocPos;
function TbsDocPos_E: TbsDocPos;
  {* ������ ������� }
function TbsDocPos_S(aPos: Longword): TbsDocPos;
  {* ������� ����������� �� Sub }
function TbsDocPos_P(const aPos: IeePara): TbsDocPos;
function TbsDocPos_PID(aPos: Longword): TbsDocPos;

implementation

uses
  DocumentUnit,
  l3Bits
  ;


function TbsDocPos_C(aType: TDocumentPositionType;
         aPos: Longword): TbsDocPos;
//#UC START# *4BA782140193_491B329F0330_var*
//#UC END# *4BA782140193_491B329F0330_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BA782140193_491B329F0330_impl*
 Result.rRefType := aType;
 Result.rPos := aPos;
 if (Result.rRefType = dptSub) then
 begin
  if (Result.rPos AND POSITION_TYPE_MASK = POSITION_TYPE_PARA_ID) then
   Result.rRefType := dptPara;
  l3ClearMask(Integer(Result.rPos), Integer(POSITION_TYPE_MASK));
 end;//fRefType = dptSub
//#UC END# *4BA782140193_491B329F0330_impl*
end;//TbsDocPos.C


function TbsDocPos_E: TbsDocPos;
  {* ������ ������� }
//#UC START# *4BA7822703B2_491B329F0330_var*
//#UC END# *4BA7822703B2_491B329F0330_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BA7822703B2_491B329F0330_impl*
 Result := TbsDocPos_C(dptNone, 0);
//#UC END# *4BA7822703B2_491B329F0330_impl*
end;//TbsDocPos.E


function TbsDocPos_S(aPos: Longword): TbsDocPos;
  {* ������� ����������� �� Sub }
//#UC START# *4BA7823901C7_491B329F0330_var*
//#UC END# *4BA7823901C7_491B329F0330_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BA7823901C7_491B329F0330_impl*
 Result := TbsDocPos_C(dptSub, aPos);
//#UC END# *4BA7823901C7_491B329F0330_impl*
end;//TbsDocPos.S


function TbsDocPos_P(const aPos: IeePara): TbsDocPos;
//#UC START# *4BA789E200FF_491B329F0330_var*
//#UC END# *4BA789E200FF_491B329F0330_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BA789E200FF_491B329F0330_impl*
 if (aPos <> nil) then
 begin
  if (aPos.ID = -1) then
   Result := TbsDocPos_PID(0)
  else
   Result := TbsDocPos_PID(aPos.ID);
  Result.rPara := aPos;
 end;//aPos <> nil
//#UC END# *4BA789E200FF_491B329F0330_impl*
end;//TbsDocPos.P


function TbsDocPos_PID(aPos: Longword): TbsDocPos;
//#UC START# *4C064CB90097_491B329F0330_var*
//#UC END# *4C064CB90097_491B329F0330_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4C064CB90097_491B329F0330_impl*
 Result := TbsDocPos_C(dptPara, aPos);
//#UC END# *4C064CB90097_491B329F0330_impl*
end;//TbsDocPos.PID

// start class TbsDocPos

function TbsDocPos.EQ(const anOther: TbsDocPos): Boolean;
//#UC START# *50103641035D_491B329F0330_var*
//#UC END# *50103641035D_491B329F0330_var*
begin
//#UC START# *50103641035D_491B329F0330_impl*
 Result := (Self.rPos = anOther.rPos) and
           (Self.rRefType = anOther.rRefType);
//#UC END# *50103641035D_491B329F0330_impl*
end;//TbsDocPos.EQ

end.