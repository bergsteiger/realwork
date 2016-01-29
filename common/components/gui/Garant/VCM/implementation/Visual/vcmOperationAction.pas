unit vcmOperationAction;
{* ������� �������� ���������� vcm ��� �������� � ����. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmOperationAction - }
{ �����: 27.02.2003 13:29 }
{ $Id: vcmOperationAction.pas,v 1.98 2014/02/18 10:01:29 lulin Exp $ }

// $Log: vcmOperationAction.pas,v $
// Revision 1.98  2014/02/18 10:01:29  lulin
// - ��� ������������� ������� ������� ����������� ��������� ���� ����������.
//
// Revision 1.97  2013/11/15 13:31:39  lulin
// {RequestLink:502351620}
//
// Revision 1.96  2012/04/11 15:29:02  lulin
// - �������� ����������� � "���������".
//
// Revision 1.95  2012/03/23 13:03:46  lulin
// - ���������� ���������.
//
// Revision 1.94  2012/03/21 18:08:43  lulin
// {RequestLink:349116364}
//
// Revision 1.93  2011/12/08 16:30:10  lulin
// {RequestLink:273590436}
// - ������ ����.
//
// Revision 1.92  2009/10/05 06:46:09  lulin
// {RequestLink:159360578}. �51.
//
// Revision 1.91  2009/02/20 17:29:22  lulin
// - ������ ������������.
//
// Revision 1.90  2009/02/20 16:45:41  lulin
// - <K>: 136941122.
//
// Revision 1.89  2009/02/20 15:19:08  lulin
// - <K>: 136941122.
//
// Revision 1.88  2009/02/12 17:09:18  lulin
// - <K>: 135604584. ������� ������ � ����������� �����������.
//
// Revision 1.87  2008/03/19 14:23:47  lulin
// - cleanup.
//
// Revision 1.86  2007/09/25 03:55:32  mmorozov
// - new behaviour: ��� ������\��������� �������� ���������� �������� ��� �������� ���� vcm_otDate, vcm_otCombo, vcm_otEditCombo ���������� �������� ���������� _SelectedString, ������ Caption. ��� ����� Caption ��� ���� ����� �������� ���� ���������� (� ������ ������ CQ: OIT5-26741);
//
// Revision 1.85  2007/06/28 14:56:16  lulin
// - cleanup.
//
// Revision 1.84  2007/06/26 09:42:38  mmorozov
// - hint fix;
//
// Revision 1.83  2007/04/26 13:29:47  oman
// - new: �������� ����� �������� � DesignTime - ����������
//  �������� <_Operation>.IsDefault (cq24612)
//
// Revision 1.82  2007/04/12 07:57:11  lulin
// - ���������� ������ � ����������.
//
// Revision 1.81  2007/04/11 12:04:29  lulin
// - ��� ��������� ������ ���������� ������ � ����������.
//
// Revision 1.80  2007/04/10 13:20:11  lulin
// - ���������� ������ � ����������.
//
// Revision 1.79  2007/02/28 13:36:20  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.78  2007/02/13 13:28:26  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.77  2007/02/13 12:09:03  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.76  2007/01/24 14:48:25  lulin
// - cleanup.
//
// Revision 1.75  2007/01/22 15:30:12  lulin
// - ����������� �� ��������������� ���������� ��� ���������� ���������������� ��������.
//
// Revision 1.74  2007/01/18 13:13:46  lulin
// - �������� � ������� ��������� ��� ����� � ��� ����������.
//
// Revision 1.73  2007/01/18 09:06:53  lulin
// - � ����� ���������� ������ �������� �����.
//
// Revision 1.72  2007/01/17 14:02:47  lulin
// - �������� ��������� ��������������� ��������� � ������ ��������.
//
// Revision 1.71  2007/01/16 14:13:14  lulin
// - ����������� �� ���������������� ��������� - ��������� ��������.
//
// Revision 1.70  2007/01/16 13:06:19  lulin
// - cleanup.
//
// Revision 1.69  2007/01/16 08:51:10  lulin
// - ����������� �� ���������������� ��������� - ������� ����.
//
// Revision 1.68  2007/01/15 18:33:03  lulin
// - ����������� �� ���������������� ��������� - ���������� ������ ��� ���.
//
// Revision 1.67  2007/01/15 17:54:27  lulin
// - ����������� �� ���������������� ���������.
//
// Revision 1.66  2007/01/15 17:25:40  lulin
// - cleanup.
//
// Revision 1.65  2007/01/15 12:59:25  lulin
// - ���� ���� ������ ����� �� ������.
//
// Revision 1.64  2007/01/15 12:47:28  lulin
// - ������ ����� ������� ������ �� ���������� - ����� ��� ������� ����� ���������.
//
// Revision 1.63  2007/01/12 13:14:40  oman
// - fix: ������ vcm_otMenuButtonCombo - ����������� ���� (cq24113)
//
// Revision 1.62  2007/01/11 12:52:18  lulin
// - ������ ������ ��� ������� ������ �� ���������� - ����� ��� ������� ����� ���������.
//
// Revision 1.61  2007/01/11 11:15:08  lulin
// - ������ "������" ����.
//
// Revision 1.60  2007/01/10 18:00:31  lulin
// - cleanup.
//
// Revision 1.59  2007/01/10 17:27:43  lulin
// - ������ ������ ����� ������� ������ �� ���������� - ����� ��� ������� ����� ���������.
//
// Revision 1.58  2007/01/10 15:56:02  lulin
// - cleanup.
//
// Revision 1.57  2007/01/10 12:22:31  lulin
// - ������ ����.
//
// Revision 1.56  2007/01/10 11:57:53  lulin
// - cleanup.
//
// Revision 1.55  2007/01/05 18:17:36  lulin
// - ���������� ������� ���� ��� ���������� �������.
//
// Revision 1.54  2007/01/05 14:14:53  lulin
// - ����� ������ ��� �������� - ��� ������ ����� �������� ����� ������������ ��������.
//
// Revision 1.53  2007/01/05 13:53:16  lulin
// - ����� ������ ��� �������� - ��� ������ ����� �������� ����� ������������ ��������.
//
// Revision 1.52  2007/01/05 13:33:00  lulin
// - cleanup.
//
// Revision 1.51  2007/01/05 11:35:27  lulin
// - ����� ������� �������� ��������.
//
// Revision 1.50  2007/01/05 11:18:00  lulin
// - cleanup.
//
// Revision 1.49  2006/09/21 13:06:31  mmorozov
// - new behaviour: � ����������� � ���������� �������� �������� ����������� �������� � ���� IvcmOperationDef;
//
// Revision 1.48  2006/08/25 12:34:15  oman
// - new: ����� ��� �������� _vcm_otMenuButtonPopup - ����� �� ���
//   _vcm_otButtonPopup, �� ����� ��� ������������ � ����.
//
// Revision 1.47  2006/04/24 11:29:28  oman
// - fix: ��� ���������� Hint � LongHint ����������� ���������� ����� � ���������
//
// Revision 1.46  2006/04/18 07:49:14  oman
// warning fix
//
// Revision 1.45  2006/04/11 08:16:14  oman
// - fix: ��� �������� �������� � ����������� � "��� ���������"
//  �� ���������� ��������� (cq20392)
//
// Revision 1.44  2006/03/31 07:41:49  lulin
// - ������� ��� ����������, ���������� � Execte ��������.
//
// Revision 1.43  2005/01/20 07:08:56  mmorozov
// new: � MakeTestParams � DoMakeExecuteParams ������������� _IvcmParams.OperationType;
//
// Revision 1.42  2004/11/18 16:29:57  lulin
// - ���������� ���������� �� VCM ��� ������������� inc'��.
//
// Revision 1.41  2004/11/05 14:04:54  am
// change: ����� ��� - _vcm_otMenuButtonCombo. ��������� ����� ��, ��� vcm_otButtonCombo, �� ����� ���������� ���� � ����.
//
// Revision 1.40  2004/09/17 11:23:02  lulin
// - �������� vcm_opStrings ������������ � _vcm_opItems, � ��� ������� ��� � _IvcmHolder �� _IvcmStrings (!).
//
// Revision 1.39  2004/09/11 12:01:52  lulin
// - cleanup: ����������� �� ������� ������������� ������������.
//
// Revision 1.38  2004/08/06 13:42:36  mmorozov
// new: ��� ���������� �������� ���� vcm_otTyper ������� ����� �������� _vcm_eopOperationCode;
//
// Revision 1.37  2004/06/02 10:20:51  law
// - ������ ����������� Tl3VList.MakeIUnknown - ����������� _Tl3InterfaceList.Make.
//
// Revision 1.36  2004/04/20 15:41:36  mmorozov
// change: � ���������� ��������������� � OnTest �������� �������� vcm_opCurrentItem;
//
// Revision 1.35  2004/04/19 15:40:47  mmorozov
// new: ���������� ����� �������� _vcm_eopObject � DoMakeExecuteParams;
//
// Revision 1.34  2004/04/09 11:27:49  law
// - new class: _TvcmStringList.
//
// Revision 1.33  2004/03/11 13:08:10  nikitin75
// + UpdateFromOp SecondaryShortCuts;
//
// Revision 1.32  2004/03/10 13:00:58  mmorozov
// new: ����������� ���������� Checked ��� �������� ���� vcm_otButtonCombo;
//
// Revision 1.31  2004/02/13 14:04:18  law
// - new behavior: �������� ���� vcm_otCombo ����� �������� � ����.
//
// Revision 1.30  2004/01/15 13:43:33  law
// - new const: _vcm_otShortCut - ��������, ������� ������ �������� � ���� ������ ��� ShortCut'�.
//
// Revision 1.29  2004/01/14 11:46:33  law
// - new const: _vcm_opBackColor, _vcm_opFont.
//
// Revision 1.28  2003/12/26 16:51:20  law
// - new behavior: ���������� ������ ��������� BottonCombo - ������ ���� ���� ����, �� � ������� ���� ����.
// - bug fix: ������ ��� �������������� �� ������� �������� _Caption �������� ����.
//
// Revision 1.27  2003/12/11 17:59:13  law
// - new const: _vcm_opPlainLevel.
// - new behavior: ������ ���� "������� ��������� (��� � �������)" ������� � ������ ����������� _vcm_opPlainLevel (CQ OIT5-5467).
//
// Revision 1.26  2003/12/09 16:12:50  law
// - new _operation param: vcm_opShowRoot.
//
// Revision 1.25  2003/12/09 15:45:53  law
// - bug fix: � OnTest �� ���������� ���������� CurrentNode.
//
// Revision 1.24  2003/12/03 13:36:48  law
// - new _operation param: vcm_opCurrentNode.
//
// Revision 1.23  2003/11/28 18:08:39  law
// - change: ��������, ��� ���, ����� �� ComboTree ����� ���� ���������� ��������� ����.
//
// Revision 1.22  2003/11/19 18:38:43  law
// - new prop: TvcmBaseOperationsCollectionItem.Params - ��������� ������ ���������� ��������.
// - new prop: TvcmOperationsCollectionItem.Linked - ���������� ������� �������� � ���������������� ���������� ��� ���.
//
// Revision 1.21  2003/11/19 09:13:49  law
// - bug fix: �� ��������������� ��� ��������� _vcmNeedL3.
//
// Revision 1.20  2003/11/19 09:09:18  law
// - bug fix: Exception ��� ������ ��� (F7).
//
// Revision 1.19  2003/11/18 17:59:45  law
// - new behavior: � ��������� _vcm_eopNode �������� ��������� ���� ������.
//
// Revision 1.18  2003/11/17 13:36:43  law
// - new const: _vcm_opSubNodes - ������ �������� ���������, ���� �� ��������������, �� ��� ����� ���������.
//
// Revision 1.17  2003/11/13 09:17:13  law
// - ����� ��� �������� - vcm_otTyper, �� �� ��� � vcm_otEdit, �� � ���������������� �������� �� ����, �� �� �� Esc/Edit.
//
// Revision 1.16  2003/11/05 15:17:12  law
// - new behavior: ��� ��������� ������������ ����� ������ �������� �������� vcm_opStrings ������ ��������� � OnTest.
//
// Revision 1.15  2003/09/03 16:00:44  law
// - new _operation type: _vcm_otButtonPopup.
//
// Revision 1.14  2003/09/03 07:50:23  law
// - new behavior: ��� vcm_otButtonCombo � ������ �������� OnExecute ������ ����� ��������� ������ (0 - ���� ������, 1..N - ����� ����).
//
// Revision 1.13  2003/09/02 16:48:05  law
// - new behavior: ������ ������ ������ ����� ��� vct_otButtonCombo.
//
// Revision 1.12  2003/09/01 12:51:19  law
// - new const: vcm_otEditCombo.
// - new behavior: ������ ���� ����������� ��������� ������������� � ��������������� ���������� ������.
//
// Revision 1.11  2003/08/01 11:46:10  law
// - bug fix: �� "��������" ������.
//
// Revision 1.10  2003/07/25 13:39:28  law
// - new behavior: toolbar'� ����������� ����� ���������.
//
// Revision 1.9  2003/07/17 12:53:12  law
// - new behavior: �������� ���������� GroupIndex.
//
// Revision 1.8  2003/04/09 15:52:35  law
// - new _operation type: vcm_otDate.
//
// Revision 1.7  2003/04/09 15:02:00  law
// - new behavior: �������� ����� �� ������ ComboBox'�.
//
// Revision 1.6  2003/04/09 14:51:34  law
// - new behavior: ������ ��������� ������ ����� � ComboBox'�.
//
// Revision 1.5  2003/04/09 13:08:14  law
// - new behavior: � ������� ����������� ������ ��������� �������� � ����� vcm_otCombo.
//
// Revision 1.4  2003/04/08 10:34:10  law
// - new behavior: ���������� OpDef � OperationAction.
//
// Revision 1.3  2003/04/04 12:56:31  law
// - new prop: IvcmOperationDef.ShortCut.
//
// Revision 1.2  2003/04/04 10:58:59  law
// - bug fix: ���� ������ � ����� ���� TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - ��������������� MVC � VCM.
//
// Revision 1.6  2003/03/27 14:36:54  law
// - new prop: �������� ������ ����� ��������.
//
// Revision 1.5  2003/03/26 16:10:33  law
// - new prop: ������� �������� _Category ��� ��������.
//
// Revision 1.4  2003/03/20 16:42:58  law
// - change: ���� �������� ����� Name ��������� �������� _Caption.
//
// Revision 1.3  2003/02/27 10:59:50  law
// - comments: xHelpGen.
//
// Revision 1.2  2003/02/27 10:55:12  law
// - new unit: vcmEntityAction.
//
// Revision 1.1  2003/02/27 10:36:26  law
// - new unit: vcmOperationAction.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmIdentifiedAction
  ;

type
  TvcmOperationAction = class(TvcmIdentifiedAction)
   {* ������� �������� ���������� vcm ��� �������� � ����. }
    private
    // internal fields
      f_Module : IvcmModule;
      f_OpDef  : IvcmOperationDef;
    protected
    // property methods
      function pm_GetOperationID: TvcmControlID;
        {-}
    protected
    // internal fields
      procedure UpdateFromOp;
        {-}
      function  DoMakeExecuteParams : IvcmExecuteParams;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure DoExecute;
        overload;
        override;
        {* - ���������� ��������. ��� ���������� � ��������. }
    public
    // public methods
      constructor Create(anOwner       : TComponent;
                         const anOpDef : IvcmOperationDef);
        reintroduce;
        {-}
      function  MakeTestParams: IvcmTestParams;
        override;
        {-}
    public
    // public properties
      property OperationID: TvcmControlID
        read pm_GetOperationID;
        {* - ��� ��������. }
      property OpDef: IvcmOperationDef
        read f_OpDef;
        {* - ��������� ��������. }
  end;//TvcmOperationAction

implementation

uses
  SysUtils,
  Menus,

  vcmBase,
  vcmMenuManager,
  vcmBaseMenuManager,
  vcmInternalConst
  ;

// start class TvcmModuleAction

constructor TvcmOperationAction.Create(anOwner       : TComponent;
                                       const anOpDef : IvcmOperationDef);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner, anOpDef.ID);
 f_OpDef := anOpDef;
 UpdateFromOp;
end;

procedure TvcmOperationAction.DoExecute;
  //overload;
  //override;
  {* - ���������� ��������. ��� ���������� � ��������. }

  procedure lp_Notify;
  {* - ����������� � ��������� ��������. ������������ ��� ������� ������
       ������������. }
  var
   l_Item: TMenuItem;
  begin
   if Assigned(ActionComponent) then
    if ActionComponent is TvcmToolButtonDef then
     g_MenuManager.OperationExecuteNotify(vcm_octToolbar, f_OpDef)
    else
     if ActionComponent is TMenuItem then
     begin
      l_Item := TMenuItem(ActionComponent);
      while l_Item.Parent <> nil do
       l_Item := l_Item.Parent;
      if l_Item.Owner is TPopupMenu then
       g_MenuManager.OperationExecuteNotify(vcm_octContextMenu, f_OpDef)
      else
       if l_Item.Owner is TMainMenu then
        g_MenuManager.OperationExecuteNotify(vcm_octMainMenu, f_OpDef);
     end;
  end;//lp_Notify
  
begin
 lp_Notify;
 inherited;
end;

procedure TvcmOperationAction.Cleanup;
  //override;
  {-}
begin
 f_OpDef := nil;
 f_Module := nil;
 inherited;
end;

procedure TvcmOperationAction.UpdateFromOp;
  {-}
begin
 if (f_OpDef <> nil) then
 begin
  Caption := f_OpDef.Caption;
  Hint := CalcOperationHint(f_OpDef.Hint, f_OpDef.LongHint);
  Category := f_OpDef.Category;
  ImageIndex := f_OpDef.ImageIndex;
  ShortCut := f_OpDef.ShortCut;
  SecondaryShortCuts := f_OpDef.SecondaryShortCuts;
  IsDefault := f_OpDef.IsDefault;
  if (f_OpDef.OperationType in [vcm_otCheck, vcm_otRadio, vcm_otButtonCombo, vcm_otMenuButtonCombo]) then
  begin
//   AutoCheck := true;
   GroupIndex := Succ(Random(Pred(High(Word))));
  end;//f_OpDef.OperationType in [vcm_otCheck, vcm_otRadio]
 end;//f_OpDef <> nil
end;

function TvcmOperationAction.DoMakeExecuteParams : IvcmExecuteParams;
  //override;
  {-}
var
 l_Node : IvcmNode;
begin
 Result := inherited DoMakeExecuteParams;
 Result.OperationType := OpDef.OperationType;
 if (OpDef.OperationType in vcm_ComboOperations) then
 begin
  if (ActionComponent = nil) then
   Result.ItemIndex := 0
  else
   Result.ItemIndex := ActionComponent.Tag; 
  Supports(ActionComponent, IvcmNode, l_Node);
  try
   Result.CurrentNode := l_Node;
  finally
   l_Node := nil;
  end;//try...finally
 end//OpDef.OperationType in vcm_ComboOperations
 else
 if (OpDef.OperationType in vcm_ComboBoxOperations) then
 begin
  Result.SelectedString := SelectedString; 
  Supports(ActionComponent, IvcmNode, l_Node);
  try
   Result.CurrentNode := l_Node;
  finally
   l_Node := nil;
  end;//try...finally
 end//OpDef.OperationType in vcm_ComboBoxOperations
 else
 if (OpDef.OperationType in vcm_SimpleOperations) then
  Result.SelectedString := SelectedString;
 ActionComponent := nil;
end;

function TvcmOperationAction.MakeTestParams: IvcmTestParams;
  //override;
  {-}
begin
 Result := inherited MakeTestParams;
 if (OpDef <> nil) then
 begin
  with Result, Op do
  begin
   if (OpDef.StatesCount > 0) then
   begin
    Caption := f_OpDef.Caption;
    Flag[vcm_ofChecked] := false;
   end;//OpDef.StatesCount > 0
   OperationType := OpDef.OperationType;
   if (OpDef.OperationType = vcm_otShortCut) then
    Flag[vcm_ofVisible] := false;
  end;//Result.TestPart
 end;//OpDef <> nil
end;

function TvcmOperationAction.pm_GetOperationID: TvcmControlID;
  {-}
begin
 Result := ID;
end;

end.

