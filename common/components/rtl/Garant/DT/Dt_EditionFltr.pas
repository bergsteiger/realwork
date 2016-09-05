unit Dt_EditionFltr;
{ $Id: Dt_EditionFltr.pas,v 1.35 2016/06/16 05:40:06 lukyanets Exp $ }

// $Log: Dt_EditionFltr.pas,v $
// Revision 1.35  2016/06/16 05:40:06  lukyanets
// ������������ UserManager �� ����� ������
//
// Revision 1.34  2014/04/04 06:58:50  dinishev
// Bug fix: �� ��������� ����.
//
// Revision 1.33  2014/02/28 14:54:23  lulin
// - ������������� ����������.
//
// Revision 1.32  2013/10/21 15:43:09  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.31  2013/10/21 10:30:56  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.30  2013/10/18 15:38:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.29  2011/06/10 11:53:44  voba
// - DocumentServer ������ �������� function DocumentServer(aFamily : TdaFamilyID), ��� �� �������� Family �� �����������
//
// Revision 1.28  2009/07/20 12:38:48  voba
// - ������� renum � ��������
//
// Revision 1.27  2009/03/04 16:26:03  lulin
// - <K>: 137470629. Bug fix: �� ��������� ����������.
//
// Revision 1.26  2008/01/28 12:23:43  voba
// - bug fix
//
// Revision 1.25  2007/08/14 14:30:08  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.24  2007/07/19 07:16:27  voba
// no message
//
// Revision 1.23.24.1  2007/07/13 14:38:56  voba
// no message
//
// Revision 1.23  2006/06/05 13:56:49  voba
// - _move CdtNextEditionAttributes, CdtOldEditionAttributes to ddDocumentCopy
//
// Revision 1.22  2005/05/16 11:06:04  voba
// - ������� atLogInfo �� atDocLogInfo, atAnnoLogInfo
//
// Revision 1.21  2004/11/02 10:05:21  voba
// - tuning
//
// Revision 1.20  2004/10/12 10:50:06  voba
// - update: ���������� log �������� ��� ������� ��������
//
// Revision 1.19  2004/08/03 08:52:50  step
// ������ dt_def.pas �� DtDefine.inc
//
// Revision 1.18  2004/05/14 16:58:47  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.17  2004/05/14 14:48:59  law
// - ���������� �������� � ��������.
//
// Revision 1.16  2004/05/14 14:29:05  law
// - change: TevVariant ������������ � Tk2Variant � �������� � k2Types.
//
// Revision 1.15  2003/12/24 16:04:53  voba
// -parameter tuning
//
// Revision 1.14  2003/12/02 08:22:05  voba
// -rename TCreateNewEditionFilter to TCloneDocumentFilter
//
// Revision 1.13  2003/10/31 17:22:06  voba
// - rename const
//
// Revision 1.12  2003/10/30 09:20:33  voba
// - new behavior : ����� ������ ��������� ���������� ��� ���������� ���������
//
// Revision 1.11  2003/10/22 12:40:01  voba
// - tuning of constant
//
// Revision 1.10  2003/06/25 14:57:18  voba
// - new behavior: ������ ������� k2_tiExternalHandle ������ �����������, �.�. ��� update ���������� � �������� SetEditionID.
//
// Revision 1.9  2003/06/25 14:32:42  voba
// - new behavior: ��������� ����������� �������� ������ �� ���������� �������� ��� ������������ ������ ��������.
//
// Revision 1.8  2003/05/07 08:33:19  voba
// -new behavior: �������������� ��������� Name ��� �������� ����� ���������
//
// Revision 1.7  2003/04/21 15:23:22  voba
// - bug fix
//
// Revision 1.6  2003/04/16 09:24:03  voba
// - improvement: ��������� ���������� � ������ ��������� � exception � SetEditionID
//
// Revision 1.5  2003/04/09 16:11:26  demon
// - code fix
//
// Revision 1.4  2003/04/09 11:58:06  demon
// - bug fix: ������������� ��������� ��� utEdition.
//
// Revision 1.3  2003/04/04 16:47:59  demon
// - bug fix: ��������� ���������� �������������� �������������� ������.
//
// Revision 1.2  2003/04/04 15:11:06  demon
// - new: TStartDocumentGenerator - ������� ������ �������� � ������ �
// �������� ���������������.
//
// Revision 1.1  2003/04/04 13:59:30  demon
// - new: TCreateNewEditionFilter - ������ ��� �������� �������� ���������
// � ������������� ���������� ������.
//

{$I DtDefine.inc}

interface
uses Classes,
     l3Types,
     k2TagFilter, k2Types, k2Reader,
     daTypes,
     Dt_Const, Dt_Types;

type
 (* ������ ������� ����� �������� � ���� � ���������������� ���������� ������ � ������
    ������, ���������� ������ ����.
   ID ������������ ��������� ������������ ������� (ExternalEditionID). *)
 TCloneDocumentFilter = class(Tk2TagFilter)
  protected
   fFamily          : TdaFamilyID;
   fIntDocumentID   : TDocID;
   fIntEditionID    : TDocID;
   // fExtEditionID : TDocID;
   fStripName       : Boolean;
   fReplaceUserType : Boolean;
   fNewUserType     : TUserType;
   fReverseHlinkRenum : Boolean;

   procedure SetEditionID(aValue : TDocID);
   procedure SetInternalEditionID(aValue : TDocID);

  public
   constructor Create(aOwner : TComponent; aFamily : TdaFamilyID); reintroduce;

   procedure   AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;

   {Main Data Initialization}
   procedure   OpenStream; override;

   property    ExternalEditionID : TDocID {read fExtEditionID} write SetEditionID;
   {* - ������� (������������) ������������� ����������� �������� ���������. }

   property    InternalEditionID : TDocID write SetInternalEditionID;
   {* - ��y������� ������������� ����������� �������� ���������. �������� �� "���������� � ����" �� ������������}

   property    ReverseHlinkRenum : Boolean write fReverseHlinkRenum;
   {* - ����������� �� ������ �������������� fIntDocumentID -> fIntEditionID,
        �� � ������������� "��������" ��������������, ������ ��� ������������� ��������������
        ����� ��-��� ������� �������� ��� �������� �������}

   property    StripName : Boolean read fStripName write fStripName;
   {* - StripName = true ������� �� Name ����� "(� ���. � ���....)". }

   property    ReplaceUserType : Boolean read fReplaceUserType write fReplaceUserType;
   {* - ReplacetUserType = true �������� k2_tiUserType �� utEdition. }

   property    NewUserType : TUserType read fNewUserType write fNewUserType;
   {* - ConvertUserType = true �������� k2_tiUserType �� utEdition. }

 end;

 TStartDocumentGenerator = Class(Tk2CustomReader)
  protected
   fCurDocID : TDocID;
  public
   procedure   Read; override;

   { ������������� ��������� ��� ������ ��������� ��������. �� ����� �������� � �����. }
   property    InternalDocID  : TDocID read fCurDocID write fCurDocID;
 end;

implementation
uses SysUtils,
     k2Tags, Dt_Err, Dt_Doc, Dt_Serv, l3Variant,
     Dt_LinkServ,

     Document_Const,
     Hyperlink_Const,
     Address_Const,

     k2VariantImpl
     ;

(************************** TCreateNewEditionFilter *************************************)

constructor TCloneDocumentFilter.Create(aOwner : TComponent; aFamily : TdaFamilyID);
begin
 inherited Create(aOwner);
 if aFamily > 0 then
  fFamily:=aFamily
 else
  raise EHtErrors.CreateInt(ecNotFamilyID);


 //fIntDocumentID:=0;
 //fIntEditionID:=0;
 //fExtEditionID:=0;
end;

procedure TCloneDocumentFilter.SetInternalEditionID(aValue : TDocID);
begin
 fIntEditionID := aValue;
end;

procedure TCloneDocumentFilter.SetEditionID(aValue : TDocID);
var
 lRelFlag : Boolean;
begin
 if aValue <> 0 then
 begin
  //fExtEditionID:=aValue;
  fIntEditionID := aValue;
  LinkServer(fFamily).Renum.GetRNumber(fIntEditionID);

  if DocumentServer(fFamily).CheckDoc(fIntEditionID,True,lRelFlag) then
  begin
   if lRelFlag then
    msg2log(Format('������������� %d, �������� ��� �������� ��������, ����� ������������ ��������',[aValue]))
   else
    msg2log(Format('������������� %d, �������� ��� �������� ��������, ����� ������������ ����������',[aValue]));
   raise EHtErrors.CreateInt(ecIDAlreadyUsedParam,[aValue]);
  end;
 end;
end;


function StripNameSuffix(aValue : string) : String;
const
 sidUserModifyShortSrch2 = '(� ����������� � ������������)';
var
 lPos : Integer;
begin
 lPos := Pos(sidUserModifyShortSrch2, aValue);
 If lPos > 0 then
  Result := Copy(aValue, 1, Pred(lPos))
 else
  Result := aValue;
end;

procedure TCloneDocumentFilter.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
var
 lValue    : Tk2Variant;
 lFltrAtom : Boolean;
begin
 lFltrAtom:=False;
 lValue:=Value;
 try
  if TopType[0].IsKindOf(k2_typDocument) then {��������� ������������ ����� ���������}
  begin
   if (AtomIndex = k2_tiName) then
   begin
    if StripName then
     lValue.AsString.AsString := StripNameSuffix(lValue.AsString.AsString);
   end
   else
   if (AtomIndex = k2_tiInternalHandle) then
   begin
    if (lValue.Kind=k2_vkInteger) then
    begin
     fIntDocumentID:=TDocID(lValue.asInteger);
     lValue := Tk2VariantImpl.Make(fIntEditionID);
     inherited AddAtomEx(AtomIndex,lValue);
     lFltrAtom := True;
     if ReplaceUserType then
      Generator.AddIntegerAtom(k2_tiUserType,Integer(NewUserType));
    end
    else
     ConvertErrorEx(lValue.Kind);
   end
   else
   if (AtomIndex = k2_tiExternalHandle) then
    lFltrAtom := True
   else
   if (AtomIndex = k2_tiUserType) then
    if ReplaceUserType then lFltrAtom := True;
  end
  else
   if TopType[0].IsKindOf(k2_typHyperLink) then {���������� �������������� �������������� ������}
   begin
    if (AtomIndex = k2_tiHandle) then
     lFltrAtom :=True;
   end
   else
    if TopType[1].IsKindOf(k2_typHyperLink) and  {��������� ������: �������������� ������}
       TopType[0].IsKindOf(k2_typAddress) then
    begin
     if (AtomIndex = k2_tiDocID) then
     begin
      if (lValue.Kind = k2_vkInteger) then
      begin
       if TDocID(lValue.AsInteger) = fIntDocumentID then
        lValue := Tk2VariantImpl.Make(fIntEditionID)
       else 
       if fReverseHlinkRenum and
          (TDocID(lValue.AsInteger) = fIntEditionID) then
        lValue := Tk2VariantImpl.Make(fIntDocumentID);
      end
      else
       ConvertErrorEx(lValue.Kind);
     end;
    end;
  finally
   if not lFltrAtom then
    inherited AddAtomEx(AtomIndex,lValue);
  end;
end;

procedure TCloneDocumentFilter.OpenStream;
begin
 if (fIntEditionID = 0) then {Edition ID not Assigned}
 begin
  msg2log('�� ����� ������������� ��� �������� ��������');
  raise EHtErrors.CreateInt(ecNotAssigned);
 end;

 inherited;
end;

(*********************** TStartDocumentGenerator *******************************)

procedure TStartDocumentGenerator.Read;
begin
 Generator.StartChild(k2_typDocument);
 try
  Generator.AddIntegerAtom(k2_tiInternalHandle,fCurDocID);
 finally
  Generator.Finish;
 end;
end;

(***********************************************************************)
end.
