<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmFormula
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmFormula))
        Me.StatusStripFormula = New System.Windows.Forms.StatusStrip()
        Me.MenuStripFormula = New System.Windows.Forms.MenuStrip()
        Me.ФайлToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.СохнаитьВФайлToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ПечататьToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.ВыйтиToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.СправкаToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ОПрограммеToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer()
        Me.ListBoxFormula = New System.Windows.Forms.ListBox()
        Me.SplitContainer2 = New System.Windows.Forms.SplitContainer()
        Me.TextBoxFormula = New System.Windows.Forms.TextBox()
        Me.PictureBoxFormula = New System.Windows.Forms.PictureBox()
        Me.ContextMenuPic = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.ИзменитьToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.MenuStripFormula.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        Me.SplitContainer2.Panel1.SuspendLayout()
        Me.SplitContainer2.Panel2.SuspendLayout()
        Me.SplitContainer2.SuspendLayout()
        CType(Me.PictureBoxFormula, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ContextMenuPic.SuspendLayout()
        Me.SuspendLayout()
        '
        'StatusStripFormula
        '
        Me.StatusStripFormula.Location = New System.Drawing.Point(0, 492)
        Me.StatusStripFormula.Name = "StatusStripFormula"
        Me.StatusStripFormula.RenderMode = System.Windows.Forms.ToolStripRenderMode.ManagerRenderMode
        Me.StatusStripFormula.Size = New System.Drawing.Size(694, 22)
        Me.StatusStripFormula.TabIndex = 0
        Me.StatusStripFormula.Text = "StatusStripFormula"
        '
        'MenuStripFormula
        '
        Me.MenuStripFormula.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ФайлToolStripMenuItem, Me.СправкаToolStripMenuItem})
        Me.MenuStripFormula.Location = New System.Drawing.Point(0, 0)
        Me.MenuStripFormula.Name = "MenuStripFormula"
        Me.MenuStripFormula.Size = New System.Drawing.Size(694, 24)
        Me.MenuStripFormula.TabIndex = 1
        Me.MenuStripFormula.Text = "MenuStrip1"
        '
        'ФайлToolStripMenuItem
        '
        Me.ФайлToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.СохнаитьВФайлToolStripMenuItem, Me.ПечататьToolStripMenuItem, Me.ToolStripSeparator1, Me.ВыйтиToolStripMenuItem})
        Me.ФайлToolStripMenuItem.Name = "ФайлToolStripMenuItem"
        Me.ФайлToolStripMenuItem.Size = New System.Drawing.Size(48, 20)
        Me.ФайлToolStripMenuItem.Text = "&Файл"
        '
        'СохнаитьВФайлToolStripMenuItem
        '
        Me.СохнаитьВФайлToolStripMenuItem.Name = "СохнаитьВФайлToolStripMenuItem"
        Me.СохнаитьВФайлToolStripMenuItem.ShortcutKeys = CType(((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.Shift) _
            Or System.Windows.Forms.Keys.S), System.Windows.Forms.Keys)
        Me.СохнаитьВФайлToolStripMenuItem.Size = New System.Drawing.Size(245, 22)
        Me.СохнаитьВФайлToolStripMenuItem.Text = "&Сохранить в файл"
        '
        'ПечататьToolStripMenuItem
        '
        Me.ПечататьToolStripMenuItem.Name = "ПечататьToolStripMenuItem"
        Me.ПечататьToolStripMenuItem.ShortcutKeys = CType(((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.Shift) _
            Or System.Windows.Forms.Keys.P), System.Windows.Forms.Keys)
        Me.ПечататьToolStripMenuItem.Size = New System.Drawing.Size(245, 22)
        Me.ПечататьToolStripMenuItem.Text = "&Печатать"
        '
        'ToolStripSeparator1
        '
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(242, 6)
        '
        'ВыйтиToolStripMenuItem
        '
        Me.ВыйтиToolStripMenuItem.Name = "ВыйтиToolStripMenuItem"
        Me.ВыйтиToolStripMenuItem.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.F4), System.Windows.Forms.Keys)
        Me.ВыйтиToolStripMenuItem.Size = New System.Drawing.Size(245, 22)
        Me.ВыйтиToolStripMenuItem.Text = "&Выйти..."
        '
        'СправкаToolStripMenuItem
        '
        Me.СправкаToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ОПрограммеToolStripMenuItem})
        Me.СправкаToolStripMenuItem.Name = "СправкаToolStripMenuItem"
        Me.СправкаToolStripMenuItem.Size = New System.Drawing.Size(65, 20)
        Me.СправкаToolStripMenuItem.Text = "&Справка"
        '
        'ОПрограммеToolStripMenuItem
        '
        Me.ОПрограммеToolStripMenuItem.Name = "ОПрограммеToolStripMenuItem"
        Me.ОПрограммеToolStripMenuItem.Size = New System.Drawing.Size(158, 22)
        Me.ОПрограммеToolStripMenuItem.Text = "&О программе..."
        '
        'Panel1
        '
        Me.Panel1.Controls.Add(Me.SplitContainer1)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Panel1.Location = New System.Drawing.Point(0, 24)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(694, 468)
        Me.Panel1.TabIndex = 2
        '
        'SplitContainer1
        '
        Me.SplitContainer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer1.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer1.Name = "SplitContainer1"
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.Controls.Add(Me.ListBoxFormula)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.SplitContainer2)
        Me.SplitContainer1.Size = New System.Drawing.Size(694, 468)
        Me.SplitContainer1.SplitterDistance = 192
        Me.SplitContainer1.TabIndex = 0
        '
        'ListBoxFormula
        '
        Me.ListBoxFormula.Dock = System.Windows.Forms.DockStyle.Fill
        Me.ListBoxFormula.FormattingEnabled = True
        Me.ListBoxFormula.Location = New System.Drawing.Point(0, 0)
        Me.ListBoxFormula.Name = "ListBoxFormula"
        Me.ListBoxFormula.Size = New System.Drawing.Size(192, 468)
        Me.ListBoxFormula.TabIndex = 0
        '
        'SplitContainer2
        '
        Me.SplitContainer2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer2.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer2.Name = "SplitContainer2"
        Me.SplitContainer2.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer2.Panel1
        '
        Me.SplitContainer2.Panel1.Controls.Add(Me.TextBoxFormula)
        '
        'SplitContainer2.Panel2
        '
        Me.SplitContainer2.Panel2.Controls.Add(Me.PictureBoxFormula)
        Me.SplitContainer2.Size = New System.Drawing.Size(498, 468)
        Me.SplitContainer2.SplitterDistance = 161
        Me.SplitContainer2.TabIndex = 0
        '
        'TextBoxFormula
        '
        Me.TextBoxFormula.BackColor = System.Drawing.SystemColors.ControlLightLight
        Me.TextBoxFormula.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TextBoxFormula.Location = New System.Drawing.Point(0, 0)
        Me.TextBoxFormula.Multiline = True
        Me.TextBoxFormula.Name = "TextBoxFormula"
        Me.TextBoxFormula.ReadOnly = True
        Me.TextBoxFormula.Size = New System.Drawing.Size(498, 161)
        Me.TextBoxFormula.TabIndex = 0
        '
        'PictureBoxFormula
        '
        Me.PictureBoxFormula.BackColor = System.Drawing.SystemColors.ControlLightLight
        Me.PictureBoxFormula.ContextMenuStrip = Me.ContextMenuPic
        Me.PictureBoxFormula.Dock = System.Windows.Forms.DockStyle.Fill
        Me.PictureBoxFormula.Location = New System.Drawing.Point(0, 0)
        Me.PictureBoxFormula.Name = "PictureBoxFormula"
        Me.PictureBoxFormula.Size = New System.Drawing.Size(498, 303)
        Me.PictureBoxFormula.TabIndex = 0
        Me.PictureBoxFormula.TabStop = False
        '
        'ContextMenuPic
        '
        Me.ContextMenuPic.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ИзменитьToolStripMenuItem})
        Me.ContextMenuPic.Name = "ContextMenuPic"
        Me.ContextMenuPic.Size = New System.Drawing.Size(129, 26)
        '
        'ИзменитьToolStripMenuItem
        '
        Me.ИзменитьToolStripMenuItem.Name = "ИзменитьToolStripMenuItem"
        Me.ИзменитьToolStripMenuItem.Size = New System.Drawing.Size(128, 22)
        Me.ИзменитьToolStripMenuItem.Text = "&Изменить"
        '
        'frmFormula
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(694, 514)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.StatusStripFormula)
        Me.Controls.Add(Me.MenuStripFormula)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.MenuStripFormula
        Me.Name = "frmFormula"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Справочник по синтаксису редактора формул ""Архивариус"" и ""Эверест"""
        Me.MenuStripFormula.ResumeLayout(False)
        Me.MenuStripFormula.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.ResumeLayout(False)
        Me.SplitContainer2.Panel1.ResumeLayout(False)
        Me.SplitContainer2.Panel1.PerformLayout()
        Me.SplitContainer2.Panel2.ResumeLayout(False)
        Me.SplitContainer2.ResumeLayout(False)
        CType(Me.PictureBoxFormula, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ContextMenuPic.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents StatusStripFormula As System.Windows.Forms.StatusStrip
    Friend WithEvents MenuStripFormula As System.Windows.Forms.MenuStrip
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents SplitContainer1 As System.Windows.Forms.SplitContainer
    Friend WithEvents ListBoxFormula As System.Windows.Forms.ListBox
    Friend WithEvents SplitContainer2 As System.Windows.Forms.SplitContainer
    Friend WithEvents TextBoxFormula As System.Windows.Forms.TextBox
    Friend WithEvents PictureBoxFormula As System.Windows.Forms.PictureBox
    Friend WithEvents ContextMenuPic As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents ИзменитьToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ФайлToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents СохнаитьВФайлToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents ВыйтиToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents СправкаToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ОПрограммеToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ПечататьToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem

End Class
