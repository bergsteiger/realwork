Public Class frmFormula

    Private Sub frmFormula_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        With ListBoxFormula
            .Items.Add("Выражения")
            .Items.Add("Единцы ширины")
            .Items.Add("Простые выражения")
            .Items.Add("Символ !")
            .Items.Add("Символ -")
            .Items.Add("Символ #")
            .Items.Add("Символ %O/")
            .Items.Add("Символ & ")
            .Items.Add("Символ * ")
            .Items.Add("Символ **")
            .Items.Add("Символ *.")
            .Items.Add("Символ * +")
            .Items.Add("Символ , ")
            .Items.Add("Символ /")
            .Items.Add("Символ //")
            .Items.Add("Символ / +")
            .Items.Add("Символ ^ ")
            .Items.Add("Символ (вектор) ")
            .Items.Add("Символ (нижний индекс)")
            .Items.Add("Символ ` (обратный апостроф) ")
            .Items.Add("Символ ~")
            .Items.Add("Символ ~~")
            .Items.Add("Символ -+")
            .Items.Add("Символ  + ")
            .Items.Add("Символ + -")
            .Items.Add("Символ < ")
            .Items.Add("Символ <~")
            .Items.Add("Символ  << ")
            .Items.Add("Символ  <= ")
            .Items.Add("Символ <>")
            .Items.Add("Символ  = ")
            .Items.Add("Символ =~")
            .Items.Add("Символ ==")
            .Items.Add("Символ  > ")
            .Items.Add("Символ ->")
            .Items.Add("Символ >~")
            .Items.Add("Символ >= ")
            .Items.Add("Символ  >> ")
            .Items.Add("Скобки !() ")
            .Items.Add("Скобки ()")
            .Items.Add("Скобки []")
            .Items.Add("Скобки {}")
            .Items.Add("Скобки ||")
            .Items.Add("Токен ... ")
            .Items.Add("Токен Alpha")
            .Items.Add("Токен Angle")
            .Items.Add("Токен Asterix")
            .Items.Add("Токен Beta")
            .Items.Add("Токен Chi")
            .Items.Add("Токен Comma")
            .Items.Add("Токен Const")
            .Items.Add("Токен Delta")
            .Items.Add("Токен Empty")
            .Items.Add("Токен Epsilon")
            .Items.Add("Токен Eta")
            .Items.Add("Токен Gamma")
            .Items.Add("Токен Inf")
            .Items.Add("Токен Iota")
            .Items.Add("Токен Kappa")
            .Items.Add("Токен Lambda")
            .Items.Add("Токен Minus")
            .Items.Add("Токен Mu")
            .Items.Add("Токен Nabla")
            .Items.Add("Токен Nil")
            .Items.Add("Токен Nu")
            .Items.Add("Токен Omega")
            .Items.Add("Токен Omicron")
            .Items.Add("Токен Parallel")
            .Items.Add("Токен Perpendicular")
            .Items.Add("Токен Phi")
            .Items.Add("Токен Pi")
            .Items.Add("Токен PLambda")
            .Items.Add("Токен Plank")
            .Items.Add("Токен Psi")
            .Items.Add("Токен Rho")
            .Items.Add("Токен Sigma")
            .Items.Add("Токен Tau")
            .Items.Add("Токен Theta")
            .Items.Add("Токен Upsilon")
            .Items.Add("Токен Xi")
            .Items.Add("Токен Zeta")
            .Items.Add("Функции")
            .Items.Add("Функция Abs")
            .Items.Add("Функция Angle")
            .Items.Add("Функция At")
            .Items.Add("Функция Brackets")
            .Items.Add("Функция Cap")
            .Items.Add("Функция Case")
            .Items.Add("Функция Circ")
            .Items.Add("Функция Circle")
            .Items.Add("Функция Comma")
            .Items.Add("Функция Diff")
            .Items.Add("Функция DiffN")
            .Items.Add("Функция DiffR")
            .Items.Add("Функция DiffRF")
            .Items.Add("Функция Fact")
            .Items.Add("Функция Func")
            .Items.Add("Функция Ind")
            .Items.Add("Функция Int")
            .Items.Add("Функция IntM")
            .Items.Add("Функция Lim")
            .Items.Add("Функция Line")
            .Items.Add("Функция Log")
            .Items.Add("Функция Matrix")
            .Items.Add("Функция Num")
            .Items.Add("Функция PDiff")
            .Items.Add("Функция PDiffN")
            .Items.Add("Функция PDiffR")
            .Items.Add("Функция PDiffRF")
            .Items.Add("Функция Points")
            .Items.Add("Функция Pow")
            .Items.Add("Функция Prod")
            .Items.Add("Функция Root")
            .Items.Add("Функция Space")
            .Items.Add("Функция Sqr")
            .Items.Add("Функция Sqrt")
            .Items.Add("Функция StandC")
            .Items.Add("Функция StandL")
            .Items.Add("Функция StandR")
            .Items.Add("Функция String")
            .Items.Add("Функция Strokes")
            .Items.Add("Функция Summa")
            .Items.Add("Функция Symbol")
            .Items.Add("Функция System")
            .Items.Add("Функция Tilde")
            .Items.Add("Функция Vect")
        End With
    End Sub
    Private Sub ListBoxFormula_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBoxFormula.SelectedValueChanged
        Dim выражение(0 To 100)

        выражение(0) = "Выражения"
        выражение(1) = "Единцы ширины"
        выражение(2) = "Простые выражения"
        выражение(3) = "Символ !"
        выражение(4) = "Символ -"
        выражение(5) = "Символ #"
        выражение(6) = "Символ %O/"
        выражение(7) = "Символ & "
        выражение(8) = "Символ *"
        выражение(9) = "Символ **"
        выражение(10) = "Символ *."
        выражение(11) = "Символ * +"
        выражение(12) = "Символ ,"
        выражение(13) = "Символ /"
        выражение(14) = "Символ //"
        выражение(15) = "Символ / +"
        выражение(16) = "Символ ^"
        выражение(17) = "Символ (вектор) "
        выражение(18) = "Символ (нижний индекс)"
        выражение(19) = "Символ ` (обратный апостроф)"
        выражение(20) = "Символ ~"
        выражение(21) = "Символ ~~"
        выражение(22) = "Символ -+"
        выражение(23) = "Символ  +"
        выражение(24) = "Символ + -"
        выражение(25) = "Символ <"
        выражение(26) = "Символ *~"
        выражение(27) = ""
        выражение(28) = ""
        выражение(29) = ""
        выражение(30) = ""
        выражение(31) = ""
        выражение(32) = ""
        выражение(33) = ""
        выражение(34) = ""


        Select Case ListBoxFormula.Text
            Case выражение(0)
                TextBoxFormula.Text = My.Resources.Выражения
                'RichTextBox1.SelectedRtf = My.Resources.Пример
                PictureBoxFormula.Image = My.Resources.Pic1_1
            Case выражение(1)
                TextBoxFormula.Text = My.Resources.Единицы_ширины
                PictureBoxFormula.Image = My.Resources.Pic1_2
            Case выражение(2)
                TextBoxFormula.Text = My.Resources.Простые_выражения
                PictureBoxFormula.Image = My.Resources.Pic1_3
            Case выражение(3)
                TextBoxFormula.Text = My.Resources.Символ_Воск_Знак
                PictureBoxFormula.Image = My.Resources.Pic1_4
            Case выражение(4)
                TextBoxFormula.Text = My.Resources.Символ_минус
                PictureBoxFormula.Image = My.Resources.Pic1_5
            Case выражение(5)
                TextBoxFormula.Text = My.Resources.Символ_Диез
                PictureBoxFormula.Image = My.Resources.Pic1_6
            Case выражение(6)
                TextBoxFormula.Text = My.Resources.Знак_диаметра
                PictureBoxFormula.Image = My.Resources.Pic1_7
            Case выражение(7)
                TextBoxFormula.Text = My.Resources.Сивол_Конкатен
                PictureBoxFormula.Image = My.Resources.Pic1_8



            Case выражение(8)
                TextBoxFormula.Text = My.Resources.Символ_звезда
                'PictureBoxFormula.Image = My.Resources.Pic1_8
            Case выражение(9)
                TextBoxFormula.Text = My.Resources.Символ_2звезды
            Case выражение(10)
                TextBoxFormula.Text = My.Resources.Умножение
            Case выражение(11)
                TextBoxFormula.Text = My.Resources.Умножение_плюс
            Case выражение(12)
                TextBoxFormula.Text = My.Resources.Запятая
            Case выражение(13)
                TextBoxFormula.Text = My.Resources.Обратный_слеш
            Case выражение(14)
                TextBoxFormula.Text = My.Resources.Обратный_2слеш
            Case выражение(15)
                TextBoxFormula.Text = My.Resources.Слеш_плюс
            Case выражение(16)
                TextBoxFormula.Text = My.Resources.Крыша
            Case выражение(17)
                TextBoxFormula.Text = My.Resources.Вектор
            Case выражение(18)
                TextBoxFormula.Text = My.Resources.Нижний_индекс
            Case выражение(19)
                TextBoxFormula.Text = My.Resources.Обратный_апостроф
            Case выражение(20)
                TextBoxFormula.Text = My.Resources.Волна
            Case выражение(21)
                TextBoxFormula.Text = My.Resources.Волна2
            Case выражение(22)
                TextBoxFormula.Text = My.Resources.Плюс_минус
            Case выражение(23)
                TextBoxFormula.Text = My.Resources.Плюс
            Case выражение(24)
                TextBoxFormula.Text = My.Resources.Плюс_минус_обратно
            Case выражение(25)
                TextBoxFormula.Text = My.Resources.Меньше
            Case выражение(26)
                TextBoxFormula.Text = My.Resources.Больше





        End Select
    End Sub

    Private Sub ОПрограммеToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ОПрограммеToolStripMenuItem.Click
        frmAboutBox.Show()
    End Sub

    Private Sub ВыйтиToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ВыйтиToolStripMenuItem.Click
        Application.Exit()
    End Sub
End Class
