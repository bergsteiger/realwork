unit vcmModule;
{* ������� �����, �������������� ������ ���������� ������������ �� ������ ���������� vcm. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmModule -     }
{ �����: 24.02.2003 14:21 }
{ $Id: vcmModule.pas,v 1.88 2015/07/09 09:54:20 kostitsin Exp $ }

// $Log: vcmModule.pas,v $
// Revision 1.88  2015/07/09 09:54:20  kostitsin
// ����� �� ��������.
//
// Revision 1.87  2015/07/09 09:49:02  kostitsin
// {requestlink: 127042272 } - ������� ��� ����� _TvcmInterfaceList.
//
// Revision 1.86  2015/03/12 11:03:49  lulin
// - ������������� �����.
//
// Revision 1.85  2015/01/15 14:08:31  lulin
// {RequestLink:585926571}. ���������� Interlocked.
//
// Revision 1.84  2014/11/11 07:45:02  morozov
// �� ���������� (����� � vcmModule ������ ��� �������)
//
// Revision 1.83  2014/11/10 13:10:09  kostitsin
// {requestlink: 570118431 } - ������������ �����
//
// Revision 1.82  2014/11/10 12:42:13  kostitsin
// {requestlink: 570118431 }
//
// Revision 1.81  2012/11/01 09:42:19  lulin
// - ����� ����� � �������.
//
// Revision 1.80  2012/11/01 07:44:02  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.79  2011/04/12 15:00:46  lulin
// {RequestLink:195757811}.
//
// Revision 1.78  2010/10/18 15:19:26  lulin
// {RequestLink:235876230}.
//
// Revision 1.77  2010/09/15 18:14:59  lulin
// {RequestLink:235047275}.
//
// Revision 1.76  2010/09/15 15:59:58  lulin
// {RequestLink:235047275}.
//
// Revision 1.75  2010/09/15 15:11:05  lulin
// {RequestLink:235047275}.
//
// Revision 1.74  2010/09/06 15:48:58  lulin
// {RequestLink:197496539}.
//
// Revision 1.73  2009/11/12 18:06:59  lulin
// - ������� �������� ������������ ��������.
//
// Revision 1.72  2009/11/06 13:06:17  lulin
// - ��������� �� ������ �������� ���������� ����� ���� Data.
//
// Revision 1.71  2009/10/16 11:19:53  lulin
// - �������� ���������� ���� � �������.
//
// Revision 1.70  2009/10/14 18:39:46  lulin
// {RequestLink:166855347}.
//
// Revision 1.69  2009/10/05 07:05:10  lulin
// {RequestLink:159360578}. �50.
//
// Revision 1.68  2009/09/30 15:22:58  lulin
// - ������� �������� ���������� �� ������ �������� �����������.
//
// Revision 1.67  2009/09/28 18:50:34  lulin
// - ������� ������ ����� ��� ������ ��������.
//
// Revision 1.66  2009/09/28 14:33:38  lulin
// - ����� ������� ������ ������� �� ����� �������� �� �������.
//
// Revision 1.65  2009/09/25 14:05:17  lulin
// - ����� ������������������ ���.
//
// Revision 1.64  2009/09/25 14:03:15  lulin
// [$164596627].
//
// Revision 1.63  2009/09/25 12:45:09  lulin
// - ��������� ��� ������ ���������� �� �����.
//
// Revision 1.62  2009/09/25 12:09:11  lulin
// - ���������� ��������.
//
// Revision 1.61  2009/09/04 17:08:02  lulin
// {RequestLink:128288497}.
//
// Revision 1.60  2009/07/31 17:56:19  lulin
// {RequestLink:129240934}. �7.
//
// Revision 1.59  2009/04/20 16:47:07  lulin
// [$124453728]. ��������� �����������.
//
// Revision 1.58  2009/02/20 17:57:35  lulin
// - <K>: 136941122. ������ ����.
//
// Revision 1.57  2009/02/20 17:29:18  lulin
// - ������ ������������.
//
// Revision 1.56  2009/02/20 16:45:36  lulin
// - <K>: 136941122.
//
// Revision 1.55  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.54  2009/02/20 10:56:45  lulin
// - ����������� �� ������� �� ������, ������� �� ����� ����� �� ����������.
//
// Revision 1.53  2009/02/20 10:08:34  lulin
// - ������ ������������.
//
// Revision 1.52  2009/02/16 12:59:41  lulin
// - <K>: 135604584.
//
// Revision 1.51  2009/02/12 17:09:12  lulin
// - <K>: 135604584. ������� ������ � ����������� �����������.
//
// Revision 1.50  2008/03/19 14:23:42  lulin
// - cleanup.
//
// Revision 1.49  2008/02/14 19:32:29  lulin
// - �������� ����� ������ � ���������.
//
// Revision 1.48  2008/02/14 14:12:12  lulin
// - <K>: 83920106.
//
// Revision 1.47  2008/02/07 08:37:41  lulin
// - ������� �������� ������� �� ������������ ������.
//
// Revision 1.46  2008/02/01 15:14:33  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.45  2008/01/31 18:53:32  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.44  2008/01/25 12:06:48  lulin
// - �������������� ����� � �������.
//
// Revision 1.43  2008/01/25 11:32:02  lulin
// - �������������� ����� � �������.
//
// Revision 1.42  2007/01/20 20:28:48  lulin
// - ������� � ���������� �������� ����������.
//
// Revision 1.41  2007/01/20 17:35:43  lulin
// - ��������� �������� �������� ������ �� ������� ��������� ���������������.
//
// Revision 1.40  2007/01/19 11:53:20  lulin
// - ������ ��������� � ����� ���������� �� ����� ������������������.
//
// Revision 1.39  2007/01/18 10:49:30  lulin
// - �������� ������ ��������� ������ �� ���������.
//
// Revision 1.38  2006/12/08 14:21:02  lulin
// - ������� ������������ ���������� ���, ��� ����� ��� ������ ��������.
//
// Revision 1.37  2006/09/21 13:06:37  mmorozov
// - new behaviour: � ����������� � ���������� �������� �������� ����������� �������� � ���� IvcmOperationDef;
//
// Revision 1.36  2006/04/14 13:40:18  lulin
// - ��������� ����������� ����������.
//
// Revision 1.35  2006/04/14 12:11:14  lulin
// - ����� � �������� ���� ����� ���������� ��������.
//
// Revision 1.34  2006/04/14 11:53:02  lulin
// - ��������� ��������� � ���������� _Unknown_ � ���� ����.
//
// Revision 1.33  2006/03/27 13:20:02  lulin
// - cleanup.
//
// Revision 1.32  2006/02/02 14:48:48  mmorozov
// new: ���������� ������ � ������� ���������������� �����, �� ������ �����;
// change: ������ �������� ������ ��� �������� �����;
//
// Revision 1.31  2005/12/05 06:21:42  lulin
// - ���������� ��������� ������� ���������� �� ������� �������.
//
// Revision 1.30  2004/12/30 13:02:55  lulin
// - bug fix: ���� ����������� ���������� define'�.
//
// Revision 1.29  2004/12/30 12:19:23  lulin
// - _TvcmModule ��������� IUnknown ����� ������.
//
// Revision 1.28  2004/09/07 16:19:42  law
// - ������� VCM �� ����������� �������.
//
// Revision 1.27  2004/09/01 14:48:53  demon
// - new behavior: �� �������� IvcmDispatcher BeginOp/EndOp ������ ������ StoreFocus/RestoreFocus. ��� ����������� ���������� ������ ��� ������ ��������� ����.
//
// Revision 1.26  2004/07/14 13:49:27  law
// - optimiztion: ������ ������� ����� ���������.
// - optimization: ��������� �� ��������� Handle ���� ������ ��� ����������.
//
// Revision 1.25  2004/06/02 15:41:43  law
// - bug fix: ���������� "����������" ������.
//
// Revision 1.24  2004/06/02 10:20:38  law
// - ������ ����������� Tl3VList.MakeIUnknown - ����������� _Tl3InterfaceList.Make.
//
// Revision 1.23  2004/05/19 12:53:47  am
// change: �������� MenuManager.BeginOp\EndOp � _Dispatcher.BeginOp\EndOp.
//
// Revision 1.22  2004/03/19 13:25:18  mmorozov
// new: ����������� �������� ��� ���������� ����������� �����;
//
// Revision 1.21  2004/03/16 10:59:30  law
// - new const: _vcm_omAggregateExecute.
// - new behavior: ��� �������� ��������� �� ��������� ��������� Enabled.
//
// Revision 1.20  2004/02/10 12:59:47  law
// - change: IvcmUserTypesIterator ������ ���������� IvcmUserTypeDef.
//
// Revision 1.19  2003/12/18 17:19:55  law
// - ������ � ���������.
//
// Revision 1.18  2003/11/21 13:00:44  law
// - change: �������� aMode ��������� � ����� � ������ ��������������.
//
// Revision 1.17  2003/09/26 15:23:58  law
// - new behavior: ����� ������ ������ ��������� ��������.
//
// Revision 1.16  2003/09/25 17:00:22  law
// - new behavior: ������� ���������� �������� ����.
//
// Revision 1.15  2003/07/25 17:51:54  law
// - new behavior: ����� �������� ������ UserType'��.
//
// Revision 1.14  2003/06/03 14:08:12  law
// - bug fix: �� ���������� � ������ vcmNeedL3.
// - bug fix: ��� �������� ���������� �� ������������� ������.
//
// Revision 1.13  2003/06/02 15:19:38  narry
// - update: ����������� ���������������� ����������
//
// Revision 1.12  2003/05/22 09:08:01  narry
// - update: ������ ����������������
//
// Revision 1.11  2003/04/22 14:03:00  law
// - new behavior: ������� ��������� ��������, ��������� �� �������� �����.
//
// Revision 1.10  2003/04/04 11:29:47  law
// - new behavior: ������� ����������� ������ ����� ������, ��� �������� �� �������.
//
// Revision 1.9  2003/04/04 10:58:57  law
// - bug fix: ���� ������ � ����� ���� TvcmControlID.
//
// Revision 1.8  2003/04/03 15:58:27  demon
// - bug fix: ������ �� ������������ �� �������.
//
// Revision 1.7  2003/04/03 13:03:32  law
// - new method: IvcmParam.CheckAggregate.
//
// Revision 1.6  2003/04/03 12:14:07  law
// - new prop: TvcmEntityForm._Module.
// - new method: TvcmEntityForm._MakeAggregate.
// - new method: IvcmModule._MakeAggregate.
//
// Revision 1.5  2003/04/03 09:26:17  law
// - new behavior: ������ ����������� �������� �� �������.
//
// Revision 1.4  2003/04/02 12:54:19  law
// - new interface: IvcmSubscriber.
//
// Revision 1.3  2003/04/02 11:41:42  law
// - new method: _TvcmModule._MakeAggregate.
// - new proc: vcmTestParams.
//
// Revision 1.2  2003/04/02 11:17:53  law
// - new unit: vcmAggregate.
//
// Revision 1.1  2003/04/01 12:54:42  law
// - ��������������� MVC � VCM.
//
// Revision 1.41  2003/03/28 15:24:16  law
// - ������ ������� �������� ������ ������.
//
// Revision 1.40  2003/03/28 11:47:09  law
// - change: �� _TvcmModule ����� _ModuleDef, ��� ��� ���� ������ ������������� ��� � ����������� �� _TvcmModule.
//
// Revision 1.39  2003/03/26 12:13:40  law
// - cleanup.
//
// Revision 1.38  2003/03/25 09:56:52  law
// - new prop: TvcmOperationsCollectionItem.Hint, TvcmOperationsCollectionItem.LongHint.
//
// Revision 1.37  2003/03/24 14:04:05  law
// - change: ���������� ������������ ��� ����������� � �������� � _IvcmParams.
//
// Revision 1.36  2003/03/24 13:25:46  law
// - change: ���������� ������������ ��� ����������� � �������� � _IvcmParams.
//
// Revision 1.35  2003/03/21 12:34:42  law
// - new behavior: ��������� �������� ������ ����������.
//
// Revision 1.34  2003/03/21 10:13:33  law
// - cleanup: ������� ������ vcm*Repository.
//
// Revision 1.33  2003/03/21 09:39:28  law
// - new _module: vcmRepositoryEx.
//
// Revision 1.32  2003/03/20 16:42:56  law
// - change: ���� �������� ����� Name ��������� �������� _Caption.
//
// Revision 1.31  2003/03/20 15:38:11  law
// - new methods: IvcmDispatcher.GetModuleCount, IvcmDispatcher.GetModule.
//
// Revision 1.30  2003/03/20 15:22:49  law
// - new methods: IvcmDispatcher.GetModuleByID, IvcmDispatcher._ModuleOperation.
//
// Revision 1.29  2003/03/20 15:10:10  law
// - new method: IvcmDispatcher._GetModuleByName.
// - new method version: IvcmDispatcher._EntityOperation.
//
// Revision 1.28  2003/03/20 12:30:00  law
// - new behavior: ������� ��������� ����������� ��������.
//
// Revision 1.27  2003/03/19 14:14:53  law
// - new behavior: ������������������ ������ ������ �������� � ������.
//
// Revision 1.26  2003/03/19 13:04:16  law
// - new method: _TvcmModule.Make.
//
// Revision 1.25  2003/03/14 18:24:08  law
// - �������-�� ����� ������ ��� _BCB.
//
// Revision 1.24  2003/03/14 09:22:35  law
// - change: ���������� vcm �� l3.
//
// Revision 1.23  2003/03/13 09:52:01  law
// - new component: TvcmModuleDef.
//
// Revision 1.22  2003/03/12 16:29:45  law
// - new behavior: ������� ����������� �������� ������ �� ������ _TvcmOperations.
//
// Revision 1.21  2003/03/12 16:07:00  law
// - change: _TvcmModule ������ ����������� �� _TDataModule.
//
// Revision 1.20  2003/03/11 17:03:47  law
// - new unit: vcmModulesRepository.
//
// Revision 1.19  2003/03/11 13:03:57  law
// - new behavior: ������� �������������� ����������� ��������������� ��������� � ��������.
//
// Revision 1.18  2003/02/28 16:11:38  law
// - cleanup.
//
// Revision 1.17  2003/02/27 17:35:12  law
// - change: ��������� ������ ExecuteOperation � OperationEnabled.
//
// Revision 1.16  2003/02/27 10:23:23  law
// - new unit: vcmOperationableIdentifiedUserFriendly.
//
// Revision 1.15  2003/02/27 10:06:08  law
// - change: ������ � �������� �������� �������������.
//
// Revision 1.14  2003/02/27 09:37:57  law
// - new behavior: � �������� �������� ��������� ��������.
//
// Revision 1.13  2003/02/27 09:00:03  law
// - cleanup.
//
// Revision 1.12  2003/02/27 07:57:37  law
// - new behavior: ������� ��������� ��������� ������.
//
// Revision 1.11  2003/02/26 16:22:42  law
// - new behavior: ������� ��������� �������� � �������� ����.
//
// Revision 1.10  2003/02/25 17:59:45  law
// - new behavior: ����� ������ ������� ��� ���������� �������� ������.
//
// Revision 1.9  2003/02/25 14:08:15  law
// - rename method: _TvcmModule._GetOperations -> _TvcmModule.GetOperationsDef.
//
// Revision 1.8  2003/02/25 11:11:37  law
// - change: ��������� ����������� �������� ������.
//
// Revision 1.7  2003/02/25 11:08:05  law
// - change: ��������� ����������� �������� ������.
//
// Revision 1.6  2003/02/24 16:13:37  law
// - new prop: IvcmModuleDef.OperationsDefIterator.
//
// Revision 1.5  2003/02/24 15:58:09  law
// no message
//
// Revision 1.4  2003/02/24 14:19:34  law
// - change: ������ ������������ ����� ������.
//
// Revision 1.3  2003/02/24 13:45:04  law
// - new prop: IvcmModuleDef.Hint, IvcmModuleDef.LongHint.
// - bug fix: ������������ ��������� ������ GetBaseModuleDef.
//
// Revision 1.2  2003/02/24 12:52:12  law
// - new unit: mo.
//

{$Include vcmDefine.inc }

interface

uses
  Windows,

  Classes,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBase,
  vcmOperations,
  vcmEntityForm,
  vcmModuleDef,
  vcmUserTypeDefList,
  vcmEntitiesDefList
  ;

type
  _l3Unknown_Parent_ = TComponent;
  {$Define _UnknownIsComponent}
  {$IfNDef vcmNeedL3}
  {$Define _UnknownNotNeedL3}
  {$EndIf  vcmNeedL3}
  {$Include l3Unknown.imp.pas}
  TvcmModule = class(_l3Unknown_)
   {* ������� �����, �������������� ������ ���������� ������������ �� ������ ���������� vcm. }
    protected
    // internal fields
       f_ModuleDef : TvcmCustomModuleDef;
       {$IfNDef DesignTimeLibrary}
       f_Module    : Pointer;
       {$EndIf  DesignTimeLibrary}
       f_ID        : TvcmControlID;
    protected
    // property methods
      {$IfNDef DesignTimeLibrary}
      function pm_GetModule: IvcmModule;
        {-}
      {$EndIf  DesignTimeLibrary}  
    protected
    // interface methods
      // IvcmModule
       procedure Operation(const anID        : TvcmControlID;
                          aMode             : TvcmOperationMode;
                          const aParams     : IvcmParams);
         virtual;
         { ��������� �������� ������.
           
           Description
           
           
           Parameters
           anID :     ������������� ������������ �������, ��� ��������
                      ����� ����������� ��������
           aMode :    ����� ���������� �������� (vcm_omTest ���
                      vcm_omExecute)
           aParams :  ���������, ������������ � ��������
           
           
           Returns
           ������ ����������, ���������������� ���������               }
    protected
    // internal methods
      class procedure GetEntityForms(aList : TvcmClassList);
        virtual;
        { Description
          ��� ����, ����� ������ ���� � ��� ����������� ����������,
          ����� ����� ��������� ����� �������� � ������ ���������
          ������. ������ ���������� ���� ���������:


          <CODE>
          class procedure TmoDocument.GetEntityForms(aList : TvcmVList);
          begin
           inherited;
           aList.Add(TenDocument);
           aList.Add(TenList);
          end;
          </CODE>

          Summary
          ���������� ������ ���� ��������� ������.

          Note
          ������������� � ��������. � ������� ������� �������� ��
          ���������.                                                    }
      function QueryInterface(const IID: TGUID; out Obj): HResult;
        override;
        {-}
      procedure SetName(const NewName: TComponentName);
        override;
        {-}
      procedure Loaded;
        override;
        {-}
      {$I l3DefineCleanup.inc}
        {-}
      procedure PublishOp(const anOperation : TvcmString;
                          anExecute         : TvcmControlExecuteEvent;
                          aTest             : TvcmControlTestEvent);
        {* - ������������ ��������. }
      procedure ShowInToolbar(const anOperation : TvcmString;
                                  aValue            : Boolean);
        {-}
      procedure SetShortCut(const anOperation : TvcmString;
                            const aValue      : String);
        {-}
    protected
    // internal properties
      {$IfNDef DesignTimeLibrary}
      property Module: IvcmModule
        read pm_GetModule;
        {* - ������. }
      {$EndIf DesignTimeLibrary}  
    public
    // public methods
      constructor Create(AOwner : TComponent);
        override;
        {-}
      class function Make: IvcmModule;
        {-}
      class function GetModuleDef: IvcmModuleDef;
        virtual;
        {* - ���������� �������� ������. ��� ���������� � ��������. }
      class procedure GetEntitiesDef(aList      : TvcmEntitiesDefList;
                                     aUserTypes : TvcmUserTypeDefList);
        virtual;
        {* - ���������� ������ �������� ���������. ��� ���������� � ��������. }
      class function GetModuleByID(const aModuleID: TvcmControlID): IvcmModule;
        { ���������� ������ �� ��������������.
          
          Returns
          ��������� �� ��������� ������ ��� nil � ��� ������, ����
          ����������� ������ �� ����������.                        }
      class function GetModuleCount: Integer;
        { ���������� ���������� ������������������ �������. }
      class function GetModule(const anIndex: Integer): IvcmModule;
        {* - ���������� ������ �� �������. }
      class function DefaultContainer: IvcmContainer;
        {-}
      class function CheckContainer(const aCont: IvcmContainer): IvcmContainer;
        {-}  
    public
    // public properties
      property ID: TvcmControlID
        read f_ID;
        {* - ������������� ������. }
      property ModuleDef: TvcmCustomModuleDef
        read f_ModuleDef;
        {-}
  end;//TvcmModule
  RvcmModule = class of TvcmModule;

implementation

uses
  SysUtils,
  StrUtils,

  Menus,
  Forms,

  {$IfDef _UnknownNeedL3}
  l3Base,
  l3Interfaces,
  l3Interlocked,
  {$EndIf _UnknownNeedL3}
  vcmBaseMenuManager,
  vcmInternalInterfaces,
  vcmAggregate,
  vcmRepositoryEx,

  vcmInternalConst,
  vcmBaseOperationsCollectionItem,
  vcmBaseCollectionItem
  ;

{$IfNDef DesignTimeLibrary}
// start class TvcmModuleImplementation

type
  TvcmModuleImplementation = class(TvcmCacheableBase, IvcmModule, IvcmForms)
    private
    // internal fields
      f_Module : TvcmModule;
    protected
    // interface methods
      // IvcmModule
      function Get_ModuleDef: IvcmModuleDef;
        {-}
      procedure Operation(anID        : TvcmControlID;
                         const aParams     : IvcmParams;
                         aMode             : TvcmOperationMode);
        {* - ��������� �������� ������. }
      function GetOperationByID(anID: TvcmControlID): IvcmOperationDef;
        {-}
      // IvcmForms
      procedure GetEntityForms(aList : TvcmClassList);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aModule: TvcmModule);
        reintroduce;
        {-}
      class function Make(aModule: TvcmModule): IvcmModule;
        reintroduce;
        {-}
  end;//TvcmModuleImplementation

constructor TvcmModuleImplementation.Create(aModule: TvcmModule);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Module := aModule;
end;

class function TvcmModuleImplementation.Make(aModule: TvcmModule): IvcmModule;
  //reintroduce;
  {-}
var
 l_Module : TvcmModuleImplementation;
begin
 l_Module := Create(aModule);
 try
  Result := l_Module;
 finally
  vcmFree(l_Module);
 end;//try..finally
end;

function TvcmModuleImplementation.GetOperationByID(anID: TvcmControlID): IvcmOperationDef;
  {-}
var
 l_Item : TvcmBaseCollectionItem;
begin
 Result := nil;
 l_Item := f_Module.ModuleDef.Operations.FindItemByID(anID);
 Assert(l_Item <> nil);
 Result := TvcmBaseOperationsCollectionItem(l_Item).OperationDef;
 Assert(Result <> nil);
end;

procedure TvcmModuleImplementation.Cleanup;
  //override;
  {-}
begin
 if (f_Module <> nil) then
  f_Module.f_Module := nil;
 vcmFree(f_Module);
 inherited;
end;

function TvcmModuleImplementation.Get_ModuleDef: IvcmModuleDef;
  {-}
begin
 if (f_Module.f_ModuleDef = nil) then
  Result := nil
 else
  Result := f_Module.f_ModuleDef.ModuleDef;
end;

procedure TvcmModuleImplementation.Operation(anID        : TvcmControlID;
                                            const aParams     : IvcmParams;
                                            aMode             : TvcmOperationMode);
  {* - ��������� �������� ������. }
var
 l_D : IvcmDispatcher;
begin
 if (aMode in vcm_omExecutes) then
 begin
  l_D := vcmDispatcher;
  l_D.BeginOp;
  try
   g_MenuManager.BeginOp;
   try
    f_Module.Operation(anID, aMode, aParams);
   finally
    g_MenuManager.EndOp;
   end;//try..finally
  finally
   l_D.EndOp;
  end;//try..finally
 end//aMode in vcm_omExecutes
 else
  f_Module.Operation(anID, aMode, aParams);
end;

procedure TvcmModuleImplementation.GetEntityForms(aList : TvcmClassList);
  {-}
begin
 f_Module.GetEntityForms(aList);
end;
{$EndIf DesignTimeLibrary}

{$Include l3Unknown.imp.pas}

// start class TvcmModule

var
 g_Modules : array of record
  rModule      : IvcmModule;
  rModuleClass : RvcmModule;
 end = nil;

type
 _Unknown_Child_ = TvcmModule;
{$I l3ImplCleanup.inc}
begin
 FreeAndNil(f_ModuleDef);
 inherited;
end;

constructor TvcmModule.Create(AOwner : TComponent);
  //override;
var
 l_N : String;  
begin
 inherited Create(AOwner);
 l_N := ClassName;
 if SameText(l_N[1], 'T') then
  System.Delete(l_N, 1, 1);
 Name := l_N;
 f_ModuleDef := TvcmCustomModuleDef.Create(Self);
 Loaded;
 // - ���� ������, �.�. �� �� ��������� ���������
 {$IfNDef DesignTimeLibrary}
 if Assigned(g_MenuManager) then
  g_MenuManager.AddModule(Self);
 // - ��� ����� ����� Loaded ��� - http://mdp.garant.ru/pages/viewpage.action?pageId=235876230 
 {$EndIf DesignTimeLibrary}
end;

class function TvcmModule.Make: IvcmModule;
  {-}
var
 l_Length : Integer;
 l_Index  : Integer;
 l_Module : TvcmModule;
begin
 l_Length := Length(g_Modules);
 for l_Index := Low(g_Modules) to Pred(l_Length) do
  with g_Modules[l_Index] do
   if (rModuleClass = Self) then begin
    Result := rModule;
    Exit;
   end;//rModuleClass = Self
 l_Module := Create(nil);
 Result := l_Module As IvcmModule;
 SetLength(g_Modules, Succ(l_Length));
 with g_Modules[l_Length] do begin
  rModule := Result;
  rModuleClass := Self;
 end;//with g_Modules[Pred(l_Length)]
end;

class function TvcmModule.GetModuleDef: IvcmModuleDef;
  
begin
 Result := Make.ModuleDef;
end;

class procedure TvcmModule.GetEntitiesDef(aList      : TvcmEntitiesDefList;
                                          aUserTypes : TvcmUserTypeDefList);
  //virtual;
  {*- ���������� ������ �������� ���������. ��� ���������� � ��������. }
var
 l_List  : TvcmClassList;
 l_Index : Integer;
begin
 l_List := TvcmClassList.Make;
 try
  GetEntityForms(l_List);
  with l_List do
   for l_Index := Lo to Hi do
    RvcmEntityForm(Items[l_Index]).ClassGetEntitiesDef(aList, aUserTypes);
 finally
  vcmFree(l_List);
 end;//try..finally
end;

{$IfNDef DesignTimeLibrary}
function TvcmModule.pm_GetModule: IvcmModule;
  {-}
begin
 Result := IvcmModule(f_Module);
end;
{$EndIf DesignTimeLibrary}

procedure TvcmModule.Operation(const anID        : TvcmControlID;
                              aMode             : TvcmOperationMode;
                              const aParams     : IvcmParams);
  //virtual;
  {* - ��������� �������� ������. }
begin
 if (f_ModuleDef <> nil) then
  f_ModuleDef.Operation(anID, aMode, aParams);
end;

class procedure TvcmModule.GetEntityForms(aList : TvcmClassList);
  
begin
end;

function TvcmModule.QueryInterface(const IID: TGUID; out Obj): HResult;
  //override;
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 if IsEqualGUID(IID, IvcmModule) then
 begin
  Result := S_Ok;
  if (f_Module = nil) then begin
   IvcmModule(Obj) := TvcmModuleImplementation.Make(Self);
   f_Module := Pointer(Obj);
  end else
   IvcmModule(Obj) := Module;
 end else
 {$EndIf  DesignTimeLibrary}
  Result := inherited QueryInterface(IID, Obj);
end;

procedure TvcmModule.SetName(const NewName: TComponentName);
  //override;
  {-}
begin
 inherited;
 f_ID := vcmGetID(vcm_repModule, Name);
end;

procedure TvcmModule.Loaded;
  //override;
  {-}
begin
 inherited;
 f_ID := vcmGetID(vcm_repModule, Name);
end;

procedure TvcmModule.PublishOp(const anOperation : TvcmString;
                    anExecute         : TvcmControlExecuteEvent;
                    aTest             : TvcmControlTestEvent);
  {* - ������������ ��������. }
begin
 ModuleDef.Operations.PublishOp(Self, anOperation, anExecute, aTest, nil);
end;

procedure TvcmModule.ShowInToolbar(const anOperation : TvcmString;
                            aValue            : Boolean);
  {-}
var
 l_Op : TvcmOperationOptions;
begin
 with ModuleDef.Operations.FindItemByName(anOperation) As TvcmBaseOperationsCollectionItem do
 begin
  l_Op := Options;
  if aValue then
   Include(l_Op, vcm_ooShowInMainToolbar)
  else
  begin
   Exclude(l_Op, vcm_ooShowInMainToolbar);
   if (l_Op = []) then
    Include(l_Op, vcm_ooShowInChildMenu);
  end;//aValue
  Options := l_Op;
 end;//ModuleDef.Operations.FindItemByName(l_OpN) As TvcmBaseOperationsCollectionItem
end;

procedure TvcmModule.SetShortCut(const anOperation : TvcmString;
                                 const aValue      : String);
  {-}
var
 l_V : String;
begin
 l_V := aValue;
 l_V := AnsiReplaceText(l_V, 'Alt-', 'Alt+');
 l_V := AnsiReplaceText(l_V, 'Ctrl-', 'Ctrl+');
 l_V := AnsiReplaceText(l_V, 'Shift-', 'Shift+');
 (ModuleDef.Operations.FindItemByName(anOperation)
  As TvcmBaseOperationsCollectionItem).
   ShortCut := TextToShortCut(l_V);
end;

class function TvcmModule.GetModuleByID(const aModuleID: TvcmControlID): IvcmModule;
  {* - ���������� ������ �� ��������������. }
var
 l_Index : Integer;
begin
 Result := nil;
 for l_Index := Low(g_Modules) to High(g_Modules) do
  with g_Modules[l_Index] do
   if (rModule.ModuleDef.ID = aModuleID) then begin
    Result := rModule;
   end;//rModule.ModuleDef.ID = aModuleID
end;

class function TvcmModule.GetModuleCount: Integer;
  {* - ���������� ���������� ������������������ �������. }
begin
 Result := Length(g_Modules);
end;

class function TvcmModule.GetModule(const anIndex: Integer): IvcmModule;
  {* - ���������� ������ �� �������. }
begin
 Result := g_Modules[anIndex].rModule;
end;

class function TvcmModule.DefaultContainer: IvcmContainer;
  {-}
begin
 Result := vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer;
end;

class function TvcmModule.CheckContainer(const aCont: IvcmContainer): IvcmContainer;
  {-}
begin
 if (aCont = nil) then
  Result := DefaultContainer
 else
  Result := aCont;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\vcmModule.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\vcmModule.pas initialization leave'); {$EndIf}
finalization
 g_Modules := nil;

end.

