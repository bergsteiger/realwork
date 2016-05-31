{$IfNDef ListInfoUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "ListInfoUserTypes" MUID: (4FFB165600FE)
// Имя типа: "_ListInfoUserTypes_"

{$Define ListInfoUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListInfoUserTypes_ = {abstract} class(_ListInfoUserTypes_Parent_)
  protected
   procedure LiListInfoQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события liListInfo.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_ListInfoUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListInfoUserTypes_ = _ListInfoUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListInfoUserTypes_imp}

{$IfNDef ListInfoUserTypes_imp_impl}

{$Define ListInfoUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _ListInfoUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(liListInfoName,
  str_liListInfoCaption,
  str_liListInfoSettingsCaption,
  True,
  20,
  10,
  '',
  nil,
  nil,
  LiListInfoQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(liListInfoName
end;//_ListInfoUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf ListInfoUserTypes_imp_impl}

{$EndIf ListInfoUserTypes_imp}

