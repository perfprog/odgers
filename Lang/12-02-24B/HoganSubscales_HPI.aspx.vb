
Partial Class Lang_Hoganscales
    Inherits System.Web.UI.Page

    Protected Sub tabA_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles tabA.RowCommand
        If e.CommandName = "Save" Then
            Data_Save()
        End If
    End Sub

    Sub Data_Save()
        Dim gr As GridViewRow, T1 As TextBox, sSql As String, L1 As Label

        For Each gr In Me.tabA.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                L1 = gr.FindControl("AutoID")
                sSql = "Update HoganSubscales_HPI Set "
                T1 = gr.FindControl("SubscaleName")
                sSql = sSql & " SubscaleName=N'" & Replace(T1.Text, "'", "''") & "'"
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
