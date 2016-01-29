<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmRegion
    Inherits System.Windows.Forms.Form

    'Форма переопределяет dispose для очистки списка компонентов.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Является обязательной для конструктора форм Windows Forms
    Private components As System.ComponentModel.IContainer

    'Примечание: следующая процедура является обязательной для конструктора форм Windows Forms
    'Для ее изменения используйте конструктор форм Windows Form.  
    'Не изменяйте ее в редакторе исходного кода.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmRegion))
        Me.gbIDRegion = New System.Windows.Forms.GroupBox()
        Me.ContextMenuNumer = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.tsCopyNumer = New System.Windows.Forms.ToolStripMenuItem()
        Me.lbNumer = New System.Windows.Forms.Label()
        Me.lbIDreg = New System.Windows.Forms.Label()
        Me.gbRegion = New System.Windows.Forms.GroupBox()
        Me.ListComboBox = New System.Windows.Forms.ComboBox()
        Me.ContextMenuRegions = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.tsSaveNumer = New System.Windows.Forms.ToolStripMenuItem()
        Me.smiAbout = New System.Windows.Forms.ToolStripMenuItem()
        Me.ПомощьToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.СправкаToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.MenuRegions = New System.Windows.Forms.MenuStrip()
        Me.ФайлToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.smiSaveList = New System.Windows.Forms.ToolStripMenuItem()
        Me.smiCopyNumer = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.smiExit = New System.Windows.Forms.ToolStripMenuItem()
        Me.SaveFileRegions = New System.Windows.Forms.SaveFileDialog()
        Me.gbIDRegion.SuspendLayout()
        Me.ContextMenuNumer.SuspendLayout()
        Me.gbRegion.SuspendLayout()
        Me.ContextMenuRegions.SuspendLayout()
        Me.MenuRegions.SuspendLayout()
        Me.SuspendLayout()
        '
        'gbIDRegion
        '
        Me.gbIDRegion.ContextMenuStrip = Me.ContextMenuNumer
        Me.gbIDRegion.Controls.Add(Me.lbNumer)
        Me.gbIDRegion.Controls.Add(Me.lbIDreg)
        Me.gbIDRegion.Location = New System.Drawing.Point(5, 70)
        Me.gbIDRegion.Name = "gbIDRegion"
        Me.gbIDRegion.Size = New System.Drawing.Size(272, 27)
        Me.gbIDRegion.TabIndex = 6
        Me.gbIDRegion.TabStop = False
        '
        'ContextMenuNumer
        '
        Me.ContextMenuNumer.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.tsCopyNumer})
        Me.ContextMenuNumer.Name = "ContextMenuStrip1"
        Me.ContextMenuNumer.Size = New System.Drawing.Size(221, 26)
        '
        'tsCopyNumer
        '
        Me.tsCopyNumer.Name = "tsCopyNumer"
        Me.tsCopyNumer.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.C), System.Windows.Forms.Keys)
        Me.tsCopyNumer.Size = New System.Drawing.Size(220, 22)
        Me.tsCopyNumer.Text = "&Копировать номер"
        '
        'lbNumer
        '
        Me.lbNumer.AutoSize = True
        Me.lbNumer.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.lbNumer.Location = New System.Drawing.Point(108, 11)
        Me.lbNumer.Name = "lbNumer"
        Me.lbNumer.Size = New System.Drawing.Size(44, 13)
        Me.lbNumer.TabIndex = 1
        Me.lbNumer.Text = "номер"
        '
        'lbIDreg
        '
        Me.lbIDreg.Location = New System.Drawing.Point(6, 11)
        Me.lbIDreg.Name = "lbIDreg"
        Me.lbIDreg.Size = New System.Drawing.Size(106, 13)
        Me.lbIDreg.TabIndex = 0
        Me.lbIDreg.Text = "ID Вашего региона:"
        '
        'gbRegion
        '
        Me.gbRegion.Controls.Add(Me.ListComboBox)
        Me.gbRegion.Location = New System.Drawing.Point(5, 27)
        Me.gbRegion.Name = "gbRegion"
        Me.gbRegion.Size = New System.Drawing.Size(272, 40)
        Me.gbRegion.TabIndex = 4
        Me.gbRegion.TabStop = False
        Me.gbRegion.Text = "Выбор региона"
        '
        'ListComboBox
        '
        Me.ListComboBox.AccessibleDescription = ""
        Me.ListComboBox.ContextMenuStrip = Me.ContextMenuRegions
        Me.ListComboBox.Dock = System.Windows.Forms.DockStyle.Fill
        Me.ListComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ListComboBox.FormattingEnabled = True
        Me.ListComboBox.IntegralHeight = False
        Me.ListComboBox.Location = New System.Drawing.Point(3, 16)
        Me.ListComboBox.MaxDropDownItems = 10
        Me.ListComboBox.Name = "ListComboBox"
        Me.ListComboBox.Size = New System.Drawing.Size(266, 21)
        Me.ListComboBox.Sorted = True
        Me.ListComboBox.TabIndex = 0
        Me.ListComboBox.Tag = ""
        '
        'ContextMenuRegions
        '
        Me.ContextMenuRegions.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.tsSaveNumer})
        Me.ContextMenuRegions.Name = "ContextMenuRegions"
        Me.ContextMenuRegions.Size = New System.Drawing.Size(247, 26)
        '
        'tsSaveNumer
        '
        Me.tsSaveNumer.Name = "tsSaveNumer"
        Me.tsSaveNumer.ShortcutKeys = CType(((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.Shift) _
            Or System.Windows.Forms.Keys.S), System.Windows.Forms.Keys)
        Me.tsSaveNumer.Size = New System.Drawing.Size(246, 22)
        Me.tsSaveNumer.Text = "&Сохранить список"
        '
        'smiAbout
        '
        Me.smiAbout.Name = "smiAbout"
        Me.smiAbout.Size = New System.Drawing.Size(158, 22)
        Me.smiAbout.Text = "&О программе..."
        '
        'ПомощьToolStripMenuItem
        '
        Me.ПомощьToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.smiAbout, Me.СправкаToolStripMenuItem})
        Me.ПомощьToolStripMenuItem.Name = "ПомощьToolStripMenuItem"
        Me.ПомощьToolStripMenuItem.Size = New System.Drawing.Size(68, 20)
        Me.ПомощьToolStripMenuItem.Text = "&Помощь"
        '
        'СправкаToolStripMenuItem
        '
        Me.СправкаToolStripMenuItem.Name = "СправкаToolStripMenuItem"
        Me.СправкаToolStripMenuItem.Size = New System.Drawing.Size(158, 22)
        Me.СправкаToolStripMenuItem.Text = "Справка"
        '
        'MenuRegions
        '
        Me.MenuRegions.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ФайлToolStripMenuItem, Me.ПомощьToolStripMenuItem})
        Me.MenuRegions.Location = New System.Drawing.Point(0, 0)
        Me.MenuRegions.Name = "MenuRegions"
        Me.MenuRegions.RenderMode = System.Windows.Forms.ToolStripRenderMode.System
        Me.MenuRegions.Size = New System.Drawing.Size(281, 24)
        Me.MenuRegions.TabIndex = 5
        Me.MenuRegions.Text = "MenuRegions"
        '
        'ФайлToolStripMenuItem
        '
        Me.ФайлToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.smiSaveList, Me.smiCopyNumer, Me.ToolStripSeparator1, Me.smiExit})
        Me.ФайлToolStripMenuItem.Name = "ФайлToolStripMenuItem"
        Me.ФайлToolStripMenuItem.Size = New System.Drawing.Size(48, 20)
        Me.ФайлToolStripMenuItem.Text = "&Файл"
        '
        'smiSaveList
        '
        Me.smiSaveList.Name = "smiSaveList"
        Me.smiSaveList.ShortcutKeys = CType(((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.Shift) _
            Or System.Windows.Forms.Keys.S), System.Windows.Forms.Keys)
        Me.smiSaveList.Size = New System.Drawing.Size(246, 22)
        Me.smiSaveList.Text = "&Сохранить список"
        '
        'smiCopyNumer
        '
        Me.smiCopyNumer.Name = "smiCopyNumer"
        Me.smiCopyNumer.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.C), System.Windows.Forms.Keys)
        Me.smiCopyNumer.Size = New System.Drawing.Size(246, 22)
        Me.smiCopyNumer.Text = "&Копировать номер"
        '
        'ToolStripSeparator1
        '
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(243, 6)
        '
        'smiExit
        '
        Me.smiExit.Name = "smiExit"
        Me.smiExit.ShortcutKeys = CType((System.Windows.Forms.Keys.Shift Or System.Windows.Forms.Keys.F4), System.Windows.Forms.Keys)
        Me.smiExit.Size = New System.Drawing.Size(246, 22)
        Me.smiExit.Text = "&Выйти"
        '
        'frmRegion
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(281, 120)
        Me.Controls.Add(Me.MenuRegions)
        Me.Controls.Add(Me.gbRegion)
        Me.Controls.Add(Me.gbIDRegion)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "frmRegion"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "RegTool"
        Me.gbIDRegion.ResumeLayout(False)
        Me.gbIDRegion.PerformLayout()
        Me.ContextMenuNumer.ResumeLayout(False)
        Me.gbRegion.ResumeLayout(False)
        Me.ContextMenuRegions.ResumeLayout(False)
        Me.MenuRegions.ResumeLayout(False)
        Me.MenuRegions.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents gbIDRegion As System.Windows.Forms.GroupBox
    Friend WithEvents ContextMenuNumer As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents tsCopyNumer As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents lbNumer As System.Windows.Forms.Label
    Friend WithEvents lbIDreg As System.Windows.Forms.Label
    Friend WithEvents gbRegion As System.Windows.Forms.GroupBox
    Friend WithEvents ListComboBox As System.Windows.Forms.ComboBox
    Friend WithEvents smiAbout As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ПомощьToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents MenuRegions As System.Windows.Forms.MenuStrip
    Friend WithEvents ФайлToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents smiExit As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents smiSaveList As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SaveFileRegions As System.Windows.Forms.SaveFileDialog
    Friend WithEvents ContextMenuRegions As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents tsSaveNumer As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents smiCopyNumer As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents СправкаToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem

End Class
