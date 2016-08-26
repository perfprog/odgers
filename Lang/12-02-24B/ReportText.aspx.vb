
Partial Class Lang_ReportText
    Inherits System.Web.UI.Page

    Protected Sub tabA_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles tabA.RowCommand
        If e.CommandName = "Save" Then
            Data_Save()
        End If
    End Sub

    Sub Data_Save()
        Dim gr As GridViewRow, T1 As TextBox, sSql As String, L1 As Label

        For Each gr In Me.tabA.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                L1 = gr.FindControl("AutoID")
                sSql = "Update ReportText Set "
                T1 = gr.FindControl("KeyValue")
                sSql = sSql & " KeyValue=N'" & Replace(T1.Text, "'", "''") & "'"
                sSql = sSql & " where"
                sSql = sSql & " AutoID=" & L1.Text
                Trace.Warn(sSql)
                CF.Runquery(sSql)
            End If
        Next
        Me.Message.Text = "Your changes have been saved."
        Me.tabA.DataBind()
    End Sub

End Class
