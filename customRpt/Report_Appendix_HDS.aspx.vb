Imports ChartDirector

Partial Class CustomRpt_Report_HDS
    Inherits System.Web.UI.Page


    Protected Sub BindIt(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.Header Then Exit Sub
        If e.Row.RowType = DataControlRowType.Footer Then Exit Sub

        Dim i1 As Integer, T1 As HtmlTable, hr1 As Label
        Dim gv1 As GridView
        T1 = e.Row.FindControl("tabscore")
        Trace.Warn(T1.Rows.Count)
        e.Row.Cells(0).Style.Add("padding-right", "4px")
        For i1 = 0 To 3
            If (i1 < e.Row.DataItem("Score")) Then
            Else
                Trace.Warn(i1)
                'hr1 = T1.Rows(0).Cells(i1).Controls(1)
                'hr1.Visible = False
            End If
        Next

        If e.Row.RowIndex = 0 Then
            gv1 = e.Row.NamingContainer
            gv1.HeaderRow.Cells(0).Text = e.Row.DataItem("ScaleName")
            gv1.HeaderRow.Cells(0).HorizontalAlign = HorizontalAlign.Left
            gv1.HeaderRow.Cells(1).Text = "<br>HIGH RISK"

        End If
    End Sub
    

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim aScales(14) As Integer
        aScales(0) = 1
        aScales(1) = 6
        aScales(2) = 10
        aScales(3) = 2
        aScales(4) = 7
        aScales(5) = 11
        aScales(6) = 3
        aScales(7) = 8
        aScales(8) = 0
        aScales(9) = 4
        aScales(10) = 9
        aScales(11) = 0
        aScales(12) = 5
        aScales(13) = 0
        aScales(14) = 0
        Dim i1 As Integer
        For i1 = 0 To 10
            'aScales(i1) = i1 + 1
        Next

        Me.tabHDSOuter.DataSource = aScales
        Me.tabHDSOuter.DataBind()
    End Sub
End Class

