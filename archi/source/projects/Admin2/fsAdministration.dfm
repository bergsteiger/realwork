object fsAdmin: TfsAdmin
  OldCreateOrder = True
  Forms = <
    item
      Name = 'cfVertical_utVGeneral'
      Childs = <
        item
          Name = 'enUserTree_utUsersTree'
          FormName = 'enUserTree'
          ZoneType = vcm_ztParent
          UserType = 0
          OnNeedMakeForm = cfVertical_utVGeneralenUserTree_utUsersTreeNeedMakeForm
        end
        item
          Name = 'enNoEditForm_utNoEdit'
          FormName = 'enNoEditForm'
          ZoneType = vcm_ztChild
          UserType = 0
          OnNeedMakeForm = cfVertical_utVGeneralenNoEditForm_utNoEditNeedMakeForm
        end
        item
          Name = 'cfProps_utProperties'
          Childs = <
            item
              Name = 'cfHorizontal_utHUserProperties'
              Childs = <
                item
                  Name = 'enUserPropertiesForm_utUserProperties'
                  FormName = 'enUserPropertiesForm'
                  ZoneType = vcm_ztParent
                  UserType = 0
                  OnNeedMakeForm = cfHorizontal_utHUserPropertiesenUserPropertiesForm_utUserPropertiesNeedMakeForm
                end
                item
                  Name = 'enMarkedListForm_utGroupsList'
                  FormName = 'enMarkedListForm'
                  ZoneType = vcm_ztChild
                  UserType = 0
                  OnNeedMakeForm = cfHorizontal_utHUserPropertiesenMarkedListForm_utGroupsListNeedMakeForm
                end>
              FormName = 'cfHorizontal'
              ZoneType = vcm_ztParent
              UserType = 0
              OnNeedMakeForm = cfProps_utPropertiescfHorizontal_utHUserPropertiesNeedMakeForm
            end
            item
              Name = 'cfHorizontal_utHUserGroupProperties'
              Childs = <
                item
                  Name = 'enUserGroupPropetriesForm_utUserGroupPropetries'
                  FormName = 'enUserGroupPropetriesForm'
                  ZoneType = vcm_ztParent
                  UserType = 0
                  OnNeedMakeForm = cfHorizontal_utHUserGroupPropertiesenUserGroupPropetriesForm_utUserGroupPropetriesNeedMakeForm
                end
                item
                  Name = 'cfVertical_utVGroupRights'
                  Childs = <
                    item
                      Name = 'enGroupRightsForm_utGroupRights'
                      FormName = 'enGroupRightsForm'
                      ZoneType = vcm_ztParent
                      UserType = 0
                      OnNeedMakeForm = cfVertical_utVGroupRightsenGroupRightsForm_utGroupRightsNeedMakeForm
                    end
                    item
                      Name = 'enRigthsValuesForm_utRightsValues'
                      FormName = 'enRigthsValuesForm'
                      ZoneType = vcm_ztChild
                      UserType = 0
                      OnNeedMakeForm = cfVertical_utVGroupRightsenRigthsValuesForm_utRightsValuesNeedMakeForm
                    end>
                  FormName = 'cfVertical'
                  ZoneType = vcm_ztChild
                  UserType = 1
                  OnNeedMakeForm = cfProps_utPropertiescfHorizontal_utHUserGroupPropertiesNeedMakeForm
                end>
              FormName = 'cfHorizontal'
              ZoneType = vcm_ztParent
              UserType = 1
              OnNeedMakeForm = cfProps_utPropertiescfHorizontal_utHUserGroupPropertiesNeedMakeForm
            end
            item
              Name = 'enMarkedListForm_utUsersList'
              FormName = 'enMarkedListForm'
              ZoneType = vcm_ztParent
              UserType = 1
              OnNeedMakeForm = cfProps_utPropertiesenMarkedListForm_utUsersListNeedMakeForm
            end>
          FormName = 'cfProps'
          ZoneType = vcm_ztChild
          UserType = 0
          OnNeedMakeForm = cfVertical_utVGeneralcfProps_utPropertiesNeedMakeForm
        end
        item
          Name = 'enBigBrotherForm_ugBigBrother'
          FormName = 'enBigBrotherForm'
          ZoneType = vcm_ztChild
          UserType = 0
          OnNeedMakeForm = cfVertical_utVGeneralenBigBrotherForm_ugBigBrotherNeedMakeForm
        end>
      FormName = 'cfVertical'
      ZoneType = vcm_ztMain
      UserType = 0
      OnNeedMakeForm = fsAdmincfVertical_utVGeneralNeedMakeForm
    end>
  Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1094#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1080' '#1075#1088#1091#1087#1087
  OwnerForm = 0
  Left = 475
  Top = 327
  Height = 209
  Width = 255
end
