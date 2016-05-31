unit alcuMdpProtoSyncronizer;

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpProtoSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpProtoSyncronizer" MUID: (574C0E84031E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csMdpSyncPrim
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 //#UC START# *574C0E84031Eintf_uses*
 //#UC END# *574C0E84031Eintf_uses*
;

type
 //#UC START# *574C0E84031Eci*
 //#UC END# *574C0E84031Eci*
 //#UC START# *574C0E84031Ecit*
 //#UC END# *574C0E84031Ecit*
 TalcuMdpProtoSyncronizer = {abstract} class(Tl3ProtoObject)
  private
   f_Sync: TcsMdpSyncPrim;
  private
   procedure PostToGardoc(aStream: TStream);
  protected
   function PrepareData(aStream: TStream): Boolean; virtual; abstract;
   procedure BeforeSync; virtual; abstract;
   procedure AfterSuccessfulSync; virtual; abstract;
   function GetTitle: AnsiString; virtual; abstract;
  public
   constructor Create(aSync: TcsMdpSyncPrim); reintroduce;
   procedure Execute;
 //#UC START# *574C0E84031Epubl*
 //#UC END# *574C0E84031Epubl*
 end;//TalcuMdpProtoSyncronizer

implementation

uses
 l3ImplUses
 //#UC START# *574C0E84031Eimpl_uses*
 //#UC END# *574C0E84031Eimpl_uses*
;

constructor TalcuMdpProtoSyncronizer.Create(aSync: TcsMdpSyncPrim);
//#UC START# *574C37390202_574C0E84031E_var*
//#UC END# *574C37390202_574C0E84031E_var*
begin
//#UC START# *574C37390202_574C0E84031E_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C37390202_574C0E84031E_impl*
end;//TalcuMdpProtoSyncronizer.Create

procedure TalcuMdpProtoSyncronizer.Execute;
//#UC START# *574C38C2015A_574C0E84031E_var*
//#UC END# *574C38C2015A_574C0E84031E_var*
begin
//#UC START# *574C38C2015A_574C0E84031E_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C38C2015A_574C0E84031E_impl*
end;//TalcuMdpProtoSyncronizer.Execute

procedure TalcuMdpProtoSyncronizer.PostToGardoc(aStream: TStream);
//#UC START# *574C39080008_574C0E84031E_var*
//#UC END# *574C39080008_574C0E84031E_var*
begin
//#UC START# *574C39080008_574C0E84031E_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C39080008_574C0E84031E_impl*
end;//TalcuMdpProtoSyncronizer.PostToGardoc

//#UC START# *574C0E84031Eimpl*
//#UC END# *574C0E84031Eimpl*

end.
