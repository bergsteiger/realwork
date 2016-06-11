inherited WideSQLEditForm: TWideSQLEditForm
  ExplicitWidth = 532
  ExplicitHeight = 357
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainPanel: TPanel
    inherited MetaInfoPanel: TPanel
      inherited TableListPanel: TPanel
        inherited TablePanel: TPanel
          inherited TableList: TListBox
            TabOrder = 1
            Visible = True
            OnClick = TableListClick
            OnDblClick = AddTableButtonClick
          end
          inherited AddTableButton: TButton
            TabOrder = 0
          end
        end
      end
      inherited FieldsPanel: TPanel
        inherited FieldList: TListBox
          TabOrder = 1
          Visible = True
          OnDblClick = AddFieldButtonClick
        end
        inherited AddFieldButton: TButton
          TabOrder = 0
        end
      end
    end
    inherited SqlPanel: TPanel
      inherited SQLMemo: TMemo
        TabOrder = 1
        Visible = True
        OnEnter = SQLMemoEnter
        OnExit = SQLMemoExit
      end
      inherited SqlLabelPanel: TPanel
        TabOrder = 0
      end
    end
  end
end
