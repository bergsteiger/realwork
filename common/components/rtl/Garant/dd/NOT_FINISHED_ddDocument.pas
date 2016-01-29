unit NOT_FINISHED_ddDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::Writers::ddDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  k2Interfaces,
  l3_Base,
  k2CustomFileGenerator
  ;

type
 TddDocumentGenerator = class(Tk2CustomFileGenerator)
 protected
 // protected methods
   procedure DoStartBlock; virtual;
   procedure DoCloseBlock; virtual;
   procedure Apply2Sub(AtomIndex: LongInt;
     const Value: Tk2Variant); virtual;
   procedure DoStartDocument; virtual;
   function NeedWritePara: Boolean; virtual;
     {* Ручки "наружу" для Writer'а. Писать или не писать параграф в зависимости от стиля. }
   function BlockIndent: Integer; virtual;
     {* Ручки "наружу" для Writer'а. Отступ для дочернего параграфа. }
   function IgnoreLeftIndent: Boolean; virtual;
   procedure CheckFilterPara(aFromFilter: Boolean); virtual;
 end;//TddDocumentGenerator

 TddDocument = class(Tl3_Base)
 end;//TddDocument

implementation

uses
  evdAllParaEliminator
  ;

// start class TddDocumentGenerator

procedure TddDocumentGenerator.DoStartBlock;
//#UC START# *55BB1FC300A2_4F683DA30260_var*
//#UC END# *55BB1FC300A2_4F683DA30260_var*
begin
//#UC START# *55BB1FC300A2_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55BB1FC300A2_4F683DA30260_impl*
end;//TddDocumentGenerator.DoStartBlock

procedure TddDocumentGenerator.DoCloseBlock;
//#UC START# *55BB200700A0_4F683DA30260_var*
//#UC END# *55BB200700A0_4F683DA30260_var*
begin
//#UC START# *55BB200700A0_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55BB200700A0_4F683DA30260_impl*
end;//TddDocumentGenerator.DoCloseBlock

procedure TddDocumentGenerator.Apply2Sub(AtomIndex: LongInt;
  const Value: Tk2Variant);
//#UC START# *55BB2C2E01BD_4F683DA30260_var*
//#UC END# *55BB2C2E01BD_4F683DA30260_var*
begin
//#UC START# *55BB2C2E01BD_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55BB2C2E01BD_4F683DA30260_impl*
end;//TddDocumentGenerator.Apply2Sub

procedure TddDocumentGenerator.DoStartDocument;
//#UC START# *55BB394E0074_4F683DA30260_var*
//#UC END# *55BB394E0074_4F683DA30260_var*
begin
//#UC START# *55BB394E0074_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55BB394E0074_4F683DA30260_impl*
end;//TddDocumentGenerator.DoStartDocument

function TddDocumentGenerator.NeedWritePara: Boolean;
//#UC START# *55BB59B0034D_4F683DA30260_var*
//#UC END# *55BB59B0034D_4F683DA30260_var*
begin
//#UC START# *55BB59B0034D_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55BB59B0034D_4F683DA30260_impl*
end;//TddDocumentGenerator.NeedWritePara

function TddDocumentGenerator.BlockIndent: Integer;
//#UC START# *55BB58F60134_4F683DA30260_var*
//#UC END# *55BB58F60134_4F683DA30260_var*
begin
//#UC START# *55BB58F60134_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55BB58F60134_4F683DA30260_impl*
end;//TddDocumentGenerator.BlockIndent

function TddDocumentGenerator.IgnoreLeftIndent: Boolean;
//#UC START# *55C092BD009D_4F683DA30260_var*
//#UC END# *55C092BD009D_4F683DA30260_var*
begin
//#UC START# *55C092BD009D_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55C092BD009D_4F683DA30260_impl*
end;//TddDocumentGenerator.IgnoreLeftIndent

procedure TddDocumentGenerator.CheckFilterPara(aFromFilter: Boolean);
//#UC START# *55E97B4602E4_4F683DA30260_var*
//#UC END# *55E97B4602E4_4F683DA30260_var*
begin
//#UC START# *55E97B4602E4_4F683DA30260_impl*
 !!! Needs to be implemented !!!
//#UC END# *55E97B4602E4_4F683DA30260_impl*
end;//TddDocumentGenerator.CheckFilterPara
end.