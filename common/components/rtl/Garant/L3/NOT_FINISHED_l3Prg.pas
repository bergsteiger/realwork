unit NOT_FINISHED_l3Prg;
 {* Индикатор прогресса. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Prg.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3Prg" MUID: (47ECBF8502B7)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3_Base
 , l3Interfaces
;

type
 Tl3ProgressIndicator = class(Tl3_Base, Il3Progress)
  {* Индикатор прогресса. }
  protected
   procedure Start(Count: Integer;
    const aMsg: Il3CString); overload;
    {* начать процесс. }
   procedure Start(Count: Large;
    const aMsg: Il3CString); overload;
    {* начать процесс. }
   procedure Finish;
    {* закончить процесс. }
   procedure Progress(Current: Integer); overload;
    {* изменить текущее состояние. }
   procedure Progress(Current: Large); overload;
    {* изменить текущее состояние. }
   procedure ProgressEx(Current: Integer;
    const aMsg: Il3CString);
   procedure ChangeIO(Start: Boolean);
    {* изменить флаг InIO. }
   function InIO: Boolean;
    {* в процессе ввода/вывода? }
   function InUse: Boolean;
 end;//Tl3ProgressIndicator

implementation

uses
 l3ImplUses
 //#UC START# *47ECBF8502B7impl_uses*
 //#UC END# *47ECBF8502B7impl_uses*
;

procedure Tl3ProgressIndicator.Start(Count: Integer;
 const aMsg: Il3CString);
 {* начать процесс. }
//#UC START# *476F75DE01E9_47ECBFAE0299_var*
//#UC END# *476F75DE01E9_47ECBFAE0299_var*
begin
//#UC START# *476F75DE01E9_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F75DE01E9_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.Start

procedure Tl3ProgressIndicator.Start(Count: Large;
 const aMsg: Il3CString);
 {* начать процесс. }
//#UC START# *476F75F60302_47ECBFAE0299_var*
//#UC END# *476F75F60302_47ECBFAE0299_var*
begin
//#UC START# *476F75F60302_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F75F60302_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.Start

procedure Tl3ProgressIndicator.Finish;
 {* закончить процесс. }
//#UC START# *476F7608002D_47ECBFAE0299_var*
//#UC END# *476F7608002D_47ECBFAE0299_var*
begin
//#UC START# *476F7608002D_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F7608002D_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.Finish

procedure Tl3ProgressIndicator.Progress(Current: Integer);
 {* изменить текущее состояние. }
//#UC START# *476F76160143_47ECBFAE0299_var*
//#UC END# *476F76160143_47ECBFAE0299_var*
begin
//#UC START# *476F76160143_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F76160143_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.Progress

procedure Tl3ProgressIndicator.Progress(Current: Large);
 {* изменить текущее состояние. }
//#UC START# *476F7637011A_47ECBFAE0299_var*
//#UC END# *476F7637011A_47ECBFAE0299_var*
begin
//#UC START# *476F7637011A_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F7637011A_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.Progress

procedure Tl3ProgressIndicator.ProgressEx(Current: Integer;
 const aMsg: Il3CString);
//#UC START# *476F76450378_47ECBFAE0299_var*
//#UC END# *476F76450378_47ECBFAE0299_var*
begin
//#UC START# *476F76450378_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F76450378_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.ProgressEx

procedure Tl3ProgressIndicator.ChangeIO(Start: Boolean);
 {* изменить флаг InIO. }
//#UC START# *476F76550369_47ECBFAE0299_var*
//#UC END# *476F76550369_47ECBFAE0299_var*
begin
//#UC START# *476F76550369_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F76550369_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.ChangeIO

function Tl3ProgressIndicator.InIO: Boolean;
 {* в процессе ввода/вывода? }
//#UC START# *476F76660313_47ECBFAE0299_var*
//#UC END# *476F76660313_47ECBFAE0299_var*
begin
//#UC START# *476F76660313_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F76660313_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.InIO

function Tl3ProgressIndicator.InUse: Boolean;
//#UC START# *476F767601FC_47ECBFAE0299_var*
//#UC END# *476F767601FC_47ECBFAE0299_var*
begin
//#UC START# *476F767601FC_47ECBFAE0299_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F767601FC_47ECBFAE0299_impl*
end;//Tl3ProgressIndicator.InUse

end.
