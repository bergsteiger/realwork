unit CsProcWithId;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsProcWithId.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsProcWithId
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  CsObject,
  CsDataPipe,
  CsQueryTypes
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TCsReplyProc = procedure (aPipe: TCsDataPipe) of object;

 TCsProcWithId = class(TCsObject)
 public
 // public fields
   QueryId : TCsQueryId;
   Proc : TCsReplyProc;
 public
 // public methods
   constructor Create(aQueryId: TCsQueryId;
     aProc: TCsReplyProc); reintroduce;
 end;//TCsProcWithId
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}

// start class TCsProcWithId

constructor TCsProcWithId.Create(aQueryId: TCsQueryId;
  aProc: TCsReplyProc);
//#UC START# *537F63B40386_537F6306025B_var*
//#UC END# *537F63B40386_537F6306025B_var*
begin
//#UC START# *537F63B40386_537F6306025B_impl*
 inherited Create;
 QueryId := aQueryId;
 Proc := aProc;
//#UC END# *537F63B40386_537F6306025B_impl*
end;//TCsProcWithId.Create

{$IfEnd} //AppServerSide AND not Nemesis

end.