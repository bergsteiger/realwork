unit vcmEntity;
{* ��������. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmEntity -     }
{ �����: 27.02.2003 15:19 }
{ $Id: vcmEntity.pas,v 1.28 2012/10/26 18:33:19 lulin Exp $ }

// $Log: vcmEntity.pas,v $
// Revision 1.28  2012/10/26 18:33:19  lulin
// - �������� ��������� ����� ���������.
//
// Revision 1.27  2009/11/12 18:06:59  lulin
// - ������� �������� ������������ ��������.
//
// Revision 1.26  2009/11/06 13:06:17  lulin
// - ��������� �� ������ �������� ���������� ����� ���� Data.
//
// Revision 1.25  2009/10/01 14:58:27  lulin
// - ������� ������������ ���� � �������.
//
// Revision 1.24  2009/02/20 17:29:18  lulin
// - ������ ������������.
//
// Revision 1.23  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.22  2007/07/10 12:40:09  lulin
// - ������ ���� � ����� � ������ ��� ��������, �� ����������� �������� ����� � Parent-���� (CQ-25867, <K>-29392957).
//
// Revision 1.21  2007/01/20 17:35:43  lulin
// - ��������� �������� �������� ������ �� ������� ��������� ���������������.
//
// Revision 1.20  2007/01/20 15:31:07  lulin
// - ��������� ��������� �������� ��� ���������� � ��� ������������.
//
// Revision 1.19  2007/01/18 09:06:49  lulin
// - � ����� ���������� ������ �������� �����.
//
// Revision 1.18  2007/01/17 14:02:43  lulin
// - �������� ��������� ��������������� ��������� � ������ ��������.
//
// Revision 1.17  2006/03/16 14:12:51  lulin
// - ������ ����������� ��������� �������� ��������� - �������������� ��������.
//
// Revision 1.16  2006/03/16 11:28:49  lulin
// - �������� ����� ��������� � �������� - ������� �� �� ��������������.
//
// Revision 1.15  2005/07/14 16:02:46  lulin
// - new behavior: � run-time �������� ID �������� �� �� ����� �� ����������, ������������ � MenuManager'�.
//
// Revision 1.14  2004/11/18 17:33:58  lulin
// - new interface: IvcmParamsPrim.
//
// Revision 1.13  2004/10/07 14:16:58  lulin
// - new: ������ � _IvcmParams ����� ����������� ������ �������� DoneStatus - ��� ����������. �� ������ ����� "��-�������" ������������ ShortCut'� ��� ����������� �������� (CQ OIT5-10123).
//
// Revision 1.12  2004/09/22 09:34:29  lulin
// - ������������ - �������� ��������� �������������� Name -> ID ��� ������� ��������.
//
// Revision 1.11  2004/09/07 16:19:41  law
// - ������� VCM �� ����������� �������.
//
// Revision 1.10  2004/05/19 12:57:08  am
// change: ������ BeginOp\EndOp � _Operation � Mode = (vcm_omExecute, _vcm_omAggregateExecute)
//
// Revision 1.9  2004/03/16 10:59:30  law
// - new const: _vcm_omAggregateExecute.
// - new behavior: ��� �������� ��������� �� ��������� ��������� Enabled.
//
// Revision 1.8  2003/11/30 13:18:09  law
// - new method version: IvcmEntity._Operation.
//
// Revision 1.7  2003/11/21 12:09:57  law
// - change: �������� aMode ��������� � ����� � ������ ��������������.
//
// Revision 1.6  2003/11/20 20:37:53  law
// - new behavior: ��������� ���������� ������ ��������������� ��������.
// - new behavior: ����� �������� ��������� �������� ������ ������ �� ��������������.
// - cleanup: �������� � Design-Time ���������� �� GblAdapter (�� ����������).
//
// Revision 1.5  2003/04/28 13:02:34  law
// - remove const: vcm_opDone.
// - new prop: _IvcmParams.Done.
//
// Revision 1.4  2003/04/08 13:10:35  law
// no message
//
// Revision 1.3  2003/04/08 12:52:48  law
// - new method version: IvcmEntity._Operation.
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: ���� ������ � ����� ���� TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - ��������������� MVC � VCM.
//
// Revision 1.9  2003/03/24 14:04:04  law
// - change: ���������� ������������ ��� ����������� � �������� � _IvcmParams.
//
// Revision 1.8  2003/03/24 13:25:46  law
// - change: ���������� ������������ ��� ����������� � �������� � _IvcmParams.
//
// Revision 1.7  2003/03/21 12:34:42  law
// - new behavior: ��������� �������� ������ ����������.
//
// Revision 1.6  2003/02/28 16:11:38  law
// - cleanup.
//
// Revision 1.5  2003/02/27 17:23:52  law
// - change: ��������� ������ ExecuteOperation � OperationEnabled.
//
// Revision 1.4  2003/02/27 16:26:56  law
// - new behavior: ������� ����������� ����������� ��������� ����� ��������� � ������ ��������.
//
// Revision 1.3  2003/02/27 13:00:20  law
// - new prop: IvcmEntity._Inner.
//
// Revision 1.2  2003/02/27 12:55:50  law
// - new prop: IvcmEntity._Inner.
//
// Revision 1.1  2003/02/27 12:33:38  law
// - new units: vcmEntity, vcmControlEntity.
//

{$Include vcmDefine.inc }

interface

uses
  vcmUserControls,
  vcmInterfaces,
  vcmExternalInterfaces,
  vcmBaseMenuManager,

  vcmBase
  ;

type
  TvcmEntity = class(TvcmCacheableBase, IvcmEntity)
   {* ��������. }
    protected
    // interface methods
      //IvcmEntity
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmParams;
                         aMode         : TvcmOperationMode): Boolean;
        overload;
        virtual;
        {* - ��������� �������� ��������. }
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmExecuteParams): Boolean;
        overload;
        { ���������� �������� �� ����� ��������. }
      function Operation(const anOp    : TvcmOPID;
                         const aParams : IvcmTestParams): Boolean;
        overload;
        { ���������� �������� �� ����� ��������. }
      function Operation(const anOp : TvcmOPID;
                         aMode      : TvcmOperationMode = vcm_omExecute): Boolean;
        overload;
        { ���������� �������� �� ����� ��������. }
      function Get_ID: TvcmControlID;
        virtual;
        {* - ���������� ������������� ��������. ��� ���������� � ��������. }
      function Get_Inner(const anEntityID : TvcmControlID): IvcmEntity;
        virtual;
        {* - ���������� ��������� ��������. ��� ���������� � ��������. }
      function Get_AsForm: IvcmEntityForm;
        virtual;
    protected
    // internal methods
      procedure SelfOperation(const anOperationID : TvcmControlID;
                             aMode               : TvcmOperationMode;
                             const aParams       : IvcmParams);
        virtual;
        {* - ��������� �������� ��������. ��� ���������� � ��������. }
  end;//TvcmEntity

implementation

uses
  vcmRepositoryEx
  ;

// start class TvcmEntity

function TvcmEntity.Operation(const anOp    : TvcmOPID;
                              const aParams : IvcmParams;
                              aMode         : TvcmOperationMode): Boolean;
  //overload;
  {* - ��������� �������� ��������. }
var
 l_Inner : IvcmEntity;
begin
 if (aMode in [vcm_omExecute, vcm_omAggregateExecute]) then
  g_MenuManager.BeginOp;
 try
  if (anOp.rEnID = Get_ID) then
   SelfOperation(anOp.rOpID, aMode, aParams)
  else
  begin
   l_Inner := Get_Inner(anOp.rEnID);
   if (l_Inner = nil) then
   begin
    Case aMode of
     vcm_omTest :
      aParams.TestPart.Op.Flag[vcm_ofEnabled] := false;
     vcm_omExecute,
     vcm_omAggregateExecute :
      {Result.DoneStatus := vcm_dsNoEntity};
    end;//Case aMode
    aParams.DoneStatus := vcm_dsNoEntity;
   end//l_Inner = nil
   else
    l_Inner.Operation(anOp, aParams, aMode);
  end;//anEntityID = Get_ID
 finally
  if (aMode in [vcm_omExecute, vcm_omAggregateExecute]) then
   g_MenuManager.EndOp;
 end;//try..finally
 Result := aParams.Done;
end;

function TvcmEntity.Operation(const anOp    : TvcmOPID;
                              const aParams : IvcmExecuteParams): Boolean;
  //overload;
  { ���������� �������� �� ����� ��������. }
begin
 Result := Operation(anOp, aParams.BasePart, vcm_omExecute);
end;

function TvcmEntity.Operation(const anOp    : TvcmOPID;
                              const aParams : IvcmTestParams): Boolean;
  //overload;
  { ���������� �������� �� ����� ��������. }
begin
 Result := Operation(anOp, aParams.BasePart, vcm_omTest);
end;

function TvcmEntity.Operation(const anOp : TvcmOPID;
                              aMode      : TvcmOperationMode = vcm_omExecute): Boolean;
  //overload;
  { ���������� �������� �� ����� ��������. }
begin
 if (aMode = vcm_omTest) then
  Result := Operation(anOp, TvcmTestParams.Make.BasePart, aMode)
 else
  Result := Operation(anOp, vcmParams.BasePart, aMode);
end;

function TvcmEntity.Get_ID: TvcmControlID;
  //virtual;
  {-}
begin
 Result := vcm_cidEmpty;
end;

function TvcmEntity.Get_Inner(const anEntityID : TvcmControlID): IvcmEntity;
  //virtual;
  {-}
begin
 Result := nil;
end;

function TvcmEntity.Get_AsForm: IvcmEntityForm;
  //virtual;
begin
 Result := nil;
 Assert(false);
end;

procedure TvcmEntity.SelfOperation(const anOperationID : TvcmControlID;
                                  aMode               : TvcmOperationMode;
                                  const aParams       : IvcmParams);
  //virtual;
  {* - ��������� �������� ��������. }
begin
end;

end.

